Return-Path: <netdev+bounces-254343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEAmKrM9emlB4wEAu9opvQ
	(envelope-from <netdev+bounces-254343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:47:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28519A61EC
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F15B3004C36
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A949F2F25EF;
	Wed, 28 Jan 2026 16:46:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73512417C6;
	Wed, 28 Jan 2026 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769618762; cv=none; b=drntad1IVbS8bIZQ7RwTnB6zCC5Y0L5VsMTMjWP8WpxNBbwgH/hrnSckp00OqAPcNfkL3Mwp31DFj7XUq/EZKgiKlafmtWFiuph6KxcQ7LPD7xCgSPPz5dEFyJH6Pe0asdZiGdNSaDnRk2Z+4v3FYnafm2KhqQvi1to0Lb9vabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769618762; c=relaxed/simple;
	bh=KVAnWsWX88ycpqMzI0FDNp56r5WJEy/yL2wARg8vkro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5OfQVpMm8tvmtxwCY3J7qaxq+VX88uAZdW8Vq+PQgi8GCSJKyOZuzaEYFF0w6Mip7o0+ICxfcfg0eXjANLRq8xAw0x/hfAxqaccpdngnbhxUtyWWWPmlX+DcvhNX0PVTxQcpdWtwlVevzdYG6KKgsOTrQ7ozEC5s808cDSqZpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vl8fm-000000007ki-385z;
	Wed, 28 Jan 2026 16:45:42 +0000
Date: Wed, 28 Jan 2026 16:45:38 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v9 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aXo9MnBFuaj8d5Hv@makrotopia.org>
References: <cover.1769549559.git.daniel@makrotopia.org>
 <35ba37bee00af9de047e8ac49fcd739f10736f84.1769549559.git.daniel@makrotopia.org>
 <20260128112950.q2kzl632w3jidyls@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128112950.q2kzl632w3jidyls@skbuf>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254343-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,makrotopia.org:mid]
X-Rspamd-Queue-Id: 28519A61EC
X-Rspamd-Action: no action

Hi Vladimir,

thank you for the elaborate and very helpful review (one could even say
"inspiring" ;).

See some questions and answers inline below.

On Wed, Jan 28, 2026 at 01:29:50PM +0200, Vladimir Oltean wrote:
> > [...]
> > +/**
> > + * struct mxl862xx_bridge_port_alloc - Bridge Port Allocation
> > + * @bridge_port_id: If the bridge port allocation is successful, a valid ID
> > + *                  will be returned in this field. Otherwise, INVALID_HANDLE is returned.
> > + *                  For bridge port free, this field should contain a valid ID returned by
> > + *                  the bridge port allocation. ID 0 is special for the CPU port in
> > + *                  PRX300, mapping to CTP (Connectivity Termination Port) 0 (Logical Port
> > + *                  0 with Sub-interface ID 0), and is pre-allocated during initialization.
> 
> Just to be clear, "CPU port in PRX300" does not refer to the "DSA CPU
> port" that connects to the Linux system, no? Because
> mxl862xx_configure_tag_proto() assigns a different CTP ID for the DSA
> CPU port AFAICS, not 0.
> 
> Without further clarifications, this comment is a bit confusing. I would
> at least add that CTP 0 is not used by the driver.

This documentation was probably meant for a whole series of different
chips which are used with the (proprietary) switch driver which in case
of the MxL862xx is running on the internal microcontroller rather than
on the host OS...

I'll remove the comment, PRX300 is a xPON SoC which contains the same
switch IP. There are plans to upstream support also for this SoC, but of
course without the proprietary switch driver which this API refers to.

> [...]
> > +/**
> > + * struct mxl862xx_ctp_port_assignment - CTP Port Assignment/association
> > + *                                       with logical port
> > + * @logical_port_id: Logical Port Id. The valid range is hardware dependent
> > + * @first_ctp_port_id: First CTP (Connectivity Termination Port) ID mapped
> > + *                     to above logical port ID
> > + * @number_of_ctp_port: Total number of CTP Ports mapped above logical port
> > + *                      ID
> > + * @mode: Logical port mode to define sub interface ID format. See
> > + *        &enum mxl862xx_logical_port_mode
> > + * @bridge_port_id: Bridge Port ID (not FID). For allocation, each CTP
> > + *                  allocated is mapped to the Bridge Port given by this
> > + *                  field. The Bridge Port will be configured to use first CTP
> > + *                  as egress CTP.
> > + *
> > + * A CTP (Connectivity Termination Port) is equivalent to
> > + * Logical Port + Sub-Interface-ID (capped at 31).
> 
> "+" as in "arithmetical plus"?

Yes.

> How do we know that CTP 5 is 3 + 2 and not 4 + 1?

We can't. This "rule" anyway seems to rather be just a software
convention, see below.

> > [...]
> > +static int mxl862xx_configure_tag_proto(struct dsa_switch *ds, int port, bool enable)
> > +{
> > +	struct mxl862xx_ctp_port_assignment assign = {
> > +		.number_of_ctp_port = cpu_to_le16(enable ? (32 - DSA_MXL_PORT(port)) : 1),
> > +		.logical_port_id = DSA_MXL_PORT(port),
> > +		.first_ctp_port_id = cpu_to_le16(DSA_MXL_PORT(port)),
> > +		.mode = cpu_to_le32(MXL862XX_LOGICAL_PORT_ETHERNET),
> 
> I have a really hard time understanding the physical port to CTP port
> mapping here. Specifically, I see you allocate 1 CTP port (sub-interface)
> per user port, and the rest up to 32 CTP ports as sub-interfaces of the
> DSA CPU port.
> 
> But I can only see this working if the index of the DSA CPU port is the
> last. Otherwise, won't the CTP port IDs of user ports subsequent to the
> DSA CPU port overlap with sub-interfaces of the latter?
> 
> Example:
> mxl862xx_configure_tag_proto(ds, 3, true) // CPU port
> -> .number_of_ctp_port = cpu_to_le16(32 - DSA_MXL_PORT(3)), // 28
> -> .logical_port_id = DSA_MXL_PORT(3), // 4
> -> .first_ctp_port_id = cpu_to_le16(DSA_MXL_PORT(3)), // 4
> mxl862xx_configure_tag_proto(ds, 4, false) // user port
> -> .number_of_ctp_port = cpu_to_le16(1), // 1
> -> .logical_port_id = DSA_MXL_PORT(4), // 5
> -> .first_ctp_port_id = cpu_to_le16(DSA_MXL_PORT(4)), // 5
> 
> Doesn't the CTP port ID of user port 4 (5) collide with sub-interface 2
> of CPU port 3?

Absolutely true. It works coincidental because only SerDes port 0
(port_id 9) is allowed to be CPU port. When using SerDes port 1
(port_id 13) as a user port it already starts to be tricky and more care
needs to be taken when setting up CTP port assignment...

Now that I understand more of what it actually does I'll try to come up
with something smarter.

> > [...]
> > +static int mxl862xx_isolate_port(struct dsa_switch *ds, int port)
> 
> I would recommend against using the "isolate" term in this context, it
> will conflict at some point with the meaning of the BR_ISOLATED bridge
> port flag. From man bridge:
> 
>        isolated on or isolated off
>               Controls whether a given port will be isolated, which
>               means it will be able to communicate with non-isolated
>               ports only.  By default this flag is off.
> 
> Something like gswip_add_single_port_br() is better maybe?

+1

> > [...]
> > +static int mxl862xx_setup(struct dsa_switch *ds)
> > +{
> > +	struct mxl862xx_bridge_port_config br_port_cfg = {};
> > +	struct mxl862xx_priv *priv = ds->priv;
> > +	u16 bridge_port_map = 0;
> > +	struct dsa_port *dp;
> > +	int cpu_port = -1;
> > +	int ret;
> > +
> > +	dsa_switch_for_each_cpu_port(dp, ds) {
> > +		/* Only a single CPU port is supported by now */
> > +		if (cpu_port != -1)
> > +			return -EINVAL;
> 
> If the hardware supports multiple CPU ports, then please describe all
> CPU ports as such in the device tree, and make an effort to handle that
> description gracefully even if you cannot make use of the second CPU port.

The number of available CTP (32) limits the possible setup for CPU ports.
The reference driver only allows port_id 9 (SerDes 0) to be used as CPU
port. SerDes 1 may also be used as CPU port in theory.

> See the rules by which dsa_tree_setup_cpu_ports() creates the initial
> user to CPU port mapping. This avoids a future breakage you'll cause
> with old kernels when you update the device tree to describe the second
> CPU port for what it is.

Understood. On old kernel, lets assume with this basic driver just added
but future DT with more than one CPU port described one should still end
up with the first CPU port used and all ports assigned to that CPU port.
Right?

> 
> > +
> > +		cpu_port = dp->index;
> > +	}
> > +
> > +	ret = mxl862xx_reset(priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = mxl862xx_wait_ready(ds);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* CPU port bridge setup */
> > +	br_port_cfg.mask = cpu_to_le32(MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_PORT_MAP |
> > +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_MC_SRC_MAC_LEARNING |
> > +				       MXL862XX_BRIDGE_PORT_CONFIG_MASK_VLAN_BASED_MAC_LEARNING);
> > +
> > +	br_port_cfg.bridge_port_id = cpu_to_le16(DSA_MXL_PORT(cpu_port));
> > +	br_port_cfg.src_mac_learning_disable = false;
> > +	br_port_cfg.vlan_src_mac_vid_enable = true;
> > +	br_port_cfg.vlan_dst_mac_vid_enable = true;
> > +
> > +	/* include all non-CPU ports in the CPU portmap */
> > +	dsa_switch_for_each_available_port(dp, ds) {
> > +		if (dsa_port_is_cpu(dp))
> > +			continue;
> > +
> > +		bridge_port_map |= BIT(DSA_MXL_PORT(dp->index));
> > +	}
> > +	br_port_cfg.bridge_port_map[0] |= cpu_to_le16(bridge_port_map);
> > +
> > +	ret = MXL862XX_API_WRITE(priv, MXL862XX_BRIDGEPORT_CONFIGSET,
> > +				 br_port_cfg);
> > +	if (ret) {
> > +		dev_err(ds->dev, "failed to set the CPU portmap\n");
> > +		return ret;
> > +	}
> > +	mxl862xx_port_fast_age(ds, cpu_port);
> 
> Duplicate with the call from mxl862xx_port_setup()?

+1 I'll remove that.

> > [...]
> > +static int mxl862xx_port_setup(struct dsa_switch *ds, int port)
> > +{
> > +	bool is_cpu_port = dsa_is_cpu_port(ds, port);
> > +	int ret;
> > +
> > +	ret = mxl862xx_configure_tag_proto(ds, port, is_cpu_port);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!is_cpu_port && !dsa_is_unused_port(ds, port)) {
> > +		ret = mxl862xx_isolate_port(ds, port);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	mxl862xx_port_fast_age(ds, port);
> > +
> > +	ret = mxl862xx_port_state(ds, port, is_cpu_port);
> 
> What is the point of this? Do CPU ports need to be enabled prior to the
> mxl862xx_port_enable() call?

Testing turned out it doesn't matter and it's totally fine to have
the CPU port enabled/disabled by calling mxl862xx_port_enable() just
like for any other port.

> 
> > [...]
> > +#define MXL862XX_MAX_PHY_PORT_NUM	8
> > +#define MXL862XX_MAX_EXT_PORT_NUM	7
> > +#define MXL862XX_MAX_PORT_NUM		(MXL862XX_MAX_PHY_PORT_NUM + \
> > +					 MXL862XX_MAX_EXT_PORT_NUM)
> 
> 8 + 7 == 15. This is written into ds->num_ports.

Good you are asking this. It's another oddity which came from the vendor
driver. It's wrong in many ways, see below.

> 
> Could you please explain how this agrees with the Kconfig help text:
> 	  These switches have two 10GE SerDes interfaces, one typically
> 	  used as CPU port.
> 	   MxL86282 has eight 2.5 Gigabit PHYs
> 	   MxL86252 has five 2.5 Gigabit PHYs
> 
> What are the extra port indices used for, and is it ok that MxL86282 and
> MxL86252 are registered with the same ds->num_ports value? This should
> be visible in the "devlink port" command - even unused ports have
> devlink instances.

This is probably because the SerDes ports also support 10G QXGMII PHYs
with 4x 2.5G TP ports connected via a single pair of 10G SerDes lanes.
In this case 4 port indexes are used for the 4 ports.

My understanding of the internal port IDs by now:
	 MxL86282				MxL86252
port 0:  microcontroller			microcontroller
port 1:  PHY port 0				PHY port 0
port 2:  PHY port 1				PHY port 1
port 3:  PHY port 2				PHY port 2
port 4:  PHY port 3				PHY port 3
port 5:  PHY port 4				PHY port 4
port 6:  PHY port 5				n/c
port 7:  PHY port 6				n/c
port 8:  PHY port 7				n/c
port 9:  SerDes PCS 0				SerDes PCS 0
port 10: SerDes PCS 0 (QXGMII)			SerDes PCS 0 (QXGMII)
port 11: SerDes PCS 0 (QXGMII)			SerDes PCS 0 (QXGMII)
port 12: SerDes PCS 0 (QXGMII)			SerDes PCS 0 (QXGMII)
port 13: SerDes PCS 1				SerDes PCS 1
port 14: SerDes PCS 1 (QXGMII)			SerDes PCS 1 (QXGMII)
port 15: SerDes PCS 1 (QXGMII)			SerDes PCS 1 (QXGMII)
port 16: SerDes PCS 1 (QXGMII)			SerDes PCS 1 (QXGMII)

MaxLinear seems to tell board designers to always use port 9 as CPU port
and port 13 for an SFP cage or for an additional single-port PHY.
But this seem to be limitations of their current downstream driver
implementation and the hardware would be capable of using either
or both SerDes port as CPU port, and also support connecting a QXGMII PHY
to end up with 12 TP ports in total.

Port 0 indeed turned out to be the microcontroller, I can confirm that
because it screams when poking it with IEEE1588v2 packets, which you
get to see in the kernel logs:
net eth1: Invalid source port, packet dropped, tag: 88 c3 0f 04 00 00 00 10
                                                                         ^^
                                          IGP/EGP is 0 here, Record-ID is 1

The datasheet says that Record-ID "[...] is used for logging information
for PTP and OAM packets".

And calling mxl862xx_port_disable() on it makes it shut up...


Cheers


Daniel

