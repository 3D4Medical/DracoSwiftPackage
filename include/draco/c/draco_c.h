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


#if __cplusplus
extern "C" {
#endif
    
    // return interleaved data
    struct DracoRaw draco_decode(const char *compressedData, unsigned long size);
    
    // free data
    void free_draco(struct DracoRaw dRaw);
    
#if __cplusplus
}
#endif

#endif /* draco_c_hpp */
