Return-Path: <netdev+bounces-153134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B94FD9F6F2C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 22:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9119F189105B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 21:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA861FC115;
	Wed, 18 Dec 2024 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="w92Jx+vo"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A9B1FBCBE
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555785; cv=none; b=DBRlaMek/DxWy6ClxrtnBwDqzhmhEgv4kZBsdvxHaKKM8Yi4lhDgG0AaSS9yc7dsr7lTqYXDF/dc7pj8RKXMkbN+1VQVCk943ZczdXJf81E7uNrqV8rrld/9s3cQkqxBw807NR6YoeBWhpdUbcyqCS1kaknGr2TNG2DgyoFSJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555785; c=relaxed/simple;
	bh=KpWK9TK9KDUhAC+sTn1oIy5F2mvKxZ4vquJ/EIWVFKU=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=SviraPWsYa/rC4ug7w0Y4Uxy05YRXjRLNcMOdQXL5n07misSMWRSiTct5l8f3pIawbjwA65kOtcMO/ZxMMe2CruOrzVyqg7xzT/VhxaFmigAjjexaQgXCT0x+LXus7ccx6FQIeYowokbaFdc9lHoldzoUCYB8fYoW7oEiIhF1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=w92Jx+vo; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 4BIL2nSk002455
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 18 Dec 2024 21:02:52 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 4BIL2nSk002455
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1734555773; bh=KpWK9TK9KDUhAC+sTn1oIy5F2mvKxZ4vquJ/EIWVFKU=;
	h=From:Subject:Date:Cc:To:From;
	b=w92Jx+vo21YA4117wwOAgcMxKjf1jmQVYSkE31cGbtuADtPMAcWzTe9CmB3DWtTWk
	 khMcFdx/BNm6dlQRvBvtI7v+jkTpK8p/AlA+iII66mEET8jRvy8h+ahtn/Xj1pV+D8
	 22GFUbW2wDQeiDP5iow0OOQpwtdzbSsFGtO9a30+cdunrvM71I0rjAX+gUPow4hTyD
	 /RKCTOpvAQ94Smublx1wYDtpaKNvOjSzRmdHfl3a/6FXJOP2McGhiJeAVX9XdSiTrX
	 FiW6yH2/Bodpc3XDtiX4QNtr4O3d57eOWTRYp4QXLkgl87o9CGTfveun/7JIdIHtQS
	 q/4crziKXVesQ==
From: Luke Howard <lukeh@padl.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: net: dsa: mv88e6xxx architecture
Message-Id: <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
Date: Thu, 19 Dec 2024 08:02:38 +1100
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Kieran Tyrrell <kieran@sienda.com>, Max Hunter <max@huntershome.org>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3774.600.62)

I am working on TC support for the mv88e6xxx DSA driver. [1]

Two architectural questions.

mv88e6xxx switches support AVB admission control, where frames with AVB =
frame priorities are discarded unless their ATU entry has a flag =
indicating they belong to an AVB stream. This requires knowing the =
intent behind fdb_add() or mdb_add(). One, intrusive, option would be a =
NTF_EXT flag that could be set by the SRP [2] daemon. My current =
approach is a NET_DSA_MV88E6XXX_AVB Kconfig option which assumes all =
static FDB/MDB updates on MQPRIO-enabled ports should have the AVB flag =
set. MQPRIO and CBS are supported without this option, but will fail =
AVB/TSN switch certification (which floods the switch with =E2=80=9CAVB=E2=
=80=9D frames not setup by SRP).

The second question is whether Linux TCs should be mapped to AVB classes =
or to queues. The admission control described above requires dedicated, =
global queues for Class A and B AVB traffic. This effectively imposes a =
mapping between TCs and AVB classes (with a third TC for non-AVB =
traffic). On mv88e6xxx chips with more than 4 TX queues, a mapping =
between TCs and TX queues would provide more flexibility, particularly =
as it would also allow per-port MQPRIO policies (a feature not available =
on the 6352 family).

I think I have made the right set of tradeoffs but clearly there is =
compromise between supporting CBS generally, and supporting AVB/TSN =
properly. Any thoughts would be appreciated. More detail can be found in =
the avb.h comment in [1].

[1] =
https://github.com/PADL/linux/compare/158f238aa69d91ad74e535c73f552bd4b025=
109c...PADL:linux:marvell-fqtss?expand=3D1
[2] 802.1Q Clause 35, also our open source implementation at =
https://github.com/PADL/SwiftMRP=

