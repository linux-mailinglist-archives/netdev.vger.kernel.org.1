Return-Path: <netdev+bounces-230800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A91BABEFA85
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 934DC4E1A94
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 07:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E331A2C08D5;
	Mon, 20 Oct 2025 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="toFN0IKM"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B887354AE8;
	Mon, 20 Oct 2025 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945025; cv=none; b=rLGAdFd3D7sMJgdiqO/SXdCokrBt1MxScRt+MkpbV3o114aZz9UGYzJNxz3x5d0SEqZws5GShOc+Mfu0k8sdS4we6lGXpkT3mNSgUfb3a5yaPrPOCbmE199DfM64w/OPQzb22EBS+K45Vf0ZMv+D1f3mw9czwofQyaSkaqhdN6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945025; c=relaxed/simple;
	bh=5o78rylKRX0/yU4lfmztzJpE+BWtXEbfN+wqWJfrF5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jHnHF0TT0jEaeUavLFyZmM0ReikHDAztHwuv2qotTB4ozfGiR12lUPWgVAnky5tyzJd+jxZG1ndB9Qxd6Mni/pN1LMfEKTMFIZ9BprlJ6zbb8+qVwzWk+9ns/D7omwmHJI9MqBlbZa6uglqS9HsW0gb81SNHUaOtQAdTyCi47wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=toFN0IKM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1760945024; x=1792481024;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5o78rylKRX0/yU4lfmztzJpE+BWtXEbfN+wqWJfrF5M=;
  b=toFN0IKM9yukVXLwAcesM0wwhrdDHX2QIRiDdk+f4RhA625H5gWYEHop
   6XD/CPEtFcBDm4TKKyMYHIsUovPED03/nZUjfNuEykJmrBKg14jV0xU3o
   VRVtqTC68Sy9m+f758aL5SlI3Pt1Knr4rETfyfQ+lm8WbJfCxtkR0wPLi
   PNQri4DSb26+Vf7JOQM6OGQ37hIulRLtuVzPmGWpo0WYuHzZt8l7IZcdi
   V2TWa5WCe0iTpSwOJGCG0y7gYy5hcS/OcHIZ9HC8Iet1eiXlX+yJFwmHc
   CAG9rwwFq9d6i0kk4MonuC2lD2/PrePy5GLsnjFJLdN1DNW9OjdHE8pD4
   g==;
X-CSE-ConnectionGUID: syLohhXcRWmxQ5Yx+26ZSw==
X-CSE-MsgGUID: U3LNmo/gQpu7y77ep3kveQ==
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="48498060"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2025 00:23:43 -0700
Received: from chn-vm-ex3.mchp-main.com (10.10.87.32) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 20 Oct 2025 00:23:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.27; Mon, 20 Oct 2025 00:23:18 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 20 Oct 2025 00:23:16 -0700
Message-ID: <602279c8-2e37-4ddc-8569-7f2bae944438@microchip.com>
Date: Mon, 20 Oct 2025 09:23:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] net: macb: Remove duplicate linux/inetdevice.h
 header
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC: <claudiu.beznea@tuxon.dev>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abaci Robot <abaci@linux.alibaba.com>
References: <20251020014441.2070356-1-jiapeng.chong@linux.alibaba.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20251020014441.2070356-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 20/10/2025 at 03:44, Jiapeng Chong wrote:
> ./drivers/net/ethernet/cadence/macb_main.c: linux/inetdevice.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=26474
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/net/ethernet/cadence/macb_main.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 214f543af3b8..39673f5c3337 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -14,7 +14,6 @@
>   #include <linux/etherdevice.h>
>   #include <linux/firmware/xlnx-zynqmp.h>
>   #include <linux/inetdevice.h>
> -#include <linux/inetdevice.h>
>   #include <linux/init.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
> --
> 2.43.5
> 


