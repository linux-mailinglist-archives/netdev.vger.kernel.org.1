Return-Path: <netdev+bounces-43895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB3C7D53BF
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7A02819D1
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C151E2C844;
	Tue, 24 Oct 2023 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Kmtus5Y4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4291D2773A
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:18:40 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00399B6
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 07:18:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso7128595a12.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 07:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698157116; x=1698761916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JOgUmZ/i7NH7todrPk6yq7t2rzG1HndUdq8MJVPNGQg=;
        b=Kmtus5Y4g8S0M0hDHLZTh03iiSRIx9AC7hnts+moSczbP9bVMGWCnhvNprqmt1yjgv
         fPsINU3RzmxygB7FLeXv1BeB88pek274choXCaU2PGCXw2bHPASvd5FCMwcquAab6tEJ
         8Pv4V8nBHAPRcEGbEaqu9oIqE4uq9OOyBoZ2EcxHw5k7Fvl5azt2zVMKQy6n4JXGt0+A
         60A+steqJqrHE7SLsBKVSjJH9WcUOOWx73/1v1lwrAziqKROMqmRw9TstizcQdmQ+yKv
         KtMDC8/tRqe0kvpthfTbJD9TNL4rSW6p8Swo+WpXCzV4hxo8Ci681cG60FgNfOd+2VtZ
         up1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157116; x=1698761916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOgUmZ/i7NH7todrPk6yq7t2rzG1HndUdq8MJVPNGQg=;
        b=PA+H9uJriD6IyQ+MsZ+n1nJMgFU0b1nHwXrudJOVmxFPpk42mCegW8RBmmX/PEDa+r
         FDFkuOO/th7CKUBqowI0oQFzgibnzPW1sesxcz1nG73qgQUipBgjUxE/foFyCLpqn9K/
         ggU39DjyXs/3qntlPBaye1hNsV8MGUimOPX0x0gHtQS1ul5iqfjuqO5r7WgCsrVots5h
         V/YMmfmQn2I8QC9Yf5CITlh17brQnybdSb+587r3BXwROQ+qMoQ/QgcDx5TDNq4nGS+C
         Ibo4LwzLN+5QnS+3iM0w4FlO5jtrlTA1iC0O5mZMeLpsczhVFd/SGLybMcteCcFnlbek
         +GQg==
X-Gm-Message-State: AOJu0YxK0q5KSP0Nx78ZHcOGz4V+FmPOP3ZJlbc42ZVlTSFI6QDBkbru
	A5FcydlEHuJh7WOnyjkT7fpURw==
X-Google-Smtp-Source: AGHT+IEfPX8HDxSh3u8WyrY3nPgo1Z+3/Jd8JTRXkUQ5Qt3roDlGxpW/xl03NSdnJ+FV1PgOJ72iZw==
X-Received: by 2002:a17:906:c156:b0:9b2:c583:cd71 with SMTP id dp22-20020a170906c15600b009b2c583cd71mr9509494ejc.50.1698157116191;
        Tue, 24 Oct 2023 07:18:36 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id lv12-20020a170906bc8c00b009c657110cf2sm8356351ejb.99.2023.10.24.07.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 07:18:35 -0700 (PDT)
Date: Tue, 24 Oct 2023 16:18:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
	smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
	yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
	imagedong@tencent.com, ast@kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH v17 01/20] net: Introduce direct data placement tcp
 offload
Message-ID: <ZTfSOv0F7licIO6Y@nanopsycho>
References: <20231024125445.2632-1-aaptel@nvidia.com>
 <20231024125445.2632-2-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024125445.2632-2-aaptel@nvidia.com>

Tue, Oct 24, 2023 at 02:54:26PM CEST, aaptel@nvidia.com wrote:
>From: Boris Pismenny <borisp@nvidia.com>

[...]


>@@ -2134,6 +2146,9 @@ struct net_device {
> 	netdev_features_t	mpls_features;
> 	netdev_features_t	gso_partial_features;
> 
>+#ifdef CONFIG_ULP_DDP
>+	struct ulp_ddp_netdev_caps ulp_ddp_caps;

Why can't you have this inside the driver? You have set_caps/get_stats
ops. Try to avoid netdev struct pollution.


>+#endif
> 	unsigned int		min_mtu;
> 	unsigned int		max_mtu;
> 	unsigned short		type;

[...]


>+/**
>+ * struct netlink_ulp_ddp_stats - ULP DDP offload statistics
>+ * @rx_nvmeotcp_sk_add: number of sockets successfully prepared for offloading.
>+ * @rx_nvmeotcp_sk_add_fail: number of sockets that failed to be prepared
>+ *                           for offloading.
>+ * @rx_nvmeotcp_sk_del: number of sockets where offloading has been removed.
>+ * @rx_nvmeotcp_ddp_setup: number of NVMeTCP PDU successfully prepared for
>+ *                         Direct Data Placement.
>+ * @rx_nvmeotcp_ddp_setup_fail: number of PDUs that failed DDP preparation.
>+ * @rx_nvmeotcp_ddp_teardown: number of PDUs done with DDP.
>+ * @rx_nvmeotcp_drop: number of PDUs dropped.
>+ * @rx_nvmeotcp_resync: number of resync.
>+ * @rx_nvmeotcp_packets: number of offloaded PDUs.
>+ * @rx_nvmeotcp_bytes: number of offloaded bytes.
>+ */
>+struct netlink_ulp_ddp_stats {

There is nothing "netlink" about this. Just stats. Exposed over netlink,
yes, but that does not need the prefix.


>+	u64 rx_nvmeotcp_sk_add;
>+	u64 rx_nvmeotcp_sk_add_fail;
>+	u64 rx_nvmeotcp_sk_del;
>+	u64 rx_nvmeotcp_ddp_setup;
>+	u64 rx_nvmeotcp_ddp_setup_fail;
>+	u64 rx_nvmeotcp_ddp_teardown;
>+	u64 rx_nvmeotcp_drop;
>+	u64 rx_nvmeotcp_resync;
>+	u64 rx_nvmeotcp_packets;
>+	u64 rx_nvmeotcp_bytes;
>+
>+	/*
>+	 * add new stats at the end and keep in sync with
>+	 * Documentation/netlink/specs/ulp_ddp.yaml
>+	 */
>+};

[...]


>+++ b/include/net/ulp_ddp_caps.h
>@@ -0,0 +1,42 @@
>+/* SPDX-License-Identifier: GPL-2.0
>+ *
>+ * ulp_ddp.h
>+ *  Author: Aurelien Aptel <aaptel@nvidia.com>
>+ *  Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
>+ */
>+#ifndef _ULP_DDP_CAPS_H
>+#define _ULP_DDP_CAPS_H
>+
>+#include <linux/types.h>
>+
>+enum {
>+	ULP_DDP_C_NVME_TCP_BIT,
>+	ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
>+
>+	/*
>+	 * add capabilities above and keep in sync with
>+	 * Documentation/netlink/specs/ulp_ddp.yaml

Wait what? Why do you need this at all? Just use the uapi enum.


>+	 */
>+	ULP_DDP_C_COUNT,
>+};
>+

[...]

