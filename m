Return-Path: <netdev+bounces-288196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AgNJJ/ABmo2ngIAu9opvQ
	(envelope-from <netdev+bounces-288196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:43:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5CB54A164
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96EBB301E5A4
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 06:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180F6382F1D;
	Fri, 15 May 2026 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pNKxO9UU"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF98B1EA7DB
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827421; cv=none; b=GU29PdayEWBpD7fqxgp27eKrAjdppf4NSKwU9JHoMTVA6h7M0iXq1II62TLIYI6rSpmvXuFlPimXxuwpe6e0MQ/jSNJ6vS1J+LerBgcn6DyXhIvYDUU0t0IBuJm8cYTYNWVR/qtQbyJkN2f5SK0aFA8r9jCNQfeGGF/FGSGN8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827421; c=relaxed/simple;
	bh=w3LZ+22DKBruuM9EkhSBft5y5RfTvGlNhxYf0cHK3wU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=fGCl+JCNZZjt1hnDS0+PNaxRAxqLAoU6HYziERvslqbDEdNeVk/Knsn78L2DyuHho0bmegiW3niz4aJYld9x57j6qqvA7EhNMABYfxKgQrdiaxgUrgEdijfu2JAiMQoeYq/NUfe0Q8FlhETBcM4D6u0TUav7IR4NnJbXFWbNnZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pNKxO9UU; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778827408; h=Message-ID:Subject:Date:From:To;
	bh=94Q75HxocWakfQHkNTW/VP+CpL1WcLFkRQL6fiF2uYo=;
	b=pNKxO9UUGzyyQJ0ZtukQ3zY9Z8jVibyq/3CFFYSJb+XgHtRjD7N96/ZxO3mHjnu+CYv2Z+4RrUacbZy9CH1Az960IsTZpQB4O0lkdhUMusktLm+fAClve2Kxz3ZEfWv0s/sakP8l/EV+ehjI/SSclzutxyH85SjBRqzEAlkA6uU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X2yjMkA_1778827405;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X2yjMkA_1778827405 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 May 2026 14:43:26 +0800
Message-ID: <1778827248.343426-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v43 0/8] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Fri, 15 May 2026 14:40:48 +0800
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
In-Reply-To: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: DE5CB54A164
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,stu.xidian.edu.cn,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288196-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,sashiko.dev:url]
X-Rspamd-Action: no action

Hi Paolo,

Could you please clarify if this patch set is under embargo?

Also, I noticed that this version is very similar to the previous one. Could
you advise on how you would like me to proceed?

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260514095138.80680-1-xuanzhuo%40linux.alibaba.com

Thanks


On Thu, 14 May 2026 17:51:30 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> Add a driver framework for EEA that will be available in the future.
>
> This driver is currently quite minimal, implementing only fundamental
> core functionalities. Key features include: I/O queue management via
> adminq, basic PCI-layer operations, and essential RX/TX data
> communication capabilities. It also supports the creation,
> initialization, and management of network devices (netdev). Furthermore,
> the ring structures for both I/O queues and adminq have been abstracted
> into a simple, unified, and reusable library implementation,
> facilitating future extension and maintenance.
>
> v43:
>     1. fix the comments from sashiko
>
> v42:
>     1. fix the comments from Jakub
>     2. fix the comments from sashiko
>
> v41:
>     1. make https://sashiko.dev/ happy
>
> v40:
>     1. fix comments from https://sashiko.dev/
>
> v39:
>     1. fix comments from https://sashiko.dev/#/patchset/20260407122001.22265-1-xuanzhuo%40linux.alibaba.com
>
> v38:
>     1. fix comments from https://sashiko.dev/#/patchset/20260404135144.33166-1-xuanzhuo%40linux.alibaba.com
>
> v36:
>     1. fix comments from https://sashiko.dev/#/patchset/20260323074441.91691-1-xuanzhuo%40linux.alibaba.com
>
> v35:
>     1. fix comments from https://netdev-ai.bots.linux.dev/ai-review.html?id=24371ffc-a1ea-46e1-a6b3-b8cbcbb52efb
>
> v34:
>     1. fix the comments from https://sashiko.dev/#/patchset/20260317015257.79494-1-xuanzhuo%40linux.alibaba.com
>
> v33:
>     1. fix the comments. old version refers enet_bind_new_q_and_cfg, but that is
>        changed to eea_bind_q_and_cfg.
>
> v32:
>     1. remove unused parameters from eea_net_ha_reset_remove and eea_create_pp
>     2. call skb_mark_for_recycle for new skb for frag_list skbs
>
> v31:
>     1. remove unused parameter "enet" from eex_rx_post()
>
> v30:
>    1. fix some small problems
>
> v29:
>     Address AI-generated review suggestions from the previous version.
>
> v28:
>     Address AI-generated review suggestions from the previous version.
>
> v27:
>     Address AI-generated review suggestions from the previous version.
>
> v26:
>     Adopting suggestions from the previous AI review, another significant
>     change is the introduction of an IRQ block to implement IRQ proxying. With
>     this design, when an IRQ occurs, we no longer invoke the RX data structure
>     directly -- instead, the IRQ block serves as an intermediary proxy. This
>     approach offers several advantages: IRQ resources no longer need to be
>     reallocated during reset operations, and IRQs are decoupled from RX
>     structures. Consequently, when certain errors occur, we can fall back and
>     safely reuse the original memory resources.
>
> v25:
>     I have adopted most of the suggestions from the AI's feedback. However, I
>     believe some of the feedback is incorrect. I have already replied in the
>     previous thread. http://lore.kernel.org/all/1770002612.3297296-2-xuanzhuo@linux.alibaba.com
>
> v24:
>     1. Add null checks for enet->rx and enet->tx in eea_get_ethtool_stat to
>        prevent errors when reading rx = enet->rx[i] in case enet->rx is null.
>        tx is similar. With rtnl protection in place, this check is sufficient.
>     2. Use 'received' as the return value in eea_poll.
>
> v23:
>     I have moved netif_set_real_num_queues() out of eea_start_rxtx(), so
>     eea_start_rxtx() is now a void function. I believe enet_bind_new_q_and_cfg()
>     is a more suitable place to include netif_set_real_num_queues(). In
>     eea_active_ring_and_irq(), I first execute request_irq() before interacting
>     with the hardware to create queues. Therefore, during the NIC setup process,
>     all driver-internal operations (memory allocation, IRQ initialization, sysfs
>     configuration, etc.) will be completed before the final notification to the
>     hardware.
>
> v22:
>     1. Use the budget from the NAPI poll function as the parameter for
>        napi_consume_skb.
>     2. Stop the TX queue when the remaining ring slots cannot hold an SKB.
>
> v21:
>     Fix two issues from the previous version:
>     1, a DMA unmap operation was missing.
>     2, RCU APIs were not used in eea_stats. Although the standard practice when
>         using RCU would require adding the __rcu annotation to both the rx and
>         tx fields, in many cases these fields are read without needing RCU
>         protection.  Therefore, I do not want to add the __rcu annotation.
>         Instead, I use a spin lock to protect modifications to rx and tx.
>
> v20:
>     Fix the partially initialized structure passed to db. @Jakub
>     http://lore.kernel.org/all/20260113172353.2ae6ef81@kernel.org
>
> v19:
>     fix the comments from @Simon Horman
>
> v18:
>     v17 with [PATCH] prefix.
>
> v17:
>     1. In `eea_adminq_dev_status`, uniformly use `enet->cfg.rx_ring_num`.
>     2. Add a `struct eea_net_cfg *cfg` parameter to `eea_free_rx` and
>         `eea_free_tx`. When called in the normal path, pass `enet->cfg` as
>         the argument; when called during initialization, pass the temporary
>         `cfg` instead.
>     3. Move the `.ndo_get_stats64` callback into `eea_net.c`.
>     4. In the `.ndo_get_stats64` callback, add a comment explaining how the TX
>         and RX statistics are protected by RCU.
>
>        /* This function is protected by RCU. Here uses enet->tx and enet->rx
>         * to check whether the TX and RX structures are safe to access. In
>         * eea_free_rxtx_q_mem, before freeing the TX and RX resources, enet->rx
>         * and enet->tx are set to NULL, and synchronize_net is called.
>         */
>
>
> v16:
>     1. follow the advices from @ALOK TIWARI
>        http://lore.kernel.org/all/5ff95a71-69e5-4cb6-9b2a-5224c983bdc2@oracle.com
>
> v15:
>     1. remove 'default m' from eea kconfig
>     2. free the resources when open failed.
>
> v14:
>     1. some tiny fixes
>
> v13:
>     1. fix some tiny fixes @Simon
>
> v12:
>     I encountered some issues with sending the v11 patches, as they were quite
>     messy. Therefore, I'm resending them as v12.
>
> v11:
>     1. remove auto clean __free(kfree)
>     2. some tiny fixes
>
> v10:
>     1. name the jump labels after the target @Jakub
>     2. rm __GFP_ZERO from dma_alloc_coherent @Jakub
> v9:
>     1. some fixes for ethtool from http://lore.kernel.org/all/20251027183754.52fe2a2c@kernel.org
>
> v8: 1. rename eea_net_tmp to eea_net_init_ctx
>     2. rm code that allocs memory to destroy queues
>     3. some other minor changes
>
> v7: 1. remove the irrelative code from ethtool commit
>     2. build every commits with W12
>
> v6: Split the big one commit to five commits
> v5: Thanks for the comments from Kalesh Anakkur Purayil, ALOK TIWARI
> v4: Thanks for the comments from Troy Mitchell, Przemek Kitszel, Andrew Lunn, Kalesh Anakkur Purayil
> v3: Thanks for the comments from Paolo Abenchi
> v2: Thanks for the comments from Simon Horman and Andrew Lunn
> v1: Thanks for the comments from Simon Horman and Andrew Lunn
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> Xuan Zhuo (8):
>   eea: introduce PCI framework
>   eea: introduce ring and descriptor structures
>   eea: probe the netdevice and create adminq
>   eea: create/destroy rx,tx queues for netdevice open and stop
>   eea: implement packet receive logic
>   eea: implement packet transmit logic
>   eea: introduce ethtool support
>   eea: introduce callback for ndo_get_stats64 and register netdev
>
>  MAINTAINERS                                   |   8 +
>  drivers/net/ethernet/Kconfig                  |   1 +
>  drivers/net/ethernet/Makefile                 |   1 +
>  drivers/net/ethernet/alibaba/Kconfig          |  28 +
>  drivers/net/ethernet/alibaba/Makefile         |   5 +
>  drivers/net/ethernet/alibaba/eea/Makefile     |   9 +
>  drivers/net/ethernet/alibaba/eea/eea_adminq.c | 542 +++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_adminq.h |  83 ++
>  drivers/net/ethernet/alibaba/eea/eea_desc.h   | 138 +++
>  .../net/ethernet/alibaba/eea/eea_ethtool.c    | 273 ++++++
>  .../net/ethernet/alibaba/eea/eea_ethtool.h    |  48 +
>  drivers/net/ethernet/alibaba/eea/eea_net.c    | 887 ++++++++++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_net.h    | 198 ++++
>  drivers/net/ethernet/alibaba/eea/eea_pci.c    | 744 +++++++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_pci.h    |  73 ++
>  drivers/net/ethernet/alibaba/eea/eea_ring.c   | 249 +++++
>  drivers/net/ethernet/alibaba/eea/eea_ring.h   |  99 ++
>  drivers/net/ethernet/alibaba/eea/eea_rx.c     | 814 ++++++++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_tx.c     | 500 ++++++++++
>  19 files changed, 4700 insertions(+)
>  create mode 100644 drivers/net/ethernet/alibaba/Kconfig
>  create mode 100644 drivers/net/ethernet/alibaba/Makefile
>  create mode 100644 drivers/net/ethernet/alibaba/eea/Makefile
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_desc.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_rx.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_tx.c
>
> --
> 2.32.0.3.g01195cf9f
>

