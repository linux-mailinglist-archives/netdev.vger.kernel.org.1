Return-Path: <netdev+bounces-306520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9ePSH3nTUGpg5gIAu9opvQ
	(envelope-from <netdev+bounces-306520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:11:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3F373A00F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:11:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=PP7GyeVE;
	dkim=pass header.d=redhat.com header.s=google header.b=JsiYhaZT;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306520-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306520-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D99630160F9
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B603FBB73;
	Fri, 10 Jul 2026 11:08:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80031E5724
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 11:08:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681704; cv=none; b=In2VxuJWJT8w6XrpqudXYizliPp0Fhwslpa36QzhisQS/SETGA2fWctEb6IxSMQqdI173EqNAl1fECdwuyJkWO/butuidyay0dimL8wAIeMjlYquRqSGTZPDAERt6pWNGpA2cQ5sHTJveQUpkcDhQadVd7+AbpF2YGY/op5E9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681704; c=relaxed/simple;
	bh=e5xqzj5VcmqRGQg9yvOVBS1RBaPT/HoPjWWGI0L4NM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m33KIa7tRCbx+zegayd/v4grvqKf5GdRfdaqDWQQc1zPpfjWOHABotSZ96lG9qgQbI8yMFhPXrFbpVttnZMnqKZmAFtRUV/5zl+EyGTR5FwxdZao/jtMGUttHzOSaaExUsGHb/A9v8gqdKs1lyAMtg/sI9V1IwpcJpoK1Sh8mEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PP7GyeVE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsiYhaZT; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783681701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A/xpprWsCARJV3hFOHnEFDBJZlEdfu5eZqIPOt6UdJM=;
	b=PP7GyeVEzGT20bo65gv3fQGgS6HkneaqNPZpPPS2jGHQa8sQ8WqRFZPcV3VtsdW2BWBCyL
	szNcT352j8nAGUXhRv5auHOlB/i7Ikf3+FetBx/cNO06PsANP28PGoIaEpNEhtXlVwbJGX
	1WTjjHdWe0ADllNC3DYj/iPYA22FPLM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-jb-CcGYfOoi8vDreUvnblA-1; Fri, 10 Jul 2026 07:08:20 -0400
X-MC-Unique: jb-CcGYfOoi8vDreUvnblA-1
X-Mimecast-MFC-AGG-ID: jb-CcGYfOoi8vDreUvnblA_1783681699
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-475de65009dso823873f8f.0
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783681699; x=1784286499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A/xpprWsCARJV3hFOHnEFDBJZlEdfu5eZqIPOt6UdJM=;
        b=JsiYhaZTrqUNYdNhblbU7UAyDSIWhiFkFTYnHyOXcb1YTACgGP5s5rBxtnt5BYckGp
         JfIb3LRAYOQXZ7+nXtkXT0O8SNR4mvvBGIphwh8u2bof7YTvi5bw87QjERupj8UbZDAN
         M5HiU8rNzYDdU04Zed+DSGA23SrqP40pB2kqI4p4Ez6Ofod0+ws7dGDRMxVFJZBUxQIp
         onnPEkwsResYiuhJfguxyCgobwX8fKfM3jfyc+gjmYif39nCho7IWqQXyw7hhX8fgHmp
         eoloyhLTM3xNifbPhOmULl3MYnnpcFpnLX+hyxym8MqupuNup4MZlMc97qb9VXBsiyfq
         vSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783681699; x=1784286499;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/xpprWsCARJV3hFOHnEFDBJZlEdfu5eZqIPOt6UdJM=;
        b=OTCDecA4uZVnNAGuA+GE1VCAr6ko4M5yZOSmoShtwRIpm/pZKEroxFpEYIV3lUdIOa
         /oZ4oX+WhYtYX/mujlUj7j8uAplKq8gK5NRMneKS3up9zsVksstUjh+8JxxsR1yK0PF2
         fRPU3e8mePHtXU2IE7GkSGl0/aYRgW9X3yT/rZ0F2dOShFTPYTvKGffKtBUo6gSdg3Zx
         3MWQbgnEMo/46/50t1rwwNRQmdxAzyn0NCNDjEzFjp8avS/eEyUwQuUNo0qerAd9VSVN
         S0HMLy5tH61CI9rVj12uVKmdkadMpXEYXTw+doewsyMHDLl7anWVQcFDr4dZDEo/MioV
         dyHw==
X-Forwarded-Encrypted: i=1; AHgh+RpzsY9tZMQ3baqT33xqAMt/VI4KLyx9mCWWaLk+8AUmHfuHb6Ta+eaZVfK/jq1kQJXwicBckas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoSNkhAzNlp7b8FQuZiOewpaxB7Gu/+UAxtGBZ1ov3dQFerDpW
	zTJthrRXaiHs45QlP+fjZhD+iGdQWb+liEGlUz8zwHJHgkFTQJD7SKJe7A72uSjsOkcS2yA4WLn
	ewUDvRu8ky2EErVEQn8MTFZl9dZksIXPat9XpeA7+ss2PxD3khMhAqBgfcA==
X-Gm-Gg: AfdE7ckXE8q8wTi6AFgNwhzQvGczpGC/NKblnUpEM3nAoolXaRrOvySspnb/X4try2q
	ukjpmg0PM5DkmDcn1l7hHnFGpFSZDAOhiFkw4ODau0U1fGdYYT+mBicF09gGBHllxsv7RJPdICI
	oRFoicbd9vcgBVegFtLHJjPYlXEOHc2Gf2Kl0EPO8DBvf3oNIxmFrQ1K0WVvkop43etLZJCS7cu
	a6JRZbnKvJz0KtTvkyD9ECWSVsndZkgyZB+JEoQm68HruU2jll0xh8jRc6+UQ/5N1yDy2zf5kCc
	QTZLgORqie2/ghCkTBfVYK5FPUNIqOrmHn7vfLPOcMobfuF78SAjlnjJT4N9rWvBoNeqVfg8aTj
	v3prQ9LymNkSVXGIVVEvuq3IW6m3dUvavSAWkbBN+gzQCSGcsj4u5thG99jmkEJtPjn4pA6z9RP
	DH57JTLJHn1LRp
X-Received: by 2002:a05:6000:40cb:b0:475:a05c:c63e with SMTP id ffacd0b85a97d-47df075c7f8mr11941815f8f.31.1783681698918;
        Fri, 10 Jul 2026 04:08:18 -0700 (PDT)
X-Received: by 2002:a05:6000:40cb:b0:475:a05c:c63e with SMTP id ffacd0b85a97d-47df075c7f8mr11941773f8f.31.1783681698469;
        Fri, 10 Jul 2026 04:08:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d6da9sm58458989f8f.12.2026.07.10.04.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 04:08:17 -0700 (PDT)
Message-ID: <71f1aba1-78b6-4e7b-8dc9-092b50402e07@redhat.com>
Date: Fri, 10 Jul 2026 13:08:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 13/14] ipvlan: Protect ipvl_port.ipvlans with
 mutex.
To: Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260703001009.1572444-1-kuniyu@google.com>
 <20260703001009.1572444-14-kuniyu@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260703001009.1572444-14-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306520-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB3F373A00F

On 7/3/26 2:09 AM, Kuniyuki Iwashima wrote:
> @@ -800,9 +831,15 @@ static int ipvlan_device_event(struct notifier_block *unused,
>  		if (dev->reg_state != NETREG_UNREGISTERING)
>  			break;
>  
> -		list_for_each_entry_safe(ipvlan, next, &port->ipvlans, pnode)
> -			ipvlan->dev->rtnl_link_ops->dellink(ipvlan->dev,
> -							    &lst_kill);
> +		list_for_each_entry_safe(ipvlan, next, &port->ipvlans, pnode) {
> +#if IS_ENABLED(CONFIG_IPVTAP)
> +			if (ipvlan->dev->rtnl_link_ops != &ipvlan_link_ops)
> +				__ipvtap_dellink_ptr(ipvlan->dev, &lst_kill);
> +			else
> +#endif
> +				__ipvlan_link_delete(ipvlan->dev, &lst_kill);

I'm not sure if it's worthy a repost, but what about adding a
link_delete_unlocked() cb to `struct ipvl_dev *`? IMHO should make this
code more straight forward.

/P


