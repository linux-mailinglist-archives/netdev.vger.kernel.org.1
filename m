Return-Path: <netdev+bounces-298306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UrwMMqgGK2pS1gMAu9opvQ
	(envelope-from <netdev+bounces-298306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:04:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEC9674A93
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:04:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HyTaGrbB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298306-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298306-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BC6E30696F7
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC43411695;
	Thu, 11 Jun 2026 19:04:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71521361DD2
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:04:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204645; cv=pass; b=L1A7B+10WDDw5RyiXpJ8Y9zYwAGsDnwqZHj39YsSZjmT1DAoWY0pijoDYZDUHm2sPlZIzdWnb80V1WhQIiGf3y+sKFJg4sxI8H8KwCvaNxhYmd/TDjr1f/ArVMMo5/z0wInN9WaTK2Li6apdkEMVyyAdajvwQZ74Z8g2ofVf9o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204645; c=relaxed/simple;
	bh=19S4Z4vC2sbHYIBiZdSTw1jPA/UBUrJBzFMcLN2IZa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4ROqnHZSCNSnqTFRgjM0mWmWJUi0N3onPbkr+wMAfngCOAN+9/pLpjeVwa7ePgftDeZekoLIzIaI+xXPcn3exHRMK1kLIyR+UF1Kz0IJhSS7Zooj8NFapVs8DvInanFcm5iu1C8Xln6P1WOGGyUSzjyKwtrvrq1+67uzbvOAyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyTaGrbB; arc=pass smtp.client-ip=209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68acf0a15b3so305871a12.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 12:04:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781204643; cv=none;
        d=google.com; s=arc-20240605;
        b=T8ysQgeRXxNN3+wxvLFwvQkPBr4SrRAS1PiA/TEBLDGtnKNUIPLuhhb8/jno+M5YtU
         RuF0v+76bYsilsKL94yoZyhMYDJ0u88foJwaW9vkh79B/R0lLl4Ql0qgG+Dm5adUCS97
         TFgTM5R/PigaqMUe8eyAARIlyGdwRy4YMvZw8wRFihw5Ixj4d7x35hxIgCIihYgHQAzf
         uPKyyErQFkxrkyYuA5Y14xFcEWoAK9SDDV/hifIxzvwlqTrxay8ABIn+E9ymE3XiLph4
         bufJyUV+GjZ592FZ+PSne7K6gRRNAR64VfeR5SIZiDCOTMz2INqIWnAJhCsNKl+4qmHi
         AMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UP1VjekGuh+xTHsW2iYMlPPlOgcyEofNeKViivDpRIU=;
        fh=Xx6nh8XfEurUZ+QeJDrnH2ADIybQ4mcuGtRjMo/jZMA=;
        b=Hq9lrks/MOS/Aze/zLyWlEZQ4oyLYiDd6/X12tuarMEHfggN56EIvUFwUtkFdex+gh
         lmZBNSomdiEdvK3kvFY2Udse//pn2FExnF0t1zQKOrOJ+Fs/0Iq43jq8mMpfx47MC0ph
         0SQhtzk+xk/GRnhA7VuwNID550QRBe1VT5C/HGnBENwuR5AEaNByudH9WcstKApz+MBv
         65xjMhu/1LU70kHxZUF20yoG8+uGX7Vkb/desynMDoqTluCFj0xmrQgcVuA9VgajGy6j
         +S9jDUwSZOUXyEtPZ18IlcsOz5TJvmlZCfi4i1Eu404Izrra1N11hIxXdgM+Sbxy0gAH
         BxmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781204643; x=1781809443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UP1VjekGuh+xTHsW2iYMlPPlOgcyEofNeKViivDpRIU=;
        b=HyTaGrbB4qhXFbG1VRZDYvP4dKnmxw1rCYSdsaSIG0sB8wd5yIRk/A4H8rFJiSIcKU
         U5KhgiBxdvbEXITM5bhIfNx43l/u9UqCHs4Nj2sHhFMUQIp4yXNTmGfEC855Rqf1X1I2
         dQSGz1rR7DQriu7guvlhnTWQ+0qmscafNJd9qqMD5XrTeDXmkXfYMXNJVcJdS3mMKV8A
         QCvjuOMg/mhZxZJlbwW59kpEF/JcktpI+NUnE9LktCV52dyt4GdBSbME2iqp39clH15d
         3R0rR5i3f+PjZffTIRG7nBvZk7+P8g34zuaQuSDXSIv9eAmdKRZdJxMpR9FAIPmKB9C3
         2rNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781204643; x=1781809443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UP1VjekGuh+xTHsW2iYMlPPlOgcyEofNeKViivDpRIU=;
        b=Fk1YV2zHXzNW1zdFAvJWPx7KiJlPTr5qKJcXfVwQ0yLt/Cy2Dian6fPSSV8i8/mgsH
         8GvXK5pQz6e4rReeq5LMrEwcQXkoToGgAXi4RV+w2wO/oYbQ7kjWoLT5SzWPsERZCAvh
         iPJCw/0zGJX5T1582XtV0oEHoG5j3KL8JmCadsR4cO3NpgLQBH5+ZXlekiJKK47cz19U
         95qa+EOMgWE7Pk0Bz+N2F6HumNH9SNpX88vGyhjBusaKWk9vAlohZlukIRslZzPFKnHT
         rNFKm8cxriz0ab/3RYgOr/YXid+Lo5vwEPELV5V2XI3XbNLmabDB0nIUI94efv3MhrA3
         q98Q==
X-Forwarded-Encrypted: i=1; AFNElJ89R9hgByhaUk4fenA3EE2kBvmTjTlkx4q6n9wDagWG/jxUUgeEaHL2l2DBJSHRrqvmTg2zD8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtO6iCkTpxnZfaXF2UA0qFMEFPh3gimDKJ+QBIK0LjKl8NaIdq
	06sl+PuXleqYiDWnv89z7OTTE5fCbkasdY9FHtE4wsTh6urGz1zIhJIAM+MTdm/yYeYil3qclgT
	ur79/+p7ahQJ+oEAlVv/4aYl62iJsTLA=
X-Gm-Gg: Acq92OHMjovYqGHBM6vbwy/e7Vz8uk5nscE05oY/Ac5jFXg88Sek6UX2j6Upyr4gXbM
	THvkgKfYb3Wm6Zj2CmwA5dU2y5Eqls+sAlvUrWCIGYSSOsSIo8RBR/SGniApeABp4bFZYPdyjBx
	kqR3hcmIb+caYNkjz+SQmTI6h98wRkBpOPl/S0ItH2M9kYmC9caSF9jrlBP0BgP4qqk0WekWyIj
	1gGaggqjbBZsqgSvkZUM6bTVY9mszM6UZZVChBT9aNx9DycfLtru0q4VnaRmt2P15YCnl6FQjGA
	dAVfvUGX
X-Received: by 2002:a17:907:97c5:b0:bf1:1d19:cf98 with SMTP id
 a640c23a62f3a-bfc85d877fcmr247705166b.15.1781204642637; Thu, 11 Jun 2026
 12:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608165546.61347-1-dbgh9129@gmail.com> <20260610083544.0da95356@kernel.org>
 <aioblJqQctA_9U8y@rkannoth-OptiPlex-7090> <20260611104547.22cedb69@kernel.org>
In-Reply-To: <20260611104547.22cedb69@kernel.org>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Thu, 11 Jun 2026 15:03:50 -0400
X-Gm-Features: AVVi8Cfc5DYP663_mt4ABLFqbFe2OyhtD7TOFn-Ilr-hj2Jip2myIXzN8-AmRF0
Message-ID: <CACrCO_UAjAdi3K7y0nHcSDoCXaZnZRCZ46b3u3vdfyWEY1GC9w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] octeontx2-af: Fix PCI device reference leaks
 in debugfs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nshettyj@marvell.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:rkannoth@marvell.com,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nshettyj@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298306-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FEC9674A93

> Oh, that's much better, somehow I assumed that this dance is necessary
> because we are accessing a different PCI device.
>
> Also, since you're actively working upstream and nobody else on the CC
> list responded - should you perhaps be added to maintainers for this
> driver so that you're CCed on patches?  (instead of one of the useless
> ones)

Thank you for reviewing this patch.

If Marvell posts a cleanup patch for this issue, could you please include:
Reported-by: Yuho Choi dbgh9129@gmail.com
or otherwise mention this report?
I will hold off on sending another revision for now.

