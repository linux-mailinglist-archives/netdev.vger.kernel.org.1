Return-Path: <netdev+bounces-224007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F20B7E78F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B51F520915
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 12:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA3A30CB28;
	Wed, 17 Sep 2025 12:46:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27D2FBDFF;
	Wed, 17 Sep 2025 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113200; cv=none; b=j7zddEcEvPsiZYNe1Rmd6XGi4pynmxUwBhdMaRIJvJOcBRHrboXiW+JQBrNYqOQrtooz8ZTbgiUUEouQHLwBTQcIwwKiwzNPQmEKFtt9zzD3dO39B2bVMnD0buMxmPwi5P5xQupzFI1I2mkVJGePVE0QFmbHFlDwqo5szf7oHls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113200; c=relaxed/simple;
	bh=aFTk21/Z1yevUz4SRaZ4PgphBX8nO20Tu1tx5Yqizxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=MZgybgJJg3AxW7bVNxFTcj41MlpnEjM99hcNP8tJ1+LN5hrPvRxmNpnDiqOrRf2HQ2UyD77mEJq+20is2Nx5wJPH4VRRyalKfpGcWyXPK6ETWjHtLB7HAvZRD66NGqSvlFf6ypkJK2QwN/+B2wgUz5q/zevM9rIY5OYu2shKKtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.205] (p5b13a163.dip0.t-ipconnect.de [91.19.161.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4C3F76028F34A;
	Wed, 17 Sep 2025 14:45:48 +0200 (CEST)
Message-ID: <f80effb4-0c91-416f-a7cb-4c9a7055fa13@molgen.mpg.de>
Date: Wed, 17 Sep 2025 14:45:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 1/5] net: docs: add missing
 features that can have stats
To: Jacob Keller <jacob.e.keller@intel.com>
References: <20250916-resend-jbrandeb-ice-standard-stats-v4-0-ec198614c738@intel.com>
 <20250916-resend-jbrandeb-ice-standard-stats-v4-1-ec198614c738@intel.com>
Content-Language: en-US
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Jakub Kicinski <kuba@kernel.org>, Hariprasad Kelam <hkelam@marvell.com>,
 Simon Horman <horms@kernel.org>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org, corbet@lwn.net
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250916-resend-jbrandeb-ice-standard-stats-v4-1-ec198614c738@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jacob, dear Jesse,


Thank you for your patch.

Am 16.09.25 um 21:14 schrieb Jacob Keller:
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> While trying to figure out ethtool -I | --include-statistics, I noticed
> some docs got missed when implementing commit 0e9c127729be ("ethtool:
> add interface to read Tx hardware timestamping statistics").
> 
> Fix up the docs to match the kernel code, and while there, sort them in
> alphabetical order.

So, ETHTOOL_MSG_LINKSTATE_GET and ETHTOOL_MSG_TSINFO_GET were missing.

> Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   Documentation/networking/statistics.rst | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/statistics.rst b/Documentation/networking/statistics.rst
> index 518284e287b0..66b0ef941457 100644
> --- a/Documentation/networking/statistics.rst
> +++ b/Documentation/networking/statistics.rst
> @@ -184,9 +184,11 @@ Protocol-related statistics can be requested in get commands by setting
>   the `ETHTOOL_FLAG_STATS` flag in `ETHTOOL_A_HEADER_FLAGS`. Currently
>   statistics are supported in the following commands:
>   
> -  - `ETHTOOL_MSG_PAUSE_GET`
>     - `ETHTOOL_MSG_FEC_GET`
> +  - `ETHTOOL_MSG_LINKSTATE_GET`
>     - `ETHTOOL_MSG_MM_GET`
> +  - `ETHTOOL_MSG_PAUSE_GET`
> +  - `ETHTOOL_MSG_TSINFO_GET`
>   
>   debugfs
>   -------
> 

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


