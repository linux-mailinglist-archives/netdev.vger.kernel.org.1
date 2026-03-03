Return-Path: <netdev+bounces-263300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJSSH3QHp2k7bgAAu9opvQ
	(envelope-from <netdev+bounces-263300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:08:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F21D51F34BB
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD18D305DA7F
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04FD494A0B;
	Tue,  3 Mar 2026 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB4S7EMe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D6F494A08
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772553728; cv=none; b=AC+4hYk5MvEFFagrQJwpX8rmGI5f5b63kmZFi7fpgiHGBdc2RccyGAanHkDfEMXn4KviudRd016wEUItke65AOQ1mKyL6WtAVYFfajVwyfc/840pG/GZUQ5kVGGDoTklWKQArWda3JhliQ0mRtS1v0PL2dcMXw8f6ehXULTZLYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772553728; c=relaxed/simple;
	bh=/gPqESLtTH3QLgeWJA2O/i7hxujnrzJIfT5R3/4nA2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jG7bO9LR4YDoS+yYEg0Mi6jQUHBSnDmWfLhSru46kVxTLJFqX3vdGa8Y7BkGucBmluEvRw0RlPP2q844/ZLIPEK+y2pNj+XoeDhFO3OW7wUFylhLXbMOhOegx2ST4u+ytGYeiv69ubHA1jH4xEhgPrDSsmlS5iH+5YzvCrhnTiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eB4S7EMe; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4836d541968so5146905e9.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 08:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772553725; x=1773158525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4l1bVDEVtDur1FtKBZcRUqwAXWv6Qrc8WxL1St5E+f4=;
        b=eB4S7EMeNQC+OcZRLpfAsow7Qp0XPFzIr3VLjTcR/+xOCH8sTshxC2XM9cxrV+ETQu
         1t5XoDstIr1NEPyG7GKZpOKmBJ1jfDzK5Wd/Cy5JvzWF/VA8Qa/DrXA37AbckEF3sdBC
         9t1c6Wx9OfbDUWf1nGlkXmTW8vkISb1GsK8VHadHivPSFQPUQHABZVGcHn3V595srQwd
         kfX4FQhgqLGtfck+czNJnFDgOTo37juiApXWxu8KjA5EkeJ9PRVTc0RS9SMI23nwMAAG
         VAj/Kg9XtGywoDB19vMfvVWQqV9rEnBxu8Czodr2g7T+VWNiaolspHic1NAa3taw9AnI
         OwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772553725; x=1773158525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4l1bVDEVtDur1FtKBZcRUqwAXWv6Qrc8WxL1St5E+f4=;
        b=XOKv4Pe9pbQ8RPfC2401ccrsvsZ+81XVOtJLbjRMmhXsKF3VG6qXku2f6d6BpuMQqF
         uzJDinzLVQ8ls6XOdFkH13rdLO8B14wOrJfvVOLQFKBcCWPbEI6hEMMwcQD4Po+DxsA5
         LNs7wj4x07HiyT1jR7NyzNUrBsWsWCkMBK70WOv00UkR3boUzYNc5JFLAro/bh41UCaq
         9PrAKic2PcUJo3PkK68RyVO98qqscSn+JOGZ4UnLoABXZY1wUYNJzj6W7LrGOSmF5u4J
         Ee1Z0vh7p0NamIAhln27meM7NUT8dTHxrqbQblcor9/fET032PfDQqFoomq1H3Vth3JD
         e3yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP+y7+0ja0LIPbGSXnUy1BOSCqMNIVdJQILbsZ90rLNU/LaAaDwC707gHVAPUUl0LeOsqUfyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfa1wP0BfBFCj83PbGK9uSxCNAJWPI4/eDiEMfaGYBkb6mG0u7
	LGWPnGQq9kwpgqo3P/3hvhsD2LioUnqP63DUlo6SMPc/V3QkwMMYdpar
X-Gm-Gg: ATEYQzyqBPzINVBHx6wRNYDQxSi0FHOz5fbMbCHWX+ljs8bsKog5UH1Zfbb450hcMXU
	bhVz4FXxppIIxHohnq6q6VEtAv8IDNwIe8eBsitxC+8FvfZK3eFLHnhZXW/k/vXSpCsuXj1gN2U
	yr8PZ9QeqmUDCkqDtn/LwmaVypyjNmWc5y/e80WKQ0Ly9F6UIAycoWQF12p6KtIc6BFty08KvJU
	zW6j4tsWzLOD/8i8ZormcWqgN6mVXxDEnQOPqLJJEOkjvA2LcssoZBrsa6Y4T6RuumFhsfRI3jO
	a0HQmqO/sVbCVfI6LW7s7jqayPfA6eMraHNNWVrPSLoozIqytLlXkSeEfMiG9VhSGBnLiPElsq/
	jgv1ujowXCiZDYAdzpqWPAVslN1FrTFncvvSKb46jNIKUevAc5QG9+PFjhMNnqVGfYdp0f2KkwQ
	x9ZmDT0iK+WMTjUzo=
X-Received: by 2002:a05:600c:350e:b0:483:79af:ca1e with SMTP id 5b1f17b1804b1-483c9be0523mr165981275e9.5.1772553723948;
        Tue, 03 Mar 2026 08:02:03 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00e:3600:2472:8e4a:cf12:bb30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd750607sm483969725e9.10.2026.03.03.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 08:02:02 -0800 (PST)
Date: Tue, 3 Mar 2026 18:01:59 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jens Emil Schulz =?utf-8?Q?=C3=98stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 8/8] net: dsa: lan9645x: add port statistics
Message-ID: <20260303160159.efjtqzpa2w4awxht@skbuf>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-8-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-8-bff8ca1396f5@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303-dsa_lan9645x_switch_driver_base-v1-8-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-8-bff8ca1396f5@microchip.com>
X-Rspamd-Queue-Id: F21D51F34BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263300-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 01:22:34PM +0100, Jens Emil Schulz Østergaard wrote:
> Add statistics support for the port counters. Chip registers are 32 bit,
> so this unit is responsible maintaining a 64bit software cache, and
> updating it frequently to handle overflows in hardware.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
> ---
>  drivers/net/dsa/microchip/lan9645x/Makefile        |   1 +
>  drivers/net/dsa/microchip/lan9645x/lan9645x_main.c |  82 ++
>  drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |   3 +
>  .../net/dsa/microchip/lan9645x/lan9645x_stats.c    | 825 +++++++++++++++++++++
>  .../net/dsa/microchip/lan9645x/lan9645x_stats.h    | 288 +++++++
>  5 files changed, 1199 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/lan9645x/Makefile b/drivers/net/dsa/microchip/lan9645x/Makefile
> index a90a46f81c72..486b005cf740 100644
> --- a/drivers/net/dsa/microchip/lan9645x/Makefile
> +++ b/drivers/net/dsa/microchip/lan9645x/Makefile
> @@ -7,3 +7,4 @@ mchp-lan9645x-objs := lan9645x_main.o \
>  	lan9645x_phylink.o \
>  	lan9645x_vlan.o \
>  	lan9645x_mac.o \
> +	lan9645x_stats.o \
> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index ba76279b4414..8a1de2588ab8 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> @@ -7,6 +7,7 @@
>  #include <linux/phy/phy.h>
>  
>  #include "lan9645x_main.h"
> +#include "lan9645x_stats.h"
>  
>  static const char *lan9645x_resource_names[NUM_TARGETS + 1] = {
>  	[TARGET_GCB]          = "gcb",
> @@ -79,6 +80,7 @@ static void lan9645x_teardown(struct dsa_switch *ds)
>  	debugfs_remove_recursive(lan9645x->debugfs_root);
>  	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
>  	lan9645x_mac_deinit(lan9645x);
> +	lan9645x_stats_deinit(lan9645x);
>  }
>  
>  static int lan9645x_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
> @@ -274,6 +276,12 @@ static int lan9645x_setup(struct dsa_switch *ds)
>  
>  	lan9645x_port_set_tail_drop_wm(lan9645x);
>  
> +	err = lan9645x_stats_init(lan9645x);
> +	if (err) {
> +		dev_err(dev, "Lan9645x setup: failed to init stats.");

Missing \n.
Also "Lan9645x" probably not required, it will be somewhere in the
driver name.

> +		return err;
> +	}
> +
>  	ds->mtu_enforcement_ingress = true;
>  	ds->assisted_learning_on_cpu_port = true;
>  	ds->fdb_isolation = true;
> @@ -636,6 +644,68 @@ static int lan9645x_fdb_del(struct dsa_switch *ds, int port,
>  	return __lan9645x_fdb_del(lan9645x, port, addr, vid, br);
>  }
>  
> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
> index 4c7111375918..fe801d0ed39a 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
> @@ -217,6 +217,9 @@ struct lan9645x {
>  	u8 vlan_flags[VLAN_N_VID];
>  	DECLARE_BITMAP(cpu_vlan_mask, VLAN_N_VID); /* CPU VLAN membership */
>  
> +	/* Statistics  */
> +	struct lan9645x_stats *stats;
> +
>  	int num_port_dis;
>  	bool dd_dis;
>  	bool tsn_dis;
> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> new file mode 100644
> index 000000000000..43078e441e55
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> @@ -0,0 +1,825 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2026 Microchip Technology Inc.
> + */
> +
> +#include <linux/workqueue.h>
> +#include <linux/debugfs.h>
> +
> +#include "lan9645x_main.h"
> +#include "lan9645x_stats.h"
> +
> +#define LAN9645X_STATS_CHECK_DELAY	(3 * HZ)
> +
> +static const struct lan9645x_stat_region lan9645x_port_stat_regions[] = {
> +	/* RX region */
> +	{ .base_offset = 0x0, .cnt = 67, .cnts_base_idx = 0 },
> +	/* TX region */
> +	{ .base_offset = 0x80, .cnt = 48, .cnts_base_idx = 67 },
> +	/* DR region */
> +	{ .base_offset = 0x100, .cnt = 18, .cnts_base_idx = 115 },
> +};

Did you find any bug in ocelot_prepare_stats_regions(), which is
supposed to automatically build regions of contiguous stats registers
from just their declarations? Because I find this super error-prone and
hard to maintain in the long term, especially with cherry-picks on
stable branches and so on.

> +
> +static const struct lan9645x_stat_layout lan9645x_port_stats_layout[] = {
> +	{ .name = "rx_oct",                .offset = 0x0 },

New drivers which report a counter through standard ethtool API aren't
supposed to need a driver-specific string for it.

> +	{ .name = "rx_uc",                 .offset = 0x1 },
> +	{ .name = "rx_mc",                 .offset = 0x2 },
> +	{ .name = "rx_bc",                 .offset = 0x3 },
> +	{ .name = "rx_short",              .offset = 0x4 },
> +	{ .name = "rx_frag",               .offset = 0x5 },
> +	{ .name = "rx_jabber",             .offset = 0x6 },
> +	{ .name = "rx_crc",                .offset = 0x7 },
> +	{ .name = "rx_symbol_err",         .offset = 0x8 },
> +	{ .name = "rx_sz_64",              .offset = 0x9 },
> +	{ .name = "rx_sz_65_127",          .offset = 0xa },
> +	{ .name = "rx_sz_128_255",         .offset = 0xb },
> +	{ .name = "rx_sz_256_511",         .offset = 0xc },
> +	{ .name = "rx_sz_512_1023",        .offset = 0xd },
> +	{ .name = "rx_sz_1024_1526",       .offset = 0xe },
> +	{ .name = "rx_sz_jumbo",           .offset = 0xf },
> +	{ .name = "rx_pause",              .offset = 0x10 },
> +	{ .name = "rx_control",            .offset = 0x11 },
> +	{ .name = "rx_long",               .offset = 0x12 },
> +	{ .name = "rx_cat_drop",           .offset = 0x13 },
> +	{ .name = "rx_red_prio_0",         .offset = 0x14 },
> +	{ .name = "rx_red_prio_1",         .offset = 0x15 },
> +	{ .name = "rx_red_prio_2",         .offset = 0x16 },
> +	{ .name = "rx_red_prio_3",         .offset = 0x17 },
> +	{ .name = "rx_red_prio_4",         .offset = 0x18 },
> +	{ .name = "rx_red_prio_5",         .offset = 0x19 },
> +	{ .name = "rx_red_prio_6",         .offset = 0x1a },
> +	{ .name = "rx_red_prio_7",         .offset = 0x1b },
> +	{ .name = "rx_yellow_prio_0",      .offset = 0x1c },
> +	{ .name = "rx_yellow_prio_1",      .offset = 0x1d },
> +	{ .name = "rx_yellow_prio_2",      .offset = 0x1e },
> +	{ .name = "rx_yellow_prio_3",      .offset = 0x1f },
> +	{ .name = "rx_yellow_prio_4",      .offset = 0x20 },
> +	{ .name = "rx_yellow_prio_5",      .offset = 0x21 },
> +	{ .name = "rx_yellow_prio_6",      .offset = 0x22 },
> +	{ .name = "rx_yellow_prio_7",      .offset = 0x23 },
> +	{ .name = "rx_green_prio_0",       .offset = 0x24 },
> +	{ .name = "rx_green_prio_1",       .offset = 0x25 },
> +	{ .name = "rx_green_prio_2",       .offset = 0x26 },
> +	{ .name = "rx_green_prio_3",       .offset = 0x27 },
> +	{ .name = "rx_green_prio_4",       .offset = 0x28 },
> +	{ .name = "rx_green_prio_5",       .offset = 0x29 },
> +	{ .name = "rx_green_prio_6",       .offset = 0x2a },
> +	{ .name = "rx_green_prio_7",       .offset = 0x2b },
> +	{ .name = "rx_assembly_err",       .offset = 0x2c },
> +	{ .name = "rx_smd_err",            .offset = 0x2d },
> +	{ .name = "rx_assembly_ok",        .offset = 0x2e },
> +	{ .name = "rx_merge_frag",         .offset = 0x2f },
> +	{ .name = "rx_pmac_oct",           .offset = 0x30 },
> +	{ .name = "rx_pmac_uc",            .offset = 0x31 },
> +	{ .name = "rx_pmac_mc",            .offset = 0x32 },
> +	{ .name = "rx_pmac_bc",            .offset = 0x33 },
> +	{ .name = "rx_pmac_short",         .offset = 0x34 },
> +	{ .name = "rx_pmac_frag",          .offset = 0x35 },
> +	{ .name = "rx_pmac_jabber",        .offset = 0x36 },
> +	{ .name = "rx_pmac_crc",           .offset = 0x37 },
> +	{ .name = "rx_pmac_symbol_err",    .offset = 0x38 },
> +	{ .name = "rx_pmac_sz_64",         .offset = 0x39 },
> +	{ .name = "rx_pmac_sz_65_127",     .offset = 0x3a },
> +	{ .name = "rx_pmac_sz_128_255",    .offset = 0x3b },
> +	{ .name = "rx_pmac_sz_256_511",    .offset = 0x3c },
> +	{ .name = "rx_pmac_sz_512_1023",   .offset = 0x3d },
> +	{ .name = "rx_pmac_sz_1024_1526",  .offset = 0x3e },
> +	{ .name = "rx_pmac_sz_jumbo",      .offset = 0x3f },
> +	{ .name = "rx_pmac_pause",         .offset = 0x40 },
> +	{ .name = "rx_pmac_control",       .offset = 0x41 },
> +	{ .name = "rx_pmac_long",          .offset = 0x42 },
> +	{ .name = "tx_oct",                .offset = 0x80 },
> +	{ .name = "tx_uc",                 .offset = 0x81 },
> +	{ .name = "tx_mc",                 .offset = 0x82 },
> +	{ .name = "tx_bc",                 .offset = 0x83 },
> +	{ .name = "tx_col",                .offset = 0x84 },
> +	{ .name = "tx_drop",               .offset = 0x85 },
> +	{ .name = "tx_pause",              .offset = 0x86 },
> +	{ .name = "tx_sz_64",              .offset = 0x87 },
> +	{ .name = "tx_sz_65_127",          .offset = 0x88 },
> +	{ .name = "tx_sz_128_255",         .offset = 0x89 },
> +	{ .name = "tx_sz_256_511",         .offset = 0x8a },
> +	{ .name = "tx_sz_512_1023",        .offset = 0x8b },
> +	{ .name = "tx_sz_1024_1526",       .offset = 0x8c },
> +	{ .name = "tx_sz_jumbo",           .offset = 0x8d },
> +	{ .name = "tx_yellow_prio_0",      .offset = 0x8e },
> +	{ .name = "tx_yellow_prio_1",      .offset = 0x8f },
> +	{ .name = "tx_yellow_prio_2",      .offset = 0x90 },
> +	{ .name = "tx_yellow_prio_3",      .offset = 0x91 },
> +	{ .name = "tx_yellow_prio_4",      .offset = 0x92 },
> +	{ .name = "tx_yellow_prio_5",      .offset = 0x93 },
> +	{ .name = "tx_yellow_prio_6",      .offset = 0x94 },
> +	{ .name = "tx_yellow_prio_7",      .offset = 0x95 },
> +	{ .name = "tx_green_prio_0",       .offset = 0x96 },
> +	{ .name = "tx_green_prio_1",       .offset = 0x97 },
> +	{ .name = "tx_green_prio_2",       .offset = 0x98 },
> +	{ .name = "tx_green_prio_3",       .offset = 0x99 },
> +	{ .name = "tx_green_prio_4",       .offset = 0x9a },
> +	{ .name = "tx_green_prio_5",       .offset = 0x9b },
> +	{ .name = "tx_green_prio_6",       .offset = 0x9c },
> +	{ .name = "tx_green_prio_7",       .offset = 0x9d },
> +	{ .name = "tx_aged",               .offset = 0x9e },
> +	{ .name = "tx_llct",               .offset = 0x9f },
> +	{ .name = "tx_ct",                 .offset = 0xa0 },
> +	{ .name = "tx_bufdrop",            .offset = 0xa1 },
> +	{ .name = "tx_mm_hold",            .offset = 0xa2 },
> +	{ .name = "tx_merge_frag",         .offset = 0xa3 },
> +	{ .name = "tx_pmac_oct",           .offset = 0xa4 },
> +	{ .name = "tx_pmac_uc",            .offset = 0xa5 },
> +	{ .name = "tx_pmac_mc",            .offset = 0xa6 },
> +	{ .name = "tx_pmac_bc",            .offset = 0xa7 },
> +	{ .name = "tx_pmac_pause",         .offset = 0xa8 },
> +	{ .name = "tx_pmac_sz_64",         .offset = 0xa9 },
> +	{ .name = "tx_pmac_sz_65_127",     .offset = 0xaa },
> +	{ .name = "tx_pmac_sz_128_255",    .offset = 0xab },
> +	{ .name = "tx_pmac_sz_256_511",    .offset = 0xac },
> +	{ .name = "tx_pmac_sz_512_1023",   .offset = 0xad },
> +	{ .name = "tx_pmac_sz_1024_1526",  .offset = 0xae },
> +	{ .name = "tx_pmac_sz_jumbo",      .offset = 0xaf },
> +	{ .name = "dr_local",              .offset = 0x100 },
> +	{ .name = "dr_tail",               .offset = 0x101 },
> +	{ .name = "dr_yellow_prio_0",      .offset = 0x102 },
> +	{ .name = "dr_yellow_prio_1",      .offset = 0x103 },
> +	{ .name = "dr_yellow_prio_2",      .offset = 0x104 },
> +	{ .name = "dr_yellow_prio_3",      .offset = 0x105 },
> +	{ .name = "dr_yellow_prio_4",      .offset = 0x106 },
> +	{ .name = "dr_yellow_prio_5",      .offset = 0x107 },
> +	{ .name = "dr_yellow_prio_6",      .offset = 0x108 },
> +	{ .name = "dr_yellow_prio_7",      .offset = 0x109 },
> +	{ .name = "dr_green_prio_0",       .offset = 0x10a },
> +	{ .name = "dr_green_prio_1",       .offset = 0x10b },
> +	{ .name = "dr_green_prio_2",       .offset = 0x10c },
> +	{ .name = "dr_green_prio_3",       .offset = 0x10d },
> +	{ .name = "dr_green_prio_4",       .offset = 0x10e },
> +	{ .name = "dr_green_prio_5",       .offset = 0x10f },
> +	{ .name = "dr_green_prio_6",       .offset = 0x110 },
> +	{ .name = "dr_green_prio_7",       .offset = 0x111 },
> +};
> +
> +static const struct lan9645x_view_stats lan9645x_view_stat_cfgs[] = {
> +	[LAN9645X_STAT_PORTS] = {
> +	  .name = "ports",
> +	  .type = LAN9645X_STAT_PORTS,
> +	  .layout = lan9645x_port_stats_layout,
> +	  .num_cnts = ARRAY_SIZE(lan9645x_port_stats_layout),
> +	  .num_indexes = NUM_PHYS_PORTS,
> +	  .regions = lan9645x_port_stat_regions,
> +	  .num_regions = ARRAY_SIZE(lan9645x_port_stat_regions),

Odd to mix spaces with tabs.

> +	},
> +};
> +void
> +lan9645x_stats_get_rmon_stats(struct lan9645x *lan9645x, int port,
> +			      struct ethtool_rmon_stats *rmon_stats,
> +			      const struct ethtool_rmon_hist_range **ranges)
> +{
> +	u64 *port_cnt;
> +
> +	mutex_lock(&lan9645x->stats->hw_lock);
> +
> +	__lan9645x_stats_view_idx_update(lan9645x, LAN9645X_STAT_PORTS, port);
> +
> +	port_cnt = STAT_COUNTERS(lan9645x, LAN9645X_STAT_PORTS, port);
> +
> +	rmon_stats->undersize_pkts =
> +		port_cnt[SCNT_RX_SHORT] +
> +		port_cnt[SCNT_RX_PMAC_SHORT];

You aren't supposed to sum up eMAC + pMAC stats except when
rmon_stats->src == ETHTOOL_MAC_STATS_SRC_AGGREGATE. Otherwise report
them individually.

Same thing for lan9645x_stats_get_eth_mac_stats().

> +	rmon_stats->oversize_pkts =
> +		port_cnt[SCNT_RX_LONG] +
> +		port_cnt[SCNT_RX_PMAC_LONG];
> +	rmon_stats->fragments =
> +		port_cnt[SCNT_RX_FRAG] +
> +		port_cnt[SCNT_RX_PMAC_FRAG];
> +	rmon_stats->jabbers =
> +		port_cnt[SCNT_RX_JABBER] +
> +		port_cnt[SCNT_RX_PMAC_JABBER];
> +
> +	rmon_stats->hist[0] =
> +		port_cnt[SCNT_RX_SZ_64] +
> +		port_cnt[SCNT_RX_PMAC_SZ_64];
> +	rmon_stats->hist[1] =
> +		port_cnt[SCNT_RX_SZ_65_127] +
> +		port_cnt[SCNT_RX_PMAC_SZ_65_127];
> +	rmon_stats->hist[2] =
> +		port_cnt[SCNT_RX_SZ_128_255] +
> +		port_cnt[SCNT_RX_PMAC_SZ_128_255];
> +	rmon_stats->hist[3] =
> +		port_cnt[SCNT_RX_SZ_256_511] +
> +		port_cnt[SCNT_RX_PMAC_SZ_256_511];
> +	rmon_stats->hist[4] =
> +		port_cnt[SCNT_RX_SZ_512_1023] +
> +		port_cnt[SCNT_RX_PMAC_SZ_512_1023];
> +	rmon_stats->hist[5] =
> +		port_cnt[SCNT_RX_SZ_1024_1526] +
> +		port_cnt[SCNT_RX_PMAC_SZ_1024_1526];
> +	rmon_stats->hist[6] =
> +		port_cnt[SCNT_RX_SZ_JUMBO] +
> +		port_cnt[SCNT_RX_PMAC_SZ_JUMBO];
> +
> +	rmon_stats->hist_tx[0] =
> +		port_cnt[SCNT_TX_SZ_64] +
> +		port_cnt[SCNT_TX_PMAC_SZ_64];
> +	rmon_stats->hist_tx[1] =
> +		port_cnt[SCNT_TX_SZ_65_127] +
> +		port_cnt[SCNT_TX_PMAC_SZ_65_127];
> +	rmon_stats->hist_tx[2] =
> +		port_cnt[SCNT_TX_SZ_128_255] +
> +		port_cnt[SCNT_TX_PMAC_SZ_128_255];
> +	rmon_stats->hist_tx[3] =
> +		port_cnt[SCNT_TX_SZ_256_511] +
> +		port_cnt[SCNT_TX_PMAC_SZ_256_511];
> +	rmon_stats->hist_tx[4] =
> +		port_cnt[SCNT_TX_SZ_512_1023] +
> +		port_cnt[SCNT_TX_PMAC_SZ_512_1023];
> +	rmon_stats->hist_tx[5] =
> +		port_cnt[SCNT_TX_SZ_1024_1526] +
> +		port_cnt[SCNT_TX_PMAC_SZ_1024_1526];
> +	rmon_stats->hist_tx[6] =
> +		port_cnt[SCNT_TX_SZ_JUMBO] +
> +		port_cnt[SCNT_TX_PMAC_SZ_JUMBO];
> +
> +	mutex_unlock(&lan9645x->stats->hw_lock);
> +
> +	*ranges = lan9645x_rmon_ranges;
> +}
> +
> +void lan9645x_stats_get_stats64(struct lan9645x *lan9645x, int port,
> +				struct rtnl_link_stats64 *stats)
> +{
> +	u64 *port_cnt;
> +
> +	/* Avoid stats update, as this is called very often by DSA. */
> +	mutex_lock(&lan9645x->stats->hw_lock);

This is atomic context, you can't acquire a mutex which may be held by a
process which sleeps, which also puts you to sleep for it.

This is why ocelot->stats_lock is a spinlock, different from
ocelot->stat_view_lock (your lan9645x->stats->hw_lock).

No problem with not updating the stats upon ndo_get_stats64() call,
given the fact that the context is atomic.

> +
> +	port_cnt = STAT_COUNTERS(lan9645x, LAN9645X_STAT_PORTS, port);
> +
> +	stats->rx_bytes = port_cnt[SCNT_RX_OCT] +
> +			  port_cnt[SCNT_RX_PMAC_OCT];
> +
> +	stats->rx_packets = port_cnt[SCNT_RX_SHORT] +
> +			    port_cnt[SCNT_RX_FRAG] +
> +			    port_cnt[SCNT_RX_JABBER] +
> +			    port_cnt[SCNT_RX_CRC] +
> +			    port_cnt[SCNT_RX_SYMBOL_ERR] +
> +			    port_cnt[SCNT_RX_SZ_64] +
> +			    port_cnt[SCNT_RX_SZ_65_127] +
> +			    port_cnt[SCNT_RX_SZ_128_255] +
> +			    port_cnt[SCNT_RX_SZ_256_511] +
> +			    port_cnt[SCNT_RX_SZ_512_1023] +
> +			    port_cnt[SCNT_RX_SZ_1024_1526] +
> +			    port_cnt[SCNT_RX_SZ_JUMBO] +
> +			    port_cnt[SCNT_RX_LONG] +
> +			    port_cnt[SCNT_RX_PMAC_SHORT] +
> +			    port_cnt[SCNT_RX_PMAC_FRAG] +
> +			    port_cnt[SCNT_RX_PMAC_JABBER] +
> +			    port_cnt[SCNT_RX_PMAC_SZ_64] +
> +			    port_cnt[SCNT_RX_PMAC_SZ_65_127] +
> +			    port_cnt[SCNT_RX_PMAC_SZ_128_255] +
> +			    port_cnt[SCNT_RX_PMAC_SZ_256_511] +
> +			    port_cnt[SCNT_RX_PMAC_SZ_512_1023] +
> +			    port_cnt[SCNT_RX_PMAC_SZ_1024_1526] +
> +			    port_cnt[SCNT_RX_PMAC_SZ_JUMBO];
> +
> +	stats->multicast = port_cnt[SCNT_RX_MC] +
> +			   port_cnt[SCNT_RX_PMAC_MC];
> +
> +	stats->rx_errors = port_cnt[SCNT_RX_SHORT] +
> +			   port_cnt[SCNT_RX_FRAG] +
> +			   port_cnt[SCNT_RX_JABBER] +
> +			   port_cnt[SCNT_RX_CRC] +
> +			   port_cnt[SCNT_RX_SYMBOL_ERR] +
> +			   port_cnt[SCNT_RX_LONG] +
> +			   port_cnt[SCNT_RX_PMAC_SHORT] +
> +			   port_cnt[SCNT_RX_PMAC_FRAG] +
> +			   port_cnt[SCNT_RX_PMAC_JABBER] +
> +			   port_cnt[SCNT_RX_PMAC_CRC] +
> +			   port_cnt[SCNT_RX_PMAC_SYMBOL_ERR] +
> +			   port_cnt[SCNT_RX_PMAC_LONG];
> +
> +	stats->rx_dropped = port_cnt[SCNT_RX_LONG] +
> +			    port_cnt[SCNT_DR_LOCAL] +
> +			    port_cnt[SCNT_DR_TAIL] +
> +			    port_cnt[SCNT_RX_CAT_DROP] +
> +			    port_cnt[SCNT_RX_RED_PRIO_0] +
> +			    port_cnt[SCNT_RX_RED_PRIO_1] +
> +			    port_cnt[SCNT_RX_RED_PRIO_2] +
> +			    port_cnt[SCNT_RX_RED_PRIO_3] +
> +			    port_cnt[SCNT_RX_RED_PRIO_4] +
> +			    port_cnt[SCNT_RX_RED_PRIO_5] +
> +			    port_cnt[SCNT_RX_RED_PRIO_6] +
> +			    port_cnt[SCNT_RX_RED_PRIO_7];
> +
> +	for (int i = 0; i < LAN9645X_NUM_TC; i++) {
> +		stats->rx_dropped += port_cnt[SCNT_DR_YELLOW_PRIO_0 + i] +
> +				     port_cnt[SCNT_DR_GREEN_PRIO_0 + i];
> +	}
> +
> +	stats->tx_bytes = port_cnt[SCNT_TX_OCT] +
> +			  port_cnt[SCNT_TX_PMAC_OCT];
> +
> +	stats->tx_packets = port_cnt[SCNT_TX_SZ_64] +
> +			    port_cnt[SCNT_TX_SZ_65_127] +
> +			    port_cnt[SCNT_TX_SZ_128_255] +
> +			    port_cnt[SCNT_TX_SZ_256_511] +
> +			    port_cnt[SCNT_TX_SZ_512_1023] +
> +			    port_cnt[SCNT_TX_SZ_1024_1526] +
> +			    port_cnt[SCNT_TX_SZ_JUMBO] +
> +			    port_cnt[SCNT_TX_PMAC_SZ_64] +
> +			    port_cnt[SCNT_TX_PMAC_SZ_65_127] +
> +			    port_cnt[SCNT_TX_PMAC_SZ_128_255] +
> +			    port_cnt[SCNT_TX_PMAC_SZ_256_511] +
> +			    port_cnt[SCNT_TX_PMAC_SZ_512_1023] +
> +			    port_cnt[SCNT_TX_PMAC_SZ_1024_1526] +
> +			    port_cnt[SCNT_TX_PMAC_SZ_JUMBO];
> +
> +	stats->tx_dropped = port_cnt[SCNT_TX_DROP] +
> +			    port_cnt[SCNT_TX_AGED];
> +
> +	stats->collisions = port_cnt[SCNT_TX_COL];
> +
> +	mutex_unlock(&lan9645x->stats->hw_lock);
> +}
> +
> +void lan9645x_stats_get_eth_phy_stats(struct lan9645x *lan9645x, int port,
> +				      struct ethtool_eth_phy_stats *phy_stats)
> +{
> +	u64 *port_cnt;
> +
> +	mutex_lock(&lan9645x->stats->hw_lock);
> +
> +	__lan9645x_stats_view_idx_update(lan9645x, LAN9645X_STAT_PORTS, port);
> +
> +	port_cnt = STAT_COUNTERS(lan9645x, LAN9645X_STAT_PORTS, port);
> +
> +	switch (phy_stats->src) {
> +	case ETHTOOL_MAC_STATS_SRC_EMAC:
> +		phy_stats->SymbolErrorDuringCarrier =
> +			port_cnt[SCNT_RX_SYMBOL_ERR];
> +		break;
> +	case ETHTOOL_MAC_STATS_SRC_PMAC:
> +		phy_stats->SymbolErrorDuringCarrier =
> +			port_cnt[SCNT_RX_PMAC_SYMBOL_ERR];
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	mutex_unlock(&lan9645x->stats->hw_lock);
> +}
> +
> +void
> +lan9645x_stats_get_eth_ctrl_stats(struct lan9645x *lan9645x, int port,
> +				  struct ethtool_eth_ctrl_stats *ctrl_stats)
> +{
> +	u64 *port_cnt;
> +
> +	mutex_lock(&lan9645x->stats->hw_lock);
> +
> +	__lan9645x_stats_view_idx_update(lan9645x, LAN9645X_STAT_PORTS, port);
> +
> +	port_cnt = STAT_COUNTERS(lan9645x, LAN9645X_STAT_PORTS, port);
> +
> +	switch (ctrl_stats->src) {
> +	case ETHTOOL_MAC_STATS_SRC_EMAC:
> +		ctrl_stats->MACControlFramesReceived =
> +			port_cnt[SCNT_RX_CONTROL];
> +		break;
> +	case ETHTOOL_MAC_STATS_SRC_PMAC:
> +		ctrl_stats->MACControlFramesReceived =
> +			port_cnt[SCNT_RX_PMAC_CONTROL];
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	mutex_unlock(&lan9645x->stats->hw_lock);
> +}
> +
> +void lan9645x_stats_get_pause_stats(struct lan9645x *lan9645x, int port,
> +				    struct ethtool_pause_stats *ps)
> +{
> +	u64 *port_cnt;
> +
> +	mutex_lock(&lan9645x->stats->hw_lock);
> +
> +	__lan9645x_stats_view_idx_update(lan9645x, LAN9645X_STAT_PORTS, port);
> +
> +	port_cnt = STAT_COUNTERS(lan9645x, LAN9645X_STAT_PORTS, port);
> +
> +	switch (ps->src) {
> +	case ETHTOOL_MAC_STATS_SRC_EMAC:
> +		ps->tx_pause_frames = port_cnt[SCNT_TX_PAUSE];
> +		ps->rx_pause_frames = port_cnt[SCNT_RX_PAUSE];
> +		break;
> +	case ETHTOOL_MAC_STATS_SRC_PMAC:
> +		ps->tx_pause_frames = port_cnt[SCNT_TX_PMAC_PAUSE];
> +		ps->rx_pause_frames = port_cnt[SCNT_RX_PMAC_PAUSE];
> +		break;

...no aggregate? I guess this will just return zeroes under normal
operation, and not anything useful? Similar thing everywhere you look
for the source of statistics.

BTW, Ioana is working on a selftest that makes sure standard counters
are implemeted correctly.
https://lore.kernel.org/netdev/20260225150648.1542206-6-ioana.ciornei@nxp.com/

The test packaging still needs to be improved, but it's functional.
Maybe you could give it a run? I'm thinking it would have caught this.

> +	default:
> +		break;
> +	}
> +
> +	mutex_unlock(&lan9645x->stats->hw_lock);
> +}
> +
> +void lan9645x_stats_get_mm_stats(struct lan9645x *lan9645x, int port,
> +				 struct ethtool_mm_stats *stats)
> +{
> +	u64 *port_cnt;
> +
> +	mutex_lock(&lan9645x->stats->hw_lock);
> +
> +	__lan9645x_stats_view_idx_update(lan9645x, LAN9645X_STAT_PORTS, port);
> +
> +	port_cnt = STAT_COUNTERS(lan9645x, LAN9645X_STAT_PORTS, port);
> +
> +	stats->MACMergeFrameAssErrorCount = port_cnt[SCNT_RX_ASSEMBLY_ERR];
> +	stats->MACMergeFrameSmdErrorCount = port_cnt[SCNT_RX_SMD_ERR];
> +	stats->MACMergeFrameAssOkCount = port_cnt[SCNT_RX_ASSEMBLY_OK];
> +	stats->MACMergeFragCountRx = port_cnt[SCNT_RX_MERGE_FRAG];
> +	stats->MACMergeFragCountTx = port_cnt[SCNT_TX_MERGE_FRAG];
> +	stats->MACMergeHoldCount = port_cnt[SCNT_TX_MM_HOLD];
> +
> +	mutex_unlock(&lan9645x->stats->hw_lock);
> +}
> +
> +void lan9645x_stats_clear_counters(struct lan9645x *lan9645x,
> +				   enum lan9645x_view_stat_type type, int idx)

Never called, please remove. Don't leave dead code in the driver.

> +{
> +	struct lan9645x_view_stats *vstats =
> +		lan9645x_get_vstats(lan9645x, type);
> +	u64 *idx_grp;
> +	int cntr;
> +	u32 sel;
> +
> +	switch (type) {
> +	case LAN9645X_STAT_PORTS:
> +		/* Drop, TX and RX counters */
> +		sel = BIT(2) | BIT(1) | BIT(0);
> +		break;
> +	case LAN9645X_STAT_ISDX:
> +		/* ISDX and FRER seq gen */
> +		sel = BIT(5) | BIT(3);
> +		break;
> +	case LAN9645X_STAT_ESDX:
> +		/* ESDX */
> +		sel = BIT(6);
> +		break;
> +	case LAN9645X_STAT_SFID:
> +		/* Stream filter */
> +		sel = BIT(4);
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	mutex_lock(&lan9645x->stats->hw_lock);
> +
> +	lan_wr(SYS_STAT_CFG_STAT_CLEAR_SHOT_SET(sel) |
> +	       SYS_STAT_CFG_STAT_VIEW_SET(idx),
> +	       lan9645x, SYS_STAT_CFG);
> +
> +	idx_grp = STATS_INDEX(vstats, idx);
> +	for (cntr = 0; cntr < vstats->num_cnts; cntr++)
> +		idx_grp[cntr] = 0;
> +
> +	mutex_unlock(&lan9645x->stats->hw_lock);
> +}
> +
> +static void lan9645x_check_stats_work(struct work_struct *work)
> +{
> +	struct delayed_work *del_work = to_delayed_work(work);
> +	struct lan9645x_stats *stats;
> +
> +	stats = container_of(del_work, struct lan9645x_stats, work);
> +
> +	lan9645x_stats_update(stats->lan9645x);
> +
> +	queue_delayed_work(stats->queue, &stats->work,
> +			   LAN9645X_STATS_CHECK_DELAY);
> +}
> +
> +static int lan9645x_stats_debugfs_show(struct seq_file *m, void *unused)
> +{
> +	struct lan9645x_view_stats *vstats = m->private;
> +	int idx, cntr;
> +	size_t total;
> +	u64 *snap;
> +
> +	total = vstats->num_cnts * vstats->num_indexes;
> +
> +	/* Snapshot counters under lock to avoid holding hw_lock during
> +	 * slow seq_printf output.
> +	 */
> +	snap = kmalloc_array(total, sizeof(u64), GFP_KERNEL);
> +	if (!snap)
> +		return -ENOMEM;
> +
> +	mutex_lock(&vstats->stats->hw_lock);
> +	memcpy(snap, vstats->cnts, total * sizeof(u64));
> +	mutex_unlock(&vstats->stats->hw_lock);
> +
> +	for (idx = 0; idx < vstats->num_indexes; idx++) {
> +		for (cntr = 0; cntr < vstats->num_cnts; cntr++) {
> +			seq_printf(m, "%s_%d_%-*s %llu\n", vstats->name, idx,
> +				   30, vstats->layout[cntr].name,
> +				   snap[vstats->num_cnts * idx + cntr]);
> +		}
> +	}
> +
> +	kfree(snap);
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(lan9645x_stats_debugfs);

What is the purpose of a 'stats' debugfs?

If this is about standard ethtool stats on the CPU port, we need a
larger discussion about this, since it is a common problem for multiple
drivers.

I had a prototype patch to permit "ethtool" to be run on devlink ports
(we do have one of those on the CPU port). But I never had time to start
a discussion about it.

> +
> +static void lan9645x_stats_debugfs(struct lan9645x *lan9645x,
> +				   struct dentry *parent)
> +{
> +	struct lan9645x_stats *stats = lan9645x->stats;
> +	struct dentry *dir;
> +	int i;
> +
> +	dir = debugfs_create_dir("stats", parent);
> +	if (PTR_ERR_OR_ZERO(dir))
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(stats->view); i++)
> +		debugfs_create_file(stats->view[i].name, 0444, dir,
> +				    &stats->view[i],
> +				    &lan9645x_stats_debugfs_fops);
> +}
> +
> +static int lan9645x_view_stat_init(struct lan9645x *lan9645x,
> +				   struct lan9645x_view_stats *vstat,
> +				   const struct lan9645x_view_stats *cfg)
> +{
> +	size_t total = cfg->num_cnts * cfg->num_indexes;
> +
> +	memcpy(vstat, cfg, sizeof(*cfg));
> +
> +	vstat->cnts = devm_kcalloc(lan9645x->dev, total, sizeof(u64),
> +				   GFP_KERNEL);
> +	if (!vstat->cnts)
> +		return -ENOMEM;
> +
> +	vstat->buf = devm_kcalloc(lan9645x->dev, total, sizeof(u32),
> +				  GFP_KERNEL);
> +	if (!vstat->buf)
> +		return -ENOMEM;
> +
> +	vstat->stats = lan9645x->stats;
> +
> +	return 0;
> +}
> +
> +int lan9645x_stats_init(struct lan9645x *lan9645x)
> +{
> +	const struct lan9645x_view_stats *vs;
> +	struct lan9645x_stats *stats;
> +	int err, i;
> +
> +	lan9645x->stats = devm_kzalloc(lan9645x->dev, sizeof(*stats),
> +				       GFP_KERNEL);
> +	if (!lan9645x->stats)
> +		return -ENOMEM;
> +
> +	stats = lan9645x->stats;
> +	stats->lan9645x = lan9645x;
> +
> +	mutex_init(&stats->hw_lock);
> +	stats->queue = alloc_ordered_workqueue("lan9645x-stats", 0);
> +	if (!stats->queue)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ARRAY_SIZE(lan9645x_view_stat_cfgs); i++) {
> +		vs = &lan9645x_view_stat_cfgs[i];
> +
> +		if (!vs->num_cnts)
> +			continue;
> +
> +		err = lan9645x_view_stat_init(lan9645x, &stats->view[vs->type],
> +					      vs);
> +		if (err)

stats->queue is leaked.

> +			return err;
> +	}
> +
> +	INIT_DELAYED_WORK(&stats->work, lan9645x_check_stats_work);
> +	queue_delayed_work(stats->queue, &stats->work,
> +			   LAN9645X_STATS_CHECK_DELAY);
> +
> +	lan9645x_stats_debugfs(lan9645x, lan9645x->debugfs_root);
> +
> +	return 0;
> +}

