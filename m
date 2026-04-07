Return-Path: <netdev+bounces-275829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL0BN7Fn1GkMtwcAu9opvQ
	(envelope-from <netdev+bounces-275829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:10:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4DD3A8E60
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00B7D304A5AD
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03938283FF5;
	Tue,  7 Apr 2026 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YheRBWI9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B582264C7;
	Tue,  7 Apr 2026 02:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527804; cv=none; b=TrD1suuLLkBVcbErCmKFp28QSI40KTv44xoicRjVJ7nTVNsBEAeQ2IT6QnmXHP2Ay21S0qpu3rSHxfNa54V39MPgMmkMv2q7njteliQduHq5TledH2L2u1mBfYASdcmeoH1loolIbmjKOKPUvixxBSD+eEw5y7gch1J+rHE8lno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527804; c=relaxed/simple;
	bh=ZIIp/+ZUoCnQFU4UxASiRQxcQE6IhtOQ6CK/qGpyTpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFkNkEZNOVyuX1qOlAsv8ABd4Z09AkVY2Cnt9orMlv8mv/MB2UiRufv/97aHwEPLdInOH5Kpf4TkytVipbeOsgo7RZU8ly5chflWX4h4KITZ8z+gAfzT4+qt6WJT5h0l883fES9k+iIG3VYVOCt9Y2qEkdUIz5TYlVJW3vfHea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YheRBWI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFAFC2BCB2;
	Tue,  7 Apr 2026 02:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775527804;
	bh=ZIIp/+ZUoCnQFU4UxASiRQxcQE6IhtOQ6CK/qGpyTpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YheRBWI9F1HtwM5G2yFcl/FwnK3egO39Fh7LQR9y1FIfLXGbOI8XXGmqxsOnBUXW9
	 YL8KsmM170BEIkKX0kBJX057CRwyWOO2CLV30RDNLLcbmsLc0+6XObTTmwtJXCWCn7
	 wGBEBWJEWCIpoOSwbFABvEe3w/u6CjzpfUAQi/SizmkqlqNO3c5t6RCEqF7UW4Ukx7
	 9Sh/53wIf/nsDJPF8f9Xo6f+L4cI6QD4727REsxx16GfTCKmPj/Svcskl37NTaAnuh
	 jDtSzPfNSvHofGxD4YIskqMnAHHVSsoR5cbgmL8sh7bVMxVHMbY+eiXv9NrPkHfTQO
	 Wt9CKCQgD7mzQ==
From: Jakub Kicinski <kuba@kernel.org>
To: jitendra.vegiraju@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	richardcochran@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	rmk+kernel@armlinux.org.uk,
	rohan.g.thomas@altera.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	me@ziyao.cc,
	siyanteng@cqsoftware.com.cn,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	vladimir.oltean@nxp.com,
	lizhi2@eswincomputing.com,
	boon.khai.ng@altera.com,
	maxime.chevallier@bootlin.com,
	chenchuangyu@xiaomi.com,
	yangtiezhu@loongson.cn,
	ovidiu.panait.rb@renesas.com,
	chenhuacai@kernel.org,
	florian.fainelli@broadcom.com,
	quic_abchauha@quicinc.com
Subject: Re: [PATCH net-next v9 3/4] net: stmmac: Add PCI glue driver for BCM8958x
Date: Mon,  6 Apr 2026 19:10:01 -0700
Message-ID: <20260407021001.3674617-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402213629.1996133-4-jitendra.vegiraju@broadcom.com>
References: <20260402213629.1996133-4-jitendra.vegiraju@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,foss.st.com,davemloft.net,google.com,redhat.com,gmail.com,broadcom.com,iogearbox.net,armlinux.org.uk,altera.com,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[38];
	TAGGED_FROM(0.00)[bounces-275829-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E4DD3A8E60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Date:   Thu Apr 2 21:36:28 2026 +0000

    net: stmmac: Add PCI glue driver for BCM8958x

    Add pci ethernet driver support for Broadcom BCM8958x soc devices used
    in automotive applications. This device features a pcie ethernet mac
    directly attached to an integrated ethernet switch using an xgmii interface.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
> new file mode 100644
> index 0000000000000..e8c6b4b618acb
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
[ ... ]
> +static const struct software_node *brcm_swnodes[] = {
> +	&parent_swnode,
> +	&fixed_link_swnode,
> +	NULL
> +};

Will this statically allocated global software node array cause issues if
multiple devices are present?

If a second device is probed, software_node_register_node_group might fail
with an error. Additionally, if one device is unbound, unregistering the
group could destroy the global nodes, causing a use-after-free for any other
active instances.

Could these software nodes be dynamically allocated per-device?

[ ... ]
> +static int brcm_drv_init(struct device *dev, void *bsp_priv)
> +{
> +	struct brcm_priv_data *brcm_priv = (struct brcm_priv_data *)bsp_priv;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int vector;
> +	int ret;
> +
> +	/* This device is directly attached to the switch chip internal to the
> +	 * SoC using XGMII interface. Since no MDIO is present, register
> +	 * fixed-link software_node to create phylink.
> +	 */
> +	ret = software_node_register_node_group(brcm_swnodes);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to register software_node\n");
> +	device_set_node(dev, software_node_fwnode(&parent_swnode));

Does device_set_node overwrite the device's primary firmware node here?

Using device_set_node can destroy existing acpi or device tree companion
nodes. Would it be safer to use device_add_software_node instead to attach
the node without overwriting the primary firmware node?

> +
> +	pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LOW,
> +			       XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LO_VALUE);
> +	pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HIGH,
> +			       XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HI_VALUE);
> +
> +	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_OFFSET,
> +		     XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_VALUE);
> +	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_OFFSET,
> +		     XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_VALUE);

[ ... ]

> +static void brcm_drv_exit_cleanup(struct device *dev, void *bsp_priv)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	device_set_node(&pdev->dev, NULL);
> +	software_node_unregister_node_group(brcm_swnodes);
> +}

If device_set_node is called with NULL, will it leave the device permanently
mangled without its original firmware node upon unbind?

[ ... ]
> +static int brcm_pci_resume(struct device *dev, void *bsp_priv)
> +{
> +	/* Enable Switch Link */
> +	misc_iowrite(bsp_priv, XGMAC_PCIE_MISC_MII_CTRL_OFFSET,
> +		     XGMAC_PCIE_MISC_MII_CTRL_PAUSE_RX |
> +		     XGMAC_PCIE_MISC_MII_CTRL_PAUSE_TX |
> +		     XGMAC_PCIE_MISC_MII_CTRL_LINK_UP);
> +
> +	return stmmac_pci_plat_resume(dev, bsp_priv);
> +}

Will the hardware state configured in brcm_drv_init be fully restored after
a suspend and resume cycle?

When a pci device resumes from suspend, its internal state is typically reset
to defaults. Since the pci core's pci_save_state does not save arbitrary mmio
registers or custom extended configuration registers, it appears the msi-x
routing and address match configurations programmed during probe might be
lost.

Could this cause the msi-x interrupts to stop working after resume?

