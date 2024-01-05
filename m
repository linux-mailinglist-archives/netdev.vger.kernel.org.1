Return-Path: <netdev+bounces-61859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA14082514D
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 10:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895D128849A
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 09:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ED824A05;
	Fri,  5 Jan 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="u/po0y20"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C49249F7
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so14145925e9.0
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 01:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704448552; x=1705053352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/ztSBwbrYnc3C3ubnEB0gBjQMTcTGB+VnyHOm6Fxgw=;
        b=u/po0y20Ppdcqz/apM4NiyNlP2nH7OLxQhmyl7oZbHE7Bi/XZUMMoC0Cu3TaaeTX8W
         Y+p8Ohmp0JH5ZGDsd77NgmyINnCKMADjYzGqGV3nnZ8dtAkhVzYGwKWAFHlwJf4Vuqlu
         pNNQRdiNLCZeObteCjlDNGpdi4hE2caHwinYUE1YZ59kJu877Da4jWEV66JuSYSufnHg
         J0zTXZkzIkeDXevcIAraNjh+S1pvuF+/IQATvu/6uEPPKvVxrt/2AVr3FvQzHslvzHlM
         chs8T3YWTTqhuW98s5kdelbJe9ltfgm7mNsgjSRsBCWX0yuWL5vxCquB3DQ+Ao/FHLuw
         eZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704448552; x=1705053352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/ztSBwbrYnc3C3ubnEB0gBjQMTcTGB+VnyHOm6Fxgw=;
        b=MXuye6eWmDg2wB7DTlpkVKACgkWhV0NBjRDekDo43D4zckGo1/Nc/0XuhK/RjVjxeJ
         Fq1FELZ6V9NXkhk+4ARTl43ciPmIcMYQBh2WlG0dUXHxtF6yMhLBPrNAX6JB03az4RP/
         Z1ktlcAhXuWeVsfvamjR0Vz5LfXzAmqOqF/2HzZsXI/ayA6va35PMiabyLSTXLrfDB/T
         6v+ncElOlP1+crwturPbPmrO+Rhog/P0ZfIZAuHK8YM30wFE4uAb5qiuqihL+WNwdaNp
         AkiyZeEdBslaEcJAeFkJX7e52h1wlWa50OMY9TwhwffhoUwRR+qHPAmqaIOGkhJlbleX
         MRsg==
X-Gm-Message-State: AOJu0Yzyer2DDl5MT86fpQOF64ED/mBn/AEtTljF+w+NVIfsaRtTSaHn
	BDe7HwGjduqrxkxh1HRLMuwq8Ka5DRachkcIaK0MZPykMxo=
X-Google-Smtp-Source: AGHT+IEWYAJHMPLNr2rJ6gQ20snX+nL3DblEgtUmaXHkW2wP5KU5r+DFb4z+WVlnJpD2rb/OtNnjqA==
X-Received: by 2002:a05:600c:450a:b0:40d:8964:7eb4 with SMTP id t10-20020a05600c450a00b0040d89647eb4mr1070926wmo.35.1704448552303;
        Fri, 05 Jan 2024 01:55:52 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id d12-20020a05600c34cc00b0040d2e37c06dsm1039339wmq.20.2024.01.05.01.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 01:55:51 -0800 (PST)
Date: Fri, 5 Jan 2024 10:55:50 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, lanhao@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 net-next 4/4] net: hns3: support dump pfc frame
 statistics in tx timeout log
Message-ID: <ZZfSJoEsoXceI_2q@nanopsycho>
References: <20240105010119.2619873-1-shaojijie@huawei.com>
 <20240105010119.2619873-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105010119.2619873-5-shaojijie@huawei.com>

Fri, Jan 05, 2024 at 02:01:19AM CET, shaojijie@huawei.com wrote:
>Continuous pfc frames may cause tx timeout.
>Therefore, pfc frame statistics are added to logs.
>
>Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>Reviewed-by: Simon Horman <horms@kernel.org>
>---
> drivers/net/ethernet/hisilicon/hns3/hnae3.h             | 2 ++
> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         | 6 ++++--
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 ++
> 3 files changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
>index ff475b0eac22..bf1e386617bc 100644
>--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
>+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
>@@ -209,6 +209,8 @@ struct hnae3_queue {
> struct hns3_mac_stats {
> 	u64 tx_pause_cnt;
> 	u64 rx_pause_cnt;
>+	u64 tx_pfc_cnt;
>+	u64 rx_pfc_cnt;
> };
> 
> /* hnae3 loop mode */
>diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>index b618797a7e8d..8e237f0f4fc9 100644
>--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>@@ -2871,8 +2871,10 @@ static bool hns3_get_tx_timeo_queue_info(struct net_device *ndev)
> 		struct hns3_mac_stats mac_stats;
> 
> 		h->ae_algo->ops->get_mac_stats(h, &mac_stats);
>-		netdev_info(ndev, "tx_pause_cnt: %llu, rx_pause_cnt: %llu\n",
>-			    mac_stats.tx_pause_cnt, mac_stats.rx_pause_cnt);
>+		netdev_info(ndev,
>+			    "tx_pause_cnt: %llu, rx_pause_cnt: %llu, tx_pfc_cnt: %llu, rx_pfc_cnt: %llu\n",
>+			    mac_stats.tx_pause_cnt, mac_stats.rx_pause_cnt,
>+			    mac_stats.tx_pfc_cnt, mac_stats.rx_pfc_cnt);

Don't we have a better way to expose this? I mean, whenever there is a
patch that extends the amount of text written in dmesg, it smells.
We should rather reduce it.


> 	}
> 
> 	hns3_dump_queue_reg(ndev, tx_ring);
>diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>index cf85ef55a0f4..f70a1159de40 100644
>--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>@@ -775,6 +775,8 @@ static void hclge_get_mac_stat(struct hnae3_handle *handle,
> 
> 	mac_stats->tx_pause_cnt = hdev->mac_stats.mac_tx_mac_pause_num;
> 	mac_stats->rx_pause_cnt = hdev->mac_stats.mac_rx_mac_pause_num;
>+	mac_stats->tx_pfc_cnt = hdev->mac_stats.mac_tx_pfc_pause_pkt_num;
>+	mac_stats->rx_pfc_cnt = hdev->mac_stats.mac_rx_pfc_pause_pkt_num;
> }
> 
> static int hclge_parse_func_status(struct hclge_dev *hdev,
>-- 
>2.30.0
>
>

