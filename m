Return-Path: <netdev+bounces-205438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 934D9AFEACC
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF8C18863FE
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0F32E041F;
	Wed,  9 Jul 2025 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YCDKl75t"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6032D59E4
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069122; cv=none; b=aC931qNdvPAFBNvzWaTbAuogR0fsV0hQvGFngl6p69tcTQJ1HRsmuUnyKv39YMR0fttyFcQ5dpiWVWV4NIkuAoPOWwHV7E9VHr/h5GrmeXySBYLh6dPkeWF5mV/Y+obOiXdsNwzekNLBj8ghqyK72val7sIUe2o6e8Eo9oGU5rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069122; c=relaxed/simple;
	bh=t9r2tCq4Koo6vPvZYpiCCJMYAZ61THXsNerWOF1rwJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c57onQ5trHYQuwIusUOlghsR/k5yJEdQAXNOLOmfItb7Ti7wqodUpfcvF7bJs6M0TZadtwLjuafL44wwfugXkRwASKJQZIFR4Jo87pIxs3Fg/rpVQgrc3lpZ6dLOeIBEu8CCMs3+6lE747+q/Kevecwi+SEXmp8x781wcO4cCWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YCDKl75t; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b8efdcd7-bc06-4c91-910f-3337be7408de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752069118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eMsrQPAy6VNiHKZk80acEBT2ke3J3UIlQ0eRTJNEqo=;
	b=YCDKl75tUYnxDzYuMVNvTLbAKsYHKVtrp6wdCN88VxRQSPToXT4oIBBB2SyolL6XlDOZDk
	OkbjJXXKzuYz8An1jsldIliZsCRByCBvG9yL1AxgEid5k3JiJV67jKMCb2PGQGaXwwNpLM
	Jh8l/q9prcKNbS/jhz9C2Po/pD2exPI=
Date: Wed, 9 Jul 2025 14:51:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 03/12] net: libwx: add wangxun vf common api
To: Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org
Cc: michal.swiatkowski@linux.intel.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, andrew+netdev@lunn.ch, duanqiangwen@net-swift.com,
 linglingzhang@trustnetic.com, jiawenwu@trustnetic.com
References: <20250704094923.652-1-mengyuanlou@net-swift.com>
 <20250704094923.652-4-mengyuanlou@net-swift.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250704094923.652-4-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/07/2025 10:49, Mengyuan Lou wrote:
> Add common wx_configure_vf and wx_set_mac_vf for
> ngbevf and txgbevf.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>   drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
>   drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   3 +-
>   drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   1 +
>   drivers/net/ethernet/wangxun/libwx/wx_type.h  |   4 +
>   drivers/net/ethernet/wangxun/libwx/wx_vf.h    |  50 ++++
>   .../net/ethernet/wangxun/libwx/wx_vf_common.c | 196 ++++++++++++
>   .../net/ethernet/wangxun/libwx/wx_vf_common.h |  14 +
>   .../net/ethernet/wangxun/libwx/wx_vf_lib.c    | 280 ++++++++++++++++++
>   .../net/ethernet/wangxun/libwx/wx_vf_lib.h    |  14 +
>   9 files changed, 562 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
>   create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
>   create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
>   create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h
> 

[...]

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.h b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
> index c523ef3e8502..e863a74c291d 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
> @@ -14,6 +14,7 @@
>   #define WX_VXMRQC                0x78
>   #define WX_VXICR                 0x100
>   #define WX_VXIMS                 0x108
> +#define WX_VXIMC                 0x10C
>   #define WX_VF_IRQ_CLEAR_MASK     7
>   #define WX_VF_MAX_TX_QUEUES      4
>   #define WX_VF_MAX_RX_QUEUES      4
> @@ -22,6 +23,12 @@
>   #define WX_VXRXDCTL_ENABLE       BIT(0)
>   #define WX_VXTXDCTL_FLUSH        BIT(26)
>   
> +#define WX_VXITR(i)              (0x200 + (4 * (i))) /* i=[0,1] */
> +#define WX_VXITR_MASK            GENMASK(8, 0)
> +#define WX_VXITR_CNT_WDIS        BIT(31)
> +#define WX_VXIVAR_MISC           0x260
> +#define WX_VXIVAR(i)             (0x240 + (4 * (i))) /* i=[0,3] */
> +
>   #define WX_VXRXDCTL_RSCMAX(f)    FIELD_PREP(GENMASK(24, 23), f)
>   #define WX_VXRXDCTL_BUFLEN(f)    FIELD_PREP(GENMASK(6, 1), f)
>   #define WX_VXRXDCTL_BUFSZ(f)     FIELD_PREP(GENMASK(11, 8), f)
> @@ -44,6 +51,49 @@
>   #define WX_RX_HDR_SIZE           256
>   #define WX_RX_BUF_SIZE           2048
>   
> +#define WX_RXBUFFER_2048         (2048)

extra parentheses are not needed

> +#define WX_RXBUFFER_3072         3072
> +
> +/* Receive Path */
> +#define WX_VXRDBAL(r)            (0x1000 + (0x40 * (r)))
> +#define WX_VXRDBAH(r)            (0x1004 + (0x40 * (r)))
> +#define WX_VXRDT(r)              (0x1008 + (0x40 * (r)))
> +#define WX_VXRDH(r)              (0x100C + (0x40 * (r)))

[...]


