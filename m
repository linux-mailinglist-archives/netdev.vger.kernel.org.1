Return-Path: <netdev+bounces-225519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3E3B9501D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984B2188CF9A
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E32531A042;
	Tue, 23 Sep 2025 08:33:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7217331BCA3
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616410; cv=none; b=SJJuZy3d2m7RJT0q7flKpAXCnMnKg3oy/VFrtOzB/nkgu+1mSouOVwzA73bFd9eIFXXah+Y4r9p3hxwtLesEhpi4WPUt+zWkVoFhORcwE7YYbYqTXGpeus2JmbgxNOiurScBLbaIgVLW4E+YsMmiFOSpRZNNAaEg7RQ2sz1+SiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616410; c=relaxed/simple;
	bh=8r5nob4O5VCCihJbBAvJ3ktnNTfs7iaQMCLWQUbpSAM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=l3Ls3OMhZP4eLqfmJoY9nz9cT4W5TQkxAlG/8fFvCdjwxmL0p/K8EC6n4RTtf1y/HwvkXFNwjb6QnW18eqi4fWEriFfch2DavaHpNvJUmY+Gc48IobkZkHLZDIPpZ3e6QwAoecJvJL2EwMNSYoFxievq1Z68GoQoZrvMj28yjX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz9t1758616345t6f37a3ae
X-QQ-Originating-IP: qX5YUT9f79b04HVeyf9HhKDxxMGquq3cv4d7eiVhqAw=
Received: from smtpclient.apple ( [111.204.182.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Sep 2025 16:32:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16710722125067247522
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [net-next v8 2/3] net: bonding: add broadcast_neighbor netlink
 option
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <aNIAytaEhRGVTRvu@fedora>
Date: Tue, 23 Sep 2025 16:32:12 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <11162EF0-0EF9-4A37-B57F-C2B7F38CAED2@bamaicloud.com>
References: <cover.1751031306.git.tonghao@bamaicloud.com>
 <76b90700ba5b98027dfb51a2f3c5cfea0440a21b.1751031306.git.tonghao@bamaicloud.com>
 <aNIAytaEhRGVTRvu@fedora>
To: Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Nexn2h+iS/qOW3dv8VWVGxoUAPp+nGZwOPuCRn4v2UEZDhpHq6WlB0sw
	smWyg+E+Z3NqdU0WSOm8+xID9wOW5cmznQiQIpmbhJbXcyeeUyTzaoAa8mcf+9TBRN9IsSb
	7Qs8H6c5djqd7RjsLTdQmCEK7FY2uhq2N9E4YJiI+3iU5wRu+SLQv5lwTgF6XLHa8ivOeca
	VlpkGwMC1GbIRXBJ+8F4HeY1vhexykwZiYzbZ98TGrUdSZlYrnETdBfUESAJZM8ehE/HErg
	+XutX02Aa2h3GXP7pRZTzcvbMxZCKXuIvfNT/qavrqoKEwe8AAkfCnXLsvKrZ4TYWQLGK7x
	pTrBXMODkDa/9n3Fb7nkxvECZjTj2xo5QInrU/AaA1vjpxwTOD9+TcKJvE3NcoZIJWibed7
	ENqBXo+1dA8ok0IZvFCY2eKScmtiGBPAblmtkWglP2MdhEAjWqbHMKo4y5QaPQVOw4xWkas
	dNwUpx5ZhCuvXm3sTN27xC9U2+mRKuzvXK4Ifz7ga19lXwnMmXgpD1/bd96aQkBBOklaa7U
	DWKQ20cutDvxGOqw3EVsMVYDCLNhCnNmGBLrmPF2tcK4/U/wfZ1bv1PhbqUgkBH/f1woq9a
	/7SPV4gX+C5DuD9WAc/IWBcdK9IDMGiCNyMabXOwFjB2V6+b4xhUTkcrnPMDtNACWJQpzEY
	tWE6OGtqVevS+UvWAwCP45EMI/yusZyTuIuaKx93BJ21vgNfwhsFJKlYs6FyRti1a9tBaOJ
	aYl/zL4BKQpRh105+MICS36OsJgAy4eF0Yqd0WDJeRx7LpZZpDSLTSgXi0lYdUG2Re4ANR1
	D5ZUVfvY3Dd3WQmtkVWuc2jPdzOrGhRBPnXUvY1LlBbWsjykKHP5zq2rZ184URfS/yk83oo
	suoaUFxt7q7ySpH7Ul4YuSaebvmpkpy65X1iP+snq6avjhYnBSV5GhD/qNwCpPVYoKuOZUm
	cXfMqnndF4/UhAdYb+mL/NNu2cICY7O/oL5e4/8Xtlq/qvA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B49=E6=9C=8823=E6=97=A5 10:07=EF=BC=8CHangbin Liu =
<liuhangbin@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Jun 27, 2025 at 09:49:29PM +0800, Tonghao Zhang wrote:
>> User can config or display the bonding broadcast_neighbor option via
>> iproute2/netlink.
>=20
> Hi Tonghao,
>=20
> Have you post the iproute2 patch? I can't find it.
Yes, today, David suggested that I repost the patch for iproute2. I will =
cc you.
>=20
> Thanks
> Hangbin
>=20
>=20


