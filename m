Return-Path: <netdev+bounces-304372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lX1lDNxaR2pdWwAAu9opvQ
	(envelope-from <netdev+bounces-304372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:46:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A52BF6FF2FF
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:46:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=QfTUVtAa;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304372-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304372-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 827A7303BDD3
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 06:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9443815F7;
	Fri,  3 Jul 2026 06:46:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F138398D;
	Fri,  3 Jul 2026 06:46:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061180; cv=none; b=oHywGkBHOBmN8fUGYcKNboAEFlI5CDJ45m9JMTrD1tIv/ZVupXTbWgtP8EdxU3Hk7e+YTgPtCdqitT5VsqQNrB7KpoWrHPBsdBWIwERFlolX79YHFp5DNXpL0tuPpstfj5UR7bFCjWQO4uY7zVWJDld4saybGJaX/rHojPHVqxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061180; c=relaxed/simple;
	bh=6lFxQ0h9OVxTsgI5bvBbt3kmfE1MGi2yxaDnVrhRRpI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gIs5XuRxb6LjRDbofdX1OBAB8ct/kJSmR/pZxnAVCzwOvZNRBauBsJL8hJ59MS5nKPZpIcOzp0/RQpA+Mp0JmcGdwR3kbU7v85a+fcBAL3ulmLKdWSthdvVv0MtX4mdv+Yr9p2vaEt4bCkMHC2UCtxX46fuTFsNgsvVS4ksDuB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=QfTUVtAa; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 2412C60C1E;
	Fri,  3 Jul 2026 02:46:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783061177; bh=nyhGbijbZrs3Zozee4fmjBVYlju+40VlE9rXtEOwt0M=;
	h=From:Subject:Date:To:Cc:From;
	b=QfTUVtAaLdgron8yzlIo6C5JYdhxQ+eOMVGEQfRERodzaAxdEcmuB2VMzww8I0odS
	 /0MSOh2xim9zETt4WVr/4d54/5J97E5KKdnHYskOVrhuxochrEQlevZkhVi9vX/Nvx
	 LYQ1zOnJMTp3xDafBvFSN0cGVUjHAbYh1g5WvLf1Zyfcl2I7lnkmjUvQkxIg9p41Ij
	 ll34N9RXWcxzTf0GRsAyeMQqQn1dEcEeio+kSL8W7eyHIHTptTcLKPWEEdbO+v2j5u
	 2vtftu+usLnGYesDXlysDFvMGNbTuBB0P8iFn4IO5gfVfJEhEAf0OJI4+ldof2ajBW
	 HTfUpvGXeUbNw==
From: Luke Howard <lukeh@padl.com>
Subject: [PATCH net-next 0/2] net: dsa: mv88e6xxx: add support for DCB DSCP
 config
Date: Fri, 03 Jul 2026 16:46:05 +1000
Message-Id: <20260703-mv88e6xxx-dscp-prio-map-v1-0-250e0ebcce83@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALBaR2oC/22Oy27DIBBFf8ViXSTexvxKlQXgoaWSbQrEQory7
 yGJU2XR5dXMOfdeUIEcoSAzXFCGPZa4rT3QjwH5b7t+AY5zz4gRpogiI152rUG11vBcfMIpxw0
 vNmEWQMzaEUsnjzqdMoTYHuZPtELFK7SKTs9LObsf8PUuPn4z/J57eT2Av24zPJoFJ/gleZvgX
 cGMMkrV5K1V2uwjel9+0Irw/+j02i9HyTo/Tkw5s9O7wtkC2G/LEqsZuHUOOGGcCkEDDc5xTiR
 MWgovleVCSWKD5Oh0vd4AYVUnFlIBAAA=
X-Change-ID: 20260607-mv88e6xxx-dscp-prio-map-2fe4d8b0a19c
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783061173; l=1206;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=6lFxQ0h9OVxTsgI5bvBbt3kmfE1MGi2yxaDnVrhRRpI=;
 b=AkOLm/uWa+RPzTEnE2pOo2TLtAGIbjlG0BFrjyio3/QL8uHGL8Pkp1sUZiB8kY6+3EPVpFpLQ
 NU7MLqZh6MTDdPoLCUsAe8Z2qcIEndp+7b01cvLk1YBQQBbzsWGt/HJ
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304372-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A52BF6FF2FF

Add the DCB DSCP and apptrust applications for configuring DSCP to
queue mappings.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
Luke Howard (2):
      net: dsa: mv88e6xxx: add support for DCB DSCP app
      net: dsa: mv88e6xxx: add support for DCB apptrust app

 drivers/net/dsa/mv88e6xxx/chip.c    |   8 +
 drivers/net/dsa/mv88e6xxx/chip.h    |  20 ++
 drivers/net/dsa/mv88e6xxx/dcb.c     | 406 ++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/dcb.h     |  11 +
 drivers/net/dsa/mv88e6xxx/global1.h |   8 +
 drivers/net/dsa/mv88e6xxx/port.h    |  10 +
 6 files changed, 463 insertions(+)
---
base-commit: 3abbe30231441f1fbb3305e9854c56a34650af53
change-id: 20260607-mv88e6xxx-dscp-prio-map-2fe4d8b0a19c
prerequisite-change-id: 20260430-net-next-mv88e6xxx-cbs-2121169caa68:v7
prerequisite-patch-id: 8ad59c43368d4639e0cabcc59a7f6e487560d3f7
prerequisite-patch-id: 22f1cda311b1826bd4151fc7d4cdf3d87ca519ed
prerequisite-change-id: 20260603-net-next-mv88e6xxx-pcp-prio-5752caa7926b:v1
prerequisite-patch-id: f324a0334ef91256d6f09562d978e9d6c32b7f3c
prerequisite-patch-id: 79c2b056ae68846b5e2950b9738cb83e73d2710e

Best regards,
--  
Luke Howard <lukeh@padl.com>


