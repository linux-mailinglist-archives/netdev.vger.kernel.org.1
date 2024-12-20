Return-Path: <netdev+bounces-153841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4463E9F9CDC
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 23:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95FC116B274
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2682421C19F;
	Fri, 20 Dec 2024 22:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="UqOUF1cW"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16D71A3BAD
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 22:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734735409; cv=none; b=AVabLxb+lU4FsxCjBzKAyhjdtsY9DN5klfsYyZ/Mjb6SRCzWrhE+s2exwj/rX1ZSe6AfrKntvLRLIQLcKGP/ZsmMJkGlXLUaeV4XQLuSyUbuttq1Oryp1+uTHER/G49AQKl+G+g2pGM2e8DIeP6SNdHUyUWlcMCtOC12OgDdsXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734735409; c=relaxed/simple;
	bh=odL6FDhc69ETyHvnddhWAmrCrI+1e+kTTtwatpCyO68=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iyDykG6GPPPJVfjsAQ2eVBBKsHQxRmswJLmn+JbSjaxmDEIRBcBnNJltgIb6ciVkiDzbGlbtaWe6F2iA0O+gArsqf7w0NIwGF8TJwjQgc3btdrGWD0FggjPskZrlpDW+bzaPNZWzlv15lxoFdbxMA6rfjQ5xYFFI2UefBROWEts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=UqOUF1cW; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 4BKMud48029116
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 Dec 2024 22:56:41 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 4BKMud48029116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1734735402; bh=odL6FDhc69ETyHvnddhWAmrCrI+1e+kTTtwatpCyO68=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=UqOUF1cWq0yWgCDRYQE1OBx1r+LV5hzDhhwrWbx7AivmVwwY3IAPcujUyi8WR0Xkn
	 BB/ZGplOYRqvlUdz3L1X051PpuQscfEjkfhkycEzO3F78ewc1z5B30RcuKjV+dev69
	 RA6Xb3za0DMu1nc4bxqU41y7FzoBUMURXvZtWbRl/PUL0Da8rqaez8bamhYwXE/Faw
	 kK5XPpg+I/nK+iNdXYzQD5NQWLpD9gk7I4po4xGtgzzw/I0eczCdfFzDGa1kDHH2oS
	 P2VgCeQaBCx5xeukFy0PzSYqy2IreehFSs4Ky/hGBgl1bBjzyPvf3tPhzsnLy2xz5p
	 ZEVaJM8yK05XA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: net: dsa: mv88e6xxx architecture
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <fbbd0f33-240f-41c7-bb5f-3cea822c4bf9@lunn.ch>
Date: Sat, 21 Dec 2024 09:56:28 +1100
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
        Kieran Tyrrell <kieran@sienda.com>, Max Hunter <max@huntershome.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E12410D-3939-41D7-8DBD-9FB5E3EB446D@padl.com>
References: <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
 <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
 <20241220121010.kkvmb2z2dooef5it@skbuf>
 <7E1DC313-33DE-4AA8-AD52-56316C07ABC4@padl.com>
 <fbbd0f33-240f-41c7-bb5f-3cea822c4bf9@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3818.100.11.1.3)


> For a moment, forget about Marvell. Think about a purely software
> solution, maybe using the Linux bridge, and a collection of e1000e
> cards. Does the same problem exist? How would you solve it?

One could:

* Add (e.g.) TCA_MQPRIO_TC_ENTRY_SRP to indicate the TC is associated =
with a SRP class
* Add (e.g.) NTF_EXT_SRP_MANAGED to indicate the FDB/MDB entry was =
inserted by the SRP daemon

Packets with TCs marked TCA_MQPRIO_TC_ENTRY_SRP to DAs not marked =
NTF_EXT_SRP_MANAGED would be dropped (or deprioritised).

For mv88e6xxx, TCA_MQPRIO_TC_ENTRY_SRP would be supported for =E2=80=9CAVB=
=E2=80=9D traffic classes, and NTF_EXT_SRP_MANAGED would map to =
MV88E6XXX_G1_ATU_DATA_STATE_{UC,MC}_STATIC_AVB_NRL.

Or, we do nothing. As far as I can tell the biggest issue with not =
supporting this is whether the bridge would pass the Avnu test suite. =
That=E2=80=99s not so important to me, but it might be to some other =
users.

Cheers,
Luke=

