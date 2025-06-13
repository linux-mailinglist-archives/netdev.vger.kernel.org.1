Return-Path: <netdev+bounces-197512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22437AD8FCC
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D67C3A436D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFF419ABAC;
	Fri, 13 Jun 2025 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp13Egy1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0119995E
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825659; cv=none; b=TEGuTT7Ea/yFadKNITrkHPrHX2dc/gOO/TGkigugqtNmH6oKPwLnT944Se6jY+peS9JY+o0MgZZfNqoFygDqwdpNatAsWK1R6bPx6cqZuJf/4Cncs9u4UzfegcVwe6uM96vLQngKDR+B1nVU5yjuJCEPKUP9T8S4OBdIjDKg05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825659; c=relaxed/simple;
	bh=v41rUl0cVAHu9TQSSGtAQC6Vwh3oXlyQlmYuvKABbiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7C5O2QXRXh6eiCFZZwscM3/S01a05PtQPU7IqudBLmbqaxRct4t/NLyKhHzIZ8YTIuEnfJx0WCGC9EdUhL/25W++lt9y0crci3Y0PoZMuk8UHWhFUJB2xmPwrp38QvdSA2ylwfDRKePoOGhp1U6cyYHUNfFvlRdLua6IQnlr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp13Egy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C939C4CEE3;
	Fri, 13 Jun 2025 14:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749825659;
	bh=v41rUl0cVAHu9TQSSGtAQC6Vwh3oXlyQlmYuvKABbiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vp13Egy1tXc7BiB3S2DOan1cUF/Ewbvv54L9zikmq0mVOSEtE4oB18TiVsaLSfy+E
	 8am35MR4p/8nWVmxtuv1HMVtq5pcdkqeMPsIyH/xzn5SFlWx0yi9LPRVZBU+8Ul8S7
	 UDgwob352lEtxXA/PZmrUvyzrDpvcTHRRMfvnVaJd+LULpm0npVzmeG/ks7DBMKYdB
	 jInhU54c6L7zF4C1YknJoylaTv+rf434WiyRByGT2G2EPj8wzq021WijmQPtJY5R5O
	 BA30HprJD08oaee6+ZApy1zWyGq9Vmv2UfbtOfYFNFn32bOLgcqgtwCmlnueGK922S
	 8buY71bjtIqZQ==
Date: Fri, 13 Jun 2025 15:40:55 +0100
From: Simon Horman <horms@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org
Subject: Re: [PATCH net-next v9 03/15] net: homa: create shared Homa header
 files
Message-ID: <20250613144055.GI414686@horms.kernel.org>
References: <20250609154051.1319-1-ouster@cs.stanford.edu>
 <20250609154051.1319-4-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609154051.1319-4-ouster@cs.stanford.edu>

On Mon, Jun 09, 2025 at 08:40:36AM -0700, John Ousterhout wrote:
> homa_impl.h defines "struct homa", which contains overall information
> about the Homa transport, plus various odds and ends that are used
> throughout the Homa implementation.
> 
> homa_stub.h is a temporary header file that provides stubs for
> facilities that have omitted for this first patch series. This file
> will go away once Home is fully upstreamed.
> 
> Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> 
> ---
> Changes for v9:
> * Move information from sync.txt into comments in homa_impl.h
> * Add limits on number of active peer structs
> * Introduce homa_net objects; there is now a single global struct homa
>   shared by all network namespaces, with one homa_net per network namespace
>   with netns-specific information.
> * Introduce homa_clock as an abstraction layer for the fine-grain clock.
> * Various name improvements (e.g. use "alloc" instead of "new" for functions
>   that allocate memory)
> * Eliminate sizeof32 definition
> 
> Changes for v8:
> * Pull out pacer-related fields into separate struct homa_pacer in homa_pacer.h
> 
> Changes for v7:
> * Make Homa a per-net subsystem
> * Track tx buffer memory usage
> * Refactor waiting mechanism for incoming packets: simplify wait
>   criteria and use standard Linux mechanisms for waiting
> * Remove "lock_slow" functions, which don't add functionality in this
>   patch series
> * Rename homa_rpc_free to homa_rpc_end
> * Add homa_make_header_avl function
> * Use u64 and __u64 properly
> ---
>  net/homa/homa_impl.h | 603 +++++++++++++++++++++++++++++++++++++++++++
>  net/homa/homa_stub.h |  91 +++++++
>  2 files changed, 694 insertions(+)
>  create mode 100644 net/homa/homa_impl.h
>  create mode 100644 net/homa/homa_stub.h
> 
> diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h

...

> +#ifdef __CHECKER__
> +#define __context__(x, y, z) __attribute__((context(x, y, z)))
> +#else
> +#define __context__(...)
> +#endif /* __CHECKER__ */

I am unclear on the intent of this. But it does seem to be an
unusual approach within the Kernel (I couldn't find any other similar
code in-tree. And, with other patches in this series, it does seem
to lead to Sparse and Smatch flagging the following (and other similar
warnings):

 .../rhashtable.h:411:9: error: macro "__context__" requires 3 arguments, but only 2 given
 .../rhashtable.h:411:27: error: Expected ( after __context__ statement
 .../rhashtable.h:411:27: error: got ;

I suspect it's best to remove the above.

...

