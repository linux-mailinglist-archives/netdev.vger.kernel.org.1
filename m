Return-Path: <netdev+bounces-233491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3104AC14590
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1AB1A652AB
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC605307ACB;
	Tue, 28 Oct 2025 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yYdtv9h5"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104E218EB1
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650814; cv=none; b=qXv/5oc0eqG3RerM1dO1lEt/KuYFLurSHsur3cqy8zhpzuint+uhYeWAo6oP/BaB9YxdqCER4iUQYTQgSXXSRqdI8yteiaX4UIjza+H9i9O7LkGxwjF3IL48TndURQr45pv7/JOqPpkaFPeo+ieQtqNjINmn168YaBIJMLvEpgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650814; c=relaxed/simple;
	bh=1FYBSuautEIAG7T+Ol4+igQ37gAQWUTKdQpXOUVndIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkhoQjugT8T902CRN0WKGda3qkwMzWkpWuimlEarFjDrfm7In4z0kGNLf+OidUvN8TlAIll3uZPI5KmeAijXL3SgySFuTDVs3kz4OqQ77fU9IuEzqepJtBxOw2Mq0AMnFRS7FsmN83qcUhe3n6LEGbJz0If5dNHbT8Sb8W8w8Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yYdtv9h5; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 44650C0BE9D;
	Tue, 28 Oct 2025 11:26:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 702EE606AB;
	Tue, 28 Oct 2025 11:26:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EA45E102F23B7;
	Tue, 28 Oct 2025 12:26:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761650808; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=uLE0eTiI6TFyVoJFE00DU2l+ZzaA7D7Dyj0PBL3xFBY=;
	b=yYdtv9h5uVkWuAPwLtXjyYlPWVrzUpwiuyAJcIxNZS3FnWiI8ct9+zIZaKSdyGWZdZP7Zq
	6Dy6UfGWkGAJ6vFf6UrdpipfXfA+/6y0JZjGcBXy1n08RfqyODVLfzUarGcsQWBSNy6Eq6
	ShVX2TJDnIWddhfA0wJRrTJmaZNtRt7CbZRMqp+pBfjTC+obK/NtCiqbCJwfebKY6zOXzG
	8a1/owtEn59F7gvrHb+ZdptxURxJG459LLZXNevh9GK7QhH5hFvT4z5jM8IQmEt2I1K6d0
	QT1GSDByFzGwmPhP8J2WgmRwdnFbGX8WtLq8Fn5+PYxER96BAEyr833Ax30ZIA==
Message-ID: <c2686441-7201-470f-b1b5-063c347bea2e@bootlin.com>
Date: Tue, 28 Oct 2025 12:26:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: stmmac: add support specifying PCS
 supported interfaces
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alexis Lothor__ <alexis.lothore@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Boon Khai Ng <boon.khai.ng@altera.com>,
 Daniel Machon <daniel.machon@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Furong Xu <0x1207@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Yu-Chun Lin <eleanor15x@gmail.com>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
 <E1vClC5-0000000Bcbb-1WUk@rmk-PC.armlinux.org.uk>
 <604b68ce-595f-4d50-92ad-3d1d5a1b4989@bootlin.com>
 <aQCcVOYV15SeHAMU@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aQCcVOYV15SeHAMU@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 28/10/2025 11:35, Russell King (Oracle) wrote:
> On Tue, Oct 28, 2025 at 11:16:00AM +0100, Maxime Chevallier wrote:
>> Hello Russell,
>>
>> On 25/10/2025 22:48, Russell King (Oracle) wrote:
>>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>>
>> Maybe this needs a commit log, even a small one ? :(
> 
> Thanks for giving Jakub a reason to mark this "changes required." :D
> I'm not really expecting this to be merged as-is. So why didn't I
> post it as RFC? Too many people see "RFC" as a sign to ignore the
> patch series. Some people claim that "RFC" means it isn't ready and
> thus isn't worth reviewing/testing/etc. I say to those people... I
> can learn their game and work around their behaviour.

Yeah this series needs to be tested and discussed, I am rounding up all
my stmmac platforms in my ever-growing pile of HW as I'm building my
own test farm, but all the glue stmmac boards I have are the ones that
are fairly well maintained (imx-dwmac, dwmac-stm32, sdwmac-socfpga...).
I don't have any stmmac that use the integrated PCS :(

> 
> Yes, it will need a better commit log, but what I'm much much more
> interested in is having people who are using the integrated PCS (in
> SGMII mode as that's all we support) to test this, especially
> dwmac-qcom-ethqos folk.

Let's hope we can get some test indeed :/ 

Maxime

> The 2.5G support was submitted by Sneh Shah, and my attempts to make
> contact have resulted in no response.
> 


