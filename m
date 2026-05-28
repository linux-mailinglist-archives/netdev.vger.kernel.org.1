Return-Path: <netdev+bounces-292866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJcWEK7AGGp4nAgAu9opvQ
	(envelope-from <netdev+bounces-292866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:24:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D645FAEB3
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E6063009508
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C3536921E;
	Thu, 28 May 2026 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYck+3Ya"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8007369D7D
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007012; cv=none; b=ZsHzrLq9/7wfnP9Xa0GIQWCzpzUtEu7s5F2q8HbEniqJMqaClSIZSy0fc6C54Jh214CpPWaDre8a3M+GgZhLfKvgUHRHBtxJWjounyZx5Rl6dm51JbqDyUkRV1TB3U1MS0KZ1S58yz5C9uvD9D9gWJpT4u9zZIKQG2EhMRcvi/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007012; c=relaxed/simple;
	bh=2SC0ANVkCKp8E1WQmu3i8e+gSNuNdk0aJRJ5X83hnn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpRGyslJrKa/3pLlB7d3XkWGej+FvfqmGxS5BS7W6+sMfuGfirh0QmINWkRaaBOQ0Pm+0gxEENmAcwbbNSfvAVdyF8CX3lkswwqKOVYI/YoRzjGvLp7pLAEmBpyJIa/g6TvXRdREvRdBBpeaDtpCenbvPoTIXUowxIKa4YGpNMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYck+3Ya; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49048a8ca1bso3566035e9.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780007008; x=1780611808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxyZcyLn2H2/+BqmnLphcOMc8sbPDUQAcX0fDWHLlEw=;
        b=LYck+3Ya6iHZGzADK96KwBBIdr7U86xXOqlQxzHxNOq5cIeT6h2zhEsPl/lCN42sKC
         OJrNtF5Rj8uo803ohXJhDM9Z+iyahrNOsXEXPRl5Cp2iOjIyjam3ETNkUA5CQKPUyXMi
         r2/8TxiWIXkU5A6jIPeFtghSHXNNRDXsaXuHd9EtXZUpfZCbtr92ffOpZc1hNaWKOT0G
         YNjPg56dhl8Rw5AKscWAqFXfR6niUVDUXRxiibjja8n9ZK9bfuUOcaW8gGQELTV1sHP0
         ibVf2rZ3WDeaDJRQs+MwVtCUtwa2W8yTW5cTAdWSat3uwW0OHDpLFzjkXQJvxzm6L4Eg
         n3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780007008; x=1780611808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxyZcyLn2H2/+BqmnLphcOMc8sbPDUQAcX0fDWHLlEw=;
        b=baSDYilR/6vXYDWbIOLO0KTAbf1u8hiwwL66QqzfJg//LPRcPZKQQNLSXIH3TQUbPp
         TAE78EIu4fjAdYDN2kNK9c1Guhyuu3tlzMtHdjCY5ZfDP7ar/O+80wSljR6L1dzIuh32
         cOEuvaCRFDslH1Tai5LgMKRlrcoRbP2F6NqwdcxdmBZv7rIL/Bp9/ohAM96DvKUtepGf
         x5nmdACgdicYxuqkFcbceJG64A0NZfteWvZGIAa50T8BiopLjdrNuOxyzxlU/IShdGlA
         L4cL9BbuecBqZ7gTfsmNmdvljtcREcWjomo6W2vDanPrCutYwdvVYxl0HtSix6v+Hc7+
         byYw==
X-Gm-Message-State: AOJu0YyPq6FcRDXD8rFNmizulUdPlK1+S42itQl/Dgo3sRZxtw7Aj8AC
	jvlB/+ZkArHW9AcIN8/FAV/RbQvNG+MDh7ZX0xCQNObuspM0qZOnrP4X
X-Gm-Gg: Acq92OGf6A1eh7smaWIXCth0ytK/MxKP4B+o2dpn9uvBwJFE1zCKmCPEIApBYwv8pUa
	/OsJONpt75wPxKhr1t/+IAcnvagF0TidMrimEfmmQAVC0NdV94GO0fT52/HZxDxzY251FpOtqjk
	Srg+SXAjTZbDtiPJiSwIqwqECrWSIXCNVDv9YKykkGKS0+BevZ0wu8qtwQRValavSXAKKCDXAJD
	+IHdN2EDIo9fHyLzGKHVJpOTm3ooa8rxlZrwmfvioLUsom37h5ZmWcsMVai2DHzevBbT5w+zzop
	E0Wcw0i/sM7LUaZ5nWoqOUJcitMemxHaeXYQMtQUCYARS1DRrnDHHq1Bc+Uc05Xm1CJfsw+y0IP
	PXOMt2J9s6P5/RJis34yYVSWuSoQDTW7Q9vcinVvhaYiLnAftYJSZnhGAG4qSULgWqK2xWrmZFf
	hCeCru1vzey/seVxl341oT+vPoJw==
X-Received: by 2002:a05:600c:4511:b0:490:6869:e7f5 with SMTP id 5b1f17b1804b1-4909c02bcddmr2412925e9.0.1780007007858;
        Thu, 28 May 2026 15:23:27 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d305:6000:97f9:e596:8819:1468])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909ca6575csm4326545e9.4.2026.05.28.15.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 15:23:27 -0700 (PDT)
Date: Fri, 29 May 2026 01:23:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: sja1105: flower: reject cross-chip
 redirect
Message-ID: <20260528222325.swzj77wo7lifymoa@skbuf>
References: <20260528203549.1918040-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528203549.1918040-1-mmyangfl@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292866-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 93D645FAEB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 04:35:44AM +0800, David Yang wrote:
> The driver silently accepts a destination port on a different switch
> chip, then programs its index (on another chip) into the local hardware,
> which redirects to the wrong port or possibly crashes if the port index
> is out of bound locally.
> 
> Add a check for it and adjust the extack message.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/sja1105/sja1105_flower.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/sja1105/sja1105_flower.c b/drivers/net/dsa/sja1105/sja1105_flower.c
> index fba926f85b47..7547999a113f 100644
> --- a/drivers/net/dsa/sja1105/sja1105_flower.c
> +++ b/drivers/net/dsa/sja1105/sja1105_flower.c
> @@ -391,9 +391,9 @@ int sja1105_cls_flower_add(struct dsa_switch *ds, int port,
>  			struct dsa_port *to_dp;
>  
>  			to_dp = dsa_port_from_netdev(act->dev);
> -			if (IS_ERR(to_dp)) {
> +			if (IS_ERR(to_dp) || to_dp->ds != ds) {
>  				NL_SET_ERR_MSG_MOD(extack,
> -						   "Destination not a switch port");
> +						   "Destination not a local switch port");
>  				return -EOPNOTSUPP;
>  			}
>  
> -- 
> 2.53.0
> 

The problem is more nuanced, but I agree with the patch. If you want to
resend to make it more clear in the commit message, fine, if not, oh well.

Basically these days we can do better than rejecting the operation, see
https://lore.kernel.org/all/20241023135251.1752488-1-vladimir.oltean@nxp.com/

If cls->common.skip_sw is set, sure, but if not, just redirecting to
dsa_upstream_port(ds, port) should be fine (but not enough).

The problem is that the source user port itself may not belong to a
switch directly attached to the conduit, and in this case, redirecting
to the CPU implies programming the upstream switch(es) to also redirect
that flow to the CPU, for it to be properly processed exclusively in
software as opposed to flooded. And then there's a risk that the flow
may have been programmed on that switch already with another target, so
the operation might fail.

This appears to also be a problem with my patch set linked above, so
they should be treated together (not necessarily by you, not necessarily
now).

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

