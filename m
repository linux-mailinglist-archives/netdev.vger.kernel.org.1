Return-Path: <netdev+bounces-125245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E1596C72D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 21:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEB31C24BE4
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B0D1E4114;
	Wed,  4 Sep 2024 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="GuO53Ple"
X-Original-To: netdev@vger.kernel.org
Received: from mx08lb.world4you.com (mx08lb.world4you.com [81.19.149.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255AA1E490E
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476892; cv=none; b=Qf1tGai1okIOyf3haOw5Ofz7kOl2XUTENH9hc26d1c0aayts6XY54RfLhbrWLAk1nQEefdfHNdgarx1tL5qugLMA/d4AtYyoHscy4sk+sY2Oo65gm7K6gV9edlzWZmEQhTDSkgb9mU7MA76hF4jVz3hEyKQT/3SBoLQbl66W8zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476892; c=relaxed/simple;
	bh=M3TT/sllD/ZbFv6c8T0nZyt4FCMQZgWKfFpBKD4cNzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSTEUDd1tBSsfbEF4GiPHDZCVCmClIJnE+JGSEIeaiyut+QVmDuwf1IRYlhl8utBEgdnzBOHT+0PNkDZ/crEUMbCTZo7ty85wklWZdQ92c8DAghIV6gvCX+P2IHlP1EpDC77vs7ofTvhU3XVsD15B6Ne/nfSupj94Hy41/oQFEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=GuO53Ple; arc=none smtp.client-ip=81.19.149.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UxN9BugtAlKG9zuPDjXmvzb5CzexfJ52mJXzYIfqG3k=; b=GuO53PleCApAFKlr7RvxHaoHza
	chRO/Ous/KJ0+ADx2Ab8txODYSyx/BiWXl5K65+5NS5RJOnlzlHVpKxjoIG6nmGzLI9yBWAqWdWex
	2lV4fTKCyU/GaoCQToA8P2R2RHX/8PrcKKcTZhvqs5EsYEipVV5jQ8cZSROI1hqi8no8=;
Received: from [88.117.52.244] (helo=[10.0.0.160])
	by mx08lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1slvM7-0003yc-27;
	Wed, 04 Sep 2024 21:07:51 +0200
Message-ID: <dd42c1fd-c98b-4eda-b75f-01df15934653@engleder-embedded.com>
Date: Wed, 4 Sep 2024 21:07:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ice: Make use of assign_bit() API
Content-Language: en-US
To: Hongbo Li <lihongbo22@huawei.com>, anthony.l.nguyen@intel.com
Cc: przemyslaw.kitszel@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
References: <20240902131407.3087903-1-lihongbo22@huawei.com>
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20240902131407.3087903-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 02.09.24 15:14, Hongbo Li wrote:
> We have for some time the assign_bit() API to replace open coded
> 
>      if (foo)
>              set_bit(n, bar);
>      else
>              clear_bit(n, bar);
> 
> Use this API to clean the code. No functional change intended.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 46d3c5a34d6a..e3ad91b3ba77 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -6522,8 +6522,7 @@ ice_set_features(struct net_device *netdev, netdev_features_t features)
>   	if (changed & NETIF_F_HW_TC) {
>   		bool ena = !!(features & NETIF_F_HW_TC);
>   
> -		ena ? set_bit(ICE_FLAG_CLS_FLOWER, pf->flags) :
> -		      clear_bit(ICE_FLAG_CLS_FLOWER, pf->flags);
> +		assign_bit(ICE_FLAG_CLS_FLOWER, pf->flags, ena);
>   	}
>   
>   	if (changed & NETIF_F_LOOPBACK)

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

