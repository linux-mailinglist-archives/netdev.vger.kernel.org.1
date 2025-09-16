Return-Path: <netdev+bounces-223529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F654B59675
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1941B27890
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E621581EE;
	Tue, 16 Sep 2025 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wBmAO/DC"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98482D7DCD
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026713; cv=none; b=gYDd472ZWceLBHC7WQ9lame3U/NwiV22Hq+3e8OxTxL7UhYzpdw+iQieIc93+LAZ121Tyikh02Zjc4cR5EK1qSjVzMUFPBxNjzcYouJTnCZX8QQQWje2XLihtqow+VTfxqmrAmMOESWEX/aJ2AhJKujB0mbI00e9COk0ml29A34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026713; c=relaxed/simple;
	bh=FzUCUUXus0/lvP4HuQ7h69MpKibfnnx6lcJF1Jm+eMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGg1AgtpE3yBw02b5MnXEB8VvpTTKRLsstD+HeB4TBebsiwO70O/9oj4EMrojXw4GGEYYwJqkhWPKAAaR2Ah67a1tULVhXCcUU44heQ/ffKcIq484AQhqCUXwPxv/thHVHQGetHa5pkvnxCBzRGCjD3zINFNnttzc95WCcJm08k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wBmAO/DC; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <25108422-5b8a-49ec-89f4-ac5b1453d369@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758026699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtOFTlB5Q16CW97J68iNpibAWAgBtX0/ZjlWESzeId4=;
	b=wBmAO/DCz89ZZFOgPw+uXFG825I59GaCYV50AWXAFWpG3awQOf9GpMJMiUwVdpB6GleEDr
	9wZ1WNom6WbAE75pQXPrZWh7Wlsf+RzZCBVZ8LD+iI0mGFtoo36VAzDCIAwPGNlw/W7xJI
	0zvn9Aew++9m51aQuy9bwr1Q+oMt3xA=
Date: Tue, 16 Sep 2025 13:44:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] ptp: describe the two disables in
 ptp_set_pinfunc()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Clark Wang <xiaoning.wang@nxp.com>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>, Eric Dumazet <edumazet@google.com>,
 imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, netdev@vger.kernel.org,
 Nick Shi <nick.shi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Yangbo Lu <yangbo.lu@nxp.com>
References: <aMglp11mUGk9PAvu@shell.armlinux.org.uk>
 <E1uyAP2-00000005lGk-2q9l@rmk-PC.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <E1uyAP2-00000005lGk-2q9l@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/09/2025 15:42, Russell King (Oracle) wrote:
> Accurately describe what each call to ptp_disable_pinfunc() is doing,
> rather than the misleading comment above the first disable. This helps
> to make the code more readable.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

