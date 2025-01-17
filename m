Return-Path: <netdev+bounces-159305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8229A1508D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCC83A25B8
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6811FF618;
	Fri, 17 Jan 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQPu6zQE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C571A1F9F55;
	Fri, 17 Jan 2025 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737120560; cv=none; b=YnjIOcmm/apW+yXuygHX4GR2q0pmGzXZy+atQi3cBdoZP2IZ6DmtZqUtlrsWSGPwJ1wQ8K1jPw0JVUOZmb2OnPizn0y/PbOmjln2HMkj3zMyOHZHs75qUuk9gyeerZHLR6gyt18mpFRryHWi1G8jAaWvusEdrfpVkcLoNdTCxyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737120560; c=relaxed/simple;
	bh=cyeRKmSrmaR1OXFF7PZ0eOkiXIzTbKeyIu7hglTG1b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ja7yr2YR/JxXIfgCDiEbUaWVZ3LstfySu/9DR0CoWmxcqmkSoN7WgLha2QNWQNvz6tRtNTj5HIi4R0Qq6Ag+dfgl4DwPWoscQwHQcLAG3cKIhvuyN0zpYcUPfgCaEwf4gCI+5c2uguL6FNTgSVjth0xcJA8d3hLJ+Na3sh0/w5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQPu6zQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21830C4CEDD;
	Fri, 17 Jan 2025 13:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737120559;
	bh=cyeRKmSrmaR1OXFF7PZ0eOkiXIzTbKeyIu7hglTG1b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MQPu6zQEX3z9FWADMBdHQJRriWjLOS8v9HwnUoKElsXkvyiYd0hxKbls0Di1f/Dlx
	 voyv2PviuWJvjWiUfqFY1qxvTDm0Jb3c5cu6129sRRUL1Hz9eVAmCO+dXvaq2rD7bT
	 xGZ5mJkxAL0qLZBAMwHtL+CsngNTpfO5AavhNJH7MVHwKITMgwSqSitwtV8eir7zbY
	 Hx6qc0M+MX0rhR9qmJsUNTKya925keUwhiXzeQJAl8WtOceXg9Vhb4osNvrmjUzXa3
	 TWpSpdxUiXYj/rERkoakzgp1/nAaD2oXywpgdUODptPW+tjHt9ZH5kr96Hh8avmjWS
	 /TCaks8bzRdfg==
Date: Fri, 17 Jan 2025 13:29:14 +0000
From: Simon Horman <horms@kernel.org>
To: Charles Han <hanchunchao@inspur.com>
Cc: ayush.sawal@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	atul.gupta@chelsio.com, werner@chelsio.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: chtls: Add check alloc_skb() returned value
Message-ID: <20250117132914.GM6206@kernel.org>
References: <20250117031328.13908-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117031328.13908-1-hanchunchao@inspur.com>

On Fri, Jan 17, 2025 at 11:13:28AM +0800, Charles Han wrote:
> alloc_skb() can return a NULL pointer on failure.But these returned
> value in send_defer_abort_rpl() and chtls_close_conn()  not checked.
> 
> Fixes: cc35c88ae4db ("crypto : chtls - CPL handler definition")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  .../net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c  | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> index 6f6525983130..725cce34f25a 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> @@ -306,6 +306,10 @@ static void chtls_close_conn(struct sock *sk)
>  	tid = csk->tid;
>  
>  	skb = alloc_skb(len, GFP_KERNEL | __GFP_NOFAIL);
> +	if (!skb) {
> +		pr_warn("%s: cannot allocate skb!\n", __func__);
> +		return;
> +	}
>  	req = (struct cpl_close_con_req *)__skb_put(skb, len);
>  	memset(req, 0, len);
>  	req->wr.wr_hi = htonl(FW_WR_OP_V(FW_TP_WR) |
> @@ -1991,6 +1995,11 @@ static void send_defer_abort_rpl(struct chtls_dev *cdev, struct sk_buff *skb)
>  
>  	reply_skb = alloc_skb(sizeof(struct cpl_abort_rpl),
>  			      GFP_KERNEL | __GFP_NOFAIL);
> +	if (!reply_skb) {
> +		pr_warn("%s: cannot allocate skb!\n", __func__);
> +		return;
> +	}
> +
>  	__skb_put(reply_skb, sizeof(struct cpl_abort_rpl));
>  	set_abort_rpl_wr(reply_skb, GET_TID(req),
>  			 (req->status & CPL_ABORT_NO_RST));

Hi Charles,

I agree that not checking for NULL skbs will very soon lead
to a NULL pointer dereference. But I wonder if this patch leads
us to a better place. Because by returning on skb allocation
failure in each of the above cases, don't we end up with
an inconsistent state?

Also, the above notwithstanding, I do wonder if:
a) the warnings should be errors
b) they should be rate limited

