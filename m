Return-Path: <netdev+bounces-170429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6C0A48AB5
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 22:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7368E7A11C5
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 21:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C429271281;
	Thu, 27 Feb 2025 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="nxNnjZ6h"
X-Original-To: netdev@vger.kernel.org
Received: from mx24lb.world4you.com (mx24lb.world4you.com [81.19.149.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446931A9B2A;
	Thu, 27 Feb 2025 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692539; cv=none; b=LOiOrOT6ystA5/6w/T0ci98CJzIVq+h10/LKo5Gd/1Bfali1dF4rMp6AZ6bFGU/s0NISQpe66mSVOA0IBJIOJiIdspCxZQ+OFytJ0lTjGrs+m35g+zTxAzRXOJgwsbzmFA2vSygwzrNN/pR5QIM8t4LBkDYPjcgWCeUngh3H2EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692539; c=relaxed/simple;
	bh=ZgLkTQpi46zVF4g45Rb7vFFSn7wnrwrrKVkZSld/DCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvKeU+qKK1MspKeWjzG2EJMQxaYvzSfi+sZujMjrnan6S/jEG1Mrq9ku3HHRrmYUXX+L1eFyUFlbPKjdb5wOp+CdyXP0UyaV2C0CuFbxHkax3rSa7IL1zLbGTxUx4ZU+0QpXiRejBQNWC69Z1NCsAhGeXi0m0lM3VylQ0mma+Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=nxNnjZ6h; arc=none smtp.client-ip=81.19.149.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NXcp1FiqxMKRjKgh60iR4pFXneo9a1uhMTjZAaxEfm0=; b=nxNnjZ6hbxsWBoU0izOH/n1fJp
	rrQKHMkTDk+5mX1fxI07czCN/4RiRq6VFfn2yKEO2DBulYz8p1Rt3AFy7m+LjosjIJ3JKs0380Cb6
	KoLeAtDOuokIhOk1J5A5e6UiEL3xj0VjLCSrAsKpyr+pkVVa2ob528VKxxIePcxD6ADM=;
Received: from [88.117.55.1] (helo=[10.0.0.160])
	by mx24lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tnkrC-000000000l3-2Rs8;
	Thu, 27 Feb 2025 21:51:46 +0100
Message-ID: <1ea6a1df-357d-4d00-828b-98345254b4b2@engleder-embedded.com>
Date: Thu, 27 Feb 2025 21:51:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] caif_virtio: fix wrong pointer check in cfv_probe()
To: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rusty Russell <rusty@rustcorp.com.au>, Erwan Yvin
 <erwan.yvin@stericsson.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250227184716.4715-1-v.shevtsov@mt-integration.ru>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250227184716.4715-1-v.shevtsov@mt-integration.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 27.02.25 19:46, Vitaliy Shevtsov wrote:
> del_vqs() frees virtqueues, therefore cfv->vq_tx pointer should be checked
> for NULL before calling it, not cfv->vdev. Also the current implementation
> is redundant because the pointer cfv->vdev is dereferenced before it is
> checked for NULL.
> 
> Fix this by checking cfv->vq_tx for NULL instead of cfv->vdev before
> calling del_vqs().
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Fixes: 0d2e1a2926b1 ("caif_virtio: Introduce caif over virtio")
> Signed-off-by: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
> ---
>   drivers/net/caif/caif_virtio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
> index 7fea00c7ca8a..c60386bf2d1a 100644
> --- a/drivers/net/caif/caif_virtio.c
> +++ b/drivers/net/caif/caif_virtio.c
> @@ -745,7 +745,7 @@ static int cfv_probe(struct virtio_device *vdev)
>   
>   	if (cfv->vr_rx)
>   		vdev->vringh_config->del_vrhs(cfv->vdev);
> -	if (cfv->vdev)
> +	if (cfv->vq_tx)
>   		vdev->config->del_vqs(cfv->vdev);
>   	free_netdev(netdev);
>   	return err;

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

