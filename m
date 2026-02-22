Return-Path: <netdev+bounces-259857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ll74BRGSmmlQcgMAu9opvQ
	(envelope-from <netdev+bounces-259857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 06:20:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BDF16E813
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 06:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A2503015714
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 05:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0491A5B84;
	Sun, 22 Feb 2026 05:20:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F20199E89
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771737613; cv=none; b=uA9YPu8ToW41duJ++VjDv0b41Ik8U3VL7s+G1JhMGXjr9oJG59D7Etfsw5j+klIOzD2rLGwAAxOs7mwrkxmbCG6bHCEhMU9cldEl2CkEPm0grbTr6VVOWGFHBHZrgXpiCOgNci5X/wklY1eDJ0PErUOhz9s3nKdWeLm/mIK3Puo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771737613; c=relaxed/simple;
	bh=csF4ZVaCIrxXyOB02Lb/+phl872HisVeiJFwazcPf9A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fi7JdVGnOsdAxE5kdDan9zJAoIjyjZEAswrBuerAnA+E85gvleineu2QO7Nl5bprtjjeCOU/JKHRrOVegoMo1BGzAYjSr2b2cUVh0m5zkWUXqSf+1BHyaVf2WBswHSfpqoeamJXbTgPsvfnhZtBwpkrw3QPI3WBWYgBhv9rpFUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz3t1771737581t3524c13c
X-QQ-Originating-IP: BaQTBE9EmP+FwbhyrGblSrTy9dbC9Qsny1fnTBqANsU=
Received: from smtpclient.apple ( [120.244.235.1])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 22 Feb 2026 13:19:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3587849616591520657
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net-next] net: core: introduce the
 netdev_fetch_core_stats()
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <e8355c0d7fd48981ba505e455387971f91210fa8.1771734206.git.tonghao@bamaicloud.com>
Date: Sun, 22 Feb 2026 13:19:28 +0800
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BED9B63-F9A1-45C4-AE58-99AFCD7375CC@bamaicloud.com>
References: <e8355c0d7fd48981ba505e455387971f91210fa8.1771734206.git.tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NojR6Ao/DkED/E+jejEHgyGSAfHfK1wvp81/V0yDQYu7Pzl1QSFzGxe/
	N/W4jYtWV+NDFsoz+ckjPV/JWC7F7hxVxLgMwxR5RmZdNRIAkGYqVH44eHDeDNGAtiVUK+v
	coeDoOikFpgW5Y48q0ja97UFE0Ur4Q2y0WIdMfb71slLtKnhHJeNYTIh+N7Tuzx4U75cZVF
	ARVukvKsLE6MNzKuTiAofSxU2oAPPzv/JC52K+iI2rrVubSGsbE4Qr+AVVgL8UUGukFM5BW
	iPSBuRF27aMURJOz80JBRrMFlGu0KtZHntsDWYG0tt0avNq8JeWNh8V4smcuGjmQUGJKseq
	IeV0hU8m6GD0cWX3P2r04xHyQ94r2wmVhZxZxTotRfcPV/wJRvIpNVCK3APlIUBuAibWq3t
	9GcGR+6xCWUuwKMhPx09Fm6jSqzts5tneWweY/6Mk9MYTB3TSuJ/1JQO1EG0fT8ufU9ko2N
	IawzHqcDEFfvttmaz7HGfC6AFL8ImfcBYfeU8ZUgYdXdVbP8ycJTF71emyjcCWDWWFBmC6t
	9yvhx9uykpEkf1M8pr8An1LCIzEN3nGGbe8UnPXt/74d0SHMQVK2BM3XPRfSMOJ2ghPl6Gu
	+QM7Y08DuofKdKpk/9Kn09i1hZ2wBnyKNfFUs73zrxwRDqHucdnniBCE5VK6S7EtG/NVzKh
	YyyVRWp/1Owk2UU21qpBeiX6XLzVBpTHEe7UmrGEGDLLdvJv8lhTfOIVA5PomTGaumVwQWU
	0wHZfws8B+MmK3OZ4G3JV7ObIbVY9xB4IUQUIjqrtcz+DVb4Wp299EY8QGCqXPxcttYptDj
	k7Xnm9ul4vCCROHLpu7S5Uz6tX5gdJob8C2Us2MTj5F1p+ssxHMzy5Ykugq3+ICVlPL1prV
	XMVag5FPSBNrSFBjUuvhOPLGTAEOXX7WkUNUSnn3GBBzMHxXXlMNLw7E/052Xc0zT9DELCv
	Y16qB9iy4D2fwc8AVPTLsmVvPjI03sfncxL6vXBIjiKgnMSnRdGHj5wvMQtqX55q8wAeyQa
	zzKrZ1QrqbJ1ToChwQLk30GoUJqy5WoIIBWr0u4My1nYb5XsjGZ3KNNx8J1KgCh4b/W5MR7
	Q==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259857-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[bamaicloud.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tonghao@bamaicloud.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.997];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email]
X-Rspamd-Queue-Id: 39BDF16E813
X-Rspamd-Action: no action



> On Feb 22, 2026, at 12:33, Tonghao Zhang <tonghao@bamaicloud.com> =
wrote:
>=20
> Network device statistics retrieved via procfs, sysfs, and netlink
> represent the combined total of core_stats + driver, hardware =
statistics.
>=20
> However, in some scenarios, when monitoring netdev metrics, it is =
valuable
> to clearly distinguish whether the values originate from the =
networking
> stack's core statistics or from the driver, hardware layer. This helps
> improve debugging and addressing issues.
>=20
> Approaches were considered:
> - commit 5247dbf16cee ("net/core: Introduce netdev_core_stats_inc()").
>  This allows tracking increments to core_stats and helps identify =
specific
>  causes of changes, but not provide the total counters.
> - extending rtnl_link_stats64 with new core_xxx fields.
>  This would likely confuse or break existing userspace applications =
relying
>  on this struct.
> - adding a tracepoint inside dev_get_stats().
>  This implementation is not simple or straightforward enough.
>=20
> The solution in this patch is therefore to introduce a new dedicated =
function
> for collecting core statistics and mark it noinline. This approach is =
simple,
> clean, and maintainable to obtain driver, hardware statistics =
separately when needed.
>=20
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Samiullah Khawaja <skhawaja@google.com>
> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
> net/core/dev.c | 40 ++++++++++++++++++++++++----------------
> 1 file changed, 24 insertions(+), 16 deletions(-)
>=20
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 096b3ff13f6b..ab8de140b128 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11824,6 +11824,29 @@ noinline void netdev_core_stats_inc(struct =
net_device *dev, u32 offset)
> }
> EXPORT_SYMBOL_GPL(netdev_core_stats_inc);
>=20
> +static noinline struct rtnl_link_stats64 *
> +netdev_fetch_core_stats(struct net_device *dev, struct =
rtnl_link_stats64 *storage)
Waiting for more opinions, and the next version:
:s/netdev_fetch_core_stats/netdev_core_stats_fetch/g

> +{
> + const struct net_device_core_stats __percpu *p;
> + const struct net_device_core_stats *core_stats;
> + int i;
> +
> + /* This READ_ONCE() pairs with the write in =
netdev_core_stats_alloc() */
> + p =3D READ_ONCE(dev->core_stats);
> + if (!p)
> + return storage;
> +
> + for_each_possible_cpu(i) {
> + core_stats =3D per_cpu_ptr(p, i);
> + storage->rx_dropped +=3D READ_ONCE(core_stats->rx_dropped);
> + storage->tx_dropped +=3D READ_ONCE(core_stats->tx_dropped);
> + storage->rx_nohandler +=3D READ_ONCE(core_stats->rx_nohandler);
> + storage->rx_otherhost_dropped +=3D =
READ_ONCE(core_stats->rx_otherhost_dropped);
> + }
> +
> + return storage;
> +}
> +
> /**
>  * dev_get_stats - get network device statistics
>  * @dev: device to get statistics from
> @@ -11838,7 +11861,6 @@ struct rtnl_link_stats64 *dev_get_stats(struct =
net_device *dev,
> struct rtnl_link_stats64 *storage)
> {
> const struct net_device_ops *ops =3D dev->netdev_ops;
> - const struct net_device_core_stats __percpu *p;
>=20
> /*
> * IPv{4,6} and udp tunnels share common stat helpers and use
> @@ -11867,21 +11889,7 @@ struct rtnl_link_stats64 =
*dev_get_stats(struct net_device *dev,
> netdev_stats_to_stats64(storage, &dev->stats);
> }
>=20
> - /* This READ_ONCE() pairs with the write in =
netdev_core_stats_alloc() */
> - p =3D READ_ONCE(dev->core_stats);
> - if (p) {
> - const struct net_device_core_stats *core_stats;
> - int i;
> -
> - for_each_possible_cpu(i) {
> - core_stats =3D per_cpu_ptr(p, i);
> - storage->rx_dropped +=3D READ_ONCE(core_stats->rx_dropped);
> - storage->tx_dropped +=3D READ_ONCE(core_stats->tx_dropped);
> - storage->rx_nohandler +=3D READ_ONCE(core_stats->rx_nohandler);
> - storage->rx_otherhost_dropped +=3D =
READ_ONCE(core_stats->rx_otherhost_dropped);
> - }
> - }
> - return storage;
> + return netdev_fetch_core_stats(dev, storage);
> }
> EXPORT_SYMBOL(dev_get_stats);
>=20
> --=20
> 2.34.1
>=20


