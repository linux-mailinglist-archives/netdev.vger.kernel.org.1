Return-Path: <netdev+bounces-138122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CD29AC105
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1251B23BC9
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7872F156F3F;
	Wed, 23 Oct 2024 08:05:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9A5152787;
	Wed, 23 Oct 2024 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670735; cv=none; b=ivnYworC/RxEunQm7STaHHafUw3s08WEHE1fJLAbcoQ/sqZgDq2z0DFSz25Hf51p4WHJH89qmJOK/WkmIdpcoPw/K/spCB3Vb5rD/Lr66J2tMRhOmwpYVR6gSWLLA4J2K3pJVajYJXvDfqPgQZgBc4k4Rxaz8fR+LW31GgYGjDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670735; c=relaxed/simple;
	bh=ezTVhyyhWtup+bc5fzujfyflKD8dHccc9qonD4HK7fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVhak6UJm42D3Hv+k/DwlVDcq0Vc68L2Ig9xGs3yn3HI5hfH92Bm7dsquQ24mdjpNvvXxSxBCY3d6kxzlwtqWvBX5xqUG9Cfpa6cQfBgLRZnayEWlPoGYYFWqm0bbU0iHUWXD1DjoR281BzSpAJH2DpAxT0VH9KQzA1vlyIKeKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aeec7.dynamic.kabel-deutschland.de [95.90.238.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id DADAF61E5FE05;
	Wed, 23 Oct 2024 10:04:45 +0200 (CEST)
Message-ID: <ba58bbcd-079e-42b9-8e66-52b2626936e2@molgen.mpg.de>
Date: Wed, 23 Oct 2024 10:04:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 1/1] [net-next] igb: Fix spelling in
 igb_main.c
To: Johnny Park <pjohnny0508@gmail.com>
Cc: horms@kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZxhruNNXvQI-xUwE@Fantasy-Ubuntu>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ZxhruNNXvQI-xUwE@Fantasy-Ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Johnny,


Thank you for your patch. I recommend to put the information, that the 
typos are only in comments, to the summary/title:

igb: Fix 2 typos in comments in igb_main.c

That way, skimming `git log --oneline` is more informative.

Am 23.10.24 um 05:21 schrieb Johnny Park:
> Simple patch that fix spelling mistakes in igb_main.c

fix*es*, but better use imperative mood:

Fix 2 spelling mistakes in comments `igb_main.c`.

> Signed-off-by: Johnny Park <pjohnny0508@gmail.com>
> ---
> Changes in v2:
>    - Fix spelling mor -> more
> ---
>   drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 1ef4cb871452..fc587304b3c0 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -1204,7 +1204,7 @@ static int igb_alloc_q_vector(struct igb_adapter *adapter,
>   	/* initialize pointer to rings */
>   	ring = q_vector->ring;
>   
> -	/* intialize ITR */
> +	/* initialize ITR */
>   	if (rxr_count) {
>   		/* rx or rx/tx vector */
>   		if (!adapter->rx_itr_setting || adapter->rx_itr_setting > 3)
> @@ -3906,7 +3906,7 @@ static void igb_remove(struct pci_dev *pdev)
>    *
>    *  This function initializes the vf specific data storage and then attempts to
>    *  allocate the VFs.  The reason for ordering it this way is because it is much
> - *  mor expensive time wise to disable SR-IOV than it is to allocate and free
> + *  more expensive time wise to disable SR-IOV than it is to allocate and free
>    *  the memory for the VFs.
>    **/
>   static void igb_probe_vfs(struct igb_adapter *adapter)

Rest looks good.


Kind regards,

Paul

