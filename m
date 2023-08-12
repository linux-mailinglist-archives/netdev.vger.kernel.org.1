Return-Path: <netdev+bounces-27005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E35779D31
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 07:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C07281E07
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 05:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72D61854;
	Sat, 12 Aug 2023 05:05:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05D1849
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 05:05:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D352722;
	Fri, 11 Aug 2023 22:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=QVO+YD/A9B88x8NiWdr2MCn5pXPPZlopwlUOKBD1+Hs=; b=x9fOkwf6k49NlChnY1xxM6PETP
	P4j8i5BsNPySDLS3g3HkFJdbJ28w4pH9V5oxszkcYAZ9eRr5JvAC9aSykeZtjJ4pJjgOnXlToRQsP
	uV5NM1XRiUZtEduKEJifSEbdJC/dCp67mh3HJi0BQ18h35g7IAm4biCCqneXsi+oDQnVeDoMcMbMI
	Lj9XTwsG3f6IbJ52G1HWORVyQ687kQzXVA1vpSVDJmDyPBKifbL28cMa5+udxNimqA1HD0+Kb4T25
	w/L0qMUWxh72qF/lwB78909lAqq8rWhAj9RcasDICSiwUwszWzAqW2VLAJB2DrduGBFuIG7nLzxlO
	L1f4kaKQ==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qUgWl-00CdzG-1Z;
	Sat, 12 Aug 2023 04:47:03 +0000
Message-ID: <9efeeb6a-a2d4-9b56-c127-119c1ac378b6@infradead.org>
Date: Fri, 11 Aug 2023 21:47:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 1/2] scripts: kernel-doc: parse
 DEFINE_DMA_UNMAP_[ADDR|LEN]
Content-Language: en-US
To: Pavan Kumar Linga <pavan.kumar.linga@intel.com>, netdev@vger.kernel.org,
 kuba@kernel.org
Cc: linux-doc@vger.kernel.org, corbet@lwn.net, emil.s.tantilov@intel.com,
 joshua.a.hay@intel.com, sridhar.samudrala@intel.com, alan.brady@intel.com,
 madhu.chittim@intel.com, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, willemb@google.com, decot@google.com
References: <20230812002549.36286-1-pavan.kumar.linga@intel.com>
 <20230812002549.36286-2-pavan.kumar.linga@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230812002549.36286-2-pavan.kumar.linga@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/11/23 17:25, Pavan Kumar Linga wrote:
> At present, if the marcos DEFINE_DMA_UNMAP_ADDR() and

                     macros

> DEFINE_DMA_UNMAP_LEN() are used in the structures as shown
> below, instead of parsing the parameter in the parenthesis,

                                                 parentheses

> kernel-doc parses 'DEFINE_DMA_UNMAP_ADDR(' and
> 'DEFINE_DMA_UNMAP_LEN(' which results in the following
> warnings:
> 
> drivers/net/ethernet/intel/idpf/idpf_txrx.h:201: warning: Function
> parameter or member 'DEFINE_DMA_UNMAP_ADDR(dma' not described in
> 'idpf_tx_buf'
> drivers/net/ethernet/intel/idpf/idpf_txrx.h:201: warning: Function
> parameter or member 'DEFINE_DMA_UNMAP_LEN(len' not described in
> 'idpf_tx_buf'
> 
> struct idpf_tx_buf {
> 	DEFINE_DMA_UNMAP_ADDR(dma);
> 	DEFINE_DMA_UNMAP_LEN(len);
> };
> 
> Fix the warnings by parsing DEFINE_DMA_UNMAP_ADDR() and
> DEFINE_DMA_UNMAP_LEN().
> 
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

Looks good. Thanks.
Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  scripts/kernel-doc | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index d0116c6939dc..cfb1cb223508 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1168,6 +1168,10 @@ sub dump_struct($$) {
>  	$members =~ s/DECLARE_KFIFO_PTR\s*\($args,\s*$args\)/$2 \*$1/gos;
>  	# replace DECLARE_FLEX_ARRAY
>  	$members =~ s/(?:__)?DECLARE_FLEX_ARRAY\s*\($args,\s*$args\)/$1 $2\[\]/gos;
> +	#replace DEFINE_DMA_UNMAP_ADDR
> +	$members =~ s/DEFINE_DMA_UNMAP_ADDR\s*\($args\)/dma_addr_t $1/gos;
> +	#replace DEFINE_DMA_UNMAP_LEN
> +	$members =~ s/DEFINE_DMA_UNMAP_LEN\s*\($args\)/__u32 $1/gos;
>  	my $declaration = $members;
>  
>  	# Split nested struct/union elements as newer ones

-- 
~Randy

