Return-Path: <netdev+bounces-241149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D4946C8045D
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C42B342976
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 11:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A012FF642;
	Mon, 24 Nov 2025 11:50:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFBA26E706
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763985053; cv=none; b=CBGvV38cTGkwxjiazWDjUIYEjhMDTi+g9EttYS1/TxQHcS9whLKpXiCAfL2k7g5q6El4zSPdD+ficcvQ0eoyX/nhXTLuqKoBKSMs07mLeAeb6VQfDSsIZPf/fafaYq6i0fM4/fi5xkuxPByqDq/ia2Ya7R6M0S5TmJDn2zl+MnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763985053; c=relaxed/simple;
	bh=VsVmTijMdhvcnx8zIJqhmORsXZ14/Q5s+I5vrO1kIiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=to2LZDffUgaCeNppHzqrkpxGd10iHLspvnC63qhsDkGy2RAUlF3ZIinUDJsQTDDYogSaSWSVeO4tEnS+sfhDhP0LI8YGN2q4ewcgni63ren5UdAgmrsY3VE8v3MZ5vpITn+cTqEFip5gnrBy8wjb1WewqqHRXTHVqnMmh7atpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.160] (unknown [185.238.219.78])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D4D5261CC3FF6;
	Mon, 24 Nov 2025 12:50:20 +0100 (CET)
Message-ID: <7a18de32-73c6-4d54-831e-714e6ff0ccf1@molgen.mpg.de>
Date: Mon, 24 Nov 2025 12:50:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH linux-firmware v2] ice: update DDP LAG
 package to 1.3.2.0
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20251124114356.75699-1-marcin.szycik@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251124114356.75699-1-marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Am 24.11.25 um 12:43 schrieb Marcin Szycik:
> Highlights of changes since 1.3.1.0:
> 
> - Add support for Intel E830 series SR-IOV Link Aggregation (LAG) in
>    active-active mode. This uses a dual-segment package with one segment
>    for E810 and one for E830, which increases package size.
> 
> Testing hints:
> - Install ice_lag package
> - Load ice driver

Give the command?

Format the comands below without the bullet, so it can be copied more 
easily?

> - devlink dev eswitch set $PF1_PCI mode switchdev
> - ip link add $BR type bridge
> - echo 1 > /sys/class/net/$PF1/device/sriov_numvfs
> - ip link add $BOND type bond miimon 100 mode 802.3ad
> - ip link set $PF1 down
> - ip link set $PF1 master $BOND
> - ip link set $PF2 down
> - ip link set $PF2 master $BOND
> - ip link set $BOND master $BR
> - ip link set $VF1_PR master $BR
> - Configure link partner in 802.3ad bond mode

How?

> - Verify both links in bond are transmitting/receiving VF traffic
> - Verify bond still works after pulling one of the cables

Please give the command.

> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v2: Update WHENCE
> ---
>   WHENCE                                        |   2 +-
>   ...ce_lag-1.3.1.0.pkg => ice_lag-1.3.2.0.pkg} | Bin 692776 -> 1360772 bytes
>   2 files changed, 1 insertion(+), 1 deletion(-)
>   rename intel/ice/ddp-lag/{ice_lag-1.3.1.0.pkg => ice_lag-1.3.2.0.pkg} (49%)
> 
> diff --git a/WHENCE b/WHENCE
> index 02e6d3575f99..7b63c659f100 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -6970,7 +6970,7 @@ Driver: ice - Intel(R) Ethernet Connection E800 Series
>   
>   File: intel/ice/ddp/ice-1.3.43.0.pkg
>   Link: intel/ice/ddp/ice.pkg -> ice-1.3.43.0.pkg
> -File: intel/ice/ddp-lag/ice_lag-1.3.1.0.pkg
> +File: intel/ice/ddp-lag/ice_lag-1.3.2.0.pkg

[…]

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

