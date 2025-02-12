Return-Path: <netdev+bounces-165683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68FFA3305F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 21:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605D0188529C
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6BD1FF7D7;
	Wed, 12 Feb 2025 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="PcNKHn+U"
X-Original-To: netdev@vger.kernel.org
Received: from mx07lb.world4you.com (mx07lb.world4you.com [81.19.149.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA11FBC96
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390633; cv=none; b=bVv27zwlbXnLvnBXHbSZ3PnkYJH+b/CIsh/nRBU6ViEbYPrsK38OYjgCn+oYa6Yp6jK8QKsJCeaWDXthpwC2UvjdvRfaYOowOxAIx0Bc3BIw9MKR3tf+YIp0CFMH8RiamZMSUfgGtQJ6/g9iyEwFTm4jNpP2FJ8Y1m+B5V5yOwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390633; c=relaxed/simple;
	bh=ou1bOgszxAcWhuKdk9FKr30XrobEhEAkxXVoLyEDzEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGQnvaedCjo5Y5IZaea8/x15iNl/5MGWAf1l8e/TfvTk4+EXnvHflL6Mt1jhGpKgjVqjr6KYZrnNZuMY1DTVkj2yshOf3xQZ5W8OtP4uqLzhsIklSglZLrSsrn94WUcZB577uKJbA3I5/hdQbxRRIPeZQDaz/N0q5XI/GZzYWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=PcNKHn+U; arc=none smtp.client-ip=81.19.149.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KPlWx8XBrRCYRRg1lADy2ZKTR9yU3FlKN7VdzVdidrM=; b=PcNKHn+UX/CKZF2v2Z3oPDigbQ
	/d3QNDwcj/eNWd6u32QxpgmXngWEMWdk3Sy4lPie2DTnSKGlwTHdnEEIW8OPQPaNcjBZcLaPgxayy
	VG+U5eSV3hwJZqQ3gBudhwgHeBkIymBFeKNnoUc3Y5p2JK8/NdybDDV1Ta9BhheOjC/Q=;
Received: from [88.117.55.1] (helo=[10.0.0.160])
	by mx07lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tiIxY-000000002KG-2SEN;
	Wed, 12 Feb 2025 21:03:48 +0100
Message-ID: <b6df96f2-64a1-4b4d-a00d-8fad585d2b78@engleder-embedded.com>
Date: Wed, 12 Feb 2025 21:03:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/7] net: phy: micrel: Add loopback support
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20250209190827.29128-1-gerhard@engleder-embedded.com>
 <20250209190827.29128-4-gerhard@engleder-embedded.com>
 <e52245af-7429-4e86-b7f2-475a7605a47f@lunn.ch>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <e52245af-7429-4e86-b7f2-475a7605a47f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes



On 12.02.25 02:51, Andrew Lunn wrote:
>> +	ret = phy_read_poll_timeout(phydev, MII_BMSR, val, val & BMSR_LSTATUS,
>> +				    5000, 500000, true);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
> 
> This can be simplified to jus
> 
>          return phy_read_poll_timeout(...);

Of course! Don't why I missed that.

Gerhard

