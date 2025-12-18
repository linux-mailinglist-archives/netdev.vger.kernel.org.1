Return-Path: <netdev+bounces-245403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F6DCCCF90
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 18:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06950300F9FA
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421833002DC;
	Thu, 18 Dec 2025 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GTDFWtVo"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162752FFF90;
	Thu, 18 Dec 2025 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766079194; cv=none; b=ssOvyNX85WhrHGUQTmgWK5uLIJ83OiJNwCPwk+BeiBIkOIH54//bN6xkvxKMt+yM60m6Tn9E8IEGqKVFgjGyE+0LaBt1PXTYqGLU3dzEbXuleFrkGGly0U58RANrRz1VosqKR/0A/LY9sgurtqYuyRSJwSpHgkae76neOWVaED4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766079194; c=relaxed/simple;
	bh=BRNfsoVtFyj8k/Ogg+BkBLDieL7b4UX2EYRr6GnyOxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uo4iIiVld4891uVpVg98+bEEWUvXZPnjqUhoDws7zqwZvwnxEIFmtD1srt09fUcDLi5WOdNGs4NE5X3u4VPXcrUQIPxuIjxmiMQP2hxxlMClh1krTTO5uAT+IpVdXUpMIBzuJI9B0hVs9G6/NV5d3SxqOUHQmD/emPnzathfb1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=GTDFWtVo; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dXHnH0fn8z9sky;
	Thu, 18 Dec 2025 18:33:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766079187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgkuC1m4Oid887kzrkiQC1Ee5Df1QY6+DU83kHcDiik=;
	b=GTDFWtVofqviBPwPwCPpNxbOthm/e/vmS6KhQ0JbsHpcX1GrY3W8d2VEEtrrvr9wMZWpV7
	e+t+Yw8LMzpQ8evnygbyHY39PCBykGa1nc6e+UmYkM2MCAuPdP4dgJOdQeA8TH1MD6yJ6A
	1ecWEGxQ1O3n19GWGFbNDsZrrdLj529V2lvpEi6pa0vnqf55VAEbkfFNkMAk4JPMxGR4zY
	u04RWRZ/ACu/sJB28iY/FKkx4+BSV0V5QIWjgKJJ9ci+Xe9n7RZkCUDUJnpTQTvwTGQcXq
	D2PixgRL0VptoxGHJMn3r/HUq66e66XdwrN2cS+zggnqJPQVSG2EIJ9cVylqDg==
Message-ID: <5b6cdd76-30a7-49be-8ccf-b90ede78b15a@mailbox.org>
Date: Thu, 18 Dec 2025 18:33:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH v2 3/3] net: phy: realtek: Add property to enable
 SSC
To: Sai Krishna Gajula <saikrishnag@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Ivan Galkin <ivan.galkin@axis.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20251203210857.113328-1-marek.vasut@mailbox.org>
 <20251203210857.113328-3-marek.vasut@mailbox.org>
 <BY3PR18MB47076A26714A7AC5A34D7F32A0A1A@BY3PR18MB4707.namprd18.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <BY3PR18MB47076A26714A7AC5A34D7F32A0A1A@BY3PR18MB4707.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e536153fb2d4297c2e9
X-MBO-RS-META: ohhqdxb9jzceachq1duhwnu3apyufhrp

On 12/11/25 7:39 PM, Sai Krishna Gajula wrote:

[...]

>> +	ret = phy_write_paged(phydev, RTL8211F_SSC_PAGE,
>> RTL8211F_SSC_RXC, 0x5f00);
>> +	if (ret < 0) {
>> +		dev_err(dev, "RXC SCC configuration failed: %pe\n",
>> ERR_PTR(ret));
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int rtl8211f_config_sysclk_ssc(struct phy_device *phydev) {
> 
> Minor nit:   Kernel style requires the opening brace on the next line, also in other places.
> static int rtl8211f_config_sysclk_ssc(struct phy_device *phydev)
> {
The patch looks correctly in lore archive, see:

https://lore.kernel.org/all/20251203210857.113328-3-marek.vasut@mailbox.org/

The patch also looks correctly in my mailer, it is only the 
aforementioned quoted text that seems mangled. Maybe your mailer did 
something odd with the patch ?

