Return-Path: <netdev+bounces-287499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMtmHXNIBGrNGgIAu9opvQ
	(envelope-from <netdev+bounces-287499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:46:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E70530E67
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A99F3310F439
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064893E9C1E;
	Wed, 13 May 2026 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BUFx7xgb"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B46F3AE195
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665005; cv=none; b=Guj5enMqspCqKgs5GG8KuPRjRPhgvZZTvIMjqvoC2diOCqVc10lbxsGV+dpzMJu3ceJ5hHoRwwvlqlcrwQI71VGEkDD4GP/bYS2HsfNDqsFWsJZxNG79sDGfqadrq5qxh9XwTCXGRSR42cPqv5B2H2mM4CeYHmVqB+pNIVOijpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665005; c=relaxed/simple;
	bh=aAJHQ33bJ4PDhBNJKFufDit3fV/pu3MUw3SmOAJMr2Q=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=nDm8zL+lCvUEzPYjHLmafH5CmgsBp+4rRy9djx6Gq5jkdSF1vVOgcOu0p3rV4witGQ6L1jVom2vi/eAF77/oo6o7fnBgXf8jmZ8Ze1mKoFZOxsmKDrEDYV02Iuszf77LHA4YiiISM0wZJb0xX9pvJaAKo6IQQzo0CBVWrYuSvo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BUFx7xgb; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778664995; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=MZQZW7273zCOHWpxlljLTSlQBSte44sCnNS0Gj4IQeM=;
	b=BUFx7xgbMPjJORRRRKjruw0iGMqgfyxHWaj5RE9JAGRqfqgRiEzd0SQzGGqKnbw6nRX3hrIFjt9FhnkT/1HuvrIGaf1As913IBezSvBY9cj375g9iHVsdzGZ8N0upIAifqAl/qX0jOYJT3HBwhBIUu0StL7fSJXfWJNQR5gC224=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X2tfaJ._1778664993;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X2tfaJ._1778664993 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 May 2026 17:36:34 +0800
Message-ID: <1778664597.4457154-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v42 0/8] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Wed, 13 May 2026 17:29:57 +0800
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
 Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20260504144439.29570-1-xuanzhuo@linux.alibaba.com>
 <1c5a2912-6d24-4709-b3da-9a58f0731e9f@redhat.com>
In-Reply-To: <1c5a2912-6d24-4709-b3da-9a58f0731e9f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 48E70530E67
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287499-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,linux.alibaba.com,linux.dev,mucse.com,stu.xidian.edu.cn,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Action: no action

On Thu, 7 May 2026 12:30:15 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> On 5/4/26 4:44 PM, Xuan Zhuo wrote:
> > Add a driver framework for EEA that will be available in the future.
> >
> > This driver is currently quite minimal, implementing only fundamental
> > core functionalities. Key features include: I/O queue management via
> > adminq, basic PCI-layer operations, and essential RX/TX data
> > communication capabilities. It also supports the creation,
> > initialization, and management of network devices (netdev). Furthermore,
> > the ring structures for both I/O queues and adminq have been abstracted
> > into a simple, unified, and reusable library implementation,
> > facilitating future extension and maintenance.
>
> I forwarded you the comments from nipa-sashiko. There are more on
> gemini, even a good deal of them looks invalid. For future revisions, it
> would help moving this series forward to triage such comments,
> explicitly marking the invalid ones.

Allow me to summarize the situation briefly:

eea: introduce PCI framework
     Sashiko questioned if read_poll_timeout could return early by reading =
the
     value we just wrote. While this is a valid concern for generic PCI
     devices, it is not an issue here. In our scenario, the DPU software
     handles all IOMMU responses, ensuring that the register transition is
     atomic relative to the software service. Thus, no hardware-side race
     condition exists, and the current handshake is robust by design.

eea: introduce ring and descriptor structures
     This commit has passed regression testing multiple times and is consid=
ered
     stable. We can likely drop it from our focus list.

eea: probe the netdevice and create adminq
     Sashiko has repeatedly expressed concerns that the device might access=
 the
     ring if eea_pci_set_aq_up fails. While the ring's DMA address is confi=
gured
     in the hardware beforehand, the device is architecturally designed to =
only
     begin ring processing upon a successful return from eea_pci_set_aq_up.=
 If
     this step fails, the device remains idle and will not perform any write
     operations to the ring. Thus, there is no risk of invalid hardware acc=
ess.

eea: create/destroy rx,tx queues for netdevice open and stop
     This section seems to be a persistent source of minor glitches. ^_^

eea: implement packet receive logic
     I believe this commit is ready. It hasn't triggered any meaningful iss=
ues
     for a long time. Sashiko=E2=80=99s concern primarily centers on error =
handling
     during multi-fragment processing=E2=80=94specifically, whether a mid-s=
tream
     exception might cause the driver to misidentify subsequent fragments a=
s the
     start of a new packet. However, from a driver perspective, there is li=
ttle
     we can do in such scenarios; if the hardware state becomes corrupted in
     this way, it constitutes a critical hardware error that is effectively
     beyond the driver's recovery capability.

eea: implement packet transmit logic
     Sashiko requested that we clear the descriptor (desc) fields before
     dispatch. However, according to our current design, unused fields in t=
he
     descriptor do not require explicit clearing. I believe this addition is
     unnecessary and could introduce overhead without providing actual valu=
e.
     Regarding the other points on exception handling, I maintain my previo=
us
     stance: if the hardware enters a faulty state, the driver's ability to
     recover is inherently limited. I don't see the benefit in over-enginee=
ring
     the driver to compensate for catastrophic hardware failures.

eea: introduce ethtool support
     This commit has passed regression testing multiple times and is consid=
ered
     stable. We can likely drop it from our focus list.

eea: introduce callback for ndo_get_stats64 and register netdev
     There is a standing requirement for linear growth in the stats counter=
s.
     However, I plan to introduce qstats (queue-specific statistics) in a f=
uture
     update, which will be a more appropriate place for such tracking. I in=
tend
     to defer this feature until that implementation; it will not be includ=
ed in
     the current version.

Thanks.













>
> Thanks,
>
> Paolo
>

