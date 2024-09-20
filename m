Return-Path: <netdev+bounces-129130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1C097DAB2
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 01:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E971F22379
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 23:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E26B187322;
	Fri, 20 Sep 2024 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaSfXY8C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4A0127E18;
	Fri, 20 Sep 2024 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726873538; cv=none; b=eq1CwOeHp4pe1MMbVJyv7qj1YGcldjddtFKNF6j9zJESG1hi9CkqNYRuqAoeD3axpNNlHerNlXrKGruMoEO9YPhR3f5UNcoalsT3Y6H21wPhsLeKdmSdNvoawiHGGt2I0zquYM0gb6bHVR/fljOkqJUM500p1vrjkyFEqCrlYJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726873538; c=relaxed/simple;
	bh=+rGQG04/nZt6KRqsZLKR/tBIRsrN3V+5ZxUWtF5UQSs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=vBAoaozfhn7VscQQB97PGdttbBpvBAjXJl5PTa0Dxixt/fjQZXoRSuSjCTW6cbohPNjLT1igBKiSStbjq7srhwsMmCeRDizI5C8ZKErRGDctwAfJ5ltkrSy6LDmuI8KBPfG3boGvHtngTDWxbzLeQJpv0c7C+Ioo81VjxGRxSBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaSfXY8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429DDC4CEC3;
	Fri, 20 Sep 2024 23:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726873538;
	bh=+rGQG04/nZt6KRqsZLKR/tBIRsrN3V+5ZxUWtF5UQSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QaSfXY8C2N7f9mmOhDpOncGN700G7CoKIJlFkZCWD4k62fAGjcovMdJodrZdy8XgO
	 dj/E4vnStINydTDsjLA7RDUl1dkBLPbmVfb8YmgVZJMlC6fvzE+54DaliMaUJIVKTl
	 nypXr9UD9YJBH5NlyTfvxK2vONEzhbSbfan7mWksBB9oQekoc78tSOgc3CV0ub1RC1
	 00kwCF08e/FtsCjvMRQzprNdGra8v9Van2pqxy9rWma7XxRp6HE6fv3HpYFia+3tZZ
	 kVyWtfPCVVnAndZDjvEGGapCzcCmkI56zuy5oubeozVrTAgeBN39iLnr3NzIFca8eH
	 SkusSwhRKoJfw==
Date: Fri, 20 Sep 2024 18:05:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [RFC] net:yt6801: Add Motorcomm yt6801 PCIe driver
Message-ID: <20240920230534.GA1071655@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913124113.9174-1-Frank.Sae@motor-comm.com>

On Fri, Sep 13, 2024 at 09:00:04PM +0800, Frank Sae wrote:
> This patch is to add the ethernet device driver for the PCIe interface of
> Motorcomm YT6801 Gigabit Ethernet.

> +static void fxgmac_pcie_init(struct fxgmac_pdata *pdata, bool ltr_en,
> +			     bool aspm_l1ss_en, bool aspm_l1_en,
> +			     bool aspm_l0s_en)
> +{
> +	struct pci_dev *pdev = to_pci_dev(pdata->dev);
> +	u16 deviceid = 0;
> +	u8 revid = 0;
> +	u32 val = 0;
> +
> +	pci_read_config_dword(pdev, PCI_LINK_CTRL, &val);
> +	if ((FIELD_GET(LINK_CTRL_L1_STATUS, pdata->pcie_link_status)) &&
> +	    0x00 == FXGMAC_GET_BITS(val, LINK_CTRL_ASPM_CONTROL_POS,
> +				    LINK_CTRL_ASPM_CONTROL_LEN)) {
> +		fxgmac_set_bits(&val, LINK_CTRL_ASPM_CONTROL_POS,
> +				LINK_CTRL_ASPM_CONTROL_LEN,
> +				pdata->pcie_link_status);
> +		pci_write_config_dword(pdev, PCI_LINK_CTRL, val);

You shouldn't be writing ASPM config bits directly; that should be
managed by the PCI core.  Please report any related problems or
missing functionality in the PCI core.

> +	pci_read_config_byte(pdev, PCI_REVISION_ID, &revid);
> +	pci_read_config_word(pdev, PCI_DEVICE_ID, &deviceid);

Already in pdev->device, pdev->revision; no need to read again.

> +	/* yt6801 rev 01 adjust sigdet threshold to 55 mv*/

Space before closing "*/"

> +	if (YT6801_REV_01 == revid && YT6801_PCI_DEVICE_ID == deviceid) {
> +		val = rd32_mem(pdata, MGMT_SIGDET);
> +		fxgmac_set_bits(&val, MGMT_SIGDET_POS, MGMT_SIGDET_LEN,
> +				MGMT_SIGDET_55MV);
> +		wr32_mem(pdata, val, MGMT_SIGDET);
> +	}
> +}

> +	/* Power Management*/

Space before closing "*/".

> +	/*For phy write /read*/

Space after opening "/*" and before closing "*/".

> +static void fxgmac_check_esd_work(struct fxgmac_pdata *pdata)
> +{
> +	struct fxgmac_esd_stats *stats = &pdata->esd_stats;
> +	struct pci_dev *pdev = to_pci_dev(pdata->dev);
> +	u32 val, i = 0;
> +
> +	/* ESD test make recv crc errors more than 4294967xxx in one second. */
> +	if (stats->rx_crc_errors > FXGMAC_ESD_ERROR_THRESHOLD ||
> +	    stats->rx_align_errors > FXGMAC_ESD_ERROR_THRESHOLD ||
> +	    stats->rx_runt_errors > FXGMAC_ESD_ERROR_THRESHOLD ||
> +	    stats->tx_abort_excess_collisions > FXGMAC_ESD_ERROR_THRESHOLD ||
> +	    stats->tx_dma_underrun > FXGMAC_ESD_ERROR_THRESHOLD ||
> +	    stats->tx_lost_crs > FXGMAC_ESD_ERROR_THRESHOLD ||
> +	    stats->tx_late_collisions > FXGMAC_ESD_ERROR_THRESHOLD ||
> +	    stats->single_collisions > FXGMAC_ESD_ERROR_THRESHOLD ||
> +	    stats->multi_collisions > FXGMAC_ESD_ERROR_THRESHOLD ||
> +	    stats->tx_deferred_frames > FXGMAC_ESD_ERROR_THRESHOLD) {
> +		yt_dbg(pdata,
> +		       "rx_crc_errors:%ul, rx_align_errors:%ul, rx_runt_errors:%ul, tx_abort_excess_collisions:%ul, tx_dma_underrun:%ul, tx_lost_crs:%ul, tx_late_collisions:%ul, single_collisions:%ul, multi_collisions:%ul, tx_deferred_frames:%ul\n",
> +		       stats->rx_crc_errors, stats->rx_align_errors,
> +		       stats->rx_runt_errors, stats->tx_abort_excess_collisions,
> +		       stats->tx_dma_underrun, stats->tx_lost_crs,
> +		       stats->tx_late_collisions, stats->single_collisions,
> +		       stats->multi_collisions, stats->tx_deferred_frames);
> +
> +		yt_err(pdata, "%s, esd error, restart NIC...\n", __func__);
> +
> +		pci_read_config_dword(pdev, PCI_COMMAND, &val);
> +		while ((val == FXGMAC_PCIE_LINK_DOWN) &&

Use PCI_POSSIBLE_ERROR() instead.

> +		       (i++ < FXGMAC_PCIE_RECOVER_TIMES)) {
> +			usleep_range(200, 210);
> +			pci_read_config_dword(pdev, PCI_COMMAND, &val);
> +			yt_dbg(pdata, "pcie recovery link cost %d(200us)\n", i);
> +		}
> +
> +		if (val == FXGMAC_PCIE_LINK_DOWN) {
> +			yt_err(pdata, "pcie link down, recovery err.\n");
> +			return;
> +		}
> +
> +		if (val & FXGMAC_PCIE_IO_MEM_MASTER_ENABLE) {
> +			pdata->hw_ops.esd_restore_pcie_cfg(pdata);
> +			pci_read_config_dword(pdev, PCI_COMMAND, &val);
> +			yt_dbg(pdata,
> +			       "pci command reg is %x after restoration.\n",
> +			       val);
> +			fxgmac_restart(pdata);
> +		}
> +	}
> +
> +	memset(stats, 0, sizeof(struct fxgmac_esd_stats));
> +}

> +static int fxgmac_disable_pci_msi_config(struct fxgmac_pdata *pdata)
> +{
> +	u32 pcie_msi_mask_bits = 0, pcie_cap_offset = 0;
> +	struct pci_dev *pdev = to_pci_dev(pdata->dev);
> +	int ret = 0;
> +
> +	pcie_cap_offset = pci_find_capability(pdev, PCI_CAP_ID_MSI);
> +	if (pcie_cap_offset) {
> +		ret = pci_read_config_dword(pdev, pcie_cap_offset,
> +					    &pcie_msi_mask_bits);
> +		if (ret) {
> +			yt_err(pdata,
> +			       "read pci config space MSI cap. err :%d\n", ret);
> +			return -EFAULT;
> +		}
> +	}
> +
> +	fxgmac_set_bits(&pcie_msi_mask_bits, PCI_CAP_ID_MSI_ENABLE_POS,
> +			PCI_CAP_ID_MSI_ENABLE_LEN, 0);
> +	ret = pci_write_config_dword(pdev, pcie_cap_offset, pcie_msi_mask_bits);
> +	if (ret) {
> +		yt_err(pdata, "write pci config space MSI mask err :%d\n", ret);
> +		return -EFAULT;
> +	}
> +
> +	return ret;
> +}

Nothing here is fxgmac-specific.  Maybe pci_disable_msi() or similar
could be used?

> +static int fxgmac_disable_pci_msix_config(struct fxgmac_pdata *pdata)
> +{
> +	u32 pcie_msi_mask_bits = 0;
> +	u16 pcie_cap_offset = 0;
> +	struct pci_dev *pdev = to_pci_dev(pdata->dev);
> +	int ret = 0;
> +
> +	pcie_cap_offset = pci_find_capability(pdev, PCI_CAP_ID_MSIX);
> +	if (pcie_cap_offset) {
> +		ret = pci_read_config_dword(pdev, pcie_cap_offset,
> +					    &pcie_msi_mask_bits);
> +		if (ret) {
> +			yt_err(pdata,
> +			       "read pci config space MSIX cap. err: %d\n",
> +			       ret);
> +			return -EFAULT;
> +		}
> +	}
> +
> +	fxgmac_set_bits(&pcie_msi_mask_bits, PCI_CAP_ID_MSIX_ENABLE_POS,
> +			PCI_CAP_ID_MSIX_ENABLE_LEN, 0);
> +	ret = pci_write_config_dword(pdev, pcie_cap_offset, pcie_msi_mask_bits);
> +	if (ret) {
> +		yt_err(pdata, "write pci config space MSIX mask err:%d\n", ret);
> +		return -EFAULT;
> +	}
> +
> +	return ret;
> +}

Nothing here is fxgmac-specific.  Maybe pci_disable_msix() or similar
could be used?

> +int fxgmac_start(struct fxgmac_pdata *pdata)
> +{
> +	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
> +	unsigned int pcie_low_power = 0;
> +	u32 val;
> +	int ret;
> +
> +	if (pdata->dev_state != FXGMAC_DEV_OPEN &&
> +	    pdata->dev_state != FXGMAC_DEV_STOP &&
> +	    pdata->dev_state != FXGMAC_DEV_RESUME)
> +		return 0;
> +
> +	/* must reset software again here, to avoid flushing tx queue error
> +	 * caused by the system only run probe
> +	 * when installing driver on the arm platform.
> +	 */
> +	hw_ops->exit(pdata);
> +
> +	if (pdata->int_flags & FXGMAC_FLAG_LEGACY_ENABLED) {
> +		/* we should disable msi and msix here when we use legacy
> +		 * interrupt,for two reasons:
> +		 * 1. Exit will restore msi and msix config regisiter,
> +		 * that may enable them.
> +		 * 2. When the driver that uses the msix interrupt by default
> +		 * is compiled into the OS, uninstall the driver through rmmod,
> +		 * and then install the driver that uses the legacy interrupt,
> +		 * at which time the msix enable will be turned on again by
> +		 * default after waking up from S4 on some
> +		 * platform. such as UOS platform.
> +		 */
> +		ret = fxgmac_disable_pci_msi_config(pdata);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = fxgmac_disable_pci_msix_config(pdata);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	fxgmac_phy_reset(pdata);
> +	ret = fxgmac_phy_release(pdata);
> +	if (ret < 0)
> +		return ret;
> +
> +#define PCIE_LP_ASPM_L0S		1
> +#define PCIE_LP_ASPM_L1			2
> +#define PCIE_LP_ASPM_L1SS		4
> +#define PCIE_LP_ASPM_LTR		8
> +	hw_ops->pcie_init(pdata, pcie_low_power & PCIE_LP_ASPM_LTR,
> +			  pcie_low_power & PCIE_LP_ASPM_L1SS,
> +			  pcie_low_power & PCIE_LP_ASPM_L1,
> +			  pcie_low_power & PCIE_LP_ASPM_L0S);

AFAICT, pcie_low_power is 0 here, so all the "pcie_low_power &
PCIE_LP_ASPM_LTR" and similar looks pointless.

> +static int fxgmac_set_mac_address(struct net_device *netdev, void *addr)
> +{
> +	struct fxgmac_pdata *pdata = netdev_priv(netdev);
> +	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
> +	struct sockaddr *saddr = addr;
> +
> +	if (!is_valid_ether_addr(saddr->sa_data))
> +		return -EADDRNOTAVAIL;
> +
> +	eth_hw_addr_set(netdev, saddr->sa_data);
> +	memcpy(pdata->mac_addr, saddr->sa_data, netdev->addr_len);
> +	hw_ops->set_mac_address(pdata, saddr->sa_data);
> +	hw_ops->set_mac_hash(pdata);
> +
> +	yt_dbg(pdata, "fxgmac,set mac addr to %02x:%02x:%02x:%02x:%02x:%02x\n",
> +	       netdev->dev_addr[0], netdev->dev_addr[1], netdev->dev_addr[2],
> +	       netdev->dev_addr[3], netdev->dev_addr[4], netdev->dev_addr[5]);

See
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/core-api/printk-formats.rst?id=v6.11#n297,
perhaps use %pM here?

> +static int fxgmac_change_mtu(struct net_device *netdev, int mtu)
> +{
> +	struct fxgmac_pdata *pdata = netdev_priv(netdev);
> +	int old_mtu = netdev->mtu;
> +	int ret, max_mtu;
> +
> +	max_mtu = FXGMAC_JUMBO_PACKET_MTU - ETH_HLEN;
> +	if (mtu > max_mtu) {
> +		yt_err(pdata, "MTU exceeds maximum supported value\n");

Always nice to include the offending value (mtu) instead of just a
constant string with no real information other than "we were here".

> +static int fxgmac_all_poll(struct napi_struct *napi, int budget)
> +{
> +	struct fxgmac_pdata *pdata =
> +		container_of(napi, struct fxgmac_pdata, napi);
> +	struct fxgmac_channel *channel;
> +	int processed;
> +
> +	if (netif_msg_rx_status(pdata))
> +		yt_dbg(pdata, "%s, budget=%d\n", __func__, budget);
> +
> +	processed = 0;
> +	do {
> +		channel = pdata->channel_head;
> +		/*since only 1 tx channel supported in this version, poll

Add space after opening "/*".

> +#ifdef CONFIG_PM
> +static int fxgmac_suspend(struct pci_dev *pcidev,
> +			  pm_message_t __always_unused state)

Use generic power management, not the pci_driver.suspend()/resume()
callbacks.

See, for example, these patches that converted drivers to use generic
power management:
https://lore.kernel.org/all/?q=f%3Avaibhavgupta40%40gmail.com+s%3A%22power+management%22

> +{
> +	struct net_device *netdev = dev_get_drvdata(&pcidev->dev);
> +	struct fxgmac_pdata *pdata = netdev_priv(netdev);
> +	struct device *dev = &pcidev->dev;
> +	int ret = 0;
> +	bool wake;
> +
> +	fxgmac_lock(pdata);
> +	if (pdata->dev_state != FXGMAC_DEV_START)
> +		goto unlock;
> +
> +	if (netif_running(netdev)) {
> +		ret = __fxgmac_shutdown(pcidev, &wake);
> +		if (ret < 0)
> +			goto unlock;
> +	} else {
> +		wake = !!(pdata->wol);
> +	}
> +	ret = fxgmac_phy_cfg_led(pdata, pdata->led.s3);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	if (wake) {
> +		pci_prepare_to_sleep(pcidev);
> +	} else {
> +		pci_wake_from_d3(pcidev, false);
> +		pci_set_power_state(pcidev, PCI_D3hot);
> +	}

If you use generic power management, the PCI core *should* take care
of pci_prepare_to_sleep(), pci_wake_from_d3(), pci_set_power_state(),
I think.  You should only need to do fxgmac-specific things here.

> +	pdata->dev_state = FXGMAC_DEV_SUSPEND;
> +unlock:
> +	fxgmac_unlock(pdata);
> +	dev_dbg(dev, "%s, set to %s\n", __func__, wake ? "sleep" : "D3hot");
> +
> +	return ret;
> +}
> +
> +static int fxgmac_resume(struct pci_dev *pcidev)
> +{
> +	struct net_device *netdev = dev_get_drvdata(&pcidev->dev);
> +	struct fxgmac_pdata *pdata = netdev_priv(netdev);
> +	struct device *dev = &pcidev->dev;
> +	int ret = 0;
> +
> +	fxgmac_lock(pdata);
> +	if (pdata->dev_state != FXGMAC_DEV_SUSPEND)
> +		goto unlock;
> +
> +	pdata->dev_state = FXGMAC_DEV_RESUME;
> +
> +	pci_set_power_state(pcidev, PCI_D0);
> +	pci_restore_state(pcidev);
> +
> +	/* pci_restore_state clears dev->state_saved so call
> +	 * pci_save_state to restore it.
> +	 */
> +	pci_save_state(pcidev);
> +
> +	ret = pci_enable_device_mem(pcidev);
> +	if (ret < 0) {
> +		dev_err(dev, "%s, pci_enable_device_mem err:%d\n", __func__,
> +			ret);
> +		goto unlock;
> +	}
> +
> +	/* flush memory to make sure state is correct */
> +	smp_mb__before_atomic();
> +	__clear_bit(FXGMAC_POWER_STATE_DOWN, &pdata->powerstate);
> +	pci_set_master(pcidev);
> +	pci_wake_from_d3(pcidev, false);

Same for resume, the PCI core *should* take care of the generic PCI
stuff if you use generic power management.

> +	rtnl_lock();
> +	if (netif_running(netdev)) {
> +		ret = fxgmac_net_powerup(pdata);
> +		if (ret < 0) {
> +			dev_err(dev, "%s, fxgmac_net_powerup err:%d\n",
> +				__func__, ret);
> +			goto unlock;
> +		}
> +	}
> +
> +	netif_device_attach(netdev);
> +	rtnl_unlock();
> +
> +	dev_dbg(dev, "%s ok\n", __func__);
> +unlock:
> +	fxgmac_unlock(pdata);
> +
> +	return ret;
> +}

> +#define PCI_PM_STATCTRL				0x44 /* WORD reg */
> +#define PM_STATCTRL_PWR_STAT_POS		0
> +#define PM_STATCTRL_PWR_STAT_LEN		2
> +#define  PM_STATCTRL_PWR_STAT_D0		0
> +#define  PM_STATCTRL_PWR_STAT_D3		3
> +#define PM_CTRLSTAT_PME_EN_POS			8
> +#define PM_CTRLSTAT_PME_EN_LEN			1
> +#define PM_CTRLSTAT_DATA_SEL_POS		9
> +#define PM_CTRLSTAT_DATA_SEL_LEN		4
> +#define PM_CTRLSTAT_DATA_SCAL_POS		13
> +#define PM_CTRLSTAT_DATA_SCAL_LEN		2
> +#define PM_CTRLSTAT_PME_STAT_POS		15
> +#define PM_CTRLSTAT_PME_STAT_LEN		1

Should use existing PCI_PM_PMC and related #defines instead of
duplicating them here.  Use pci_find_capability(PCI_CAP_ID_PM) to
locate the capability.

> +#define PCI_DEVICE_CTRL1			0x78
> +#define DEVICE_CTRL1_CONTROL_POS		0
> +#define DEVICE_CTRL1_CONTROL_LEN		16
> +#define DEVICE_CTRL1_STATUS_POS			16
> +#define DEVICE_CTRL1_STATUS_LEN			16

Use PCI_EXP_DEVCTL instead of duplicating it here.  The bits inside
(DEVICE_CTRL1_*) aren't used, so omit them.

> +#define PCI_LINK_CTRL				0x80
> +#define LINK_CTRL_ASPM_CONTROL_POS		0
> +#define LINK_CTRL_ASPM_CONTROL_LEN		2
> +#define  LINK_CTRL_L1_STATUS			2
> +#define LINK_CTRL_CONTROL_CPM_POS		8
> +#define LINK_CTRL_CONTROL_CPM_LEN		1
> +#define LINK_CTRL_STATUS_POS			16
> +#define LINK_CTRL_STATUS_LEN			16

PCI_EXP_LNKCTL.

> +#define PCI_DEVICE_CTRL2			0x98 /* WORD reg */
> +#define DEVICE_CTRL2_LTR_EN_POS			10 /* Enable from BIOS side. */
> +#define DEVICE_CTRL2_LTR_EN_LEN			1

PCI_EXP_DEVCTL2.  These all need pcie_capability_read_word() and
similar.

> +#define PCI_MSIX_CAPABILITY			0xb0

Should locate with pci_find_capability(PCI_CAP_ID_MSIX).

> +#define PCI_ASPM_CONTROL			0x70c
> +#define ASPM_L1_IDLE_THRESHOLD_POS		27
> +#define ASPM_L1_IDLE_THRESHOLD_LEN		3
> +#define  ASPM_L1_IDLE_THRESHOLD_1US		0
> +#define  ASPM_L1_IDLE_THRESHOLD_2US		1
> +#define  ASPM_L1_IDLE_THRESHOLD_4US		2
> +#define  ASPM_L1_IDLE_THRESHOLD_8US		3 /* default value. */
> +#define  ASPM_L1_IDLE_THRESHOLD_16US		4
> +#define  ASPM_L1_IDLE_THRESHOLD_32US		5
> +#define  ASPM_L1_IDLE_THRESHOLD_64US		6

I assume device-specific ASPM control stuff.  Really should be located
via pci_find_ext_capability(), but maybe these aren't organized into
the capability list.

> +#define FXGMAC_GET_BITS(var, pos, len)                                         \
> +	({                                                                     \
> +		typeof(pos) _pos = (pos);                                      \
> +		typeof(len) _len = (len);                                      \
> +		((var) & GENMASK(_pos + _len - 1, _pos)) >> (_pos);            \
> +	})
> +
> +#define FXGMAC_GET_BITS_LE(var, pos, len)                                      \
> +	({                                                                     \
> +		typeof(pos) _pos = (pos);                                      \
> +		typeof(len) _len = (len);                                      \
> +		typeof(var) _var = le32_to_cpu((var));                         \
> +		((_var) & GENMASK(_pos + _len - 1, _pos)) >> (_pos);           \
> +	})
> +
> +#define __FXGMAC_SET_BITS(var, pos, len, val)                                  \
> +	({                                                                     \
> +		typeof(var) _var = (var);                                      \
> +		typeof(pos) _pos = (pos);                                      \
> +		typeof(len) _len = (len);                                      \
> +		typeof(val) _val = (val);                                      \
> +		_val = (_val << _pos) & GENMASK(_pos + _len - 1, _pos);        \
> +		_var = (_var & ~GENMASK(_pos + _len - 1, _pos)) | _val;        \
> +	})
> +
> +static inline void fxgmac_set_bits(u32 *val, u32 pos, u32 len, u32 set_val)
> +{
> +	*(val) = __FXGMAC_SET_BITS(*(val), pos, len, set_val);
> +}
> +
> +#define FXGMAC_SET_BITS_LE(var, pos, len, val)                               \
> +	({                                                                     \
> +		typeof(var) _var = (var);                                      \
> +		typeof(pos) _pos = (pos);                                      \
> +		typeof(len) _len = (len);                                      \
> +		typeof(val) _val = (val);                                      \
> +		_val = (_val << _pos) & GENMASK(_pos + _len - 1, _pos);        \
> +		_var = (_var & ~GENMASK(_pos + _len - 1, _pos)) | _val;        \
> +		cpu_to_le32(_var);                                             \
> +	})

None of these macros has anything to do with FXGMAC-specific things.
Use FIELD_GET(), FIELD_PREP() if you can.

Bjorn

