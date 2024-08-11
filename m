Return-Path: <netdev+bounces-117481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D5C94E17D
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 15:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A1E281590
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 13:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602101494AF;
	Sun, 11 Aug 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFnKpfhy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE7C42A84;
	Sun, 11 Aug 2024 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723383898; cv=none; b=jZesOBydeV70OfxHgqph4g03OYSe3Ddj/NMN8HwfSUZptVp6QsRqSKn411l88RMqLrX8ZCMWiyhNe+xKUI7BivwXH1+WyXbwZTRaaWvO4HVgmqjnxiQ51AxKw9MMt9kBtsoAhRpGkaZE8KrDRpNkzW17JNb9j8qh1Howw6CeqpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723383898; c=relaxed/simple;
	bh=xyzmM7UbIfJS/kPf0ODNmP4zfQ2ba/o/1fRh28BkZRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pU5WFkjRRH7hahLpSJydxcl/Yp0kLW+9V/buU3bSAUuQ2AADOPzgVDVWOO/xCAZGvhG8+pwE2Q2RcxF+iaknsm2eBhDLzzU8a7NxFZIHAXGGwnX8mrxrZPd3ovMVGggB1H2Ot8EAlfkeqymCRG5H85oMowsbJ5SrQ/9pSWXc1fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFnKpfhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B182DC32786;
	Sun, 11 Aug 2024 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723383897;
	bh=xyzmM7UbIfJS/kPf0ODNmP4zfQ2ba/o/1fRh28BkZRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFnKpfhybC9UtQyJ129hqQHVOTytIrQ4UBhis2eOE9VbrYCZqdHVdB5btmn8FN8T6
	 4/VlrbZmo4pcXGen2mzFWTXms7CnbWBc/4cJTmFWWhx3K2ukhhtNGFFFcQVSic0+tq
	 Yvs7PyTj+Yzdeoyqc/Y9kTzIcLvtq5IsjenW0ufRm+7oxb9Om9Q40HaibFUAOgk2uc
	 Td/hsXXH0r4p4ePqUT7tKamegWTYF8Rc+FJcSlhQ9V2hs6qhQIqmr/mZgtYstGkn+8
	 n2NF+xY6TsahqtzGn6D9pSLzEn5pLZ5X03w3gbSmoWsqOvf97RMJRdGutPvQF2R5k+
	 MAKP0AVgWQQiw==
Date: Sun, 11 Aug 2024 14:44:53 +0100
From: Simon Horman <horms@kernel.org>
To: Jing-Ping Jan <zoo868e@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] Documentation: networking: correct spelling
Message-ID: <20240811134453.GJ1951@kernel.org>
References: <20240809181750.62522-1-zoo868e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809181750.62522-1-zoo868e@gmail.com>

On Sat, Aug 10, 2024 at 02:17:50AM +0800, Jing-Ping Jan wrote:
> Correct spelling problems for Documentation/networking/ as reported
> by ispell.
> 
> Signed-off-by: Jing-Ping Jan <zoo868e@gmail.com>
> ---
>  Documentation/networking/ethtool-netlink.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index d5f246aceb9f..9ecfc4f0f980 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -934,7 +934,7 @@ Request contents:
>    ====================================  ======  ===========================
>  
>  Kernel checks that requested ring sizes do not exceed limits reported by
> -driver. Driver may impose additional constraints and may not suspport all
> +driver. Driver may impose additional constraints and may not support all
>  attributes.
>  
>  
> @@ -943,7 +943,7 @@ Completion queue events(CQE) are the events posted by NIC to indicate the
>  completion status of a packet when the packet is sent(like send success or
>  error) or received(like pointers to packet fragments). The CQE size parameter
>  enables to modify the CQE size other than default size if NIC supports it.
> -A bigger CQE can have more receive buffer pointers inturn NIC can transfer
> +A bigger CQE can have more receive buffer pointers in turn NIC can transfer
>  a bigger frame from wire. Based on the NIC hardware, the overall completion
>  queue size can be adjusted in the driver if CQE size is modified.

FWIIW, it is not clear to me that the sentence that is being updated is
grammatically correct either before or after the change: some words seem to
be missing.

Perhaps:

A bigger CQE can have more receive buffer pointers, and in turn the NIC can
transfer a bigger frame from the wire.

Also, 'NIC/ -> 'the NIC' in the previous sentence.

And there should be a space before each '('/

I guess this document could do with an edit.

But, regardless of my comments above, your changes look like
good steps in the right direction to me. Thanks.

Reviewed-by: Simon Horman <horms@kernel.org>

...

