Return-Path: <netdev+bounces-274825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAtpDVgVz2k2swYAu9opvQ
	(envelope-from <netdev+bounces-274825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:18:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F68638FEE4
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAA52302DF5C
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499E72820A9;
	Fri,  3 Apr 2026 01:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odmCkW0v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A827A907;
	Fri,  3 Apr 2026 01:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179047; cv=none; b=IaZcCCjUd9vPXyrnAjkS8CiYDanoc9jtmcoB1nMi4lvqWK4HP7bz3HXow2Q1oYm2Qj3nSYu9KSShIzfWoYyycoZnEfXf/at62iI62DTtwCY7avI8GhfLy1w4DALxQd3AoVv9I50reWnrbN6kLRmF7hqBUo2Kwet4VRdZC3vEkI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179047; c=relaxed/simple;
	bh=JaZaqXx7UjhAu1o2iKmm1mcnfKWDRIbQehAs9zgMebg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2XQ1mpECdnh9O0Caj4hUWyD2b7llw6kbGhDLUff0CIUzAuUgBdFAw9K3RY1SjuapyscezTvFS8p4SzKL9uA+/i/nHNi8o9ooNIJoxZBHT1BfQ9PadHzyca8ELvH9eSzhpItbyFVKkOClgVNJJ4wBfA/TM87SYCMI4Hvj38it+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odmCkW0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5498C116C6;
	Fri,  3 Apr 2026 01:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179046;
	bh=JaZaqXx7UjhAu1o2iKmm1mcnfKWDRIbQehAs9zgMebg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odmCkW0vCuh4urc8EBRzGnbdsI1D7bki86zEYeShQ5iBGE0KbhZtGUh1TYW61UifM
	 vlZHEIb9RaVRJGFQM90CW2FTMdJVg7rTtV3Cn6qKnA6Udo6V2mCALGdOOkpc7sWyL7
	 1/mYbbTxLddFsySO148Z/Di7Bi0W8SPd3NAHFa/gBoX46ljq7C9wKjgbsSufCiBleV
	 BzDqEBm7D2ZkGrCurTK/ahccod50nLtj/EEtaNvDUbNyMG3jUXrtG9MXFelGSUExpp
	 lLGnyvayMqtQU/dbr2Mwt942GBzYgPP47aePrQlIDLtC0Iir7STP++CxmJmplaBXM5
	 iC2+aAECkb13Q==
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 net-next 03/14] net: enetc: add pre-boot initialization for i.MX94 switch
Date: Thu,  2 Apr 2026 18:17:23 -0700
Message-ID: <20260403011723.1795349-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-4-wei.fang@nxp.com>
References: <20260331113025.1566878-4-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,lists.ozlabs.org,lists.infradead.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-274825-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F68638FEE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: enetc: add pre-boot initialization for i.MX94 switch

This commit adds pre-boot initialization logic for the i.MX94 switch
in the NETC block control driver. It configures external ports, MII
protocols, and MDIO PHY addresses, and handles the MAC selection
constraint between switch port 2 and ENETC 0.

> diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> index 92a0f824dae7..c21230f7a7fb 100644
> --- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> +++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
[ ... ]
> +static int imx94_switch_link_config(struct netc_blk_ctrl *priv,
> +				    struct device_node *np,
> +				    bool *swp2_en)
> +{
> +	struct device_node *ports;
> +	int port_id, err = 0;

Since of_property_read_u32() expects a u32 pointer, does passing a
signed int pointer here trigger an incompatible pointer types warning
during compilation?

> +
> +	ports = netc_get_switch_ports(np);
> +	if (!ports)
> +		return -ENODEV;
> +
> +	for_each_available_child_of_node_scoped(ports, child) {
> +		if (of_property_read_u32(child, "reg", &port_id) < 0) {

If the device tree provides a reg value with the MSB set, port_id
would be evaluated as a negative number.

[ ... ]
>  static int imx94_netcmix_init(struct platform_device *pdev)
>  {
>  	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
>  	struct device_node *np = pdev->dev.of_node;
> +	bool enetc0_en = false, swp2_en = false;
>  	u32 val;
>  	int err;
>  
>  	for_each_child_of_node_scoped(np, child) {
>  		for_each_child_of_node_scoped(child, gchild) {
> -			if (!of_device_is_compatible(gchild, "pci1131,e101"))
> -				continue;
> -
> -			err = imx94_enetc_link_config(priv, gchild);
> -			if (err)
> -				return err;
> +			if (of_device_is_compatible(gchild, "pci1131,e101")) {
> +				err = imx94_enetc_link_config(priv, gchild,
> +							      &enetc0_en);
> +				if (err)
> +					return err;
> +			} else if (of_device_is_compatible(gchild,
> +							   "pci1131,eef2")) {

Is it possible for the switch node to be disabled in the device tree?

If so, should we check of_device_is_available() for gchild before proceeding,
similar to how it is checked for enetc0_en?

Without checking availability, if the disabled switch lacks a ports subnode,
imx94_switch_link_config() might return -ENODEV and abort the entire probe.

Alternatively, if the disabled switch node has a ports subnode with an
available port 2, it could spuriously set swp2_en = true and cause a false
conflict with ENETC 0.

> +				err = imx94_switch_link_config(priv, gchild,
> +							       &swp2_en);
> +				if (err)
> +					return err;
> +			}
>  		}
>  	}
[ ... ]
> @@ -610,6 +682,77 @@ static int imx94_enetc_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
>  	return 0;
>  }
>  
> +static int imx94_ierb_enetc_init(struct netc_blk_ctrl *priv,
[ ... ]
> +static int imx94_switch_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
> +					    struct device_node *np,
> +					    int port_id, u32 phy_mask)
> +{
> +	int addr;
> +
> +	/* The switch has 3 external ports at most */
> +	if (port_id > 2)
> +		return 0;

If port_id is negative due to the signed type, it will bypass this upper
bound check.

> +
> +	addr = netc_get_phy_addr(np);
> +	if (addr < 0) {
> +		if (addr == -ENODEV)
> +			return 0;
> +
> +		return addr;
> +	}
> +
> +	if (phy_mask & BIT(addr)) {
> +		dev_err(&priv->pdev->dev,
> +			"Found same PHY address in EMDIO and switch node\n");
> +		return -EINVAL;
> +	}
> +
> +	netc_reg_write(priv->ierb, IERB_LBCR(port_id),
> +		       LBCR_MDIO_PHYAD_PRTAD(addr));

Could this lead to an out-of-bounds register write prior to the array base
since port_id is negative?

> +
> +	return 0;
> +}
> +
> +static int imx94_ierb_switch_init(struct netc_blk_ctrl *priv,
> +				  struct device_node *np,
> +				  u32 phy_mask)
> +{
> +	struct device_node *ports;
> +	int port_id, err = 0;

A similar signed int declaration is used here for port_id, which would run
into the same pointer type warning and negative value issues.

> +
> +	ports = netc_get_switch_ports(np);
> +	if (!ports)
> +		return -ENODEV;
[ ... ]
-- 
pw-bot: cr

