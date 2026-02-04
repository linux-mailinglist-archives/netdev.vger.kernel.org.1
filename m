Return-Path: <netdev+bounces-256621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHQOEeMLg2k+hAMAu9opvQ
	(envelope-from <netdev+bounces-256621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 10:05:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CE2E38AD
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 10:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD93304AAC8
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFF3395265;
	Wed,  4 Feb 2026 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bU4dwAQU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAAC2264CA
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195650; cv=pass; b=m+r4BYTJhsLVMMhuO5YM5iyy4eehivR+4CdVXDXbdel22GE/aI2GDrCtFQid71NbzXMc/rvshPyzTHZR+RI+jCunAy91PuHVTuUTfmuwSWceHeXI1456L9z3D3S1F+xtCv/k4V5AXLM8/g4fa2c2ViHAZQM1xyh8MV3pImQKYio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195650; c=relaxed/simple;
	bh=Ls1D+yxmbY6bYCTOk0C6MSrbomU6CnAzVv656Mw/4fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8/zbXf9TUnvolyRviBVk0e1JRTsRyg0IB71Tb2sdrmMV4I23doc+IM7h5Vil1X/8JOGEzked7z6qac5xt6m9Y/LOlsQQdgs5OGKAczFSnv8FWZR4QHwimkL4DnGscx/yriGRzEVSUYiWKNvxcKUzVnEs9sOYKaL9eH/0PFQ55Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bU4dwAQU; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-894770e34afso87512216d6.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 01:00:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770195649; cv=none;
        d=google.com; s=arc-20240605;
        b=gBTlccV0ZyTH9mxf12hAzo2R7ehwFzPQsjNPEpqc82I8Wb7yB3SVdgA8guJsDLU07n
         rl12nEAamPWGT7BIOxQ9aePvF0D27bsAiUVUu6BsXRBZ5PMjzjPDbraXCr/w2vURpD7Y
         VweZQKC/Rfk4FNuUO4BozvJmqa2Wi8DqVbbO4bZESo+SLwnZZrtM4FlrLdOgwfuwAFFd
         E4XGnTmiVVc9w6hmxeDFF7lC1hn246oeDHm6VRvKoGXNpyXwoFhTR9JbJRvmMBFZVekp
         3w7OXzGMyW6O/mzjMkKwMfulUyL3IYQpYBEPkDNfIPj9Ek0cKlUJi4EG+lJe362JF3OR
         rO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ls1D+yxmbY6bYCTOk0C6MSrbomU6CnAzVv656Mw/4fQ=;
        fh=qJR1M71IQO3jjQz/0ilccUDTsaZYro5NQcCgk5LYiiw=;
        b=XpPH2eGbwFavyE1cqM0JKjHgFkdbxGJBd3InkV0IIJ8FOYJpPl0cRBtrFIB6tNRIpc
         USLO9nvWmCPZB8c55VO6IsysNSwm2RmVF/IKWEhTFBAKLJz6pF1/+yicIc/wH6Q9Gtlh
         TaGMrwNR016pwokA4raKi+bOLU3LpIgNBvXeawXyB1FbaFYOH2y/3q96puU97AIlVaqc
         g46VnIVSLp1yzujGILzwOVPVqemFO1JNlhpDdyKivuEWCFraq0CrMHUThQkZSwGIbGt3
         XUybm8kyra3JC3/jdPxeIvV6ZLdzp8NwwHrxJYo7BGbDVRdJ5W+evT6fkOmkFb0cP3Rf
         Lv/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770195649; x=1770800449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls1D+yxmbY6bYCTOk0C6MSrbomU6CnAzVv656Mw/4fQ=;
        b=bU4dwAQU9oTDP+tZVWb6cS1lDuhhR0ALS2C8Rw1SJ3PQAB3DxD6O3UA3pDBbI1W9B2
         jl7G/MIJzfQ14Cd0J3agYiJrP3IgQ8tF2IjApR0dXHZPt2RLkIva7R8N8xOARQXcHpxf
         s6jKwNFAUYj3X4N/WMDU7nNDgHf61GsDZ37sle7djWIUrtPJViR2fqnYOkZ0X3IC9dgt
         AwZ0mhUUDIOEBCJGZVMAnOO4iWA3TAdzPEJbmAHFL/aSe7RwfcD7uP4nUhXU4ZEmXE4b
         vPJTtzuWdVaBaqmyJM1eavzsOoe0U66f7WnZSIAycY8OAfCSPNshz7d7cfJHhd5FkT67
         gdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770195649; x=1770800449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ls1D+yxmbY6bYCTOk0C6MSrbomU6CnAzVv656Mw/4fQ=;
        b=hCIVgVaNBEOug1HnFiNCj4afwvm2sCw4hri0kR0ba8yPgoAAG3oPSe2j1mw0Hp7ZiC
         /VUK3FObt8PZz9rD4YKyEMPs27X6/V3xFN5oNLYtDiNamGPR3bA49lBG1VuXkJRp4DME
         ZPy8tA2b4EqGt4RyoNyIhG7zOu2SY51ieIn6sAWBbIHrd28rTSrzVCUoXLe2BY4IQLsn
         cBW06KPd1y9oBCV+TsKOH1J0U1hGEwS92YyuCgMWBZoM9TIMvTnwouzSjAz8Zwe7jBuA
         Up6yyJgS+lAhWl1Rxif4WJSTKKpFYDj0E1Le87NViNns3TBqDVhnzzOVTVY01fZJ/zAX
         sH3w==
X-Gm-Message-State: AOJu0YwU4y3Dj5+dmkKgIItSi0koLD3bqHrghYtLcN84EIFQBisRaMq5
	h89KCAYrzJc2mdowUjC6ZBbEuqsVM2I5+VJ9gsKVxeH6yWAFV9R3YPuXmW3vUjapMscOH5AB60H
	lvEVPsShyNKP8hG2uvHVGdV7XRVsYuvFTXI8R
X-Gm-Gg: AZuq6aI6gtCcc2Mz0UaWb2S/bGTq0qfD0bMYAUxYQe5gscUY3INq8CVYqT6zqgFl6CV
	/OhmawMfA2wvJUbV0bRJFuMIFiTmZ2CiMvzupFo2coAW72mfs8H4/Q6lyVMz/vfdTsMw06pF+mX
	aXuuc/IDKILA1gRXsrF0Dc7SWj3JyWvKxl7Q4Qj6vZtibntCMc7cW6GnNfSGwHUHb8v31hJIkut
	nTP/QRQzuQ19LVB7cSZ+xFEO8ofXA0WuJFQkaLw15/uyKsz4u/CfiOYxbwQ1D/zbYdFrVrEzSWp
	EjVjasN9UnkHmVKrq35kvBDPdN9WO8jcLbAeUoSLDssOb0FYYryKEItK
X-Received: by 2002:a05:6214:27ef:b0:88a:568b:f4af with SMTP id
 6a1803df08f44-895221019c8mr32165666d6.23.1770195648713; Wed, 04 Feb 2026
 01:00:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADkSEUjsT8OW9QVa-U4PQMG+8c1tjjxk7tNJu3U+6yoC82Y7FQ@mail.gmail.com>
In-Reply-To: <CADkSEUjsT8OW9QVa-U4PQMG+8c1tjjxk7tNJu3U+6yoC82Y7FQ@mail.gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Wed, 4 Feb 2026 01:00:38 -0800
X-Gm-Features: AZwV_QiUBEYt9Z4YPvvCmmjZlvxL9F7JYPI99S5U1hMZ9MhB000fgNB3ionh72c
Message-ID: <CADkSEUhCgkMFrGxJ_ov9MHxF1xakSvb1HJyKisS2LQxPGhgkGQ@mail.gmail.com>
Subject: Re: PCI ID 10ec:8129 is in both 8139too and r8169
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
	TAGGED_FROM(0.00)[bounces-256621-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A9CE2E38AD
X-Rspamd-Action: no action

1186:4302 is also in both r8169 and
drivers/net/ethernet/marvell/skge.c; it is labeled "D-Link DGE-530T
Rev C1" in skge.

I wrote a script to find these ID collisions, but it currently has too
many false positives to be broadly useful. I can share it once that is
fixed, if anyone is interested.

