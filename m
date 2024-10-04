Return-Path: <netdev+bounces-132059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE6D990453
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA481F21301
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1184215F4C;
	Fri,  4 Oct 2024 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="aP9vtyvq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8542E215F63;
	Fri,  4 Oct 2024 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048462; cv=none; b=CI61v9dDACp2CHE0i/NaVr+YTicYGsFmzA8RKLtuHzAxR27Wk56zXLfb1O1rA29ae/LSlP66//SJ/vNtlk0RSaaEyWJN+koeBn4XcmUT43X0goPLPuHMzMKODIEn6Rnjx1CJ58tHj5EV0vwNBO9ZJ6bKPOkcflkX+5WAmtO4XNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048462; c=relaxed/simple;
	bh=wXOvCcdCOFnCU6NncgYUeYLI/oZaAgPJrFGjm1nUCac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qptqGAIB3zlRFL1234yIulHqOj8DXtUAmdzR/Ksq3YXHIqDMCSjWVNl0FB9ACLr4WEAP3NH91CvwdNxrFN8yUvwn8qDWPBYgfyFOrsj6Vs+Jc7FQbcFDd59E0XGNLDD0UGCtP3Avr5AOlAbZUGWWg6d6mtrwLy9IxmTA3Ku8MJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=aP9vtyvq; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id wiLHsrcDKQ2lWwiLHsVTtm; Fri, 04 Oct 2024 15:27:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1728048457;
	bh=bzI6W4OG5I3nv3GvEI+4yHlLOPUJAHIjWK4G/3umQj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=aP9vtyvqNVC7LqYhz52g4D6jO7Z58BcXZrnZEzb6pwJs6b7pbRXUPuSHijzA3F+4y
	 UH0wUu3fQwro/m3kxGnKmmF6650sCAmwbyYGvj493UhsBFqn4H6QcstWL8WNta0RqG
	 FfhFiE2TCFyMF50WMgHMb7bPqLeWTlr8Ovj571XuMUteAvschfF9jAWk6+rRHRKJaF
	 Fejd1HM22WU2MUOvWzRrXgt6vuvINSnCmlvSaBco+XdYsQ8Q+f9iwI9hsGFWGSTdPp
	 b44nJ5+jRqtRS/VmXSPSM8GpBrBuG2uLXqKsKJAY2SI7fisw3cYYIix1h4HK2Amqti
	 UHsrnEFGpP8lA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 04 Oct 2024 15:27:37 +0200
X-ME-IP: 90.11.132.44
Message-ID: <bf75a318-a3e1-4d03-85f3-63b316b22346@wanadoo.fr>
Date: Fri, 4 Oct 2024 15:27:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: adi: adin1110: Fix some error handling
 path in adin1110_read_fifo()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Lennart Franzen <lennart@lfdomain.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org
References: <8ff73b40f50d8fa994a454911b66adebce8da266.1727981562.git.christophe.jaillet@wanadoo.fr>
 <63dbd539-2f94-4b68-ab4e-c49e7b9d2ddd@stanley.mountain>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <63dbd539-2f94-4b68-ab4e-c49e7b9d2ddd@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/10/2024 à 13:47, Dan Carpenter a écrit :
> On Thu, Oct 03, 2024 at 08:53:15PM +0200, Christophe JAILLET wrote:
>> If 'frame_size' is too small or if 'round_len' is an error code, it is
>> likely that an error code should be returned to the caller.
>>
>> Actually, 'ret' is likely to be 0, so if one of these sanity checks fails,
>> 'success' is returned.
>>
>> Return -EINVAL instead.
>>
>> Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> This patch is speculative.
>> If returning 0 is what was intended, then an explicit 0 would be better.
> 
> I have an unpublished Smatch warning for these:
> 
> drivers/net/ethernet/adi/adin1110.c:321 adin1110_read_fifo() info: returning a literal zero is cleaner
> drivers/net/ethernet/adi/adin1110.c:325 adin1110_read_fifo() info: returning a literal zero is cleaner
> 
> It's a pity that deliberately doing a "return ret;" when ret is zero is so
> common.  Someone explained to me that it was "done deliberately to express that
> we were propagating the success from frob_whatever()".  No no no!
> 
> I don't review these warnings unless I'm fixing a bug in the driver because
> they're too common.  The only ones I review are:
> 
> 	ret = frob();
> 	if (!ret)
> 		return ret;
> 
> Maybe 20% of the time those warnings indicate a reversed if statement.
> 
> Your heuristic here is very clever and I'll try steal it to create a new more
> specific warning.

Well my heuristic is mostly luck, here ;-)

Anyway, what I was looking for (un-initialized last argument in some 
function) could be nice to have in smatch, if not already present.


Finally, if you want, I can give a look at the warnings if you share the 
log.

CJ

> 
> regards,
> dan carpenter
> 
> 
> 


