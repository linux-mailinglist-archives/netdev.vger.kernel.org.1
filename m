Return-Path: <netdev+bounces-25659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAAE7750B2
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 04:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CBE281996
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 02:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F90632;
	Wed,  9 Aug 2023 02:08:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4592662C
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 02:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BE4C433C8;
	Wed,  9 Aug 2023 02:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691546935;
	bh=PT0mLcVjBLrfgD4nTIjBAloiFkwt2JhnyC433VN+0e0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pm/0Pyxgq4ql4H3TDzjZgEtGPCtzew/xPp4jABQVvsVElGP9Y+hHqmigHpwjpJ6i9
	 Qd6eLSBDUfj+MT3AkG0oSZTF7OhNl4NA3h/J3nKoCP/59dDxBPW5SgrUS5opBlU/iG
	 GEv6btU5zvrDd/iYrwIia2oYwO8sw9d44LTI/HanCN5+CKaBZcF6vIou3f53AjzLJ4
	 Tq4Jd7NZqsZtpPCzMZ8/7GhB58/CmVlp1gvoGSfGCoObvAOOPke1Wjr5YSZCdmrQXw
	 3lHWxvRVUngba/+wTSPBeq8O8OFSX5rJK1Ie+dW/lVdFwpRs9Gb93yoBnAaOEboe/9
	 VOca2UqVviUjA==
Date: Tue, 8 Aug 2023 19:08:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <emil.s.tantilov@intel.com>, <jesse.brandeburg@intel.com>,
 <sridhar.samudrala@intel.com>, <shiraz.saleem@intel.com>,
 <sindhu.devale@intel.com>, <willemb@google.com>, <decot@google.com>,
 <andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
 <simon.horman@corigine.com>, <shannon.nelson@amd.com>,
 <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v4 00/15][pull request] Introduce Intel IDPF
 driver
Message-ID: <20230808190853.3edc88f4@kernel.org>
In-Reply-To: <e1beeb14-fbb5-216c-f661-2bb9a84ba724@intel.com>
References: <20230808003416.3805142-1-anthony.l.nguyen@intel.com>
	<20230808133234.78504bca@kernel.org>
	<e1beeb14-fbb5-216c-f661-2bb9a84ba724@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Aug 2023 17:35:27 -0700 Linga, Pavan Kumar wrote:
> On 8/8/2023 1:32 PM, Jakub Kicinski wrote:
> > On Mon,  7 Aug 2023 17:34:01 -0700 Tony Nguyen wrote:  
> >> This patch series introduces the Intel Infrastructure Data Path Function
> >> (IDPF) driver. It is used for both physical and virtual functions. Except
> >> for some of the device operations the rest of the functionality is the
> >> same for both PF and VF. IDPF uses virtchnl version2 opcodes and
> >> structures defined in the virtchnl2 header file which helps the driver
> >> to learn the capabilities and register offsets from the device
> >> Control Plane (CP) instead of assuming the default values.  
> > 
> > Patches 4 and 10 add kdoc warnings, please fix those.
> > And double check all the checkpatch warning about lines > 80 chars.  
> 
> Thanks for the feedback.
> 
> Will review the warnings regarding 80char limit. Are you wanting them 
> all removed or is it okay to leave the ones that help readability?

For some definition of helps readability, yes.
I glanced at the warnings on one of the first patches and most of them
were just comments.

>  > drivers/net/ethernet/intel/idpf/idpf.h:123: warning: Enum value   
> 'csum_caps' not described in enum 'idpf_cap_field'
>  > drivers/net/ethernet/intel/idpf/idpf.h:123: warning: Enum value   
> 'seg_caps' not described in enum 'idpf_cap_field'
>  > drivers/net/ethernet/intel/idpf/idpf.h:123: warning: Enum value   
> 'rss_caps' not described in enum 'idpf_cap_field'
>  > drivers/net/ethernet/intel/idpf/idpf.h:123: warning: Enum value   
> 'hsplit_caps' not described in enum 'idpf_cap_field'
>  > drivers/net/ethernet/intel/idpf/idpf.h:123: warning: Enum value   
> 'rsc_caps' not described in enum 'idpf_cap_field'
>  > drivers/net/ethernet/intel/idpf/idpf.h:123: warning: Enum value   
> 'other_caps' not described in enum 'idpf_cap_field'
>  > drivers/net/ethernet/intel/idpf/idpf_txrx.h:153: warning: Function   
> parameter or member 'DEFINE_DMA_UNMAP_ADDR(dma' not described in 
> 'idpf_tx_buf'
>  > drivers/net/ethernet/intel/idpf/idpf_txrx.h:153: warning: Function   
> parameter or member 'DEFINE_DMA_UNMAP_LEN(len' not described in 
> 'idpf_tx_buf'
> 
> /**
>   * enum idpf_cap_field - Offsets into capabilities struct for specific caps
>   * @IDPF_BASE_CAPS: generic base capabilities
>   * @IDPF_CSUM_CAPS: checksum offload capabilities
> ...
>   */
> enum idpf_cap_field {
>           IDPF_BASE_CAPS          = -1,
>           IDPF_CSUM_CAPS          = offsetof(struct virtchnl2_get_capabilities,
>                                              csum_caps),
>           IDPF_SEG_CAPS           = offsetof(struct
> ...
> }
> 
> 
> /**
>   * struct idpf_tx_buf
>   * @next_to_watch: Next descriptor to clean
>   * @skb: Pointer to the skb
>   * @dma: DMA address
>   * @len: DMA length
> ...
>   */
> struct idpf_tx_buf {
>          void *next_to_watch;
>          struct sk_buff *skb;
>          DEFINE_DMA_UNMAP_ADDR(dma);
>          DEFINE_DMA_UNMAP_LEN(len);
> ...
> }
> 
> The script is parsing the offsetof() argument as part of the enum, which 
> is not true. I believe it to be a false positive. Same for the second 
> one where it parses 'DEFINE_DMA_UNMAP_ADDR(dma'. Is it okay to use 'dma' 
> and 'len' in the kdoc header as-is or please suggest if you prefer 
> something?

The parser is in scripts/kernel-doc, it's not very complicated.
You can teach it new tricks.

