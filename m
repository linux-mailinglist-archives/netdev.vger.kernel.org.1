Return-Path: <netdev+bounces-63705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C783182EF82
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 14:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22229B2299F
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 13:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68C81BC35;
	Tue, 16 Jan 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrrGrMZv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6261BDCA
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a271a28aeb4so1069392166b.2
        for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 05:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705410622; x=1706015422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=praQUuISfuraZC+TeyNTFcgmJt1zo5q7CZ1NoR3g74g=;
        b=mrrGrMZvjH+pktyh1NmXyVwNNMUtydGitFueXCHN3vXMSwaeq/Nn4J32d0PCNr7NZb
         NzvvDPlh/GHkqI+5Er8o5WcI9umlp4Rylb/1XRXgpnQQHMeyE1vzTSQDVZonSVBf5Fff
         YfJWpj1hDk1PQ+J1CtWpFnjV8VrsoiKGxgQ5acTii4//lCeC02h+iyRwB7AcKw0tGYy/
         Kkw5iWWT7EhSBMxdGbXheuUJkEiHzsZ2qO8lxhjjEvLeXPZ96nxLvM+WINSFs2vVuzzV
         aeVoukrlg5Wr+J+jdusjl9zv1L8JyOJGTG0Mk4wn7G6UY3jObN7ro5sm0QORuIUP+WB6
         WGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705410622; x=1706015422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=praQUuISfuraZC+TeyNTFcgmJt1zo5q7CZ1NoR3g74g=;
        b=lIqgXJq+6lnSHt1eBKxFQKiVXfDIfh/IxpeCQ5IspPUFUG2ykfAEn36+FUIoomgoaM
         XOwgUmeTYqMjK9Blp0D9pymkGGxHfIpT8uHY01CWkJfsrLX+zAMzBdrlkmCYg+w6+EPa
         2IMoDPuCglJi7ihlstwSMf2ObBZwjhV1gzftQQ3v7IZSN3oAP1Nl/CAf7Bd+4T+k38F0
         4Zi75lSodDO6DQUl2NW4C9OwQTBTNJUYFVh9U8wcuwRC0JYqT1JE5H1Ak29GCJHyEom9
         ujKTzDziyzsq3PjHTSdUzi5xWJAWB/7O9RWKLx/qjxWeqceR6zoU23/ZMCTo3Li7qYrs
         pLVg==
X-Gm-Message-State: AOJu0YwZAbvB5JpYITEWiHv5dauhGW1I9zxngr8+K/0z6jhYyUT14EBx
	6QU3VaeFqK21+TKXCvGCbKZR3cNVqtX/Qg==
X-Google-Smtp-Source: AGHT+IHeCsh36un94FZPvQkINVNWVevaplAxFTJeYoForgDrf30u4tjjebqgfvvqc5JG0ygIMiOEDw==
X-Received: by 2002:a17:906:2ac2:b0:a28:d4eb:4286 with SMTP id m2-20020a1709062ac200b00a28d4eb4286mr3446788eje.109.1705410622023;
        Tue, 16 Jan 2024 05:10:22 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id tl15-20020a170907c30f00b00a2e7b7fab35sm603286ejc.14.2024.01.16.05.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 05:10:21 -0800 (PST)
Date: Tue, 16 Jan 2024 15:10:19 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Simon Waterer <simon.waterer@gmail.com>
Cc: Arun Ramadoss <arun.ramadoss@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Subject: Re: DSA switch: VLAN tag not added on packets directed to a
 PVID,untagged switchport
Message-ID: <20240116131019.wmonfumccn25kig3@skbuf>
References: <CABumfLzJmXDN_W-8Z=p9KyKUVi_HhS7o_poBkeKHS2BkAiyYpw@mail.gmail.com>
 <20240115181545.ixme3ao4z4gyn5qq@skbuf>
 <CABumfLwA5xMiag2+2Rjj6r12uqvnsTjrNGfp4HDp+pZ7vw-HLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABumfLwA5xMiag2+2Rjj6r12uqvnsTjrNGfp4HDp+pZ7vw-HLg@mail.gmail.com>

On Tue, Jan 16, 2024 at 05:32:57PM +1300, Simon Waterer wrote:
> So a similar fix to ksz9477.c would be as follows?
> 
> int ksz9477_port_vlan_del(struct ksz_device *dev, int port,
> const struct switchdev_obj_port_vlan *vlan)
> {
> - bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> u32 vlan_table[3];
> u16 pvid;
> 
> ksz_pread16(dev, port, REG_PORT_DEFAULT_VID, &pvid);
> pvid = pvid & 0xFFF;
> 
> if (ksz9477_get_vlan_table(dev, vlan->vid, vlan_table)) {
> dev_dbg(dev->dev, "Failed to get vlan table\n");
> return -ETIMEDOUT;
> }
> 
> vlan_table[2] &= ~BIT(port);
> 
> if (pvid == vlan->vid)
> pvid = 1;
> 
> - if (untagged)
> - vlan_table[1] &= ~BIT(port);
> -
> if (ksz9477_set_vlan_table(dev, vlan->vid, vlan_table)) {
> dev_dbg(dev->dev, "Failed to set vlan table\n");
> return -ETIMEDOUT;
> }
> 
> ksz_pwrite16(dev, port, REG_PORT_DEFAULT_VID, pvid);
> 
> return 0;
> }
> 
> I've applied this change to my version of the driver and will test to
> see if any issues result.

Something like this, yes. It is clearer ("do nothing simpler"), and
should not result in any behavior change.

int br_switchdev_port_vlan_del(struct net_device *dev, u16 vid)
{
	struct switchdev_obj_port_vlan v = {
		.obj.orig_dev = dev,
		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
		.vid = vid,
		/* .flags implicitly zero */
	};

	return switchdev_port_obj_del(dev, &v.obj);
}

If you take care of the ksz driver, I can take care of lantiq_gswip,
b53 and dsa_loop once net-next reopens, which also have this kind of
bogus logic.

> > Separately, another bug in ksz9477_port_vlan_del() is this:
> >
> >         if (pvid == vlan->vid)
> >                 pvid = 1;
> >
> > When deleting the PVID VLAN, the documented expected behavior of Linux
> > is that the port should drop incoming untagged and priority-tagged
> > traffic. But this driver changes the PVID to 1, and that's not ok.
> 
> What would the suggested fix be for this one? I expect it would be to
> just not touch the PVID at all within ksz9477_port_vlan_del. As
> follows (based on previous change already applied)?
> 
> int ksz9477_port_vlan_del(struct ksz_device *dev, int port,
> const struct switchdev_obj_port_vlan *vlan)
> {
> u32 vlan_table[3];
> - u16 pvid;
> -
> - ksz_pread16(dev, port, REG_PORT_DEFAULT_VID, &pvid);
> - pvid = pvid & 0xFFF;
> 
> if (ksz9477_get_vlan_table(dev, vlan->vid, vlan_table)) {
> dev_dbg(dev->dev, "Failed to get vlan table\n");
> return -ETIMEDOUT;
> }
> 
> vlan_table[2] &= ~BIT(port);
> 
> - if (pvid == vlan->vid)
> - pvid = 1;
> -
> if (ksz9477_set_vlan_table(dev, vlan->vid, vlan_table)) {
> dev_dbg(dev->dev, "Failed to set vlan table\n");
> return -ETIMEDOUT;
> }
> 
> - ksz_pwrite16(dev, port, REG_PORT_DEFAULT_VID, pvid);
> -
> return 0;
> }
> 
> Again, I've applied this change to my version of the driver and will
> test to see if any issues result, and happy to submit a patch with
> those changes.

You're asking me a hard question. I opened up the KSZ9477 documentation
and I see that the Port Ingress MAC Control Register has a field called
Discard Untagged Packets. Logic should be inserted into the driver such
that when a port lacks a bridge PVID and is under a VLAN-aware bridge,
this bit is set.

There are 3 ways that can lead to this bit being set in hardware:
- The port is already under a VLAN-aware bridge, and the user runs
  'bridge vlan del' on the PVID VLAN.
- The port is already under a VLAN-aware bridge, and the user runs
  'bridge vlan add dev afe0 vid 1 [ untagged ]', aka it reinstalls VID 1,
  just with different flags than it had before (aka it unsets 'pvid').
- The port is under a VLAN-unaware bridge which already lacks a PVID on
  the port. Because the bridge is VLAN-unaware at the moment, for now,
  the driver has to ignore this VLAN setting and accept all traffic.
  Then, when VLAN filtering is dynamically toggled to 'on', is when the
  VLAN table from the bridge should take effect in hardware.

Search for "commit_pvid" in other drivers to get an idea of how to
structure the code to get this right.

> Further, the referenced ksz8_port_vlan_del has a block to 'Invalidate
> the entry if no more members'. Perhaps the same logic should apply to
> ksz9477_port_vlan_del? i.e.:
> 
> int ksz9477_port_vlan_del(struct ksz_device *dev, int port,
> const struct switchdev_obj_port_vlan *vlan)
> {
> u32 vlan_table[3];
> 
> if (ksz9477_get_vlan_table(dev, vlan->vid, vlan_table)) {
> dev_dbg(dev->dev, "Failed to get vlan table\n");
> return -ETIMEDOUT;
> }
> 
> vlan_table[2] &= ~BIT(port);
> 
> + /* Invalidate the entry if no more member. */
> + if (!vlan_table[2]) {
> + vlan_table[0] &= ~VLAN_VALID;
> + }
> +
> if (ksz9477_set_vlan_table(dev, vlan->vid, vlan_table)) {
> dev_dbg(dev->dev, "Failed to set vlan table\n");
> return -ETIMEDOUT;
> }
> 

Seems plausible, must be tested.

> Ok, I've also made the below change to remove the handling of cpu_port
> in vlan_table[2] and will test if it causes any issues.
> 
> int ksz9477_port_vlan_add(struct ksz_device *dev, int port,
> const struct switchdev_obj_port_vlan *vlan,
> struct netlink_ext_ack *extack)
> {
> u32 vlan_table[3];
> bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> int err;
> 
> err = ksz9477_get_vlan_table(dev, vlan->vid, vlan_table);
> if (err) {
> NL_SET_ERR_MSG_MOD(extack, "Failed to get vlan table");
> return err;
> }
> 
> vlan_table[0] = VLAN_VALID | (vlan->vid & VLAN_FID_M);
> if (untagged)
> vlan_table[1] |= BIT(port);
> else
> vlan_table[1] &= ~BIT(port);
> vlan_table[1] &= ~(BIT(dev->cpu_port) | BIT(dev->dsa_port));

Later on, the BIT(dev->cpu_port) handling in vlan_table[1] should also
be reworded, something like this:

	/* Always configure VLANs as egress-tagged towards the CPU,
	 * and untag frames in software.
	 */
	if (dsa_is_cpu_port(ds, port) || !untagged)
		vlan_table[1] &= ~BIT(port);
	else
		vlan_table[1] |= BIT(port);

> - vlan_table[2] |= BIT(port) | BIT(dev->cpu_port);
> + vlan_table[2] |= BIT(port);
> 
> err = ksz9477_set_vlan_table(dev, vlan->vid, vlan_table);
> if (err) {
> NL_SET_ERR_MSG_MOD(extack, "Failed to set vlan table");
> return err;
> }
> 
> /* change PVID */
> if (vlan->flags & BRIDGE_VLAN_INFO_PVID)
> ksz_pwrite16(dev, port, REG_PORT_DEFAULT_VID, vlan->vid);
> 
> return 0;
> }

Something like this. It has to be tested.

Note that since commit 02020bd70fa6 ("net: dsa: add trace points for
VLAN operations") from kernel 6.4, it should be easier for you to see
what is going on, by using "trace-cmd record -e dsa".

> > > ip link set dev br0 type bridge vlan_filtering 1
> >
> > This right here, while a perfectly legal command, also makes evaluating
> > what goes on all that more difficult.
> >
> > See, there is a difference between creating a bridge as VLAN-aware
> > straight away (ip link add dev br0 type bridge vlan_filtering 1) and
> > making it VLAN-unaware, telling the ports to join the bridge, and
> > then making it VLAN-aware dynamically.
> 
> This is exactly it.
> 
> By making the bridge VLAN-aware at the time of creating the bridge, it
> exactly solved the issue I was facing. So the command becomes as you
> have written (ip link add dev br0 type bridge vlan_filtering 1). Now
> the ARP reply packets are being received (at the device originating
> the ping) as untagged exactly as I expect:
> 
> 15:46:47.603761 00:e0:4c:68:0d:66 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.168.30.1 tell 192.168.30.251, length 28
> 15:46:47.605409 ea:38:5b:06:97:75 > 00:e0:4c:68:0d:66, ethertype ARP (0x0806), length 60: Reply 192.168.30.1 is-at ea:38:5b:06:97:75, length 46
> 15:46:47.605439 00:e0:4c:68:0d:66 > ea:38:5b:06:97:75, ethertype IPv4 (0x0800), length 98: 192.168.30.251 > 192.168.30.1: ICMP echo request, id 28, seq 1, length 64
> 15:46:47.606538 ea:38:5b:06:97:75 > 00:e0:4c:68:0d:66, ethertype IPv4 (0x0800), length 98: 192.168.30.1 > 192.168.30.251: ICMP echo reply, id 28, seq 1, length 64
> ...

Ok, makes sense.

> This also solved the other issue I noted below that after running a
> "bridge vlan del dev <device> vid 1" command, the entry for VID=1
> never disappeared from the ouput of "bridge vlan show". Now (if bridge
> is VLAN-aware at creation) it does remove the VID=1 when executing a
> "bridge vlan del dev <device> vid 1" command.

The only plausible explanation is that when vid 1 wasn't deleted, it was
because DSA (through switchdev) was returning an error saying that it
doesn't know anything of vid 1. Bridge's __vlan_vid_del() seems to not
ignore the error code from switchdev, and it stops right there, not
removing VID 1 from its VLAN groups, and propagating the error to the
user instead. It's strange that you aren't confirming that the 'bridge
vlan del' command does, in fact, return an error.

> Yes, the "skipping configuration of VLAN" was being printed in my
> original setup when the bridge was created as VLAN-unaware.

It would have saved me some time for you to not omit this :)

> It is quite hard to tell what the hardware default is from the
> documentation. The "Microchip AN4005 LAN937x Register Definitions"
> document does state at "TABLE 136: GLOBAL VLAN TABLE ENTRY 2 REGISTER"
> the default value of the "UNTAG" field is 0, which means all ports
> have 0 in the bitfield, which is stated to mean: "0 = Do not untag".
> Presumably this could be interpreted to mean that the hardware is
> pre-programmed with egress-tagged for VID=1 for all ports.
> 
> As a test, I added code to the driver to query the VLAN table entry
> for VID=1 on each port, immediately after the switch is reset in
> ksz_setup() function in ksz_common.c. The output as below shows the
> initial value in vlan_entry[1] is 0x00000000 for VID=1 for all ports.
> I think this confirms that the hardware default is to program VID=1 as
> PVID and egress-tagged on all ports.
> 
> ksz-switch spi1.0: port=0 vid=1 vlan_entry[0]=0x80000000 vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
> ksz-switch spi1.0: port=1 vid=1 vlan_entry[0]=0x80000000 vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
> ksz-switch spi1.0: port=2 vid=1 vlan_entry[0]=0x80000000 vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
> ksz-switch spi1.0: port=3 vid=1 vlan_entry[0]=0x80000000 vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
> ksz-switch spi1.0: port=4 vid=1 vlan_entry[0]=0x80000000 vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
> ksz-switch spi1.0: port=5 vid=1 vlan_entry[0]=0x80000000 vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
> ksz-switch spi1.0: port=6 vid=1 vlan_entry[0]=0x80000000 vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
> ksz-switch spi1.0: port=7 vid=1 vlan_entry[0]=0x80000000 vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
> ksz-switch spi1.1: port=0 vid=1 vlan_entry[0]=0x80000000 vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
> ksz-switch spi1.1: port=1 vid=1 vlan_entry[0]=0x80000000 vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
> ksz-switch spi1.1: port=2 vid=1 vlan_entry[0]=0x80000000 vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
> ksz-switch spi1.1: port=3 vid=1 vlan_entry[0]=0x80000000 vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
> ksz-switch spi1.1: port=4 vid=1 vlan_entry[0]=0x80000000 vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
> ksz-switch spi1.1: port=5 vid=1 vlan_entry[0]=0x80000000 vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
> ksz-switch spi1.1: port=6 vid=1 vlan_entry[0]=0x80000000 vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1
> ksz-switch spi1.1: port=7 vid=1 vlan_entry[0]=0x80000000 vlan_entry[1]=0x00000000 vlan_entry[2]=0x000000ff PVID=1

It's good when reality agrees with theory :)

> As you were originally talking about the
> configure_vlan_while_not_filtering flag, as another test, I removed
> the line of code in ksz_common.c that sets:
> 
>         ds->configure_vlan_while_not_filtering = false;
> 
> And using the original setup commands (where the bridge is first
> created as VLAN-unaware, then the switchports are added, then the
> bridge is made VLAN-aware): this also exactly solved my issue (and I
> also did not see the "skipping configuration of VLAN" message,
> confirming that the logic in DSA did not skip VLAN configuration on
> the VLAN-unaware bridge as you described above).
> 
> So it would seem that the setting of
> configure_vlan_while_not_filtering to false within the Microchip
> LAN9373 driver is not a useful or helpful behaviour for my use case.

Yes, the idea behind configure_vlan_while_not_filtering is to prefer one
bug for another bug, because the second bug implies changing the original
behavior. Not great either way.

> > I would absolutely appreciate patches to handle this condition correctly,
> > so that we can get rid of the ds->configure_vlan_while_not_filtering
> > flag. To handle it correctly would mean to do as instructed in the
> > "Bridge VLAN filtering" section of Documentation/networking/switchdev.rst.
> 
> Unfortunately I do not have the expertise to assess if the LAN937X
> driver would be in conformance with that documentation if the
> ds->configure_vlan_while_not_filtering = false is removed from the
> driver code. Simply removing that line of code from ksz_common.c seems
> to have not have had any harmful side-effects in my use case.

And neither do I :) But I've had success in the past with this tactic:
make a best guess as to why configure_vlan_while_not_filtering = false
exists in the first place, write some tests which exhibit a change when
removing the flag, then fix the driver with the flag removed, then hope
for the best :)

There was a previous attempt to get rid of configure_vlan_while_not_filtering
which did not lead anywhere.
https://lore.kernel.org/netdev/20220705173114.2004386-1-vladimir.oltean@nxp.com/
Hopefully this time will be different, but I really need collaboration
from someone who has the time and interest to tinker a bit with the driver,
since I don't have hardware to experiment on.

We also have more kselftests which I don't think currently pass on the
KSZ driver. I'm getting ahead of myself, but it would certainly be nice
if they all passed. Some of them test the bridge VLAN path, and I did add
one more, to capture what I believe is what the configure_vlan_while_not_filtering
workaround protects against. I have not yet seen how it behaves on KSZ
switches.

When that passes, it is OK from my side to delete
"ds->configure_vlan_while_not_filtering = false" for this driver.

> I should point out that I have applied a series of vendor patches to
> the Microchip LAN9373 driver on top of the mainline Linux 6.1.36
> driver. The patches are found at:
> https://github.com/microchip-ung/lan937x_linux/tree/main/src/Atmel_SOC_SAMA5D3/buildroot_external_lan937x/board/atmel/sama5d3_xplained_lan937x/patches/linux/6.0-rc4
> 
> In addition to those patches, I have made a few fixes of my own to the
> LAN937X driver code where required.
> 
> Now that I understand a lot more about how this driver works (after a
> few months of working with it now), I expect there is a certain
> minimal set of changes that I can extract from the above patch series
> in order to gain the functionality that I needed (the support for
> cascaded switches and insertion of the 3-byte cascade tail tag,
> essentially) and consider submitting them as patches for review

Looking forward to that. I think some of the patches were upstreamed in
6.2. It would be good to move to net-next first when assessing upstream
behavior.

> I'm also aware of the patch series at
> https://lore.kernel.org/netdev/20230202125930.271740-2-rakesh.sankaranarayanan@microchip.com/
> and I note the existing review comments against that patch series. In
> my version of the driver I have had to force the selection of
> DSA_TAG_PROTO_LAN937X_CASCADE_VALUE by ksz_get_tag_protocol() due to
> the incorrect logic within that function.

One of the review comments was that DSA_TAG_PROTO_LAN937X_CASCADE should
not exist in the first place.

> On another note, I had tremendous trouble configuring the LAN9373 to
> talk RGMII nicely with the iMX8 FEC. In the end it was two register
> settings that needed to be set appropriately in order to allow the
> RGMII to work. I do wonder if the LAN937X driver should provide
> appropriate default behaviour, for the following:
> 
> - Disable In-Band-Status (IBS) on the RGMII port(s). This requirement
> is not described in the datasheet for the hardware, however it is
> documented at https://microchip.my.site.com/s/article/Ethernet-MAC-to-PHY-speed-matching-and-IBS-for-RGMII.
> The ksz_set_xmii() in ksz_common.c does have code to disable RGMII
> in-band status support for chip ids KSZ9893_CHIP_ID and
> KSZ8563_CHIP_ID. I added code to a similar effect to set the
> appropriate register for LAN937x, which has worked for me. I am not
> certain if I should submit a patch for this, as it seems like
> something that should be user-controllable, rather than hard-coded in
> the driver, i.e. from a device tree property? Or perhaps it can be
> inferred by the presence of a "fixed-link" for an RGMII port, then the
> driver should disable IBS on that port. (Here is the patch originally
> introducing it for KSZ9893:
> https://lore.kernel.org/netdev/20200905140325.108846-4-pbarker@konsulko.com/).

Note that since commit d73ffc08824d ("net: phylink: allow RGMII/RTBI
in-band status") from kernel v6.1, phylink understands the 'managed =
"in-band-status";' property for RGMII interfaces as well. Presumably
this driver should be coded to control the IBS bits based on the
presence or absence of this property (and yes, it is illegal to enable
it on a fixed-link).

> - Disable the Virtual PHY function of the switch. Otherwise the RGMII
> interface selects an incorrect link speed and/or duplex mode as the
> hardware seems to expecting some software agent to instruct it via the
> Virtual PHY. In this case I think it makes sense for the driver to
> always disable Virtual PHY since DSA is the software agent controlling
> the swtich I don't see any way that the hardware will work with DSA if
> the Virtual PHY is left enabled?

If this is anything similar to LAN9303_VIRT_PHY_BASE:
https://lore.kernel.org/netdev/20221206221238.5p4wv472wwcjowy5@skbuf/
you'd have to see if anything uses it (through the device tree) which
could break if you disable it.

Otherwise, well-justified and documented patches are always welcome.

> And on a completely different note, I've also been having trouble to
> get the LAN9373 SGMII ports to interface with a TI DP83TC812.
> Whilst the driver does bringup the PHY:
> [ 11.267701] ksz-switch spi1.1 lan1 (uninitialized): PHY [5b040000.ethernet-1:0c] driver [TI DP83TC812CS2.0] (irq=POLL)
> 
> And ethtool reports that a link is detected at 100Mb/s (the only link
> speed supported by that PHY):
> root@imx8qxp-var-som:~# ethtool lan1
> Settings for lan1:
> Supported ports: [ TP MII ]
> Supported link modes: 100baseT/Full
> Supported pause frame use: No
> Supports auto-negotiation: No
> Supported FEC modes: Not reported
> Advertised link modes: Not reported
> Advertised pause frame use: No
> Advertised auto-negotiation: No
> Advertised FEC modes: Not reported
> Speed: 100Mb/s
> Duplex: Full
> Auto-negotiation: off
> Port: Twisted Pair
> PHYAD: 12
> Transceiver: external
> MDI-X: Unknown
> Supports Wake-on: d
> Wake-on: d
> Link detected: yes
> 
> But I'm seeing rx_crc_errors and rx_jabbers on the switchport's PHY statistics:
> root@imx8qxp-var-som:~# ethtool -S lan1
> NIC statistics:
> tx_packets: 13
> tx_bytes: 1230
> rx_jabbers: 19
> rx_crc_err: 110
> rx_512_1023: 110
> tx_bcast: 12
> tx_mcast: 1
> rx_total: 111921
> tx_total: 1288
> 
> As well as align_errors on the device connected to the SGMII PHY:
> $ ethtool -S enx00e04c680d66
> NIC statistics:
> tx_packets: 315
> align_errors: 1
> $ ethtool enx00e04c680d66
> Settings for enx00e04c680d66:
> Supported ports: [ TP MII ]
> Supported link modes: 10baseT/Half 10baseT/Full
> 100baseT/Half 100baseT/Full
> 1000baseT/Half 1000baseT/Full
> Supported pause frame use: No
> Supports auto-negotiation: Yes
> Supported FEC modes: Not reported
> Advertised link modes: 10baseT/Half 10baseT/Full
> 100baseT/Half 100baseT/Full
> 1000baseT/Full
> Advertised pause frame use: Symmetric Receive-only
> Advertised auto-negotiation: Yes
> Advertised FEC modes: Not reported
> Link partner advertised link modes: 10baseT/Half 10baseT/Full
> 100baseT/Half 100baseT/Full
> Link partner advertised pause frame use: No
> Link partner advertised auto-negotiation: Yes
> Link partner advertised FEC modes: Not reported
> Speed: 100Mb/s
> Duplex: Full
> Port: MII
> PHYAD: 32
> Transceiver: internal
> Auto-negotiation: on
> 
> I'm wondering if the LAN937X DSA driver is missing some support for
> bringing up SGMII ports properly?

I really don't know here. In mainline, supporting code for SGMII has not
been submitted, so there has been no chance of even evaluating what is
necessary.

