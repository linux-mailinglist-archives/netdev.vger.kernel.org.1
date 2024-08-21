Return-Path: <netdev+bounces-120709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 272BD95A548
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7FE1C21C19
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 19:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B9916D9C2;
	Wed, 21 Aug 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGcBogCI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D2279CD
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268419; cv=none; b=N9glR01oTyryNIgvyLUdl7ehLJ/Qn+JJDWNyaReoIXCeXet4jaFGRmA8mdYfgDozZ5pS8RpLCYgBgSDGK6uaubeG8l8SEpScoW2sMfzBmajfwdFfqGMKU833DUalCvmSFbpSgzjFfVrQoblWEyWEHUnu1pGekKikBOjIVmKQuS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268419; c=relaxed/simple;
	bh=ylOCmaplzGHqEO1m4kZtLVYPg9/Dtj/6J1o30seDo50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cy5cj16qbCpdbv5JqF2c0kN61uaLrHiS6E/xOaEUIhiZ9efx4KU73NQq1XgXZslBLiXnuFJD74HNQhYuH7ZKkB2KBly7HGiW2tRDrgjTQxVpY+FOd0DIJD1C0xAEEv/7BTaR3rUIjb+zrwmwmTVEF9bB0WPawZyGrits3Ht1noE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGcBogCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB9CC32781;
	Wed, 21 Aug 2024 19:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724268419;
	bh=ylOCmaplzGHqEO1m4kZtLVYPg9/Dtj/6J1o30seDo50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGcBogCIIhv98MRVjfpeoGmlbLRYpSXcRS3qyG66fD1LRCDDuQP5nEwSRNKNsDORp
	 Vc+Mg81IsUT9lSUDfx78GRSqrI2/SrOM6y4lMmeOQOdywZK37xh6yMq4o6ukP4WNmO
	 8sqZt0DsirNZo9Neqnl1CJCyYA29oLcKvdfgj1KFU3pGQORGNJepXQqk06n59puQnN
	 oTCFUAhMUmERLE58HLT+TuufFS1eNCLNYYz4iYAk51hBgxi34XiZZu6qSsXWkjXpyX
	 rQhh5oFvmlWEe2fnngwi0K92HOoLOwwafP7IixlZjtppFjA3uwMQkbMTRK5A4eB3Id
	 zzhoO+hOkYFAg==
Date: Wed, 21 Aug 2024 20:26:55 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH iwl-next v3] i40e: Add Energy Efficient Ethernet ability
 for X710 Base-T/KR/KX cards
Message-ID: <20240821192655.GH2164@kernel.org>
References: <20240819092756.1113554-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819092756.1113554-1-aleksandr.loktionov@intel.com>

On Mon, Aug 19, 2024 at 11:27:56AM +0200, Aleksandr Loktionov wrote:
> Add "EEE: Enabled/Disabled" to dmesg for supported X710 Base-T/KR/KX cards.
> According to the IEEE standard report the EEE ability and and the
> EEE Link Partner ability. Use the kernel's 'ethtool_keee' structure
> and report EEE link modes.
> 
> Example:
> dmesg | grep 'NIC Link is'
> ethtool --show-eee <device>
> 
> Before:
> 	NIC Link is Up, 10 Gbps Full Duplex, Flow Control: None
> 
>         Supported EEE link modes:  Not reported
>         Advertised EEE link modes:  Not reported
>         Link partner advertised EEE link modes:  Not reported
> 
> After:
> 	NIC Link is Up, 10 Gbps Full Duplex, Flow Control: None, EEE: Enabled
> 
>         Supported EEE link modes:  100baseT/Full
>                                    1000baseT/Full
>                                    10000baseT/Full
>         Advertised EEE link modes:  100baseT/Full
>                                     1000baseT/Full
>                                     10000baseT/Full
>         Link partner advertised EEE link modes:  100baseT/Full
>                                                  1000baseT/Full
>                                                  10000baseT/Full
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v2->v3 removed double space from code
> v1->v2 removed some not mandatory changes, some style improvements

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

