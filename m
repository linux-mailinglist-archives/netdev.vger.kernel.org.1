Return-Path: <netdev+bounces-201531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA21AE9CA7
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BEA917D2D8
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDE6220698;
	Thu, 26 Jun 2025 11:36:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72DF17BA5
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750937818; cv=none; b=g6yT1GTWzJNQu6NK0dtahL+3d32GOnmxq1ERF9Qz83m0jvs92MUdRe1Q9Pb7C+G/PUjaQRfk/nqrDPsb4vTuqv1kI9LQTPvViS3MFRGBI1vcPHDSVOkjnzbSFGnci9967VJaaN8vvutGvITm2s+nnntPjI167W9PGR/YVKXIMUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750937818; c=relaxed/simple;
	bh=I4uEFDC+4MLeiciehajdsQjasD2ojHSMCmS2viL4ivE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WpvIFd+1985tikhnT/4GL2EN7K9fz7j9tjao5+P6bS8TATbXI0heeOhAi+H2Brc75OMFJgy1TnA9RLMXNEVeFwVHHCwA1CZGIw58Yw720/SsPiLNWbrNxRj61/IcDVnSORCOnqrfH65Uq5D182Iu50t0PuXaYYAG+PedoWkLTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz8t1750937780te6094148
X-QQ-Originating-IP: m5wMsy7NDNmuwNS8/3w/b/eZeAa88QcmSi20vwln1+Y=
Received: from smtpclient.apple ( [111.202.70.102])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Jun 2025 19:36:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15898985945846823140
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [net-next v7 3/3] net: bonding: send peer notify when failure
 recovery
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <77694cec-af8e-4685-8918-4fd8c12ba960@redhat.com>
Date: Thu, 26 Jun 2025 19:36:07 +0800
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
Message-Id: <EA1E6A18-1A83-43B8-B91F-5755EB553766@bamaicloud.com>
References: <cover.1750642572.git.tonghao@bamaicloud.com>
 <6965bf859a08214da53cad17ea6ed1be841618fa.1750642573.git.tonghao@bamaicloud.com>
 <77694cec-af8e-4685-8918-4fd8c12ba960@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Np+AlqyfvJHV7QjtSrROooQRSil7HWRGb6Uav+RTQaLLUgWKIsY2nRag
	NLxsoG7wst7KjNMt8yvF5jU8OJ7IFmNPwevUiCIPwfOUwHr37BWWg+z4UF5wQQ+KZfp1fC6
	HZFHqs+JWNvEgIevrBgAK5adAmZ+tZhzDmpMQywghzdxx8jPd/SVh5FuDPtWrZtMXLXshbM
	TxpFY2Sfjr5w7zrswUjviMifSIr17QdFUI5QvuP0l80dAvB1sWA/6W/Wlm7f+pZ3gRZ5TZh
	xzHIRT1Gq0Sz63EdpL1UPg5r+j2sTiXJYSEoAuEdzWwYXkRx64TyGlYWO2IR2L6HnLeEXC7
	H2liAv3rBO9AVFmHWnPO5HcpmfVa2kxKuyN6bTunxLFS6ZpVIQ2sVaWRgkmZw4XdgHHlvmr
	PqOLmd1eDqCp8HGizY661JMjL5ICX4kIWO4SIXSgGh6csvy+VqvcjG7uBGyuB0tzQGUerzT
	HpInCrJTB86Uj/uI74EgepZ7Qk5hIjsKFDW/dn/JMPvxCX8opoET9t8S9DNdWb1eoAlqbB9
	yY06d8LBWkn1fLY67LJS7drgitF3bMDCNkepXZOeD5AQDuz2htCCwSGERtKQrw6wff54kOE
	FZV+x3ZP7vM1ES+dtuXcWLULMDqvqtTM59ljWC4ZlTFJkjDHyOLtyU5NmvyD8e/YwNffqT4
	vi8dwM1Ho4asWiMwkdp5+fjQG04Xqc09VwclL1vxglV6GNpKqJ8qzGfTOLfeptNOULC9hIF
	McH1qlOxnhFzXfaWTLshFjF4valzYH72+6Vm+HABM52if0FafvNg4uUppQILE3f6ELDkstf
	6r2/d9DE1if16yeOq+cjApZEAufuSWbO76JkHACLK02ZqjFNF+UtDo54D8bM91ASg/S4InF
	ojsq8L47hhUl7VkVnrGWfnnArhk7Rj3qFU26fe3U0sxxc4PjuAvU/twiKpP9XzGb7JqkeJR
	uyMvdUa0wwzC7Z6V1BZHAu1LvmOIutX8hjTGuZonGlENnkUcDZV/FeZjDO6INVi6Eiacdjg
	gfT8f4Rg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B46=E6=9C=8826=E6=97=A5 19:16=EF=BC=8CPaolo Abeni =
<pabeni@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 6/24/25 4:18 AM, Tonghao Zhang wrote:
>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>> index 12046ef51569..0acece55d9cb 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -1237,17 +1237,28 @@ static struct slave =
*bond_find_best_slave(struct bonding *bond)
>> /* must be called in RCU critical section or with RTNL held */
>> static bool bond_should_notify_peers(struct bonding *bond)
>> {
>> - struct slave *slave =3D =
rcu_dereference_rtnl(bond->curr_active_slave);
>> + struct bond_up_slave *usable;
>> + struct slave *slave =3D NULL;
>>=20
>> - if (!slave || !bond->send_peer_notif ||
>> + if (!bond->send_peer_notif ||
>>    bond->send_peer_notif %
>>    max(1, bond->params.peer_notif_delay) !=3D 0 ||
>> -    !netif_carrier_ok(bond->dev) ||
>> -    test_bit(__LINK_STATE_LINKWATCH_PENDING, &slave->dev->state))
>> +    !netif_carrier_ok(bond->dev))
>> return false;
>>=20
>> + if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
>=20
> I still don't see why you aren't additionally checking
> broadcast_neighbor here. At least a code comment is necessary (or a =
code
checking broadcast_neighbor is unnecessary, because send_peer_notif is =
set when bond is in BOND_MODE_8023AD mode and broadcast_neighbor is =
enabled.
>=20
> change).
>=20
> Also the related selftests are still missing.
This option is set by iproute2 tools (netlink), I plan to post a =
selftest for this option when iproute2 support this option.
>=20
> Thanks,
>=20
> Paolo
>=20
>=20
>=20


