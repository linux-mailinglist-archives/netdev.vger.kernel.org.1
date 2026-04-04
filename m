Return-Path: <netdev+bounces-275331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIC8ENzL0GkkAQcAu9opvQ
	(envelope-from <netdev+bounces-275331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 10:29:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBA139A69F
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 10:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4192630180AF
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 08:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F76B3502A3;
	Sat,  4 Apr 2026 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AeV+RRd8"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C44139A071
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775291353; cv=none; b=q+861TCypILMlktGNIvNIIoMzK+ipFvHFl9pXT6ZH/tqXo6moAy+dkyCERjBkundmJZ0QArj/H3gkuFKa9mE07fX401Md1lBVpc0HdqJ8ow1kTmFCvRx49ELyezX5mbyljdSpHAAU/NfC7wXsOvZdvOsi2bLQN2KrcBGq14oDLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775291353; c=relaxed/simple;
	bh=ZbsX+Q5T2gwoIrjPK4sgxPqkkf/llmC5UqpbNPFVpmM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=f17bEw8aNL3dOK2qexlfnqlfvlEvjz4ZbI2GmMcO6Sd9VB6picv203OZQog6EyLQ9gQEHRvnS85DX3VoTXSPQMEQtxuE7hfpqVD828LkpfxMmC9ffHVCwn8DxhKjVmdn5j+dMPrCJn9+CpP3z2TalKKageuvVPMn/jhAlmFRJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AeV+RRd8; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775291340; h=Message-ID:Subject:Date:From:To;
	bh=2q+prOzJsFXyRKa4d2Gk0G7yi9o+Nj7QVGZC9FAOjUI=;
	b=AeV+RRd8YRRKiOcP/zR2KgmjyXldD78yMnIxdOILXbTMksVzHEwREaE6XneGsDTOCc+KbGHVWgbwZMJXjhyypsfzrY0pMa5F207VILhT/L2AXkoINJXha+gv5VWVYvDMji8t9/lySn+c8G8u1kHLXbkcUCBemoCKNKPiPCzdg+k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X0MpQxc_1775291338;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X0MpQxc_1775291338 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 04 Apr 2026 16:28:59 +0800
Message-ID: <1775291205.5205972-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v36 1/8] eea: introduce PCI framework
Date: Sat, 4 Apr 2026 16:26:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20260329132222.130912-1-xuanzhuo@linux.alibaba.com>
 <20260329132222.130912-2-xuanzhuo@linux.alibaba.com>
 <e769aaaa-17bb-4356-9848-dc5001885e24@redhat.com>
In-Reply-To: <e769aaaa-17bb-4356-9848-dc5001885e24@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,linux.alibaba.com,linux.dev,mucse.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275331-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8EBA139A69F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2 Apr 2026 10:02:53 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> On 3/29/26 3:22 PM, Xuan Zhuo wrote:
> > +struct eea_pci_cfg {
> > +	__le32 reserve0;
> > +	__le32 reserve1;
> > +	__le32 drv_f_idx;
> > +	__le32 drv_f;
> > +
> > +#define EEA_S_OK           BIT(2)
> > +#define EEA_S_FEATURE_DONE BIT(3)
> > +#define EEA_S_FAILED       BIT(7)
> > +	u8   device_status;
> > +	u8   reserved[7];
> > +
> > +	__le32 rx_num_max;
> > +	__le32 tx_num_max;
> > +	__le32 db_blk_size;
> > +
> > +	/* admin queue cfg */
> > +	__le16 aq_size;
> > +	__le16 aq_msix_vector;
> > +	__le32 aq_db_off;
> > +
> > +	__le32 aq_sq_addr;
> > +	__le32 aq_sq_addr_hi;
> > +	__le32 aq_cq_addr;
> > +	__le32 aq_cq_addr_hi;
> > +
> > +	__le64 hw_ts;
>
> Sashiko has still a lot to say about this series. Here:
>
> ---
> Is there an implicit compiler padding issue here?
> The field aq_cq_addr_hi is a 32-bit integer ending at offset 59. The
> immediately following field, hw_ts, is an 8-byte integer. To align hw_ts
> to an 8-byte boundary, the compiler will implicitly insert 4 bytes of
> padding, placing hw_ts at offset 64 instead of 60.
> Depending on whether the hardware designer intended the register to be
> at offset 60 or 64, the driver might read from the wrong address, or
> rely on implicit padding that could change across architectures.
> ---
>
> I assume the (virtual) H/W does the align thing correctly, so no real
> issue here. Still replying to this patch explaining why the raised
> concern is not valid would help a lot progresses on this series.


Yes, we had indeed overlooked this part before. I think it's still better to
keep it 64-bit aligned. AI did help us, and additionally, it caught another
issue: if an RX packet is dropped, we need to re-dma-sync the buffer
for the device when reusing it. In this AI review, I believe only these two
findings are valid. Even though the second one rarely causes problems in
practice, I'll submit another patch set to address both. AI does catch real
issues, but the Sashiko review results seem to generate too many false
positives. Reviewing them takes up too much of our time, and the return on
effort is too low. I've gone through every single item flagged by Sashiko, and
only these two are actual issues; the rest don't exist. Unfortunately, I can't
reply to them inline like I would in an email thread.

>
> [ ... ]
> > +int eea_device_reset(struct eea_device *edev)
> > +{
> > +	struct eea_pci_device *ep_dev = edev->ep_dev;
> > +	u8 val;
> > +
> > +	eea_pci_io_set_status(edev, 0);
> > +
> > +	return read_poll_timeout(cfg_read8, val, !val, 20, EEA_RESET_TIMEOUT_US,
> > +				 false, ep_dev->reg, device_status);
> > +}
>
> Sashiko says:
> ---
> Can this cause a 60-second thread stall during a surprise removal?
> When a PCIe device is surprise-removed, MMIO reads typically return all
> ones (0xFF). If the device is removed, !0xFF evaluates to false, causing
> the loop to never exit early and hanging the executing thread for the
> entire 60-second timeout.
> ---
>
> A similar concern was raised on the previous iteration. I see you
> decreased the timeout from 1000s to 60s, but 60s is still a considerably
> longsystem hangup. Anything above a few seconds should be considered
> carefully.


I will add check for 0xFF.


Thanks


>
> > +
> > +int eea_pci_set_aq_up(struct eea_device *edev)
> > +{
> > +	struct eea_pci_device *ep_dev = edev->ep_dev;
> > +	u8 status = eea_pci_io_get_status(edev);
> > +	int err;
> > +	u8 val;
> > +
> > +	WARN_ON(status & EEA_S_OK);
>
> Sashiko says:
>
> ---
> Does a surprise removal trigger a spurious kernel warning here?
> A surprise removal forces status to 0xFF, making 0xFF & BIT(2) true and
> triggering an unintended kernel stack dump for an asynchronous hardware
> event.
> ---
>
> This looks valid to me.
>
> /P
>

