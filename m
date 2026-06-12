Return-Path: <netdev+bounces-298708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1+N8KrUoLGrnMQQAu9opvQ
	(envelope-from <netdev+bounces-298708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 17:41:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E24B867A943
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 17:41:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eGRhrNOF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298708-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298708-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4ECAD314F725
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A10384CC2;
	Fri, 12 Jun 2026 15:41:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59159384CC1
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 15:41:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278890; cv=none; b=luaa6Abt3AVTikuEbtWHx3t8PeLnO6Dau17TS5Fam0cG1xumo7rbOLsFk+UElkCdCHH/IHjoTsl8w0AO4zeW4Ao8MQDVJE+HUKX4FlzdgJFicV+/lloy6n8eEZttKXbw/ygGQB4uUWLZQPaeidHf5X5tKwXO46QpkFG58voIP9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278890; c=relaxed/simple;
	bh=Axdt+aSjVUqsgwFdjoJHWua5+tA3tRTy0McnpHROGwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNO7OWujXxmTOqqtyYwOm7zZcKtmwMFiDD/6xOFI6CdWXhRu+Uzs73YByZ3jFCkUX3l2gaV3WTzzQ2xClh0kMZswzQWkANtdSr4FjT6KKGE03R8TTy856AHCMPQBEPcNrSuZQyVIglI7nIoGlqrl21lP5bVOF4MwyoBf6BO7Kfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGRhrNOF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3101F000E9;
	Fri, 12 Jun 2026 15:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781278889;
	bh=hr7nVV/JFuVzvP9XUE05eaKzOVShmXlpSVLVxYOV5hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eGRhrNOFhmQVfx1+hSWhWorSS4jcn0qF3HjdAWCxX2IrQ+n3bVpq4vIXde1odVGKl
	 cnub2j21zoCshZKF6vBQLuEbMyETDYZZxpcHV8qGaPfgN6W1kwuqZNakoUemYvER3e
	 9x6p0VyG1E/iz8LoBuWe8/3hiyHZDqQPfQhHCOhe1V24HIPtK0U89oRI2VIQ7S/6Ts
	 FFfZgrDaTr2ZMoKGRhCtRnYJtt9zxmX6VHPPEovO7eE88zd3ldyVQrPn5HDHnKr45m
	 EX933iQRC+gKf5shdA8XECUau6oMG5l5wenMENn+ifwwGVPsdHu5HyaYbOHeLhpzcx
	 P7/9hajU6TixA==
Date: Fri, 12 Jun 2026 16:41:17 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>, Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 5/5] net: wangxun: add pcie error handler
Message-ID: <20260612154117.GC671640@horms.kernel.org>
References: <20260610060917.23980-1-jiawenwu@trustnetic.com>
 <20260610060917.23980-6-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610060917.23980-6-jiawenwu@trustnetic.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298708-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:kees@kernel.org,m:larysa.zaremba@intel.com,m:joe@dama.to,m:leitao@debian.org,m:aleksandr.loktionov@intel.com,m:u.kleine-koenig@baylibre.com,m:fabio.baltieri@gmail.com,m:tglx@kernel.org,m:gregkh@linuxfoundation.org,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,trustnetic.com:email,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E24B867A943

On Wed, Jun 10, 2026 at 02:09:17PM +0800, Jiawen Wu wrote:
> Support AER driver to handle the PCIe errors. Sometimes netdev watchdog
> Tx timeout happens before the AER error report when a PCIe error occurs,
> CPU blocking would be caused by MMIO during the reset process. To
> prevent it, check PCIe error status in .ndo_tx_timeout. The current
> function of ngbe is not yet fully developed, it will be completed in the
> future.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Hi Jiawen,

There is AI-generated review of this patch-set available on both
https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/

I've tried to filter out only those that seem strictly relevant
to the progress of this patch and have included them inline.

I'd appreciate it if you could take a look over this.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c

...

> +/**
> + * wx_io_slot_reset - called after the pci bus has been reset.
> + * @pdev: Pointer to PCI device
> + *
> + * Return: pci_ers_result_t.
> + *
> + * Restart the card from scratch, as if from a cold-boot.
> + */
> +static pci_ers_result_t wx_io_slot_reset(struct pci_dev *pdev)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	pci_ers_result_t result;
> +
> +	if (pci_enable_device_mem(pdev)) {
> +		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
> +		result = PCI_ERS_RESULT_DISCONNECT;
> +	} else {
> +		/* make all memory operations done before clearing the flag */
> +		smp_mb__before_atomic();
> +		clear_bit(WX_STATE_DISABLED, wx->state);
> +		clear_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
> +		pci_set_master(pdev);
> +		pci_restore_state(pdev);
> +		pci_wake_from_d3(pdev, false);
> +
> +		rtnl_lock();
> +		if (netif_running(wx->netdev) && wx->down_suspend)
> +			wx->down_suspend(wx);
> +		if (wx->do_reset)
> +			wx->do_reset(wx->netdev, false);

The AI-generated review on sashiko.dev flags the following.

	"Does this properly initialize the hardware MAC during PCIe AER
	 slot reset recovery for the ngbe driver?

	"For txgbe, this correctly maps to txgbe_reset(), which calls
	 txgbe_reset_hw().  However, for ngbe, wx->do_reset maps to
	 ngbe_do_reset() which calls ngbe_reset().

	"Looking at ngbe_reset():

	"drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:ngbe_reset() {
	    if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
	        return;
	    wx_flush_sw_mac_table(wx);
	    wx_mac_set_default_filter(wx, wx->mac.addr);
	    if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
	        wx_ptp_reset(wx);

	"This skips ngbe_reset_hw() and fails to fully reset the hardware.
	 Since a PCIe slot reset clears the device's internal state, when
	 wx_io_resume() subsequently calls ndo_open(), could the device fail
	 to function because its hardware registers and PHY state were never
	 reset?

> +		rtnl_unlock();
> +		result = PCI_ERS_RESULT_RECOVERED;
> +	}
> +
> +	pci_aer_clear_nonfatal_status(pdev);
> +
> +	return result;
> +}

...

> +static void wx_tx_timeout_recovery(struct wx *wx)
> +{
> +	/*
> +	 * When a PCIe hardware error occurs, the driver should initiate a PCIe
> +	 * recovery mechanism. However, this recovery flow relies on the AER
> +	 * driver for current kernel policy. Therefore, a self-contained
> +	 * recovery mechanism is not implemented yet.
> +	 */
> +	set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
> +	wx_err(wx, "PCIe error detected during tx timeout\n");
> +	queue_work(wx->reset_wq, &wx->reset_task);
> +}

The AI-generated review on https://netdev-ai.bots.linux.dev/sashiko/ flags:

	"What clears WX_FLAG_NEED_PCIE_RECOVERY if AER never follows up?
	 wx_tx_timeout_recovery() sets the flag and queues reset_task.
	 reset_task only calls wx_soft_quiesce() and does not clear the
	 flag:

	    if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
	        wx_soft_quiesce(wx);

	"The flag is cleared only on the success branch of
	 wx_io_slot_reset(). If the PCIe error never escalates to AER (AER
	 disabled in firmware or kernel, error not reportable, slot_reset
	 returns PCI_ERS_RESULT_DISCONNECT), the flag remains set
	 indefinitely.

	"Both ngbe_reset() and txgbe_reset() now early-return on this flag:

	    static void ngbe_reset(struct wx *wx)
	    {
	        if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
	            return;
	        ...
	    }

	"so any subsequent reset path (ethtool reset, ndo_set_features
	 triggered reset, watchdog timeout reset, FDIR reinit,
	 ngbe_reinit_locked / txgbe_reinit_locked) is silently a no-op. The
	 hardware reset capability is effectively disabled until the module
	 is reloaded.

	"Should wx_tx_timeout_recovery() (or reset_task after the quiesce)
	 clear the flag once the soft-quiesce completes, so the driver's
	 reset machinery remains functional when AER does not follow up?

...

