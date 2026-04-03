Return-Path: <netdev+bounces-275068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFdTBaTLz2m50gYAu9opvQ
	(envelope-from <netdev+bounces-275068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:16:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC67395139
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 976C1303C638
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC01229B799;
	Fri,  3 Apr 2026 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdZeus1b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FF527FD5B
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225386; cv=pass; b=VwGaPH4Vs9P3ykSCDXQaY4GIgdFBOAjWQsKbcHzZEtnMsIwLDZlK4kHIex5JcfKzu+jrkoVNUDCIHVWHtaGbitfdb7VY/YE3WX0EEV9pirbE4ep/l55r2eYq+vCesF0YJ5pwEf12W6g6mraosXcy31kJL2rD1pw6uJIG9wgw0is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225386; c=relaxed/simple;
	bh=qbRrEnZzpWrSN1u397fwLoWncaQQwztK8g0+hanM9jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKONuOcHIg7Um10FCXfHpb/IhM2cY1qoB0UgG2WTS3siXlyuZIPo0iFOzRH0jb7LULJab5/k5Lgh7/6KtI+Y2LZl/9xJLbbh1oZLn4FzQzIuW0GnidoclnBimCvrRsbD8Jg6g658qeV6wTm0JNlL2Lvb8cCOvAP++kqDF0GJYaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdZeus1b; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66ad907833dso3501196a12.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 07:09:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775225384; cv=none;
        d=google.com; s=arc-20240605;
        b=A0S1mMY8I7oNuTk2h/MQfJvBVkKGL0SGcRo685UwUke9ST4q6WbgBC8qDv7N32zjtp
         v/kYJ/7VWH9srVegR/fa8VjqsVGui8QuPBNUx/akAX9H85N+5qU4KPRzkILPtXKYBUy+
         6bfr8ZZ4fdd7PL2AlTpV2q08KJlrR9QedM1e6HYh1YcbTq7PB1VzGGkP1lZsFO40smb0
         soPKJ5VjKJi2AwjDeWnzU/orepREf6hR7aI9ZCraegLT70bT3i2PrLu/H8lDljcuDSfi
         OKjJWAPi7tQNXLI1yf8cl/mL9cFNqofRXS5Kh+TngzQwu5SNEEj1QpHwxfhb28tuUTQ1
         oELg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WR6sDr/2QYQd3Rt/PMIZo6/qUJ5BGx5+klEe7Mko8E4=;
        fh=YG0p1JHzyOVHbL6If5lOTlWR+aEhz2A67VGtgz6Dqiw=;
        b=W7XWzGZDFxvrDjZSLTjKe9/VZOYxVD16gc2IQofo3R7f6OzOd3L1yIL81vqBjS7tna
         8Lst78tlHe5NVnbJt8a88vAfesNKvD5aMAhZNH69eCcCle51X9FLI55GMKJGLDGOafld
         3FdQM7hXl3nHXQ5wa9jVOIMLHZgk/0ta6mr6xjdfh3NCktqw1amNWZQGBtm0FJ0lPCD9
         7JU5Q/+9Di+CqFAisSLB0HzjcOY7KHrbc1+02AD9ff/XfdSlxI/urJmqoYd5C9kHg/Q+
         LqXWsoQb7HwspvLrG8PaWTmEWvCvC7DywdOjeG76Upkiyh4gxAFdMh0a33FmV+oNwUc2
         kfqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775225384; x=1775830184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WR6sDr/2QYQd3Rt/PMIZo6/qUJ5BGx5+klEe7Mko8E4=;
        b=qdZeus1baDOIbe5HsWqFnraencUAUSSqxQaUU8hmb3p0cck46lCdrU73kUe4Ka7z7L
         VG5O0Jz8ip3ZLlx0fBwnqyhBwWQTlsbra9qmIqagn9UQGxDPk3YeEZ1Curx3AULJyYvD
         h7qQB2vG8Wj8bjnGt354+3JeaN0FWHPieduzrkPtp3Jwtu5Hg9O41r1ZpXFZCzCGda7C
         b+5wVg/a33LjxAK3jF0sMqLsGOxszt3eR65vInxg+u//4+cnk51no+BsIubBxoahwA0p
         y/FtlNaZ2Bar3DvoCiPqtK9dRK0I6fmfLASjA5A7wftvlE4bXrN9nffT/3nCGSkUeOEg
         62jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775225384; x=1775830184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR6sDr/2QYQd3Rt/PMIZo6/qUJ5BGx5+klEe7Mko8E4=;
        b=QJ3TllXZ3CJy3F+olmBM0kZPWB0B4utySiN4/sb91sAW5IPn+QuhTa1lFrEhsb9IfI
         AcJQokeYEyb/dW0u4+MFLe0Cv6CI7DFgJaAoaKBB9tlNeunKpoegjP8CqOf6p5xw8Lip
         Kz5pRWyT1CqUfZ8lgBFaQotk2DlFjxa1Ok8Ju308VvXa+5tYN0PMWwV66tRfBG2Kb8yR
         FvJyXiOtjBsRq5Q+VIupd0wTPIZ2P6Xbt5bJVDWclQBG/2w7zKoL+rVWl/DNqXsQNAY8
         2KdwFyliJBo0KYvrjwQxNCDWXnZSYgvSP1FXpWb4qZMOtXtyjyJFj6w4DQpBr5XYskxC
         TYbw==
X-Forwarded-Encrypted: i=1; AJvYcCVlzRDfTmTfg4TZj9iRu41PxC0cwhVsAGGsFEIpz7VJfBLUKpFN0WRhkGVYZ5fg+6/YFcJCk74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/19a6CUr/xxfo9URHM6wc42JRLfr9exYRt0kOmwqu6JHAcsX8
	lkh6qT7J+NqwD9gVIuw2ztAPQtCpv0bEsn6RxMMkk9EFLjKAhsUIdJ/GYGM2DN238eTcsjPzdjB
	a/pASMw15HQIhk7iYVu/REUhC7TcN8sc=
X-Gm-Gg: AeBDieuXRxRkbShuvVq7zyjVXJl1B5Kh0X++b8stcHF6VEolfFPu2wsqX6holp0n/YN
	hMJ+2NW9VftiDEEbe/l2OOgi3jL07QYMa3go+9yyB/oCHNWBRpatxK3oUD3n0XO9tJtWZDSXoyU
	khT/x3wsXLm2jcu0mmYSmADEMasAgxUnYgXmCkp/PrxcifhfN9//ycRK7H4Tuln1JKs9IjDIPa7
	+LMcTeZEbaAEBKDRo1utXwsnfFtiIrFDwC/SqlcgawYoXsXbgOdQEZMwzZyM5R7cd1mVMdjCL25
	63ipB5xkHlWokVUWq+EcqT4Zl9n+6yxDsRbslhQB3xK7izgOr5Y=
X-Received: by 2002:a05:6402:1941:b0:66b:eb2f:a0a1 with SMTP id
 4fb4d7f45d1cf-66e3f871a1cmr1536109a12.28.1775225383190; Fri, 03 Apr 2026
 07:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-4-44fb63033b7e@gmail.com> <acx_1dOF3EjvGt4B@yury>
 <CAJq09z7+cA9_1fWzkrJebutJD0b1BGhrC1sUyoqqb=ddKCAXcw@mail.gmail.com>
 <20260402102717.5eb48393@pumpkin> <ac50sX3MZAcVSNJo@yury> <20260402232126.2e74631e@pumpkin>
In-Reply-To: <20260402232126.2e74631e@pumpkin>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 3 Apr 2026 11:09:30 -0300
X-Gm-Features: AQROBzCofzJmP5ZmSc3jneG_T7xdby2ZMQ3IjB1zaryEguM18WmcxlQtPGh3VDg
Message-ID: <CAJq09z5kMu4ANp3n2Q0C1j8TULdCKW_yPM=nN78mNupAt51YGQ@mail.gmail.com>
Subject: Re: [net-next PATCH 04/10] bitfield.h: add FIELD_WIDTH()
To: David Laight <david.laight.linux@gmail.com>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275068-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6AC67395139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks David and Yuri,

This patch was originally intended to reconstruct a value split across
multiple registers. Originally:

        vlan4k->member =
               FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK, data[0]) |
               (FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, data[2])
                << FIELD_WIDTH(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK));

However, as Yuri pointed out, I can use FIELD_PREP() to align the bits
into the final struct member without manual bitops. While less common,
this pattern is used elsewhere (e.g., drivers/clk/clk-lmk04832.c). The
updated approach would be:

        vlan4k->member =
               FIELD_PREP(RTL8365MB_CVLAN_MBR_LO_MASK,
                          FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK,
data[0])) |
               FIELD_PREP(RTL8365MB_CVLAN_MBR_HI_MASK,

FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, data[2]));

If this use of FIELD_PREP is preferred, I will drop this FIELD_WIDTH
patch from the series as it would no longer have any users.

Regards,

Luiz

