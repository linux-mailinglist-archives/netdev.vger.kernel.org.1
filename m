Return-Path: <netdev+bounces-294517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BUsyLHmQH2rfnAAAu9opvQ
	(envelope-from <netdev+bounces-294517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:24:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B0D633A21
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:24:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294517-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294517-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4112C30238C1
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 02:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E913D810C;
	Wed,  3 Jun 2026 02:23:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8237B352C54
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 02:23:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453439; cv=none; b=c/avUJLfI2PTFGjGt5oIu0U0X1npcbbqHFvTE247AYXZQ8C1oRyVFBNfqWowLdIn+rHUOPCi7U0/Ug2nY6Yfo8yRUjDv5s8Y3oRSyFRGddt4qOCqpfgySMR2AO7kGeZAl8JNkYBAS152rOPcfO8VJx/8xMlnSYIoxybiJ7zgDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453439; c=relaxed/simple;
	bh=OSD1MxWLmpm44uwyEirSbR6oylZ9ebZKVjDvor31qmM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=J404D1X15ORyzVLqQJvTtwvz7dBL7iPKC+eMH11oJ6FEbsVrysyp+D62RH5/e24hroQfV+H6XsZ7qAq4ELTqWIfb5rihkrjt4Ej/urnSr87eactoQrWfNFcIXIsXsvhaB8tTNdufBMJfRFnCRrExMbwUjUsNzbIKJ+avRyAV5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
X-QQ-mid:Yeas4t1780453348t452t38243
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.207.111])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2004524863220335382
To: "'Larysa Zaremba'" <larysa.zaremba@intel.com>
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
	"'Simon Horman'" <horms@kernel.org>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Ingo Molnar'" <mingo@kernel.org>,
	"'Joe Damato'" <joe@dama.to>,
	"'Breno Leitao'" <leitao@debian.org>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Johannes Berg'" <johannes@sipsolutions.net>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>,
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
	"'Simon Horman'" <horms@kernel.org>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Ingo Molnar'" <mingo@kernel.org>,
	"'Joe Damato'" <joe@dama.to>,
	"'Breno Leitao'" <leitao@debian.org>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Johannes Berg'" <johannes@sipsolutions.net>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>
References: <20260601072221.2952-1-jiawenwu@trustnetic.com> <20260601072221.2952-3-jiawenwu@trustnetic.com> <ah6xJgZjplSbVKvl@soc-5CG4396X81.clients.intel.com>
In-Reply-To: <ah6xJgZjplSbVKvl@soc-5CG4396X81.clients.intel.com>
Subject: RE: [PATCH net-next v4 2/5] net: wangxun: add Tx timeout process
Date: Wed, 3 Jun 2026 10:22:27 +0800
Message-ID: <093d01dcf2ff$d2792810$776b7830$@trustnetic.com>
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
Thread-Index: AQEmZmPiFxLXVQw6wm5cjAUm9/PfJgFDayZNAffErqC3f1cwwA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Ndvb6QWuI/gYQ3toBxFaFbRplthyuekS4gLyCUXsoeIxNQ0dxxDOu6BW
	2sULOZ+S+ygX7zIf2/GWkMFIgPx3ypla0mv7AMgQFMoNv3Tb9pI5fr3G+wC/SNvG2NfWzKB
	UKbTQPduLrd6YUNXe8r7nPz9Rm29uzb063XQR2QAtRiW103yyQNvutNaFJiBzoz67M2DuoO
	O1Z4nUk769sB3Uy9kzmZwJCZlfH1P8r7IU4t6Ql5OWHjNotmm8ZkYEynh0T6q1hEaQvQ2oH
	8AdG8t4Zf9zo69+W8t3FHykwonN+oC/+TZMzu76g3vRTFjrVW20VLv9UMpZi6P4hXS5S7ut
	Yc43imt4Jya/5M2j9aJSsyP2o+VNTUcDuDd5jcTcJr5xvlAcyE7E7Oo7gYxGsndxUbNs8IF
	ywY8i4y6buAdHd9TpVkgs5CxZH1U+UtM03mS5a8OYikJgVnzZUYOndDyHLCh+CzQpy2hDG/
	c+aI0g8pN6qIACM+OWMiNLyhefeT2JVsEa/Y2e8Mr2oXjgM26bZa5zeZgfc3jopht6D3ZP/
	LrKJZoi73f8w4P4d4FYpCwlZyV96RZ23zeCm3hedmFPGsOuiEmoqGnKP3aRJ10sh2sI/Y1i
	ZQ7cSr1zUmwO6WVxaUP8Pg8F9Y0wnG4IGCBGCtc4wCLuGoRUpVcJhcjdMAa4zRj60p7G/1A
	bvwhoaZdykvj30kQ56z5GpwoJ7Ja41eG0PJ8kVW2XGHH8LDMBB4j+He+eEGo1Zg7HBlSN5O
	xzwPIRcwfy+3aOkqcgGqiZYNYjD0omD/NKXRjTiB9a0XnhXXtW4aYLZmtiJm69SguqNQ97+
	mPwgsZANdUUCKr+Gaw/FzyJczfUYqGkGvMJBAnAsk4Ep+lxZFWw6D+/+Nqkm3exufL6sKzx
	dPT0uUw5d826qKwh8oA41rS4tW61Cj/wg2eivVRLtEXk4B6fWEH+QDMygyNKxHaRVRTLGU0
	AuWWtmgq3BLGbsRUIIDIpBbcW2qumqQurp0gV0HX6IK8TAnHDNphfa8NBFzju/2HUXl1WqZ
	N7hRzrLwOPOw+Qk6d8JMXtqfeG/r6PyRNQ7s57ttbFpUJqw/Mulc0+yuAUpd9HqDwrNDTM+
	pUHyPkDmMM0iiGpf0+2pGE3n+1kdZLmk17AtkUitgz4
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	FROM_EXCESS_BASE64(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-294517-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_RECIPIENTS(0.00)[m:larysa.zaremba@intel.com,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:mingo@kernel.org,m:joe@dama.to,m:leitao@debian.org,m:aleksandr.loktionov@intel.com,m:u.kleine-koenig@baylibre.com,m:johannes@sipsolutions.net,m:fabio.baltieri@gmail.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,sipsolutions.net];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[41];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0B0D633A21

On Tue, Jun 2, 2026 6:32 PM, Larysa Zaremba wrote:
> On Mon, Jun 01, 2026 at 03:22:18PM +0800, Jiawen Wu wrote:
> > Implement .ndo_tx_timeout to handle Tx side timeout event. When a Tx
> > timeout event occur, it will trigger driver into reset process.
> >
> > The WX_HANG_CHECK_ARMED bit is set to indicate a potential hang. It will
> > be cleared if a pause frame is received to avoid false hang detection
> > caused by pause frames.
> 
> In general, logic seems sound, below 1 small nit.
> There is also a seemingly sensible comment from Sashiko (pasted below), which I
> agree with. If you not schedule NAPI every time to check for hang, then without
> Rx you are relying on dev_watchdog anyway, so maybe internal hang detection is
> not that necessary?

The purpose of WX_TX_DETECT_HANG is to reuse the existing Tx cleanup path and
detect hangs opportunistically when NAPI is already running due to normal Tx/Rx
interrupt activity.

For workloads with active traffic, this allows earlier detection than the
generic dev_watchdog() timeout and provides driver-specific diagnostics before
a full reset is triggered.

> 
> >
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
> >  drivers/net/ethernet/wangxun/libwx/wx_err.c   | 170 ++++++++++++++++++
> >  drivers/net/ethernet/wangxun/libwx/wx_err.h   |  16 ++
> >  drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
> >  drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  37 ++++
> >  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  19 +-
> >  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  14 ++
> >  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  14 ++
> >  8 files changed, 284 insertions(+), 5 deletions(-)
> >  create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
> >  create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
> > index a71b0ad77de3..c8724bb129aa 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/Makefile
> > +++ b/drivers/net/ethernet/wangxun/libwx/Makefile
> > @@ -4,5 +4,5 @@
> >
> >  obj-$(CONFIG_LIBWX) += libwx.o
> >
> > -libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o
> > +libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o wx_err.o
> >  libwx-objs += wx_vf.o wx_vf_lib.o wx_vf_common.o
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > new file mode 100644
> > index 000000000000..982a438d009e
> > --- /dev/null
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > @@ -0,0 +1,170 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2015 - 2026 Beijing WangXun Technology Co., Ltd. */
> > +/* Copyright (c) 1999 - 2026 Intel Corporation. */
> > +
> > +#include <linux/netdevice.h>
> > +#include <linux/pci.h>
> > +
> > +#include "wx_type.h"
> > +#include "wx_lib.h"
> > +#include "wx_err.h"
> > +
> > +static void wx_pf_reset_subtask(struct wx *wx)
> > +{
> > +	if (!test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
> > +		return;
> > +
> > +	wx_warn(wx, "Reset adapter.\n");
> > +	if (wx->do_reset)
> > +		wx->do_reset(wx->netdev);
> > +}
> > +
> > +static void wx_reset_task(struct work_struct *work)
> > +{
> > +	struct wx *wx = container_of(work, struct wx, reset_task);
> > +
> > +	rtnl_lock();
> > +
> > +	if (test_bit(WX_STATE_DOWN, wx->state) ||
> > +	    test_bit(WX_STATE_RESETTING, wx->state))
> > +		goto out;
> > +
> > +	wx_pf_reset_subtask(wx);
> > +
> > +out:
> > +	rtnl_unlock();
> > +}
> > +
> > +void wx_check_err_subtask(struct wx *wx)
> > +{
> > +	if (test_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
> > +		queue_work(wx->reset_wq, &wx->reset_task);
> > +}
> > +EXPORT_SYMBOL(wx_check_err_subtask);
> > +
> > +int wx_init_err_task(struct wx *wx)
> > +{
> > +	wx->reset_wq = alloc_workqueue("wx_reset_wq", WQ_UNBOUND | WQ_HIGHPRI, 1);
> > +	if (!wx->reset_wq) {
> > +		pr_err("Failed to create wx_reset_wq workqueue\n");
> 
> This driver does not generally use pr_err().

I'll change it to wx_err().

> 
> > +		return -ENOMEM;
> > +	}
> > +
> > +	INIT_WORK(&wx->reset_task, wx_reset_task);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(wx_init_err_task);
> > +
> > +static bool wx_ring_tx_pending(struct wx *wx)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < wx->num_tx_queues; i++) {
> > +		struct wx_ring *tx_ring = wx->tx_ring[i];
> > +
> > +		if (tx_ring->next_to_use != tx_ring->next_to_clean)
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +static bool wx_vf_tx_pending(struct wx *wx)
> > +{
> > +	struct wx_ring_feature *vmdq = &wx->ring_feature[RING_F_VMDQ];
> > +	u32 q_per_pool = __ALIGN_MASK(1, ~vmdq->mask);
> > +	u32 i, j;
> > +
> > +	if (!wx->num_vfs)
> > +		return false;
> > +
> > +	for (i = 0; i < wx->num_vfs; i++) {
> > +		for (j = 0; j < q_per_pool; j++) {
> > +			u32 h, t;
> > +
> > +			h = rd32(wx, WX_PX_TR_RP_PV(q_per_pool, i, j));
> > +			t = rd32(wx, WX_PX_TR_WP_PV(q_per_pool, i, j));
> > +
> > +			if (h != t)
> > +				return true;
> > +		}
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +static void wx_watchdog_flush_tx(struct wx *wx)
> > +{
> > +	if (!netif_running(wx->netdev))
> > +		return;
> > +	if (netif_carrier_ok(wx->netdev))
> > +		return;
> > +
> > +	if (wx_ring_tx_pending(wx) || wx_vf_tx_pending(wx)) {
> > +		/* We've lost link, so the controller stops DMA,
> > +		 * but we've got queued Tx work that's never going
> > +		 * to get done, so reset controller to flush Tx.
> > +		 * (Do the reset outside of interrupt context).
> > +		 */
> > +		wx_warn(wx, "initiating reset due to lost link with pending Tx work\n");
> > +		set_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> > +	}
> > +}
> > +
> > +static void wx_check_tx_hang(struct wx *wx)
> > +{
> > +	int i;
> > +
> > +	/* If we're down or resetting, just bail */
> > +	if (!netif_running(wx->netdev) ||
> > +	    test_bit(WX_STATE_RESETTING, wx->state))
> > +		return;
> > +
> > +	/* Force detection of hung controller */
> > +	if (netif_carrier_ok(wx->netdev)) {
> > +		for (i = 0; i < wx->num_tx_queues; i++)
> > +			set_bit(WX_TX_DETECT_HANG, wx->tx_ring[i]->state);
> 
> Sashiko says:
> 
> If a software interrupt is not triggered, wouldn't the evaluation of this
> flag in wx_clean_tx_irq() fail to run unless incoming Rx traffic happens
> to arrive on the same interrupt vector?
> 
> > +	}
> > +}
> > +
> > +void wx_check_tx_hang_subtask(struct wx *wx)
> > +{
> > +	wx_watchdog_flush_tx(wx);
> > +	wx_check_tx_hang(wx);
> > +}
> > +EXPORT_SYMBOL(wx_check_tx_hang_subtask);
> > +
> > +static void wx_tx_timeout_reset(struct wx *wx)
> > +{
> > +	if (test_bit(WX_STATE_DOWN, wx->state))
> > +		return;
> > +
> > +	set_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> > +	wx_warn(wx, "initiating reset due to tx timeout\n");
> > +	wx_service_event_schedule(wx);
> > +}
> > +
> > +void wx_tx_timeout(struct net_device *netdev, unsigned int __always_unused txqueue)
> > +{
> > +	struct wx *wx = netdev_priv(netdev);
> > +
> > +	wx_tx_timeout_reset(wx);
> > +}
> > +EXPORT_SYMBOL(wx_tx_timeout);
> > +
> > +void wx_handle_tx_hang(struct wx_ring *tx_ring, unsigned int next)
> > +{
> > +	struct wx *wx = netdev_priv(tx_ring->netdev);
> > +
> > +	wx_warn(wx,
> > +		"Detected Tx Unit Hang: Queue %d, TDH %x, TDT %x, ntu %x, ntc %x, ntc.time_stamp %lx, jiffies %lx\n",
> > +		tx_ring->queue_index,
> > +		rd32(wx, WX_PX_TR_RP(tx_ring->reg_idx)),
> > +		rd32(wx, WX_PX_TR_WP(tx_ring->reg_idx)),
> > +		tx_ring->next_to_use, next,
> > +		tx_ring->tx_buffer_info[next].time_stamp, jiffies);
> > +
> > +	netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
> > +
> > +	wx_tx_timeout_reset(wx);
> > +}
> 
> [...]
> 


