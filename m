Return-Path: <netdev+bounces-279912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDqdBN1/5mmjxQEAu9opvQ
	(envelope-from <netdev+bounces-279912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:34:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 093874335BB
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C7043005146
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27FC3C457F;
	Mon, 20 Apr 2026 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXBYKr80"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9553C5DBE
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713677; cv=none; b=MKUdWtf2dfeY2V9VcWTBZdk0Vozlf/+fg/wZ92A0YjuoZY8EjnXWSlphg3wGoOF4J+meTqO8hnLo+9QBgIBNO/E/POlday7wj9bH3Pj0OBUE0hbODDgh/YV9duA/x3+Mzz3nIevalgJRaGbp7Ocowku9OQLqerAXfnylwyaQ21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713677; c=relaxed/simple;
	bh=4AcxTXrP07xw5t1hnLLLV3ffxLb6Xd2Pby+ubT65AL0=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=gVTPsnyyowjQroFIXgssHyoUjBhfDT7VwTP4vAbIj+Q/Gy1T7j3xGhqGnFVkuJRYfLH1kXH7wGI9cDYALsc3JS2TYRv8CM3TtCtKr1yJGlCQEtEae7AIk8qPjaHmjPKh84JOaHRON3mw9KnrjZXzGTfeC2ICqwPczk61M3wfsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXBYKr80; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-42c08cbae4cso811672fac.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 12:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776713675; x=1777318475; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vr6bqKSRSVsDkD+G7UTApJEY1Dv37sU6YEle/+qubhw=;
        b=GXBYKr80AmJU+6iBnr31r6oQFVSE8X+fHwDuxQQTZOf74hSZRGR5uoGCFBYuImckSx
         9WRet7ciI9u+ifJq48RXbfT2oruCChMM89XWt3QkBtluby7MCexp+XWjLmaCFhKeug7M
         yN2GQ3ZYStI4hO6iHFdbEzNaMRCfsLho1MWgOO9CTVn1hGLFlFtaop2CxszxrznNMX7m
         vbwXRgGVI3t2ylfWGcBztzoXi6/X8cgi3L5GHinRghxOiPIh4mYatCME+XhiS2YSpOcD
         0v+/wmjeN4uhj08jZDUEVFpAtvZRAOd7CY6ppDCigCv9wHwFElVi2zhn/yRCC/rG/bz5
         WJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776713675; x=1777318475;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vr6bqKSRSVsDkD+G7UTApJEY1Dv37sU6YEle/+qubhw=;
        b=hD4Emb1wf7hWseZDKRcp1SfM7JR1c751EntsWDeIjJYGrx7VqiVqxP0YyuwSEBzJHp
         X9EEMWRsHLvkoKQVe/AJS1g8TpZxo9tbAlE31qhNnyxd9ujV7PwyaLzHSqXvv0Syt9Df
         8l+/qmnpMh9Pw150AUDiZwb6YNte7Y+PGtVK8Q8D2xlNVo28+B/8fLh5tvxLU3+2N5nw
         puMugZsEGRf7ZeKN9dOOCOYmE0BUCRZ5hrYynJGj5kAOEzT6KutfuwmrW1S4jFvf+xbM
         WJ45fSCYTOL7pgT2sYTgB6I3RqWqpftnu1q12Lcz/DEtZ9P43Q8P29g07NkMw1E3Ze+H
         9icw==
X-Forwarded-Encrypted: i=1; AFNElJ/Mb/TUCJcHIPCMKxxLH/fhsQd6tDpxBK5naKBK9ebFzTOlrk4qEPnh1yo1Z3Uz2EP/tpSmZh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV5fZQ8HCrNVvlvVopCCt/RvbCxT7JWydZX8zXG4vYkei6Uajd
	SHzzOJWzN3BSScEBkDITVqLUvJdGDJ4KqVwAKVDwQELyoNf6jOaavw7J
X-Gm-Gg: AeBDieu4SvlT+XgX6loBHT6LxuEzJ/n/gxQDPxB7X9AMtznGhzK7reUZ/UE3ajkmisE
	xMNWYL1auKmS+R0xrbUp41htotx0T6Z7eu6DLBi3+zthTEpaiYtiiQOuDXE3jv2CjdXMF64DCdy
	DbKyAInUcyxw+6/R5HSZjHswxZ6044N6KQLly7Yg9ih+cmgdEBxzdOif5so2yHBkGSFGZh4qMEa
	Z7VU7v4ahHWQENmgjSBALHpxPZWZSv8MubXvEWsq2IEs63XMTtdXwRReAlBn8CsGcFGKA3/Zx4S
	ahWNv+Nl08/FBNxoYi2aYuLaSqyR1mouoq088yUJYgjzx/Hf8Q4TAvQgYPCghWNlpRKa86TKRrw
	GvCiyt0/TMx+cvhv7UEyA0XuVyFA947mlViPRXRL62dCXilsxTDczGn9qahs6juX/saAbaWiB4A
	sx6Sg12+rQD9vCvp5ANU1SOy2KoE8u
X-Received: by 2002:a05:6870:b10:b0:409:95c6:f2d2 with SMTP id 586e51a60fabf-42aded59e24mr8798401fac.30.1776713675325;
        Mon, 20 Apr 2026 12:34:35 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42c16b64a83sm1389898fac.18.2026.04.20.12.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:34:34 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:34:34 -0700
Message-ID: <7f15844902d6dcee6ba070b0f3002b20.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260420082805.14844-5-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v2 4/8] xsk: prevent CQ desync when freeing half-built
 skbs in xsk_build_skb()
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279912-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 093874335BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Jason Xing <kernelxing@tencent.com>
> 
> Once xsk_skb_init_misc() has been called on an skb, its destructor is
> set to xsk_destruct_skb(), which submits the descriptor address(es) to
> the completion queue and advances the CQ producer. If such an skb is
> subsequently freed via kfree_skb() along an error path - before the
> skb has ever been handed to the driver - the destructor still runs and
> submits a bogus, half-initialized address to the CQ.
> 
> Introduce a new common helper to fix the issue. That function will be
> used by the subsequent patches soon.
> 
> Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/
> Fixes: c30d084960cf ("xsk: avoid overwriting skb fields for multi-buffer traffic")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 4fdd1a45a9bd..614e7bd1252b 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -717,6 +717,12 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  	return 0;
>  }
>  
> +static void xsk_drop_untrans_skb(struct sk_buff *skb)
> +{
> +	skb->destructor = sock_wfree;
> +	kfree_skb(skb);
> +}
> +
>  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  					      struct xdp_desc *desc)
>  {
> @@ -890,7 +896,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  
>  free_err:
>  	if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
> -		kfree_skb(skb);
> +		xsk_drop_untrans_skb(skb);
>  
>  	if (err == -EOVERFLOW) {
>  		if (xs->skb) {
> -- 
> 2.41.3
>

Have you considered the alternative where we postpone `skb->destructor =
xsk_destruct_skb` to a later point? Will this be less messy than
undoing that descriptor in a few curated places?

