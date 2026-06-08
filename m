Return-Path: <netdev+bounces-296627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5i7dAw/jJmqvmQIAu9opvQ
	(envelope-from <netdev+bounces-296627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:43:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 720E76583DB
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:43:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SNRpde6k;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296627-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296627-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F23A8305CB80
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A07A327BFC;
	Mon,  8 Jun 2026 15:07:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1830675C
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:07:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931271; cv=none; b=TVv/LlNYxdCEfhBD7eimn1mfzrsmmm2tZz2w37X5I28bNpxFbAOzdZTNprAAQ33ey/GquJa6th5lu4JjGNE0grWvg3HGxdd3pk8rMYq9QXrbr5eoLp1ZtnokG58kECWN3upRx+hieaNLbWGPGg98swsyGO+c3a19zkS2Xzspby4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931271; c=relaxed/simple;
	bh=3ZAi6k7uot/P9VWf4aeXBkjh3qrMw04RVar/N/MtQ28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvDx4lK7wFcPuBY9JA4a1BdqA3FoT0DPc5yWflEzlweQpfcifIomMLmdRyvD2+9xTCP6yefovFrDoBJio/kHsjd3U7XMNPsaT42JapkPNHk22bLUJUd+HSUn8pu6LFVRiAK4yFT7Law6FbyviZEIByyi4i+7Oy6pViURsKD2sGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNRpde6k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C421F00893;
	Mon,  8 Jun 2026 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780931269;
	bh=4LLNpNp2396w2WmhF3i7U1VNXInpT/sRq/l2UGIIvV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SNRpde6krlDWnxsgZ3jauKZP99qdShWOV1LWKqMYoXGC5wrmTkgymuPwjmEHv5PI0
	 z285kLrrIyoctoIIkiEvN3n8gNhBepqgQSBZaxI5rT9ZrdwXAt8G8wcBzEIQIvAemC
	 2JMju0QFD0/wKNHJNQ+2JfVgpIzWO+dHCPmdgb4DmRHQqbV29kjiv1QFNd50Euw8CA
	 GwdpgIgcAk9+1XRrW2tSvrwHcVwvnXmco7nHypkxe8bfp94p096IG3CvrCdGL6xUIr
	 uh6jNSRDFhlx8qf3D5CQ8gHGZZFNPXoX8VIUbWGLPI7fnM3WkZpUk9YfIthI1EfwuC
	 U2diiPT06INOw==
From: Simon Horman <horms@kernel.org>
To: jiawenwu@trustnetic.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	kees@kernel.org,
	larysa.zaremba@intel.com,
	joe@dama.to,
	leitao@debian.org,
	aleksandr.loktionov@intel.com,
	u.kleine-koenig@baylibre.com,
	fabio.baltieri@gmail.com,
	tglx@kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next v5 5/5] net: wangxun: add pcie error handler
Date: Mon,  8 Jun 2026 16:05:31 +0100
Message-ID: <20260608150529.149510-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604085631.12720-6-jiawenwu@trustnetic.com>
References: <20260604085631.12720-6-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296627-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:kees@kernel.org,m:larysa.zaremba@intel.com,m:joe@dama.to,m:leitao@debian.org,m:aleksandr.loktionov@intel.com,m:u.kleine-koenig@baylibre.com,m:fabio.baltieri@gmail.com,m:tglx@kernel.org,m:gregkh@linuxfoundation.org,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,linuxfoundation.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 720E76583DB

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says: there is also AI-generated review available of other patches of
	    this patch-set. But I believe those flagged below are the ones
	    that warrant investigation in the context of this patchset.

---
net: wangxun: add pcie error handler

Support AER driver to handle the PCIe errors. Sometimes netdev watchdog
Tx timeout happens before the AER error report when a PCIe error occurs,
CPU blocking would be caused by MMIO during the reset process. To
prevent it, error return is added in reset path. The current function of
ngbe is not yet fully developed, it will be completed in the future.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> index ee27f96735dc7..9a4dbb3427d93 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
[ ... ]
> @@ -4,11 +4,125 @@
>  static pci_ers_result_t wx_io_slot_reset(struct pci_dev *pdev)
>  {
>  	struct wx *wx = pci_get_drvdata(pdev);
>  	pci_ers_result_t result;
>  
>  	if (pci_enable_device_mem(pdev)) {
>  		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
>  		result = PCI_ERS_RESULT_DISCONNECT;
>  	} else {
>  		/* make all memory operations done before clearing the flag */
>  		smp_mb__before_atomic();
>  		clear_bit(WX_STATE_DISABLED, wx->state);
>  		pci_set_master(pdev);
>  		pci_restore_state(pdev);
>  		pci_wake_from_d3(pdev, false);
>  
> +		rtnl_lock();
> +		if (netif_running(wx->netdev) && wx->down_suspend)
> +			wx->down_suspend(wx);
> +		if (wx->do_reset)
> +			wx->do_reset(wx->netdev, false);
> +		rtnl_unlock();

[Severity: Critical]
Does this sequence leave the netdev state out of sync if wx_io_resume()
later fails?

If wx_io_resume() fails its ndo_open() call, it returns with netif_running()
still true. If an administrator later sets the interface down, the kernel
will call ndo_stop (txgbe_close).

txgbe_close() unconditionally calls wx_free_irq(), txgbe_free_misc_irq(), and
wx_free_resources(). Because txgbe_free_misc_irq() does not set
txgbe->misc.domain to NULL, calling it a second time causes a double free.

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> index 3e32aca728065..80811947d5acf 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
[ ... ]
> @@ -78,13 +78,17 @@ static int txgbe_set_ringparam(struct net_device *netdev,
>  		goto clear_reset;
>  	}
>  
> -	txgbe_down(wx);
> +	err = txgbe_down(wx);
> +	if (err)
> +		goto free_temp;
>  
>  	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
>  	kvfree(temp_ring);
>  
>  	txgbe_up(wx);
>  
> +free_temp:
> +	kvfree(temp_ring);
>  clear_reset:
>  	clear_bit(WX_STATE_RESETTING, wx->state);

[Severity: High]
If txgbe_down() returns an error here, the function jumps to free_temp and
skips calling txgbe_up().

Because txgbe_disable_device() has already called wx_soft_quiesce() to stop
TX queues and disable NAPI, does this leave the interface logically stuck
down while the OS still considers it up?

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index f6e596eb92178..98786efbe871d 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
[ ... ]
> @@ -212,15 +212,21 @@ static void txgbe_reset(struct wx *wx)
>  		wx_ptp_reset(wx);
>  }
>  
> -static void txgbe_disable_device(struct wx *wx)
> +static int txgbe_disable_device(struct wx *wx)
>  {
>  	struct net_device *netdev = wx->netdev;
> +	int ret = 0;
>  	u32 i;
>  
>  	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
> -		return;
> +		return 0;
> +
> +	ret = wx_disable_pcie_master(wx);
> +	if (ret) {
> +		wx_soft_quiesce(wx);
> +		return ret;
> +	}

[Severity: High]
If wx_disable_pcie_master() times out and returns an error, the function
exits without clearing the WX_STATE_DOWN bit. If a subsequent teardown
attempt occurs, will the WX_STATE_DOWN check falsely assume the device is
already disabled and return 0 (success)?

[Severity: Critical]
Returning early here skips critical hardware teardown like wx_disable_rx()
and the MAC shutdown.

Because callers like txgbe_close() do not check the return value of
txgbe_down(), they proceed to unconditionally free all DMA rings via
wx_free_resources(). Can this allow the hardware to DMA incoming packets into
freed memory pages?

[ ... ]
> @@ -606,13 +635,16 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
>  
>  static void txgbe_reinit_locked(struct wx *wx)
>  {
> +	int ret;
> +
>  	netif_trans_update(wx->netdev);
>  
>  	mutex_lock(&wx->reset_lock);
>  	set_bit(WX_STATE_RESETTING, wx->state);
>  
> -	txgbe_down(wx);
> -	txgbe_up(wx);
> +	ret = txgbe_down(wx);
> +	if (!ret)
> +		txgbe_up(wx);
>  
>  	clear_bit(WX_STATE_RESETTING, wx->state);

[Severity: High]
Similar to the ethtool path, if txgbe_down() fails here, txgbe_up() is
skipped. Does this leave the interface in a broken state until the next
administrative down/up cycle?

