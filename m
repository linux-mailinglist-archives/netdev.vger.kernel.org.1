Return-Path: <netdev+bounces-192294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FA1ABF46C
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 14:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF718C7992
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAFEDDA9;
	Wed, 21 May 2025 12:37:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FCC12E5B
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831060; cv=none; b=E+eRQMFRx8CW1AyLbol7byQr85yTAykgrJ5bffgobrW45Nq2++TWXPRnhZwqSNGq4wZhemeMlao3kcuYjITe+vSdfs/BZv1SgFcFo/4sDaI0NgCIyfbQGg24PuRd3gD4mrTbgIhGX296buwNk8n2Ie72vIDBEE9NHGYL2EW3H2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831060; c=relaxed/simple;
	bh=cV9aLg4EWgptKKblw5LNVC2Yc/2PSt4N8pm8oXrEKo0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=M7hWOzp/otH11RYBA/ll++7PYlt+zqyJ9A+SiMeqdvYNW72ZP7qKmem2hr5NLxfV5dJyOe6WY5M8NTlzlzSmqSSjxrgjcGDWDl0UAcETSnX4iy9gCwDH9+v+Ic/hCHLAkCvISWVUIekfNVQuDH5CI/93Y/B4r4NVF3uRSHvZOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz14t1747830975t02670818
X-QQ-Originating-IP: rDA45F+O0QIMo3WoRU5WjKFw1B2EOj1qTazDQl1/ltg=
Received: from smtpclient.apple ( [111.202.70.102])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 21 May 2025 20:36:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13152145970513390061
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH net-next v5 0/4] add broadcast_neighbor for no-stacking
 networking arch
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <1194d026-ea54-4e86-b0e3-e5d73bc74c36@blackwall.org>
Date: Wed, 21 May 2025 20:36:03 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Zengbing Tu <tuzengbing@didiglobal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6586695-34CC-4076-9528-514C9176CD98@bamaicloud.com>
References: <B713F1A654D10D79+20250519084315.57693-1-tonghao@bamaicloud.com>
 <1194d026-ea54-4e86-b0e3-e5d73bc74c36@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M1tjFO1fqc+0Ad2GViVkG3htcuSGqJ4mtweS/mib3fJcZtpPlxbjBKTP
	Zw6iH+6IJPerL8fVxvvrD7K6IP0WtFOSNkrBJjxv2/0vl4gndaunmieUVEh/dx+SnvR83cG
	ylEVUwTm4TRcCA+i9VDc/zgQHjII05cGt+tGMFo41L+CN/MBWKP4m0VhIbvDtIBWLZYX0rW
	Jpbsz8/B+6Jkhiu48QHva6SP8KadEss5cZ6mqaMG6O2X5sXm11GclZPHujk0uS96BCeSb3e
	BuBG0V3FsHVYW8C5CEKUER+Ys0+7ezON5Qa5IQBGBURxYobRPfM6YTJzb6IcKT6dPa10VIX
	d/BDnCp0yymGyBBgCDoPbTiJqrBR37QeL9AsGXlI57KkSE2aY0dREecGgh9NAX9hvX0MiNf
	aigTYncVV41A9l6zFjbxRszhD6+Il7As5fLG4MQrCqA9v6ai5AMBjGDoWo35WFVLBxegfkh
	gmIrOWvLJO813Ott1Il7IZ6PYiVRNeQY2OLZl1xS1s6YBIodji8cpAoAprAXvgnjEYBzf1C
	yrgU82j23ODcsNsElm52Mhj3vVUipx8E4YZEOq/2UL0+hVmZfcur3YA+o8V64W1/r52Ggd9
	mt4KhcRLowvCuIszG8ZqmDH3Ey9Et9XVEL7ZDLN1rh9JtoGOSGoqQ4FLIsRpQLlNf/rEKel
	NLb99MtspST+ci39IYVO+dh57hQr0XBgbmTb6FfS5z678qp6Z2B4MJB/ZRCAvQUdH9t8Uik
	/xQBgUUkuvjYaOCZceIrauonp00jjgzcynYEuUZ5+GjLqxGcW8kwX3B2F/kyEPeL228ixtf
	3e/0XyFxM+skD+W3AKSjSDSZzgYeYhdJiT8XGh8+HPZdrclml4qkBG1ou89EbpD2ds8hGhv
	i+1djFxh4GYwXLiYFA7qOQKlcrzZtQlie6iQaBZKk68c2JfzDqshEkmsjHb+SC3p96ha0Mi
	YjIZDCFtQZu3eiJQf10NC3potZYAzjbUyGjTVeMMQfllLFg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B45=E6=9C=8819=E6=97=A5 20:17=EF=BC=8CNikolay Aleksandrov =
<razor@blackwall.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 5/19/25 11:43, Tonghao Zhang wrote:
>> For no-stacking networking arch, and enable the bond mode 4(lacp) in
>> datacenter, the switch require arp/nd packets as session =
synchronization.
>> More details please see patch.
>> v5 change log:
>> - format commit message of all patches
>> - use skb_header_pointer instead of pskb_may_pull
>> - send only packets to active slaves instead of all ports, and add =
more commit log
>> v4 change log:
>> - fix dec option in bond_close
>> v3 change log:
>> - inc/dec broadcast_neighbor option in bond_open/close and UP state.
>> - remove explicit inline of bond_should_broadcast_neighbor
>> - remove sysfs option
>> - remove EXPORT_SYMBOL_GPL
>> - reorder option bond_opt_value
>> - use rcu_xxx in bond_should_notify_peers.
>> v2 change log:
>> - add static branch for performance
>> - add more info about no-stacking arch in commit message
>> - add broadcast_neighbor info and format doc
>> - invoke bond_should_broadcast_neighbor only in BOND_MODE_8023AD mode =
for performance
>> - explain why we need sending peer notify when failure recovery
>> - change the doc about num_unsol_na
>> - refine function name to ad_cond_set_peer_notif
>> - ad_cond_set_peer_notif invoked in ad_enable_collecting_distributing
>> - refine bond_should_notify_peers for lacp mode.
>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Simon Horman <horms@kernel.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>> Cc: Zengbing Tu <tuzengbing@didiglobal.com>
>> Tonghao Zhang (4):
>>   net: bonding: add broadcast_neighbor option for 802.3ad
>>   net: bonding: add broadcast_neighbor netlink option
>>   net: bonding: send peer notify when failure recovery
>>   net: bonding: add tracepoint for 802.3ad
>>  Documentation/networking/bonding.rst | 11 +++-
>>  drivers/net/bonding/bond_3ad.c       | 19 ++++++
>>  drivers/net/bonding/bond_main.c      | 86 =
++++++++++++++++++++++++----
>>  drivers/net/bonding/bond_netlink.c   | 16 ++++++
>>  drivers/net/bonding/bond_options.c   | 35 +++++++++++
>>  include/net/bond_options.h           |  1 +
>>  include/net/bonding.h                |  3 +
>>  include/trace/events/bonding.h       | 37 ++++++++++++
>>  include/uapi/linux/if_link.h         |  1 +
>>  9 files changed, 197 insertions(+), 12 deletions(-)
>>  create mode 100644 include/trace/events/bonding.h
>=20
> Again and more explicit - please CC *all* reviewers on the full =
patch-set
> when sending a new version. I had to chase down the patches on the =
list
> which is a waste of time.
Ok, I will Cc all reviewers. Thanks
>=20
> Thanks,
> Nik



