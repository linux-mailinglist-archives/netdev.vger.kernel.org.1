Return-Path: <netdev+bounces-254144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON46DuTDeWl0zAEAu9opvQ
	(envelope-from <netdev+bounces-254144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:08:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E29AD9E091
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA89730089BD
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF3C3382F4;
	Wed, 28 Jan 2026 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nkkZYDjN"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814D3284B26
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769587638; cv=none; b=K2+qd2IQNLwNYJLPqmTRjJMCOiKmw7E9P5Vc30IKYEEwqqrj0+d63lB0IJOlwfH4SCRZYIyX8A0i/GEyWDV+lbaTwwhwGTC+eoLrOXqxJ5sUBpZdc6JXdBAUDN9YUmHldhgupDStClc3oGDFa1Z8ifN/+BR88nq6Mc3Y18Kg8jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769587638; c=relaxed/simple;
	bh=Akv84JQFTqSg1HNmxKpEqhysp1MVEeTShgu/5PVNbOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwP+zcovcuSTFEWna35LF6gMiKZOYdtRgrEf9qydYkXp4uXatIoNAbNUX4cV9R6EJoIjdIKN45vLTaAWJSQ1DGO/kSPDGmJCqoXbx3MqQ2stYhW6sQm7PLcDub+YQf7BJ6muhnjCkEk4rLykrIb0i9Jnu83GELdEYet/wtBEnr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nkkZYDjN; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B0276C211E1;
	Wed, 28 Jan 2026 08:07:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 307AF6071A;
	Wed, 28 Jan 2026 08:07:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE70A119A8695;
	Wed, 28 Jan 2026 09:07:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769587632; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=viA9W+b9JKLDFwhgQlKxjiFrQnMXXL6+tuKc6Rapy/g=;
	b=nkkZYDjNLWqk0wScH2Rzx50RaJ5KNvuCSLXP1/ua1DY3lkUc6nMidTHfxp6c5tjal6n6p4
	6puZ6cnE+SK2TyOj6+XP5Wc36ErCOvWiobBA8GRAEQH3PoQBXGIDeLSjdvi7Y//LxM6PG6
	zIHldHXG4LSc5Wf0aWal0Ab4M+Jw1snO7vpnpPx8IXi9MtI3+148WvlUM6tZ/qk4X8Dv2g
	FV++eDBLXXgBe492hvMrTNhwkUFQfkpGXtKp/T2nfTQsHNLxaypAXw/sx2w6r1CL4hRf7g
	k/hyMjqivDGe7qYexzXIvNq5gKh/FYdyl/oQfSMW71x0/227KMwRmegmTFQ9yQ==
Message-ID: <a11817cb-ab03-4710-8ff0-142a2ba73383@bootlin.com>
Date: Wed, 28 Jan 2026 09:07:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/13] net: phy_port: SFP modules representation
 and phy_port listing
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
 <20260127130745.5cc65868@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260127130745.5cc65868@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	TAGGED_FROM(0.00)[bounces-254144-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E29AD9E091
X-Rspamd-Action: no action

Hi again,

On 27/01/2026 22:07, Jakub Kicinski wrote:

> Some config-related build unhappines here (kunit hits this):
> 
> ../include/linux/phy_link_topology.h:110:1: error: return type defaults to ‘int’ [-Wimplicit-int]
>   110 | phy_link_topo_get_port(struct net_device *dev, u32 port_id)
>       | ^~~~~~~~~~~~~~~~~~~~~~
> ../include/linux/phy_link_topology.h:110:1: warning: no previous prototype for ‘phy_link_topo_get_port’ [-Wmissing-prototypes]
> In file included from ../include/uapi/linux/posix_types.h:5,
>                  from ../include/uapi/linux/types.h:14,
>                  from ../include/linux/types.h:6,
>                  from ../include/linux/kasan-checks.h:5,
>                  from ../include/asm-generic/rwonce.h:26,
>                  from ./arch/x86/include/generated/asm/rwonce.h:1,
>                  from ../include/linux/compiler.h:380,
>                  from ../include/linux/build_bug.h:5,
>                  from ../include/linux/bits.h:30,
>                  from ../include/linux/bitops.h:6,
>                  from ../include/linux/bitmap.h:8,
>                  from ../include/linux/ethtool.h:16,
>                  from ../include/uapi/linux/ethtool_netlink.h:12,
>                  from ../include/linux/ethtool_netlink.h:6,
>                  from ../net/ethtool/common.c:3:
> ../include/linux/phy_link_topology.h: In function ‘phy_link_topo_get_port’:
> ../include/linux/stddef.h:8:14: error: returning ‘void *’ from a function with return type ‘int’ makes integer from pointer without a cast [-Wint-conversion]
>     8 | #define NULL ((void *)0)
>       |              ^
> ../include/linux/phy_link_topology.h:112:16: note: in expansion of macro ‘NULL’
>   112 |         return NULL;
>       |                ^~~~

The kernel test bot also found it, and AI found stuff to fix I'll
address that + AI review then :)

Maxime

