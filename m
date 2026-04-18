Return-Path: <netdev+bounces-279484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ3NBKZO42n0EgEAu9opvQ
	(envelope-from <netdev+bounces-279484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 11:28:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBB4420916
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 11:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00021301112E
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8077C342539;
	Sat, 18 Apr 2026 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="NRnEh3Vd"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625B0278156
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776504479; cv=none; b=Qfw18M6rzfkQbWyVV5Eii15nt/LNzm62vbdnig+/JnBDOOiAK5bHx/cM+YRWZiBBEjE5c7vnc6QQfI3yt1/BzB5q7cLpzMbL9YBZknezPyF8a4OMQYC8vU37CC0nMF+0uUQKs4Ka66FyMyumrpIH7C9gOpROnDwBh3K/psLtQ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776504479; c=relaxed/simple;
	bh=9nWKYdcX6HTN7OzBmQheYehNic+2ATuAJCinIe3KyI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=swIxRZUtBv/OGZstnrry7oafFMx5eXjUX0/2VbF43wMwJ6WjjzECOvZ3BlDMHy6U9PIvJhACx4m3vKmjAEUAU57Gea0fRwVjmrOJdzJv749KaJnrWqWntOesyM6+uDBdD7bgPU+r+bTzX2zUTDL9RnoXTi8XNPVHHGkeK0xIyqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=NRnEh3Vd; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1776504462; x=1777109262;
	i=markus.stockhausen@gmx.de;
	bh=MxAyFR8DzHiTOLcILNJXnBI3RznatIg9tnnjxwrC654=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NRnEh3VdMY5JUXt8Arz49BoWmpiMgUmGR9P8NQRcId8IwhYwuR4EQPat9nw+lbnQ
	 LG5QNQX6ZXVll/hltTKuWHPaDU5Lmv5pn/2lSUMV3JrSn5Z25vL1IlJLhuv9SbNaI
	 4lemyY6JxW/zVEYC11sxUrDmWynW95Pw+jLXdfVoOHWbyf+zrMHDWuitEHCsF941h
	 ORC0dg7ejsVQSHlMTv4tc+gquXnQu8A9+sB/553ZYZzI7oNsCL5q2RmwBspyVXCML
	 aG96UV3zvF50OSz9M+22glVF9TWZsFITMgPdVtXr+WhIvkHBt2eWfozC9GFEAQSNz
	 ccL5aHRU/GuUqs3UYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpOT-1vlIv90Gt7-00icmT; Sat, 18
 Apr 2026 11:27:42 +0200
From: <markus.stockhausen@gmx.de>
To: <linux@armlinux.org.uk>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<netdev@vger.kernel.org>
Cc: "'Jonas Jelonek'" <jelonek.jonas@gmail.com>,
	<jan@3e8.eu>
Subject: pre-boot plugged SFP autoneg advertisement 
Date: Sat, 18 Apr 2026 11:27:40 +0200
Message-ID: <007c01dccf15$9b4622c0$d1d26840$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdzPFPux4I/AJTntQSeVX3c7ZkApDw==
Content-Language: de
X-Provags-ID: V03:K1:IhzgNz/PDgC/otTknhHoJbOU1cO6VxWO7FaamQKbmJyi7E6VFi0
 8whYtEmPq0ZehlOXrduhsy4z5R4/A2y2YmPZAV7HSI5OqMn0qtvOg6TjkJhG9H82tNKKUyX
 wZJh4sP0VXix3WpV8u6ZLgf7XM6hNLEM2Ud4U0x3lByg6q9IxLw4D6Aza61NqXp3FCqxxTM
 bVYuz4480G4Rroygf36mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3iSH6hmII6M=;n7ptKsBjt5c7oZ5FYSkxBxQ6Nzz
 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
 tulLCK5oqb0g7otweTtcRrZGhVjwMn1hw==
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_SPACES(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-279484-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmx.de];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,3e8.eu];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:dkim,gmx.de:mid]
X-Rspamd-Queue-Id: 6DBB4420916
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I'm currently analyzing an issue where a pre-boot-plugged SFP module=20
comes up with autoneg=3Dno advertisement during boot. After an
unplug/replug autoneg=3Dyes advertisement is chosen.=20

The following addition in phylink_start() just before the call to
phylink_mac_initial_config() mitigiates this.

+  /* If an SFP module was already present before phylink_start() was
+   * called, phylink_sfp_set_config() was unable to call
+   * phylink_mac_initial_config() as phylink was not yet started.
+   * Ensure the SFP capabilities are reflected in advertising.
+   */
+  if (pl->sfp_bus && !linkmode_empty(pl->sfp_support))
+    linkmode_copy(pl->link_config.advertising, pl->sfp_support);

Remark! This is about the OpenWrt Realtek Switch ecosystem with=20
kernel 6.18 where we are working hard to get hardware up and=20
running. We still rely heavily on pcs/dsa downstream drivers. So=20
I'm unsure if my observation/idea regarding upstream phylink is=20
right.

Thanks for your feedback in advance.

Markus


