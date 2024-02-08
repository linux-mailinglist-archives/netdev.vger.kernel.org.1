Return-Path: <netdev+bounces-70249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8386E84E2D1
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F70D1F266DF
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CE6763FC;
	Thu,  8 Feb 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="fRncyi4n"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34224763EF
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401491; cv=none; b=Ei30AL6m/1mp1Vt/z+OIgOsVieh/LF42pjL64DSFVBWeAw0w+VWBqCGyja0dlQISjanj2M/GLxSUcuSlBGYGVTV6RRxSFqDfHO0Ef7IG13JThixED48Ngx+Nbjs47A8EAkS7bD0YulY4+X+ZnrftFpgL3GBxoT7U+BUduNO1T78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401491; c=relaxed/simple;
	bh=xtwDn75Tz6e94RW5GLFfK+lijBtQ41Nn6qsYmZWhhxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tv9ue4h0yvcAdePXiIpUoVDuuIpciMxjpuluBBye+0VgWluA/kXZQofGjlKZzYN8FJi/YzavzQDw9u1XmWZ3DsRQCGKcVo651oQyZDto/0Dk3cQN94kr+K9PwKM9vBpd8EnRY9jp6MuGSxd0JtKAbZaomX9NXMy2o8juSzezHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=fRncyi4n; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240208141117783081e56ba0b8cb7c
        for <netdev@vger.kernel.org>;
        Thu, 08 Feb 2024 15:11:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=YllPWmYpM7x9EdeJLCeLEMVnTdnQ3fYg+nWSnMSSUyA=;
 b=fRncyi4nlcHAI7JRYzcX2DyKvYbQrMUKkarJtz7LWeURqJ5IAgM/qz9GeM4uOuJjyGeuLn
 1+8BhrJNlcJyiM0Vm+7qOkD4ku2Sewzje6CMotFkE/Fi/jHyQMJ4FKuZrhKzuYROlHzkM36e
 As5FynYVIJNMn5CUd8YZzHpN7fHo4=;
Message-ID: <ca56b654-c088-4c04-8b00-b24067dd2ec1@siemens.com>
Date: Thu, 8 Feb 2024 14:11:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: ti: icssg-prueth: Remove duplicate cleanup calls
 in emac_ndo_stop()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Simon Horman <horms@kernel.org>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 vigneshr@ti.com, jan.kiszka@siemens.com, robh@kernel.org,
 grygorii.strashko@ti.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
References: <20240206152052.98217-1-diogo.ivo@siemens.com>
 <20240208104700.GF1435458@kernel.org>
 <2fa5f053-6b4f-40e4-86f5-807c3c6dfee9@moroto.mountain>
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <2fa5f053-6b4f-40e4-86f5-807c3c6dfee9@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer


On 2/8/24 13:33, Dan Carpenter wrote:
> On Thu, Feb 08, 2024 at 10:47:00AM +0000, Simon Horman wrote:
>> On Tue, Feb 06, 2024 at 03:20:51PM +0000, Diogo Ivo wrote:
>>> Remove the duplicate calls to prueth_emac_stop() and
>>> prueth_cleanup_tx_chns() in emac_ndo_stop().
>>>
>>> Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
>>> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
>>> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
>> Hi Doigo,
>>
>> I see that there are indeed duplicate calls,
>> but I do wonder if this is a cleanup rather than a bug:
>> is there a user-visible problem that this addresses?
>>
>> If so, I think it would be good to spell this out in the commit message.
>>
>> ...
> So far as I can see from reviewing the code there is no user visible
> effect.
>
> rproc_shutdown() calls rproc_stop() which sets "rproc->state = RPROC_OFFLINE;"
> so the second call will return be a no-op and return -EINVAL.  But the
> return value is not checked so no problem.
>
> prueth_cleanup_tx_chns() uses memset to zero out the emac->tx_chns[] so
> the second call will be a no-op.
>
> regards,
> dan carpenter

Yes, it is just a code cleanup. Is the commit message fine as it is?


Best regards,

Diogo


