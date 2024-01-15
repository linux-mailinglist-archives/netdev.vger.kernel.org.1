Return-Path: <netdev+bounces-63554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B459882DEF3
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 19:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092C91F22BB9
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 18:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC02182A1;
	Mon, 15 Jan 2024 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeIOYa8v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA61805E
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e7a9c527dso9690985e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 10:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705342548; x=1705947348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+U/s4Gu/S/t1TJGKHRZT+AjAm7rta8I7uR7DBe8epZg=;
        b=XeIOYa8vXvdSxjUFD4tvlg3aKzMHG75kK88a++cGEv9nktYqLAz6qbwjOi1BuhQqRT
         v6Yw/1ZevYbIk+0i+9vTtDyY4yiTvtmY1skdzsgtij/fon91qSUeWfHcuMElcNn8eMcy
         5bsMzbvshNKuTipSWuMHDCN4p7gBODKse1R/rZeBoJs3lKdXoDijtmrZ3BVFnnaikfLz
         ksqcKc4BDKcPacn+9gOmqDTNz1lWnDIkUJRv1HUiw5RpjINCYb4VXriaYhsAiq1bTXQi
         hhbOpr+oajOYfoFIzZoiouQXyQXOkBr23/UtwE2FNQRPvPhz4KZFyfSkKxokBjGkniTD
         HT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705342548; x=1705947348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+U/s4Gu/S/t1TJGKHRZT+AjAm7rta8I7uR7DBe8epZg=;
        b=SyLRC6TZ4nRq5QkXoutRM1oBqqlB+EHIvzkW8EgdvZ4ajikoTyAlY846R+3+GWaatQ
         MI7ZPb162tKC81P0YT8wIM3+UQChesK9+2W8AfMhv3Ehr0mXiVx8pI2bvz006WtioXnx
         I1uwAjDNJ4+rgKIW2Kvf5nnFEAH0CKvtg1klRcyaK8Gxh0QwG68TarrXU8KrHhircu0f
         SbjJER67Wl69s4Jz8F22UfTRofJRv8n9vWWvneiDmDzgEj5wZw3kiLcBOk2QqO2N+kwp
         lSZYpK94+NL+AOa0TvCbwYDcbvxCDVtldj+XeupyrFOPKB7ZZlmTz8mthuSC8GySJtT3
         ySLw==
X-Gm-Message-State: AOJu0YwcGORQwC72xKl3//CflCNH3dJ5qfo2YiiIOmI/Gu1OllHqvvUD
	TP/K0xfaCwo1y2MxiIJ9iEeOgXpyPgWZ0Q==
X-Google-Smtp-Source: AGHT+IHbJVoqKP13ukXq6kJd8+yQWXKNerDsGMif01xgLABNYqrIm8zHWEdJ2HCDecjlAOfMKxa2kQ==
X-Received: by 2002:a7b:c349:0:b0:40e:4337:84b2 with SMTP id l9-20020a7bc349000000b0040e433784b2mr1766596wmj.361.1705342547592;
        Mon, 15 Jan 2024 10:15:47 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0040d1bd0e716sm16777267wmq.9.2024.01.15.10.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 10:15:47 -0800 (PST)
Date: Mon, 15 Jan 2024 20:15:45 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Simon Waterer <simon.waterer@gmail.com>
Cc: Arun Ramadoss <arun.ramadoss@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Subject: Re: DSA switch: VLAN tag not added on packets directed to a
 PVID,untagged switchport
Message-ID: <20240115181545.ixme3ao4z4gyn5qq@skbuf>
References: <CABumfLzJmXDN_W-8Z=p9KyKUVi_HhS7o_poBkeKHS2BkAiyYpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABumfLzJmXDN_W-8Z=p9KyKUVi_HhS7o_poBkeKHS2BkAiyYpw@mail.gmail.com>

Hello Simon,

The title of your email is not a good summary of the problem. As phrased,
the title does not even describe a problem. "VLAN tags not added towards
an egress-untagged port" is "working as per the description". You seem
to be looking at a different (set of) problems, which I will detail
below.

On Mon, Jan 15, 2024 at 05:37:21PM +1300, Simon Waterer wrote:
> Hello,
> 
> I'm using a DSA switch with vlan_filtering enabled.
> 
> When tcpdumping on the DSA master interface, and looking at the
> packets egressing the Linux host towards the CPU port of the switch,
> I'm observing that 802.1q vlan tags are only being added on packets
> directed towards a trunk port of the switch. VLAN tags are not being
> added on packets directed to a PVID,untagged switchport. The VLAN tags
> are seen when tcpdumping the br0 device, but are lost by the time they
> reach the DSA master interface.

This part is expected of the bridge driver when the TX path is not
offloaded [1]. It is the same regardless of the bridge port driver
(DSA, e1000e, etc). If the software bridge decides that a VLAN-tagged
skb should egress a port and that VLAN is untagged on the port, the VLAN
tag will be stripped, otherwise it would appear on the wire.

> This is an issue as the switch hardware proceeds to tag the packet
> with the default VLAN id 1 when the untagged packet ingresses the
> switch via the CPU port.
> 
> Is this behaviour expected of DSA switch integration with VLANs?
> Please may anyone offer a suggestion on what further I may look into
> to troubleshoot this issue?

So DSA tagging protocol drivers (in this case lan937x_netdev_ops) are
expected to transmit packets in a way that bypasses the switching layer
(aka they are sent as "control packets" rather than "data plane packets").
Meaning that they are force-injected into the port specified in the DSA
tag, regardless of FDB lookups, no VLAN processing, STP state of that
port, etc. These are all bridging layer functions, so they should all be
bypassed by the normal xmit procedure. The switch strips the DSA tag,
and the rest of the packet (what appears on the wire) should be
identical with what the host has passed it.

This means that the problem is not in the bridge driver, not in the DSA
master driver, and not in the DSA framework. It is in the Microchip KSZ
switch driver, user of the DSA framework.
From your logs, it appears that packets injected by Linux don't
(completely) bypass the switching layer. They get classified to VID 1,
which apparently is the PVID of the CPU port (for which no net_device
exists). In this case, it has to be studied what can be done to
configure the switch/tagger pair to behave as closely as possible to
the expectation.

The problem, one might argue, is that the switch is configured (by whom?
I don't know - maybe this is the hardware default, maybe the driver has
some code which I haven't found) with PVID=1 on the CPU port. The DSA
framework does not manage the PVID VLAN of the CPU port, it is the
driver's private responsibility. The problem with VID=1 is that it is a
user visible VLAN, so the behavior of untagged traffic can be modulated
(involuntarily) by the user, when issuing 'bridge vlan add/del' commands
on user ports. It's better to use a VLAN that is not user visible, like
VID=4095, as the VLAN to which the CPU port classifies VLAN-untagged
packets. All user ports should be members of this VLAN, and all with the
"egress untagged" property, so that no one outside the system knows that
VID=4095 was used.

As opposed to VID=4095, it is possible for the user to reinstall VID=1
without the "egress untagged" flag, and what will happen is that packets
which were untagged in software are now VLAN-tagged on the wire.

This also seems to be what's happening in your case (VID=1 behaves as
egress-tagged), but you haven't presented any command which alters VID=1
below, so it is strange [2]. I think you may have become a little bit
confused by all the moving parts and many bugs in this driver and the
way in which they interact - and so have I.

For example, I found this patch on ksz8:

commit af01754f9e3c553a2ee63b4693c79a3956e230ab
Author: Ben Hutchings <ben.hutchings@mind.be>
Date:   Tue Aug 10 00:59:47 2021 +0200

    net: dsa: microchip: ksz8795: Fix VLAN untagged flag change on deletion

    When a VLAN is deleted from a port, the flags in struct
    switchdev_obj_port_vlan are always 0.  ksz8_port_vlan_del() copies the
    BRIDGE_VLAN_INFO_UNTAGGED flag to the port's Tag Removal flag, and
    therefore always clears it.

    In case there are multiple VLANs configured as untagged on this port -
    which seems useless, but is allowed - deleting one of them changes the
    remaining VLANs to be tagged.

    It's only ever necessary to change this flag when a VLAN is added to
    the port, so leave it unchanged in ksz8_port_vlan_del().

    Fixes: e66f840c08a2 ("net: dsa: ksz: Add Microchip KSZ8795 DSA driver")
    Signed-off-by: Ben Hutchings <ben.hutchings@mind.be>
    Signed-off-by: David S. Miller <davem@davemloft.net>

and the ksz9477_port_vlan_del() (also used by LAN937x) seems to have a
similar issue as well: "vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED" is
invalid on port_vlan_del(), and ought to be ignored, but is not. Sadly,
I don't think it helps the explanation here, because it just means that
this is dead code:

	if (untagged)
		vlan_table[1] &= ~BIT(port);

...

Separately, another bug in ksz9477_port_vlan_del() is this:

	if (pvid == vlan->vid)
		pvid = 1;

When deleting the PVID VLAN, the documented expected behavior of Linux
is that the port should drop incoming untagged and priority-tagged
traffic. But this driver changes the PVID to 1, and that's not ok.

In ksz9477_port_vlan_add(), I should also mention that the BIT(dev->cpu_port)
handling should not be there. The DSA framework manages VLANs on the shared
(CPU and DSA) ports explicitly since commit 134ef2388e7f ("net: dsa: add
explicit support for host bridge VLANs") from kernel 5.18, and is
guaranteed to do so better than the driver. Its handling from vlan_table[2]
(the port membership mask) should be removed and tested without it.
The other use of dev->cpu_port is to control the "egress untagged" port
mask from vlan_table[1], aka to always program the VLANs as
egress-tagged towards the CPU. That is fine to keep, because the VLAN
"flags" that DSA framework notifies the CPU port with are the flags of
the VLAN added on the "br0" interface (with the 'self' flag). It is
legal for drivers to override this. But, when doing this, the driver
should set ds->untag_bridge_pvid = true, to remove the VLAN tags in
the software RX path if not needed.

> More information:
> 
> The DSA switch consists of 2 Microchip LAN9373 switches in cascade mode.
> The system is iMX8 running Linux 6.1.36.
> The master interface is eth1.
> The user ports are labelled afe0, afe1, afe2, etc.
> 
> Setup is as follows:
> 
> ethtool -K eth1 rx-vlan-offload off # in order to see vlan tags on eth1 ingress traffic
> ip link add br0 type bridge
> ip link add link br0 name br0.10 type vlan id 10
> ip addr add 192.168.10.1/24 dev br0.10
> ip link add link br0 name br0.20 type vlan id 20
> ip addr add 192.168.20.1/24 dev br0.20
> ip link add link br0 name br0.30 type vlan id 30
> ip addr add 192.168.30.1/24 dev br0.30
> ip link set dev afe0 master br0
> ip link set dev afe1 master br0
> ip link set dev br0 type bridge vlan_filtering 1

This right here, while a perfectly legal command, also makes evaluating
what goes on all that more difficult.

See, there is a difference between creating a bridge as VLAN-aware
straight away (ip link add dev br0 type bridge vlan_filtering 1) and
making it VLAN-unaware, telling the ports to join the bridge, and
then making it VLAN-aware dynamically.

There was a bug in the DSA framework and API which got fixed, but it was
not fully understood of what the impact upon drivers was, so their old
behavior was kept intact, when those could not be tested. Nowadays, this
is guarded by a flag unset in a minority of drivers like this:

	ds->configure_vlan_while_not_filtering = false;

which the ksz_common.c file executes exactly like so.

When opting into this legacy and known-buggy behavior, what happens is
that your afeN ports first join the VLAN-unaware bridge. The bridge
notifies the default VLANs through switchdev (aka VID=1, as PVID +
egress untagged), but ds->configure_vlan_while_not_filtering is set, and
as the DSA core logic goes, "we are not VLAN-filtering, so we don't
configure the VLANs". Why this logic is as such, is not very relevant or
worth digging into. What is relevant is that with the logic enabled, DSA
will not call .port_vlan_add() for VID=1, and will instead print a
"skipping configuration of VLAN" warning extack message through netlink.

If VID=1 is not actually programmed as egress-untagged by the driver
because of the above bug, I can only suspect that the hardware comes
pre-programmed with VID=1 as PVID and egress-tagged on all ports as the
default, and no one overrides this? Thus, untagged packets received on
the CPU port are later sent with VID=1 on the wire, whereas VLAN-tagged
packets received on the CPU port are always classified to the VID from
the 802.1Q header, and never to the CPU port PVID. To me it seems
plausible that this is what's happening, with 2 bugs interacting with
each other in this roundabout way. It doesn't make much sense otherwise.
Or you may have run some more commands which you haven't shown, which
have affected the state of the system.

I would absolutely appreciate patches to handle this condition correctly,
so that we can get rid of the ds->configure_vlan_while_not_filtering
flag. To handle it correctly would mean to do as instructed in the
"Bridge VLAN filtering" section of Documentation/networking/switchdev.rst.

> bridge vlan add dev br0 vid 10 self
> bridge vlan add dev br0 vid 20 self
> bridge vlan add dev br0 vid 30 self
> bridge vlan add vid 10 dev afe0
> bridge vlan add vid 30 dev afe0
> bridge vlan add vid 20 dev afe0
> bridge vlan add vid 30 dev afe1 pvid untagged
> ip link set dev br0 up
> ip link set dev br0.10 up
> ip link set dev br0.20 up
> ip link set dev br0.30 up
> ip link set dev afe0 up
> ip link set dev afe1 up
> 
> 
> Example showing expected behaviour:
> -----------------------------------
> When sending a ping to 192.168.30.1 from another device (IP:
> 192.168.30.251) that is connected to the tagged port "afe0", behaviour
> is as expected:
> 
> tcpdump on device sending the ping:
>    listening on enx00e04c3ff8c2, link-type EN10MB (Ethernet), capture size 262144 bytes
>    13:23:37.412278 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype 802.1Q (0x8100), length 46: vlan 30, p 0, ethertype ARP, Request who-has 192.168.30.1 tell 192.168.30.251, length 28
>    13:23:37.414159 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 60: vlan 30, p 0, ethertype ARP, Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 42
>    13:23:37.414170 00:e0:4c:3f:f8:c2 > ea:38:5b:06:97:75, ethertype 802.1Q (0x8100), length 102: vlan 30, p 0, ethertype IPv4, 192.168.30.251 > 192.168.30.1: ICMP echo request, id 48, seq 1, length      64
>    13:23:37.415247 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 102: vlan 30, p 0, ethertype IPv4, 192.168.30.1 > 192.168.30.251: ICMP echo reply, id 48, seq 1, length 64
> 
>    Here, the ping is successful with the device receiving the ARP
> reply and ICMP echo reply with vlan id 30 (as expected).
> 
> tcpdump on DSA master interface eth1:
>    listening on eth1, link-type NULL (BSD loopback), snapshot length 262144 bytes
>    13:27:46.917763 AF Unknown (4294967295), length 65:
>        0x0000:  ffff 00e0 4c3f f8c2 8100 001e 0806 0001  ....L?..........
>        0x0010:  0800 0604 0001 00e0 4c3f f8c2 c0a8 1efb  ........L?......
>        0x0020:  0000 0000 0000 c0a8 1e01 0000 0000 0000  ................
>        0x0030:  0000 0000 0000 0000 0000 0000 00         .............
>    13:27:46.917905 AF Unknown (14699583), length 63:
>        0x0000:  f8c2 ea38 5b06 9775 8100 001e 0806 0001  ...8[..u........
>        0x0010:  0800 0604 0002 ea38 5b06 9775 c0a8 1e01  .......8[..u....
>        0x0020:  00e0 4c3f f8c2 c0a8 1efb 0000 0000 0000  ..L?............
>        0x0030:  0000 0000 0000 0000 2000 01              ...........
>    13:27:46.918932 AF Unknown (3929561862), length 103:
>        0x0000:  9775 00e0 4c3f f8c2 8100 001e 0800 4500  .u..L?........E.
>        0x0010:  0054 022e 4000 4001 7a2e c0a8 1efb c0a8  .T..@.@.z.......
>        0x0020:  1e01 0800 28d1 0030 0001 097b a465 0000  ....(..0...{.e..
>        0x0030:  0000 5c4a 0600 0000 0000 1011 1213 1415  ..\J............
>        0x0040:  1617 1819 1a1b 1c1d 1e1f 2021 2223 2425  ...........!"#$%
>        0x0050:  2627 2829 2a2b 2c2d 2e2f 3031 3233 3435  &'()*+,-./012345
>        0x0060:  3637 00                                  67.
>    13:27:46.919035 AF Unknown (14699583), length 105:
>        0x0000:  f8c2 ea38 5b06 9775 8100 001e 0800 4500  ...8[..u......E.
>        0x0010:  0054 f562 0000 4001 c6f9 c0a8 1e01 c0a8  .T.b..@.........
>        0x0020:  1efb 0000 30d1 0030 0001 097b a465 0000  ....0..0...{.e..
>        0x0030:  0000 5c4a 0600 0000 0000 1011 1213 1415  ..\J............
>        0x0040:  1617 1819 1a1b 1c1d 1e1f 2021 2223 2425  ...........!"#$%
>        0x0050:  2627 2829 2a2b 2c2d 2e2f 3031 3233 3435  &'()*+,-./012345
>        0x0060:  3637 2000 01                             67...
> 
>    Here, the vlan tag (81 00 00 1e) is shown on both the ingress and
> egress packets with expected vid 30 (0x1e).

Ok, you are showing here that when we are targeting afe0 (egress-tagged
in VID 30), both ingress and egress packets are tagged with VID=30.
Not surprising.

>    Here also, the tailtags from/to the switch hardware (tag_ksz) are observed:
>    - ingress tailtags (the 00 octet at end of ingress packets).
>    - egress tailtags (the 20 00 01 octets at end of egress packets)
> 
> tcpdump on br0:
>    listening on br0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
>    13:27:46.917815 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype 802.1Q (0x8100), length 64: vlan 30, p 0, ethertype ARP (0x0806), Request who-has 192.168.30.1 tell 192.168.30.251, length 46
>    13:27:46.917869 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 46: vlan 30, p 0, ethertype ARP (0x0806), Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 28
>    13:27:46.918945 00:e0:4c:3f:f8:c2 > ea:38:5b:06:97:75, ethertype 802.1Q (0x8100), length 102: vlan 30, p 0, ethertype IPv4 (0x0800), 192.168.30.251 > 192.168.30.1: ICMP echo request, id 48, seq       1, length 64
>    13:27:46.919016 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 102: vlan 30, p 0, ethertype IPv4 (0x0800), 192.168.30.1 > 192.168.30.251: ICMP echo reply, id 48, seq 1,      length 64
> 
>    Here, vlan tag IDs have been decoded as the ingress packets passes
> up to br0 and same vlan id 30 is shown on the reply packets.

Yes, the br0 termination path sees packets tagged with VID=30, and you
use the br0.30 VLAN upper to strip VID=30 and consume this traffic as
untagged. Clear and as expected.

> Example showing the erroneous behaviour:
> ----------------------------------------
> But, when connecting the other device to the PVID,untagged port
> "afe1", the following is observed:
> 
> tcpdump on device sending the ping:
>    listening on enx00e04c3ff8c2, link-type EN10MB (Ethernet), capture size 262144 bytes
>    13:31:23.862699 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.168.30.1 tell 192.168.30.251, length 28
>    13:31:23.864551 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 64: vlan 1, p 0, ethertype ARP, Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 46
>    13:31:24.890952 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.168.30.1 tell 192.168.30.251, length 28
>    13:31:24.892810 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 64: vlan 1, p 0, ethertype ARP, Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 46
>    13:31:25.910959 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.168.30.1 tell 192.168.30.251, length 28
>    13:31:25.912828 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 64: vlan 1, p 0, ethertype ARP, Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 46
> 
>    Here, the reply packet errorneously contains vlan tag for vlan id
> 1, when it was expected to be untagged-on-egress from the switch, and
> was expected to have vlan id 30.

So "reply packet" (ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2) means actually
what afe1 puts on the wire.

I'm not sure why on the wire, it was expected to have VID=30 as you say,
rather than be untagged? The ARP request (00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff)
was VLAN-untagged.

> tcpdump on DSA master interface eth1:
>    listening on eth1, link-type NULL (BSD loopback), snapshot length
> 262144 bytes
>    13:35:33.363982 AF Unknown (4294967295), length 65:
>        0x0000:  ffff 00e0 4c3f f8c2 8100 001e 0806 0001  ....L?..........
>        0x0010:  0800 0604 0001 00e0 4c3f f8c2 c0a8 1efb  ........L?......
>        0x0020:  0000 0000 0000 c0a8 1e01 0000 0000 0000  ................
>        0x0030:  0000 0000 0000 0000 0000 0000 01         .............
>    13:35:33.364186 AF Unknown (14699583), length 63:
>        0x0000:  f8c2 ea38 5b06 9775 0806 0001 0800 0604  ...8[..u........
>        0x0010:  0002 ea38 5b06 9775 c0a8 1e01 00e0 4c3f  ...8[..u......L?
>        0x0020:  f8c2 c0a8 1efb 0000 0000 0000 0000 0000  ................
>        0x0030:  0000 0000 0000 0000 2000 02              ...........
>    13:35:34.392257 AF Unknown (4294967295), length 65:
>        0x0000:  ffff 00e0 4c3f f8c2 8100 001e 0806 0001  ....L?..........
>        0x0010:  0800 0604 0001 00e0 4c3f f8c2 c0a8 1efb  ........L?......
>        0x0020:  0000 0000 0000 c0a8 1e01 0000 0000 0000  ................
>        0x0030:  0000 0000 0000 0000 0000 0000 01         .............
>    13:35:34.392385 AF Unknown (14699583), length 63:
>        0x0000:  f8c2 ea38 5b06 9775 0806 0001 0800 0604  ...8[..u........
>        0x0010:  0002 ea38 5b06 9775 c0a8 1e01 00e0 4c3f  ...8[..u......L?
>        0x0020:  f8c2 c0a8 1efb 0000 0000 0000 0000 0000  ................
>        0x0030:  0000 0000 0000 0000 2000 02              ...........
>    13:35:35.412251 AF Unknown (4294967295), length 65:
>        0x0000:  ffff 00e0 4c3f f8c2 8100 001e 0806 0001  ....L?..........
>        0x0010:  0800 0604 0001 00e0 4c3f f8c2 c0a8 1efb  ........L?......
>        0x0020:  0000 0000 0000 c0a8 1e01 0000 0000 0000  ................
>        0x0030:  0000 0000 0000 0000 0000 0000 01         .............
>    13:35:35.412384 AF Unknown (14699583), length 63:
>        0x0000:  f8c2 ea38 5b06 9775 0806 0001 0800 0604  ...8[..u........
>        0x0010:  0002 ea38 5b06 9775 c0a8 1e01 00e0 4c3f  ...8[..u......L?
>        0x0020:  f8c2 c0a8 1efb 0000 0000 0000 0000 0000  ................
>        0x0030:  0000 0000 0000 0000 2000 02              ...........
> 
>    Here, the vlan tag (81 00 00 1e) is *ONLY* present on the *ingress*
> packets (the ARP requests), and *ABSENT* from the *egress* packets
> (the ARP replies).

Yes, this is normal operation which can be reproduced with any other
driver, this is not the problem. The problem is that the switch inserts
VID=1 into untagged packets when it was not told to do that.

>    Here also, the tailtags from/to the switch hardware (tag_ksz) are
> observed and are as expected, this time corresponding to switch-port
> "afe1".
> 
> tcpdump on br0:
>    listening on br0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
>    13:35:33.364069 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype 802.1Q (0x8100), length 64: vlan 30, p 0, ethertype ARP (0x0806), Request who-has 192.168.30.1 tell 192.168.30.251, length 46
>    13:35:33.364154 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 46: vlan 30, p 0, ethertype ARP (0x0806), Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 28
>    13:35:34.392307 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype 802.1Q (0x8100), length 64: vlan 30, p 0, ethertype ARP (0x0806), Request who-has 192.168.30.1 tell 192.168.30.251, length 46
>    13:35:34.392356 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 46: vlan 30, p 0, ethertype ARP (0x0806), Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 28
>    13:35:35.412300 00:e0:4c:3f:f8:c2 > ff:ff:ff:ff:ff:ff, ethertype 802.1Q (0x8100), length 64: vlan 30, p 0, ethertype ARP (0x0806), Request who-has 192.168.30.1 tell 192.168.30.251, length 46
>    13:35:35.412355 ea:38:5b:06:97:75 > 00:e0:4c:3f:f8:c2, ethertype 802.1Q (0x8100), length 46: vlan 30, p 0, ethertype ARP (0x0806), Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 28
> 
>    Here, vlan tag IDs have been decoded as the packet passes up to
> br0, and vlan id 30 is present on the replies, yet the vlan tag appear
> to be dropped when the packet is sent down from br0 to eth1, as not
> visible in the tcpdump of eth1 above.
> 
> I have checked and confirmed that "tx-vlan-offload" is "off" for eth1.

The "tx-vlan-offload" flag is not relevant for this.

> Other information:
> ------------------
> root@imx8qxp-var-som:~# route -n
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
> 10.10.1.0       0.0.0.0         255.255.255.0   U     0      0        0 eth0
> 192.168.10.0    0.0.0.0         255.255.255.0   U     0      0        0 br0.10
> 192.168.20.0    0.0.0.0         255.255.255.0   U     0      0        0 br0.20
> 192.168.30.0    0.0.0.0         255.255.255.0   U     0      0        0 br0.30
> 
> root@imx8qxp-var-som:~# bridge vlan
> port              vlan-id
> afe0              1 PVID Egress Untagged
>                  10
>                  20
>                  30
> afe1              1 Egress Untagged
>                  30 PVID Egress Untagged
> afe3              1 Egress Untagged
>                  30 PVID Egress Untagged
> afe4              1 Egress Untagged
>                  20 PVID Egress Untagged
> afe2              1 Egress Untagged
>                  30 PVID Egress Untagged
> afe5              1 Egress Untagged
>                  30 PVID Egress Untagged
> afe6              1 Egress Untagged
>                  30 PVID Egress Untagged
> afe8              1 Egress Untagged
>                  30 PVID Egress Untagged
> afe9              1 Egress Untagged
>                  30 PVID Egress Untagged
> afe7              1 Egress Untagged
>                  30 PVID Egress Untagged
> br0               1 PVID Egress Untagged
>                  10
>                  20
>                  30
> 
> Note: Another observation is that even after running "bridge vlan del
> dev afe0 vid 1" or "bridge vlan del dev afe1 vid 1", the entry for
> vlan-id 1 never disappears from the ouput of "bridge vlan show"

How sure are you about this? It does not seem very plausible.
Did the "bridge vlan del" command succeed?

> root@imx8qxp-var-som:~# bridge fdb
> 33:33:00:00:00:01 dev eth0 self permanent
> 01:00:5e:00:00:01 dev eth0 self permanent
> 33:33:00:00:00:01 dev eth1 self permanent
> 01:00:5e:00:00:01 dev eth1 self permanent
> f8:dc:7a:bb:54:a1 dev afe0 vlan 20 master br0 permanent
> f8:dc:7a:bb:54:a1 dev afe0 vlan 30 master br0 permanent
> f8:dc:7a:bb:54:a1 dev afe0 vlan 10 master br0 permanent
> f8:dc:7a:bb:54:a1 dev afe0 vlan 1 master br0 permanent
> f8:dc:7a:bb:54:a1 dev afe0 master br0 permanent
> 00:e0:4c:3f:f8:c2 dev afe1 vlan 30 master br0
> 00:e0:4c:3f:f8:c2 dev afe1 vlan 10 self
> 00:e0:4c:3f:f8:c2 dev afe1 vlan 20 self
> 00:e0:4c:3f:f8:c2 dev afe1 vlan 30 self
> 33:33:00:00:00:01 dev br0 self permanent
> 01:80:c2:00:00:21 dev br0 self permanent
> 01:00:5e:00:00:6a dev br0 self permanent
> 33:33:00:00:00:6a dev br0 self permanent
> 01:00:5e:00:00:01 dev br0 self permanent
> ea:38:5b:06:97:75 dev br0 vlan 30 master br0 permanent
> ea:38:5b:06:97:75 dev br0 vlan 20 master br0 permanent
> ea:38:5b:06:97:75 dev br0 vlan 10 master br0 permanent
> ea:38:5b:06:97:75 dev br0 vlan 1 master br0 permanent
> ea:38:5b:06:97:75 dev br0 master br0 permanent
> 33:33:00:00:00:01 dev br0.10 self permanent
> 01:00:5e:00:00:01 dev br0.10 self permanent
> 33:33:00:00:00:01 dev br0.20 self permanent
> 01:00:5e:00:00:01 dev br0.20 self permanent
> 33:33:00:00:00:01 dev br0.30 self permanent
> 01:00:5e:00:00:01 dev br0.30 self permanent
> 
> root@imx8qxp-var-som:~# ip a
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
>    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>    inet 127.0.0.1/8 scope host lo
>       valid_lft forever preferred_lft forever
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
>    link/ether f8:dc:7a:bb:54:a0 brd ff:ff:ff:ff:ff:ff
>    inet 10.10.1.4/24 brd 10.10.1.255 scope global eth0
>       valid_lft forever preferred_lft forever
> 3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1507 qdisc mq state UP group default qlen 1000
>    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> 4: afe0@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
>    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> 5: afe1@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br0 state UP group default qlen 1000
>    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> 6: afe3@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
>    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> 7: afe4@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
>    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> 8: afe2@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
>    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> 9: afe5@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
>    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> 10: afe6@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
>    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> 11: afe8@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
>    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> 12: lan1@eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
>    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> 13: lan2@eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
>    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> 14: afe9@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
>    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> 15: afe7@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br0 state LOWERLAYERDOWN group default qlen 1000
>    link/ether f8:dc:7a:bb:54:a1 brd ff:ff:ff:ff:ff:ff
> 16: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>    link/ether ea:38:5b:06:97:75 brd ff:ff:ff:ff:ff:ff
> 17: br0.10@br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>    link/ether ea:38:5b:06:97:75 brd ff:ff:ff:ff:ff:ff
>    inet 192.168.10.1/24 scope global br0.10
>       valid_lft forever preferred_lft forever
> 18: br0.20@br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>    link/ether ea:38:5b:06:97:75 brd ff:ff:ff:ff:ff:ff
>    inet 192.168.20.1/24 scope global br0.20
>       valid_lft forever preferred_lft forever
> 19: br0.30@br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>    link/ether ea:38:5b:06:97:75 brd ff:ff:ff:ff:ff:ff
>    inet 192.168.30.1/24 scope global br0.30
>       valid_lft forever preferred_lft forever
> 
> Best Regards,
> Simon
> 

Sorry that this wasn't very straight or completely certain, but I hope
you're looking a bit more in the right direction now. Depending on your
level of hacking experience and interest in getting this fixed, you
could make the patches yourself and submit for review (preferable
because you have the hardware to test), or I could send to you untested
patches and you could report back as to how they behave? The latter
would be a bit more tedious.

Vladimir

[1] The TX path of the bridge can also be offloaded (see the "bool
*tx_fwd_offload" argument of port_bridge_join() and the "Bridge layer"
section of Documentation/networking/dsa/dsa.rst). When offloaded,
packets will always be passed down by the bridge software as
VLAN-tagged, and it is the responsibility of the driver to untag them
[ in hardware ]. The asymmetry you are witnessing, with the RX path
seeing VLAN tagged packets and TX seeing VLAN untagged, is due to the
lack of offloading in the TX direction. Though it should have worked
without the TX offload too.

[2] Except "bridge vlan add vid 30 dev afe1 pvid untagged". Because
there is only one PVID on a port at any given time, and VID=1 was the
previous PVID, this operation implicitly changes the "pvid" flag of
VID=1. But not the "untagged" flag, and as "pvid" is an ingress flag
while "untagged" is an egress flag, this should not be relevant here.

