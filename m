Return-Path: <netdev+bounces-189679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB7DAB327E
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1D63A7544
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FE325A323;
	Mon, 12 May 2025 08:57:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A525B1FF
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040220; cv=none; b=MSKl69FQhqbcoe5N1UvbbE4FXsa2Kkf2wyNopAtJHzlqqUxBG/+vX9rWE6ClwT3UffUx8FHCu4vnZTBBm0rjjJVkHB4+lELh9ZxN1ZdRcBzxe6e5+BN6oXKsTvnb2y4crS7jjbCM7zK3/3WCK0kn1jZ4NfP7qJyfjHXCfYmBhPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040220; c=relaxed/simple;
	bh=NZeAAAI0Wk88InKWrw79wYG1C9t62SpIJwkLeDk870E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dAyfUq3/MNltWC0eDmJYWd5C2E+ZrHCENbDEQ/VMAPMKyYTn/iaGaqgjz9wpIwUmWPqE/FvF2sl/LQJHq95FIE+DgwRWDSEBKKRQ3rMjEtxTlYOjk14DPpoJDWQbgoKKDT2QDRriU8wMQNKWS1Aq6+LOI1hWFaUMXoCbciX14JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz16t1747040138tbf057915
X-QQ-Originating-IP: s0rjAovFxlQCmvTmfAadw9TVUJKRcRvqRhY+URv6yfo=
Received: from smtpclient.apple ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 May 2025 16:55:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5690796263493250774
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH net-next 1/4] net: bonding: add broadcast_neighbor option
 for 802.3ad
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <aCGvynxFVglsf1St@fedora>
Date: Mon, 12 May 2025 16:55:36 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DCAD8257-E275-4251-8E6D-815D583907BF@bamaicloud.com>
References: <20250510044504.52618-1-tonghao@bamaicloud.com>
 <20250510044504.52618-2-tonghao@bamaicloud.com> <aCGvynxFVglsf1St@fedora>
To: Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MhqidREDs1kxb6iuvtjsWc7bJXyx2/5ouOHYxYvpnSeWaikQcaBr5ASP
	vESzn42p55129raAcj8RDPM8yJMbBE1biCm4Otj1k8BhP/386NQuAmvhPddCMLCf8IvbUQH
	45bIQ5Ub/kDg0oV4Lx8nzrmw+D4dL77MO9iS3IfjW1BTCOLRunEkhrY8kKfeHIng3N5NGR8
	lglYa2Xus7FsSWa/Jr1mwBs16RwuLJffOxYbtES0Z7KuH7BXSjy4g5s6ewBYtJOURvuBbGK
	SlfdstC/0q1x7zK3ekyuRUsirYXi0u82h7M+KnybkzjrhSnxJskc+IrtrMMKRBkQx4+U3+I
	ie+ZeKGcJwn4ULvmgbQU5aqOClpw4KKoCQ7XCX4WWDXucECxZV0q9/3DXeR5keFV+wrC2vx
	YICOLcOuBAyKqsfNrCRrXiVQ1RljyceLyG3DGGxn4XghackOHRO4oaDR/9km6EuEC1sW3yV
	9QzXSS4f7BmXXMRFGzckVpuScjrru0mVEwtU2jnlorsYBn4sV8klQD7mGlZUrt40pNDFj4x
	h0K5FOtjspSBvK8NFiueEO4906DrsU3AAJ/oUAL39tR4Hn92vHQVsoltMSFCHgug/NysPj/
	u5oCwEMleiqjwhFhErrNyAmjRklFFGJYaRcT8uDD0do9gFPwukBkKlfhCX7KUU4YsjlvzX5
	u0LOFNG0h0y2OB/+suTEw57Lu1saKR+Rgr1Jm/6GdyZ8L7EyyfKKomnj++covUJi3B6Wxew
	cav47RfbYYOna5N4qOcMC8FuLh+NDtnxcGDBN2KyiJ978JN+2YKlR5p/nj7j51CMUXrj1BQ
	atcXfptUBC/uHXNmUNfu4cZWmjOkcEAddcmB6MKrOTMoIrNFjhJ1bLgeSV1WRLghJ9rntk1
	DFl+dEK1Lvi9vffYuOogZkwf59skYGqmg4Hch4Oo5Z2wIymmJcad3dolR1/aM5CxPNFle5e
	RMWrsAqZXrN/SisuOQNgK2pBowYIIR2P34kBKLy0Kr15Juo0NwkdCyHKL7Pl0kc2sducU5f
	8OVv9l8wszLeqFDpoGta1qX3mqd7WrYFl947GCtQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B45=E6=9C=8812=E6=97=A5 =E4=B8=8B=E5=8D=884:22=EF=BC=8CHangbi=
n Liu <liuhangbin@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sat, May 10, 2025 at 12:45:01PM +0800, tonghao@bamaicloud.com =
wrote:
>> diff --git a/drivers/net/bonding/bond_sysfs.c =
b/drivers/net/bonding/bond_sysfs.c
>> index 1e13bb170515..76f2a1bf57c2 100644
>> --- a/drivers/net/bonding/bond_sysfs.c
>> +++ b/drivers/net/bonding/bond_sysfs.c
>> @@ -752,6 +752,23 @@ static ssize_t =
bonding_show_ad_user_port_key(struct device *d,
>> static DEVICE_ATTR(ad_user_port_key, 0644,
>> 		   bonding_show_ad_user_port_key, =
bonding_sysfs_store_option);
>>=20
>> +static ssize_t bonding_show_broadcast_neighbor(struct device *d,
>> +					       struct device_attribute =
*attr,
>> +					       char *buf)
>> +{
>> +	struct bonding *bond =3D to_bond(d);
>> +	const struct bond_opt_value *val;
>> +
>> +	val =3D bond_opt_get_val(BOND_OPT_BROADCAST_NEIGH,
>> +			bond->params.broadcast_neighbor);
>=20
> nit: please take care of the code alignment here
OK
>> +
>> +	return sysfs_emit(buf, "%s %d\n", val->string,
>> +			bond->params.broadcast_neighbor);
>=20
>                       here
Ok, thanks Hangbin.
>> +}
>> +
>> +static DEVICE_ATTR(broadcast_neighbor, 0644,
>> +		   bonding_show_broadcast_neighbor, =
bonding_sysfs_store_option);
>=20
> and here.
OK
>=20
> Thanks
> Hangbin
>=20


