Return-Path: <netdev+bounces-243275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B30AAC9C691
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB87D345320
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF75F2C0F97;
	Tue,  2 Dec 2025 17:35:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F832BEFEB;
	Tue,  2 Dec 2025 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696913; cv=none; b=Ik0gUge1ODKkSaStCADzz9skRT1UtSXKbaZnfaSCzq9id436xoZUvqn+pyBA6K+NdJX+wxbmyU6QeglvAjj9PYQqasniot2d0mCpi0sr//cQQ+uDSy3eJVZtxpDH8+dAQW110CF1Pus2mzdunz9B5jFNJERO46dRbILyyGy7mGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696913; c=relaxed/simple;
	bh=x4o9HIWheh9sz5INWZqpUCNN1YHDEOJZHw96pD53mwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKK1nPWR2tuDmPJ7tM8ZeTAzNtb6ulDBmIlfwk5XYGFmVvLmUXLUJh0bSHoTShJQpcYLkPFOQFKpSIISaTY9j8AlzmdfuxQUzewGBSCKV0U5jROYFjO6K1oYJueLQO6re24XqoenDwfdtLxszz3pQaFDeK6EOx9wbjOXhj07/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AFCF961CC3FF3;
	Tue, 02 Dec 2025 18:34:17 +0100 (CET)
Message-ID: <a5c2ee3c-6643-4e67-acba-44384706e971@molgen.mpg.de>
Date: Tue, 2 Dec 2025 18:34:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] igc: Use 5KB TX packet
 buffer per queue for TSN mode
To: Chwee-Lin Choong <chwee.lin.choong@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zdenek Bouska <zdenek.bouska@siemens.com>,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
References: <20251202122351.11915-1-chwee.lin.choong@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251202122351.11915-1-chwee.lin.choong@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chwee-Lin,


Thank you for your patch.

(Just a heads-up, that Zdenek’s email address was not properly quoted in 
the Cc: list.)

In the summary you could be more specific to say, that you *decrease* 
the size.

Am 02.12.25 um 13:23 schrieb Chwee-Lin Choong:
> Update IGC_TXPBSIZE_TSN to allocate 5KB per TX queue (TXQ0-TXQ3)
> as recommended in I225/I226 SW User Manual Section 7.5.4 for TSN
> operation.

Please elaborate on the problem (mention the 7 KB size and hangs), and 
maybe Faizal remembers why they chose 7 KB.

Also, are there any performance drawbacks. (I know that avoiding hangs 
tops that, but it would be good to know.)

> Fixes: 0d58cdc902da ("igc: optimize TX packet buffer utilization for TSN mode")
> Reported-by: Zdenek Bouska <zdenek.bouska@siemens.com>
> Closes: https://lore.kernel.org/netdev/AS1PR10MB5675DBFE7CE5F2A9336ABFA4EBEAA@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM/
> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_defines.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 498ba1522ca4..9482ab11f050 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -443,9 +443,10 @@
>   #define IGC_TXPBSIZE_DEFAULT ( \
>   	IGC_TXPB0SIZE(20) | IGC_TXPB1SIZE(0) | IGC_TXPB2SIZE(0) | \
>   	IGC_TXPB3SIZE(0) | IGC_OS2BMCPBSIZE(4))
> +/* TSN value following I225/I226 SW User Manual Section 7.5.4 */
>   #define IGC_TXPBSIZE_TSN ( \
> -	IGC_TXPB0SIZE(7) | IGC_TXPB1SIZE(7) | IGC_TXPB2SIZE(7) | \
> -	IGC_TXPB3SIZE(7) | IGC_OS2BMCPBSIZE(4))
> +	IGC_TXPB0SIZE(5) | IGC_TXPB1SIZE(5) | IGC_TXPB2SIZE(5) | \
> +	IGC_TXPB3SIZE(5) | IGC_OS2BMCPBSIZE(4))

Reading the commit message of commit 0d58cdc902da ("igc: optimize TX 
packet buffer utilization for TSN mode"), it says, that the goal is to 
split up 32 KB. What is happening to the 8 KB that are freed up now?

>   #define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
>   #define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */

With a more elaborate commit message, feel free to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

