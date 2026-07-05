Return-Path: <netdev+bounces-304806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zY/JJeupSmq6FgEAu9opvQ
	(envelope-from <netdev+bounces-304806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 21:00:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A3D70AD52
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 21:00:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tillo.ch header.s=mail202603 header.b=FuVx4NMf;
	dmarc=pass (policy=quarantine) header.from=tillo.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304806-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304806-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C70923001FD9
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 19:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC102DCF46;
	Sun,  5 Jul 2026 19:00:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.mdapi.ch (mail.mdapi.ch [31.3.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D451D258EE9;
	Sun,  5 Jul 2026 19:00:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278053; cv=none; b=qK7f7g4vyzJNvmZ393J5b37maejp1g4veun7ObJhDev2IkODhP04LoSD3DXDguycaZmciJvkPw+8ho9nPkQQbWyS/2dhwWkVNuq9PLO6X9chHdploFvLcmUym/kwuIRj3+Yu3vItgSNZNQ/dSVeSuu/9KiJJOkzSxZEd8gnRkW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278053; c=relaxed/simple;
	bh=rfm6ObRtGhGC71McIxv0Dh1SUwb5GZZE+qEI5IZHJgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kom9PqMxQ2bRUYeiA4GJHm6oLIza5HsMgDSIMTCddAi4h4fWltpkFWgtJgiEANZ77mCwjp5FyV/xbGICzy733tmuigc2CYpgJNN/3WCdYWTeHu3uEXjdjYPx1KIhQFDknDqIsuStjk/CxroOFWVPZ9Y36r1+Ld0nrvYN2WmjrUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch; spf=pass smtp.mailfrom=tillo.ch; dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b=FuVx4NMf; arc=none smtp.client-ip=31.3.128.54
From: Martino Dell'Ambrogio <tillo@tillo.ch>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tillo.ch; s=mail202603;
	t=1783277683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u84a5/yplSHRs4w9tw7UD/LToulfXDxm/OSwiU8t828=;
	b=FuVx4NMfx7lbQYuFlG0rYjOBa+NxHqcDaXt5NlfBRSkO9hIdy6VLSNrPivrVFufAFRa1NM
	W7Vn5ibj5qgI2pbkGlZKOTbdtnNIfy6gnLSgMrRKH7aF5XpKlRUhVSE8QMi1izNphU1Xxx
	/BcDjBgHP8AFMJCE55VSD7rLZPlXy7HrHQJBT23j1Pva+qztz86r+qpqxOT2vm1j3I4rJI
	OpbKYSZekNdqCmkU+LF/injiGVkqF7jt3t76obii7x/LyERlNtMqj3/dPSZHVKOWIT3Xgb
	CTokLvt9Dxv+3IGeY9DVBX5GMW4pHTO7IjO6Kc/STonepbmFR5P+iNoCw59XzA==
To: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Martino Dell'Ambrogio <tillo@tillo.ch>
Subject: [PATCH net-next 0/2] net: sfp: quirk support for XGS-PON ONT sticks with unclean EEPROMs
Date: Sun,  5 Jul 2026 20:54:37 +0200
Message-ID: <20260705185440.136496-1-tillo@tillo.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tillo.ch,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[tillo.ch:s=mail202603];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304806-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,tillo.ch];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:tillo@tillo.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tillo@tillo.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tillo@tillo.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tillo.ch:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tillo.ch:from_mime,tillo.ch:dkim,tillo.ch:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96A3D70AD52

Some clone XGS-PON ONT sticks ship EEPROMs where the vendor PN field is
filled with non-printable garbage past the legitimate string instead of
the SFF-8472 mandated space padding. sfp_strlen() then can't trim the
field, the exact-length check in sfp_match() rejects the quirk entry
before the string comparison runs, and the quirk silently never applies
— so the kernel honors the module's spurious TX_FAULT and eventually
disables it.

Patch 1 adds an opt-in prefix-matching flag to the quirk table so such
modules can still be matched; existing exact-match entries behave
exactly as before. Patch 2 adds the two entries that need it: the
"OEM" XGSPONST2001 and the Fiberstore XGS-SFP-ONT-MACI, both wired to
the existing potron fixup.

Both quirks are in production use on a Bananapi BPI-R4 (MT7988A)
router on an XGS-PON uplink, backported onto 6.12.

Martino Dell'Ambrogio (2):
  net: sfp: allow prefix matching in quirk lookup
  net: sfp: add quirks for OEM XGSPONST2001 and FS XGS-SFP-ONT-MACI

 drivers/net/phy/sfp.c | 37 ++++++++++++++++++++++++++++++++-----
 drivers/net/phy/sfp.h |  1 +
 2 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.47.3


