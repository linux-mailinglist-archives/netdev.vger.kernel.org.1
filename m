Return-Path: <netdev+bounces-192808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 882C3AC11F9
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE4707AE51E
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFD818CC1D;
	Thu, 22 May 2025 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="SrUyXDkQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QjqVcrmA"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477617ADF8
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747934400; cv=none; b=H8xPBZq78dYo1EY9eEeuEgPyANM5GoSl0kxHW84Oad+8dKfUzP4wdkUs+baRQKA0RS1OUmQKFfPZ0w6cw5EEWSoJmlLfBGARiLmuqeQBghCcbvtbP623caGkUMr1yHIctwKbh1PFiV4Osqhww2fRO1uTme3FxezFkcuhyoDI3WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747934400; c=relaxed/simple;
	bh=NHrZ/IZJ6IrRTk6Y9XSHsFvIPW3Ndfr79+VJReBUwig=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=ZTTeFveeLr+6PWpFpt+JHHRg8Fd0JClSTcF9P7db2180vRPDg1ch/slIbF1fJ/dtGL/GvyRlqXvRut9wdTrrRJPlwdmvrAuCjUiDto8TvMzGCebWy+cxMFM6N7Hk/Yi2k8jF8kTuM//JHpcKy3s5jExL0FjxYvi/396TGJoRHuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=SrUyXDkQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QjqVcrmA; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D016025400F2;
	Thu, 22 May 2025 13:19:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 22 May 2025 13:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1747934396; x=1748020796; bh=Pn
	et9DSQTbbS0Xed/D3s7jBjFLkc5sXhGTv0b+ACzZk=; b=SrUyXDkQgAVmcqoJy6
	oVc3N57lJCAGufcfgNtU0bq2f3vzhWJViYX9fUhQx2OxxbfHw42XCFAkVHiDVkPZ
	EMwdT9NdaIAxdHISbVgXkISs0Wwj7+xDOj/4pPPNtIlE+WplosiN1oH1xJUDwCRB
	AhkTXc+JYx1clXz9c3pUSeUswG3dGRWx63g/ZLk1/D3X0hC17aXbdYhCrXVHaXuH
	v3mdjl9xVVaunG76wYhsjAtqwBaU/O/mvpu5gaGkWXWLh+t8YcHbB2Er0e7n6Dhr
	wNl66jX5/4vaar3gKz/vgR481tAJygm6g3z/JR8h83A5fxTn4ZwH36Hwo5It9r3q
	sbUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1747934396; x=1748020796; bh=Pnet9DSQTbbS0Xed/D3s7jBjFLkc
	5sXhGTv0b+ACzZk=; b=QjqVcrmAdHbHSOfjN0WHNPcQgQU6thfjl1MHxlWEegF7
	PKmvUVWKWw4h0swKUMhPVAMCA3+GZ6kT/VkF+c12X32hhHMMN1w/kXW0Th1Fchm3
	4exBayIuu8rsPSe55KbSNbXERwGvs0P5hbHTWBh/+APqigO0s4KJEt+lanz3GdyC
	CvlMm9pGypvn+qbzsr2mqJBsb9hDTDS23M5qdf31bw6G9Me4gxQUMiLWHVk2p66k
	CkrhYoNArZOdsgjmcUN8BmqGIXhZJGfFxZ4RPbsn2BoUV4s4eVzwxsmUabq8wmG/
	sBE6c1en/Hx2QqWzTJaqVQlmT7v/p4/hmNg/2kqAhw==
X-ME-Sender: <xms:vFwvaCAagE4Yy34wJJOegtBGY-pQcfsIRBaVCJFj6ySv05cfoMYkWg>
    <xme:vFwvaMj7eaHCu57R9YpNElllAUopDlav4arUlXUL8WhUSItYECtfFLxWuFabzpEQG
    fwrRQ5CnrmZZLmyatM>
X-ME-Received: <xmr:vFwvaFk85twElO_7aXyihRbsLqTtmTUNifSO6c5lmyHqUNISO3zfF3PV4YTG9XMZP4MjNGV9AihskF7_mkZWzRxJlVISvTLXjNKxzHznsElW0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeiheehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefhtgfgggfukfffvefvofesthhqmhdthhdtjeenucfhrhhomheptfhi
    tggrrhguuceuvghjrghrrghnohcuoehrihgtrghrugessggvjhgrrhgrnhhordhioheqne
    cuggftrfgrthhtvghrnhepieevgfeufeejfefgkefgkedtfeduvdffleetvdekgfegudff
    iefgffetjedvledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprhhitggrrhgusegsvghjrghrrghnohdrihhopdhnsggprhgtphhtthhopeel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghlrdhjrghmvghtsehinhhtvghl
    rdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrih
    hnthgvlhdrtghomhdprhgtphhtthhopeihvghhvgiikhgvlhhshhgssehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtph
    htthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhm
    rgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:vFwvaAwUL_2cH86QofDeq2H99VRv3JCw1zmOA6X3L1jxv9kehTCyKw>
    <xmx:vFwvaHQVYjgNBN0N08VXC0GGwuD3VgbztQblWnaDG02j1FTGHeeJ3w>
    <xmx:vFwvaLb23wBaINQea9gRnuzHCHOKOKyzEiRIg1hAcM4MJyyHlTMAAg>
    <xmx:vFwvaAQhaU1c7T8sD6LUjK7feW1-k6UrrZuJ3-BZWLmT4xHuB7x2Uw>
    <xmx:vFwvaCRCxqaQ-r3M7Hl-B2EByXPjoDeQaFpBRGME3vY3ptFQWrHaTLw3>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 13:19:54 -0400 (EDT)
From: Ricard Bejarano <ricard@bejarano.io>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Poor thunderbolt-net interface performance when bridged
Message-Id: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
Date: Thu, 22 May 2025 19:19:52 +0200
Cc: michael.jamet@intel.com,
 mika.westerberg@linux.intel.com,
 YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi all,

Please excuse me if this is not the right place or way to report this, =
in which case I'd appreciate a pointer to the proper forum. I've CC'd =
every one who showed up in get_maintainer.pl.

I'm investigating a performance issue in the bridging of traffic coming =
in via a Thunderbolt 3/4 (thunderbolt-net driver) network interface. I =
don't think this is tracked from what I could find online.

Summary:
When a thunderbolt-net interface is slave to a bridge, traffic in the =
"other slave interfaces -> bridge -> thunderbolt-net interface" =
direction approximates maximum line bandwidth (~9Gbps in Thunderbolt 3, =
~16Gbps in Thunderbolt 4); but traffic in the opposite "thunderbolt -> =
bridge -> other" direction drops to ~5Mbps (in my testing). More details =
below.

I need some pointers on how to proceed.

Thanks,
RB

--=20

## 1. Setup

Three hosts:
- `red`:
  - Board: Intel NUC8i5BEH2
  - CPU: 1x 4-core x86-64 (Intel Core i5-8259U)
  - RAM: 2x 8GB DDR4-2666 SODIMM CL19 (Crucial)
  - Disk: 1x 120GB SATA SSD (Crucial BX500)
  - Relevant interfaces:
    - `br0` (`bridge` driver, `10.0.0.1/24` address)
    - `tb0` (`thunderbolt-net` driver): maps to the board's Thunderbolt =
port, slave of `br0`
- `blue`:
  - Board: Intel NUC8i5BEH2
  - CPU: 1x 4-core x86-64 (Intel Core i5-8259U)
  - RAM: 2x 8GB DDR4-2666 SODIMM CL19 (Crucial)
  - Disk: 1x 120GB SATA SSD (Crucial BX500)
  - Relevant interfaces:
    - `br0` (`bridge` driver, `10.0.0.2/24` address)
    - `tb0` (`thunderbolt-net` driver): maps to the board's Thunderbolt =
port, slave of `br0`
    - `eno1` (`e1000e` driver): maps to the board's Ethernet port, slave =
of `br0`
- `purple`:
  - Board: Intel NUC8i5BEHS
  - CPU: 1x 4-core x86-64 (Intel Core i5-8260U)
  - RAM: 2x 8GB DDR4-2666 SODIMM CL19 (Crucial)
  - Disk: 1x 240GB M.2 SATA SSD (WD Green)
  - Relevant interfaces:
    - `br0` (`bridge` driver, `10.0.0.3/24` address)
    - `eno1` (`e1000e` driver): maps to the board's Ethernet port, slave =
of `br0`

Connected with two cables:
- Amazon Basics Thunderbolt 3 & 4 cable, connecting `red` (`tb0`) to =
`blue` (`tb0`).
- Monoprice SlimRun Cat6A Ethernet cable, connecting `blue` (`eno1`) to =
`purple` (`eno1`).

All three running Linux 6.14.7 (built from source) on Ubuntu Server =
24.04.2 LTS, running iperf 2.1.9 servers.
See "4. References" section for details.

## 2. The problem

As seen in [4.6.3b], traffic going in the `purple:br0 -> purple:eno1 -> =
blue:eno1 -> blue:br0 -> blue:tb0 -> red:tb0 -> red:br0` direction =
approaches line speed (~1Gbps).
However, per [4.6.3a], traffic going in the opposite `red:br0 -> red:tb0 =
-> blue:tb0 -> blue:br0 -> blue:eno1 -> purple:eno1 -> purple:br0` =
direction is several orders of magnitude slower (~5Mbps).

This is abnormal, given [4.6.1] sets the bidirectional Thunderbolt line =
speed at ~9Gbps and [4.6.2] sets the bidirectional Ethernet line speed =
at ~1Gbps.

Per the above, we can safely assume that the problem is localized at =
`blue`, specifically in how `blue` bridges traffic out of `tb0` and into =
`eno1`.

=46rom prior undocumented anecdata, we know this also happens in =
Thunderbolt-to-Thunderbolt bridged traffic, which hints at a problem in =
how traffic goes out of `tb0` and into `br0`, not with how traffic goes =
out of `br0` and into `eno1`.
This is further consolidated by the fact that Ethernet-to-Ethernet =
bridging is known to approach line speed in both directions (or =
otherwise the Internet would be way slower, I suppose).

And finally, hosts are only assuming an IP address at their respective =
`br0` interfaces, and [4.6.1] shows line speed performance in the =
`red:br0 -> red:tb0 -> blue:tb0 -> blue:br0` direction (and reverse).
Meaning, we can reduce the scope further to how traffic goes out of =
`tb0` and into some other slave of `br0`, but not `br0` itself.

## 3. The solution

    =C2=AF\_(;.;)_/=C2=AF

## 4. References

### 4.1. `uname -a`
#### 4.1.1. `red`
```shell
# red
$ uname -a
Linux red 6.14.7 #1 SMP PREEMPT_DYNAMIC Mon May 19 13:38:28 UTC 2025 =
x86_64 x86_64 x86_64 GNU/Linux
```
#### 4.1.2. `blue`
```shell
# blue
$ uname -a
Linux blue 6.14.7 #1 SMP PREEMPT_DYNAMIC Mon May 19 15:01:20 UTC 2025 =
x86_64 x86_64 x86_64 GNU/Linux
```
#### 4.1.3. `purple`
```shell
# purple
$ uname -a
Linux purple 6.14.7 #1 SMP PREEMPT_DYNAMIC Tue May 20 09:04:42 UTC 2025 =
x86_64 x86_64 x86_64 GNU/Linux
```

### 4.2. `ip a`
#### 4.2.1. `red`
```shell
# red
$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN =
group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: eno1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group =
default qlen 1000
    link/ether 94:c6:91:a3:f5:1a brd ff:ff:ff:ff:ff:ff
    altname enp0s31f6
3: wlp0s20f3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue =
state UP group default qlen 1000
    link/ether 04:d3:b0:0f:e6:cd brd ff:ff:ff:ff:ff:ff
    inet 192.168.10.201/23 metric 600 brd 192.168.11.255 scope global =
dynamic wlp0s20f3
       valid_lft 163sec preferred_lft 163sec
    inet6 fd9f:7271:415f:d845:6d3:b0ff:fe0f:e6cd/64 scope global dynamic =
mngtmpaddr noprefixroute
       valid_lft 1724sec preferred_lft 1724sec
    inet6 fe80::6d3:b0ff:fe0f:e6cd/64 scope link
       valid_lft forever preferred_lft forever
6: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state =
UP group default qlen 1000
    link/ether ce:42:52:00:a0:5b brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.1/24 brd 10.0.0.255 scope global br0
       valid_lft forever preferred_lft forever
7: tb0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master =
br0 state UP group default qlen 1000
    link/ether 02:5f:d6:57:71:93 brd ff:ff:ff:ff:ff:ff
```
#### 4.2.2. `blue`
```shell
# blue
$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN =
group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel =
master br0 state UP group default qlen 1000
    link/ether 1c:69:7a:00:22:99 brd ff:ff:ff:ff:ff:ff
    altname enp0s31f6
5: wlp0s20f3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue =
state UP group default qlen 1000
    link/ether d0:c6:37:09:01:5a brd ff:ff:ff:ff:ff:ff
    inet 192.168.10.200/23 metric 600 brd 192.168.11.255 scope global =
dynamic wlp0s20f3
       valid_lft 247sec preferred_lft 247sec
    inet6 fd9f:7271:415f:d845:d2c6:37ff:fe09:15a/64 scope global dynamic =
mngtmpaddr noprefixroute
       valid_lft 1651sec preferred_lft 1651sec
    inet6 fe80::d2c6:37ff:fe09:15a/64 scope link
       valid_lft forever preferred_lft forever
6: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state =
UP group default qlen 1000
    link/ether 3a:4d:83:e0:ab:3b brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.2/24 brd 10.0.0.255 scope global br0
       valid_lft forever preferred_lft forever
7: tb0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel master =
br0 state UP group default qlen 1000
    link/ether 02:70:19:dc:92:96 brd ff:ff:ff:ff:ff:ff
```
#### 4.2.3. `purple`
```shell
# purple
$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN =
group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel =
master br0 state UP group default qlen 1000
    link/ether 1c:69:7a:60:d8:69 brd ff:ff:ff:ff:ff:ff
    altname enp0s31f6
3: wlp0s20f3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue =
state UP group default qlen 1000
    link/ether 94:e6:f7:7c:2d:fb brd ff:ff:ff:ff:ff:ff
    inet 192.168.10.199/23 metric 600 brd 192.168.11.255 scope global =
dynamic wlp0s20f3
       valid_lft 165sec preferred_lft 165sec
    inet6 fd9f:7271:415f:d845:96e6:f7ff:fe7c:2dfb/64 scope global =
dynamic mngtmpaddr noprefixroute
       valid_lft 1640sec preferred_lft 1640sec
    inet6 fe80::96e6:f7ff:fe7c:2dfb/64 scope link
       valid_lft forever preferred_lft forever
4: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state =
UP group default qlen 1000
    link/ether 1a:45:1d:c0:46:02 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.3/24 brd 10.0.0.255 scope global br0
       valid_lft forever preferred_lft forever
```

### 4.3. `ethtool -i br0`
#### 4.3.1. `red`
```shell
# red
$ ethtool -i br0
driver: bridge
version: 2.3
firmware-version: N/A
expansion-rom-version:
bus-info: N/A
supports-statistics: no
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: no
```
#### 4.3.2. `blue`
```shell
# blue
$ ethtool -i br0
driver: bridge
version: 2.3
firmware-version: N/A
expansion-rom-version:
bus-info: N/A
supports-statistics: no
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: no
```
#### 4.3.3. `purple`
```shell
# purple
$ ethtool -i br0
driver: bridge
version: 2.3
firmware-version: N/A
expansion-rom-version:
bus-info: N/A
supports-statistics: no
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: no
```

### 4.4. `ethtool -i tb0`
#### 4.4.1. `red`
```shell
# red
$ ethtool -i tb0
driver: thunderbolt-net
version: 6.14.7
firmware-version:
expansion-rom-version:
bus-info: 0-1.0
supports-statistics: no
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: no
```
#### 4.4.2. `blue`
```shell
# blue
$ ethtool -i tb0
driver: thunderbolt-net
version: 6.14.7
firmware-version:
expansion-rom-version:
bus-info: 0-1.0
supports-statistics: no
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: no
```

### 4.5. `ethtool -i eno1`
#### 4.4.1. `blue`
```shell
# blue
$ ethtool -i eno1
driver: e1000e
version: 6.14.7
firmware-version: 0.4-4
expansion-rom-version:
bus-info: 0000:00:1f.6
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes
```
#### 4.4.2. `purple`
```shell
# purple
$ ethtool -i eno1
driver: e1000e
version: 6.14.7
firmware-version: 0.4-4
expansion-rom-version:
bus-info: 0000:00:1f.6
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes
```

### 4.6. `iperf` tests
#### 4.6.1a. `red` to `blue`
```shell
# red
$ iperf -c 10.0.0.2
------------------------------------------------------------
Client connecting to 10.0.0.2, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 10.0.0.1 port 38902 connected with 10.0.0.2 port 5001 =
(icwnd/mss/irtt=3D14/1448/538)
[ ID] Interval       Transfer     Bandwidth
[  1] 0.0000-10.0076 sec  11.0 GBytes  9.40 Gbits/sec
```
#### 4.6.1b. `blue` to `red`
```shell
# blue
$ iperf -c 10.0.0.1
------------------------------------------------------------
Client connecting to 10.0.0.1, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 10.0.0.2 port 49660 connected with 10.0.0.1 port 5001 =
(icwnd/mss/irtt=3D14/1448/464)
[ ID] Interval       Transfer     Bandwidth
[  1] 0.0000-10.0079 sec  10.8 GBytes  9.26 Gbits/sec
```
#### 4.6.2a. `purple` to `blue`
```shell
# purple
$ iperf -c 10.0.0.2
------------------------------------------------------------
Client connecting to 10.0.0.2, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 10.0.0.3 port 56150 connected with 10.0.0.2 port 5001 =
(icwnd/mss/irtt=3D14/1448/580)
[ ID] Interval       Transfer     Bandwidth
[  1] 0.0000-10.0358 sec  1.09 GBytes   933 Mbits/sec
```
#### 4.6.2b. `blue` to `purple`
```shell
# blue
$ iperf -c 10.0.0.3
------------------------------------------------------------
Client connecting to 10.0.0.3, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 10.0.0.2 port 37106 connected with 10.0.0.3 port 5001 =
(icwnd/mss/irtt=3D14/1448/958)
[ ID] Interval       Transfer     Bandwidth
[  1] 0.0000-10.0239 sec  1.09 GBytes   934 Mbits/sec
```
#### 4.6.3a. `red` to `purple`
```shell
# red
$ iperf -c 10.0.0.3
------------------------------------------------------------
Client connecting to 10.0.0.3, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 10.0.0.1 port 38260 connected with 10.0.0.3 port 5001 =
(icwnd/mss/irtt=3D14/1448/1578)
[ ID] Interval       Transfer     Bandwidth
[  1] 0.0000-10.2234 sec  5.88 MBytes  4.82 Mbits/sec
```
#### 4.6.3b. `purple` to `red`
```shell
# purple
$ iperf -c 10.0.0.1
------------------------------------------------------------
Client connecting to 10.0.0.1, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  1] local 10.0.0.3 port 48392 connected with 10.0.0.1 port 5001 =
(icwnd/mss/irtt=3D14/1448/1243)
[ ID] Interval       Transfer     Bandwidth
[  1] 0.0000-10.0233 sec  1.09 GBytes   932 Mbits/sec
```


