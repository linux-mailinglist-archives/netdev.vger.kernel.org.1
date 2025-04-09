Return-Path: <netdev+bounces-180635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80F8A81F60
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EBDB7ADC30
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C5225B666;
	Wed,  9 Apr 2025 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="cjEK7bVz"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-17.ptr.blmpb.com (sg-1-17.ptr.blmpb.com [118.26.132.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6998625A34C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744186106; cv=none; b=d5wBpnaa1jcj8xmrkPe7Um+/hfz0sd/NgSPJ1C0WNK+lK+29OqVVaE87YpDuBJI+jIXI4KPF2ynZwu7yBUP5dtNldaNsMExKAge1sYm38r02wKUeK699PgqouU6cQBvUmRB/QYFmDu6rTR7lhsSUma5hMBKc4V/T9+duq8opsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744186106; c=relaxed/simple;
	bh=L0ad126ns5HYos4G9yZe+P++7g9sra1NFzmlHL8byp4=;
	h=In-Reply-To:References:Content-Type:Message-Id:Date:Mime-Version:
	 To:Subject:Cc:From; b=eiVbOZcy2KwQe/Q45rA0sUtkGG4984PoDAXZUIXf38ylLtcFRpdm0TNQ99NBDAHJysScuy9jQyxzEBdIrOkfot77oaoSo/t1Mu/wU3WDbJd4Hc8qDiujivmBxUvsYWrSeDikcNnfc5vAPH62Yu0RbjLqvLzUAxCnVFGn7owdL2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=cjEK7bVz; arc=none smtp.client-ip=118.26.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1744186093; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=3rhscFQ2xYH93N3pO2le7/nTawc/35SRj/Ac27FaI6k=;
 b=cjEK7bVz1WhwC5Nxs1Tg4FmwLxiGLfQDemDQN+mmnZtY6+2uswpPut3MQqgVxMtWvwjRQ8
 QzWfyFzwJnbgzotdrjjqIl8gEiRrmmhSae62OQX1gBtK3Xpcnz32KhnP+jwp3e00Al7xWq
 4Yv1v+jpj45HGvu9+9SLEUG9mLz1M1cOPBjahpo+hB2yJbPlWFnjdfEn5rwtHMDzCbpmDf
 ZEZSDLqNi4gNYkKC9u7pdTIw1RQMfiMIonHMvyCjlTqXvdpad1rQaSQ8oMFSR0RFdnFFr+
 nTzg+k8QrXnTkg7+5S6EvK5ZirkQb3usIUOS/pFfffqwf8R/a38VQGF+b0iNwQ==
In-Reply-To: <20250326103111.GC892515@horms.kernel.org>
References: <20250318151449.1376756-1-tianx@yunsilicon.com> <20250318151522.1376756-15-tianx@yunsilicon.com> <20250326103111.GC892515@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Message-Id: <3c50fd47-ad7d-4b0c-9081-1b637035ef33@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Date: Wed, 9 Apr 2025 16:08:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: "Simon Horman" <horms@kernel.org>
Subject: Re: [PATCH net-next v9 14/14] xsc: add ndo_get_stats64
Received: from [127.0.0.1] ([116.231.163.61]) by smtp.feishu.cn with ESMTPS; Wed, 09 Apr 2025 16:08:10 +0800
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>, 
	<davem@davemloft.net>, <jeff.johnson@oss.qualcomm.com>, 
	<przemyslaw.kitszel@intel.com>, <weihg@yunsilicon.com>, 
	<wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>, 
	<kalesh-anakkur.purayil@broadcom.com>, <geert+renesas@glider.be>, 
	<geert@linux-m68k.org>
User-Agent: Mozilla Thunderbird
X-Original-From: Xin Tian <tianx@yunsilicon.com>
From: "Xin Tian" <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267f62aeb+e61594+vger.kernel.org+tianx@yunsilicon.com>

On 2025/3/26 18:31, Simon Horman wrote:
> On Tue, Mar 18, 2025 at 11:15:24PM +0800, Xin Tian wrote:
>
> ...
>
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
> ...
>
>> @@ -1912,14 +1931,20 @@ static int xsc_eth_probe(struct auxiliary_device *adev,
>>   		goto err_nic_cleanup;
>>   	}
>>   
>> +	adapter->stats = kvzalloc(sizeof(*adapter->stats), GFP_KERNEL);
>> +	if (!adapter->stats)
> Hi Xin Tian,
>
> I think you need to set err to -ENOMEM here, else the function will return 0
> even though a memory allocation error has occurred.
>
> Flagged by Smatch (please consider running this tool on your patches).

got it, thanks

>
>> +		goto err_detach;
>> +
>>   	err = register_netdev(netdev);
>>   	if (err) {
>>   		netdev_err(netdev, "register_netdev failed, err=%d\n", err);
>> -		goto err_detach;
>> +		goto err_free_stats;
>>   	}
>>   
>>   	return 0;
>>   
>> +err_free_stats:
>> +	kvfree(adapter->stats);
>>   err_detach:
>>   	xsc_eth_detach(xdev, adapter);
>>   err_nic_cleanup:
> ...

