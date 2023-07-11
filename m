Return-Path: <netdev+bounces-16709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D761274E79F
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC841C20B57
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 07:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F66D171A4;
	Tue, 11 Jul 2023 07:01:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80614AA2
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 07:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA3AC433C7;
	Tue, 11 Jul 2023 07:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689058895;
	bh=ylgZqNCeTVzlApRgVQ3zHo7lQbPJsuaEspCfRZBELx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6FCpqB3IW7pcB+8D70EvUt51N3HXBKrZZBrC1wUKy4vJLWF5XQ/6gggNngGj9VN1
	 sq1uzwGTgc+o9hlXybGTXrx6VH6HHfAc7TwCezXzmtGznLsdaLM4ZusXLrrQzd2Joj
	 kwoimjHPGJjK1uXgJErRklHSOy/LManblQtW4tRsh1jHzNgF60ZT5o6q81zX5FZqVa
	 iKiiVaGsl34Shth0U0+eX0aviqF0ejiLOL2bCrlhQ1xHpCwEaTkds6N5hBB3Ibi7pu
	 PVM7YhuWwM9A6rKveH6AU7GTwiR3UWWTipQgoxhO3Xcsgn4JpH9z+ymWiDQR/lL+kr
	 n2ZH1btIswDzA==
Date: Tue, 11 Jul 2023 10:01:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Florian Kauer <florian.kauer@linutronix.de>, kurt@linutronix.de,
	vinicius.gomes@intel.com, muhammad.husaini.zulkifli@intel.com,
	tee.min.tan@linux.intel.com, aravindhan.gunasekaran@intel.com,
	sasha.neftin@intel.com, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net 1/6] igc: Rename qbv_enable to taprio_offload_enable
Message-ID: <20230711070130.GC41919@unreal>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
 <20230710163503.2821068-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710163503.2821068-2-anthony.l.nguyen@intel.com>

On Mon, Jul 10, 2023 at 09:34:58AM -0700, Tony Nguyen wrote:
> From: Florian Kauer <florian.kauer@linutronix.de>
> 
> In the current implementation the flags adapter->qbv_enable
> and IGC_FLAG_TSN_QBV_ENABLED have a similar name, but do not
> have the same meaning. The first one is used only to indicate
> taprio offload (i.e. when igc_save_qbv_schedule was called),
> while the second one corresponds to the Qbv mode of the hardware.
> However, the second one is also used to support the TX launchtime
> feature, i.e. ETF qdisc offload. This leads to situations where
> adapter->qbv_enable is false, but the flag IGC_FLAG_TSN_QBV_ENABLED
> is set. This is prone to confusion.
> 
> The rename should reduce this confusion. Since it is a pure
> rename, it has no impact on functionality.

And shouldn't be sent to net, but to net-next.

Thanks

> 
> Fixes: e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      | 2 +-
>  drivers/net/ethernet/intel/igc/igc_main.c | 6 +++---
>  drivers/net/ethernet/intel/igc/igc_tsn.c  | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 639a50c02537..9db384f66a8e 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -191,7 +191,7 @@ struct igc_adapter {
>  	int tc_setup_type;
>  	ktime_t base_time;
>  	ktime_t cycle_time;
> -	bool qbv_enable;
> +	bool taprio_offload_enable;
>  	u32 qbv_config_change_errors;
>  	bool qbv_transition;
>  	unsigned int qbv_count;
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 281a0e35b9d1..fae534ef1c4f 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6126,16 +6126,16 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
>  
>  	switch (qopt->cmd) {
>  	case TAPRIO_CMD_REPLACE:
> -		adapter->qbv_enable = true;
> +		adapter->taprio_offload_enable = true;
>  		break;
>  	case TAPRIO_CMD_DESTROY:
> -		adapter->qbv_enable = false;
> +		adapter->taprio_offload_enable = false;
>  		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
>  
> -	if (!adapter->qbv_enable)
> +	if (!adapter->taprio_offload_enable)
>  		return igc_tsn_clear_schedule(adapter);
>  
>  	if (qopt->base_time < 0)
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index 3cdb0c988728..b76ebfc10b1d 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -37,7 +37,7 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
>  {
>  	unsigned int new_flags = adapter->flags & ~IGC_FLAG_TSN_ANY_ENABLED;
>  
> -	if (adapter->qbv_enable)
> +	if (adapter->taprio_offload_enable)
>  		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;
>  
>  	if (is_any_launchtime(adapter))
> -- 
> 2.38.1
> 
> 

