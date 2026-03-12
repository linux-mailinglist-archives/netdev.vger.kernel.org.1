Return-Path: <netdev+bounces-266909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JxeEMxNsmlRLgAAu9opvQ
	(envelope-from <netdev+bounces-266909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 06:23:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD9026D5DB
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 06:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BC4E301DDBE
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 05:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49411358389;
	Thu, 12 Mar 2026 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er1UP/a/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2E42D8DC2
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 05:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773292999; cv=none; b=CldxnrTpfz0Iql52NUeA0wM2rSiXCSWYsxG5oVJYxRaE7jDB82OvJvpKYIR6DNce7pq0uncCUNCA+1i69OjJPb4hzClUHoxe4oSdOS85wmel3NqyYxILFTmhSRXigokIViAvEDHPqzB6IDrYySo2nGFz1LDh0cVRzvLnmQrggKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773292999; c=relaxed/simple;
	bh=5CMMjtxgQtXyKnrP/IHYxuAvxK1t7FxJ2XoytVnj0RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaw7QFx2GNvCMGxGMpt5dlGUNiVX0HUUpZ9IasgjFtcDQtvxLj4fZSWwfQ7Hf/IdSsIK2x3P2w9Km5k6RyWSW/jENNdWZbggfhux1vp+vD9Ma9wOKT7VJvEJZyjd3oV/xoJuF9eiFbIEAe7xotSG0GEb84t4xbeCyrS4tpA+VG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Er1UP/a/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c73bc3dd25fso227613a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 22:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773292997; x=1773897797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q6vlO7FYWL3aJ8KsO9iAiZaaumwdfYJ9v4wBE7Btvdw=;
        b=Er1UP/a/KuLCavNZE/Ru5bPh34hB6MS/e2poZqKj+2MBQlJV5sV8Dt1VqTLW2H79lM
         OMghTsLz53mBtd9+p0KVci/F6pBvyTXOzpNXa+I9GZ1VogIT051PXRaZoOL07OjlzJDy
         UU2ehR/IbDm0TJvPB6AvRhlry0WNJPkvC8bl3G9BCYv3MJVS4hzYGZSEaQIkVKYUW7LQ
         3lAWbxrL2iEWMPIzeAaOh06oEwWQDKUk3OJpn44Juy9AAjvbMsi1yltPbL9JGBmdoOjz
         iQ3m9uwL16hMfGUo6vaUMKR0tnEIWzPPpsDh3bK0h8CDkpdcRfMxl+IsnHvFGu6GnTPz
         OlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773292997; x=1773897797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6vlO7FYWL3aJ8KsO9iAiZaaumwdfYJ9v4wBE7Btvdw=;
        b=xAiM/OyIZmgQasjHWIH8JgcUTY5JIvmn7N09eKotq1+b706iZBjJOyPlFPrbzNh8If
         Gtg6Hn/fdyOS74sdPvc7Eb7FdIy8TcqhuS4h3QheU08lrozURrElt2RidYpSlSUU8J1d
         UgvhpPaOA9DYXrFM2xPCSVY30nbYhD/KKKhVYgP7qHzvlbeAVLI9gUCArtOaXP6ytO2J
         1yHl9FjpMcCtLXMP2/AQFjOnsJ4H0Ou3MtBaSvs26CpBW6ORwHdTEpLKXBPsds21RSq2
         8zmVu9sRtAj+VNgpaDZ7H+hMsY4Nl1f09FINtEUFUQgMrFqMktg/LknwmG/xfoop6iFZ
         zKHw==
X-Forwarded-Encrypted: i=1; AJvYcCV6a/XDk95ZJ/CA2JaHzzaIlNitteugARVLjzqik3/l5RdW2bHpgzhwVP7/gCCz1Zb9ZtxjWAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyibgBin5uwQTJ+Vh//WpqcEfGXa3c1VgXtwTTmsRN6XcwQvWX5
	3WaPeiFga+1JjHq1N8Suq7HLQ75RL8mPtimpe9l9L2uArQtRbS/oKofo
X-Gm-Gg: ATEYQzzDupFaLIKcFpsWMhVlTEd+a9aQYaxmhwEp+bt7TaphTCJohmVN3AYBg+GZ9Md
	qNHbd1hNaeBnjB5StOJ7KSlkkiTcQWG8PaB5agDzudSK2+XOCohSRFQEuWiBmy+/WjtIXQLg2xi
	ZEXYJaCn0xcbHzHWFqdAaY3s61RC96XwuQYrCoMiDyGbOXAjU0I5AGBTC43kts9YwnDlYpVJRMJ
	6s1ev8JRx89ALSWFocNVQ+LxowbEL/LnZlzV/R9aYpMe6/14q2nluOjsn6rqG+zDERdl/AlIOkn
	boGupT+YxFcjvKzqZ2KWzxVu7QCLq7BN63YKTHAr1/6KTot/j/aIeQy93DgBd1vaM4wi/vK06TN
	rdhcuTgiRlhAfIW1z4hnkMP7PqOcQy94a11yzVIILZ4V0928zyT3q4FAJPZZ5lWpaVZ+zu3hkRu
	Y6M2POpnvDnv/nSmoYeyVY0yC6iO9LCDF5qKfKbdxoe7BudyiqdXm9myg5Z+o=
X-Received: by 2002:a05:6a21:693:b0:398:9d5f:e09c with SMTP id adf61e73a8af0-398c5f9dee4mr4749644637.24.1773292997327;
        Wed, 11 Mar 2026 22:23:17 -0700 (PDT)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf92fd9sm3724460a12.19.2026.03.11.22.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 22:23:16 -0700 (PDT)
Date: Thu, 12 Mar 2026 13:23:13 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net] net: prevent NULL deref in ip[6]tunnel_xmit()
Message-ID: <abJNwYsvfTj0jzMr@SLSGDTSWING002>
References: <20260312043908.2790803-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312043908.2790803-1-edumazet@google.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266909-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FD9026D5DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-03-12 04:39, Eric Dumazet wrote:
> Blamed commit missed that both functions can be called with dev == NULL.
> 
> Also add unlikely() hints for these conditions that only fuzzers can hit.

Hi Eric,
Thank you for the quick fix. I missed the NULL dev case despite the
existing `if (dev)` guard in iptunnel_xmit().

Thanks,
Weiming Shi

> Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> CC: Weiming Shi <bestswngs@gmail.com>
> ---
> 
> I am sending v2 without the usual ~24 hours delay, hoping to catch our PR today.
> 
> v2: avoid DEV_STATS_INC(NULL, tx_errors) as well.
>     add unlikely() hints.
> 
>  include/net/ip6_tunnel.h  | 10 ++++++----
>  net/ipv4/ip_tunnel_core.c | 10 ++++++----
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
> index 1253cbb4b0a45f1c62999be21931ca31b596697f..359b595f1df93663b3e32c006d936427e8c8b20c 100644
> --- a/include/net/ip6_tunnel.h
> +++ b/include/net/ip6_tunnel.h
> @@ -156,10 +156,12 @@ static inline void ip6tunnel_xmit(struct sock *sk, struct sk_buff *skb,
>  {
>  	int pkt_len, err;
>  
> -	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
> -		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
> -				     dev->name);
> -		DEV_STATS_INC(dev, tx_errors);
> +	if (unlikely(dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT)) {
> +		if (dev) {
> +			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
> +					     dev->name);
> +			DEV_STATS_INC(dev, tx_errors);
> +		}
>  		kfree_skb(skb);
>  		return;
>  	}
> diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
> index b1b6bf949f65ab7a09ba201d48aa204d913f146d..5683c328990f49df2954af9d890b5f24150caeb2 100644
> --- a/net/ipv4/ip_tunnel_core.c
> +++ b/net/ipv4/ip_tunnel_core.c
> @@ -58,10 +58,12 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
>  	struct iphdr *iph;
>  	int err;
>  
> -	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
> -		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
> -				     dev->name);
> -		DEV_STATS_INC(dev, tx_errors);
> +	if (unlikely(dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT)) {
> +		if (dev) {
> +			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
> +					     dev->name);
> +			DEV_STATS_INC(dev, tx_errors);
> +		}
>  		ip_rt_put(rt);
>  		kfree_skb(skb);
>  		return;
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 

