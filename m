Return-Path: <netdev+bounces-41803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0B77CBEB2
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6777B21056
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AC63F4B0;
	Tue, 17 Oct 2023 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPeI5XqQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4AD27721;
	Tue, 17 Oct 2023 09:14:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602EC8E;
	Tue, 17 Oct 2023 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534081; x=1729070081;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5hJ1MOTyviSW3cZFQ1/6LAEsLb2tBCjZ2qHZ6qLypPU=;
  b=GPeI5XqQVBZOvT8zyzLJO/bJ7Hnlm+DI8VvieFJYQMxA/CjFkDj+elJV
   xF1tAoVOK4gqYlvXGJCRbzNV17u8CuIJp7bPhR+A6O9LkW8IkVWgFbn6y
   9rEdaS9KKDZLX/yHxpYKPilPBaEXxNcBvI1a/8svivdIjCMVNiVcpHweL
   AyRez3cpm7rbUsNSDPtPy9lmPk9rlzbSgQDNSJf9+AHsnRsE358WWRURE
   DoONlBvAczW7TJZJ0krX/xx5IuxKkjdtGi/B1FyPQmFJwGpUM6MPg0gEn
   0IWRt7eNNiPf6L4CZWVda4WLtQDUi5cr7/YNMhzEZZzYo18a2eNaHo20c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="416820961"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="416820961"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="3851348"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.44.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:13:27 -0700
Date: Tue, 17 Oct 2023 12:14:30 +0300 (EEST)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Ma Jun <Jun.Ma2@amd.com>
cc: amd-gfx@lists.freedesktop.org, lenb@kernel.org, johannes@sipsolutions.net, 
    davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
    pabeni@redhat.com, alexander.deucher@amd.com, Lijo.Lazar@amd.com, 
    mario.limonciello@amd.com, majun@amd.com, netdev@vger.kernel.org, 
    linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    Evan Quan <quanliangl@hotmail.com>
Subject: Re: [PATCH v12 3/9] cfg80211: expose nl80211_chan_width_to_mhz for
 wide sharing
In-Reply-To: <20231017025358.1773598-4-Jun.Ma2@amd.com>
Message-ID: <92dde569-3919-15e-b714-4eb8fbc73eae@linux.intel.com>
References: <20231017025358.1773598-1-Jun.Ma2@amd.com> <20231017025358.1773598-4-Jun.Ma2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 17 Oct 2023, Ma Jun wrote:

> From: Evan Quan <quanliangl@hotmail.com>
> 
> The newly added WBRF feature needs this interface for channel
> width calculation.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> Signed-off-by: Evan Quan <quanliangl@hotmail.com>
> 
> --
> v8->v9:
>   - correct typo(Mhz -> MHz) (Johnson)
> ---
>  include/net/cfg80211.h | 8 ++++++++
>  net/wireless/chan.c    | 3 ++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index d6fa7c8767ad..026d91083f37 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -923,6 +923,14 @@ const struct cfg80211_chan_def *
>  cfg80211_chandef_compatible(const struct cfg80211_chan_def *chandef1,
>  			    const struct cfg80211_chan_def *chandef2);
>  
> +/**
> + * nl80211_chan_width_to_mhz - get the channel width in MHz
> + * @chan_width: the channel width from &enum nl80211_chan_width
> + * Return: channel width in MHz if the chan_width from &enum nl80211_chan_width
> + * is valid. -1 otherwise.

Add empty line before Return:

> + */
> +int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width);
> +
>  /**
>   * cfg80211_chandef_valid - check if a channel definition is valid
>   * @chandef: the channel definition to check
> diff --git a/net/wireless/chan.c b/net/wireless/chan.c
> index 0b7e81db383d..227db04eac42 100644
> --- a/net/wireless/chan.c
> +++ b/net/wireless/chan.c
> @@ -141,7 +141,7 @@ static bool cfg80211_edmg_chandef_valid(const struct cfg80211_chan_def *chandef)
>  	return true;
>  }
>  
> -static int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
> +int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
>  {
>  	int mhz;
>  
> @@ -190,6 +190,7 @@ static int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
>  	}
>  	return mhz;
>  }
> +EXPORT_SYMBOL(nl80211_chan_width_to_mhz);
>  
>  static int cfg80211_chandef_get_width(const struct cfg80211_chan_def *c)
>  {
> 

-- 
 i.


