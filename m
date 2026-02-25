Return-Path: <netdev+bounces-260792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPlsNK2znmnZWwQAu9opvQ
	(envelope-from <netdev+bounces-260792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:32:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 76954194465
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0E643015D89
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF4C31B839;
	Wed, 25 Feb 2026 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGS2ZSu/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75A7315D33
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772008362; cv=pass; b=mHMPhLR+3G/QmKh2jLUAtONWfBR2h+luDBw1CRJIOpoHK8ptz4/oZwkHIlrEoG1g8Zs7zKpKTpa7t5z8U4LPFOZBDtB7W22WfIJ+0UXIaiNwQdDXvuDAmK48fgCQr0DbSkLHn62t+zywlGJTCMv5LKEPeEoB2q+mdVIvkBuxWXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772008362; c=relaxed/simple;
	bh=j1XDmOFF9ikLIHIw8UOC65mfDZU8nF4o3uQ12APFwhw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RCyZV8Cg6ic08qK1rS2IkFvaL5qImI91PRbFrcdGQ/7ylT26Qcu4wrXxxWdhVlGmKCAOsSFxybGuBGEwlv/RIECG+V3B4F9XZSMgVQUaEvpbISQLsQZySOm3tEB+4BCnf/Dh/bB8agmLrxXMeuGQQ9+kRKAKsq1PJXaINEqlMNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGS2ZSu/; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bdb17511aaso1869725eec.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 00:32:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772008360; cv=none;
        d=google.com; s=arc-20240605;
        b=arLqyPFcb213IA/HRmQtWCExWniltB6NynDF80Ht6DXsAjcz2tqhDY8YgzqCz4+dDY
         4sFgl+103CZNOqpZ/VIFc+tKeKgPeED2FnX9/uQrurYHC1cpTqZLgy+3lSIORrNY4kzd
         By1QQWnDK8FkphRbcWNEU5tGFgieAyf8eLqPANdeYzAjMFmsrASd9Obm4AZtpcdg6TRJ
         lCVPLoZhEbRdVB2vouXa1N0jtRP3qfaj8TxBWJGAJfHAObU2NRAidrljlsOZyAXCRp7V
         xAliz8A/QtAbRAEpN1t+2x7GKM692zDQET+YCrsxfO1XkhC4ZuQp0KOleQ9DGjwVkSAy
         ooDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=j1XDmOFF9ikLIHIw8UOC65mfDZU8nF4o3uQ12APFwhw=;
        fh=aDUZZ9N6NPmO6DMPx8G1ADwl9DVnQFUvUJ2oivftvxg=;
        b=O1c0IZzQmFsRDX48TV9Ir8UQ5OAtSXUmPHjq4RZjMh0IhWL77cSCpJIjHetbYYL/o+
         ipilRj036aKKn5ante2yL/mz5DioQ3sN1XJag/YL6bVIKsitC34PP+esR5ST9pefKqfe
         i+RVtBQukTW4fjFLDA2NOk5IWNfAx7uhQLouSxQzxAPsRazW+9EiKZOsk+ddTQWmFEyA
         rajDGw0hh4TNElUuUEHHGHQY/eEfInnaQVcZyNbUYfhTHP+9SM2+QHzptsPFfauUwmXY
         7QU+wG6SYkYc91UUUuh+uHglDsJ4ifoKY/0L7+Wjy5Ljs96NUY4zGNR+3xfEXO6pY94K
         g7/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772008360; x=1772613160; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j1XDmOFF9ikLIHIw8UOC65mfDZU8nF4o3uQ12APFwhw=;
        b=EGS2ZSu/dbx947UHtrB5yzB+j9326+Jm0MzQJZHrxlYuA/ZNNBr/opB0LqCk2DBmXy
         EnCMOBZd0ptiuOI56A+cc119iDkdzzaJ25g4LF2veHEGtgkP0Kl96trdW5HMvka3I6aq
         w2Q+SwZWtAlodgvOURYnh2FaK7cquzPaXAncX2kDvXT1j8OyKgRjFdFNRHxpamMqgGq8
         vFXEDT3ecqNmcqGewDucJxC3lpAHc2gXs6XehVcxhZzbCR63WCiLXXVTDy7q9oKT1NV/
         Z30M7MJRdGYejrLmVArusPRdwC+NAdkSxXNuSFmunT07is01GhTf7w/nK0k+oM2v0UXu
         pN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772008360; x=1772613160;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1XDmOFF9ikLIHIw8UOC65mfDZU8nF4o3uQ12APFwhw=;
        b=jx9s9srNq1k8hV8Xk6wSLxkSbpojH4q6Vekc546nrRu5i/xBHy++Hgc8U1DZSchlcH
         tAQ5mX+T6VwLE53jciO+RuYCtcsRx3zhW/7uwpVHvb27tiGQ/x6xVXkbZatH4+YQ4zc/
         /en3U5x20ixbD6EPnCPeRqgHDqxWDHroNJTZuFTtKIP38X3XUamJyhuyTduU9N4EfqZI
         xbz3hMOVOjyPeMZJ6JGlwSWw1CBZ2xFsCk2/p2xLSkqHaaVWHct30ZuRk7xp1gSlkL32
         J/6vRc0XESFnC/AHQzeSdykwnwN0LmEe2fg+1g2ammn/+rKp15cACPMGZ5fBIWdrp9ES
         tuAA==
X-Gm-Message-State: AOJu0YztXMG4my84LpNLIN/2N1KIBFOdyLyEK+uUhqf1+v7xnRvd6nEW
	go7jEIeSAlB22XQ5RNsM+i640YP8x7B7Rnk/siwXdOY01O7DenCu3ZOxIP9D4Labj4pvwWekmM1
	DUjJinBjzFYYCq1JmmsL+IcTVmPeDo6TqryqR
X-Gm-Gg: ATEYQzwLb7x/z5nlOWqgEK9snRv7ConlPoAjcmz1AjCCQl7gsbd9JgS3/u5YWUtq0Y1
	I8AnVtZtUJvUYCpM0ukXALIqIOVb9nhKz+sK56ulFlGyMmhF3KzN9ATg4P0ed38bVMthSJG1DD0
	rQPzqRhFBJZDR+Kol5LykgtXbK52rxVAQSKndSmW7IjJJdNXPZSWUxasDuLnsxhtJEhdL87C1z+
	/17QViy/fBxa+SQ1y0l40t7sUDQ713kUVUiA2cAhH1dU2uEOqSxVJzucQ5G/dqaTSwyGVsFAtRz
	polQnd2tIdbmF2jPAGCKOJLnaq11LCK03BZcVlByw7omJJEMd28w8CgKZci5eEvyl1M=
X-Received: by 2002:a05:7300:d4cb:b0:2ba:a3c5:ccd with SMTP id
 5a478bee46e88-2bd7bd7162cmr5712863eec.37.1772008359742; Wed, 25 Feb 2026
 00:32:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Patryk <pbiel7@gmail.com>
Date: Wed, 25 Feb 2026 09:32:28 +0100
X-Gm-Features: AaiRm520FyidZTc_8ReftC7rg60pv0xElcTnBLRnDGOJ5M2FiQy94KW00QeURAA
Message-ID: <CA+DkFDaW_wJ5p9_P7pMpz-8iE6xeKkdF-MQcd2m2GcyVUE3S4Q@mail.gmail.com>
Subject: 10G-QXGMII phy no autonegotiation on LS1028A
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260792-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbiel7@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76954194465
X-Rspamd-Action: no action

Hello, I've been trying to bring-up the 10G-QXGMII PHY on LS1028A
based board and I have some problems. I guess that they come from the
fact that I do not see the whole picture as this is the second phy
I've been working on (actually the first one that uses serdes, the
previous one was connected through RGMII). Anyway I decided to send
this mail and post some of my questions hoping someone will find some
time to steer a newbie in the right direction.

The phy I've been using, once started, autoconfigures to 10G-QXGMII
mode with auto negotiation enabled. It detects the link partner
abilities and completes the autoneg process (at least on the line
side). I think we can assume it works as expected. From the SoC side,
as I understand the crucial part is pcs-lynx implementation. It
configures the USXGMII mode, checks the state, reads the link partner
ability that is carried "in-band". and so on. In the device tree I
configure my phy to use mode="in-band-status".

The problem is as follows - the pcs-lynx correctly detect the USXGII
link however does not detect the link partner ability thus, the link
never becomes functional. It looks like the autonegotiation on the SoC
side does not work at all. I browsed through the pcs-lynx sources,
looking at the LS1028A reference manual, and I've found that Serdes
module on this SoC features some MDIO devices, whereas one of them is
"QXGMII USXGMII Replicator" (LS1028ARM 29.6 MDIO register spaces for
anyone interested). I checked this device and it features the Control
Register, which contains the Auto_Negotiation_Enable bit that is never
set by the pcs-lynx driver. I patched the driver (just out of
curiosity) and in lynx_pcs_config_usxgmii I added code that sets this
bit. Somehow after this change the autoneg state machine kicked-in and
pcs-lynx was able to detect the link partner abilities, the negotiated
speed and make the link functional. I was even able to exchange some
information through this link - ping, scp file.

But this is ofc - in my opinion - not the solution, as I just can't
believe that someone just forgot to set this bit in the pcs-lynx
driver, I guess that the real solution is somewhere else. If this bit
is not set in the driver then what makes the autoneg process enabled?
I'm wondering if perhaps someone here has done something like this
before and would like to share some hints on how to approach this? The
second question I have - I mentioned that I was able to establish
communication with the link partner, however there were some errors
especially while sending bigger packets, e.g. sending ping -s 20 ended
up with 100% success rate, however ping -s 300 ended with ~50% success
rate. I'm wondering how big of an impact on the communication quality
has the fact that the PHY I've been using is connected through the
connector, not directly soldered on the PCB? It's just my feeling -
but if I were to guess I would say that in the case of 10G QXGMII it
may be significant, but I'm not that experienced to be sure of this
statement.

Best regards
Patryk

