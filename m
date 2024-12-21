Return-Path: <netdev+bounces-153950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ACB9FA2C1
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 23:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBFB188C237
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 22:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111351D90D9;
	Sat, 21 Dec 2024 22:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="WCtt7wuN"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4611CCEF7
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734819355; cv=none; b=DSw60xAddekQotMWSaMaE+A4NdxGq49wguKZ4COVLAaDBBR8th3NK8lkB3b6nnQIjuXMc2vO/CETospoZhiadBmPnkIzxDgme3YJP2m5upzEW9/gLU3zY1NMNoILqDhDcB73ihLI9a2g5Af2u44o6+s0YpffjBArvgeeUybMhZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734819355; c=relaxed/simple;
	bh=HrRy69s1GVcMmid8GAdXJqt0Z0Fz16qJ3Fpg6varMLA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aruUTg+PiGPHQQv6r5SK+C8be+LwEgHlHoQ5OSAWGeiW5HJqmnmMGfnfiDugBD0eTPWYTQsI4zuxkhyZuwzfLVt7hzyg3Ytzo1hQJulemOXu6QcIxEfN+wdEWk1neMv5+wAOvl3dOvssDdqcQjQ8Vz9rjSNBCSJ3N15pR7iC3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=WCtt7wuN; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 4BLMFX2t008826
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 21 Dec 2024 22:15:37 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 4BLMFX2t008826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1734819338; bh=HrRy69s1GVcMmid8GAdXJqt0Z0Fz16qJ3Fpg6varMLA=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=WCtt7wuNafq4ChFsZcVmYtgcmUJTE5u5zboEVuKTb1h9lPsrXZRsOenP4JXq2yrLL
	 QSP4mg+UhkxyZ+8binVVP3u0B9JFWqxhX0mIryTGuhRlehUEpN9XfObY8ebIkqUlVy
	 048nc7VU0CNlCU8W0NRNwpByWf1RuCKQ1ZtSlUQp8d76Ku7f7TuZxbkLNvLXb1GnVJ
	 XQB5hySdilbddWJ2aBVWxl6N2fWlzkBH9Vz29Vl8albcSvzkZWczHp3rBhLMjAqWqE
	 UZEE9SJpQJ3kJY2R8/doDAjzVF2zxrgTR6FZzROiXajqd55pV533+kFsN52VtKgS6Z
	 slvEr4eMyCrJg==
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
In-Reply-To: <5bdb17e0-cd7a-44e3-bdd4-d0686ea61b14@lunn.ch>
Date: Sun, 22 Dec 2024 09:15:20 +1100
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
        Kieran Tyrrell <kieran@sienda.com>, Max Hunter <max@huntershome.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C52AE934-0FE9-48C0-A258-F6357E6BBCC2@padl.com>
References: <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
 <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
 <20241220121010.kkvmb2z2dooef5it@skbuf>
 <7E1DC313-33DE-4AA8-AD52-56316C07ABC4@padl.com>
 <fbbd0f33-240f-41c7-bb5f-3cea822c4bf9@lunn.ch>
 <F8AE422A-2A10-4C39-A431-DA6E668797D3@padl.com>
 <5bdb17e0-cd7a-44e3-bdd4-d0686ea61b14@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3818.100.11.1.3)

> Doesn't FDB/MDB imply you have a bridge? What about an isolated port
> which is not a member of a bridge, there is only local traffic?

I don=E2=80=99t believe local traffic is an issue (if it were, I imagine =
one could use cgroups to control which processes could send frames of a =
particular priority). (Kieran, feel free to correct me.)

What I=E2=80=99ve done in the current patch (behind a Kconfig option) is =
to assume that static FDB/MDB entries on MQPRIO ports are for AVB alone. =
But this may be incompatible with IGMP snooping, if that also results in =
the creation of static MDB entires.

Adding MQPRIO/CBS support without this admission control is definitely =
an option and perhaps a good first step, the proviso being that when =
bridging, SRP would not provide a guaranteed bandwidth reservation.=

