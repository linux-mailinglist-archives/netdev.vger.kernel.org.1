Return-Path: <netdev+bounces-27438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057E877C022
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 20:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E4F1C20384
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 18:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA332CA4B;
	Mon, 14 Aug 2023 18:57:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF62917
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 18:57:20 +0000 (UTC)
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0471F1;
	Mon, 14 Aug 2023 11:57:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 63DDE2DC;
	Mon, 14 Aug 2023 18:57:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 63DDE2DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1692039438; bh=GnNgEeSq6QmLSqjSs9yaMmzQhonNTncyRCzqeQzsfCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BTt/XYSq0A+y0XIB/3axY5DwVGKX+OgouFFRwn9nrDda6q/HdDbfUlDq+iDIxdgRs
	 MPQL6DGix/cpYgh7onveVNtPlGFK1/aWJRKfU1Gyuyj1kWC4oNjG9wtkiLgWAo2QcU
	 clWZRlw9t3lmsVX9HMGJAZtwtQd/Hz2sgr2XeGenc3gak48ROJBI72BHM9Ne0Q7wnf
	 H0OKE/EcyFhUyHxNPy04hKv4XbOywCmYmOP3vfs7uONnV3gVVRA1Aq1DDAG1Ktr6WV
	 h6YmRQ8mdYFyCdbgOJahTNM9tiUxde2WBvuWeQB3PVj9XMkWm/62CAJIA6U9WqnwIc
	 fNY4WfjfEkgiw==
From: Jonathan Corbet <corbet@lwn.net>
To: Pavan Kumar Linga <pavan.kumar.linga@intel.com>, netdev@vger.kernel.org,
 kuba@kernel.org
Cc: linux-doc@vger.kernel.org, emil.s.tantilov@intel.com,
 joshua.a.hay@intel.com, sridhar.samudrala@intel.com, alan.brady@intel.com,
 madhu.chittim@intel.com, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, willemb@google.com, decot@google.com,
 rdunlap@infradead.org, Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: Re: [PATCH net-next v2 1/2] scripts: kernel-doc: parse
 DEFINE_DMA_UNMAP_[ADDR|LEN]
In-Reply-To: <20230814170720.46229-2-pavan.kumar.linga@intel.com>
References: <20230814170720.46229-1-pavan.kumar.linga@intel.com>
 <20230814170720.46229-2-pavan.kumar.linga@intel.com>
Date: Mon, 14 Aug 2023 12:57:17 -0600
Message-ID: <87y1idv4du.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Pavan Kumar Linga <pavan.kumar.linga@intel.com> writes:

> At present, if the macros DEFINE_DMA_UNMAP_ADDR() and
> DEFINE_DMA_UNMAP_LEN() are used in the structures as shown
> below, instead of parsing the parameter in the parentheses,
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
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  scripts/kernel-doc | 4 ++++
>  1 file changed, 4 insertions(+)

Is there a reason why you didn't CC me on these?

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

I'm not happy with this ... we are continuing to reimplement parts of
the C preprocessor here, badly, creating an ugly mess in the process.

That said, you are just the latest arrival at the party, can't blame you
for this.  Until we come up with a better way here, I guess this will
do.

Thanks,

jon

