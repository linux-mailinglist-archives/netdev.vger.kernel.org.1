Return-Path: <netdev+bounces-164498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1961A2E02F
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 20:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B637A28FF
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 19:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89D11E0DDC;
	Sun,  9 Feb 2025 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="Bom1yWAM"
X-Original-To: netdev@vger.kernel.org
Received: from mx08lb.world4you.com (mx08lb.world4you.com [81.19.149.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39D70807
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739128566; cv=none; b=EUEo+iRmLV11sXpNhBYP83zozAMMgVgtQXdCQ9YC+VQI5W7PG9cMegITZFtLCxs/nBwiWGIVr88AJ/rgy6tITr8xZbOngnMSVb0eQYVgvRfOy6Lt6HI+LDwrWjaQbQv6a8S9Arpnz0B1aetFAp6MhRwXO00iePcRcyAfGchscCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739128566; c=relaxed/simple;
	bh=6g8SjhHcFXSYOVNAE9y1JdYHRdixFfmWGNqQ++d7hGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZImagjow7hQGi7HJIm0ZgxNZZUPbyCpOnhfUp6HXWm8gd9Tq1eq3Ze8EJpPTv7f73bTmR9KgFFaB32HlnR0MLEJESt9ziN8ltn1N9/ptDEOEl2wK/s87xsnxv3IIbefbvBhpP4niemIWCqKE/sPwckOqucCAX2sXPr+tYhnK2zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=Bom1yWAM; arc=none smtp.client-ip=81.19.149.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fCH0mDBxH/PPkRq7wZzcifcJ1UIeZy/33QK0wkrDQP0=; b=Bom1yWAMj2Y0aNFYYMPtzT8KS9
	CPB31MN+dTYO8Se/ujtk68b5XMUGqmbv4Gzr/K0g0x9166K8cWcxfHpqHEh2kGWZpJCUvYlMbPppA
	I/j6K4BUWjRChGrrcSCfn/v8DjmEguaPIBswb7CTE6wrEN/9vXwskfQB2D9QyisqjPO8=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx08lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1thCPm-000000005ch-3kmR;
	Sun, 09 Feb 2025 19:52:23 +0100
Message-ID: <d93e1b3a-ac9d-4e0f-b33d-468928e4bdab@engleder-embedded.com>
Date: Sun, 9 Feb 2025 19:52:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/7] net: phy: Support speed selection for PHY
 loopback
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20250205190823.23528-1-gerhard@engleder-embedded.com>
 <20250205190823.23528-3-gerhard@engleder-embedded.com>
 <20250207161614.6a70bef6@kernel.org>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250207161614.6a70bef6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 08.02.25 01:16, Jakub Kicinski wrote:
> On Wed,  5 Feb 2025 20:08:18 +0100 Gerhard Engleder wrote:
>> +/**
>> + * phy_loopback - Configure loopback mode of PHY
>> + * @phydev: target phy_device struct
>> + * @enable: enable or disable loopback mode
>> + * @speed: enable loopback mode with speed
>> + *
>> + * Configure loopback mode of PHY and signal link down and link up if speed is
>> + * changing.
>> + */
>> +int phy_loopback(struct phy_device *phydev, bool enable, int speed)
> 
> nit: if you're adding kdoc please also document the return value.
> 
>   * Return: 0 on success, negative error code on failure.

Sorry, I missed that. Will add return value documentation.

Thank you for the review!

Gerhard

