Return-Path: <netdev+bounces-304368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e6MtFCZaR2rRWgAAu9opvQ
	(envelope-from <netdev+bounces-304368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:43:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 605E26FF294
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:43:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=FgEZoZsK;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304368-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304368-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CAC93025719
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 06:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E1D381AE2;
	Fri,  3 Jul 2026 06:43:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A530E37D10C;
	Fri,  3 Jul 2026 06:43:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060988; cv=none; b=KLojbzzQH2d7p5SmdoO4+U0nNIUKzDPZuj0+lexf7/HbV9Z/mBO+U6Fd1jRGndBbLTdEk5Mel4XJhHdWZ3g+409Y0ixZjIwKi+pK+9hUiwBvgL7o9vBtk5mqYaXDU1Jytv17JMDmlr1VbnNJPKcdRZNXPLFrpOkyrdYigyN6CtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060988; c=relaxed/simple;
	bh=us8prmEOIad7VIMkKHfj/er42U0bOWHz+wituEJPpW4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=km0kgRqIGUIp7gCKUCfpsA7ZWgjMbp+VP5UuepdW5xB9oeJuudyw8WBnfuFzikUApO3sa1Fda4Nn95pv1IZ+ERnZmn2rMb7CzuFVcpl0F+eEnssPaenqS0PQUbD3eCF4W9YrcnHb1y+d3UTs9BzgUvWc1eRuQVlE4KZWCc7H9MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=FgEZoZsK; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id C174A60C1E;
	Fri,  3 Jul 2026 02:43:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783060985; bh=nv9Qn/ehXPl8LyFJp8fd7fa2AOm1J6fKxlTJ+roDuOs=;
	h=From:Subject:Date:To:Cc:From;
	b=FgEZoZsKQkjRPBWskchnhxSGe6ZgsX7bQanGBraBbVGhgtf6C+EnUl1L5S7lTWDSJ
	 kaCMSsGx45zuVgh2v9ORRKgKjaug4Bk4QRZAC+2j6RmiWPQCotUmUBlFsN0VXHEmRj
	 uOjLzjc+ydiS1j0PFjuNjF34xl6G5cIKOBMhnUf13SzSYsrbn7IkvOVkSdTe1Jse9r
	 PgH6OuMiyQlBS5SqgjKzN3bVJXy2VbzGpMTVHb2TYoRVluSuLWJG/5I+9lpyBAQbQT
	 6zMTcgofR+MvWwZizV0gTwVl2B1ZLnVus5oM15gq5ER+tbt1XqdDUa/p5auiHX4S2G
	 abEpAnKqE5IPw==
From: Luke Howard <lukeh@padl.com>
Subject: [PATCH net-next 0/2] net: dsa: mv88e6xxx: 6141/6341 workarounds
Date: Fri, 03 Jul 2026 16:42:54 +1000
Message-Id: <20260703-mv88e6x41-fixes-v1-0-fbd3a1bf8965@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO5ZR2oC/yWMwQrCMBAFf6Xs2YU2pCH1V8SDTV91C0bJpiVQ+
 u9GPQ7DzE6KJFA6NzslbKLyihW6U0PhcYt3sEyVybTGtc5Yfm7ewxXb8SwFypMN3s5D32MMVKt
 3wk/U6EIRmSNKpuvf6DouCPk7pOP4AG0DzYx9AAAA
X-Change-ID: 20260624-mv88e6x41-fixes-d4c84f955ebc
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783060981; l=1144;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=us8prmEOIad7VIMkKHfj/er42U0bOWHz+wituEJPpW4=;
 b=9yCgmXf+Yqkqc2Mwl8EFwdmzzu1QdkG6YmiRwRn4PUuzl9kQLPMcgilGFi6wvgiel0bzqItRz
 OYkwCVjTgARB4XIu4GARqhqCX2uXapgMdb9q2gllV5ZiIO3hlLjH/5W
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304368-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 605E26FF294

This patch series addresses two issues I found with the 88E6341
switch, which likely also apply to the 88E6141 (which is the same
chip without AVB/TSN support).

The first was a genuine bug, which assumed the chip did not have
a dedicated ATU FID register (it does).

The other is an issue I noticed with hash collisions in the ATU.
I would appreciate some external testing before this commit is
reviewed, but I am including it as it was necessary for reliable
operation with multiple FIDs.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
Luke Howard (2):
      net: dsa: mv88e6xxx: write the ATU FID register on 88E6141/88E6341
      net: dsa: mv88e6xxx: use direct ATU hash on 88E6141/6341

 drivers/net/dsa/mv88e6xxx/chip.c        | 14 ++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h        |  1 +
 drivers/net/dsa/mv88e6xxx/global1.h     |  6 +++++-
 drivers/net/dsa/mv88e6xxx/global1_atu.c |  4 ++--
 4 files changed, 22 insertions(+), 3 deletions(-)
---
base-commit: 1c664ec4b9ea827b609d296921ed5bad8a40a158
change-id: 20260624-mv88e6x41-fixes-d4c84f955ebc

Best regards,
--  
Luke Howard <lukeh@padl.com>


