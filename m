Return-Path: <netdev+bounces-31440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7AA78D7EA
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 20:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D801C2074E
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 18:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2487482;
	Wed, 30 Aug 2023 18:05:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A72A6FCE
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 18:05:22 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1DF193
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 11:05:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so52568005e9.1
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 11:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693418719; x=1694023519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pxSxZK+cydiyq7TuJRv2JD7a7JTjjTDLSJtNyIfzrNA=;
        b=U3qhDrwzepdn9jVPY/wAj7VHHi/jHqBrMHS2QeCFrQ3xoUOaeu9BnFsUQ7jabPEgGe
         rAnuZZ8fhTQ53FLqe+2ROZSBEWB+g36UMXCDVyEDVFTXb63G+uoH1qM/xlnebhCJ2mcs
         Wq46UqyJpxPy8yAxoBGgvPCDK0RFQfGHnlVEnAA0CG2+cwPSrBdb437nQ0jQ2liZhDlb
         Rlw6fe856T9N7xsvVUafmQhKfglWl7DAWQIac+5Fjozb11X7a3hLuPBgTX9f6VZPlJh9
         y+ZOvQa+v6tdA1jw5NNWeXTMCt335Q7P+6cEabhYk80F1Suir2ccROd5stOC30P0/Wqw
         y1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693418719; x=1694023519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxSxZK+cydiyq7TuJRv2JD7a7JTjjTDLSJtNyIfzrNA=;
        b=H9C22cIkHYq5kuGVa4/1A45MtsAkfOHz4p3N8+JTU0jIHG7XOe/mQNGecRdGE9/7nt
         /l+l1d8UQeBkGTFSIylvqPzJ+WZi2cjvk3z1k5EUit6BDadUaymSS3RQ/ixCHLP7LIxR
         yZ+wfXacyRP7qIdrFfFaEKmyCvGecDOB6LHoJ5R6EbYdEjV/cmBXztRacrumDXWlrTxG
         wmbhAF19dvpl33X/ka6phmpxGBtKTanMMAItaedsys/2dI0TRF7vBjtgpkg90QPALaMT
         nsh5ZcBytaSybxSZdZaH8lqfhEk5X5ULGNJfed5tS8LXcicqPw4a59vnBDI9OO02HdSR
         dAwQ==
X-Gm-Message-State: AOJu0YysOjI/FaosPF2S+RU395cxyJqQ1sKVDDXMo7VtJQvjzcjSDQn/
	NXOPXbxmJ8HPwJ9kjmaA38U=
X-Google-Smtp-Source: AGHT+IFdBsd9+9jaYRxhNRCZ7EUvP3jOjqb8HJVRlZmgAmaxHpa2DAZMOGcceg5tusZO7pU2A5HT6Q==
X-Received: by 2002:a5d:69ce:0:b0:31c:7001:3873 with SMTP id s14-20020a5d69ce000000b0031c70013873mr1984980wrw.60.1693418719040;
        Wed, 30 Aug 2023 11:05:19 -0700 (PDT)
Received: from localhost ([23.154.177.4])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d6503000000b00317c742ca9asm17175117wru.43.2023.08.30.11.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 11:05:18 -0700 (PDT)
Date: Wed, 30 Aug 2023 21:05:15 +0300
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Vincent Whitchurch <Vincent.Whitchurch@axis.com>
Cc: "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
	"nbd@nbd.name" <nbd@nbd.name>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>,
	"peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	kernel <kernel@axis.com>
Subject: Re: [PATCH net] net: stmmac: Use hrtimer for TX coalescing
Message-ID: <ZO-E2_A-UrC9127S@mail.gmail.com>
References: <20201120150208.6838-1-vincent.whitchurch@axis.com>
 <732f3c01-a36f-4c9b-8273-a55aba9094d8@nbd.name>
 <2e1db3c654b4e76c7249e90ecf8fa9d64046cbb8.camel@axis.com>
 <a4ee2e37-6b2f-4cab-aab8-b9c46a7c1334@nbd.name>
 <f3c70b8e345a174817e6a7f38725d958f8193bf1.camel@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3c70b8e345a174817e6a7f38725d958f8193bf1.camel@axis.com>
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 30 Aug 2023 at 14:55:37 +0000, Vincent Whitchurch wrote:
> Any test results with this patch on the hardware with the performance
> problems would be appreciated.

TL/DR: it's definitely better than without the patch, but still worse
than fully reverting hrtimer [1].

OpenWrt on Netgear R7800, iperf3 test in both directions (LAN->WAN and
WAN->LAN), 3 runs for the duration of 1 minute each. OpenWrt options
packet_steering (RPS + XPS) and flow_offloading (flowtables) enabled,
irqbalance disabled.

Numbers in Mbit/s, I had to fit the table into 72 characters, so:
U is the original kernel 6.1.46 from OpenWrt, R is reverted hrtimer
(patch [1]), P is patched with the new patch from the previous email,
^ is upload (LAN->WAN), v is download (WAN->LAN).

  |  ^  |  v  |  ^  |  v  |  ^  |  v  | avg ^ | avg v | std ^ | std v
- | --- | --- | --- | --- | --- | --- | ----- | ----- | ----- | -----
U | 742 | 709 | 740 | 715 | 556 | 750 |  679  |  725  |  107  |   22
R | 931 | 938 | 935 | 939 | 935 | 939 |  934  |  939  |    2  |    1
P | 845 | 939 | 934 | 939 | 845 | 909 |  875  |  929  |   51  |   17

Full revert allows to get really close to the theoretical maximum
goodput (~949 Mbit/s) with minimal deviation. The new patch, however,
gives less stable numbers, while sometimes hits the maximum as well.

More numbers for the [U]npatched and [R]everted kernels are in the
OpenWrt thread [2].

[1]: https://github.com/openwrt/openwrt/files/12422351/revert-stmmac.patch.txt
[2]: https://github.com/openwrt/openwrt/issues/11676

> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 4727f7be4f86..4b6e5061b5a6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2703,9 +2703,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
>  
>  	/* We still have pending packets, let's call for a new scheduling */
>  	if (tx_q->dirty_tx != tx_q->cur_tx)
> -		hrtimer_start(&tx_q->txtimer,
> -			      STMMAC_COAL_TIMER(priv->tx_coal_timer[queue]),
> -			      HRTIMER_MODE_REL);
> +		stmmac_tx_timer_arm(priv, queue);
>  
>  	__netif_tx_unlock_bh(netdev_get_tx_queue(priv->dev, queue));
>  
> @@ -2987,6 +2985,20 @@ static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue)
>  {
>  	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
>  
> +	/*
> +	 * Note that the hrtimer could expire immediately after we check this,
> +	 * and the hrtimer and the callers of this function do not share a
> +	 * lock.
> +	 *
> +	 * This should however be safe since the only thing the hrtimer does is
> +	 * schedule napi (or ask for it run again if it's already running), and
> +	 * stmmac_tx_clean(), called from the napi poll function, also calls
> +	 * stmmac_tx_timer_arm() at the end if it sees that there are any TX
> +	 * packets which have not yet been cleaned.
> +	 */
> +	if (hrtimer_is_queued(&tx_q->txtimer))
> +		return;
> +
>  	hrtimer_start(&tx_q->txtimer,
>  		      STMMAC_COAL_TIMER(priv->tx_coal_timer[queue]),
>  		      HRTIMER_MODE_REL);
> 

