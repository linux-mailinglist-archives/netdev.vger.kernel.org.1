Return-Path: <netdev+bounces-139793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA429B4202
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 06:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC4F1C2133B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 05:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB8C20100D;
	Tue, 29 Oct 2024 05:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="cORtWZBO"
X-Original-To: netdev@vger.kernel.org
Received: from mx23lb.world4you.com (mx23lb.world4you.com [81.19.149.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2E200C82
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730181497; cv=none; b=jET2QHbICCqKEPCFs0+OcpVertRjV+NLPdOm6b3Pn6RutBefWil525IwDEDPovlkxJB8GxWxBC767fjvtvj1daSLjPBKhE7PkBCYxXbk+crH993HfC7L58Twt09P8Cc+9gEWMcA859n0B+Dgc8SrNBURVaSa8M/PjxwKTFzgK7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730181497; c=relaxed/simple;
	bh=gGn4Q0Xd8aefOl64aeK3K6CtkeTaIuaGBxjhxrlFJ94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIgRxb8PBrKO6penQRBMkYDgYt4JpnxKE2NLW2B0UMuAM4EFMKngjWDib5AiiKaoOOlK+u5W3w9iEjTxno3oM88J5l15wBrafhIB5EBq9kDk4hDiMY+KuKYZVayCZdgCBeZ3IM7HCI0lTppUJoGHI8JHPH2NpdOB+4p6vW81Vww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=cORtWZBO; arc=none smtp.client-ip=81.19.149.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r8ErtTVN8eUial96oEnfdxaZwUwifdhSsfp7NiNsfo0=; b=cORtWZBOsvcZh0k90Syeu7c61P
	lln+gNVGBOEeM9NauruQF+NtIH71BOUs2amwig0dvOVE7zTL+7LijE/RI3BE+xCnycI986mi5WC6W
	t7vSWbebEFAMwWhVKq8LfhsCvmQxOnCQ6FCvgyWCsiJiaCO3jGMJ7H5Ayy3dM1IZUSYM=;
Received: from [88.117.52.189] (helo=[10.0.0.160])
	by mx23lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1t5fF7-000000001PA-1nuo;
	Tue, 29 Oct 2024 06:58:13 +0100
Message-ID: <436283e7-16c3-46ef-9970-13ddbf3a2de3@engleder-embedded.com>
Date: Tue, 29 Oct 2024 06:58:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: phy: Allow loopback speed selection for
 PHY drivers
Content-Language: en-US
To: Lee Trager <lee@trager.us>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com
References: <20241028203804.41689-1-gerhard@engleder-embedded.com>
 <20241028203804.41689-2-gerhard@engleder-embedded.com>
 <adada090-97fc-4007-a473-04251d8c091f@trager.us>
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <adada090-97fc-4007-a473-04251d8c091f@trager.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes

On 29.10.24 00:23, Lee Trager wrote:
> On 10/28/24 1:38 PM, Gerhard Engleder wrote:
>> -int genphy_loopback(struct phy_device *phydev, bool enable)
>> +int genphy_loopback(struct phy_device *phydev, bool enable, int speed)
>>   {
>>       if (enable) {
>>           u16 ctl = BMCR_LOOPBACK;
>>           int ret, val;
>> +        if (speed == SPEED_10 || speed == SPEED_100 ||
>> +            speed == SPEED_1000)
>> +            phydev->speed = speed;
> Why is this limited to 1000? Shouldn't the max loopback speed be limited 
> by max hardware speed? We currently have definitions going up to 
> SPEED_800000 so some devices should support higher than 1000.

This generic loopback implementation only supports those three speeds
currently. If there is the need for higher speed, then there should be
PHY specific implementations in the PHY drivers.

>   Why is speed defined as an int? It can never be negative, I normally 
> see it defined as u32.

speed is defined within phy_device also as int. I aligned the data type
to this structure.

Gerhard

