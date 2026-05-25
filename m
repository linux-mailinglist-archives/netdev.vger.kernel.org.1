Return-Path: <netdev+bounces-291271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCTrJL8VFGpOJgcAu9opvQ
	(envelope-from <netdev+bounces-291271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:26:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F435C88B0
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A24943004605
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACA43E638C;
	Mon, 25 May 2026 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTdvmceE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCEA3E5EE3;
	Mon, 25 May 2026 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701179; cv=none; b=jyely/kGYMAVpbqKK7w7FkQbdqysusejz3mj4dVEK5LkpcwFD5ydN6lebxdTqbx6V1VHQzaq7BufgkUhsPcLIS9Z8wXsSXaElnRXNAHq9kQKH7fIxiQHTW1PGQlgHfcd0woRV5UvBi0r0Gcq76SoBg03gEMenjF9VqSWS+3xVhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701179; c=relaxed/simple;
	bh=tRytv1aLAHp6iF4GA97mW316GLX42vBd7VtCWvoY1Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0+GxbWiGhtSqqOzf9n/VVZ/2D8RDZdqQXGvPaTA4/Hp+Lwesu84vbDqxFNsZrTPEVnYACYYxJqOdIOaUZ+DHLI9ef8s0W9POlATEFdopyzP1g/9fYCHskgwhvVT+WwOMUh74FI13XHY/US1/0fiXzwm6yrct25453vgDXlUEvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTdvmceE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE391F000E9;
	Mon, 25 May 2026 09:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779701175;
	bh=DPRuB0VbbITbbsr96dIXtkXhg7ebKv3Z3nNz/llcy3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hTdvmceENAhQ9r4GKpRErwWtaa0O8e0+ip1tDsNEuE/UMLsRY7mj5j1+ldBG3K0NZ
	 i22ja5fl/xR/WOlnlGsjIjUfj0yagTGPghkMtdVl2LkG+EzIVNgWWfrYlBk7Td0VSB
	 o2wFNhqjX+6VNIqJQT/8ZbHXwGC5gB5Lr37bU6jDX4TrgZnY/fH+HvBwg5CwgnhEYk
	 57GMG1ody0fYBUDnzsF3yKNJkLdMTWLvBB0rPt9rC2a+XzuSb1NdQZKvpDsiXPWUPi
	 llrAo1OMeN3n7BlJXuXHEW+YYFCDRmA5UBA97cm7fZoVN59eAoeGpSICLFN4doh1CR
	 iwl8BwBUBUDgw==
Date: Mon, 25 May 2026 11:26:10 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: cedric.jehasse@luminex.be
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: use the hw tx queues
Message-ID: <nrymrthvic2co6g726qm2lb4hbsepjw3xmoh33eznmlumdcpb2@pwxvmsq5y67v>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-1-c87a8e6bcc0c@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522-net-next-mv88e6xxx-cbs-v1-1-c87a8e6bcc0c@luminex.be>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-291271-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kabel@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 37F435C88B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Num tx queues for all devices:

88E6020		4
88E6071		4
88E6085		4
88E6095		4
88E6097		4
88E6123		4
88E6131		4
88E6141		4
88E6161		4
88E6165		4
88E6171		4
88E6172		4
88E6175		4
88E6176		4
88E6185		4
88E6190		8 from you
88E6190X	8 from you
88E6191		n/a can't find datasheet, does this even exist?
88E6191X	8 from you
88E6193X	8 from you
88E6220		4 from you
88E6240		4 from you
88E6250		4 from you
88E6290		8
88E6320		4 from you
88E6321		4 from you
88E6341		4
88E6350		4
88E6351		4
88E6352		4 from you
88E6361		8
88E6390		8 from you
88E6390X	8 from you
88E6393X	8 from you

Marek

On Fri, May 22, 2026 at 12:56:22PM +0200, Cedric Jehasse via B4 Relay wrote:
> From: Cedric Jehasse <cedric.jehasse@luminex.be>
> 
> From the datasheets i've looked at these switches have 4 or 8 transmit
> queues per port.
> There's a PRI field in the dsa tag used to indicate which egress queue
> the frame is to be sent to.
> This isn't done for vlan tagged frames because this would overwrite the
> PCP value in the vlan tag (The PRI field in the dsa
> tag is used as the PCP value in the vlan tag).
> 
> Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>
> ---
>  drivers/net/dsa/mv88e6xxx/chip.c | 14 ++++++++++++++
>  drivers/net/dsa/mv88e6xxx/chip.h |  1 +
>  net/dsa/tag_dsa.c                |  3 ++-
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 8ca5fd40df92..277efe24edf4 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -3979,6 +3979,7 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
>  
>  	chip->ds = ds;
>  	ds->user_mii_bus = mv88e6xxx_default_mdio_bus(chip);
> +	ds->num_tx_queues = chip->info->num_tx_queues;
>  
>  	/* Since virtual bridges are mapped in the PVT, the number we support
>  	 * depends on the physical switch topology. We need to let DSA figure
> @@ -6051,6 +6052,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>  		.num_ports = 11,	/* 10 + Z80 */
>  		.num_internal_phys = 9,
>  		.num_gpio = 16,
> +		.num_tx_queues = 8,
>  		.max_vid = 8191,
>  		.max_sid = 63,
>  		.port_base_addr = 0x0,
> @@ -6076,6 +6078,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>  		.num_ports = 11,	/* 10 + Z80 */
>  		.num_internal_phys = 9,
>  		.num_gpio = 16,
> +		.num_tx_queues = 8,
>  		.max_vid = 8191,
>  		.max_sid = 63,
>  		.port_base_addr = 0x0,
> @@ -6125,6 +6128,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>  		.num_ports = 11,	/* 10 + Z80 */
>  		.num_internal_phys = 8,
>  		.internal_phys_offset = 1,
> +		.num_tx_queues = 8,
>  		.max_vid = 8191,
>  		.max_sid = 63,
>  		.port_base_addr = 0x0,
> @@ -6151,6 +6155,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>  		.num_internal_phys = 8,
>  		.num_tcam_entries = 256,
>  		.internal_phys_offset = 1,
> +		.num_tx_queues = 8,
>  		.max_vid = 8191,
>  		.max_sid = 63,
>  		.port_base_addr = 0x0,
> @@ -6181,6 +6186,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>  		.num_ports = 7,
>  		.num_internal_phys = 2,
>  		.invalid_port_mask = BIT(2) | BIT(3) | BIT(4),
> +		.num_tx_queues = 4,
>  		.max_vid = 4095,
>  		.port_base_addr = 0x08,
>  		.phy_base_addr = 0x00,
> @@ -6205,6 +6211,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>  		.num_ports = 7,
>  		.num_internal_phys = 5,
>  		.num_gpio = 15,
> +		.num_tx_queues = 4,
>  		.max_vid = 4095,
>  		.max_sid = 63,
>  		.port_base_addr = 0x10,
> @@ -6230,6 +6237,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>  		.num_databases = 64,
>  		.num_ports = 7,
>  		.num_internal_phys = 5,
> +		.num_tx_queues = 4,
>  		.max_vid = 4095,
>  		.port_base_addr = 0x08,
>  		.phy_base_addr = 0x00,
> @@ -6282,6 +6290,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>  		.num_internal_phys = 2,
>  		.internal_phys_offset = 3,
>  		.num_gpio = 15,
> +		.num_tx_queues = 4,
>  		.max_vid = 4095,
>  		.max_sid = 63,
>  		.port_base_addr = 0x10,
> @@ -6310,6 +6319,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>  		.num_internal_phys = 2,
>  		.internal_phys_offset = 3,
>  		.num_gpio = 15,
> +		.num_tx_queues = 4,
>  		.max_vid = 4095,
>  		.max_sid = 63,
>  		.port_base_addr = 0x10,
> @@ -6414,6 +6424,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>  		.num_ports = 7,
>  		.num_internal_phys = 5,
>  		.num_gpio = 15,
> +		.num_tx_queues = 4,
>  		.max_vid = 4095,
>  		.max_sid = 63,
>  		.port_base_addr = 0x10,
> @@ -6468,6 +6479,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>  		.num_internal_phys = 9,
>  		.num_gpio = 16,
>  		.num_tcam_entries = 256,
> +		.num_tx_queues = 8,
>  		.max_vid = 8191,
>  		.max_sid = 63,
>  		.port_base_addr = 0x0,
> @@ -6495,6 +6507,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>  		.num_ports = 11,	/* 10 + Z80 */
>  		.num_internal_phys = 9,
>  		.num_gpio = 16,
> +		.num_tx_queues = 8,
>  		.max_vid = 8191,
>  		.max_sid = 63,
>  		.port_base_addr = 0x0,
> @@ -6521,6 +6534,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>  		.num_ports = 11,	/* 10 + Z80 */
>  		.num_internal_phys = 8,
>  		.num_tcam_entries = 256,
> +		.num_tx_queues = 8,
>  		.internal_phys_offset = 1,
>  		.max_vid = 8191,
>  		.max_sid = 63,
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
> index cde71828e9d9..19d8eda19b78 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.h
> +++ b/drivers/net/dsa/mv88e6xxx/chip.h
> @@ -136,6 +136,7 @@ struct mv88e6xxx_info {
>  	unsigned int num_internal_phys;
>  	unsigned int num_gpio;
>  	unsigned int num_tcam_entries;
> +	unsigned int num_tx_queues;
>  	unsigned int max_vid;
>  	unsigned int max_sid;
>  	unsigned int port_base_addr;
> diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c
> index 2a2c4fb61a65..96c8fbedbd3b 100644
> --- a/net/dsa/tag_dsa.c
> +++ b/net/dsa/tag_dsa.c
> @@ -179,6 +179,7 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
>  			dsa_header[2] &= ~0x10;
>  		}
>  	} else {
> +		u16 queue = skb_get_queue_mapping(skb) & 0x7;
>  		u16 vid;
>  
>  		vid = br_dev ? MV88E6XXX_VID_BRIDGED : MV88E6XXX_VID_STANDALONE;
> @@ -191,7 +192,7 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
>  
>  		dsa_header[0] = (cmd << 6) | tag_dev;
>  		dsa_header[1] = tag_port << 3;
> -		dsa_header[2] = vid >> 8;
> +		dsa_header[2] = (queue << 5) | vid >> 8;
>  		dsa_header[3] = vid & 0xff;
>  	}
>  
> 
> -- 
> 2.43.0
> 
> 
> 

