Return-Path: <netdev+bounces-244191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C185CB2097
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 06:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B475A302BA88
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 05:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082E23115B0;
	Wed, 10 Dec 2025 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nM7YOaj/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9B30F819;
	Wed, 10 Dec 2025 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765346185; cv=none; b=RyIqYx1aMIyuT1lEC5w4/BPNWslmnTMEFT6liBsrh1jPHmnw2JCjxprWx4RZjeC3Y0AKHrbxoXXlnqSEb2SRj3eTrJaXO86VKEsevgOAaoSCiXm07rS9P30UldPXNdSNdnjX5GygOrSoke7Ci6M/1wqBtJrAwNZOm8KNaH0ZuVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765346185; c=relaxed/simple;
	bh=bWlBXvYhrYrd+Ktob5uAjLyx6kTxuAxzVxzdf3ytE5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEWJRqy+AwgPBLlwB26ZLqEPGFDB28WsYrk+8V8JuaLDfuPdnZF2f1m3yKfDd4bJhKYrMT1rzgN8+veRPIeFk/vfMXw4Kk4m+tsffdLxIN+timdKKAG86tfHOSswmfEolV5AjZ3S6qHezYnAviNQ06covjq9DBKOWN2wvTiHsSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nM7YOaj/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765346184; x=1796882184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bWlBXvYhrYrd+Ktob5uAjLyx6kTxuAxzVxzdf3ytE5k=;
  b=nM7YOaj/GkZovpfX5Dg9N/PtM/GakAqNVNJZD8LH1B+qoesmmxTropzH
   eyKSKqSNrK6lMs+TO/zBd/QX2lRZUpLay/DeQvHtQbgTBlDzR1MjBYLXO
   uPTuupzTvxSZC8Vtt4EryiGMTzdmDmQQYVprhCD0xhAPL8dH3ce+cjQeP
   /Vyrd5QvlLtSjBZc47zGqRgEg6BQvfL8kosEhK3ycu/XzABTqfni0B4x5
   gRMaA5agsFauzsCYuAC7+JP/x+1zFtvhkvliY5dsD3m4/wVbqHWNLIdzT
   wWZsJB3vCp7ESikIrf06AuUtmn8p8nolnHVD+1WdqnG+oV8uWUiA6mm1o
   A==;
X-CSE-ConnectionGUID: uA/HEjS/R+e1geUAlRVejw==
X-CSE-MsgGUID: PcNw/4sZRr2OsG2H1tVa6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="89962721"
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="89962721"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 21:56:22 -0800
X-CSE-ConnectionGUID: 0bYF0JJWSZiBH2+K+bfhjA==
X-CSE-MsgGUID: F5IXYfUqTvGA/X/3jRp82w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="195682395"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 09 Dec 2025 21:56:19 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 33C4F93; Wed, 10 Dec 2025 06:56:17 +0100 (CET)
Date: Wed, 10 Dec 2025 06:56:17 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: david.laight.linux@gmail.com
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@netronome.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 2/9] thunderblot: Don't pass a bitfield to FIELD_GET
Message-ID: <20251210055617.GD2275908@black.igk.intel.com>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
 <20251209100313.2867-3-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251209100313.2867-3-david.laight.linux@gmail.com>

$subject has typo: thunderblot -> thunderbolt ;-)

On Tue, Dec 09, 2025 at 10:03:06AM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> FIELD_GET needs to use __auto_type to get the value of the 'reg'
> parameter, this can't be used with bifields.
> 
> FIELD_GET also want to verify the size of 'reg' so can't add zero
> to force the type to int.
> 
> So add a zero here.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  drivers/thunderbolt/tb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index e96474f17067..7ca2b5a0f01e 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -1307,7 +1307,7 @@ static inline struct tb_retimer *tb_to_retimer(struct device *dev)
>   */
>  static inline unsigned int usb4_switch_version(const struct tb_switch *sw)
>  {
> -	return FIELD_GET(USB4_VERSION_MAJOR_MASK, sw->config.thunderbolt_version);
> +	return FIELD_GET(USB4_VERSION_MAJOR_MASK, sw->config.thunderbolt_version + 0);

Can't this use a cast instead? If not then can you also add a comment here
because next someone will send a patch "fixing" the unnecessary addition.

>  }
>  
>  /**
> -- 
> 2.39.5

