Return-Path: <netdev+bounces-64197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84344831B55
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 15:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372A41F26D7A
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D925776;
	Thu, 18 Jan 2024 14:29:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE35028DAB
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588146; cv=none; b=g5gYJkvW0gYeKhFR3r0p8OGyR4lgdhw2zbNff8kC7zjBOq7EfaTh4PMGl4AJmLrK/PNdFXELJt/8ySAAVkn5IAbpAoivKojsVG82qlt8QVzocOcvMTA72hMfICsG8oVV6wHQQpDG1z9CEmpmHfgZmsWNQSWglgCl4NfKruS7yNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588146; c=relaxed/simple;
	bh=PbAdMFihBdZDCNr21zSZ3qGCUMvuqU+o7QUdCI+tZlA=;
	h=Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=ONNei2k/DqrmVTNTAkGBFVOHTvZhhNUZDLP0kHfaGjI07geHEVwwJO9heoIQcCqTYj9wZ83F2G6wGfcDnf38IvNtzArSBMnWIKcwiNXnBAs1hEwcqclrsHDjXK/fiR0AkZ/4KqC29rrENSPbEDdXrzfHWqgqWhrGjiqbE12pqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (ip5f5af6e2.dynamic.kabel-deutschland.de [95.90.246.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 15F4861E5FE03;
	Thu, 18 Jan 2024 15:28:37 +0100 (CET)
Message-ID: <267a2f52-7813-4b9b-bdcf-e7eb05b723f4@molgen.mpg.de>
Date: Thu, 18 Jan 2024 15:28:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 3/3] ixgbe: Cleanup after
 type convertion
Content-Language: en-US
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com
References: <20240118134332.470907-1-jedrzej.jagielski@intel.com>
 <20240118134332.470907-3-jedrzej.jagielski@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240118134332.470907-3-jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jedrzej,


Thank you for your patch. Two nits regarding the commit message. For the 
summary: *Clean up* after type conver*s*ion.

Am 18.01.24 um 14:43 schrieb Jedrzej Jagielski:> Clean up code where 
touched during type convertion by the patch

1.  Clean up the code, touched during …
2.  conver*s*ion

> 8035560dbfaf. Rearrange to fix reverse Christmas tree.

Is re-arranging the only thing done by the patch? Maybe that should be 
the commit message summary/title then.


Kind regards,

Paul


> Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>   .../net/ethernet/intel/ixgbe/ixgbe_82598.c    | 14 ++--
>   .../net/ethernet/intel/ixgbe/ixgbe_82599.c    | 40 +++++------
>   .../net/ethernet/intel/ixgbe/ixgbe_common.c   | 66 +++++++++----------
>   .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 54 +++++++--------
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 12 ++--
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 50 +++++++-------
>   7 files changed, 119 insertions(+), 119 deletions(-)

[…]

