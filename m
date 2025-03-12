Return-Path: <netdev+bounces-174115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E45A5D8B5
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4686716B8B7
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 08:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815ED23644F;
	Wed, 12 Mar 2025 08:57:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2E11B6CF1;
	Wed, 12 Mar 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769838; cv=none; b=l9rEOgGP2xGHtwFA9UwmMgdZKxRUEFVA9qvoAlnWAmop5yw6R6MlujDu3UigwH1rgG5mBrJSHqmIFHzNpXBQe1FQI8s/zqAckDe0XUbD3sMMp9eP44uizhinpGYxx9jzIWjffScFkEJgAcGyYqeC2gxq+FBNSbMwZQ+Dr1uijJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769838; c=relaxed/simple;
	bh=BCmP6T//nG2YqwP/jSL4GXaPOKeO31UqtsTcys901gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sp+cGDJmeVmrb1LUTdaYRTrDi/FxTm/yW8O1V+HoHUzLjyvhg3tvbUrgviohwqbrOFb1xTbL38dWw9tSQ4D1Xogp3t38vstV6WsUCEHmQl0B1BRT0R3n/m9EOUDsVrxf2gWQu5J2Y4q0cGl34Jo/gpctmH6b8MPMbBkrTj167U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5ae865.dynamic.kabel-deutschland.de [95.90.232.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 570CB61E64844;
	Wed, 12 Mar 2025 09:54:02 +0100 (CET)
Message-ID: <7c2626fa-d923-4ef8-a102-2d9413319110@molgen.mpg.de>
Date: Wed, 12 Mar 2025 09:54:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: HCI: Fix value of
 HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE
To: Si-Jie Bai <sy2239101@buaa.edu.cn>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, cuijianw@buaa.edu.cn,
 sunyv@buaa.edu.cn, baijiaju@buaa.edu.cn, =?UTF-8?Q?Jonas_Dre=C3=9Fler?=
 <verdre@v0yd.nl>
References: <20250312083847.7364-1-sy2239101@buaa.edu.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250312083847.7364-1-sy2239101@buaa.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +Jonas Dreßler]

Dear Si-Jie,


Welcome to the mailing list, and thank you for your patch!

Am 12.03.25 um 09:38 schrieb Si-Jie Bai:
> HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE is actually 0x1a not 0x1e:
> 
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 1, Part F
> page 371:

The above length is 66 characters (< 72), and fits in one line.

>    0x1A  Unsupported Remote Feature
> 

Maybe add:

The value was probably changed by mistake, when defining the macro.

Please add a Fixes: tag. It should be:

Fixes: 79c0868ad65a ("Bluetooth: hci_event: Use HCI error defines 
instead of magic values")

> Signed-off-by: Si-Jie Bai <sy2239101@buaa.edu.cn>
> ---
>   include/net/bluetooth/hci.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 0d51970d8..3ec915738 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -683,7 +683,7 @@ enum {
>   #define HCI_ERROR_REMOTE_POWER_OFF	0x15
>   #define HCI_ERROR_LOCAL_HOST_TERM	0x16
>   #define HCI_ERROR_PAIRING_NOT_ALLOWED	0x18
> -#define HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE	0x1e
> +#define HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE	0x1a
>   #define HCI_ERROR_INVALID_LL_PARAMS	0x1e
>   #define HCI_ERROR_UNSPECIFIED		0x1f
>   #define HCI_ERROR_ADVERTISING_TIMEOUT	0x3c

With the above fixes, you can add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

