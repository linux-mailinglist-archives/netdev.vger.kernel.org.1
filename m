Return-Path: <netdev+bounces-299291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Up7nC1FgL2pm/QQAu9opvQ
	(envelope-from <netdev+bounces-299291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 04:15:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6609F682D3F
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 04:15:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299291-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299291-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6468330068F4
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 02:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C2C21A447;
	Mon, 15 Jun 2026 02:15:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA2DDCD
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 02:15:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781489725; cv=none; b=GrM0jCIr7leWh5nAp4ciYNRugFD13k8TabAgP64Laon0j/ow/+9CzFQjwDwsbBFefv1orNXijSvbA0njD3BMXDtAM3KVBRsZr2FLXKKE4UL/MR1FxfJbR47qBO9QcGivYiuDCen94ZieISnPGh0Xpn6xIUITadp99ly1CNR23aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781489725; c=relaxed/simple;
	bh=NvL+i5g+zVsvLYVycDEmE95MROyO7PdhUZNBHmGps3I=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=s1FWhdRK2khEAsyPxGc+cGhKsQuV5+QY3nBQ0x3fTvCwsDzBJxAR8kS77BF/pTLtp3OHK6NQFPP+UeNHbXwk/1oYG8NyzNPvMcP71yTBia/G9qJlDv0Exex4gjgAJGYQS1OY/jBwsKiVwH0ISF4L1X5OwCZX16QDy/2izD0r28I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
X-QQ-mid:Yeas4t1781489623t034t60564
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.157.22.210])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 17249502123495819819
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Michal Swiatkowski'" <michal.swiatkowski@linux.intel.com>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Larysa Zaremba'" <larysa.zaremba@intel.com>,
	"'Joe Damato'" <joe@dama.to>,
	"'Breno Leitao'" <leitao@debian.org>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>,
	"'Thomas Gleixner'" <tglx@kernel.org>,
	"'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
	<netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Michal Swiatkowski'" <michal.swiatkowski@linux.intel.com>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Larysa Zaremba'" <larysa.zaremba@intel.com>,
	"'Joe Damato'" <joe@dama.to>,
	"'Breno Leitao'" <leitao@debian.org>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>,
	"'Thomas Gleixner'" <tglx@kernel.org>,
	"'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
References: <20260610060917.23980-1-jiawenwu@trustnetic.com> <20260610060917.23980-6-jiawenwu@trustnetic.com> <20260612154117.GC671640@horms.kernel.org>
In-Reply-To: <20260612154117.GC671640@horms.kernel.org>
Subject: RE: [PATCH net-next v6 5/5] net: wangxun: add pcie error handler
Date: Mon, 15 Jun 2026 10:13:42 +0800
Message-ID: <018201dcfc6c$96419460$c2c4bd20$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQH9NqXiSq8t3g99zFNQdAvFN/QoIQJ20AayAkkGzz+12GL9QA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OceqJ+fpM4/sv7GBIWzlDWCN0iXD+zR/48oXju9HvHqw0ibF7x84y2Wc
	qT4SSE/GlgMnOJWY6VXKkJXE+r+R9lrnXphPU9iWNXu9b2JkxNEH8zF/7/ieWpu6909qupy
	NGSd+7ZZ2NiXuU8H1bvrS4/FNAQBkb6KSsX9mH+x7GOA5SOuUKkHSVFtzvRDfi1/Cx0telB
	+igG4/bLmuI/PpytAG/GxYv+orG4iGQ+1gPSqMc76iFQRFCL4AuIqKFO5R37/Wqf3uTOYbl
	NJa3iuMiSmF8oEPuj4W7o7zOshW2/owR75cY8fHluhSnJ01O0bQ01VKb0x0ycnkBWGi8j+3
	R33c/uobGipiLnGdqWG0fIBnyhkOaP1P40AYDxuS/wF5aYcpKUUT1oOi7gpZuCZHh/nMvdj
	12OYM22C3pJ0k9hbsIf9ky5/yrFLbFA3UUatOp63kBHOtJrNCs3LNDcCER0YQAGz1ZQ+fMw
	KcotWaHlDpQBWl1BzLqhZd1TGUuO1sS6s6cm1084yUC+EJtUJN9UKZ+w7/wobmsqzKOrB4U
	PTN5/qhd/eJcuwdcxmXH5ihwQdGxtTxkUbrkgD8H0cGhZ8McNWYs2th2lXlHdHupd8/sX26
	0a5dZ4x7NLdoYKfeNmM+rKhtTgL+UTrG/4ef1NEVa1mpFna+zzncsExJv8H+x7G7ACwh4LQ
	HM5E7sAJl91eOBQHXiDlg1tJERbdeExaHifzMBjBsCPdu8gJxrSdFwCS1ACfBJE7dMFBCql
	UVdH2I6bgby0NMGZgR+2XIn/1MuBVbkdkwvp8f4WmBJDoexh1tCtD85M2Xyl2MDnk/i5Z/c
	IIrZT60fgDB9qNOv0HCN3QvPOKV9mpvtoEHum1HaUYdAJKjPm9mM8HH0jZkOTW65E3ArKIo
	xr41YYndLdkUFvjjfTc/3Pltoii7v3zCQVssBepY9JzMGSeo3qrcOn/bVzsMQnxbqXadvAr
	ZiE41erdP0/MuAtnW7tmoAXITM0/DDXQsRHcHDVg2NbqMhYIXxaAhtZjrHeFlquQgedyoQK
	u7aYi2V91ouft0xgFwTDc5Rz8yfQh6XzHm/B1vqOhtbbGajHXlGCwFYlLlnI1txK1EdTJ01
	VJCcQE8Q9Ol0NzpAwKgMGE=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:kees@kernel.org,m:larysa.zaremba@intel.com,m:joe@dama.to,m:leitao@debian.org,m:aleksandr.loktionov@intel.com,m:u.kleine-koenig@baylibre.com,m:fabio.baltieri@gmail.com,m:tglx@kernel.org,m:gregkh@linuxfoundation.org,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	TAGGED_FROM(0.00)[bounces-299291-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,linuxfoundation.org];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6609F682D3F

On Fri, Jun 12, 2026 11:41 PM, Simon Horman wrote:
> On Wed, Jun 10, 2026 at 02:09:17PM +0800, Jiawen Wu wrote:
> > Support AER driver to handle the PCIe errors. Sometimes netdev watchdog
> > Tx timeout happens before the AER error report when a PCIe error occurs,
> > CPU blocking would be caused by MMIO during the reset process. To
> > prevent it, check PCIe error status in .ndo_tx_timeout. The current
> > function of ngbe is not yet fully developed, it will be completed in the
> > future.
> >
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> Hi Jiawen,
> 
> There is AI-generated review of this patch-set available on both
> https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
> 
> I've tried to filter out only those that seem strictly relevant
> to the progress of this patch and have included them inline.
> 
> I'd appreciate it if you could take a look over this.
> 
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> 
> ...
> 
> > +/**
> > + * wx_io_slot_reset - called after the pci bus has been reset.
> > + * @pdev: Pointer to PCI device
> > + *
> > + * Return: pci_ers_result_t.
> > + *
> > + * Restart the card from scratch, as if from a cold-boot.
> > + */
> > +static pci_ers_result_t wx_io_slot_reset(struct pci_dev *pdev)
> > +{
> > +	struct wx *wx = pci_get_drvdata(pdev);
> > +	pci_ers_result_t result;
> > +
> > +	if (pci_enable_device_mem(pdev)) {
> > +		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
> > +		result = PCI_ERS_RESULT_DISCONNECT;
> > +	} else {
> > +		/* make all memory operations done before clearing the flag */
> > +		smp_mb__before_atomic();
> > +		clear_bit(WX_STATE_DISABLED, wx->state);
> > +		clear_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
> > +		pci_set_master(pdev);
> > +		pci_restore_state(pdev);
> > +		pci_wake_from_d3(pdev, false);
> > +
> > +		rtnl_lock();
> > +		if (netif_running(wx->netdev) && wx->down_suspend)
> > +			wx->down_suspend(wx);
> > +		if (wx->do_reset)
> > +			wx->do_reset(wx->netdev, false);
> 
> The AI-generated review on sashiko.dev flags the following.
> 
> 	"Does this properly initialize the hardware MAC during PCIe AER
> 	 slot reset recovery for the ngbe driver?
> 
> 	"For txgbe, this correctly maps to txgbe_reset(), which calls
> 	 txgbe_reset_hw().  However, for ngbe, wx->do_reset maps to
> 	 ngbe_do_reset() which calls ngbe_reset().
> 
> 	"Looking at ngbe_reset():
> 
> 	"drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:ngbe_reset() {
> 	    if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
> 	        return;
> 	    wx_flush_sw_mac_table(wx);
> 	    wx_mac_set_default_filter(wx, wx->mac.addr);
> 	    if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
> 	        wx_ptp_reset(wx);
> 
> 	"This skips ngbe_reset_hw() and fails to fully reset the hardware.
> 	 Since a PCIe slot reset clears the device's internal state, when
> 	 wx_io_resume() subsequently calls ndo_open(), could the device fail
> 	 to function because its hardware registers and PHY state were never
> 	 reset?

As stated in the commit message, ngbe is not yet fully implemented due to some
existing issues with its reset mechanism. These will be refined in a future patch.

> > +		rtnl_unlock();
> > +		result = PCI_ERS_RESULT_RECOVERED;
> > +	}
> > +
> > +	pci_aer_clear_nonfatal_status(pdev);
> > +
> > +	return result;
> > +}
> 
> ...
> 
> > +static void wx_tx_timeout_recovery(struct wx *wx)
> > +{
> > +	/*
> > +	 * When a PCIe hardware error occurs, the driver should initiate a PCIe
> > +	 * recovery mechanism. However, this recovery flow relies on the AER
> > +	 * driver for current kernel policy. Therefore, a self-contained
> > +	 * recovery mechanism is not implemented yet.
> > +	 */
> > +	set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
> > +	wx_err(wx, "PCIe error detected during tx timeout\n");
> > +	queue_work(wx->reset_wq, &wx->reset_task);
> > +}
> 
> The AI-generated review on https://netdev-ai.bots.linux.dev/sashiko/ flags:
> 
> 	"What clears WX_FLAG_NEED_PCIE_RECOVERY if AER never follows up?
> 	 wx_tx_timeout_recovery() sets the flag and queues reset_task.
> 	 reset_task only calls wx_soft_quiesce() and does not clear the
> 	 flag:
> 
> 	    if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
> 	        wx_soft_quiesce(wx);
> 
> 	"The flag is cleared only on the success branch of
> 	 wx_io_slot_reset(). If the PCIe error never escalates to AER (AER
> 	 disabled in firmware or kernel, error not reportable, slot_reset
> 	 returns PCI_ERS_RESULT_DISCONNECT), the flag remains set
> 	 indefinitely.
> 
> 	"Both ngbe_reset() and txgbe_reset() now early-return on this flag:
> 
> 	    static void ngbe_reset(struct wx *wx)
> 	    {
> 	        if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
> 	            return;
> 	        ...
> 	    }
> 
> 	"so any subsequent reset path (ethtool reset, ndo_set_features
> 	 triggered reset, watchdog timeout reset, FDIR reinit,
> 	 ngbe_reinit_locked / txgbe_reinit_locked) is silently a no-op. The
> 	 hardware reset capability is effectively disabled until the module
> 	 is reloaded.
> 
> 	"Should wx_tx_timeout_recovery() (or reset_task after the quiesce)
> 	 clear the flag once the soft-quiesce completes, so the driver's
> 	 reset machinery remains functional when AER does not follow up?

If a PCIe error happens and AER is unresponsive, the driver currently lacks
alternative recovery mechanisms. This renders the hardware unusable, making
any further reset operations disallowed.



