Return-Path: <netdev+bounces-115411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 050C39464B1
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 22:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B476D281A31
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 20:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7031D3EA98;
	Fri,  2 Aug 2024 20:56:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D61ABEBA;
	Fri,  2 Aug 2024 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632199; cv=none; b=jJhfb6cVNNpO6LmhYy6bFY4hrqBDTUuVIGbPmJq1aibSF18BG8NHi69RHNESRJ/nQXGm+lalR9DEhTkR20LB0+xkwN3a86YS8EsylXojjx4yGlTfUAADLLDYZHSmRChgUNXFtj9zlGPhKX4gqK9BBAegcAPTYIpcIIaZEHvGo/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632199; c=relaxed/simple;
	bh=6w6w6n8KiMbP6wnH8x1Ba6TfTvEaAgeqvTHnPFk8e7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7sgsTnr9D+N+vb4SiRmEFTX3alor0NAm4m98iuNsLbnuPGDV08dKgo0rm3Rghw0BhEKAhApsHb0oeSVan+A3LyelysLrIJniLtEiPoiiEQAcbfVZ8XUL0AWh8YZgpwVrMgdntBbOPhHkTVjdEOGICmdQtmsWCMZDXAUvNWa2Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af10f.dynamic.kabel-deutschland.de [95.90.241.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 430F061E5FE01;
	Fri,  2 Aug 2024 22:55:46 +0200 (CEST)
Message-ID: <3b36a977-426f-4f5a-9a1f-989a95a55a2a@molgen.mpg.de>
Date: Fri, 2 Aug 2024 22:55:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tg3: Add param `short_preamble` to enable MDIO traffic to
 external PHYs
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Michael Chan <mchan@broadcom.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Roy Lee <roy_lee@accton.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Saikrishna Arcot <sarcot@microsoft.com>, Guohan Lu <lguohan@gmail.com>
References: <20240802100448.10745-1-pmenzel@molgen.mpg.de>
 <CACKFLikjqVZUXtWY5YBJPT56OqW0z00DxkaENzG74M64Rrr81w@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CACKFLikjqVZUXtWY5YBJPT56OqW0z00DxkaENzG74M64Rrr81w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +SONiC Linux kernel maintainers, cf patch submission [1]]

Dear Michael,


Thank you for the quick reply.

Am 02.08.24 um 21:51 schrieb Michael Chan:
> On Fri, Aug 2, 2024 at 3:05 AM Paul Menzel wrote:
> 
>> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
>> index 0ec5f01551f9..9b4ab201fd9a 100644
>> --- a/drivers/net/ethernet/broadcom/tg3.c
>> +++ b/drivers/net/ethernet/broadcom/tg3.c
>> @@ -233,6 +233,10 @@ static int tg3_debug = -1; /* -1 == use TG3_DEF_MSG_ENABLE as value */
>>   module_param(tg3_debug, int, 0);
>>   MODULE_PARM_DESC(tg3_debug, "Tigon3 bitmapped debugging message enable value");
>>
>> +static int short_preamble = 0;
>> +module_param(short_preamble, int, 0);
>> +MODULE_PARM_DESC(short_preamble, "Enable short preamble.");
>> +
> 
> Module parameters are generally not accepted.  If this is something
> other devices can potentially use, it's better to use a more common
> interface.

I saw the patch in the SONiC repository and took a shot at upstreaming 
it. `tg.h` defines the macro:

     #define  MAC_MI_MODE_SHORT_PREAMBLE  0x00000002

Any idea how this should be used? Can it be enabled unconditionally? I 
do not even have the datasheet.


Kind regards,

Paul


[1]: 
https://lore.kernel.org/netdev/20240802100448.10745-1-pmenzel@molgen.mpg.de/

