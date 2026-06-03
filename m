Return-Path: <netdev+bounces-294698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yranFjj8H2pwtgAAu9opvQ
	(envelope-from <netdev+bounces-294698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 12:04:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 913EC63665A
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 12:04:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=d9J2qvtD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294698-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294698-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADB503019F21
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 09:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72E53DCDAE;
	Wed,  3 Jun 2026 09:59:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F133F6C24
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 09:59:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480774; cv=none; b=pXOyD93FcZ6YvZE7xvVbJVH7f6UCCoxL6DIqIRPE1jZltp74I5j3IuahXWNP4rTdZShGXJ6HTW5JAgA8S9MiIGjMKyf2+PwaY2rAOQ4vm+UbZgMoiLjKrCjuBm4tAu6O1ho6nHaVastIeuNsKBJAZaoQgiNhHQHlDViG1zyUxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480774; c=relaxed/simple;
	bh=WWE66kO5ap0KRWA3dusn2GSl1woyLWp9FPX8roDin/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzsQj0hxRcNvWypHNTkN2iLKoY/mEP/BMI6YGes8vKeE1inOzF3/EUX8yLPLs7TXAYmpL6f02tW5EfbosBxOXgvgL05Op0XhCYRE3XOLDMeOJ9UPXllfavAItS/Rz5WAYZPH6rDL/WfAlGOU7ysBQkchoIlfXJmK0gfDhe8hpGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9J2qvtD; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so20332945e9.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 02:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780480772; x=1781085572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqrPyJYUf1uiAVLQGGWXV0g7+QvPUPnWlHlluxYaVzA=;
        b=d9J2qvtDEBPKhJ+nDTCWy8M6zPrMJqJq2Mn8uOcIz+neK9iUtP1941ERXVSEqZoQsM
         mLImxgbPIhGsaXlpN/pSgVNvIkpdZQ4gLgTmHxYLWB1p+D9IZZh6N8eLQvORyk2rNDXw
         CfOUjfVZktNXO7p1vWqUwaOjiNna2973inY7NHvbSRvh29Po/sMXbV67S0zPKbSQ2qmt
         Q3YNbPPhwyPTcpgj2qld74OFAt73q2SKbQQq3tk6kPjiwnHh2YSyBujHfL9bC8OrLvoo
         88mB0eU9L5iNEKgVtGz7mOKN5hJ8M9BqeURKSSy5AUXQi+vDz2C4zO3ncEb3UqZrV6+e
         plow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780480772; x=1781085572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hqrPyJYUf1uiAVLQGGWXV0g7+QvPUPnWlHlluxYaVzA=;
        b=sFSiHmhIPQ/3uWa4k5PwNP6Xy0UtLrANn0M4ypx3WNyFC02Xc3vjqVL0Gn1k1AE0nJ
         gZ1fk3wWrEr0RqgOZ6cCTZ/x9YE9v2aZ1s0yEMyNS7FOwpFrbYxd5kxaRmR8E25YNRb3
         5LQ3ggLhSlYGwind7ZfpsY2PZ1LtTsHg1YYMNjdU1h1/S8c/vcWZ2qAD2GDLhW5/C4GL
         5lgvrh/x4peHFEpbvOixp+FdTJbSV9SUhbL0jZm6xbtk/ZPy4XZZIcX3ocjjuJzkRioz
         l6O+kCdwzi8Wvaw7XSNYJLluh0QglM+dr/o1z8Cctc1BtENDXLvSryk8iX4fMxGmERMc
         l/Hw==
X-Forwarded-Encrypted: i=1; AFNElJ/XrKpMCb1CYZLDoSJsJ3+zeoKg/YjwEtiQ96il/8Go44YzjNhZBsC38j4HernpAd0BxY1f1vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGWGB4v5I491sa7Zh6qBvbHGNKHFVI91QOlmEt0Hg9KSeceEma
	1PIWUbaS9cRK3R7HdwHl4Xkt9TLrTuYJOB7pmZixYbau207uF9FyVAmN
X-Gm-Gg: Acq92OEH9pXysFVqY5m4n3UJwMGfwoPs/cNyls8s73tbGJWk36snSMwfQQV5czNSGKH
	QdqLU2iBwKqS2b99g/Yh3VSeC/GJGYgjtLuLsDg93BcQyf+jNvMoSvi/3IrUAtJ/RKlZ5ckAnV6
	RZz764paeDcZ9jDSL+HzQa0fD8Ppw1lA/yTIDmE4bzPMuyIfCSEjITClQ/x5yRp/oVnDQf09eFq
	Yu87+0A+tGd/6mpfhXeXR0JTRavMnjA0OZU9l5hRcIWKOn5G6xYGOBxHOUJ5g34RcxmIJ2m6LSi
	qO1bfYSzDP5jZj9Ga0TgAex8Xd4vKdn8JXNaTZSjrw/7U0BLc6XtLydOY8SIueZbouPiTp3xPk8
	qVRfPKgYw1P2mpWGfomVkbvMTs98/QRaON6o6fNDiw17vMQi2ibySAnqhT21m9ZOSymJvKDA7ZK
	mMZZ1tvJxDR5Ky/PNGec4tPuoj2/6nP3rW1S7DSv7TYO32qZZG46XCD9eNQKOrJwpBvUyLsIo=
X-Received: by 2002:a05:600c:46ce:b0:490:b4e5:ce7e with SMTP id 5b1f17b1804b1-490b5edcbe3mr37338725e9.25.1780480771473;
        Wed, 03 Jun 2026 02:59:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e1410esm133565345e9.1.2026.06.03.02.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 02:59:31 -0700 (PDT)
Date: Wed, 3 Jun 2026 10:59:29 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Justin Lai <justinlai0215@realtek.com>, <kuba@kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
 <larry.chiu@realtek.com>
Subject: Re: [PATCH] rtase: Avoid sleeping in get_stats64()
Message-ID: <20260603105929.5f278675@pumpkin>
In-Reply-To: <d84e7de2-d30d-4ec1-bdfd-6d5e25d0271a@intel.com>
References: <20260601062447.64027-1-justinlai0215@realtek.com>
	<f4b96c08-c6f7-422f-aceb-aa48fa2bfef6@intel.com>
	<20260601224203.5d282c21@pumpkin>
	<d84e7de2-d30d-4ec1-bdfd-6d5e25d0271a@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294698-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:aleksander.lobakin@intel.com,m:justinlai0215@realtek.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pkshih@realtek.com,m:larry.chiu@realtek.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 913EC63665A

On Tue, 2 Jun 2026 15:43:04 +0200
Alexander Lobakin <aleksander.lobakin@intel.com> wrote:

> From: David Laight <david.laight.linux@gmail.com>
> Date: Mon, 1 Jun 2026 22:42:03 +0100
> 
> > On Mon, 1 Jun 2026 15:14:50 +0200
> > Alexander Lobakin <aleksander.lobakin@intel.com> wrote:
> >   
> >> From: Justin Lai <justinlai0215@realtek.com>
> >> Date: Mon, 1 Jun 2026 14:24:47 +0800
> >>  
> >>> The .ndo_get_stats64 callback must not sleep because it can be
> >>> called when reading /proc/net/dev.
> >>>
> >>> rtase_get_stats64() calls rtase_dump_tally_counter(), which polls
> >>> the tally counter dump bit with read_poll_timeout(). This may
> >>> sleep while waiting for the hardware counter dump to complete.
> >>>
> >>> Use read_poll_timeout_atomic() instead to avoid sleeping in the
> >>> get_stats64() path.
> >>>
> >>> Signed-off-by: Justin Lai <justinlai0215@realtek.com>    
> >>
> >> Looks legit.
> >>
> >> One question: for how long can this poll for in real life scenarios? Up
> >> to ~1 ms is okay-ish for atomic, but if longer, then you'd better to
> >> split it into shorter polls and reschedule() time to time.  
> > 
> > Anyone trying to get a thread running at an RT priority won't thank you
> > for spinning for anywhere near that long.
> > When an RT processes becomes runnable the scheduler will preempt a lower
> > priority process that is running on the cpu the RT process last ran on.
> > The RT process won't run until the preempt actually happens.
> > 
> > 1ms is a very long time.  
> 
> That's why I wrote "okay-ish". Ideally atomic polling should not go past
> 100 us, I usually used it for no longer than 10-50 us.
> 
> The author says that it usually takes around 25 us which is acceptable
> I'd say.

Just about :-)

Would anyone notice if the read stats code returned slightly old values
and did a async request to get the current ones?

Probably more work for a back-port though.

-- David

> 
> Thanks,
> Olek
> 


