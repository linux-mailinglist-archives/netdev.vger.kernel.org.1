Return-Path: <netdev+bounces-173770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C352A5B9D2
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 08:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5E318945E7
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 07:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEDB221733;
	Tue, 11 Mar 2025 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eARvd6Ww"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA231EB195;
	Tue, 11 Mar 2025 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678301; cv=none; b=ECUhzEl1RxotJYT1tMQrqAPibaPNtFA/1cXI4iUn/HRAbTMa8SRxBc31JojU4HL6MqeAHmqk97Xsdfqf0Of1Ox0bs9i7QQ5DAyLJoTp3WXZldsctdiXxQ57B2C/j9PzsojTHpRbEFoTlqN+SWybqedBNPI60WpgJ5eNDJaWP2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678301; c=relaxed/simple;
	bh=Hq9oj7wLpWMy8mr3CBZv+PzeXcEG672QxLovOqz+Mco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6t3iwyPgrJSRe6Q005I3nuRdEHPx2wbjH5MCTSBKns3dIpNmHCdnpY4IibQC2sDWXy9dTqgvNN0OXbg+rAhDQik+vKyriCluBzjTUSeeKNi2JMFjJAe2cXRY1rYjMww3S1zXhp43QLooNHX+DNWyz/YOIo4sjZUnEPknfV9c2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eARvd6Ww; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741678300; x=1773214300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hq9oj7wLpWMy8mr3CBZv+PzeXcEG672QxLovOqz+Mco=;
  b=eARvd6WwoBHVoDyX97WM0ZB1H6QPqhqOnIoWBJyUIjvOgIvByXZH/rUF
   fmmBcol8C+lLnzX2kZXJ5OcgLFpgdz/7umy81TZStjWd1RIUXXbwE+enK
   /dztaOLso6XgxKQMtSLwOmMaSfd/co5k2HY+k2wkowgy2DGMd7M+wXAZz
   /FgIPBBdjuqcxfDq/lYCef2CQoB6sPSHzPDBsIOUWoSt+DVNd9FE1bDMH
   0EuFh1Hl7O28lacpnQHb9fpF6+KJw+/yf6U0aAi04yXup+qS6RG665A5G
   A2mhF0YwPyRDParhy3dzXVfu/1OHx7XNi/TcSOFFlwIAKKFxD15s2+EE0
   Q==;
X-CSE-ConnectionGUID: 6ss0DhYZTMeXfqIIaaiouQ==
X-CSE-MsgGUID: FiDQXVD7QoaM/VBP+XhlbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46350713"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="46350713"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 00:31:40 -0700
X-CSE-ConnectionGUID: NTagemLOSlibh4jwNKS8ng==
X-CSE-MsgGUID: u9trQ7IgS0q9Htl59JSXvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="125283253"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 00:31:37 -0700
Date: Tue, 11 Mar 2025 08:27:45 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: macb: Truncate TX1519CNT for trailing NUL
Message-ID: <Z8/l8eM5u7QeUROt@mev-dev.igk.intel.com>
References: <20250310222415.work.815-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310222415.work.815-kees@kernel.org>

On Mon, Mar 10, 2025 at 03:24:16PM -0700, Kees Cook wrote:
> GCC 15's -Wunterminated-string-initialization saw that this string was
> being truncated. Adjust the initializer so that the needed final NUL
> character will be present.
> 
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  drivers/net/ethernet/cadence/macb.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 2847278d9cd4..9a6acb97c82d 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1067,7 +1067,8 @@ static const struct gem_statistic gem_statistics[] = {
>  	GEM_STAT_TITLE(TX256CNT, "tx_256_511_byte_frames"),
>  	GEM_STAT_TITLE(TX512CNT, "tx_512_1023_byte_frames"),
>  	GEM_STAT_TITLE(TX1024CNT, "tx_1024_1518_byte_frames"),
> -	GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frames"),
> +	GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frame"),
> +
>  	GEM_STAT_TITLE_BITS(TXURUNCNT, "tx_underrun",
>  			    GEM_BIT(NDS_TXERR)|GEM_BIT(NDS_TXFIFOERR)),
>  	GEM_STAT_TITLE_BITS(SNGLCOLLCNT, "tx_single_collision_frames",

"rx_greater_than_1518_byte_frames" is also 32, probably you should fix
that too.

Thanks

> -- 
> 2.34.1
> 

