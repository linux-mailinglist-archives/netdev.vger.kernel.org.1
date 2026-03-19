Return-Path: <netdev+bounces-269289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJCVE+Fwu2nSkAIAu9opvQ
	(envelope-from <netdev+bounces-269289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:43:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E232C5A18
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 922E93013687
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6CE274FE9;
	Thu, 19 Mar 2026 03:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ2CRpiJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEAB175A7F;
	Thu, 19 Mar 2026 03:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773891230; cv=none; b=WTATZggmDAmWOqTjM3VqQ1JWxwBe7XQM/U0jupUDU7PGOTwh4aRypdrnrXd3IFzuqZI6kXM+QQVFnUD+lU5VeCoDcZ3lWMTkfy+YmlmGEDqg1K4Xm+rigtkxYscaeXlbacG6cdDJD2l+2136e0YnK43AyaKmovgUSqfaGup5+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773891230; c=relaxed/simple;
	bh=XgOD2FxBzcrwEZanmqbfz/dgf+28LNZcyXFh5nHNaVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFFr+7UzLihYWmGI5jXqkf8dgv15jtHlnvBMqboSlkmLw9peRLSL3qN74eFcFr+Pe8du2Lu39jYVdBbvimjVcv3vh0TCyzY1WBcnL4nTpn4G92WnMShNrV4Cl8OaVlgAoPLDmyGvFcb2FS4rc4vTJgEUWGKvMFp5aTwGr7b7kDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ2CRpiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001DAC19425;
	Thu, 19 Mar 2026 03:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773891230;
	bh=XgOD2FxBzcrwEZanmqbfz/dgf+28LNZcyXFh5nHNaVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IZ2CRpiJpQ1j2wZKFVLuyVlCxyZ0s/2vzeqmfoNECQAqPtT8Th5dkkZowiRHwybr+
	 uw1pBqoHsikD3yjcN+Ij1zrO5L+PLL8c90YbexeEZrO1x/U0SzgV2n4OnJW6ExONrQ
	 Xl93vDXO1JSV7hivhLKKH7XaCMY5SmXIquGzycjXQRuG0AKeinIZy+WCgI/oBXi7ZR
	 z8kSsBSyBVMILZ4sxVB9Sskgjbceqh3PL21egeIAr75EHirgi1UJ54U8kq5LSf+KBf
	 7ndvS0s2UchUI13zERp6UEXjggt6/NMLUnrBX5/lLM54UPdNT5yJAU5Dj80n2pyifC
	 ODXBII86krGuA==
Date: Wed, 18 Mar 2026 20:33:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, linux-doc@vger.kernel.org, lorenzo@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 lukas.bulwahn@redhat.com, edumazet@google.com, enelsonmoore@gmail.com,
 skhan@linuxfoundation.org, ani.nikula@intel.com, hkallweit1@gmail.com,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v8 net-next 01/11] net/nebula-matrix: add minimum nbl
 build framework
Message-ID: <20260318203349.5d83eb69@kernel.org>
In-Reply-To: <20260317034533.5600-2-illusion.wang@nebula-matrix.com>
References: <20260317034533.5600-1-illusion.wang@nebula-matrix.com>
	<20260317034533.5600-2-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[alvin.wang:url];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-269289-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org,intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.988];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[illusion.wang:url,alvin.wang:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2E232C5A18
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

On Tue, 17 Mar 2026 11:45:18 +0800 illusion.wang wrote:
> 1.Add nbl min build infrastructure for nbl driver.
> 
> 2.Implemented the framework of pci device initialization.

> +============================================================
> +Linux Base Driver for Nebula-matrix M18100-NIC family
> +============================================================

Shouldn't these lines also be the length of the text?

> +Overview:
> +=========
> +M18100-NIC is a series of network interface card for the Data Center Area.
> +
> +The driver supports link-speed 100GbE/25GE/10GE.
> +
> +M18100-NIC devices support MSI-X interrupt vector for each Tx/Rx queue and
> +interrupt moderation.
> +
> +M18100-NIC devices support also various offload features such as checksum offload,
> +Receive-Side Scaling(RSS).
> +
> +Supported PCI vendor ID/device IDs:
> +===================================
> +
> +1f0f:3403 - M18110 Family PF
> +1f0f:3404 - M18110 Lx Family PF
> +1f0f:3405 - M18110 Family BASE-T PF
> +1f0f:3406 - M18110 Lx Family BASE-T PF
> +1f0f:3407 - M18110 Family OCP PF
> +1f0f:3408 - M18110 Lx Family OCP PF
> +1f0f:3409 - M18110 Family BASE-T OCP PF
> +1f0f:340a - M18110 Lx Family BASE-T OCP PF
> +1f0f:340b - M18100 Family PF
> +1f0f:340c - M18100 Lx Family PF
> +1f0f:340d - M18100 Family BASE-T PF
> +1f0f:340e - M18100 Lx Family BASE-T PF
> +1f0f:340f - M18100 Family OCP PF
> +1f0f:3410 - M18100 Lx Family OCP PF
> +1f0f:3411 - M18100 Family BASE-T OCP PF
> +1f0f:3412 - M18100 Lx Family BASE-T OCP PF

Please don't list all the SKUs what's the point. PCIe device DB is 
the place for that.

> +NEBULA-MATRIX ETHERNET DRIVER (nebula-matrix)
> +M:	Illusion.Wang <illusion.wang@nebula-matrix.com>
> +M:	Dimon.Zhao <dimon.zhao@nebula-matrix.com>
> +M:	Alvin.Wang <alvin.wang@nebula-matrix.com>
> +M:	Sam Chen <sam.chen@nebula-matrix.com>

What makes Sam Chen not have a dot in between name and surname?
Maybe let's use the more usual notation and remove the dots?

> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/networking/device_drivers/ethernet/nebula-matrix/*

Why the star at the end?

> +++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Nebula Matrix Limited.
> +
> +obj-$(CONFIG_NBL) := nbl.o
> +
> +nbl-objs +=      nbl_main.o
> +
> +# Provide include files
> +ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/
> +ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/

Why? You really shouldn't need this

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
> new file mode 100644
> index 000000000000..8c50904b9151
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_CORE_H_
> +#define _NBL_CORE_H_
> +
> +enum {
> +	NBL_CAP_HAS_CTRL_BIT = BIT(0),

each header should be self-contained, you haven't included bits.h

> +	NBL_CAP_HAS_NET_BIT = BIT(1),
> +	NBL_CAP_IS_NIC_BIT = BIT(2),
> +	NBL_CAP_IS_LEONIS_BIT = BIT(3),
> +};
> +
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> new file mode 100644
> index 000000000000..914f1418f508
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_INCLUDE_H_
> +#define _NBL_INCLUDE_H_
> +
> +/*  ------  Basic definitions  -------  */
> +#define NBL_DRIVER_NAME					"nbl"
> +
> +struct nbl_func_caps {
> +	u32 has_ctrl:1;

ditto, types.h

> +	u32 has_net:1;
> +	u32 is_nic:1;
> +	u32 rsv:29;
> +};
> +
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> new file mode 100644
> index 000000000000..c0b01fea2548
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +#include "nbl_include.h"
> +#include "nbl_core.h"
> +
> +static int nbl_probe(struct pci_dev *pdev,
> +		     const struct pci_device_id __always_unused *id)

__always_unused should be after the arg name, not the type
but also why? kernel build doesn't warn about unused args

> +{
> +	return 0;
> +}

> +MODULE_DEVICE_TABLE(pci, nbl_id_table);
> +
> +static struct pci_driver nbl_driver = {
> +	.name = NBL_DRIVER_NAME,
> +	.id_table = nbl_id_table,
> +	.probe = nbl_probe,
> +	.remove = nbl_remove,
> +};
> +
> +module_pci_driver(nbl_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Nebula Matrix Network Driver");

missing include module.h ..
-- 
pw-bot: cr

