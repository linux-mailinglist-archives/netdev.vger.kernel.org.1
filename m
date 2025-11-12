Return-Path: <netdev+bounces-237927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05810C51932
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65FD434BDF9
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41723016E7;
	Wed, 12 Nov 2025 10:09:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB82F7AA2;
	Wed, 12 Nov 2025 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942197; cv=none; b=J2GpxL0Eu7Jp4gEj89trarYH8M2OWDmJGJ2hRwYuVwVmZtuSxaeTzr6NDmK0k4nxVQdUDaV2s26/DmflD8gvdRr+WXaSM3tITAHBZH4KPhkWhK9CAcST5/YpDsSdd4N7EltpCwFLpXbj1h9uAopEFo9sXfjEDbEsZZoBuEglVsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942197; c=relaxed/simple;
	bh=bRsp6srkHVABVShdSbIU3zF9p/23iTeZlNoyj8kpWM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8v+Nh2uEjt/T6+d7l9Oo3HCBStVHem0BIf7G3IWCBLlbZp1oXNZ+f/EtVmOGFdXj9BbM1msE0QCRJH+puK/+S5OGLQ2q5yr244M3qoO4PMI/lspB6ASUVM+PZrNp/gL0PlsnII+LxjUvLa7WCxWDGtLw1GuSKsA90fpU+JKRRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.215] (p57bd98fa.dip0.t-ipconnect.de [87.189.152.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8D568617C4FAA;
	Wed, 12 Nov 2025 11:09:34 +0100 (CET)
Message-ID: <2493f8b0-8763-4a09-ba0c-af1f73d21632@molgen.mpg.de>
Date: Wed, 12 Nov 2025 11:09:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Bluetooth: Remove unused hcon->remote_id
To: Gongwei Li <13875017792@163.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gongwei Li <ligongwei@kylinos.cn>
References: <20251112094843.173238-1-13875017792@163.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251112094843.173238-1-13875017792@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Gongwei,


Thank you for your patch.

Am 12.11.25 um 10:48 schrieb Gongwei Li:
> From: Gongwei Li <ligongwei@kylinos.cn>
> 
> hcon->remote_id last use was removed in 2024 by
> commit e7b02296fb40 ("Bluetooth: Remove BT_HS").
> 
> Remove it.

Please also add a Fixes: tag.

> Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
> ---
>   include/net/bluetooth/hci_core.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index b8100dbfe5d7..32b1c08c8bba 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -749,7 +749,6 @@ struct hci_conn {
>   
>   	__u8		remote_cap;
>   	__u8		remote_auth;
> -	__u8		remote_id;
>   
>   	unsigned int	sent;
>   

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

