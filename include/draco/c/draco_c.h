//
//  draco_c.h
//  draco
//
//  Created by Volodymyr Boichentsov on 21/02/2018.
//

#ifndef draco_c_h
#define draco_c_h

struct DracoRaw {
    int stride;
    unsigned long vertexDataSize;
    float *interleavedVertexData;
    unsigned long indicesDataSize;
    int *indicesData;
};


// return interleaved data
extern "C" {
    struct DracoRaw draco_decode(const char *compressedData, unsigned long size);
}
#endif /* draco_c_hpp */
