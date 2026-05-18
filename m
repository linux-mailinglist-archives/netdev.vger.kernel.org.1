Return-Path: <netdev+bounces-288840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIZpMBWFCmqv2AQAu9opvQ
	(envelope-from <netdev+bounces-288840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:18:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AAF565602
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B526F300D32A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B5137FF63;
	Mon, 18 May 2026 03:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cSZ0Qft9"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAAC37FF5A
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 03:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779074310; cv=none; b=bLJyhVO/znoOQddrfzbwvcHSzuo4bG1N/9ZKsDKkcQtFWfcDKZ8LPDzZrxbff8EUsongo1haiSBZ6/LHFev+XHee6+fSqyGZIHUODc3HSo8Jsw+XV19s1HrsWiSQwH2mGUU1eGAdV85wlKyh+zFoh2oshF/8w/Le5vCL/vi6eWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779074310; c=relaxed/simple;
	bh=7gYcZGNHz2rYrGabiae/qmvPW+mBCzEyVwjExD0oKZ4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=aA++NjWqkTsPf6Qv+kuqPNCZh5WW+LQs+sorSoNqY3U0CXSlC/3iKVWMrzGSQyz2pP79V+ofXwf2rMbMd0Q4CR3U4OAxd54AD/4p4IVaKEV8MiQKLnC7xpvSUursu+DAASChlV7U30UrrVhkXWrOp4cqkFp5fWI5kpcqxuJUVGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cSZ0Qft9; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779074305; h=Message-ID:Subject:Date:From:To;
	bh=mYTiPrz/pBrZk+NPI4Z30QOETd2d+NKndNUdmk1DReU=;
	b=cSZ0Qft9upQTjBZZfGyyl2dj20YHMKVK+QMBrosLHxVwTkg6pHhgvyWKZSye4+EUg/kIYria/pjCCd9BzT0qh1k6T+lxtDUblBvW4uPJT1l0h4zA0EYF1B0YCJB6UI4F3ON5YYXeBn4BP3rYQ7odaCsU0KCoINFmcRrMKXfBcBU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X335DGQ_1779074303;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X335DGQ_1779074303 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 11:18:24 +0800
Message-ID: <1779073665.4889376-13-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v43 1/8] eea: introduce PCI framework
Date: Mon, 18 May 2026 11:07:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
 <20260514095138.80680-2-xuanzhuo@linux.alibaba.com>
 <1779073615.1247635-12-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1779073615.1247635-12-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 21AAF565602
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,stu.xidian.edu.cn,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288840-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,linux.dev:url,alibaba.com:email]
X-Rspamd-Action: no action

On Mon, 18 May 2026 11:06:55 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> From https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260514095138.80680-1-xuanzhuo%40linux.alibaba.com
>
> commit 46941a5c3a95ebc5ea79193eb1c2ceab7183da1d
> Author: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> eea: introduce PCI framework
> This patch adds a basic PCI driver framework for the Alibaba Elastic
> Ethernet Adapter (EEA), implementing PCI probe, remove, shutdown, the
> device-status handshake helpers, and an MMIO config layout.
> A few questions inline below.
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c
> > new file mode 100644
> > index 000000000000..65a0ceb73b35
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c
> > @@ -0,0 +1,487 @@
> [ ... ]
> > +int eea_device_reset(struct eea_device *edev)
> > +{
> > +	struct eea_pci_device *ep_dev = edev->ep_dev;
> > +	int err;
> > +	u8 val;
> > +
> > +	eea_pci_io_set_status(edev, 0);
> > +
> > +	/* We are no longer waiting for device ack during the shutdown flow. */
> > +	if (ep_dev->shutdown)
> > +		return 0;
> > +
> > +	/* A longer timeout is set here to handle edge cases, though it should
> > +	 * return promptly in most scenarios.
> > +	 *
> > +	 * In our case, all replies are handled by the DPU software, so there is
> > +	 * no race condition between the hardware processes and the register.
> > +	 */
> > +	err = read_poll_timeout(cfg_read8, val, (!val || val == 0xFF), 20,
> > +				EEA_RESET_TIMEOUT_US,
> > +				false, ep_dev->reg, device_status);
> On the shutdown path, ep_dev->shutdown is set to true and eea_device_reset()
> then returns immediately after writing device_status = 0, skipping the
> read_poll_timeout() that would otherwise wait for the device to acknowledge
> the reset:
> eea_pci_shutdown():
>     ep_dev->shutdown = true;
>     /* do net device stop and clear. */
>     eea_device_reset(edev);
>     pci_clear_master(pci_dev);
> After that, eea_pci_shutdown() calls pci_clear_master(), which only clears
> the bus-master enable bit and does not drain in-flight or posted DMA writes.
> Without a flush read of an MMIO register from this function or a synchronous
> device-side ack, is there a guarantee that the device has stopped issuing
> DMA before pci_clear_master() runs?
> On kexec or warm-reboot, can in-flight DMA after eea_pci_shutdown() returns
> land in pages that the next kernel has reused?

We prefer to avoid blocking for too long during the shutdown process, which is
why read_poll_timeout is skipped here. As for the probe phase, I ensure DMA
safety by triggering a reset before setting the master.

> > +
> > +	/* Surprise PCIe Removal */
> > +	if (val == 0xFF)
> > +		return -EINVAL;
> > +
> > +	return err;
> > +}
> > +
> > +int eea_pci_set_aq_up(struct eea_device *edev)
> > +{
> > +	struct eea_pci_device *ep_dev = edev->ep_dev;
> > +	u8 status = eea_pci_io_get_status(edev);
> > +	int err;
> > +	u8 val;
> > +
> > +	eea_pci_io_set_status(edev, status | EEA_S_OK);
> > +
> > +	/* A longer timeout is set here to handle edge cases, though it should
> > +	 * return promptly in most scenarios.
> > +	 *
> > +	 * In our case, all replies are handled by the DPU software, so there is
> > +	 * no race condition between the hardware processes and the register.
> > +	 */
> > +	err = read_poll_timeout(cfg_read8, val,
> > +				val & (EEA_S_OK | EEA_S_FAILED),
> > +				20, EEA_RESET_TIMEOUT_US,
> > +				false, ep_dev->reg, device_status);
> > +
> > +	/* Surprise PCIe Removal */
> > +	if (val == 0xFF)
> > +		return -EINVAL;
> > +
> > +	/* device fail */
> > +	if (val & EEA_S_FAILED)
> > +		return -EINVAL;
> > +
> > +	return err;
> > +}
> Can this handshake actually observe device acknowledgment?
> The driver writes status | EEA_S_OK to device_status, then read_poll_timeout()
> waits for the readback to satisfy (val & (EEA_S_OK | EEA_S_FAILED)).
> read_poll_timeout() with sleep_before_read = false performs the op() once
> before sleeping, so the very first cfg_read8() of device_status will return
> the value that was just written, which already has EEA_S_OK set. The
> condition is met on iteration zero, the 60-second EEA_RESET_TIMEOUT_US never
> elapses, and EEA_S_FAILED never gets a chance to be observed.
> For the device to ever indicate failure, would it need to first clear
> EEA_S_OK and then either re-assert EEA_S_OK on success or set EEA_S_FAILED
> on failure? Or use a separate ack/done bit that is distinct from the
> driver-written request bit? As written, the EEA_S_FAILED check below the
> poll appears unreachable on a healthy bus.

This is a DPU implementation, so all PCI TLP messages are handled and
acknowledged by software. Even for PCI registers, the read operation does not
simply return the last written value.


> > +
> > +static int eea_negotiate(struct eea_device *edev)
> > +{
> > +	struct eea_pci_device *ep_dev;
> > +	u32 status;
> > +
> > +	ep_dev = edev->ep_dev;
> > +
> > +	edev->features = 0;
> > +
> > +	cfg_write32(ep_dev->reg, drv_f_idx, 0);
> > +	cfg_write32(ep_dev->reg, drv_f, lower_32_bits(edev->features));
> > +	cfg_write32(ep_dev->reg, drv_f_idx, 1);
> > +	cfg_write32(ep_dev->reg, drv_f, upper_32_bits(edev->features));
> > +
> > +	eea_add_status(edev, EEA_S_FEATURE_DONE);
> > +	status = eea_pci_io_get_status(edev);
> > +
> > +	/* Surprise PCIe Removal */
> > +	if (status == 0xFF)
> > +		return -EINVAL;
> > +
> > +	if (!(status & EEA_S_FEATURE_DONE))
> > +		return -ENODEV;
> > +
> > +	return 0;
> > +}
> Is this status check tautological?
> eea_add_status() reads device_status, ORs in EEA_S_FEATURE_DONE, and writes
> it back. The very next line reads device_status again, so unless the device
> clears the bit before the readback (which there is no synchronisation for),
> the readback will always have EEA_S_FEATURE_DONE set, except in the surprise
> removal case where the value is 0xFF.
> Can this code detect a device that legitimately rejects the offered
> features, given there is no poll, delay, or wait for the device to react?
> The asymmetry with eea_pci_set_aq_up(), which does call read_poll_timeout()
> albeit with the issue noted above, suggests the protocol contract for these
> two transitions is different. Could the expected device-side behaviour for
> EEA_S_FEATURE_DONE be spelled out so reviewers can check the handshake?


This is just a framework, for this version no feature is needed to negotiabled.


> > +
> [ ... ]
> > +static int eea_pci_setup(struct pci_dev *pci_dev, struct eea_pci_device *ep_dev)
> > +{
> > +	int err, n, ret, len;
> > +
> > +	ep_dev->pci_dev = pci_dev;
> > +
> > +	err = pci_enable_device(pci_dev);
> > +	if (err)
> > +		return err;
> > +
> > +	err = pci_request_regions(pci_dev, "EEA");
> > +	if (err)
> > +		goto err_disable_dev;
> [ ... ]
> > +	ep_dev->reg = pci_iomap(pci_dev, 0, 0);
> > +	if (!ep_dev->reg) {
> > +		dev_err(&pci_dev->dev, "Failed to map pci bar!\n");
> > +		err = -ENOMEM;
> > +		goto err_release_regions;
> > +	}
> > +
> > +	err = eea_device_reset(&ep_dev->edev);
> > +	if (err) {
> > +		dev_err(&pci_dev->dev, "Failed to reset device for setup!\n");
> > +		goto err_unmap_reg;
> > +	}
> [ ... ]
> > +	ep_dev->edev.rx_num = cfg_read32(ep_dev->reg, rx_num_max);
> > +	ep_dev->edev.tx_num = cfg_read32(ep_dev->reg, tx_num_max);
> > +
> > +	if (ep_dev->edev.rx_num > EEA_PCI_Q_MAX_NUM ||
> > +	    ep_dev->edev.tx_num > EEA_PCI_Q_MAX_NUM) {
> > +		dev_err(&pci_dev->dev, "Invalid queue num %u %u\n",
> > +			ep_dev->edev.rx_num,
> > +			ep_dev->edev.tx_num);
> > +		err = -EINVAL;
> > +		goto err_clear_master;
> > +	}
> [ ... ]
> > +	/* In our design, the number of hardware interrupts matches the maximum
> > +	 * number of queues. If pci_alloc_irq_vectors failed, return directly.
> > +	 *
> > +	 * 2: adminq, error handle
> > +	 */
> > +	n = ep_dev->edev.rx_num + 2;
> > +	ret = pci_alloc_irq_vectors(ep_dev->pci_dev, n, n, PCI_IRQ_MSIX);
> > +	if (ret != n) {
> > +		err = ret;
> > +		goto err_clear_master;
> > +	}
> The vector count uses rx_num only, but tx_num is also read from the device
> and validated independently against EEA_PCI_Q_MAX_NUM. If a device ever
> advertises tx_num > rx_num, would later patches that bind a TX-queue IRQ at
> an index above rx_num + 1 fail because no vector was allocated?
> Should this be max(rx_num, tx_num) + 2, or should there be an explicit
> invariant rejecting tx_num > rx_num here so that the design assumption from
> the comment is enforced?

For the current design, these issues are out of scope.

> > +
> > +	ep_dev->msix_vec_n = ret;
> > +
> > +	return 0;
> [ ... ]
> > +static int eea_init_device(struct eea_device *edev)
> > +{
> > +	int err;
> > +
> > +	err = eea_device_reset(edev);
> > +	if (err)
> > +		return err;
> > +
> > +	eea_pci_io_set_status(edev, EEA_S_INIT);
> > +
> > +	err = eea_negotiate(edev);
> > +	if (err)
> > +		goto err;
> > +
> > +	/* do net device probe ... */
> > +
> > +	return 0;
> > +err:
> > +	eea_add_status(edev, EEA_S_FAILED);
> > +	return err;
> > +}
> > +
> > +static int __eea_pci_probe(struct pci_dev *pci_dev,
> > +			   struct eea_pci_device *ep_dev)
> > +{
> > +	int err;
> > +
> > +	pci_set_drvdata(pci_dev, ep_dev);
> > +
> > +	err = eea_pci_setup(pci_dev, ep_dev);
> > +	if (err)
> > +		return err;
> > +
> > +	err = eea_init_device(&ep_dev->edev);
> > +	if (err)
> > +		goto err_pci_rel;
> > +
> > +	return 0;
> The probe path calls eea_device_reset() twice in succession:
> __eea_pci_probe()
>   -> eea_pci_setup()
>        -> eea_device_reset()  /* first reset */
>   -> eea_init_device()
>        -> eea_device_reset()  /* second reset */
> EEA_RESET_TIMEOUT_US is 60 seconds, so a misbehaving or slow device can
> stall probe for up to 120 seconds. Is the second reset intentional, and if
> so, could the rationale be added as a comment? Otherwise, would it make
> sense to drop one of them so that probe has only one reset point?

The first reset is intended to clear any potential DMA remnants from scenarios
like kexec. The second reset is performed to ensure the device is in a valid
state immediately before the actual probe. While the 60s timeout is a worst-case
safeguard, the actual device response should typically complete within 1 second.


> > +
> > +err_pci_rel:
> > +	eea_pci_release_resource(ep_dev);
> > +	return err;
> > +}
> [ ... ]
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.h b/drivers/net/ethernet/alibaba/eea/eea_pci.h
> > new file mode 100644
> > index 000000000000..746cce4dd68e
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_pci.h
> > @@ -0,0 +1,50 @@
> [ ... ]
> > +struct eea_pci_cap {
> > +	__u8 cap_vndr;
> > +	__u8 cap_next;
> > +	__u8 cap_len;
> > +	__u8 cfg_type;
> > +};
> > +
> > +struct eea_pci_reset_reg {
> > +	struct eea_pci_cap cap;
> > +	__le16 driver;
> > +	__le16 device;
> > +};
> > +
> > +struct eea_pci_device;
> > +
> > +struct eea_device {
> > +	struct eea_pci_device *ep_dev;
> > +	struct device         *dma_dev;
> > +	struct eea_net        *enet;
> > +
> > +	u64 features;
> > +
> > +	u32 rx_num;
> > +	u32 tx_num;
> > +	u32 db_blk_size;
> > +};
> > +
> > +const char *eea_pci_name(struct eea_device *edev);
> > +int eea_pci_domain_nr(struct eea_device *edev);
> > +u16 eea_pci_bdf(struct eea_device *edev);
> > +
> > +int eea_device_reset(struct eea_device *dev);
> > +int eea_pci_set_aq_up(struct eea_device *dev);
> > +
> > +u64 eea_pci_device_ts(struct eea_device *edev);
> > +
> > +void __iomem *eea_pci_db_addr(struct eea_device *edev, u32 off);
> > +#endif
> A number of symbols introduced here have no callers in this commit:
>   eea_pci_name()
>   eea_pci_domain_nr()
>   eea_pci_bdf()
>   eea_pci_set_aq_up()
>   eea_pci_db_addr()
>   eea_pci_device_ts()
>   struct eea_pci_cap
>   struct eea_pci_reset_reg
> struct eea_device also references struct eea_net via the enet field, but
> struct eea_net is not declared anywhere in this commit.
> Because these helpers are non-static, the compiler will not warn about
> unused functions, so the contracts they establish (for example the
> eea_pci_set_aq_up() handshake noted above) cannot be checked against a real
> caller in this patch.
> Could the series be reorganised so that each helper or type is introduced
> together with its first user, per the usual kernel convention?


If there is a follow-up version, I will do this.

