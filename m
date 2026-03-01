Return-Path: <netdev+bounces-262368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEYtEna9o2mPLAUAu9opvQ
	(envelope-from <netdev+bounces-262368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 05:15:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA791CE7CB
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 05:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09467302D09F
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 04:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54C31CAA65;
	Sun,  1 Mar 2026 04:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="CCQU4o6O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4814B08A
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 04:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772338546; cv=none; b=MBpZM0cywhqeW35+HTl6wiJqpAGU1SlobGOoMHV/pX83Df3nPBIp00lO1o+WxAvSIwSgTQVeHUXfLQ6SwvwRBpjL/89LYSx/2KkZcyV8xu0n3SaRpl4w4ViC8/tGIZwccNehAkPf0seA3g2IgiUJ85Jxfz+2/K6CXu/CIOTC2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772338546; c=relaxed/simple;
	bh=KJJ4cECWizV1DiLSPDhnm1jFX56BfKavUCiZVsqReZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBc345PgN2eu2X5/ai74GTI4ODaxO6aahoJBMO5TVteeq5BE5H/T35W/KpfF8uz/dZnj4Wg5GieeG4u5fuTYpVpLxkYV3Re+tX9p3jxfID+o019ErQj9/HmipgDGAHT+BZom0MaMzycaIySLqMqJld8/LG3NKlmFHwfGpmE+wGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=CCQU4o6O; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c711959442so383142085a.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 20:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1772338544; x=1772943344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:fcc:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bkf58p5E6mW2R8Vu+Y4ot2ZtwCQqP1cLlx5WZ51GBr8=;
        b=CCQU4o6OtbfDtbjIjnP834RJ6KBxD9Dwu/12nWK8A1qgIIITczNt5TGHUgjXHly3Gv
         6px9ApGhBIAuf4HW9CVSNNR9RoqWFMshFFTLi2wZCCovo12ekUgzsAzr/I/HTCL1gjyY
         0uf7chq0Ehjbr0YdZs/iy98Z61RyZ3Ru6xKG316s/Ra3elll8EJXCix6wIxaz89Bfquj
         4KAmZ4XMa3+XoquXtsPIMB2JPrsyPJ3ul3BklB06skSzTEBA1s/okTKscJq/cdhHfMpv
         eoQXcgL2LO0PuEi9tUwMrsQOJsNAOOwhJF6b9SJr7KLSzbCW2lo0XBk1ViI1rpKtBT9q
         Y1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772338544; x=1772943344;
        h=content-transfer-encoding:in-reply-to:fcc:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bkf58p5E6mW2R8Vu+Y4ot2ZtwCQqP1cLlx5WZ51GBr8=;
        b=vS/2wocqCiHTCkW5HWhDOEkQHTGDLxzc5BoOD/m+jZ9FP0xct5/Mfo7M4epyOI26MI
         miwFwozOTlW/i1wIFZMjtDUGqOqijc/5v8MTDDTVnmVVBRJ0lO7JtFb8pzqDCuT7HVAB
         qJTlwL4FWE3YLWcUR+r9MXEH08zAJ+iFeTdU3xIn4JQpTwxy8DAb0ZeZczn7+3RH34SW
         YVLNMAX6bbZKmwSVoLtErRVgybGTTRbHD6s2Kbj93ywQE9mayYtsNf4QGrKIMqgMrRcL
         ZZhfFvCWrkWC/eMEhNqQUdeT5U5sW2xfXNMhUrIMj9ex9AWsgd1xMoZAwYJgk7KM0rwg
         lbBw==
X-Forwarded-Encrypted: i=1; AJvYcCVCLkMZO1s0PKphKccOab/WOefOoXk7Bq6gD4dfQbPQMPivSiMco2OG/s2DjBxTdb8D2YBz8Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCMxE7ThA/gCn3o+9uvWLO5HePwheva3xwRb+t1ks9gCRLapqW
	QB+0Y+c63dJIDcjpAnGiG78H1RU+uBmgFaZzzDJMilv4ImOEhHwzsmJkaPpsFlYLKKQ=
X-Gm-Gg: ATEYQzzrFaOCYvZaG4JsjgdScS0+3u8ysg0h0gTixD8Wjo2xk51J5rzYM9mErYFkQTZ
	v5idXP88+U35Aeem8YyOiPARuQkQ4PpoNcT1ap2wMsrDdjiHFhOmz/ATed2GTogdhaGZHg4ZjqR
	oG5v8qZTNw3QW9M86MCnMBcSn0awdrKeB8341RYHUrUPztIZQydJjzB645k6biqhBQYEwVksbtO
	bmdcy5brjf4FKPoccFH+gM/fDqvU11ArKjDrCe5XEzSnwEgOqtb2STapJT9HkHGA6dfe0gvbdzj
	E5wWpfk7Sz9kpHExBddNJFpJ4U7qbZ/tOde9vm5Vw0SonbiESoP8EozrWEsPuNZzw0BoU/IVbY2
	MpaA6IiqY0HxmZKS3lXosh+zDHKTw4AjidyYbhMdPNGQbz/Q/bZOMOWCe2dCB5Hym4Rd97y6FnR
	eGMBpAHs5/kwXF+5n2dOYaiSUd+8B6iwHTtlIDi8lJ2E6/vQoepPR4lDiR5pT3tHJe/w==
X-Received: by 2002:a05:620a:45a6:b0:8cb:bae9:9f42 with SMTP id af79cd13be357-8cbc8cde6e1mr999030685a.27.1772338544509;
        Sat, 28 Feb 2026 20:15:44 -0800 (PST)
Received: from [192.168.86.87] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf564c27sm846264485a.0.2026.02.28.20.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 20:15:44 -0800 (PST)
Message-ID: <929612e7-cbba-4d9a-bfa4-f8e8b8f68c2a@davidwei.uk>
Date: Sat, 28 Feb 2026 20:15:41 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/9] selftests/net: Add env for container based
 tests
To: Jakub Kicinski <kuba@kernel.org>, Wei Wang <weibunny@fb.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, netdev@vger.kernel.org,
 Daniel Zahka <daniel.zahka@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20260224002410.1553838-1-weibunny@fb.com>
 <20260224002410.1553838-4-weibunny@fb.com>
 <aZ3pl177Q6+uJCCN@devvm11784.nha0.facebook.com>
 <20260227183045.234a841b@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=0
X-Identity-Key: id1
Fcc: imap://dw%40davidwei.uk@imap.gmail.com/[Gmail]/Sent Mail
In-Reply-To: <20260227183045.234a841b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262368-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davidwei-uk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 8AA791CE7CB
X-Rspamd-Action: no action

On 2026-02-27 18:30, Jakub Kicinski wrote:
> On Tue, 24 Feb 2026 10:10:31 -0800 Bobby Eshleman wrote:
>>> +Local IP prefix/subnet which can be used to allocate extra IP addresses (for
>>> +network name spaces behind macvlan, veth, netkit devices). DUT must be
>>> +reachable using these addresses from the endpoint.
>>> +
>>> +  +-------------+        +----------------------------+
>>> +  | INIT NS     |        | TEST NS                    |
>>> +  | +---------+ |        | +------------------------+ |
>>> +  | | NETIF   | |  bpf   | | Netkit                 | |
>>> +  | |         |-|--------|>| nk_guest               | |
>>> +  | +---------+ |        | | {LOCAL_PREFIX_V6}::2:2 | |
>>> +  | +---------+ |        | +------------------------+ |
>>> +  | | Netkit  | |        +----------------------------+
>>> +  | | nk_host | |
>>> +  | +---------+ |
>>> +  +-------------+
>>> +
>>
>> One thing I noticed when I tested this was the flow broke down when
>> NETIF's address happened to match LOCAL_PREFIX_V6. I didn't fully reason
>> through why this was the case, but maybe it's worth mentioning in the
>> docs here?
> 
> +1 I think it may be useful to add to the diagram some example using
> the documentation IPv6 prefix, to explain what the addresses and routes
> are in each of the boxes (and please include the remote).

Thanks, I'll improve the diagram to better illustrate what's going on.

> 
> Also
> 
> 	local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
> 
> please use Python's built in ipaddress. The standard parser will be far
> more flexible for user input

Got it.

