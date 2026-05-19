Return-Path: <netdev+bounces-289240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M4PM7q9C2rBLwUAu9opvQ
	(envelope-from <netdev+bounces-289240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:32:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 772A457617F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CC1030167B9
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFB62BCF46;
	Tue, 19 May 2026 01:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpjomkDf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12FD1DF751
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154360; cv=pass; b=T5nNx8pIB1mmo3e8rBedj1O30QN6aAFxhuLvMWc5bcbxEz1mFdmPvTSqi/z4T9OY6DDsFEkQWj8IxijHT3t5OX8ENa6k6tPeKbQW4QBubYoKVGiKcdq8ZIuYOyTQF0wIcjaNVMD+UzuP9aeRJk+J2DDfoslebeRmLrdqvMOxO64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154360; c=relaxed/simple;
	bh=CXi7UxLtcJ5TyVxKRS+hkUYEbmjcbpX1Ukueu5YWL+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6a7cTKTwFYBpF5/E38baVhoxueeovBqqdBFZy1JxFIAqjWVoMBv9O7qq5BdT1wVwDYzqKV5NZ0Q5QWR+aEHQtUIcZuc7ybKDSR1OsREV0U3gD4G7yyw5CMIIp5UUzfOo7f85tJC1wU5oY0wyANVl2zbcA1WzJhR9LmalKypqQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpjomkDf; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8b4000e51fdso34076336d6.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 18:32:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779154358; cv=none;
        d=google.com; s=arc-20240605;
        b=jeoZJzisBRu/DiQ2pBiFfGDK4XML3oPB/Br6KH04MJUJXNHGiHZdQCe/NfCmHZZJgA
         SSBTIp2k8NAVavLThdXTkkSXd108A0Y+9eNHMPfKzPYNqZDZhx62XgFg19XmN3Ex+96W
         IK1Otz21vr11SNvpzhD44o1OjHnNnjUM3SSi8vbLN+GzOziqK+a5XRdRhDEbvWLMu/qe
         Y/T36Pcr4wVCtMrx/h6BJNshgPd+5vvGq9roj9rJfl17smtGnY6g2KNFUqMEUsACofxD
         uxGIYcIR8yIWn155CbWWYIi3MEQksXyaGlkucEvEHapbpJQTOCKEja2zHTm7ci0iRlA4
         mzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ja/CV5fv5UnqqWR8UixOkds2Qx2OdDYxCo/m/q65Ga0=;
        fh=qJZK21Loqz0q1QQaM1/72+iIpgq3IsovaDi+jX9o12M=;
        b=KQfOOimUN2Jk32K1U8jamfOa0aAvqH8ezCP/orgfpPBwb7vBBhLQlvGJtkJ4btDGrI
         6uA8jVwZY+bouKQjcin4ElOZFWtBM+rkxoBm8NEi83XmlPnbA2fDoNzFt7Sb1MoUgdtL
         E1/X28rN2G8FXAuhWrw75u+PvCyCoX26/ybyPknJLof7CoHyVn4l1pzDgugMHb+L7/af
         0EBvVHHRCEpDRXz9d0l9EkiTDdlEQD6QBBE+uZg7W99nrtLT+45JAhK8y8wxanDFaR3W
         g16VJh0MEdRWaI4C86eF8nwz045EeGG7+wH3po1bSN4nitKwlgNgXXah0sCvn8RPK7l4
         NJow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779154358; x=1779759158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja/CV5fv5UnqqWR8UixOkds2Qx2OdDYxCo/m/q65Ga0=;
        b=XpjomkDfeXrhJOihW0xzMSkmNTwXHslAXcOxApb4+x6KJV++Z+T1GnIfMEOZcHTTeD
         +9ouMYCUGk/BpbFT9QKBbcVQORHMmoGB83vXNO9jOMmqeewddcncFzutSzlO3ZQv0zSJ
         Wt8G93XicZtixyBdOuJ6AsZg3Ub6icbFa6ngSczx+LYVIm28avjOFdN1uRVzHFAB3hKm
         bNRyHgEv04r1xjIRQHyh3QuzuloZvfvw+yIW9uU+eBynNMBlvFCJUdBzvZ68Xt0iLxrt
         weO4u+gCCO5TKlufsWPVQCUb2RWXRHsoOuFvS+XgvFTrULVG6308RrWOPuNrRHtZRDVe
         CEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779154358; x=1779759158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ja/CV5fv5UnqqWR8UixOkds2Qx2OdDYxCo/m/q65Ga0=;
        b=B9WVfIgTWH+J5rulUphxb0SkaWZx+g6KK6ag8fEbyqdodYyyloMm6z3B+swTQ+GcUA
         wwH1SCiETOdEzvj3JyqcKmMHDB5tjzJjnn9W/yNHiInh3v5DFajCv11Mu0ukWiz8oQBV
         G8I7JT3kf7uLLlAL44X6GjuUJ8hMmMeVxYcp4cH7rQWNSImO/+nUdoTpADq9qBKcrvhD
         GkZkRQyHo23+R2wNhU4YO2O/gYf0pR9ng2EUyKEyTFlqo+G4euIroYrc30FBstjkwPvf
         e8Ff9vt03xe2Rqem0jQSY/BtngA15JdLrI5Lj0G/d0m97ZdVIiYcRq+6EStYHqm31im6
         jiVA==
X-Gm-Message-State: AOJu0YzrieE5QBiJe5altLSAUctqj/3li78p0Zw01nAUBSQUyUwEN+5N
	DduV/7M5tpp3k0w9FDhV2uAp+ABaHR9RPD3R+31pJ0prlDihHs5lH4ceSYwu+e/XbHTKVSVzLnT
	uebOXJzTvsuFHnGsvQoh+fGT6Mxn1gHFyd004BSk=
X-Gm-Gg: Acq92OG4pW4/l/psmApNH6zRvn6Veyp8siwXtgMqVktmusCt2+9uAilQRwfSkwblqzH
	m3QFo/O6ytqHUkcdbYClojrbj+pSdspl+RuyzpFQwY1SOo/qF2MRGM/iDmnhvqPVUQpGfRd74fA
	aFrjZX+mXfCO+B4jtO0aNN9a+cOR6h7d9xs121RjNQ9k4IBCH6mVX3/TcaB1BVhd0TzsN75j77A
	xyOIW4doq1og8Qca6FRgVPzWJBG+KCK0AnKqQ+fqLbojaM62ySNQPl9NexIQLSj4NPnvMAQOaqI
	Q7Ku52WklJtaULe6hwYS/f+ZCF1KVmnlZ4ZfScsEf25mWY4js8UrMiHqvxqMGpFIrtlEmOaS17E
	GjPE=
X-Received: by 2002:a05:6214:487:b0:8ae:60c4:857 with SMTP id
 6a1803df08f44-8ca0f610e18mr270704626d6.18.1779154357667; Mon, 18 May 2026
 18:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518010739.80979-1-enelsonmoore@gmail.com> <20260518010739.80979-2-enelsonmoore@gmail.com>
In-Reply-To: <20260518010739.80979-2-enelsonmoore@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 18 May 2026 18:32:26 -0700
X-Gm-Features: AVHnY4LWd6NskGG_YZi6KRPvzMxeGyTVfq2DCXyiAR5zRUPqHTbk49wxj1zjpGo
Message-ID: <CADkSEUgs0k9eHS2_wAiEnu5PVpc+RiMcfXiF0y=wkh7rYbGouA@mail.gmail.com>
Subject: [PATCH RESEND 0/7] ARCnet: remove outdated drivers and information
 and unused code; small cleanups and documentation improvements
To: netdev@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289240-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 772A457617F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[This is the cover letter for this previously submitted series - it
didn't get sent correctly the first time.]

This patch series mainly removes the ISA and PCMCIA ARCnet drivers and
documentation for them and hardware they supported. While ARCnet is still used
in industrial environments, and cards are still manufactured, it is unlikely
anyone is still using it with ISA and PCMCIA cards. Removing these drivers
reduces future maintenance burden.

While updating the ARCnet documentation to remove references to the removed
drivers, I noticed that it contained thousands of lines of outdated and
irrelevant information (much of it so outdated that it would not even work on
modern kernels). I took the opportunity to remove this information and improve
the writing style slightly.

I noticed that the BUS_ALIGN macro was always defined to 1, which meant that the
custom arcnet_in/out/read/write* I/O macros were unnecessary. I expanded and
removed them to make the code more straightforwards.

I also corrected some typos and comments.

The first three patches are the same as those I posted on February 8th:
https://lore.kernel.org/all/20260209030649.54779-1-enelsonmoore@gmail.com/
https://lore.kernel.org/all/20260209033604.60033-1-enelsonmoore@gmail.com/
https://lore.kernel.org/all/20260209025442.50987-1-enelsonmoore@gmail.com/

Ethan Nelson-Moore (7):
  net: arcnet: com20020: remove misleading references to multicast
  net: arcnet: fix typos in comments
  net: arcnet: remove code depending on nonexistent config option
  net: arcnet: expand unnecessary I/O abstraction macros
  net: arcnet: remove ISA and PCMCIA support; modernize documentation
  docs: net: arcnet: remove outdated/irrelevant information; improve
    style
  net: arcnet: com20020-pci: avoid -Wformat-truncation warning

 .../admin-guide/kernel-parameters.txt         |   14 -
 Documentation/networking/arcnet-hardware.rst  | 2979 +----------------
 Documentation/networking/arcnet.rst           |  235 +-
 arch/mips/configs/mtx1_defconfig              |    4 -
 drivers/net/arcnet/Kconfig                    |   52 +-
 drivers/net/arcnet/Makefile                   |    5 -
 drivers/net/arcnet/arc-rimi.c                 |  386 ---
 drivers/net/arcnet/arcdevice.h                |   36 +-
 drivers/net/arcnet/com20020-isa.c             |  230 --
 drivers/net/arcnet/com20020-pci.c             |    9 +-
 drivers/net/arcnet/com20020.c                 |  107 +-
 drivers/net/arcnet/com20020.h                 |    6 +-
 drivers/net/arcnet/com20020_cs.c              |  330 --
 drivers/net/arcnet/com90io.c                  |  427 ---
 drivers/net/arcnet/com90xx.c                  |  716 ----
 drivers/net/arcnet/rfc1201.c                  |    2 +-
 16 files changed, 125 insertions(+), 5413 deletions(-)
 delete mode 100644 drivers/net/arcnet/arc-rimi.c
 delete mode 100644 drivers/net/arcnet/com20020-isa.c
 delete mode 100644 drivers/net/arcnet/com20020_cs.c
 delete mode 100644 drivers/net/arcnet/com90io.c
 delete mode 100644 drivers/net/arcnet/com90xx.c

--
2.43.0

