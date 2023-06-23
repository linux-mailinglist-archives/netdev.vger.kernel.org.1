Return-Path: <netdev+bounces-13315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375F273B3E4
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 11:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3837D1C20355
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9774434;
	Fri, 23 Jun 2023 09:44:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3213D9E
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 09:44:06 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CAC2100
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:44:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3111cb3dda1so681901f8f.0
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687513440; x=1690105440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pcy5cyjz7F8/6l0R/EBOM5X+Qzp4ddDgR685z6/Mzss=;
        b=ok4Ft78NCIBjvhxW6+v7MQjB26wxgcCwNpE1Ml0e0dES5zZCq7apHWlDFflAKjDAyc
         h99BcsaBrDSYbom6kNsNjhUDrV14INYkboViGd7fIqL3q7IB+ZPqawgGMT4ekZA7STgx
         IViXmHCmEnAUn9oVFg9sioxPx2fEWXgsC7E6WJ27QCwNSfaG7Af+tV7QzRFqdCQrlLLB
         RozewenzHz1pqcTU64hm3p6EDzwQNHwYwy/uD4FiRPYvUsCvhIsM3eym3p0h5Au+PJQA
         BsfvNGWOI4rk+dvwRD53tzJRxJP9FUrrVDXCSQWqJ262Ub+4UgQ2ELAwJhgG9cyDZDNZ
         SgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687513440; x=1690105440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcy5cyjz7F8/6l0R/EBOM5X+Qzp4ddDgR685z6/Mzss=;
        b=SUnjoEQGgo5HToJqT1JRnQcXtiFcXgs3XZzDqhYE17PqtBi0C8bYMPCrFK5idnzoAI
         gv/c+rnY27NcuDbnOgdGt2DnwAisA0/A7V2PrAYoIfiSfnnv9IDy0pa4FPz2S8f/27yg
         JDVFqiOPADvf0g6hLTam7Qn+chxUXxqd9DalTUUTtkFNs8ePvQXGPHqzW2HqyYL2f2tI
         mNQTOQ6NCerds88rLtZcWbM+WtGU2FTxTyrpNTB4Alg2fSX36C5V1Ldgq1jnm2doVC27
         xBchGMimOj+yATNBxKivSW9/iBw9deFhK+FYNgeiiBDOwQu4isne++6f6wf9qgtWSXVp
         UeJQ==
X-Gm-Message-State: AC+VfDwHqXyFfXCNvIEA1egJU8qxkufZZUSKvBtb/9q8lqDj+2Pk3nmp
	W33hFnUO5BTKPGV3d0SfCaitkg==
X-Google-Smtp-Source: ACHHUZ7DMQ7qm38AjWRARvBdOxeZdZfTwYAdbda1YDLhCgkTQvc+wurTdcmndV+S22IzJxbEHx6UJA==
X-Received: by 2002:a5d:58ea:0:b0:30f:bafb:2478 with SMTP id f10-20020a5d58ea000000b0030fbafb2478mr19835564wrd.42.1687513439618;
        Fri, 23 Jun 2023 02:43:59 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d4a88000000b003068f5cca8csm9069659wrq.94.2023.06.23.02.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 02:43:58 -0700 (PDT)
Date: Fri, 23 Jun 2023 11:43:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: souradeep chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com, vkuznets@redhat.com,
	tglx@linutronix.de, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, stable@vger.kernel.org,
	schakrabarti@microsoft.com
Subject: Re: [PATCH V2 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Message-ID: <ZJVpXR52RQxdYRY+@nanopsycho>
References: <1687505355-29212-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687505355-29212-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Jun 23, 2023 at 09:29:15AM CEST, schakrabarti@linux.microsoft.com wrote:
>From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
>
>This patch addresses  the VF unload issue, where mana_dealloc_queues()

double space here    ^^

>gets stuck in infinite while loop, because of host unresponsiveness.
>It adds a timeout in the while loop, to fix it.
>
>Also this patch adds a new attribute in mana_context, which gets set when
>mana_hwc_send_request() hits a timeout because of host unresponsiveness.
>This flag then helps to avoid the timeouts in successive calls.

You aparently combine 2 patches together. Please split.


>
>Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

Please provide a "Fixes" tag with pointer to the commit that introduced
the problem.


>---
>V1 -> V2:
>* Added net branch
>* Removed the typecasting to (struct mana_context*) of void pointer
>* Repositioned timeout variable in mana_dealloc_queues()
>* Repositioned vf_unload_timeout in mana_context struct, to utilise the
>  6 bytes hole
>---
> .../net/ethernet/microsoft/mana/gdma_main.c   |  4 +++-
> .../net/ethernet/microsoft/mana/hw_channel.c  | 12 ++++++++++-
> drivers/net/ethernet/microsoft/mana/mana_en.c | 21 +++++++++++++++++--
> include/net/mana/mana.h                       |  2 ++
> 4 files changed, 35 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>index 8f3f78b68592..6411f01be0d9 100644
>--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
>+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>@@ -946,10 +946,12 @@ int mana_gd_deregister_device(struct gdma_dev *gd)
> 	struct gdma_context *gc = gd->gdma_context;
> 	struct gdma_general_resp resp = {};
> 	struct gdma_general_req req = {};
>+	struct mana_context *ac;
> 	int err;
> 
> 	if (gd->pdid == INVALID_PDID)
> 		return -EINVAL;
>+	ac = gd->driver_data;
> 
> 	mana_gd_init_req_hdr(&req.hdr, GDMA_DEREGISTER_DEVICE, sizeof(req),
> 			     sizeof(resp));
>@@ -957,7 +959,7 @@ int mana_gd_deregister_device(struct gdma_dev *gd)
> 	req.hdr.dev_id = gd->dev_id;
> 
> 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
>-	if (err || resp.hdr.status) {
>+	if ((err || resp.hdr.status) && !ac->vf_unload_timeout) {
> 		dev_err(gc->dev, "Failed to deregister device: %d, 0x%x\n",
> 			err, resp.hdr.status);
> 		if (!err)
>diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
>index 9d1507eba5b9..492cb2c6e2cb 100644
>--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
>+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
>@@ -1,8 +1,10 @@
> // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /* Copyright (c) 2021, Microsoft Corporation. */
> 
>+#include "asm-generic/errno.h"
> #include <net/mana/gdma.h>
> #include <net/mana/hw_channel.h>
>+#include <net/mana/mana.h>
> 
> static int mana_hwc_get_msg_index(struct hw_channel_context *hwc, u16 *msg_id)
> {
>@@ -786,12 +788,19 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
> 	struct hwc_wq *txq = hwc->txq;
> 	struct gdma_req_hdr *req_msg;
> 	struct hwc_caller_ctx *ctx;
>+	struct mana_context *ac;
> 	u32 dest_vrcq = 0;
> 	u32 dest_vrq = 0;
> 	u16 msg_id;
> 	int err;
> 
> 	mana_hwc_get_msg_index(hwc, &msg_id);
>+	ac = hwc->gdma_dev->driver_data;
>+	if (ac->vf_unload_timeout) {
>+		dev_err(hwc->dev, "HWC: vport is already unloaded.\n");
>+		err = -ETIMEDOUT;
>+		goto out;
>+	}
> 
> 	tx_wr = &txq->msg_buf->reqs[msg_id];
> 
>@@ -825,9 +834,10 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
> 		goto out;
> 	}
> 
>-	if (!wait_for_completion_timeout(&ctx->comp_event, 30 * HZ)) {
>+	if (!wait_for_completion_timeout(&ctx->comp_event, 5 * HZ)) {
> 		dev_err(hwc->dev, "HWC: Request timed out!\n");
> 		err = -ETIMEDOUT;
>+		ac->vf_unload_timeout = true;
> 		goto out;
> 	}
> 
>diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
>index d907727c7b7a..cb2080b3a00c 100644
>--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
>+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
>@@ -2329,7 +2329,10 @@ static int mana_dealloc_queues(struct net_device *ndev)
> {
> 	struct mana_port_context *apc = netdev_priv(ndev);
> 	struct gdma_dev *gd = apc->ac->gdma_dev;
>+	unsigned long timeout;
> 	struct mana_txq *txq;
>+	struct sk_buff *skb;
>+	struct mana_cq *cq;
> 	int i, err;
> 
> 	if (apc->port_is_up)
>@@ -2348,13 +2351,26 @@ static int mana_dealloc_queues(struct net_device *ndev)
> 	 *
> 	 * Drain all the in-flight TX packets
> 	 */
>+
>+	timeout = jiffies + 120 * HZ;
> 	for (i = 0; i < apc->num_queues; i++) {
> 		txq = &apc->tx_qp[i].txq;
>-
>-		while (atomic_read(&txq->pending_sends) > 0)
>+		while (atomic_read(&txq->pending_sends) > 0 &&
>+		       time_before(jiffies, timeout)) {
> 			usleep_range(1000, 2000);
>+		}
> 	}
> 
>+	for (i = 0; i < apc->num_queues; i++) {
>+		txq = &apc->tx_qp[i].txq;
>+		cq = &apc->tx_qp[i].tx_cq;
>+		while (atomic_read(&txq->pending_sends)) {
>+			skb = skb_dequeue(&txq->pending_skbs);
>+			mana_unmap_skb(skb, apc);
>+			napi_consume_skb(skb, cq->budget);
>+			atomic_sub(1, &txq->pending_sends);
>+		}
>+	}
> 	/* We're 100% sure the queues can no longer be woken up, because
> 	 * we're sure now mana_poll_tx_cq() can't be running.
> 	 */
>@@ -2605,6 +2621,7 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
> 		}
> 	}
> 
>+	ac->vf_unload_timeout = false;

Pointless init. You have the struct zeroed during allocation.


> 	err = add_adev(gd);
> out:
> 	if (err)
>diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
>index 9eef19972845..5f5affdca1eb 100644
>--- a/include/net/mana/mana.h
>+++ b/include/net/mana/mana.h
>@@ -358,6 +358,8 @@ struct mana_context {
> 
> 	u16 num_ports;
> 
>+	bool vf_unload_timeout;
>+
> 	struct mana_eq *eqs;
> 
> 	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
>-- 
>2.34.1
>
>

