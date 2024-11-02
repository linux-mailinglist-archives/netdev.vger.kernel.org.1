Return-Path: <netdev+bounces-141228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 177609BA163
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 17:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F42F1F213D5
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC8C155336;
	Sat,  2 Nov 2024 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="cpL3iNk4"
X-Original-To: netdev@vger.kernel.org
Received: from ci74p00im-qukt09082302.me.com (ci74p00im-qukt09082302.me.com [17.57.156.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506A942070
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730564410; cv=none; b=ccTa6TRAmoaIk/66bQOlM7IPh/FljpOqzpEjqU2SrC94EXaF8jUwNpFD0iNATFaLoEf+iUmnp7dUJCAajp5pKc7zq3i4ZQQYKzBrrIknLc3WvwtcuMQ7bxO+k3iVx5s6MAq3KsxSEa0E9Nptc2g0zs41z7pcvzZrL9pjmpleAUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730564410; c=relaxed/simple;
	bh=scCluSYQtHdqN2CxlQfou1k9oOaQGwEtoIcDw3tKeF4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=DaQHQ7z9RerZvJWCMCRcfsO80yHdW3tBz0GyE6/q4fmHNugXov0fvrWlpSNov6MGWejPIfUrrS/7Ls7aIZt5Le6Exmbsy9PXgYZMt43S65RTl4HRNt9pQEF/+nlWdMi9pvyhiIxmLxaU9oPE2k+DaaTmapKy8GEtBOI4LUN9wu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=cpL3iNk4; arc=none smtp.client-ip=17.57.156.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1;
	t=1730564407; bh=XoSg4c3PAmauNtowH+vg08CvRIFkV+15uoiCazxoM2c=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:
	 x-icloud-hme;
	b=cpL3iNk4bw0ngvjURS5c+w4TE0zCJEzohwSdZlcMq4O1+DaACNV0z92fChf6SsO14
	 35TPDFPoF02UbtKTRkxoups/piaMZp7sbgll+0mlbGPgXFUIy1PXHLq0wA30kXbIK2
	 N7WFfs2tgOUK7k1c8Ekqmxv0owtFYetzVhx+KFnz1qlQkOaS8kh7GvFfku5/2Qcma5
	 ctpc5Jy3m7G8G2BoUZZSHjia+TdECBRUWKBhPbAaG9XwCX/eJCzdpyq2gxTZAwdsU4
	 rV6V1tIpHr1VbVHUqTLyxU4xg2fVLHmt+Dao74B25QjvcTdJqNi7laWWCAEudfZyWw
	 8He53vpspmChQ==
Received: from localhost (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09082302.me.com (Postfix) with ESMTPSA id 844372FC040A;
	Sat,  2 Nov 2024 16:20:05 +0000 (UTC)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 Nov 2024 19:20:02 +0300
Message-Id: <D5BTVREQGREW.3RSUZQK6LDN60@verdict.gg>
To: "Ido Schimmel" <idosch@idosch.org>, "David Ahern" <dsahern@kernel.org>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>
Subject: Re: [PATCH] net: ipv4: Cache pmtu for all packet paths if multipath
 enabled
From: "Vladimir Vdovin" <deliran@verdict.gg>
X-Mailer: aerc 0.18.2
References: <20241029152206.303004-1-deliran@verdict.gg>
 <736cdd43-4c4b-4341-bd77-c9a365dec2e5@kernel.org>
 <ZyJo1561ADF_e2GO@shredder.mtl.com>
In-Reply-To: <ZyJo1561ADF_e2GO@shredder.mtl.com>
X-Proofpoint-ORIG-GUID: k-11R3e3nbDQAm5F8FeOwlmwuVITlDcb
X-Proofpoint-GUID: k-11R3e3nbDQAm5F8FeOwlmwuVITlDcb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-02_14,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=583 phishscore=0 spamscore=0
 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411020145

On Wed Oct 30, 2024 at 8:11 PM MSK, Ido Schimmel wrote:
> On Tue, Oct 29, 2024 at 05:22:23PM -0600, David Ahern wrote:
> > On 10/29/24 9:21 AM, Vladimir Vdovin wrote:
> > > Check number of paths by fib_info_num_path(),
> > > and update_or_create_fnhe() for every path.
> > > Problem is that pmtu is cached only for the oif
> > > that has received icmp message "need to frag",
> > > other oifs will still try to use "default" iface mtu.
> > >=20
> > > An example topology showing the problem:
> > >=20
> > >                     |  host1
> > >                 +---------+
> > >                 |  dummy0 | 10.179.20.18/32  mtu9000
> > >                 +---------+
> > >         +-----------+----------------+
> > >     +---------+                     +---------+
> > >     | ens17f0 |  10.179.2.141/31    | ens17f1 |  10.179.2.13/31
> > >     +---------+                     +---------+
> > >         |    (all here have mtu 9000)    |
> > >     +------+                         +------+
> > >     | ro1  |  10.179.2.140/31        | ro2  |  10.179.2.12/31
> > >     +------+                         +------+
> > >         |                                |
> > > ---------+------------+-------------------+------
> > >                         |
> > >                     +-----+
> > >                     | ro3 | 10.10.10.10  mtu1500
> > >                     +-----+
> > >                         |
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >                 some networks
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >                         |
> > >                     +-----+
> > >                     | eth0| 10.10.30.30  mtu9000
> > >                     +-----+
> > >                         |  host2
> > >=20
> > > host1 have enabled multipath and
> > > sysctl net.ipv4.fib_multipath_hash_policy =3D 1:
> > >=20
> > > default proto static src 10.179.20.18
> > >         nexthop via 10.179.2.12 dev ens17f1 weight 1
> > >         nexthop via 10.179.2.140 dev ens17f0 weight 1
> > >=20
> > > When host1 tries to do pmtud from 10.179.20.18/32 to host2,
> > > host1 receives at ens17f1 iface an icmp packet from ro3 that ro3 mtu=
=3D1500.
> > > And host1 caches it in nexthop exceptions cache.
> > >=20
> > > Problem is that it is cached only for the iface that has received icm=
p,
> > > and there is no way that ro3 will send icmp msg to host1 via another =
path.
> > >=20
> > > Host1 now have this routes to host2:
> > >=20
> > > ip r g 10.10.30.30 sport 30000 dport 443
> > > 10.10.30.30 via 10.179.2.12 dev ens17f1 src 10.179.20.18 uid 0
> > >     cache expires 521sec mtu 1500
> > >=20
> > > ip r g 10.10.30.30 sport 30033 dport 443
> > > 10.10.30.30 via 10.179.2.140 dev ens17f0 src 10.179.20.18 uid 0
> > >     cache
> > >=20
> >=20
> > well known problem, and years ago I meant to send a similar patch.
>
> Doesn't IPv6 suffer from a similar problem?

I am not very familiar with ipv6,
but I tried to reproduce same problem with my tests with same topology.

ip netns exec ns_a-AHtoRb ip -6 r g fc00:1001::2:2 sport 30003 dport 443
fc00:1001::2:2 via fc00:2::2 dev veth_A-R2 src fc00:1000::1:1 metric 1024 e=
xpires 495sec mtu 1500 pref medium

ip netns exec ns_a-AHtoRb ip -6 r g fc00:1001::2:2 sport 30013 dport 443
fc00:1001::2:2 via fc00:1::2 dev veth_A-R1 src fc00:1000::1:1 metric 1024 e=
xpires 484sec mtu 1500 pref medium

It seems that there are no problems with ipv6. We have nhce entries for bot=
h paths.

>
> >=20
> > Can you add a test case under selftests; you will see many pmtu,
> > redirect and multipath tests.
> >=20
> > > So when host1 tries again to reach host2 with mtu>1500,
> > > if packet flow is lucky enough to be hashed with oif=3Dens17f1 its ok=
,
> > > if oif=3Dens17f0 it blackholes and still gets icmp msgs from ro3 to e=
ns17f1,
> > > until lucky day when ro3 will send it through another flow to ens17f0=
.
> > >=20
> > > Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
>
> Thanks for the detailed commit message


