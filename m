Return-Path: <netdev+bounces-47736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F57EB139
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 14:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92DFCB20A12
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4AC405CF;
	Tue, 14 Nov 2023 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnAHubb5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6774405CD
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 13:52:17 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A801A1
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 05:52:15 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507bd644a96so8086956e87.3
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 05:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699969934; x=1700574734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j757N9wl2OC9S0nDdSseR3c4Ld+DiVkQ7HuzMo3m75Q=;
        b=QnAHubb5AOxHa7gbJGe903NOBGUKaW4WvAj2L/dAgaBWuV5BfJoBqnJa0Dh9I2WjMa
         UGeeyD+PvYbHRX4uwUsXfwyqkxn4bmBq9mTFpvolSTesXtSdS1brVDghHruHztrWVYe1
         4lBRtDGMWFrbIftFZ3nRQHMl7w0Im5otEgIMD1agnHvKFZ6/miwYpIL3KrD8nAHODsIh
         iw9aBXxKHt3VdZ2SHlHT51hD4Sj4p9NS7CIG1axq0Xh3Ypi8jtYjUBqgxNDJu1upZ6x1
         ZAL7+1vw9QAlpYVDT7RaGgUXKrE3kkugvep1LVfo59X0fTFziqv0A6lHSeSdTk/dEPpy
         w0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699969934; x=1700574734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j757N9wl2OC9S0nDdSseR3c4Ld+DiVkQ7HuzMo3m75Q=;
        b=Mee1QmRhjIaxziRPlIlsP0sNbyDs82LopaX0c6WSRWQMfxqN01yANYGbi30oPTPkpu
         AlaCH02Bnx7gluUmkzYQmxsgAg2erug+76SHU1yGS2Qqb8tN6Xd7xikvw/Of8/L36CMH
         dJOXdk9/DHycKArV+Q3LVknjWlW4D8DwFG87nNIkgiccmX4VkxKhzPenerxUokVBw8sp
         Q/+4I1QuOxGuDGQ3G+sxruYMHtnQ05zXa1wqL566xgomh8GlV2J9+qX79aXdr9AoKX2U
         uaT4IhkJFjLqEwUTy4Jgklo+fTK0ysSDKs8aNcMY6MUWMpev4Vqy9yldQJ7PNXTdhFuP
         M/vg==
X-Gm-Message-State: AOJu0YzVZODgFgQvpYgXnFnxUOOCo3N+iGHeRvu47j4dgoUddFWmOwAd
	wDf4yZl4/XfibKQF2JlP2bQ=
X-Google-Smtp-Source: AGHT+IH+04Ch+9kgm6dAVSo7aGbw26wa30Ipxu0PNeFpJ35bUOf3NQzVs8clX8L5DUeqviqV4eG/UQ==
X-Received: by 2002:a05:6512:3251:b0:50a:71d8:c94f with SMTP id c17-20020a056512325100b0050a71d8c94fmr6239613lfr.60.1699969933332;
        Tue, 14 Nov 2023 05:52:13 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id i12-20020a056512340c00b00505677e7a99sm1345393lfr.139.2023.11.14.05.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 05:52:12 -0800 (PST)
Date: Tue, 14 Nov 2023 16:52:11 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: reduce dma ring display
 code duplication
Message-ID: <qw2ymgim7ikxmgyznzdh7acf66rm62gqdkqnjpshgksdqkdar5@52gef7yifpfg>
References: <8e3121170d479cbe095f985e01fc5e0386f2afff.1699945390.git.baruch@tkos.co.il>
 <27ad91b102bf9555e61bb1013672c2bc558e97b9.1699945390.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27ad91b102bf9555e61bb1013672c2bc558e97b9.1699945390.git.baruch@tkos.co.il>

On Tue, Nov 14, 2023 at 09:03:10AM +0200, Baruch Siach wrote:
> The code to show extended descriptor is identical to normal one.
> Consolidate the code to remove duplication.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2: Fix extended descriptor case, and properly test both cases
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 25 +++++++------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 39336fe5e89d..cf818a2bc9d5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6182,26 +6182,19 @@ static void sysfs_display_ring(void *head, int size, int extend_desc,
>  	int i;
>  	struct dma_extended_desc *ep = (struct dma_extended_desc *)head;
>  	struct dma_desc *p = (struct dma_desc *)head;

> +	unsigned long desc_size = extend_desc ? sizeof(*ep) : sizeof(*p);

From readability point of view it's better to keep the initializers as
simple as possible: just type casts or container-of-based inits. The
more complex init-statements including the ternary-based ones is better to
move to the code section closer to the place of the vars usage. So could
you please move the initialization statement from the vars declaration
section to being performed right before the loop entrance? It shall
improve the readability a tiny bit.

>  	dma_addr_t dma_addr;
>  
>  	for (i = 0; i < size; i++) {
> -		if (extend_desc) {
> -			dma_addr = dma_phy_addr + i * sizeof(*ep);
> -			seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
> -				   i, &dma_addr,
> -				   le32_to_cpu(ep->basic.des0),
> -				   le32_to_cpu(ep->basic.des1),
> -				   le32_to_cpu(ep->basic.des2),
> -				   le32_to_cpu(ep->basic.des3));
> -			ep++;
> -		} else {
> -			dma_addr = dma_phy_addr + i * sizeof(*p);
> -			seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
> -				   i, &dma_addr,
> -				   le32_to_cpu(p->des0), le32_to_cpu(p->des1),
> -				   le32_to_cpu(p->des2), le32_to_cpu(p->des3));
> +		dma_addr = dma_phy_addr + i * desc_size;
> +		seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
> +				i, &dma_addr,
> +				le32_to_cpu(p->des0), le32_to_cpu(p->des1),
> +				le32_to_cpu(p->des2), le32_to_cpu(p->des3));
> +		if (extend_desc)
> +			p = &(++ep)->basic;
> +		else
>  			p++;
> -		}
>  	}

If I were simplifying/improving things I would have done it in the
next way:

static void stmmac_display_ring(void *head, int size, int extend_desc,
			       struct seq_file *seq, dma_addr_t dma_addr)
{
        struct dma_desc *p;
	size_t desc_size;
	int i;

	if (extend_desc)
		desc_size = sizeof(struct dma_extended_desc);
	else
		desc_size = sizeof(struct dma_desc);

	for (i = 0; i < size; i++) {
		if (extend_desc)
			p = &((struct dma_extended_desc *)head)->basic;
		else
			p = head;

		seq_printf(seq, "%d [%pad]: 0x%08x 0x%08x 0x%08x 0x%08x\n",
			   i, &dma_addr,
			   le32_to_cpu(p->des0), le32_to_cpu(p->des1),
			   le32_to_cpu(p->des2), le32_to_cpu(p->des3));

		dma_addr += desc_size;
		head += desc_size;
	}
}

1. Add 0x%08x format to have the aligned data printout.
2. Use the desc-size to increment the virt and phys addresses for
unification.
3. Replace sysfs_ prefix with stmmac_ since the method is no longer
used for sysfs node.

On the other hand having the extended data printed would be also
useful at the very least for the Rx descriptors, which expose VLAN,
Timestamp and IPvX related info. Extended Tx descriptors have only the
timestamp in the extended part.

-Serge(y)

>  }
>  
> -- 
> 2.42.0
> 
> 

