Return-Path: <netdev+bounces-304949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z/NkIHSHS2oQUwEAu9opvQ
	(envelope-from <netdev+bounces-304949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:46:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C66ED70F6E6
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:46:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=L4XlFoKf;
	dkim=pass header.d=redhat.com header.s=google header.b=iWtzBdBU;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304949-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304949-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2042236E024B
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 10:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974AA42CAF4;
	Mon,  6 Jul 2026 09:45:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5518741F7EC
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:45:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331122; cv=none; b=NSI2UhaAcxsFKu9AGmt6NxfrynCJHUk87MgjwfDAJIWXol5k9o7JX0DQoxKgbKeHAy3rFEYT4yywORn2ZEa3V+dEPtFyM/N4ELOzq3T+GsHP3az4jIpUYLfy6ZyxAmCKastt0CR8NqV/aOoATPs/ff1XQQwYzRAxyJcl6QOq+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331122; c=relaxed/simple;
	bh=1XIeF1N1708V7n11cLvIZ1VE7KeWeZ3uj6dfzuHsrHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYrodM7GfOJHDtz1Kx4bppfkB2qvNlxyaKeW/sFCVX+ywBemgK+yIiC9xBvJJ0/UEpwoBHC+22W+i73RuIF3xJA2UxHksrcGsCNiBgYaqF45e70Y7pY1lUDt8jRKR6cnB8pz2FXcXCFHtpWerP8mZUmexGQKj43zbDsPEiVbwx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4XlFoKf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWtzBdBU; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783331117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0JZiWNiIfMLvkrsKKakzcqqqRzJryNplPf104vSB+c=;
	b=L4XlFoKfR55VAZXXBtSvQ7z/RMYWsGyqMtPw1TFqkvzhSN7zBte4LdOpDOX+dkzwRahzJ9
	b1RhUZxs9XO+vRjJQ04FmCgR59xeulA9xp1VjdSHMXaWezMNA/ne+2OdymWyWDLiHXnXzo
	pjPicLmWv9BV4Bocsq5s+S9qymBtLLw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-aS2ZCBSOMByY1c8N7oiRvA-1; Mon, 06 Jul 2026 05:45:16 -0400
X-MC-Unique: aS2ZCBSOMByY1c8N7oiRvA-1
X-Mimecast-MFC-AGG-ID: aS2ZCBSOMByY1c8N7oiRvA_1783331115
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-492714d002cso18153445e9.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783331115; x=1783935915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w0JZiWNiIfMLvkrsKKakzcqqqRzJryNplPf104vSB+c=;
        b=iWtzBdBURq7KP8ly8mu3mGohBSD/3UD1lD+P8Wa7MaXgRIwcJ40E8OH30KKxkP1f64
         vcQcda8q80Q6ROLW8fdttK4imm7+qjoRel+qRCyT8HFm4Mt2yml3xaB1cZ8BOXbPWrK0
         StSB/Bf0rHp520oY/I9GLsRQ0JKybMOO9b6mDlGCHKYrit+yb7V1TtZ7dpIgQbVRfMWP
         MYloCp4FmRVK7ToXCeHhba61IYla4sdLoc9zR+5Ls3nA9NQjKKcPauzMeU9cPNN6UN0T
         HXUVwpedtHIiqbdR105dZYmULaeKCk+vXaLz7Svyxoz5mMe21WEwpIOrPqarv3scooWV
         D3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783331115; x=1783935915;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w0JZiWNiIfMLvkrsKKakzcqqqRzJryNplPf104vSB+c=;
        b=kJP32jZ3ExYGtay03qkRA1GyHaBmv85ZyQYnK0ZYlbQa7Gw2CmHa1rriIPwKUt/q+Q
         vPySBhEJ2EnPcN1AaT0Gr4mXsKutgDdhIxSmCbDMDeUGTX3Chq2Tj/mI8FvvAngmt5eD
         qAy9sfGXPXwxdhOoA9wvF0q6M9PyNTPXYvpasN1W62/3S4o6sPunpGQjgpUmoi3tc3/M
         2aWv6lVaHWdxC+cfp6/WnwGZPDvoPc2r34p1Vl1k+aHmPRyBh9AvH/7XwTGzUnZKNS2s
         Ae+WOTWZx4oBx/qQnq4GHjKJ8U6kdCKoZPz4w9ubJa/5I7wncXCyvEpy4B11S/UcDMrJ
         Luqw==
X-Forwarded-Encrypted: i=1; AHgh+RpduILIT+6dAAT8fbtOKpLGIijg/+ZwveR9P6wFExF95ovvAvnSJxVgQe0+KMlomx9Fz2KbeVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdX3eRo5CrrQ2mrUUV/86ABF39P20du/RMOorMz1qB1q1al5vh
	sf86UgvNElKskGjA7bEIEr4ufLQZCgKqx47HEJ51xllV17o5hdQlmfdyp+Gih0xKQURBFgFhRbR
	MvlJC4ftfKFl1eWk/40SLdBJqzytn27TlHywqWpymuvJpswraTNdpwTPKWA==
X-Gm-Gg: AfdE7cn0RFULaaVsb3FgpX5mSsLSRReuVkx4Jl9ye/1pQ+Z89Q8oVTxK8es6pyqTfTg
	YyU88BT+5XNpQQCeO02oEh+1oM//734/pKuoqbYO1ffZA+1tFpiMcLe4YbEerpGroLkj55EFEi1
	Dw7s7eGMXQpBAlsctfQOzP/qEOzZVw4bGtKE5jguW+2NJWl0M407zkUrZ7LictEogrd0Q/LNaSM
	JT9x+gPJx8veL0XQ16NWYrIxBKnrTkdQcup+XiEQdCGOBB3v8oX7xwYpGTuRHIUEYSU/j5oS4nl
	gJ0SPGgCg6t2fhJI9zv+LoDYtssJH9bfJUwYcdubvkriNUBeQxWWU8tDzlNr4KSK+2/d/8Q0Z7s
	o5WYEOwIopcEPDsd0yidu4Bn+Go+240hSfi8HSmNlNQ7rQihAPRasbnjB3z2w9eduSa4wJsatrD
	m27DMxpPdk9Zjo
X-Received: by 2002:a05:600c:5487:b0:493:c389:d436 with SMTP id 5b1f17b1804b1-493d11d7b91mr109244785e9.9.1783331114945;
        Mon, 06 Jul 2026 02:45:14 -0700 (PDT)
X-Received: by 2002:a05:600c:5487:b0:493:c389:d436 with SMTP id 5b1f17b1804b1-493d11d7b91mr109244065e9.9.1783331113917;
        Mon, 06 Jul 2026 02:45:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6375764sm315001895e9.5.2026.07.06.02.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 02:45:13 -0700 (PDT)
Message-ID: <fd4b54b8-4e17-4519-866c-e0508e7b4ba0@redhat.com>
Date: Mon, 6 Jul 2026 11:45:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tun: no longer rely on RTNL in tun_fill_info()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260701125112.3652880-1-edumazet@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260701125112.3652880-1-edumazet@google.com>
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
	FREEMAIL_CC(0.00)[kernel.org,google.com,lunn.ch,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-304949-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:kuniyu@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C66ED70F6E6

On 7/1/26 2:51 PM, Eric Dumazet wrote:
> Update tun_fill_info() to read device configuration fields (flags, owner,
> group, numqueues, numdisabled) locklessly using READ_ONCE().
> 
> Annotate all writes to these fields in the control paths with WRITE_ONCE()
> to prevent data races, as these fields can be modified concurrently via
> ioctls (TUNSETPERSIST, TUNSETOWNER, TUNSETGROUP, TUNSETIFF) or queue
> attaching/detaching.

Sashiko-gemini notes that:

__tun_chr_ioctl() -> tun_vnet_ioctl

can still update tun->flags with no annotation for TUN_VNET_LE. I'm not
sure if a follow-up or a v2 is preferred.

/P


