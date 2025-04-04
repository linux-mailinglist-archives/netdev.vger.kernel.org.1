Return-Path: <netdev+bounces-179241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA619A7B827
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 09:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3AF3B8EED
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 07:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F101891AA;
	Fri,  4 Apr 2025 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HL0Fp/Ha"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C417A31F;
	Fri,  4 Apr 2025 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743750916; cv=none; b=q5Q4hVBaVgXMet8hVUt96qYmbRD7bzaCQrY/GqG1Bti6NR5Doiz7ZDKjV+GpuWA9Gk+ceCopwXRPL65NYvlQKG0h08MCBFKQ350dchyCJmE/ukAnrV5Q5mKnm+hpPY4PPHNLrnoVJQk7+X/478lm7W4Bxr4Vz/Huqr1d7+V69t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743750916; c=relaxed/simple;
	bh=XlZUyusEwbUmomwwZk/AGdKmRc5G5Oj19N7ritsx424=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLJEfkwQjr0BxNfVnwAydJZeZ00g9dZeEz9f3Hb8LHgOR/GBGd1M3k4iKJtqD6SFC9YXGkrBAXVa9zM5Q1Pkky3CZbJ7+ykwu3gqcSyWnDPKOHnryF5UZ2vUNpCw63qnPNg2YHhRCIOc9tOo8cNxg3EQjO8jGMssy34YRJf6dbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HL0Fp/Ha; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743750914; x=1775286914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XlZUyusEwbUmomwwZk/AGdKmRc5G5Oj19N7ritsx424=;
  b=HL0Fp/Hay29YIu10RlYcosSdwj8lijzHWKkqxrPlC3/YcIaPunPMOHTc
   bu1y5cQkoxl1DQkqaPLWxKW8/yMWr14kzycTM/CVbbMrjW+PFbYrynMyz
   VP4oNpMc9N4sGZbEsemV12J4jLIlxOkPViKtp6jUhr7c8YP1EVzGgAwSA
   2yxERfVBAQwBgqheWRe/pjYfS+/m9CHU7PIvVArahW4ywPmFTeXN9LhCa
   jPYTpGhnaNPJ0CbhoIJhKlLp/AjjFQSdhmnQL/L3AnOgYsNxcJdRMVKDh
   sJR8Ir1yLOStd21Nr/qNPNt0pii3yJo0Bwv4EA1kLWivCrkVvSz+k1AOC
   w==;
X-CSE-ConnectionGUID: AdQDj8/qSkiplD3uhxOlng==
X-CSE-MsgGUID: N+RJ4mkHQAGE5soGK4Nq8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="67655606"
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="67655606"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 00:15:13 -0700
X-CSE-ConnectionGUID: QLD+AsDsSUiqGbNvkRR6vw==
X-CSE-MsgGUID: hoXfZcudSGmeWSTjO2TSKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="127130582"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 00:15:11 -0700
Date: Fri, 4 Apr 2025 09:14:57 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: m.chetan.kumar@intel.com, loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: wwan: Add error handling for
 ipc_mux_dl_acb_send_cmds().
Message-ID: <Z++G8b6DBd3uCd1x@mev-dev.igk.intel.com>
References: <20250403084800.2247-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403084800.2247-1-vulab@iscas.ac.cn>

On Thu, Apr 03, 2025 at 04:48:00PM +0800, Wentao Liang wrote:
> The ipc_mux_dl_acbcmd_decode() calls the ipc_mux_dl_acb_send_cmds(),
> but does not report the error if ipc_mux_dl_acb_send_cmds() fails.
> This makes it difficult to detect command sending failures. A proper
> implementation can be found in ipc_mux_dl_cmd_decode().
> 
> Add error reporting to the call, logging an error message using dev_err()
> if the command sending fails.
> 
> Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> index bff46f7ca59f..478c9c8b638b 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> @@ -509,8 +509,11 @@ static void ipc_mux_dl_acbcmd_decode(struct iosm_mux *ipc_mux,
>  			return;
>  			}
>  		trans_id = le32_to_cpu(cmdh->transaction_id);
> -		ipc_mux_dl_acb_send_cmds(ipc_mux, cmd, cmdh->if_id,
> -					 trans_id, cmd_p, size, false, true);
> +		if (ipc_mux_dl_acb_send_cmds(ipc_mux, cmd, cmdh->if_id,
> +					     trans_id, cmd_p, size, false, true))
> +			dev_err(ipc_mux->dev,
> +				"if_id %d: cmd send failed",
> +				cmdh->if_id);

Shouldn't it go to the net-next? It isn't fixing anything, just adding
error message.

>  	}
>  }
>  
> -- 
> 2.42.0.windows.2

