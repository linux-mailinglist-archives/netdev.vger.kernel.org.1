Return-Path: <netdev+bounces-255376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APkHLJmifWnoSwIAu9opvQ
	(envelope-from <netdev+bounces-255376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:35:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 148FBC0F91
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C04DD300BDB3
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815A9309DA1;
	Sat, 31 Jan 2026 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PlFAHKCP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D780305E2E
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769841302; cv=pass; b=Erks46mVgeCPHAS562pMjWWXnYcXkEqRcT/2Frg1rmWNhogh6DxAX0ljfJ3RBFkKtMLzlV1gzDXCysc49QBfKDE2sRGRej9wiZ23RBOZJykkSVRJnOZ5WnmCRXpVaPPObxBm9RIKEgtha8tOST1el/xYzs6zu9lwu1WWWXp7NYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769841302; c=relaxed/simple;
	bh=SWkXH9FhIQGb6ZoVcksz8BTjQ985Yb72II+s8aLscwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6SjauEvvKHqnwukl/FEaRwpgLra0oVTSX3xyshbtqeZAj4ddz66IPHNVgw9YpVAS+46BDgrZaGMuQdNT/7pqSGFtdeOwC62LPtHK+N+wybTrkrbwZ+oJA8ziVcDnOdeg7F7Nner1LzoPemBaorOSzNwdJiDzBojnlBsSUHRSJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PlFAHKCP; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124afd03fd1so4365647c88.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 22:35:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769841300; cv=none;
        d=google.com; s=arc-20240605;
        b=N8kPdDBJ0PSdVJT++6UoNK4hZw1xR9MsId7ajq+TnPdUzN5uV1CsWb87nJ5eFg99Tp
         rBZOw7TuSn6JTdptV32p9hgKr5SaKznmJiOWT0xGVYH73JBPxep+E3r+P6nFl5oASJTi
         KVEPH0smPwmtLQFCkgaXjFrQ0ZmY7UeADwiBoV6REkqsuzkpt2k14RwOi8EeaFZu78hO
         WaE9nNhOEjp6yQgkbdfoBQpv/0scvrt2o2k/4xtj70E8kTvKbdbO3WewTeofHx7GJ3g/
         eE/KbZZRXcNCrYXyvBgKW1jBQKBVsKd5CbJBo6dU3lGOUO7hKjSUTU6kP1YoBcn7IPk4
         H3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SWkXH9FhIQGb6ZoVcksz8BTjQ985Yb72II+s8aLscwM=;
        fh=dcMxX0+Y6U3/JnxykCyXfdSiDapef3z8qokqu7Hrw/0=;
        b=jWpSJoovTiARRhpwSv2lVMiDPyc/9Nr+NH84cj5KLigSWJrEjrQ4cpUcO4O/y+DP+r
         /evXU1ydsnai4rUris3AKz4PlsHwbA4xtHMrG50/3+/+UUEDcAmM9il0grIgO7jpHL/N
         G/Q1RfqdlsZ+ex/tkqAxhzPV0geoZqMbI8ld8t+MxyUdrrawxBxqR25Uihyie+Jo+DAH
         /o35vOYTTV3xSlBB+UGGW/WeOTawFrHYtugfjUgFguqxPiLaw3bhJHfXR7MnDiIrQ7bW
         Kfa4w8DexRl3T+7xSUGrEAR4LIrBUENCZ1KwiAoJJhJEgXJ27jqj5ZUY7mI4DHj5hI3z
         R4mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769841300; x=1770446100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWkXH9FhIQGb6ZoVcksz8BTjQ985Yb72II+s8aLscwM=;
        b=PlFAHKCPXJXFbifoHp8cW/c5qO0FhT4E7LioPogtyh9lYuMX5A4301pRSs2lDcOIz7
         2sU5Sd2nENv2Qrey+sFNODQSV14angM1+rNa/dGPi14aRippilQGKZBj/e91dvtH8Eh3
         D+1HUTF8B57Gg86yJBqkcDXP837bAOcFHm4/g+pbpnSTgtCnQLGAOIt6kbQWYfH6EyTn
         /xVlmz6kTLpS+tkWLyd43nC2cJC476ldn5oP4RKgU6dn0G2nO2nPypdTX85tSU4bYJcD
         6tpc6QNGSqrE73g5OZgeXEl/eJPSuudwm79ERQH92WVXlJp5gEVyvnKaGkzFvb10XHNp
         gOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769841300; x=1770446100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SWkXH9FhIQGb6ZoVcksz8BTjQ985Yb72II+s8aLscwM=;
        b=K6VWgTFuZVtKt17GQr6OhK4+OE8f5Ifx4ZxmCVCDLcZiIMi/C+ghF3ro023Np7Wpi5
         8wQgrp4mNWWHQr3hhRLoRbN9nVlheRdZm888s+qCrHigm5C7PWBoKa87J/Dlo88uR0Ub
         1LugolCYs55wIqLs/HDHD4pm1xlgDhCJqzBDDjDZm3dZMiNJW/nd3xI0WwojBg9q0lGn
         1JWA1Ck2kg7HG0BgHKXKs36x3bnvjQ3u5n/Et4F8une0g6JJ6OpyiH5KTTRStfHTsdDz
         qyr811woms6UsTwHFDHgZWb27GdvljKY5mZIFMP/c6HBkUBcNPaTep2BotCs5vwt0TOq
         GQrg==
X-Forwarded-Encrypted: i=1; AJvYcCVThCw7UOXvZhmaAYrOpguKBQhunqStm1YN4ZaAfaUEgpbY+oFl00rs372iewzcIHD4/+W1Ass=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRpV+uMwiaMyS0V+fDSXSM2xUirgm2diQKe24L5mwRg6IxRegJ
	kCiGQTR/5xFfrxTVpt1LFI38NloImsAnuMRStJp5NogZtUrfY5BytnHrdALggr+iM34oXDOwSPq
	GPwQjJoT3fUwBoB3eZ4MxnuXw4l7ajZ7u3r5W1T78
X-Gm-Gg: AZuq6aLS5Tn8HZz7Gai9fjFCM/siCVeNeWvr7guAsQgYM5hiQuDhYzi1Ug2iQqnQn3L
	AIa5aQwsPwVkla5Is403d6vipoUx2uQwvL2wmouHi8x4yTYnwY6rjpBkcGztknNTHBTMEVcJTFF
	BLQt9tnRr+R2PCqW77rW8/fyeug/q9tyt9CApaJaiv2vng1Do4wlSnXPwXUSFIghPU761SOHZQ3
	8dQEL1cgOE1vLs12wWe4eAinygV2ZyKDO4dKJ7bb4Pi3WRyn88ycvik8+qPibAHyiEnCbhQtuxb
	Vg5F4hlpiwQR4Vz1cjqTrfxTp8Ua6lfY325sQ7gGBQ0xvSlgFchv8EVWWUth
X-Received: by 2002:a05:7022:1a83:b0:123:35cb:96e3 with SMTP id
 a92af1059eb24-125c100596dmr2701980c88.46.1769841300113; Fri, 30 Jan 2026
 22:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130210303.3888261-1-edumazet@google.com> <20260130210303.3888261-6-edumazet@google.com>
In-Reply-To: <20260130210303.3888261-6-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 30 Jan 2026 22:34:48 -0800
X-Gm-Features: AZwV_QhjNy8bxgtS2HurYfLEfXE8_cSADwxjHZsVq-4l3NAQ7sE3T0lOjlg9b4E
Message-ID: <CAAVpQUB8fpy91APegCF3iibhWZbFdYuQQ_+wkWGCMWF1JYUvzg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/8] inet: add dst4_mtu() and dst6_mtu() helpers
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-255376-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 148FBC0F91
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> With CONFIG_MITIGATION_RETPOLINE=3Dy dst_mtu() is a bit fat,
> because it is generic.
>
> Indeed, clang does not always inline it.
>
> Add dst4_mtu() and dst6_mtu() helpers for callers that
> expect either ipv4_mtu() or ip6_mtu() to be called.
>
> These helpers are always inlined.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

