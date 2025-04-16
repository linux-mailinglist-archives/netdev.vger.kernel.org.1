Return-Path: <netdev+bounces-183257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B32A8B7B7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0CB1901AB3
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A9F207643;
	Wed, 16 Apr 2025 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sku/zFdj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C932DFA20;
	Wed, 16 Apr 2025 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744803174; cv=none; b=hCt9Mk6xwPcuuNOpI0ysFvaI7T6FDufnTazgg1CO13qONtreA+6whRKGJiTaRHs+d2vue+FSc0IRZy129S+nc3M2yq0bTm5OAWKQrLAMQd9u8x0MtTPEFbjCuAPrtg132AXHkPd19u/cvELEZRQbr6WJXDdzcOD9GNy0+zXUwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744803174; c=relaxed/simple;
	bh=efnmkQJ/5G5/XO5EjFi5krAApWb4IBgDqiS+fcGiNIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcwfI9uvUNREd4bXp5mONe0XVX8wbU7eK7i0Z1NXm8nI+qvqnHZdDvDAO9ZXq5kDNOfGDC2Dwa3W/7TuLTotX4CAbU/S2mEXYuJePjmK3rt7HVsqKG05xzHxzWwlidlQMfDEBmju7GpLoScc8FlTQB7LAMhdV1OpYI4UgFC+15Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sku/zFdj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744803173; x=1776339173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=efnmkQJ/5G5/XO5EjFi5krAApWb4IBgDqiS+fcGiNIk=;
  b=Sku/zFdj6K8UBPSEEiFUY9OhoDJljGKie+WNIUmtPji8r3RjQpMrclR1
   jZv8hK6tCu4WcFABwY0eeCc1Sc55Oa/Q7TJi3CnM46DDrNkX+hOer7Qow
   ZAQIUl6Bu6Ov4rHPWAoijOx1Z/mjV80fAqOtxSIsXXy6LIOaH3o3/ZIE9
   fKNeVN3rxjtb09F+jQbtmwTD/tHoRkgnpzzDA8iRfCeSOKM3fZ8S48Fdm
   rcU/1LH/c+gaUyNTIyPz2L6LDisFDNFi5iDxbiF/3skh6Kx0NQCg0Vbnz
   IweRGq2SGtAGZt5lGFmlHSCv9kgNsGT59DqJPe6ImuiT8QfXZbySpilN1
   g==;
X-CSE-ConnectionGUID: nmj/GpeQRQGaBJrGxsbg1A==
X-CSE-MsgGUID: Q67wEkzLRqalokK7OFjM9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="56524134"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="56524134"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 04:32:52 -0700
X-CSE-ConnectionGUID: RNI6yJ5XRgWgKbqtIFosMg==
X-CSE-MsgGUID: 639qDp0LT5KT6h9/5/g6QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="135302581"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 04:32:48 -0700
Date: Wed, 16 Apr 2025 13:32:29 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?= <a.vatoropin@crpt.ru>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Padmanabh Ratnakar <padmanabh.ratnakar@emulex.com>,
	Mammatha Edhala <mammatha.edhala@emulex.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] be2net: Remove potential access to the zero address
Message-ID: <Z/+VTcHpQMJ3ioCM@mev-dev.igk.intel.com>
References: <20250416105542.118371-1-a.vatoropin@crpt.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416105542.118371-1-a.vatoropin@crpt.ru>

On Wed, Apr 16, 2025 at 10:55:47AM +0000, Ваторопин Андрей wrote:
> From: Andrey Vatoropin <a.vatoropin@crpt.ru>
> 
> At the moment of calling the function be_cmd_get_mac_from_list() with the
> following parameters:
> be_cmd_get_mac_from_list(adapter, mac, &pmac_valid, NULL, 
> 					adapter->if_handle, 0);

Looks like pmac_valid needs to be false to reach *pmac_id assign.

> 
> The parameter "pmac_id" equals NULL.
> 
> Then, if "mac_addr_size" equals four bytes, there is a possibility of
> accessing the zero address via the pointer "pmac_id".
> 
> Add an extra check for the pointer "pmac_id" to avoid accessing the zero
> address.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>        
> Fixes: e5e1ee894615 ("be2net: Use new implementation of get mac list command")
> Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
> ---
>  drivers/net/ethernet/emulex/benet/be_cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
> index 51b8377edd1d..be5bbf6881b8 100644
> --- a/drivers/net/ethernet/emulex/benet/be_cmds.c
> +++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
> @@ -3757,7 +3757,7 @@ int be_cmd_get_mac_from_list(struct be_adapter *adapter, u8 *mac,
>  			/* mac_id is a 32 bit value and mac_addr size
>  			 * is 6 bytes
>  			 */
> -			if (mac_addr_size == sizeof(u32)) {
> +			if (pmac_id && mac_addr_size == sizeof(u32)) {
>  				*pmac_id_valid = true;
>  				mac_id = mac_entry->mac_addr_id.s_mac_id.mac_id;
>  				*pmac_id = le32_to_cpu(mac_id);

Thanks for fixing.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.43.0

