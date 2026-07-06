Return-Path: <netdev+bounces-305094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wCIzFjHaS2rMbQEAu9opvQ
	(envelope-from <netdev+bounces-305094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:39:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 922A471363F
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:39:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=QwJm7X4W;
	dkim=pass header.d=redhat.com header.s=google header.b=U4FzFmER;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305094-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305094-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66D0B35ABEBF
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C963432BEF;
	Mon,  6 Jul 2026 14:19:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A125F42F71B
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 14:19:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347565; cv=none; b=U1PSWgTZTaqeCQGU7E4mT7bx5iworr3mTdt/A4I23HB15lr/1m8NYGk1ng0OCaMt4Jjt6SWYPGfLhPK6dnORyMO67kjbAG3wsTk5qONw1uT/a5CE/iLzQ5WLB+jG/JRQhHEOMVvwivinEiKS1iUmoygCgsdZK/b2AwKoW5xcQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347565; c=relaxed/simple;
	bh=neCBqWKXvaNRpzG8e2PqHcKw7/byanZoR6SfXW5PPJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vu2x83yByriLreIKOlBtFq7rh/zCccGXzxOWnPP9UeM4NO8Y0LCsMxHCbgw3Oy6Zg4YKOU35Zu3sjFQpZ4CciNs9GtI4pQHOE0AwKdwH+O1LsQqqWEeumrGnntbsuOX4KtfrrAWwDu8ZWqm0N5KEiyW7JUcGRpn4o7sbQIZBUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QwJm7X4W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4FzFmER; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783347562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bW5f6W4En+s/vR6YO0+loZpKqOqgAQJyAbAU3Myb6WU=;
	b=QwJm7X4WEYZad8+3lwLgtkXxS1In6SOvOM7fEcg2+2ubY3p3rqbCjHuRVn5jfBoXRVEhlp
	Dc7MDhMqR7Swos1gsAT3FpPPrGAim93qL47yInqqU9kI/sACMYyjYZ8xdoybETIn2jIkgV
	U2TGXNhu6AV5Qi+w3P3tfpr4zDHkQdg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-GSih1Yj3OEuiHvxks4qh5Q-1; Mon, 06 Jul 2026 10:19:21 -0400
X-MC-Unique: GSih1Yj3OEuiHvxks4qh5Q-1
X-Mimecast-MFC-AGG-ID: GSih1Yj3OEuiHvxks4qh5Q_1783347559
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493bf840a69so22724125e9.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783347559; x=1783952359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bW5f6W4En+s/vR6YO0+loZpKqOqgAQJyAbAU3Myb6WU=;
        b=U4FzFmERTAOelBstyXwBpI7w+3yfVD38BKJnOq0DiVw2udofMioFGeYRI0xTUtGX0n
         lEexrRg+8B7ly15z0Hdq8K2IntafWggD/cf/AIjz60IZTTiQf/PkhqUMLhzRV5B2pxr/
         w0jY+xGiuMeQEE0y1TsLLSfjktoEzpKve5FsBBDfUQfv32S3ypbsxlIMmktADRzI4GOK
         YJXrL+Us/n30TrxUx0dCAP0aYV7CrfWbP+ho9tie847rqXmUuJO8F7OE27m6J7Y5qfad
         l6QkxUQCDVi1SsfoijCqoZ8NRK92LpX6eA01ArR0ObI+0QuEmaYFtQ6HalN3xQNn8pu+
         cRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783347559; x=1783952359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bW5f6W4En+s/vR6YO0+loZpKqOqgAQJyAbAU3Myb6WU=;
        b=AqYuw/7hmtSPBGqK4HnTp/P/fCH+gHIUKRpfKm4iHstw4LAKRDIYhvzFCMj+6KvSQ/
         zRdTL91RCliApxJy2ci8P1HV3HugcV4tjuJMqwlTdiVY3L11G45XQsF90K0jCNyT/gHS
         LfK5gWW0WXTabEC0zBvBwYTdraSUVLBlA6OD8t7taF0jF8LS+hpouYuXlp6giy2u4404
         uATYCl46FFYmK0uu/T8jyH54zt4gvZm8jjFQZnfUME+eWSPAx76xfLPR7TPo+ZESW5Ca
         ARs1oixuYJ8kG3syiyjdaCvPmCDVVFMu3JZWOosFVR0kXWCeKaNv0abvZFqjDYDvkq8h
         De0A==
X-Forwarded-Encrypted: i=1; AHgh+Rqlr4JhWYid8gcRKG13JEqwZiMdd/MmUop7Sy/+Kux8seZqYZXRDUdNIAT4/YFcvAVs/TuVm8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdAu2zV+2qf4JrOYCuJlYOvTeBuAcUkcO0/Mf5+N76BwsDCJHY
	ibBD8cCn5SD/UD/BniKGDyGsByaJv5whQ333ONefejIglQoT/GwEvNQJz1xFyE7TndHoPiMMjTg
	mAyAHzkaSk/W8YDnGwrBFY7A3Dn75Db+8/5VqUtrW1CT2MjA0e4a3ibcthQ==
X-Gm-Gg: AfdE7cmPmt+yx4eJnKOH66t2GtAEK9tcAjcO86j7dG3T0k4Jun7yXiww89jnDLpeqSj
	0PR3truPNZ5BYfN79U8PJj6ZtKVGraC2Kc50eIkr+VwtVvAtzo5wTPt79OPGylGjJ2FDHKeKrQr
	bvTpnewcPOyX4CqxGzMCVJP3s/EmkP1w4tuCakfOs7lZbQInyT2TfUufKApZiBqJAsyMzsEsmL5
	QYMvm1I0T8pVN/3wZOae6rPj3VyYv8EO07Lt/9R6faTfaasnauaY/b1kNJbcbnOW/Ptnw4PriVR
	hLh5Ovv2/HVpBonuKbUg3i1FMRtj/aDdDBkaRx/iKRbQ57AJspD5XmtZsP6teeCY9QrFpXptQwV
	auf9HPbLju48UBgViMjZkcClSgf2xLU2R7wfrw3ITGznVwfTQN3IAiy9IQSOwDjT4rf49Jxc7N6
	TRbantWrSqCc77
X-Received: by 2002:a05:600c:3b08:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-493df0410d7mr9077675e9.14.1783347558985;
        Mon, 06 Jul 2026 07:19:18 -0700 (PDT)
X-Received: by 2002:a05:600c:3b08:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-493df0410d7mr9077035e9.14.1783347558499;
        Mon, 06 Jul 2026 07:19:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8cdsm27253314f8f.1.2026.07.06.07.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 07:19:17 -0700 (PDT)
Message-ID: <bc55e708-2f2f-46a1-b930-1cb62b05ac1d@redhat.com>
Date: Mon, 6 Jul 2026 16:19:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net: neigh: avoid calling neigh_forced_gc on
 every alloc when table is full
To: Vimal Agrawal <avimalin@gmail.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, kuniyu@google.com, edumazet@google.com,
 vimal.agrawal@sophos.com
References: <20260625084213.4e0b70c4@kernel.org>
 <20260706065813.66116-1-vimal.agrawal@sophos.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260706065813.66116-1-vimal.agrawal@sophos.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305094-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:avimalin@gmail.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:kuniyu@google.com,m:edumazet@google.com,m:vimal.agrawal@sophos.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 922A471363F

On 7/6/26 8:58 AM, Vimal Agrawal wrote:
> Once the neighbour table exceeds gc_thresh3, neigh_forced_gc() is called
> on every allocation attempt with no rate limiting. In workloads with mostly
> active/reachable entries, the GC walk traverses a large portion of the
> neighbour table without reclaiming entries, holding tbl->lock for an
> extended period. This causes severe lock contention and allocation
> latencies exceeding 16ms under sustained neighbour creation.
> 
> Add a pre-lock check in neigh_forced_gc() to skip the GC run if one was
> performed within the last 50 ms, avoiding repeated full table scans and
> lock acquisitions on the hot allocation path.
> 
> Profiling of neigh_create() shows ~3 orders of magnitude latency
> improvement with this change.
> 
> Link: https://lore.kernel.org/netdev/CALkUMdSCpx_ywYCx_ePLdm6yioO1nQWx7sSM=AEgsq0kywHxTw@mail.gmail.com/
> Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>

This apparently breaks neigh self-tests:

# 29.38 [+5.12] TEST: IPv4 "extern_valid" flag: Forced garbage
collection           [FAIL]
//...
# 85.91 [+5.11] TEST: IPv6 "extern_valid" flag: Forced garbage
collection           [FAIL]

full log at:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/722145/13-test-neigh-sh/

/P


