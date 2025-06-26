Return-Path: <netdev+bounces-201529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F20A9AE9C5B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8C418988E1
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3B52750F9;
	Thu, 26 Jun 2025 11:17:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB4275B03
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750936642; cv=none; b=ZORowzAPMwfZZPzrdBETjfgJH5pMWhx//3gK2XjXMnke+dw0dwYRDWTgNwVrbwR1P2SsIuHP58LA/11uVoMm/q992hNCh+ytXehfkW7twKFbxaaF3kNNJzToFKoa4NAh6/MdrrT/VRkT++VIHq5n3NU0QHMx0QLq3zaPw59fsiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750936642; c=relaxed/simple;
	bh=+ow5rGgCCjJCdI8Bf7UuXI8O6wBa3O/v0fOIJ4XcYN0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dIV1CNr9EnNehnt5QPs4s2oNu01SBy5eDt13bKxDrjMSid9XRz2vUme5ia/Cg3CsyRKhm/27fRymO6uZ7toFrP8tM3PYKBu4Au8EdTKfavNxJo0ZTAtUzD0x/urCqRCEqX038nZ5VxTjzHHpv2t324vddCVVKl5P6yGycQ7XbGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz4t1750936613t9e204c8a
X-QQ-Originating-IP: apMisQ9yyCb3mdrU1Vj03k+v3WJaaW68HN9rKDuU8Gw=
Received: from smtpclient.apple ( [111.202.70.102])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Jun 2025 19:16:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6906385017124595598
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [net-next v7 1/3] net: bonding: add broadcast_neighbor option for
 802.3ad
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <9829a19e-0f19-46e4-a007-0e943f1fcdb8@redhat.com>
Date: Thu, 26 Jun 2025 19:16:40 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0448275B-F4B3-43F1-BB27-CF8DAEDAA28F@bamaicloud.com>
References: <cover.1750642572.git.tonghao@bamaicloud.com>
 <f1511ff00f95124d1d7477b0793963044be60650.1750642573.git.tonghao@bamaicloud.com>
 <9829a19e-0f19-46e4-a007-0e943f1fcdb8@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Nl7eTg5yGHnwY4LR15U8M/T4tMUQHz5Uvm0Hpn+mt55IZqHpwjCl2pxv
	kobQSw2YvxZgfUoO7SNeSh4eIq1QReSw1MYQmeCZXzYchUlcsq8VjWkDB4JDZ4YVWS3RytL
	ATSmWeU3VwLKkKGf57/FxMXQs8kCv7NqcOvnMqVdKxcoOcw4CFu7sAuxuBm8NneBjUAvaPF
	5HhGQCdqUGEKsg6ytoBBCW7VVnrkbY5GBASvx41JMZyBFxmfLJ4pXI5Mf6M4iBBzhzf6Yqm
	GzasKsj86/T2DgVfG9+Fa5mW+uq1KUn0OSAW5NSTwLn/4ozvjtQnNoD8S1GaVvX/1QjXoZ7
	bObAo/wTuV9NvxVOOOyrM2uQYyEvAah0TMp0oCHx0d3zPgQn5EE+kyLf5+PkBtfwyX7PsFl
	gHyZiHKxyf/9O+7+GpgYTN1kZeW1mxBM9gZbyMstT/TLHoifb+2JfiAyyIFv0wAdB+RH0jZ
	kve7rvV5d9FnLfI8nryxhSITfdSxMsSeCdTwQE5KRiNr4l6LJ9lvscoIa2Ez5Y0G9Lwemwo
	01tYFXvyAJeimyxzXqPTsdF8nSTzRNFrQmZ5HOtB6s2eMwXFkDOE8OZImO8XxZusu1PZcTB
	8s72qIt0TIrHMpQuqbAKqHA5WPwjVBdll4GHmvRCdCBGS/jXXi0u7cd6XxINiwm/PWxEDj7
	x3N3Uc5/Drhgw66A6GVFhCUe33dbWb+z3bLdaSpotyiEoE7ipdTzfXv9tWA8WO9K/1iopa1
	GI90vGhZ5iJ9VgPJ59yDbFgsG2lLy5NCNyo00WQYNpQL3kriYKBgJTgUpu7uldBuXjXEgRG
	FEJ4nOHC+i+MtrRZeKuWq9Q9EBAMQ1j/Y4cvB8b5zTP7T5VPgbfSwkWafM/KdzajOcmH6X5
	biIlEsDN8D50pSKu4OflZz2ihuWB+U5k/omzc6VImET60jG2C5lhSzWw/o4D3D+eySsvHpc
	pdCSQEd5C95ufxyg8kdiS27hqbVUY6z1pyi27pLJMFF9aMpdg+jbFhgb2gmM0SRYqlOF7qF
	FFK1isNw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B46=E6=9C=8826=E6=97=A5 18:49=EF=BC=8CPaolo Abeni =
<pabeni@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 6/24/25 4:18 AM, Tonghao Zhang wrote:
>> @@ -893,6 +909,8 @@ static int bond_option_mode_set(struct bonding =
*bond,
>> /* don't cache arp_validate between modes */
>> bond->params.arp_validate =3D BOND_ARP_VALIDATE_NONE;
>> bond->params.mode =3D newval->value;
>> + /* cleanup broadcast_neighbor when changing mode */
>> + bond->params.broadcast_neighbor =3D 0;
>=20
> This does not look enough: it looks like 'bond_bcast_neigh_enabled'
> accounting is ignored, and should instead adjusted accordingly.
I try to explain, setting the bonding mode requires putting the device =
in the down state, which has already reduced this value, so do not =
reduce the value again in this function.
>=20
> Side notes: please include per patch changelog to help reviewers, and
> when replying to reviewers comment, please properly trim the =
unrelevant
> message part and separate your text from the quoted one.
Ok
>=20
> Thanks,
>=20
> Paolo
>=20
>=20


