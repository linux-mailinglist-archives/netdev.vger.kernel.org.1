Return-Path: <netdev+bounces-122093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1C595FE01
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 02:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FEF282E82
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD544A1A;
	Tue, 27 Aug 2024 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="fC+j5kuJ"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C21C32
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 00:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724718694; cv=none; b=f0ffeP+rSEICT3uSIexZlvO2KXqUp5VA1oI6CwppN2foAYZrsy10EFUJSjePh2Mhyv2PFXLWhrwoVwahJdfoEuwpzX+cnEgion8mu2aeVY6SNaMB8l8mMp0EbZ6hZ8V09FEsudX2IU+8B1YLBSRlzvm5TZjxpo+5PHZBJiKRYE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724718694; c=relaxed/simple;
	bh=4VIDHqRXh3PESI2LCOsW2DIpa0VAkMNyrz55gYWykF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gq0DOLwFoR7wDgyPZytWzRprSXfwMPOZn6xhp0buW1uVNLSMlHJF2Cy3BF2b1g8D/LYlaobwnqfjrUutwkZsv3PpBpV6dubucDVnc4+TOjHHcWClxL3qAhL9DhfpUq53zSP2KYOQvoLGT2J2M33EcwXx8MQv3wSOH1qfT6jddO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=fC+j5kuJ; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724718692;
	bh=R/Gak0ae/0miDysKWUlT3iOsg97pfNCUk+k54qa5SlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=fC+j5kuJ2vwr35j/O0gOUXlrL7qDQrGketa1fJ4UxmW3eIuimR04Q93yUOtk7mdKA
	 6Vk0u8I0+qbJYifKi0Wkc5mRwqULDMe8DeDcVoI6vzqDEOv8BlVXN+QlEWHUPoLBCA
	 FATgc6bRjjesJ0QNRMvaAP91wJBD/MrF4bOit/7FZF8ap91GvboaBRtsEaVXkcMfhr
	 ng17QVqOeKqE8Vn/s097dVQ+S8RFZZzoHkDsAl2GqUzeZYKy+ecfYlnvR47KFkFxHd
	 ZeDeYYY2p7dWIVETafmDe2CkNFac77osYt6UOpAn2lqEM0bT2Pxeh+jDCfTALG314b
	 I9Lg4rgMwecug==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id 54B42D002A4;
	Tue, 27 Aug 2024 00:31:21 +0000 (UTC)
Message-ID: <a5e921a1-1ceb-4b58-af02-17eed131c24a@icloud.com>
Date: Tue, 27 Aug 2024 08:31:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] cxl/region: Find free cxl decoder by
 device_for_each_child()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240824-const_dfc_prepare-v3-0-32127ea32bba@quicinc.com>
 <20240824-const_dfc_prepare-v3-2-32127ea32bba@quicinc.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20240824-const_dfc_prepare-v3-2-32127ea32bba@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: THkkK4MD2_XG40znL9Tnka8Q45xPxWZw
X-Proofpoint-ORIG-GUID: THkkK4MD2_XG40znL9Tnka8Q45xPxWZw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_18,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408270002

On 2024/8/24 17:07, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> To prepare for constifying the following old driver core API:
> 
> struct device *device_find_child(struct device *dev, void *data,
> 		int (*match)(struct device *dev, void *data));
> to new:
> struct device *device_find_child(struct device *dev, const void *data,
> 		int (*match)(struct device *dev, const void *data));
> 
> The new API does not allow its match function (*match)() to modify
> caller's match data @*data, but match_free_decoder() as the old API's
> match function indeed modifies relevant match data, so it is not suitable
> for the new API any more, solved by using device_for_each_child() to
> implement relevant finding free cxl decoder function.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/cxl/core/region.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..c2068e90bf2f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -794,10 +794,15 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  	return rc;
>  }
>  
> +struct cxld_match_data {
> +	int id;
> +	struct device *target_device;
> +};
> +
>  static int match_free_decoder(struct device *dev, void *data)
>  {
> +	struct cxld_match_data *match_data = data;
>  	struct cxl_decoder *cxld;
> -	int *id = data;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
> @@ -805,17 +810,31 @@ static int match_free_decoder(struct device *dev, void *data)
>  	cxld = to_cxl_decoder(dev);
>  
>  	/* enforce ordered allocation */
> -	if (cxld->id != *id)
> +	if (cxld->id != match_data->id)
>  		return 0;
>  
> -	if (!cxld->region)
> +	if (!cxld->region) {
> +		match_data->target_device = get_device(dev);

get_device() must != NULL since @dev != NULL for the function parameter
of both device_for_each_child() and device_find_child().

so this change's logic is same as previous existing logic.

>  		return 1;
> +	}
>  
> -	(*id)++;
> +	match_data->id++;
>  
>  	return 0;
>  }
>  
> +/* NOTE: need to drop the reference with put_device() after use. */
> +static struct device *find_free_decoder(struct device *parent)
> +{
> +	struct cxld_match_data match_data = {
> +		.id = 0,
> +		.target_device = NULL,
> +	};
> +
> +	device_for_each_child(parent, &match_data, match_free_decoder);
> +	return match_data.target_device;
> +}
> +
>  static int match_auto_decoder(struct device *dev, void *data)
>  {
>  	struct cxl_region_params *p = data;
> @@ -840,7 +859,6 @@ cxl_region_find_decoder(struct cxl_port *port,
>  			struct cxl_region *cxlr)
>  {
>  	struct device *dev;
> -	int id = 0;
>  
>  	if (port == cxled_to_port(cxled))
>  		return &cxled->cxld;
> @@ -849,7 +867,7 @@ cxl_region_find_decoder(struct cxl_port *port,
>  		dev = device_find_child(&port->dev, &cxlr->params,
>  					match_auto_decoder);
>  	else
> -		dev = device_find_child(&port->dev, &id, match_free_decoder);
> +		dev = find_free_decoder(&port->dev);
>  	if (!dev)
>  		return NULL;
>  	/*
> 


