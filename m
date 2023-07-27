Return-Path: <netdev+bounces-22014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861F5765B24
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6A81C21626
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BA8171B6;
	Thu, 27 Jul 2023 18:05:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68C62714D
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:05:08 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FD630F4
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 11:05:03 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-403aa5d07caso8336071cf.0
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 11:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690481103; x=1691085903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OC6LiCa1YC9xI+BK2/ZHlr7e4fbtV+mi6QcbdwKO5a0=;
        b=CoeAU74m+ZojIKG8qcyzSkwjx2x6UVK0ekDSDx6+W6AaCJIbl95h8g5PgSHU8Q4GgA
         +Ywq3KekH649qYCeOBpBnYjKTThtavqGqiAlP7ywi1L5WszVOGHFaKG7QyoqRHk4j0aA
         4tKcLHfu+iywdk/DneA8YSS2xtz7lRVzanMP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690481103; x=1691085903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OC6LiCa1YC9xI+BK2/ZHlr7e4fbtV+mi6QcbdwKO5a0=;
        b=NPWOyWS+oXPnsg6aZOWBkqzvsv2EQFsvNrILTIclfsHBxqXb5W+A6eMPaSULJyNIVP
         IXFb+rN//Jb1n4+3jDKb57EiXGc6df6O4EL/X1Kuc+z/3p4urRuLLqaWhUZ0Go8UM7zV
         dNUp78tqcVoHWuMQ53PB0lCkVQvWx/mFq36xi2sIPGOaQ9BJh3rgsWiGGHSNOjWXYKmu
         v1B6BiSwqzGGRkDsL3j4n/0mmmGmUxOEN17G5Zb1m5Ezf3mESwk+onWIiPAuZSC/Leu2
         oLNCwFsaxYUCtSZFirUVTccg3GXQ0K8UC3gNm6/UWOOG8Ia/KPUnrSKl4eB6rncYRm7b
         VR3A==
X-Gm-Message-State: ABy/qLZbVkl+qjJaQOjnFxY6y7CgRVhNx3+X6xCgUTSXIJAie7cVqjmv
	cIhKfMf2hDKWcyY27ItIwTQf2Q==
X-Google-Smtp-Source: APBJJlGAy7s5jAqThFClaYo0QRv7f3IKbNXj+dEQeN6unT+doVRq00I7m49gkTWhY2aM7Xmj5127VQ==
X-Received: by 2002:ac8:5a85:0:b0:403:bfda:acb4 with SMTP id c5-20020ac85a85000000b00403bfdaacb4mr300493qtc.11.1690481103072;
        Thu, 27 Jul 2023 11:05:03 -0700 (PDT)
Received: from C02YVCJELVCG ([136.54.24.230])
        by smtp.gmail.com with ESMTPSA id w16-20020a05622a135000b00403ff38d855sm592322qtk.4.2023.07.27.11.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 11:05:02 -0700 (PDT)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Thu, 27 Jul 2023 14:04:55 -0400
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, michael.chan@broadcom.com
Subject: Re: [PATCH net] bnxt: don't handle XDP in netpoll
Message-ID: <ZMKxx6sQgVdCE_JH@C02YVCJELVCG>
References: <20230727170505.1298325-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727170505.1298325-1-kuba@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 10:05:05AM -0700, Jakub Kicinski wrote:
> Similarly to other recently fixed drivers make sure we don't
> try to access XDP or page pool APIs when NAPI budget is 0.
> NAPI budget of 0 may mean that we are in netpoll.
> 
> This may result in running software IRQs in hard IRQ context,
> leading to deadlocks or crashes.
> 
> Fixes: 322b87ca55f2 ("bnxt_en: add page_pool support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>

> ---
> CC: michael.chan@broadcom.com
> CC: gospo@broadcom.com
> 
> Side note - having to plumb the "budget" everywhere really makes
> me wonder if we shouldn't have had those APIs accept a pointer
> to napi_struct instead :S

We could also consider adding budget to struct bnxt_napi.  I'm not sure that
would work in all cases, however.

I'm good if this goes in as-is and we make enhancements from this as a starting
point.

> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 19 +++++++++++--------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  6 +++++-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  3 ++-
>  4 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index a3bbd13c070f..fe1d645c39d0 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -687,7 +687,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
>  
> -static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
> +static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts,
> +			int budget)
>  {
>  	struct bnxt_tx_ring_info *txr = bnapi->tx_ring;
>  	struct netdev_queue *txq = netdev_get_tx_queue(bp->dev, txr->txq_index);
> @@ -2595,10 +2596,11 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  	return rx_pkts;
>  }
>  
> -static void __bnxt_poll_work_done(struct bnxt *bp, struct bnxt_napi *bnapi)
> +static void __bnxt_poll_work_done(struct bnxt *bp, struct bnxt_napi *bnapi,
> +				  int budget)
>  {
>  	if (bnapi->tx_pkts && !bnapi->tx_fault) {
> -		bnapi->tx_int(bp, bnapi, bnapi->tx_pkts);
> +		bnapi->tx_int(bp, bnapi, bnapi->tx_pkts, budget);
>  		bnapi->tx_pkts = 0;
>  	}
>  
> @@ -2629,7 +2631,7 @@ static int bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  	 */
>  	bnxt_db_cq(bp, &cpr->cp_db, cpr->cp_raw_cons);
>  
> -	__bnxt_poll_work_done(bp, bnapi);
> +	__bnxt_poll_work_done(bp, bnapi, budget);
>  	return rx_pkts;
>  }
>  
> @@ -2760,7 +2762,7 @@ static int __bnxt_poll_cqs(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
>  }
>  
>  static void __bnxt_poll_cqs_done(struct bnxt *bp, struct bnxt_napi *bnapi,
> -				 u64 dbr_type)
> +				 u64 dbr_type, int budget)
>  {
>  	struct bnxt_cp_ring_info *cpr = &bnapi->cp_ring;
>  	int i;
> @@ -2776,7 +2778,7 @@ static void __bnxt_poll_cqs_done(struct bnxt *bp, struct bnxt_napi *bnapi,
>  			cpr2->had_work_done = 0;
>  		}
>  	}
> -	__bnxt_poll_work_done(bp, bnapi);
> +	__bnxt_poll_work_done(bp, bnapi, budget);
>  }
>  
>  static int bnxt_poll_p5(struct napi_struct *napi, int budget)
> @@ -2806,7 +2808,8 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
>  			if (cpr->has_more_work)
>  				break;
>  
> -			__bnxt_poll_cqs_done(bp, bnapi, DBR_TYPE_CQ_ARMALL);
> +			__bnxt_poll_cqs_done(bp, bnapi, DBR_TYPE_CQ_ARMALL,
> +					     budget);
>  			cpr->cp_raw_cons = raw_cons;
>  			if (napi_complete_done(napi, work_done))
>  				BNXT_DB_NQ_ARM_P5(&cpr->cp_db,
> @@ -2836,7 +2839,7 @@ static int bnxt_poll_p5(struct napi_struct *napi, int budget)
>  		}
>  		raw_cons = NEXT_RAW_CMP(raw_cons);
>  	}
> -	__bnxt_poll_cqs_done(bp, bnapi, DBR_TYPE_CQ);
> +	__bnxt_poll_cqs_done(bp, bnapi, DBR_TYPE_CQ, budget);
>  	if (raw_cons != cpr->cp_raw_cons) {
>  		cpr->cp_raw_cons = raw_cons;
>  		BNXT_DB_NQ_P5(&cpr->cp_db, raw_cons);
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 9d16757e27fe..bd44a5701e5f 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -1005,7 +1005,7 @@ struct bnxt_napi {
>  	struct bnxt_tx_ring_info	*tx_ring;
>  
>  	void			(*tx_int)(struct bnxt *, struct bnxt_napi *,
> -					  int);
> +					  int tx_pkts, int budget);
>  	int			tx_pkts;
>  	u8			events;
>  	u8			tx_fault:1;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index 5b6fbdc4dc40..33b7eddfbf41 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -125,7 +125,8 @@ static void __bnxt_xmit_xdp_redirect(struct bnxt *bp,
>  	dma_unmap_len_set(tx_buf, len, 0);
>  }
>  
> -void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
> +void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts,
> +		     int budget)
>  {
>  	struct bnxt_tx_ring_info *txr = bnapi->tx_ring;
>  	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
> @@ -135,6 +136,9 @@ void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
>  	u16 last_tx_cons = tx_cons;
>  	int i, j, frags;
>  
> +	if (!budget)
> +		return;
> +
>  	for (i = 0; i < nr_pkts; i++) {
>  		tx_buf = &txr->tx_buf_ring[tx_cons];
>  
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> index ea430d6961df..3ab47ae2f26d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> @@ -16,7 +16,8 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
>  				   struct bnxt_tx_ring_info *txr,
>  				   dma_addr_t mapping, u32 len,
>  				   struct xdp_buff *xdp);
> -void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts);
> +void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts,
> +		     int budget);
>  bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
>  		 struct xdp_buff xdp, struct page *page, u8 **data_ptr,
>  		 unsigned int *len, u8 *event);
> -- 
> 2.41.0
> 

