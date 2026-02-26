Return-Path: <netdev+bounces-261329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJqqOc8+oGmrhAQAu9opvQ
	(envelope-from <netdev+bounces-261329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:38:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C16B1A5C95
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCBE33010624
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AA037B417;
	Thu, 26 Feb 2026 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr1dTEWz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C72337118;
	Thu, 26 Feb 2026 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772109515; cv=none; b=u7Z19y9hjQyDGPqL/umINQS5nX2B8Gu02ciQFFbwXEqEd6VUiAVx1Uq63oAbe2o2CLNRRQ7p7+jqU4tDxDvLTOBH/yTa4LPOYokRwe3hj9e5fJGG7gP0W8ejAKwQ2SCMXU77VTnPqW8xS5rx3vCTxkwX4rKHd3ezcwfIR2YMkNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772109515; c=relaxed/simple;
	bh=I4NninFluXa97EbTMTTHiG/FJYKHhKud0pF5W/3VAFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDOiBbligyuFr04WkAayzepzL3wvq4Gt90vpBxrpN/n16agWDFfwJSfbqN1bv91a6e0I6p9Slelxw1rGaTvlw7bovUOtVbRF8FKhtD4eBp4ly38xCTK9cih0fDcQi+Xrq7flndLIsh+JeltANqtxtqMoDoGk61YkDyhxpQZi69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qr1dTEWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0ADCC116C6;
	Thu, 26 Feb 2026 12:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772109514;
	bh=I4NninFluXa97EbTMTTHiG/FJYKHhKud0pF5W/3VAFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qr1dTEWzxdyt3iaci++YP6coRpai3hqg5nP9VS5zEl9tN/RmzpS8BG9DudP7qIAzw
	 N05AGabT9q6BitCmHFZPgwqOmpBwhtXa9Qx1LFHFjxsPp5RCV+inEUYRJTsGu5+zlZ
	 L6YHiN9gwy0abqsKuNFuK6Vel4Qew1fLHg/O3XEgF/7tupLtx/0brQwdgVmjcOHak6
	 3gVRy+t3V33wN154P3wxARR1W4g/cM0azKEFrbNpFCHWjdOhDPhyNSKqxb6//WLIVg
	 srAZU2ceuJHc/PueN+jS/ydbQQeYf8sC5brr7T/05a5wmp7slfTUfKvuS/nAI53df7
	 z63othO1Udu8w==
Date: Thu, 26 Feb 2026 12:38:30 +0000
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, Thomas.Lendacky@amd.com
Subject: Re: [PATCH net 2/2] amd-xgbe: add PCI power management for S0i3
 support
Message-ID: <aaA-xiedBzGqx9HY@horms.kernel.org>
References: <20260225110001.1000014-1-Raju.Rangoju@amd.com>
 <20260225110001.1000014-3-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225110001.1000014-3-Raju.Rangoju@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261329-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 8C16B1A5C95
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 04:30:01PM +0530, Raju Rangoju wrote:
> Add proper PCI power management operations to support modern standby
> (S0i3) on AMD platforms. The existing suspend/resume implementation
> did not properly handle PCI device state transitions, which prevented
> the system from reaching the deepest sleep states.
> 
> The amd_pmc driver was reporting "Last suspend didn't reach deepest
> state" when the XGBE driver was enabled.
> 
> The implementation follows the standard PCI PM model:
> 
> Suspend path:
> - Powerdown the network interface
> - Set PHY to low-power mode
> - Disable bus mastering to prevent DMA activity
> - Save PCI configuration state
> - Disable the PCI device
> - Disable wake from D3 (required for S0i3 - no Wake-on-LAN needed)
> - Set device to D3hot power state
> 
> Resume path:
> - Restore PCI power state to D0
> - Restore PCI configuration state
> - Enable the PCI device
> - Re-enable bus mastering
> - Re-enable device interrupts
> - Clear PHY low-power mode
> - Power up the network interface
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 39 ++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> index 112d7697174c..8e392cccd065 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> @@ -356,15 +356,34 @@ static int xgbe_pci_suspend(struct device *dev)
>  {
>  	struct xgbe_prv_data *pdata = dev_get_drvdata(dev);
>  	struct net_device *netdev = pdata->netdev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
>  	int ret = 0;
>  
> +	if (!netdev)
> +		return 0;
> +

Can netdev be NULL here?
Same question for the check in xgbe_pci_resume().

>  	if (netif_running(netdev))
>  		ret = xgbe_powerdown(netdev);
>  
> +	/* Disable all device interrupts to prevent spurious wakeups */
> +	XP_IOWRITE(pdata, XP_INT_EN, 0x0);
> +
> +	/* Set PHY to low-power mode */
>  	pdata->lpm_ctrl = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_CTRL1);
>  	pdata->lpm_ctrl |= MDIO_CTRL1_LPOWER;
>  	XMDIO_WRITE(pdata, MDIO_MMD_PCS, MDIO_CTRL1, pdata->lpm_ctrl);
>  
> +	/* Disable bus mastering to prevent DMA activity */
> +	pci_clear_master(pdev);
> +
> +	/* Save PCI configuration state and disable device */
> +	pci_save_state(pdev);
> +	pci_disable_device(pdev);
> +
> +	/* Disable wake from D3 - required for S0i3 deep sleep */
> +	pci_wake_from_d3(pdev, false);
> +	pci_set_power_state(pdev, PCI_D3hot);
> +
>  	return ret;
>  }
>  
> @@ -372,13 +391,33 @@ static int xgbe_pci_resume(struct device *dev)
>  {
>  	struct xgbe_prv_data *pdata = dev_get_drvdata(dev);
>  	struct net_device *netdev = pdata->netdev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
>  	int ret = 0;
>  
> +	/* Restore PCI power state */
> +	pci_set_power_state(pdev, PCI_D0);
> +
> +	/* Restore PCI configuration state */
> +	pci_restore_state(pdev);
> +
> +	/* Enable PCI device */
> +	ret = pci_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	/* Re-enable bus mastering */
> +	pci_set_master(pdev);
> +
> +	/* Re-enable all device interrupts */
>  	XP_IOWRITE(pdata, XP_INT_EN, 0x1fffff);
>  
> +	/* Clear PHY low-power mode */
>  	pdata->lpm_ctrl &= ~MDIO_CTRL1_LPOWER;
>  	XMDIO_WRITE(pdata, MDIO_MMD_PCS, MDIO_CTRL1, pdata->lpm_ctrl);
>  
> +	if (!netdev)
> +		return 0;
> +
>  	if (netif_running(netdev)) {
>  		ret = xgbe_powerup(netdev);
>  
> -- 
> 2.34.1
> 
> 

