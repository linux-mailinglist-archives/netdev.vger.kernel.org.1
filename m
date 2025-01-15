Return-Path: <netdev+bounces-158518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515BA12509
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F80A3A69E2
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDD2241A0F;
	Wed, 15 Jan 2025 13:40:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D1224AEF
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948418; cv=none; b=Pi3R+J2CY44Uq0G7XxxACfa0HREorpnNP9QcghFIB6Cc4sBNnApq3WZowg5rEVzk3GddkoU7A1HGlyX7ZTvcopvVHfU9j24fKgMnIWMFtTzpVItkFG5ocNxsfqv0Yaqv8mdrWJlnIls8TBfWig+CJEpVBOdcnK2yFKX8ZM2IAec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948418; c=relaxed/simple;
	bh=r1xsjJUOy2JgUySvO3eaWqeMmfqNQDIF+7/tYLeVTeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DU/yZknIJf23ZufmUvc/iYlr4g6OsXIx6TieW11Cetb4/06DAhfJg2r9HTGVMUH1dTT8JLz47LDCQbcVm/u+R7HpQsQrmrwjYssEsPp7Xk4QhezuxbhvGjY3WWLmLvWqHKFjN8sUw/+oKJ9zyyHLnXfHXsc6h5f7mk3By5VrdxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id DF51361E647A3;
	Wed, 15 Jan 2025 14:39:52 +0100 (CET)
Message-ID: <c8cf251c-9788-4d00-a633-7a4a7bdc5e87@molgen.mpg.de>
Date: Wed, 15 Jan 2025 14:39:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: add support for
 thermal sensor event reception
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20250115122720.431223-1-jedrzej.jagielski@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250115122720.431223-1-jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jedrzej,


Thank you for the patch.

Am 15.01.25 um 13:27 schrieb Jedrzej Jagielski:
> E610 NICs unlike the previous devices utilising ixgbe driver
> are notified in the case of overheat by the FW ACI event.

overheat*ing*

> In event of overheat when treshhold is exceeded, FW suspends all

threshold

> traffic and sends overtemp event to the driver. Then driver
> loggs appropriate message and closes the adapter instance.

logs

> The card remains in that state until the platform is rebooted.

How did you test this? Can you please paste the message?

> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 5 +++++
>   drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 3 +++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 7236f20c9a30..5c804948dd1f 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -3165,6 +3165,7 @@ static void ixgbe_aci_event_cleanup(struct ixgbe_aci_event *event)
>   static void ixgbe_handle_fw_event(struct ixgbe_adapter *adapter)
>   {
>   	struct ixgbe_aci_event event __cleanup(ixgbe_aci_event_cleanup);
> +	struct net_device *netdev = adapter->netdev;
>   	struct ixgbe_hw *hw = &adapter->hw;
>   	bool pending = false;
>   	int err;
> @@ -3185,6 +3186,10 @@ static void ixgbe_handle_fw_event(struct ixgbe_adapter *adapter)
>   		case ixgbe_aci_opc_get_link_status:
>   			ixgbe_handle_link_status_event(adapter, &event);
>   			break;
> +		case ixgbe_aci_opc_temp_tca_event:
> +			e_crit(drv, "%s\n", ixgbe_overheat_msg);
> +			ixgbe_close(netdev);
> +			break;
>   		default:
>   			e_warn(hw, "unknown FW async event captured\n");
>   			break;
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
> index 8d06ade3c7cd..617e07878e4f 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
> @@ -171,6 +171,9 @@ enum ixgbe_aci_opc {
>   	ixgbe_aci_opc_done_alt_write			= 0x0904,
>   	ixgbe_aci_opc_clear_port_alt_write		= 0x0906,
>   
> +	/* TCA Events */
> +	ixgbe_aci_opc_temp_tca_event                    = 0x0C94,
> +
>   	/* debug commands */
>   	ixgbe_aci_opc_debug_dump_internals		= 0xFF08,

Kind regards,

Paul

