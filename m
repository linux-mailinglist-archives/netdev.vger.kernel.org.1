Return-Path: <netdev+bounces-157958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0E6A0FF22
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98FCA7A1388
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FD7230D07;
	Tue, 14 Jan 2025 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8kK5r+I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1ED2309A4;
	Tue, 14 Jan 2025 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736824805; cv=none; b=h8i0skX7ZHfinytmBEuhXXG+81a+mpHdn6xBoavZJZexQoqXHu3wMMxZyM+jEMO6DYepb6/p2PNY4HiQtZdiBbhW76Hs2/k9xGy7VrGd9qB7lh05emoy+Oom7XelGVQKig4vPeFCM4K9GWvtsSwKTyOCa8gEqG4v5um+nxPt964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736824805; c=relaxed/simple;
	bh=QB8d+k+zAe20PnFNHeo6Jxr1OZ7yn2eqc1z/NBHfckI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubgcaf511ZjZuHTVgXHGEmlPTHV9N/2FuUsixRXAOQMUrOswsCNotOVUzxNNbt5qyQASsDRvJo44Wk2iI2++t9a34zUEt1rBetwSlK8Pht5sNQl9GVyZBQA+jm2NfPGbmA/wmq3bkdLky5rnS4iwdZdXwVu4AY3AWYNs1ldMw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8kK5r+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E66C4CEE1;
	Tue, 14 Jan 2025 03:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736824804;
	bh=QB8d+k+zAe20PnFNHeo6Jxr1OZ7yn2eqc1z/NBHfckI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j8kK5r+Ibx7RlfTRmW7X/evsF6cSiBVtxGvTCm8d1+5u/7pfIQ3lWmkd0jmYZjxGo
	 YUZN1W8gCdMpj2FDf5AgZ+A6gYK8MOv7VLjU0gsBj0z6UVK8TMoc1gRz5jv4jqmci/
	 D8ZcYLUT2OVFgibAvA4G53YmMxwH2GTQ6+1q2PSbbd6agobZvPZAYFqIwVgsg+nuPC
	 +ph9aQkJ+CXwSla65qsCGSpKqajj2w84Ok5bgQ+hkJn3I+7Fh9mpL1//YtJkyBASlF
	 +cEU/p6GIwDN08Xqhd3d5cs20HqVKejK3CII9MVJQnSN3nNUbmIBuOigQ+ppCuc9/N
	 CYGRA2cr8RNNw==
Date: Mon, 13 Jan 2025 19:20:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
 <UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
 <linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next v2 3/3] net: phy: microchip_rds_ptp : Add
 PEROUT feature library for RDS PTP supported phys
Message-ID: <20250113192002.39dda2c2@kernel.org>
In-Reply-To: <20250109102533.15621-4-divya.koppera@microchip.com>
References: <20250109102533.15621-1-divya.koppera@microchip.com>
	<20250109102533.15621-4-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2025 15:55:33 +0530 Divya Koppera wrote:
> +	switch (ts_on_nsec) {
> +	case 200000000:
> +		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_200MS_;
> +		break;
> +	case 100000000:
> +		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_100MS_;
> +		break;
> +	case 50000000:
> +		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_50MS_;
> +		break;
> +	case 10000000:
> +		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_10MS_;
> +		break;
> +	case 5000000:
> +		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_5MS_;
> +		break;
> +	case 1000000:
> +		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_1MS_;
> +		break;
> +	case 500000:
> +		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_500US_;
> +		break;
> +	case 100000:
> +		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_100US_;
> +		break;
> +	case 50000:
> +		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_50US_;
> +		break;
> +	case 10000:
> +		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_10US_;
> +		break;
> +	case 5000:
> +		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_5US_;
> +		break;
> +	case 1000:
> +		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_1US_;
> +		break;
> +	case 500:
> +		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_500NS_;
> +		break;
> +	case 100:
> +		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_100NS_;
> +		break;
> +	default:
> +		phydev_warn(phydev, "Using default pulse width of 200ms\n");
> +		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_200MS_;
> +		break;

+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_200MS_	13
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_100MS_	12
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_50MS_	11
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_10MS_	10
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_5MS_	9
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_1MS_	8
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_500US_	7
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_100US_	6
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_50US_	5
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_10US_	4
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_5US_	3
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_1US_	2
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_500NS_	1
+#define MCHP_RDS_PTP_GEN_CFG_LTC_EVT_100NS_	0

1) seems a bit weird to me that you go to 200ms whenever user asks for
   a value that couldn't be provided exactly. Why not go to the next
   good value?
2) this is not very well coded up, given that the values you're
   translating to are a just natural numbers you can use a table

static const sup_on_necs[] = {
	100,		/* 100ns */
	500,		/* 500ns */
	1000,		/* 1us */
	5000,		/* 5us */
	...
};

for (i = 0; i < ARRAY_SIZE(sup_on_necs); i++) {
	if (ts_on_nsec <= sup_on_necs[i]) {
		*pulse_width = i;
		break;
	}
}
-- 
pw-bot: cr

