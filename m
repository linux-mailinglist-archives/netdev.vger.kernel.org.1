Return-Path: <netdev+bounces-218421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834D7B3C603
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF871667E1
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0120E2110;
	Sat, 30 Aug 2025 00:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="OzSSnP0+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CZr1yzIK"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9C538B;
	Sat, 30 Aug 2025 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756512523; cv=none; b=LbKkYjbgaGBIaGLnZl9Op2CfqxMQIv1xFcXfizso7OT2I9wW8KufAFjO0w8tcEP8OMRR+jMWf7PyrsGUAri/Rf+4zFjsWHAxsYE2l4u4kDug+/gjJMU2+V6PMScjeSRzyC3EO+fLPei479//daMcKEPXcJfOhlEmINqI4Q39ZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756512523; c=relaxed/simple;
	bh=cGAcvfaohgcgqnBfMfHNizV5r7nAZs3ZXff8taeByaQ=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=dLLsXqohz04+HHbyyO8ciM7c3CeExfypfNh+uy2PvqM3BBM9jweoAX/OFjjWp766Lb9nuoqBfiPBSmLpwR2CymMN6QHl108U1CPqeq6S+fD/FHU/0M4LfBbNW79s1Q7w1DJPhUIDDcolkUUA02nXIm90T0sB+949eyexQgKCEHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=OzSSnP0+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CZr1yzIK; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 67ED11D0008C;
	Fri, 29 Aug 2025 20:08:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 29 Aug 2025 20:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm2; t=
	1756512519; x=1756598919; bh=gy4C+qj5SoLNzGf3kcrN8Wg8YsR+HU9nfR0
	HmZtvC9k=; b=OzSSnP0+s4fVfzpNk3an9uXbB1It9ESyHcVkx3o1R6MPoo2eSwG
	dBgVdPIcCxsBpr/38bHkHI25CtuehPIGqR1ZhSjLn2JDxo761T1zgLbH6E/KtfaJ
	19DJupcX9GzOhfqs4exT9SuD/Dt5cpypOiMmEWnQ3idHT9KSMNefZYynu4rAvTTt
	GULn5YqYwKzrAmuUTZbrRt8wGYeoY9pFf8EZcEAlOdCfT+UDCuqRprLPVytlcx4H
	mzsZWc/DtoQdShBxUKqoTrqy1UHo5VKH/jUY03eqCQ1vEYSbCOr+zp6BNzB2bq3m
	pubGpLifqtMNePgyj3WesPX8h66up9z7+Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756512519; x=
	1756598919; bh=gy4C+qj5SoLNzGf3kcrN8Wg8YsR+HU9nfR0HmZtvC9k=; b=C
	Zr1yzIKrXKzeenlkOVNEAmQX2ekcsI6fILRm9LVeSCC/uyX/VwOrYc+GxdUHhnNm
	wddC2xkzMMLq2DNGhGIkvuWOHv63Cl9gIdxQ0a0Q5us0qoChdxelbDu+0WjQujqY
	5Vt4D2fx5ns7H1j78tu6R2ZrqVRqu1kZnX4n5lqf/uTZyW71tN+5bmFl+oOWv3iM
	MwnunvnzLohk/4q4EvV6pu0B1dCR8pbMh1W3ciGGW0CGXz2q+aKRq8M9GgWTVkFp
	yT9CCPRI+LGt6qRpfJ6FXsQs9IgIatHTTJa47r8epMeVQwtKXRgTMw4SUHOLEw/N
	+yX3EZ+SeXVnFjH46qbYg==
X-ME-Sender: <xms:BkGyaGjTSCGOmbK3ZHSVTekx5j0pg6r-Wes6C5EYGvx2b2qgKebOtw>
    <xme:BkGyaBqjUS-AByg6zRRTYjf1c4k1QrJUXAw_aTRuNkWujZFkZGte4hY8erjqipckc
    ad-mFaAKNfUNL4Vdu8>
X-ME-Received: <xmr:BkGyaEGE5XdElkF0MODB8VQfKQlnSG4eQDTnE-Mlpu8jNw4XfUG8rOt9hDCbfEhZZkA5lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefuofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucggohhs
    sghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epkeetudffjeduieelhfetudffieehfeejjefhteejudduueelveffhfegkeeghfegnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthgu
    vghvsehluhhnnhdrtghhpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtg
    hpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhig
    qdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BkGyaO6xflRijFM4dGA3y2Y9_NM0vzZbtdCuYdsQHjJKl7vTEkKgMw>
    <xmx:BkGyaEd9AbFGcMZy1U63O70m4sEeqRcILh0kxH7RzjwedEIjl3Ev2g>
    <xmx:BkGyaB5aSjfyOuqw0nG1Ste1uB-bdUGY2J8bt94H_-jU4m-bGUQFOA>
    <xmx:BkGyaB9UvJ_OkbZEAs_Zuuw6rsHK5MX6inSZQdXBYAc9K_UMk60YEg>
    <xmx:B0GyaOVMTJ8ZdKM4OxCHQiWYTS6cfj84saKZhhM_M-Bdn3_NbbWucLzM>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 20:08:38 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 5434C9FCA0; Fri, 29 Aug 2025 17:08:37 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 50A729FC95;
	Fri, 29 Aug 2025 17:08:37 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org
Subject: [PATCH net-next] bonding: Remove support for use_carrier
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2029486.1756512517.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Aug 2025 17:08:37 -0700
Message-ID: <2029487.1756512517@famine>

	 Remove the implementation of use_carrier, the link monitoring
method that utilizes ethtool or ioctl to determine the link state of an
interface in a bond.  Bonding will always behaves as if use_carrier=3D1,
which relies on netif_carrier_ok() to determine the link state of
interfaces.

	To avoid acquiring RTNL many times per second, bonding inspects
link state under RCU, but not under RTNL.  However, ethtool
implementations in drivers may sleep, and therefore this strategy is
unsuitable for use with calls into driver ethtool functions.

	The use_carrier option was introduced in 2003, to provide
backwards compatibility for network device drivers that did not support
the then-new netif_carrier_ok/on/off system.  Device drivers are now
expected to support netif_carrier_*, and the use_carrier backwards
compatibility logic is no longer necessary.

	The option itself remains, but when queried always returns 1,
and may only be set to 1.

Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com=
/
Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9c9d=
ed97163aef4e4de10985cd8f7de60d28@changeid/
Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>

---

Note: Deliberately omitting a Fixes tag to avoid removing functionality
in older kernels that may be in use.

 Documentation/networking/bonding.rst |  79 +++----------------
 drivers/net/bonding/bond_main.c      | 113 ++-------------------------
 drivers/net/bonding/bond_netlink.c   |  14 ++--
 drivers/net/bonding/bond_options.c   |   7 +-
 drivers/net/bonding/bond_sysfs.c     |   6 +-
 include/net/bonding.h                |   1 -
 6 files changed, 28 insertions(+), 192 deletions(-)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networki=
ng/bonding.rst
index f8f5766703d4..a2b42ae719d2 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -582,10 +582,8 @@ miimon
 	This determines how often the link state of each slave is
 	inspected for link failures.  A value of zero disables MII
 	link monitoring.  A value of 100 is a good starting point.
-	The use_carrier option, below, affects how the link state is
-	determined.  See the High Availability section for additional
-	information.  The default value is 100 if arp_interval is not
-	set.
+
+	The default value is 100 if arp_interval is not set.
 =

 min_links
 =

@@ -896,25 +894,14 @@ updelay
 =

 use_carrier
 =

-	Specifies whether or not miimon should use MII or ETHTOOL
-	ioctls vs. netif_carrier_ok() to determine the link
-	status. The MII or ETHTOOL ioctls are less efficient and
-	utilize a deprecated calling sequence within the kernel.  The
-	netif_carrier_ok() relies on the device driver to maintain its
-	state with netif_carrier_on/off; at this writing, most, but
-	not all, device drivers support this facility.
-
-	If bonding insists that the link is up when it should not be,
-	it may be that your network device driver does not support
-	netif_carrier_on/off.  The default state for netif_carrier is
-	"carrier on," so if a driver does not support netif_carrier,
-	it will appear as if the link is always up.  In this case,
-	setting use_carrier to 0 will cause bonding to revert to the
-	MII / ETHTOOL ioctl method to determine the link state.
-
-	A value of 1 enables the use of netif_carrier_ok(), a value of
-	0 will use the deprecated MII / ETHTOOL ioctls.  The default
-	value is 1.
+	Obsolete option that previously selected between MII /
+	ETHTOOL ioctls and netif_carrier_ok() to determine link
+	state.
+
+	All link state checks are now done with netif_carrier_ok().
+
+	For backwards compatibility, this option's value may be inspected
+	or set.  The only valid setting is 1.
 =

 xmit_hash_policy
 =

@@ -2036,22 +2023,8 @@ depending upon the device driver to maintain its ca=
rrier state, by
 querying the device's MII registers, or by making an ethtool query to
 the device.
 =

-If the use_carrier module parameter is 1 (the default value),
-then the MII monitor will rely on the driver for carrier state
-information (via the netif_carrier subsystem).  As explained in the
-use_carrier parameter information, above, if the MII monitor fails to
-detect carrier loss on the device (e.g., when the cable is physically
-disconnected), it may be that the driver does not support
-netif_carrier.
-
-If use_carrier is 0, then the MII monitor will first query the
-device's (via ioctl) MII registers and check the link state.  If that
-request fails (not just that it returns carrier down), then the MII
-monitor will make an ethtool ETHTOOL_GLINK request to attempt to obtain
-the same information.  If both methods fail (i.e., the driver either
-does not support or had some error in processing both the MII register
-and ethtool requests), then the MII monitor will assume the link is
-up.
+The MII monitor relies on the driver for carrier state information (via
+the netif_carrier subsystem).
 =

 8. Potential Sources of Trouble
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
@@ -2135,34 +2108,6 @@ This will load tg3 and e1000 modules before loading=
 the bonding one.
 Full documentation on this can be found in the modprobe.d and modprobe
 manual pages.
 =

-8.3. Painfully Slow Or No Failed Link Detection By Miimon
----------------------------------------------------------
-
-By default, bonding enables the use_carrier option, which
-instructs bonding to trust the driver to maintain carrier state.
-
-As discussed in the options section, above, some drivers do
-not support the netif_carrier_on/_off link state tracking system.
-With use_carrier enabled, bonding will always see these links as up,
-regardless of their actual state.
-
-Additionally, other drivers do support netif_carrier, but do
-not maintain it in real time, e.g., only polling the link state at
-some fixed interval.  In this case, miimon will detect failures, but
-only after some long period of time has expired.  If it appears that
-miimon is very slow in detecting link failures, try specifying
-use_carrier=3D0 to see if that improves the failure detection time.  If
-it does, then it may be that the driver checks the carrier state at a
-fixed interval, but does not cache the MII register values (so the
-use_carrier=3D0 method of querying the registers directly works).  If
-use_carrier=3D0 does not improve the failover, then the driver may cache
-the registers, or the problem may be elsewhere.
-
-Also, remember that miimon only checks for the device's
-carrier state.  It has no way to determine the state of devices on or
-beyond other ports of a switch, or if a switch is refusing to pass
-traffic while still maintaining carrier on.
-
 9. SNMP agents
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_ma=
in.c
index 257333c88710..f25c2d2c9181 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -142,8 +142,7 @@ module_param(downdelay, int, 0);
 MODULE_PARM_DESC(downdelay, "Delay before considering link down, "
 			    "in milliseconds");
 module_param(use_carrier, int, 0);
-MODULE_PARM_DESC(use_carrier, "Use netif_carrier_ok (vs MII ioctls) in mi=
imon; "
-			      "0 for off, 1 for on (default)");
+MODULE_PARM_DESC(use_carrier, "option obsolete, use_carrier cannot be dis=
abled");
 module_param(mode, charp, 0);
 MODULE_PARM_DESC(mode, "Mode of operation; 0 for balance-rr, "
 		       "1 for active-backup, 2 for balance-xor, "
@@ -830,77 +829,6 @@ const char *bond_slave_link_status(s8 link)
 	}
 }
 =

-/* if <dev> supports MII link status reporting, check its link status.
- *
- * We either do MII/ETHTOOL ioctls, or check netif_carrier_ok(),
- * depending upon the setting of the use_carrier parameter.
- *
- * Return either BMSR_LSTATUS, meaning that the link is up (or we
- * can't tell and just pretend it is), or 0, meaning that the link is
- * down.
- *
- * If reporting is non-zero, instead of faking link up, return -1 if
- * both ETHTOOL and MII ioctls fail (meaning the device does not
- * support them).  If use_carrier is set, return whatever it says.
- * It'd be nice if there was a good way to tell if a driver supports
- * netif_carrier, but there really isn't.
- */
-static int bond_check_dev_link(struct bonding *bond,
-			       struct net_device *slave_dev, int reporting)
-{
-	const struct net_device_ops *slave_ops =3D slave_dev->netdev_ops;
-	struct mii_ioctl_data *mii;
-	struct ifreq ifr;
-	int ret;
-
-	if (!reporting && !netif_running(slave_dev))
-		return 0;
-
-	if (bond->params.use_carrier)
-		return netif_carrier_ok(slave_dev) ? BMSR_LSTATUS : 0;
-
-	/* Try to get link status using Ethtool first. */
-	if (slave_dev->ethtool_ops->get_link) {
-		netdev_lock_ops(slave_dev);
-		ret =3D slave_dev->ethtool_ops->get_link(slave_dev);
-		netdev_unlock_ops(slave_dev);
-
-		return ret ? BMSR_LSTATUS : 0;
-	}
-
-	/* Ethtool can't be used, fallback to MII ioctls. */
-	if (slave_ops->ndo_eth_ioctl) {
-		/* TODO: set pointer to correct ioctl on a per team member
-		 *       bases to make this more efficient. that is, once
-		 *       we determine the correct ioctl, we will always
-		 *       call it and not the others for that team
-		 *       member.
-		 */
-
-		/* We cannot assume that SIOCGMIIPHY will also read a
-		 * register; not all network drivers (e.g., e100)
-		 * support that.
-		 */
-
-		/* Yes, the mii is overlaid on the ifreq.ifr_ifru */
-		strscpy_pad(ifr.ifr_name, slave_dev->name, IFNAMSIZ);
-		mii =3D if_mii(&ifr);
-
-		if (dev_eth_ioctl(slave_dev, &ifr, SIOCGMIIPHY) =3D=3D 0) {
-			mii->reg_num =3D MII_BMSR;
-			if (dev_eth_ioctl(slave_dev, &ifr, SIOCGMIIREG) =3D=3D 0)
-				return mii->val_out & BMSR_LSTATUS;
-		}
-	}
-
-	/* If reporting, report that either there's no ndo_eth_ioctl,
-	 * or both SIOCGMIIREG and get_link failed (meaning that we
-	 * cannot report link status).  If not reporting, pretend
-	 * we're ok.
-	 */
-	return reporting ? -1 : BMSR_LSTATUS;
-}
-
 /*----------------------------- Multicast list --------------------------=
----*/
 =

 /* Push the promiscuity flag down to appropriate slaves */
@@ -1966,7 +1894,6 @@ int bond_enslave(struct net_device *bond_dev, struct=
 net_device *slave_dev,
 	const struct net_device_ops *slave_ops =3D slave_dev->netdev_ops;
 	struct slave *new_slave =3D NULL, *prev_slave;
 	struct sockaddr_storage ss;
-	int link_reporting;
 	int res =3D 0, i;
 =

 	if (slave_dev->flags & IFF_MASTER &&
@@ -1976,12 +1903,6 @@ int bond_enslave(struct net_device *bond_dev, struc=
t net_device *slave_dev,
 		return -EPERM;
 	}
 =

-	if (!bond->params.use_carrier &&
-	    slave_dev->ethtool_ops->get_link =3D=3D NULL &&
-	    slave_ops->ndo_eth_ioctl =3D=3D NULL) {
-		slave_warn(bond_dev, slave_dev, "no link monitoring support\n");
-	}
-
 	/* already in-use? */
 	if (netdev_is_rx_handler_busy(slave_dev)) {
 		SLAVE_NL_ERR(bond_dev, slave_dev, extack,
@@ -2195,29 +2116,10 @@ int bond_enslave(struct net_device *bond_dev, stru=
ct net_device *slave_dev,
 =

 	new_slave->last_tx =3D new_slave->last_rx;
 =

-	if (bond->params.miimon && !bond->params.use_carrier) {
-		link_reporting =3D bond_check_dev_link(bond, slave_dev, 1);
-
-		if ((link_reporting =3D=3D -1) && !bond->params.arp_interval) {
-			/* miimon is set but a bonded network driver
-			 * does not support ETHTOOL/MII and
-			 * arp_interval is not set.  Note: if
-			 * use_carrier is enabled, we will never go
-			 * here (because netif_carrier is always
-			 * supported); thus, we don't need to change
-			 * the messages for netif_carrier.
-			 */
-			slave_warn(bond_dev, slave_dev, "MII and ETHTOOL support not available=
 for slave, and arp_interval/arp_ip_target module parameters not specified=
, thus bonding will not detect link failures! see bonding.txt for details\=
n");
-		} else if (link_reporting =3D=3D -1) {
-			/* unable get link status using mii/ethtool */
-			slave_warn(bond_dev, slave_dev, "can't get link status from slave; the=
 network driver associated with this interface does not support MII or ETH=
TOOL link status reporting, thus miimon has no effect on this interface\n"=
);
-		}
-	}
-
 	/* check for initial state */
 	new_slave->link =3D BOND_LINK_NOCHANGE;
 	if (bond->params.miimon) {
-		if (bond_check_dev_link(bond, slave_dev, 0) =3D=3D BMSR_LSTATUS) {
+		if (netif_carrier_ok(slave_dev)) {
 			if (bond->params.updelay) {
 				bond_set_slave_link_state(new_slave,
 							  BOND_LINK_BACK,
@@ -2759,7 +2661,7 @@ static int bond_miimon_inspect(struct bonding *bond)
 	bond_for_each_slave_rcu(bond, slave, iter) {
 		bond_propose_link_state(slave, BOND_LINK_NOCHANGE);
 =

-		link_state =3D bond_check_dev_link(bond, slave->dev, 0);
+		link_state =3D netif_carrier_ok(slave->dev);
 =

 		switch (slave->link) {
 		case BOND_LINK_UP:
@@ -6257,10 +6159,10 @@ static int __init bond_check_params(struct bond_pa=
rams *params)
 		downdelay =3D 0;
 	}
 =

-	if ((use_carrier !=3D 0) && (use_carrier !=3D 1)) {
-		pr_warn("Warning: use_carrier module parameter (%d), not of valid value=
 (0/1), so it was set to 1\n",
-			use_carrier);
-		use_carrier =3D 1;
+	if (use_carrier !=3D 1) {
+		pr_err("Error: invalid use_carrier parameter (%d)\n",
+		       use_carrier);
+		return -EINVAL;
 	}
 =

 	if (num_peer_notif < 0 || num_peer_notif > 255) {
@@ -6507,7 +6409,6 @@ static int __init bond_check_params(struct bond_para=
ms *params)
 	params->updelay =3D updelay;
 	params->downdelay =3D downdelay;
 	params->peer_notif_delay =3D 0;
-	params->use_carrier =3D use_carrier;
 	params->lacp_active =3D 1;
 	params->lacp_fast =3D lacp_fast;
 	params->primary[0] =3D 0;
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond=
_netlink.c
index 57fff2421f1b..e573b34a1bbc 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -259,13 +259,11 @@ static int bond_changelink(struct net_device *bond_d=
ev, struct nlattr *tb[],
 			return err;
 	}
 	if (data[IFLA_BOND_USE_CARRIER]) {
-		int use_carrier =3D nla_get_u8(data[IFLA_BOND_USE_CARRIER]);
-
-		bond_opt_initval(&newval, use_carrier);
-		err =3D __bond_opt_set(bond, BOND_OPT_USE_CARRIER, &newval,
-				     data[IFLA_BOND_USE_CARRIER], extack);
-		if (err)
-			return err;
+		if (nla_get_u8(data[IFLA_BOND_USE_CARRIER]) !=3D 1) {
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_BOND_USE_CARRIER],
+					    "option obsolete, use_carrier cannot be disabled");
+			return -EINVAL;
+		}
 	}
 	if (data[IFLA_BOND_ARP_INTERVAL]) {
 		int arp_interval =3D nla_get_u32(data[IFLA_BOND_ARP_INTERVAL]);
@@ -688,7 +686,7 @@ static int bond_fill_info(struct sk_buff *skb,
 			bond->params.peer_notif_delay * bond->params.miimon))
 		goto nla_put_failure;
 =

-	if (nla_put_u8(skb, IFLA_BOND_USE_CARRIER, bond->params.use_carrier))
+	if (nla_put_u8(skb, IFLA_BOND_USE_CARRIER, 1))
 		goto nla_put_failure;
 =

 	if (nla_put_u32(skb, IFLA_BOND_ARP_INTERVAL, bond->params.arp_interval))
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond=
_options.c
index 3b6f815c55ff..c0a5eb8766b5 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -187,7 +187,6 @@ static const struct bond_opt_value bond_primary_resele=
ct_tbl[] =3D {
 };
 =

 static const struct bond_opt_value bond_use_carrier_tbl[] =3D {
-	{ "off", 0,  0},
 	{ "on",  1,  BOND_VALFLAG_DEFAULT},
 	{ NULL,  -1, 0}
 };
@@ -419,7 +418,7 @@ static const struct bond_option bond_opts[BOND_OPT_LAS=
T] =3D {
 	[BOND_OPT_USE_CARRIER] =3D {
 		.id =3D BOND_OPT_USE_CARRIER,
 		.name =3D "use_carrier",
-		.desc =3D "Use netif_carrier_ok (vs MII ioctls) in miimon",
+		.desc =3D "option obsolete, use_carrier cannot be disabled",
 		.values =3D bond_use_carrier_tbl,
 		.set =3D bond_option_use_carrier_set
 	},
@@ -1091,10 +1090,6 @@ static int bond_option_peer_notif_delay_set(struct =
bonding *bond,
 static int bond_option_use_carrier_set(struct bonding *bond,
 				       const struct bond_opt_value *newval)
 {
-	netdev_dbg(bond->dev, "Setting use_carrier to %llu\n",
-		   newval->value);
-	bond->params.use_carrier =3D newval->value;
-
 	return 0;
 }
 =

diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_s=
ysfs.c
index 1e13bb170515..9a75ad3181ab 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -467,14 +467,12 @@ static ssize_t bonding_show_primary_reselect(struct =
device *d,
 static DEVICE_ATTR(primary_reselect, 0644,
 		   bonding_show_primary_reselect, bonding_sysfs_store_option);
 =

-/* Show the use_carrier flag. */
+/* use_carrier is obsolete, but print value for compatibility */
 static ssize_t bonding_show_carrier(struct device *d,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct bonding *bond =3D to_bond(d);
-
-	return sysfs_emit(buf, "%d\n", bond->params.use_carrier);
+	return sysfs_emit(buf, "1\n");
 }
 static DEVICE_ATTR(use_carrier, 0644,
 		   bonding_show_carrier, bonding_sysfs_store_option);
diff --git a/include/net/bonding.h b/include/net/bonding.h
index e06f0d63b2c1..37335f62f579 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -126,7 +126,6 @@ struct bond_params {
 	int arp_interval;
 	int arp_validate;
 	int arp_all_targets;
-	int use_carrier;
 	int fail_over_mac;
 	int updelay;
 	int downdelay;
-- =

2.25.1


