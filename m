Return-Path: <netdev+bounces-107112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1791919E29
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 06:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E111C23218
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 04:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC7B18E06;
	Thu, 27 Jun 2024 04:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CiuzSJaQ"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C86DDA0;
	Thu, 27 Jun 2024 04:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719462580; cv=none; b=rjVB7gjXa9oMLOWY+Zkq3AOtmd0RlgXB6tMinElgMpeRiglF44hqunDul3cSyhvThFXVZBT99yXvHO6KkITQRSyXXQ5L2RkeY5tERIRBkeYKLh90vBg/Q74+uZQ3uyz9s0RjOH4WKd5KQ4cghJ1UJ/I4ZSolLtuxZ6FYTGnHnuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719462580; c=relaxed/simple;
	bh=KtcWo65waXRGSPn0iqCOjDZmJvKqRvvSIQ3mV+65De4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4fKYUDUAQvIMiiJl8m4zT5Zf4j9FuyvuUWAKWV3q+oPEyI3GHTvS+qq69RMYQVMeM1ajq96wl+YedJSYFGeXC+5/84ocDKlTrBxByIBbNyCwSXm/86HhTIplf3I6KDkUSeMAQ8nv+WxdMeAjlj0WkRxcqeRvTwJnjuqn4agh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=CiuzSJaQ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 057C588027;
	Thu, 27 Jun 2024 06:29:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719462576;
	bh=hLwf+KWvZOIT/6XX6OUmEpBoC6+4FW5Mca6/c3/zNwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CiuzSJaQ3ScejEUYdbVfyF/PgSdfOWVqB0VGVCJliM7PWME+a0x7vrP+4+6bwhMp8
	 GEjryXy4vmaoj7KYFMUG+0UbAUO910mlbZcLzigRPie3/Z5QT0krTIGanJQZymWSaF
	 CmnPHZhw+M3TVKJlTZeLCR8zqgNt0Ragnt1LAHhuycDLjx8ovqxXL71Vbqb65i1HSa
	 b0cDzjC2pa3n/ZSAduLJ4PjVOxqROP6yp2p3cKWaZdsRDFT4Mcun0+9yq3XnBYna5u
	 pCXMAuBgfmxS+9Od9a0qfd3q/57TLJKC/53EGphJiPS0vxn3QEmxHgIjkibFwm7iat
	 ArqQaA0DtXrEg==
Message-ID: <36f46cea-0811-47dc-8741-042d9b88df88@denx.de>
Date: Wed, 26 Jun 2024 21:47:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: phy_device: Fix PHY LED blinking code comment
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, kernel@dh-electronics.com,
 linux-kernel@vger.kernel.org
References: <20240626030638.512069-1-marex@denx.de>
 <9656eb1a-921b-4f2e-b01f-7df7d890254e@lunn.ch>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <9656eb1a-921b-4f2e-b01f-7df7d890254e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/26/24 7:32 PM, Andrew Lunn wrote:
> On Wed, Jun 26, 2024 at 05:06:17AM +0200, Marek Vasut wrote:
>> Fix copy-paste error in the code comment. The code refers to
>> LED blinking configuration, not brightness configuration. It
>> was likely copied from comment above this one which does
>> refer to brightness configuration.
>>
>> Fixes: 4e901018432e ("net: phy: phy_device: Call into the PHY driver to set LED blinking")
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> There is a lot of context in this patch. Do you have some odd git diff
> settings?

I did use git format-patch -U10 this time, to make sure that context is 
visible. With regular git format-patch, the diff contained only part of 
the comment and it wasn't clear from the diff that it does modify 
comment above (*led_blink_set)() and not e.g. (*led_brightness_set)() .

