Return-Path: <netdev+bounces-306497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i3zhIRLEUGoI4wIAu9opvQ
	(envelope-from <netdev+bounces-306497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:06:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7E87396E9
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:06:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=OckaxqCi;
	dkim=pass header.d=redhat.com header.s=google header.b=GDKKFzKc;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306497-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306497-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E353E30AA94A
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C48D3FCB3A;
	Fri, 10 Jul 2026 09:59:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841183F0779
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:59:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677557; cv=none; b=ifACRliRWZsUve2dxNOahSdupLpvXDrPqPHb5S1DDn0DLCQXOlhtSUOiFn0jyRQ5ItQa9VYA6hGl0guAhUIqTgg52rkL/hlOpnerWtnlwIDnik6Q+Ebu0uYJp+9Ws4qzAIEis8FIFRQmYeOBx+ZxiJU97CF+MUVSkXEB24J4V3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677557; c=relaxed/simple;
	bh=+z2jQv5OERjUiePae826KN2zBrzJjcXbMTIJZOwzkGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toHai3iRdU/BOzP/+WZ6VohY9SU2UDCtMj2/FYVSlb76Q9PNOdL4wAybhtHQiozOB3WEXztePutzHlZVeF7JxoYFEq0kpS4YwqIM1rukyhYv5h3lTsf0azGjO6Y3LZwiiJpOPTPDWc/uL+qoGBXcOKOk/Y2zqVCPqHYVfsowTAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OckaxqCi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDKKFzKc; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783677554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2pOdwkBhpBjkUlhAXpPxmMK4yMM34DSXxSSkOBQ4Yg=;
	b=OckaxqCiAAIYHfhajR/nVEKXxF0xEAiodLNbZCg/BcbvnUY5CmyEwVNRR5i+Ye7r3EVyya
	NPw3hiIRgO/N2NkhSfTJu5efvozmqK/7eHI+GITllt0H1TR+Ve2nXQ1onkQE4h8noWCPYo
	s7BoaxQw7dvEkOlwkk/2h/efPgs4bq0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-MqSV6PKmNbKOrRxrvjiXEw-1; Fri, 10 Jul 2026 05:59:11 -0400
X-MC-Unique: MqSV6PKmNbKOrRxrvjiXEw-1
X-Mimecast-MFC-AGG-ID: MqSV6PKmNbKOrRxrvjiXEw_1783677550
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bd52dae6so4585675e9.0
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 02:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783677550; x=1784282350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2pOdwkBhpBjkUlhAXpPxmMK4yMM34DSXxSSkOBQ4Yg=;
        b=GDKKFzKcvA2QMVpwTsZZZ/xm0jDl8K6aquUZ56l8FKdxo0ohqwjwo1nSuF3Cps6m7r
         HyM66jKpquozYmwKr6ALtYFfcP8xJcIeW45riuLI8hkezUaSu5q7rk9bF/l7A2DbmaEh
         NMbrGPhASCtJ0gSj9DAqkFR62NvhpsKd87vmdX51JN8yhuH0uwQ4aJ/TKL5grvUpMSVR
         48WzZnLTeBEsDCwhRUM25QdZh84A2U4q+Rhd4a0YRQapgrik+QqFI31K5x3WqbeGQ64Z
         pBYkk1w+dqrVzetm63aW8iGuaBbnkGkAU8Wd542SauhRn1j/1rgSb2NstQurmFDtyFDa
         Vo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677550; x=1784282350;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e2pOdwkBhpBjkUlhAXpPxmMK4yMM34DSXxSSkOBQ4Yg=;
        b=LwdfWjWLTwrOytkwY7S493SbDA7iavp6VVNiUT9CujIfKoTAfrNTqEOPxRPvLd4YeL
         NXr705PYiVbgcNJ/rLP2Sf92W+yLLtpgWvSxY/TiDLzJdNOkxvo3wvMCoU3MGbl2xvca
         MVMqVYX8yFtpYft8SCrVmMPmHiSs8c9pFJ2q2UNM3yp3INprxT9id1ZNgYf5M+5r4Zpt
         5SOMnQ1wbU3bnarIjoiiBZbIRHW4ixCZrEWwJxHJLy8zVJXC6zQSki3eHGOGwNzI6eZE
         kQ+jkre7SukP1rm6noTtCcCN/vYzBrqyNqpY9ZLk+HxgT29VQm6urFTF0KuwEO1ZQtZM
         Cx7g==
X-Forwarded-Encrypted: i=1; AHgh+Roc8uHqlgwwRihJ3Z9dzalO2aBGj01L81shRCCSXqxX6mjXQLBJq9Q9K9cEp0OcyDt+PslbHJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB5INgPrfv1Rec4do3m9XAQyW1BQPzuWiNNsz/TCL2OLL2dxFq
	lgxL64ylIHh3m3UJuHhforlUc1Do1Xfc/67hWwJaGE978pyyn+WyLKkeP7Yaxxrua1BGxA61Yby
	tOIpCXt6o4iWHKUpjfGRu7ll/OoWZVgkZ99pwyjz+/ujrROi0k0c/B0N3vg==
X-Gm-Gg: AfdE7ckK4NyUKm2BeI1la9Ir54pcRtlYHrbz7xqkOJPOl+/xsBVRx19XZVHE7umL5oN
	kLsMSgB2lHSKprgzXCS1yekqYZFwWqeocqIzKH7IZuxpXeOT78uOB0ZVHij82YTYHHU3jPZrFl0
	wbEBOsMjje5KNTjVD/R9eUDfnjiL62gwkj0u/XLLyCWhK11Md7Kh/mKij4SY4HVqnIU1BVwYrch
	KzBjv3ArJuHz678S9f01UKujmRgqtemKPSu4TibDv+TamZAlRQlt5JiKF0EoczFAemE3E+JAaI7
	70ddvnWgL9ONXvq+Bl2yQt1ro4bDHJZ/B5LBBa0yoJrtzR/tlHuUx63mpbNsmT1WvYmIcUVPyfu
	2m1yY/Hh+TOiEzIxI7sYHg5J7CpkV/xJ5DxLKxEStij8z97NPdWVBR9ajNQNdIPhGRTSzYhXUsM
	eUf4bvo4A+o+SU
X-Received: by 2002:a05:600c:4fc6:b0:492:43d2:9e6e with SMTP id 5b1f17b1804b1-493e68391c1mr107994025e9.9.1783677549967;
        Fri, 10 Jul 2026 02:59:09 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc6:b0:492:43d2:9e6e with SMTP id 5b1f17b1804b1-493e68391c1mr107993585e9.9.1783677549421;
        Fri, 10 Jul 2026 02:59:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb74b3edsm151477245e9.15.2026.07.10.02.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 02:59:08 -0700 (PDT)
Message-ID: <e53482b8-4e1d-4a04-929c-f5cb443ba59d@redhat.com>
Date: Fri, 10 Jul 2026 11:59:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/rps: consolidate RPS dispatch into netif_rps()
 helpers
To: Jemmy Wong <jemmywong512@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>,
 Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Krishna Kumar <krikku@gmail.com>, linux-kernel@vger.kernel.org
References: <20260702152830.39065-1-jemmywong512@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260702152830.39065-1-jemmywong512@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-306497-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jemmywong512@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:krikku@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,google.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE7E87396E9

On 7/2/26 5:28 PM, Jemmy Wong wrote:
> From: "Jemmy Wong" <jemmywong512@gmail.com>
> 
> The RPS steering logic in netif_rx_internal(), netif_receive_skb_internal()
> and netif_receive_skb_list_internal() was open-coded three times, each with
> its own #ifdef CONFIG_RPS block and manual rcu_read_lock()/unlock() pairs.
> 
> Factor it into two helpers, netif_rps() for the single-skb path and
> netif_rps_list() for the list path, and switch the callers to
> guard(rcu)/scoped_guard(rcu). 

Please be aware of:

https://elixir.bootlin.com/linux/v7.1.2/source/Documentation/process/maintainer-netdev.rst#L400

> @@ -5695,33 +5727,20 @@ EXPORT_SYMBOL_GPL(do_xdp_generic);
> 
>  static int netif_rx_internal(struct sk_buff *skb)
>  {
> -	int ret;
> +	int ret = NET_RX_UNHANDLED;
> +	unsigned int qtail;
> 
>  	net_timestamp_check(READ_ONCE(net_hotdata.tstamp_prequeue), skb);
> 
>  	trace_netif_rx(skb);
> 
> -#ifdef CONFIG_RPS
> -	if (static_branch_unlikely(&rps_needed)) {
> -		struct rps_dev_flow voidflow, *rflow = &voidflow;
> -		int cpu;
> -
> -		rcu_read_lock();
> -
> -		cpu = get_rps_cpu(skb->dev, skb, &rflow);
> -		if (cpu < 0)
> -			cpu = smp_processor_id();
> +	scoped_guard(rcu)
> +		ret = netif_rps(skb);
> +	if (ret != NET_RX_UNHANDLED)
> +		return ret;

This function is performance critical and RCU lock is not a no-op. I
*think* this will add an unneeded rcp barrier when RPS is compile
enabled and `static_branch_unlikely(&rps_needed)` evaluate to false.

At very least you should prove that the generated code is no worse than
the current one.

/P


