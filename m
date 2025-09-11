Return-Path: <netdev+bounces-221983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025BCB528AC
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 08:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162FA18923ED
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 06:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424952580E4;
	Thu, 11 Sep 2025 06:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="Y9aA+Wos"
X-Original-To: netdev@vger.kernel.org
Received: from mta-202a.earthlink-vadesecure.net (mta-202a.earthlink-vadesecure.net [51.81.232.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CFE259CB6
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.232.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571901; cv=none; b=FAutqRu/uO0uFV0n9CyuazHPdWRcQbZaseh/11OQ2SHZGhIn24igWb3E8mzIh8x7KwSw535PO6yb95nu//2yi1rB+sxpbr2Yazd8EqulNrCzqH0IMkc+6aCKoTFu0Z05WyJsgKhGepSrt3eA25XYsIujMXg0WPNP0uA3FkEf34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571901; c=relaxed/simple;
	bh=3MYhVJYru/xM3QYhBHOqYZpInqOXqDZ/nmezHYfZ3ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q8ygvzOR7P8wIxDjsl/EatuOBU3RK4HR//VhM0Q9VANXZNrd3PYvKz6ghpuYf3P0H2F3XiIiXWwZjIf/ofEViPzFwERrrWLemm9suAXfylYAOI3E4p2sDWKQDL63UpeeMg71GxoP5h9D+ltT0K+6EumBRHs5DkRvy8KNVZinlZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com; spf=pass smtp.mailfrom=onemain.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=Y9aA+Wos; arc=none smtp.client-ip=51.81.232.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onemain.com
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=svnelson@teleport.com smtp.mailfrom=sln@onemain.com;
DKIM-Signature: v=1; a=rsa-sha256; bh=W/ebha+hTpPuapqkckv9VNIgwA7jIHveSqndl9
 yhuMo=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1757571560; x=1758176360; b=Y9aA+Wosz/D0kooBbR61eFCr6M9
 eGODkpMUNPydfGE4b49cJAT595PcJY6y3tFG0kYFCpEMaTiIJHFE8JWAMsGWFiJq/rBhkkh
 qT0Vsr3CYZLJsPTFO5+mDaX6IZqiScpo/N2t7cgLe2Glf1aLnTrNAX8DCCTUzNYEsXTz2Tz
 qki8KZqY3pC7WezF0IgmcDoSkks3+jQcSODgSdVDblmKtvQYUXqkCiKoHeci1bfMX5eKkjD
 h2eyNpVmgmM6dlSkaJ3t+F4I18CgWDz99+smKype3xb0DAr7S5kf2lf3lbeSYiJolmdtjRw
 qjXDG7kZ9RDFBl16T9JLmRdp5+4CZ5g==
Received: from [192.168.0.23] ([50.47.159.51])
 by vsel2nmtao02p.internal.vadesecure.com with ngmta
 id c2411687-18642604784b5d48; Thu, 11 Sep 2025 06:19:20 +0000
Message-ID: <5c7de370-1fe1-4fbb-9e93-9b20fb3763e5@onemain.com>
Date: Wed, 10 Sep 2025 23:19:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ionic: use int type for err in
 ionic_get_module_eeprom_by_page
To: Alok Tiwari <alok.a.tiwari@oracle.com>, shannon.nelson@amd.com,
 brett.creeley@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
References: <20250911042351.3833648-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Shannon Nelson <sln@onemain.com>
In-Reply-To: <20250911042351.3833648-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/25 9:23 PM, Alok Tiwari wrote:
> The variable 'err' is declared as u32, but it is used to store
> negative error codes such as -EINVAL.
>
> Changing the type of 'err' to int ensures proper representation of
> negative error codes and aligns with standard kernel error handling
> conventions.
>
> Fixes: c51ab838f532 ("ionic: extend the QSFP module sprom for more pages")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index 92f30ff2d631..c3f9835446e2 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -978,7 +978,7 @@ static int ionic_get_module_eeprom_by_page(struct net_device *netdev,
>   {
>   	struct ionic_lif *lif = netdev_priv(netdev);
>   	struct ionic_dev *idev = &lif->ionic->idev;
> -	u32 err = -EINVAL;
> +	int err = -EINVAL;

Yikes, how'd we manage that?
Thanks for catching it.

Reviewed-by: Shannon Nelson <sln@onemain.com>

>   	u8 *src;
>   
>   	if (!page_data->length)


