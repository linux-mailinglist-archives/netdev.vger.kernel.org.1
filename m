Return-Path: <netdev+bounces-252241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMpeCCvecWk+MgAAu9opvQ
	(envelope-from <netdev+bounces-252241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:22:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DB06962FA5
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 390BE586223
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8282D481AB0;
	Thu, 22 Jan 2026 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VyrbTD2u"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55B648123D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069608; cv=none; b=RHjNXWP5Bs4xPccLBOVnwHo55TdWqehtw7ptnVOVyhCioL+RG9CKlJ/GikGDEu/57gooC75ukGuSl8YVSbkie9toy4iPH3lthB99IkYh9OIxB0EPPDMXO3cTdCMaiSr19xjvhfm9VqfrjwP5WNJ7A31oC78nowIj2RpfZFr4cgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069608; c=relaxed/simple;
	bh=zN3k0/AQN3wlUmIxed7qsMjkVomSbTW2i7QzYF0akho=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHVObn8MBwMpXuEQ7AkQE4M7IzFxMyvvb8eRfwv+ZWPVbdpyu5tln7bnvTc3JYPqx0ak1G31ktEDmRFy/I6Iz9T7PnfiHztlD3gksZbP1kkk6S4O+GNBZUeESu5HrTwlH1MgzkU5VIR7rnIoN2jktOtbm3IHZIva4xhWQQI2cp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VyrbTD2u; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LNVo1b1133511;
	Thu, 22 Jan 2026 00:12:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=nKfBehUr899tZEqLvcogIj52R
	woN0DwwygqKuZmD5dc=; b=VyrbTD2u3s3wRAtntgtu/pZ+7GpF87GygFmmSBZDr
	D3Oh0tMDyn3SZO2z6gshceSE3AqX8weWf2QUoZXcl4LrJ9flKiVvzxMvbhE6I0cg
	33EPQsqYEvzgd4vrYyvske6BBYyVvf8Z7vxOF7UTFgtqKtr9K+sCondWEUQYf+sv
	TT8XCpa/JvxvlgfMaDKQ2TJ0IxZj4XaLOYt9HoR39fr8Lylhr+0wa6w8vCGw1KHe
	ubr8MdRXv6/yy7Ihx7qPx8fpgPVCraeXmkt5HOCAWuGeR8PZmWLb8S01BPO1UcPc
	KKP0yAm2vagvOWlAtV6SZgncQdcJJF/0vlydGA0eOmhIg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bu8j70x84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 00:12:46 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 Jan 2026 00:12:44 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 22 Jan 2026 00:12:44 -0800
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id 1BDAE3F7048;
	Thu, 22 Jan 2026 00:12:40 -0800 (PST)
Date: Thu, 22 Jan 2026 13:42:40 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
        <michael.chan@broadcom.com>, <sdf@fomichev.me>,
        <almasrymina@google.com>, <dtatulea@nvidia.com>,
        <asml.silence@gmail.com>, <dw@davidwei.uk>, <daniel@iogearbox.net>
Subject: Re: [PATCH net-next 2/6] net: introduce a trivial
 netdev_queue_config()
Message-ID: <20260122081240.GB1544331@kernel-ep2>
References: <20260122005113.2476634-1-kuba@kernel.org>
 <20260122005113.2476634-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260122005113.2476634-3-kuba@kernel.org>
X-Proofpoint-GUID: GazIvJSVu4e2qvv0YCmm49DXN-T0Oga_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA1NCBTYWx0ZWRfX6UdPjFVACNwc
 QP08J28TeWN4dTCBGdy1aQWAHK7PhMLFDk9l/MywsQd0X+5RPg9ZhYnA0F4R+y/kzFaSGo5M8uk
 UOBip6MBHnXFPhtaWXMUYgF5wbmBSFduAUy0tGdp32+abgIumevQ4l8j9E8OjkTTPd8rvqfsp8C
 WXotmAHBsBfvSJXPQ7Teeba+Qbz5oBCJd0HyTj7mGU/pBcbLbVK/rskmFeA/14QCYPaE0BMWTL/
 8q9e052HYmHc8PSrsMjjMvhKsCm7H0SjSW0007eI1sQ7ILked7wWspNhiLuD9fJSZShMCFT01Ls
 MxnP/afch9mbHK9lmjI049JNkxBT9QV1xAKJEGq68/fgBu5zGWp5OlObXB/EXA/c1zfK2nFbzbc
 kfQg/33z02HYgPKEX8Il4+eYCYEUmffcel5vRApJ0lawsAffk5ju41jUzrL5HrBFCL8Xca+7kiG
 MvNlhcXecQ5I3mipsMg==
X-Proofpoint-ORIG-GUID: GazIvJSVu4e2qvv0YCmm49DXN-T0Oga_
X-Authority-Analysis: v=2.4 cv=Q7zfIo2a c=1 sm=1 tr=0 ts=6971dbfe cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=7BfFIGEJwCpXD-RK8Q4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252241-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,fomichev.me,nvidia.com,gmail.com,davidwei.uk,iogearbox.net];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[marvell.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: DB06962FA5
X-Rspamd-Action: no action

On 2026-01-22 at 06:21:09, Jakub Kicinski (kuba@kernel.org) wrote:
> We may choose to extend or reimplement the logic which renders
> the per-queue config. The drivers should not poke directly into
> the queue state. Add a helper for drivers to use when they want
> to query the config for a specific queue.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/Makefile                         |  1 +
>  include/net/netdev_queues.h               |  3 +++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c |  6 ++---
>  net/core/netdev_config.c                  | 32 +++++++++++++++++++++++
>  4 files changed, 39 insertions(+), 3 deletions(-)
>  create mode 100644 net/core/netdev_config.c
> 
> diff --git a/net/core/Makefile b/net/core/Makefile
> index 9ef2099c5426..d643a5a7fd18 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
>  
>  obj-y += net-sysfs.o
>  obj-y += hotdata.o
> +obj-y += netdev_config.o
>  obj-y += netdev_rx_queue.o
>  obj-y += netdev_queues.o
>  obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index 2ab3eae8e8c3..725bf69ef86c 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -170,6 +170,9 @@ struct netdev_queue_mgmt_ops {
>  	unsigned int supported_params;
>  };
>  
> +void netdev_queue_config(struct net_device *dev, int rxq,
> +			 struct netdev_queue_config *qcfg);
> +
Minor nit: make function name something like netdev_get_queue_config
(to avoid same as struct name)

Thanks,
Sundeep

>  bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
>  
>  /**
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 0b95100a7c36..d57e833ce690 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -4326,12 +4326,12 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
>  
>  	for (i = 0; i < bp->cp_nr_rings; i++) {
>  		struct bnxt_napi *bnapi = bp->bnapi[i];
> +		struct netdev_queue_config qcfg;
>  		struct bnxt_ring_mem_info *rmem;
>  		struct bnxt_cp_ring_info *cpr;
>  		struct bnxt_rx_ring_info *rxr;
>  		struct bnxt_tx_ring_info *txr;
>  		struct bnxt_ring_struct *ring;
> -		struct netdev_rx_queue *rxq;
>  
>  		if (!bnapi)
>  			continue;
> @@ -4349,8 +4349,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
>  		if (!rxr)
>  			goto skip_rx;
>  
> -		rxq = __netif_get_rx_queue(bp->dev, i);
> -		rxr->rx_page_size = rxq->qcfg.rx_page_size;
> +		netdev_queue_config(bp->dev, i, &qcfg);
> +		rxr->rx_page_size = qcfg.rx_page_size;
>  
>  		ring = &rxr->rx_ring_struct;
>  		rmem = &ring->ring_mem;
> diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
> new file mode 100644
> index 000000000000..562087bd30c8
> --- /dev/null
> +++ b/net/core/netdev_config.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/netdevice.h>
> +#include <net/netdev_queues.h>
> +#include <net/netdev_rx_queue.h>
> +
> +/**
> + * netdev_queue_config() - get configuration for a given queue
> + * @dev:      net_device instance
> + * @rxq_idx:  index of the queue of interest
> + * @qcfg: queue configuration struct (output)
> + *
> + * Render the configuration for a given queue. This helper should be used
> + * by drivers which support queue configuration to retrieve config for
> + * a particular queue.
> + *
> + * @qcfg is an output parameter and is always fully initialized by this
> + * function. Some values may not be set by the user, drivers may either
> + * deal with the "unset" values in @qcfg, or provide the callback
> + * to populate defaults in queue_management_ops.
> + */
> +void netdev_queue_config(struct net_device *dev, int rxq_idx,
> +			 struct netdev_queue_config *qcfg)
> +{
> +	struct netdev_queue_config *stored;
> +
> +	memset(qcfg, 0, sizeof(*qcfg));
> +
> +	stored = &__netif_get_rx_queue(dev, rxq_idx)->qcfg;
> +	qcfg->rx_page_size = stored->rx_page_size;
> +}
> +EXPORT_SYMBOL(netdev_queue_config);
> -- 
> 2.52.0
> 

