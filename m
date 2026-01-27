Return-Path: <netdev+bounces-253839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH7ZFMWweGlasAEAu9opvQ
	(envelope-from <netdev+bounces-253839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:34:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B57945EC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AB3030115A4
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E6F354AE9;
	Tue, 27 Jan 2026 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ij8D8QwZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKbQn1Ad"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357FE34CFAD
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769517250; cv=none; b=B90UPTQNmwrRIlr8rRfaY5nZ8YQxej063lKXHZznQVtr4D0w5D4dHAm5qwMJfeV9X7hbwR2G7vhgtsA3OiBI3Aelv/onor37rFG/QgtAew/atCCp4L8inNJ8PA1LxyoMFbsYuGlAqnTPImwQS2PcV1NV161/HcNJvrjT8uWdeoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769517250; c=relaxed/simple;
	bh=HJ7SANx1acYiar4uyTQpy+sl+uIifJg9nM93cmLUmYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHNLFjPUP7JFtCPAcgMFqeGOrW5Zpq1Z5gpeyQT9SH28Lu1Cg5Jd36IaJocQAJ1g3yXIFbZFlFDxPAz/6F38csTJBQ2AtfwkOMQ6y1YpnyJkjJUScaHNEinZzLuJpROVS6bvGeKzbPG6jZkw4pUI+gidlzgP0tkEzp0ASVtVLeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ij8D8QwZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKbQn1Ad; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769517248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/aly7Oa9P8CtJ7m7fooH55IGFySzvKDRQSyK9YnvJo4=;
	b=ij8D8QwZmiSg7lq0qZxRLeYka2XVuNRDbjg5E5Nl3ENL+GMSFjPfZsyEFzDUuJ/vsBus+d
	JHcP09TaTwyvJFGdQUZ5B/rZGSZCpzBFT+oFodujsVAVnQi/SmlDpV0fmPkANl4yP9kfyo
	Uv/19qEkvr+rpVDheBFozgeCdJwrUI4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-nH0ZUVO1NHqtFheZRUKVKg-1; Tue, 27 Jan 2026 07:34:07 -0500
X-MC-Unique: nH0ZUVO1NHqtFheZRUKVKg-1
X-Mimecast-MFC-AGG-ID: nH0ZUVO1NHqtFheZRUKVKg_1769517246
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47fff4fd76dso42035615e9.3
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 04:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769517246; x=1770122046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/aly7Oa9P8CtJ7m7fooH55IGFySzvKDRQSyK9YnvJo4=;
        b=ZKbQn1AdC1wx94XaToTWoYK2jNVg02kVe0LIhvJDKK+P6TqnQklBieEb1ZcInbRriW
         SWJDRoeP6QrR3AiFMQ10vnn/IZt2h5C6+tXOMyctBM5cidjrY9UbzmowwNa7rHyrPuFZ
         ozYaEnLVYVe5jbkAR41F4us7zMTI4wicW8p/lNFYcBvZCwFBp9ExYyopQWZd/9nRVasm
         q/1A3DpJE2CyKpOftqJ6gTx7z0sStIpCbIXlaC31DjOvYsJQ91jKymqSA3fqkWXlZY1t
         JNbDMtnIuwOQtUQ58ifNXOjOzKiF8VVNYL7Ozum4vqHmSAFains+sJCBsHxLW12ZBG+L
         a01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769517246; x=1770122046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aly7Oa9P8CtJ7m7fooH55IGFySzvKDRQSyK9YnvJo4=;
        b=BmNQFtJtCCwnfIXo22sCiq4ufiy9lU4CP5SKJFicqtGAUx+SdWAXAwzyUmrjp7OAml
         mjlPgsmcAkQxnET3ze1NM4vBSTEiDdYpxNs50qqAB6x/sgY/fNhAuqyUjAMRvntfzvu1
         43sSrfYptsT+g85uEfMloWZlAGxdig9/x119gwMG8RwdTmI5daJboE6pwLRXMIp2sMCI
         YsaZaJOM6zjMujy1MJpaNd2jZq2Nl04bsLU33Et/bUtWTi+htBwlyn/giZ+Vda1Tt+p+
         FzzFwJq/ucxDxmsj857Lx4bQDCWaGgyINixNYrx0HV0HT8zIri6mSQ+h+Z6g7hPeDODP
         xNpg==
X-Forwarded-Encrypted: i=1; AJvYcCUJAP8u5KgHpbwqVJ30oyKl7wep35NsVg/fZ34VOG07gH2shauUYvJUBQjeE2O/Ko1k/ireYvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6KrFE/E8XNfBMQDFAcIRz6JCNhNnYoQWUL2lK0h4CW4KgRz8p
	ypCVrELHhyeuMoabSvLgFlETlIlfNMoc1kEZvd612b7/xQfFDjullga8bSQI6rKKF5Ss3n47w4S
	/uz0QNaeZsVPxVcr1nG8rtHqkOSnr6gV1L2jqkgdLVV493WcYMC38GOvrgg==
X-Gm-Gg: AZuq6aLCavBVo4kVcGUyLT2Q9wvOyTlb9CsWNJL792YtEV9+Ggo5YQ85gUhUfR1u0dE
	2wkwQqgtjSZDV+7nC3CTq6l22A8/tTpU0qtZ/znr4eDekq27VAqu7+PTdvjtVuTVxNRQV9HWncA
	jJz80FcRtgS6dL5pmycmrwhfvKPYIsg/E99N9AdLcBx/RZAQEopWYaE83pRDpI7D1TCxlwQP0Tb
	NdGDXqrOVTzGTUqpolNM5tqxeQ2IUcyYaNQ2trDxpDkvZgswzPQ5XqdDplp3UhY4stS6zs/R8SN
	fXB/6fABhAC3WDC3tfCG++Gu7gdeLHBC+DhFymkrX8Oem3azeLcfnMUpIs+V/OmDOXam9LHsLEh
	7zcRtcCxc0z1y
X-Received: by 2002:a05:600c:190c:b0:480:4a4f:c36f with SMTP id 5b1f17b1804b1-48069c4869bmr22272815e9.21.1769517245715;
        Tue, 27 Jan 2026 04:34:05 -0800 (PST)
X-Received: by 2002:a05:600c:190c:b0:480:4a4f:c36f with SMTP id 5b1f17b1804b1-48069c4869bmr22272385e9.21.1769517245209;
        Tue, 27 Jan 2026 04:34:05 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bf93cesm56353205e9.9.2026.01.27.04.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 04:34:04 -0800 (PST)
Message-ID: <a957214d-62dc-40cd-a422-73b317bc1827@redhat.com>
Date: Tue, 27 Jan 2026 13:34:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] ppp: enable TX scatter-gather
To: Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
References: <20260123014214.225278-1-dqfext@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260123014214.225278-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253839-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2B57945EC
X-Rspamd-Action: no action

On 1/23/26 2:42 AM, Qingfang Deng wrote:
> PPP channels using chan->direct_xmit prepend the PPP header to a skb and
> call dev_queue_xmit() directly. In this mode the skb does not need to be
> linear, but the PPP netdevice currently does not advertise
> scatter-gather features, causing unnecessary linearization and
> preventing GSO.
> 
> Enable NETIF_F_SG and NETIF_F_FRAGLIST on PPP devices and add an
> .ndo_fix_features() callback to disable them when the underlying PPP
> channel is not using direct_xmit (i.e. IFF_NO_QUEUE is not set in
> priv_flags). This allows the networking core to pass non-linear skbs
> directly only when it is safe to do so.
> 
> PPP compressors still require linear skbs, and their states can change
> at runtime. In order to avoid races, instead of toggling features, call
> skb_linearize() before passing buffers to them. Compressors are uncommon
> on high-speed links, so this does not affect the fast path.
> 
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
> v2 -> v3:
>  toggle features only if the underlying ppp_channel changes. Call
>   skb_linearize() if compressors are in use.
>  - https://lore.kernel.org/linux-ppp/20251103031501.404141-1-dqfext@gmail.com/
> 
>  drivers/net/ppp/ppp_generic.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index f9f0f16c41d1..d706a175cea9 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -1545,6 +1545,16 @@ ppp_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats64)
>  	dev_fetch_sw_netstats(stats64, dev->tstats);
>  }
>  
> +static netdev_features_t
> +ppp_fix_features(struct net_device *dev, netdev_features_t features)
> +{
> +	/* Don't advertise SG/FRAGLIST when IFF_NO_QUEUE is absent */
> +	if (!(dev->priv_flags & IFF_NO_QUEUE))
> +		features &= ~(NETIF_F_SG | NETIF_F_FRAGLIST);

I spent a little time trying to understanding the logic here and I think
that enabling features depending on IFF_NO_QUEUE is fragile at best.

It looks like that the IFF_NO_QUEUE bit is an inconsistent state for
multilink devices using different type of channels.
Moreover the user-space could attaching a qdisc to the ppp device after
channel initialization.

Instead you could always expose the features and linearize as needed
when transmitting on !direct_xmit channel; no need to touch the
individual channel implementation, you could do such check before
calling the ops->start_xmit() calls (possibly creating a new
wrapper/helper for that).

/P


