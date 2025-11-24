Return-Path: <netdev+bounces-241154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D355DC8086E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 13:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB6B3A8CED
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487603002AD;
	Mon, 24 Nov 2025 12:43:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0278A3019A7
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988197; cv=none; b=YFZEbMGEqIYzhNNQzNxVbGprpq4MDeQEdaXTvCuo1LzE7aS70V7BhrPUmnvRdq6T9THZagncZKwYaeKYUsWujYTpEQioiH6bL0ZZJrUtwJ6bCrb/Jh7eJd/r/DAlOqqTAV4GJC38bJyR9ja4pOzffik9lRX06txnj9v41G+Jch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988197; c=relaxed/simple;
	bh=Tb2fT9kHnL94hxVjtq8WbxtpuO2J57i5KsmUmZF1tIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUAEE4Y689jQmpnzJNpgYXW0HMuEEDFAnHWWiJzYKW5lRP8lCXs19D1/26gBD3ykr6wrOD96jllp5zCtliwlbCd+7KMnOrRQwso6bP4xFcy5yE+NW6RjI4Z+LSx2LQv+P2GGbGLB3kX2mNJGjHeN9ZrL4RF7x00wHAzGqx3LoaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A3B28617C4F8B;
	Mon, 24 Nov 2025 13:42:49 +0100 (CET)
Message-ID: <7327dde3-e6db-4699-acbf-8815434d2757@molgen.mpg.de>
Date: Mon, 24 Nov 2025 13:42:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH linux-firmware v3] ice: update DDP LAG
 package to 1.3.2.0
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20251124122609.3087-1-marcin.szycik@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251124122609.3087-1-marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Marcin,


Thank you for v3.

Am 24.11.25 um 13:26 schrieb Marcin Szycik:
> Highlights of changes since 1.3.1.0:
> 
> - Add support for Intel E830 series SR-IOV Link Aggregation (LAG) in
>    active-active mode. This uses a dual-segment package with one segment
>    for E810 and one for E830, which increases package size.
> 
> Testing hints:
>    # Install ice_lag package - refer to Dynamic Device Personalization
>    # section in:
>    # Documentation/networking/device_drivers/ethernet/intel/ice.rst
>    # in kernel tree.
>    modprobe ice
>    devlink dev eswitch set $PF1_PCI mode switchdev
>    ip link add $BR type bridge
>    echo 1 > /sys/class/net/$PF1/device/sriov_numvfs
>    ip link add $BOND type bond miimon 100 mode 802.3ad
>    ip link set $PF1 down
>    ip link set $PF1 master $BOND
>    ip link set $PF2 down
>    ip link set $PF2 master $BOND
>    ip link set $BOND master $BR
>    ip link set $VF1_PR master $BR
>    # Configure link partner in 802.3ad bond mode - e.g. for Linux partner
>    # the same commands as above, but without VF, bridge and switchdev.
>    # Verify both links in bond are transmitting/receiving VF traffic.
>    # Verify connectivity still works after pulling one of the cables -
>    # e.g. physically, or (if using ice on link partner):
>    ethtool --set-priv-flags $PF1 link-down-on-close on
>    ip link set $PF1 down
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v3:
>    * Extend testing hints
>    * Don't use bullet points for testing hints
> v2: Update WHENCE
> ---
>   WHENCE                                        |   2 +-
>   ...ce_lag-1.3.1.0.pkg => ice_lag-1.3.2.0.pkg} | Bin 692776 -> 1360772 bytes
>   2 files changed, 1 insertion(+), 1 deletion(-)
>   rename intel/ice/ddp-lag/{ice_lag-1.3.1.0.pkg => ice_lag-1.3.2.0.pkg} (49%)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

