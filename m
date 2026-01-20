Return-Path: <netdev+bounces-251455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG/1NDlscWnsGwAAu9opvQ
	(envelope-from <netdev+bounces-251455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:15:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB4C5FDE0
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7A89603C94
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD10C4218B3;
	Tue, 20 Jan 2026 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="IQ5J3XJX"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29C2421892;
	Tue, 20 Jan 2026 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907722; cv=pass; b=bjPXMPLyJ2kt9s+OVrJyT5mo8o+0kNJue1LhBMIPQJv/SOKTznntId1qRk19ijxgk/jahKl2egtso6prsCNOd/3p10pruF3z6uwI3J+DEuPb2DqCkXinYtPTKIO+M6A6p9tmVDUyaC5c/ce1+1UUEsJL06JECLzYILVqIQBve1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907722; c=relaxed/simple;
	bh=Oql7bqgPicyZz3jIQKvbwNAm9ubAi1sUxOsLdaPn0LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAXuQaGWssLyQITsZykUIVIDzcAhE5a0AtWPxDayGSOLBwxRJS63SfwyV53Y24en0PTG6muGpJiZ6DEJEVxYe8gjOtKxG8tqMCrMDhRcfxuT3NqR6Z6xHATQnLlCTcxFpDikFbEWujw9SIAJmLrPETkpjDJE8sS0UCleLBFEA+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=IQ5J3XJX; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1768907647; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MLm/apznCo1vkrhgqdt2z6fqtnb1SbIVdgzHikdkv35tmySWGCVPqd99XhKn9owM3TbqWCkOIMUUwMS+4V/TExvZibsn+8Ef//q7UoIpTE2r5lb8zot88oM3B8j424J46SwRKKCxuFyolNStCD9T4Odg+1rktwEjUujOY7kupJg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768907647; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tJlvsdjO7MakrXAnTGrsJvCK8GVpY/2Oni8KztKsRFI=; 
	b=h7QuZ28EnDC7OQBna/NjX26H1HsexkJZmeY1FtM/izwfHFAZwH8EL5v++SrxWlMuY3MvlCvGBkrSFHFJvTyjQxl9FabP5zAfyzp91rYyIofRWW4ljwoTCkP2u5S7awWzTYW51Qlgz5vSOqZkTV7986ETKQgVlqL8SVgq5v9KunM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768907647;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=tJlvsdjO7MakrXAnTGrsJvCK8GVpY/2Oni8KztKsRFI=;
	b=IQ5J3XJXRxRY9SMaPXJbxjogepRElpYKptpWbrV3D841tGD/EIepXwW76IZohqcy
	tnt4sfgsqRQ+Nlu3e54z/Hy1Q5EUkmVxxbP0+LS0HVeGOdWosQZsgLuN1Jw6Fudw2GR
	WCsTFNyASwHiRvKnThPceu0ee3SM5iJpw8xp1sd8=
Received: by mx.zohomail.com with SMTPS id 176890764538613.18629924577317;
	Tue, 20 Jan 2026 03:14:05 -0800 (PST)
Date: Tue, 20 Jan 2026 11:13:50 +0000
From: Yao Zi <me@ziyao.cc>
To: Inochi Amaoto <inochiama@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Yao Zi <ziyao@disroot.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 3/3] net: stmmac: Add glue layer for Spacemit K3
 SoC
Message-ID: <aW9jbqBSgkiLLw8r@pie>
References: <20260120043609.910302-1-inochiama@gmail.com>
 <20260120043609.910302-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120043609.910302-4-inochiama@gmail.com>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [10.34 / 15.00];
	URIBL_BLACK(7.50)[ziyao.cc:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[37];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[ziyao.cc:s=zmail];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,cqsoftware.com.cn,disroot.org,nxp.com,bp.renesas.com,linux.intel.com,bootlin.com,eswincomputing.com,altera.com,cherry.de,st.com,synopsys.com];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-251455-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	R_SPF_SOFTFAIL(0.00)[~all];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@ziyao.cc,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[ziyao.cc,quarantine];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[ziyao.cc:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6BB4C5FDE0
X-Rspamd-Action: add header
X-Spam: Yes

On Tue, Jan 20, 2026 at 12:36:08PM +0800, Inochi Amaoto wrote:
> Adds Spacemit dwmac driver support on the Spacemit K3 SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-spacemit.c  | 224 ++++++++++++++++++
>  3 files changed, 237 insertions(+)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> new file mode 100644
> index 000000000000..72744e60d02a
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Spacemit DWMAC platform driver
> + *
> + * Copyright (C) 2026 Inochi Amaoto <inochiama@gmail.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/math.h>

These are the only two headers listed out-of-order. Is this intended?

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>

...

> +static int spacemit_dwmac_detected_delay_value(unsigned int delay,
> +					       unsigned int *config)
> +{
> +	int i;
> +	int code, best_code = 0;
> +	unsigned int best_delay = 0;
> +	unsigned int best_config = 0;
> +
> +	if (delay == 0)
> +		return 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(k3_delay_step_10x); i++) {
> +		unsigned int step = k3_delay_step_10x[i];
> +
> +		for (code = 1; code <= MAX_DLINE_DELAY_CODE; code++) {
> +			/*
> +			 * Note K3 require a specific factor for calculate
> +			 * the delay, in this scenario it is 0.9. So the
> +			 * formula is code * step / 10 * 0.9
> +			 */
> +			unsigned int tmp = code * step * 9 / 10 / 10;
> +
> +			if (abs(tmp - delay) < abs(best_delay - delay)) {
> +				best_code = code;
> +				best_delay = tmp;
> +				best_config = i;
> +			}

Is the inner loop really necessary? Could it be replaced by

	this_code = DIV_ROUND_CLOSEST(delay * 10 * 10, step * 9);
	this_delay = this_code * step * 9 / 10 / 10;

Then comparing abs(this_delay - delay) and abs(best_delay - delay)?

> +		}
> +	}
> +
> +	*config = best_config;
> +
> +	return best_code;
> +}

...

> +static int spacemit_dwmac_update_ifconfig(struct plat_stmmacenet_data *plat_dat,
> +					  struct stmmac_resources *stmmac_res,
> +					  struct regmap *apmu,
> +					  unsigned int ctrl_offset)
> +{
> +	unsigned int mask = PHY_INTF_MII | PHY_INTF_RGMII | WAKE_IRQ_EN;
> +	unsigned int val = 0;
> +
> +	switch (plat_dat->phy_interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		val |= PHY_INTF_MII;
> +		break;

The OR operation seems unnecessary and could be replaced with an
assignment. Same for PHY_INTERFACE_MODE_RGMII's case.

> +
> +	case PHY_INTERFACE_MODE_RMII:
> +		break;
> +
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		val |= PHY_INTF_RGMII;
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}

...

> +static int spacemit_dwmac_probe(struct platform_device *pdev)
> +{

...

> +	of_property_read_u32(pdev->dev.of_node, "tx-internal-delay-ps", &tx_delay);
> +	of_property_read_u32(pdev->dev.of_node, "rx-internal-delay-ps", &rx_delay);

According to of.h, of_property_read_u32, which in turn calls
of_property_read_u32_array, could fail with -ENODATA if there's no value
associated with the property. Should the case be handled?

Regards,
Yao Zi

