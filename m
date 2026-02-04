Return-Path: <netdev+bounces-256604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKlHFfb5gmm2fwMAu9opvQ
	(envelope-from <netdev+bounces-256604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:49:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE038E2D23
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83AF33053A8F
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 07:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E0238A700;
	Wed,  4 Feb 2026 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhjtPId+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF02385514
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770191249; cv=pass; b=F7nrXniZxyjwpyyuDaiLaz8S7FwLO8i3Y/LNSGMXAXV1CPBQmOvfd1rEt71oMZp9t3jkLSnV4puzxcX9zCSEpWkMqQYqGnPQ/Pzc61QO7ehgyICybzB5yWU/cr8iIOoyoF8rBk4dZ9sxipAjejieiyVe+qWOMV4DUhUAbcZ1K9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770191249; c=relaxed/simple;
	bh=2WhRs3rsHcPk4LyPGHeOvAwcxsLYO317+EnY2UUzSvM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=N1bm4hHdEgUcaWH4uKgI51eju4c0qWKAObI2uV8rSyOTNDNHID0p+vzooj4UU3xRE2ZP3d5W+ymVKvqSsyY72J+44UH/4cy0fK9I18GpL+qILanJGu9t5Jx8JvaXg/14s8ZCGaa47SkqoDp//H1A+H1UDqiHj3NvC0AutYB9/L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhjtPId+; arc=pass smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-89469143ebcso58476006d6.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 23:47:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770191248; cv=none;
        d=google.com; s=arc-20240605;
        b=Esz431MX5mC7JCj4smRKwUBbizZ9tfZOD4pLjFEPfmE9i39DYorq/QfSN08liV4NxB
         9xZIwmnuPqA6dcuPsUZkY5EhTLfkbluDv5QfSQ6rPY3ILsIgu3meJG/sySHoxi3h8Gkc
         8m3pNcFb7y9LA1fjx5n51CB+ovM06N15M3Lb8pHWeQF45lEOfM++bEqYwD3fQFMwxhif
         hyklBpRDTJcMzOshpRxOFGt4TNrtTs2n5TQf7+983k4wM+sCvwFT5oW3JyWgVtFB4WKg
         /v1UlYg6IpP7ZTh0TA6h93vnH1lD+KlzE7Gup4R0GuDKe+OaMr9n317VY0vdKHq16irY
         2k0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2WhRs3rsHcPk4LyPGHeOvAwcxsLYO317+EnY2UUzSvM=;
        fh=qJR1M71IQO3jjQz/0ilccUDTsaZYro5NQcCgk5LYiiw=;
        b=Elo58mvYXV6dmes8V7JfZxQ//ddqdSJ3R38Uy1FuPjvJ0CdbQ/KrbY6V2bb1e/ka1z
         Y4+K3FqQ3v3TPG2VtTOl7j4PW7sy/CrzfT6TbbSJQL0XK6pm4qL87ZP/TLc+9czmqW//
         XA/O/IRMKAto+siAieW38yFOTZR9EWzfEVOxHhqdWzCOhgsJvc8UQTH5Ylw5YQaYRqjr
         OwXPJSpdjUw9Bvads0AmimxgS2rqUgTixhewxZA897UnNRe2CO/NSFiOUN3Ytg9IoAfu
         TY0A9rJqjsL69E0DyaYA01xeT6uYsXZoi0UpGEcxZ9keXx+gwipL6k/C4IMmMqYof8z5
         MjwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770191248; x=1770796048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2WhRs3rsHcPk4LyPGHeOvAwcxsLYO317+EnY2UUzSvM=;
        b=fhjtPId+s016e6VfjR+bUZrI6HMVcDaqzh/gfiqcVapHJ1RQYomCgcy7x6wX54qqD8
         +iBF6yMw7KF8e+UHUua0Tadhbxd4Hp4lNu/XIgTWbbGa5iviF60dLGWTx3Ur+iL3MDS2
         HweM8qI6IY+q1n5LRopaYOFDZNqxzl6Q8gpnnD9zbmly5aT7PR+FhO761DYhGbIS57LC
         RHoVuNnbeSqmAJf0y+jVAXxH5zRliDiHgdHCR3PdCxYzBHIRxP+8xT8Bmi4xtBPQsoFk
         BtUeoAu1Mb9hjpYFIc73JNmzTUhdsl7P8kCIxo+C8U1p5OV/w7L5mfgIgCYN9gDWBCv6
         1bOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770191248; x=1770796048;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WhRs3rsHcPk4LyPGHeOvAwcxsLYO317+EnY2UUzSvM=;
        b=GyquxmcKc2sKAFnxvRphsuG1mhnrP4NiCC5HV/AlRTY+eno+azP3Zix/aZPdDU57sd
         JP///jcvTUOXk7eFhmguMjLD6QjnVL9y2Er0t0R2zM5+P/HNhiguUNIJqyD8kyeglxRy
         fLL3ay8ePte4AKrDrID/UWHAXH0EXPNr1ynMUultut62mDydZx5Yd27Kd8mNvy9QXIsw
         4T6lH4thhrkK80HM2WHk7RMphJ2KFgqmZmktphOkG6XWK5vHdLJ6YO+T5xCc+oqcpqxA
         S7JqwCu1EUBmXiOpvX9j1NaA7ZKrRcY3CLFmM5GnphSG3k6qDpUa33yQE5xbaD3YdLjF
         W7fA==
X-Gm-Message-State: AOJu0Yym8LbW2UVKXEdM6f8wTgAen/kPNKIYw+vutrCyyll5hHsf7JVu
	J2DkSfMBovcX4GyVvosTTV/foOycTbncmRzJ74qbnolTVnn9jQ6OoxXy3e2Z7s65TBdk5SY1ii9
	y7KrHdURCvS3paCtLL8CC6+nUCkblLtXLxdDYlPg=
X-Gm-Gg: AZuq6aL1kUBGLeEYbDayoVvStHCWjkchv9aeM3+lxPZoOlRWVewN7FNmqXGnBzCZBks
	auWLFtoxo7hvIHgB3kDWEKukq5sTnbuDN+i9W+vk0z7bXY2RPPe47BnX41pGvE3k4MwmOcdgWTp
	IHeMsWry1PxSfnwa4duU+MZWv5UpoZsFVd8nVOjtT1DmzSm5I9wk4eEXx7YMbA9h29oilB/tVDu
	xyGpCGvCWF60hbocNrd/tDaidqIGyUgtuRrWFd3wzg4HpLAho0jk9h4BfIglMNmQd9bUKTf4zPA
	yql+GPAxCpcS1YMtBwI0lhILN1mUxtoIlPCm4Dq7zROhQ/7XMsTSDqtSsFzpd/ExkUc=
X-Received: by 2002:a05:6214:1302:b0:894:6d3c:224c with SMTP id
 6a1803df08f44-895220fde3fmr28624446d6.13.1770191248451; Tue, 03 Feb 2026
 23:47:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Tue, 3 Feb 2026 23:47:17 -0800
X-Gm-Features: AZwV_QhcgkM0T9n7qR4tdzs_oTcnTjG6TnA5B3Eromu02ZynkntG0nZbjAquyzc
Message-ID: <CADkSEUjsT8OW9QVa-U4PQMG+8c1tjjxk7tNJu3U+6yoC82Y7FQ@mail.gmail.com>
Subject: PCI ID 10ec:8129 is in both 8139too and r8169
To: netdev@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256604-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE038E2D23
X-Rspamd-Action: no action

This doesn't seem right - 10ec:8129 is the RTL8129 which is much older.

It was added to r8169 in commit
de1e938e54deba5b093a3074dfafd0d11afacbe1, which said that RTL8110SBL
uses it. Can anyone at Realtek confirm or deny this? The device ID
should not be in more than one driver, because in that case, which
driver is used is unpredictable.

It might have been an unprogrammed device, since I have heard
elsewhere that newer devices with no EEPROM can appear as 10ec:8129
(in which case they don't work).

Ethan

