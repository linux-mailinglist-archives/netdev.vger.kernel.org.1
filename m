Return-Path: <netdev+bounces-168594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F61A3F752
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D53B3ADE3D
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242391D5146;
	Fri, 21 Feb 2025 14:34:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B397080D
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148459; cv=none; b=YkxjW/yc2LEzlR37hmEtJQTjWO67un24EgdBtWWkgYXLxA/9AtSZuSMllO3UNY9WHDlAEHk15qHp6GDtWgERVavJ2DUyNGOv1FeBsuboy6YYVT2tK9hIhGeaHLY+Tfjm5cDpC01T0sivzmINFdxBwE1WSjXK81Fvr/W7bqvxykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148459; c=relaxed/simple;
	bh=MmIDNduaSXZvgUnE9aQC1ZVryLQ8kuBT01oiJ/WnkwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eD/RTct4IFAPNX+im8UHcmpKbhHxsEhptY02vnEE9LD2pMyYU3hNzlkWm54+yU65zvRsTSGt9OQXS7FfwvkN5jg8gBqJIp3ggCr/NULRgi1RajrzsDKQcdCtQJvKJ9CUi0C5MUs7d31vSHiDztFHrsdzBy1CPGVd8AmqZs/GpVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af27c.dynamic.kabel-deutschland.de [95.90.242.124])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0421B61E6477D;
	Fri, 21 Feb 2025 15:34:00 +0100 (CET)
Message-ID: <d07597a8-7e89-41b3-aec9-3af9d9aed529@molgen.mpg.de>
Date: Fri, 21 Feb 2025 15:34:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: Allow 100M speed for
 E825C SGMII device
To: Grzegorz Nitka <grzegorz.nitka@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 netdev@vger.kernel.org
References: <20250221101608.2437124-1-grzegorz.nitka@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250221101608.2437124-1-grzegorz.nitka@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Grzegorz,


Thank you for the patch.

Am 21.02.25 um 11:16 schrieb Grzegorz Nitka:
> Add E825C 10GbE SGMII device to the list of devices supporting 100Mbit
> link mode. Without that change, 100Mbit link mode is ignored in ethtool
> interface. This change was missed while adding the support for E825C
> devices family.

I always like to have the commands and output for reproducing the issue 
in the commit message. That way, people hitting the error, have a chance 
of finding the commit, for example, with search engines.

> Fixes: f64e189442332 ("ice: introduce new E825C devices family")
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_common.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 7a2a2e8da8fa..caf3af2a32c3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -3180,6 +3180,7 @@ bool ice_is_100m_speed_supported(struct ice_hw *hw)
>   	case ICE_DEV_ID_E822L_SGMII:
>   	case ICE_DEV_ID_E823L_1GBE:
>   	case ICE_DEV_ID_E823C_SGMII:
> +	case ICE_DEV_ID_E825C_SGMII:
>   		return true;
>   	default:
>   		return false;
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

