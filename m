Return-Path: <netdev+bounces-300679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9+SsLLQTNWrLmgYAu9opvQ
	(envelope-from <netdev+bounces-300679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 12:02:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C596A5192
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 12:02:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=FBHopCgw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300679-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300679-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA1573003839
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70381359A91;
	Fri, 19 Jun 2026 10:02:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0502736606B
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 10:02:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781863346; cv=none; b=Hal793gSmc2k1ehCpD7Rkmt7C4GdqvFSAhwtqr9FoYN5mfPUs2rIjx3OesvanHA4ldH75XY+AK8iHbQkozYXiVYcpAMm8x9dPlw3Qlha5G91nnaW85bQmjQZjNPLQZKACyPOf7tVBKWaLeQHPT7TQxQV+TzBlNdK3YJIxPX+zyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781863346; c=relaxed/simple;
	bh=MhJZqhZj/7uObxMIakNA029KTpTbvUiTVC724tehYwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDELu4BpdWxxrbXQRvpmX9WidBNV8AcutgyBjE3j4kwIZvRYcazVck9iy/l6NQRYYjLtOqx4rKHRZycC0doXWRe7DPH5cfdTjJ2Xd4PblnIH/1o840eg1fU5Wv5WcoBgE3PsJY5YbvdXVsmmPgTAcgblW/eONQvNWE/h5SDeyYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=FBHopCgw; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49243366b9bso211085e9.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 03:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1781863336; x=1782468136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wn453f2iZcDBfaPz4O6OtSxQBZWjeCfo5Hq7Mo1r1z0=;
        b=FBHopCgwr+mPdt3eBkrkzfLq5xzKe/DiMIiCkc1MX7CVvgy9PcVzUZxJPROH5gthyb
         FsRxUZ4oLsK/NzXzUAm8n2DBS1vp3qqRa7Y9PZzDvMVKgVZljSXASKP+DzD2VrqpQ7UN
         bLPyCXjfAPTNAJETnCn/9xddizNesBoc+qALMBM+ivplbCKZGvt67QfI0XUV/X6EWcwm
         t8itqJ6r4+nKezEd8ThKnhl2WzFL8L5+i7qE8lxDTPg8sEVzdSPIumb2MjR6UFpHlwDj
         2hWCYl1Pn3RZFW+3kRoie0wfNvuJAzwMJvlcpYqp/Ph9ohCoq2DvM51vkzSidTblxxxz
         A4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781863336; x=1782468136;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wn453f2iZcDBfaPz4O6OtSxQBZWjeCfo5Hq7Mo1r1z0=;
        b=TufW0VIFpj8i22tV15SKvA7FAsfbSD47Q9GOlc+rGoEhKYCIB13SpBSRdrBUvm4NOd
         8VtaBoBbsEtGQaPWO0VX/n2LNr9x2iP3nU8uHzER081A+oup2dUYluzP8Vn6pHiYmmHU
         seCAlWHb/WZufgxY4DicSDcu0oQVJmv50CzzRc8M4MgwQun9bkIud2hf1S7a68d/14sX
         b0PZbmKjONx1jZtH/jcOIysF4XOHla0V6m2hmg5GFNlQCqv9kcapgWBaYukUS6xP0wjX
         e59fYUJM2Liu1N1IOV/iIdUTM3IDBBniX6gjBsGApeX9R4WrL+P9F784Sf2OTakCeOg4
         7WgQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+B0tEuBb6n+90qdHyzGwQ9RNEZ24HGfkA92bdy/v1U84ZOqbBx41rgm/6uNQDY9QMOrx/dcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvZgUDclC/AQYBh2mMKeV63IbYYwzJRApObhAlkqClsca47DZ3
	kJb7N0xtEF+GMclaBotMUU2UtpF3EP/rYC8hV+XPeI5g8PZb8xvbHXrzV1hMc/diiRU=
X-Gm-Gg: AfdE7claZVTAZTk8cayl1raAnbHL3wAZSQRFPQlKzTmAMdh4YK1aC2EL0lKIX+/9hat
	vWQbobkuBSmGRSLmG3GsgqB/7gDm1QfY8uzRCGnkeo5WXVdOh9Yg9umQzQxoR96ul50JT6JMoHc
	AOve3ywjL2InTNsAUHXmfn4V8FnUfb4eJhDnD1hZpQ2Fte0Aoc7w6xFZTvkRQxt4jmzzxZQ9zui
	lNelGWaEYvbJu9dxKMtxD/2ewAnJroUy+m4j25PZ2HOrPGJb4Tt3fBcKzybSE+SFA13uyNv1m7y
	3FzmfjPJ5aJHhTO3NFH+27KjvBfoSz5C3dSAWVpCVcONHycAIu3hzgjPRgZRY0XwHx6cwhTRTbh
	4EH792ZVsMl4G9Y1Ny2YqVR/0u6bwCoZqqiBZ1SXyDF24p5gdFrh0uIVgff1ZYBKPFzIJPjaOm+
	5QBEQqlW3IO+RyAyD/6UzE+dIUAQ+TAN7nb1l87k/0UzRB8xfLj5lZTgTdObsQyVWEig==
X-Received: by 2002:a05:600c:8010:b0:492:2f55:3125 with SMTP id 5b1f17b1804b1-4923f5799b8mr23413495e9.4.1781863336329;
        Fri, 19 Jun 2026 03:02:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc160sm45498675e9.2.2026.06.19.03.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 03:02:15 -0700 (PDT)
Message-ID: <7fd44d94-477d-4773-bd43-3a3714f2e650@6wind.com>
Date: Fri, 19 Jun 2026 12:02:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 6/6] ipv6: fix missing notification for
 ignore_routes_with_linkdown
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: shemminger@vyatta.com, dforster@brocade.com, gospo@cumulusnetworks.com,
 ddutt@cumulusnetworks.com, brian.haley@hp.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org
References: <20260618162225.4588-1-fmancera@suse.de>
 <20260618162225.4588-7-fmancera@suse.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260618162225.4588-7-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	TAGGED_FROM(0.00)[bounces-300679-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:shemminger@vyatta.com,m:dforster@brocade.com,m:gospo@cumulusnetworks.com,m:ddutt@cumulusnetworks.com,m:brian.haley@hp.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,6wind.com:from_mime,6wind.com:dkim,6wind.com:email,6wind.com:mid,6wind.com:replyto,vger.kernel.org:from_smtp,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50C596A5192

Le 18/06/2026 à 18:22, Fernando Fernandez Mancera a écrit :
> When changing the ignore_routes_with_linkdown sysctl for a specific
> interface, the RTM_NEWNETCONF netlink notification was not being emitted
> to userspace. Fix this by emitting the notification when needed.
> 
> In addition, fix bogus return value for successful "all" and specific
> interface write operation leading to a wrong reset of the position
> pointer.
> 
> Fixes: 35103d11173b ("net: ipv6 sysctl option to ignore routes when nexthop link is down")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com

