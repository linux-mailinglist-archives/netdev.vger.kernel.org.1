Return-Path: <netdev+bounces-174711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2168DA60011
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634B1421BC0
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 18:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5BE1EEA4A;
	Thu, 13 Mar 2025 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="Jb58RZLs";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="2ggEdGat"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3351CAA6E;
	Thu, 13 Mar 2025 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892092; cv=pass; b=P08/mESzAGIdXCGQCZrMVNOFyHYJAXienSM+MVf4dFuzyEqF8Fj8CtkYiJOFw8jrBxJJbZ2HT+AxwqWoW7H68/SdQE5czOwMQqB6/4eN0IH81HNB51wC0AquiFSBwyFbLBHIa6NcMR/GguuPEAwCaKJkF2yJKFcvA8zhDtyVODs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892092; c=relaxed/simple;
	bh=CaZpgSYtCH4wIyDEkb0dXSqO4VQYc8DrmJcMXYFTx9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcfDhupkqQFZ6gyNAi/VYOtpoQfjntl0q/MAmMAKTNSv7LgwQbuldhIBxuHN7U9cjmiPUVgBM9OuKr8JMJeXjcrm+9KxSACTehrt7pL91iwzNapNSraZeco8HX+F+XYJpL5r915UecM817JqKU+69sF0K7MZYQ8Vdq05aEJdF6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=fossekall.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=Jb58RZLs; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=2ggEdGat; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fossekall.de
ARC-Seal: i=1; a=rsa-sha256; t=1741892086; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GcAsiLlvCXj8PHDT+MgcN8oUjG6QswLD7idPFQg3P3EG3vdbTX2qYrPHk+9BFW6COe
    B5Ju0/lReHYtWSy+MRb2zK0aJtCWlsiiPB+QsuWmoc5BXlJnFhD6g7qXBuxTfmcQHbEw
    LOhEgOCGNrd/D6C+fS3dMA3Ow3AiyUaZRxfduSjOy14YdBsHX4O94K3g2So1A5iPFyAT
    Pqr+djnfzpC4ZhjdeDTlM2MNXx6x3329ZGFKr29/A4iJNc1fi4c0WGvBCDJfFwbnXJtd
    4xD/hgzWqZyhdk4WdmgbvnI7fku/rNfZLBuhOrAO6/R3bSkWIgTkGOMUS0n1QX1WmVW9
    az5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1741892086;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=SgCrvoN6Qoq9w0OBDlTcNPxcHVbNiRs3HNs+Dd44VXU=;
    b=NvpkExZiK7u9eNzB1i1l0d/wDWd59UssFxjMo4zf8m7I0vb1SCTRBA0Frhp/ZXW95b
    WvqrgonmrIR3c870+KAjXhn7OgbETAMPGTwb52kf1er5W9Q418N5mqE6GYa43WfbsHa6
    BSDFxG5oxO9c2MvK6RslNeK3gd2e9NZ8ce/Pe9f3Ht865RXFFIknBuNr8cIldF9wGoio
    gy4wBGIpkbXMrLcuuBqFeSmDqo+XfiSx9P/g2sxYSbqcfQcqhdWHv0FgU8/LlZ48Bo2D
    QAJlfvk6JEzl3tLaYmzZ27JNHIhI6GX/pJUJLdVLwLB9btyqHxvi3KcG2V8Ubr480/m7
    pXRg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1741892086;
    s=strato-dkim-0002; d=fossekall.de;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=SgCrvoN6Qoq9w0OBDlTcNPxcHVbNiRs3HNs+Dd44VXU=;
    b=Jb58RZLsAZHrogGI7vZdiA0B5mur18q7n0UlIwf56hz26vu3Iq6FKI2Shf4yI9CnnR
    JQ1vc68oC0byb7zZfWEccQ0MXGDKb2Ix4/jHFi4Yo84SB1UJuAX3YonafIWnDgNdSr79
    IAOtfDDlkSRE965T3m6SDbbpG+gsB9/oO47+Ao8h2Qt2fk52Oebxdz2K5dXaSp3BDzNN
    PrXen3hovBg9ZtQcBYYIg5ZChVqJYS0jRzgnlAXSuY/kmfUJP4PPkvOcHfYqoeeoTRlt
    iwvoexhlW4F22ddXcs6QLnz9vzled2sA24ZUsFSmXydIdmvGsdI8iLJaesi+SfeD7kfz
    aXQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1741892086;
    s=strato-dkim-0003; d=fossekall.de;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=SgCrvoN6Qoq9w0OBDlTcNPxcHVbNiRs3HNs+Dd44VXU=;
    b=2ggEdGatQ1dzUrOq9fDJwBRyAvYALEmFi9mYllcqYFMfGkar1/lLF7IsdIP3+O/086
    wj8nE11rF0iMw1zHxgBw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512DIsjqNf
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 13 Mar 2025 19:54:45 +0100 (CET)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <michael@fossekall.de>)
	id 1tsnhc-0001xg-2p;
	Thu, 13 Mar 2025 19:54:44 +0100
Date: Thu, 13 Mar 2025 19:54:43 +0100
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: realtek: Add support for PHY LEDs on
 RTL8211E
Message-ID: <Z9Mp86eWYw3hgt0x@a98shuttle.de>
References: <20250312193629.85417-1-michael@fossekall.de>
 <e62af3a7-c228-4523-a1fb-330f4f96f28c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e62af3a7-c228-4523-a1fb-330f4f96f28c@lunn.ch>
Content-Transfer-Encoding: 7bit

On Thu, Mar 13, 2025 at 05:45:05PM +0100, Andrew Lunn wrote:
>On Wed, Mar 12, 2025 at 08:36:27PM +0100, Michael Klein wrote:
>> Like the RTL8211F, the RTL8211E PHY supports up to three LEDs.
>> Add netdev trigger support for them, too.
>>
>> Signed-off-by: Michael Klein <michael@fossekall.de>
>> ---
>>  drivers/net/phy/realtek.c | 120 ++++++++++++++++++++++++++++++++++++--
>
>What tree is this based on?

This was based on mainline, will be addressed in the next version.

>> +static int rtl8211e_led_hw_control_get(struct phy_device *phydev, u8 index,
>> +				       unsigned long *rules)
>> +{
>> +	int oldpage, ret;
>> +	u16 cr1, cr2;
>> +
>> +	if (index >= RTL8211x_LED_COUNT)
>> +		return -EINVAL;
>> +
>> +	oldpage = phy_select_page(phydev, 0x7);
>> +	if (oldpage < 0)
>> +		goto err_restore_page;
>> +
>> +	ret = __phy_write(phydev, RTL821x_EXT_PAGE_SELECT, 0x2c);
>> +	if (ret)
>> +		goto err_restore_page;
>
>What is happening here? You select page 0x7, and then use
>RTL821x_EXT_PAGE_SELECT to select 0x2c? Does this hardware have pages
>within pages?

Kind of; this is from the datasheet:

	6.9.5.  Access to Extension Page (ExtPage)
	
	Set MDIO commands as shown below to switch to the Extension Page (ExtPage) 0xXY (in Hex).
	1. Set Register 31 Data=0x0007 (set to Extension Page)
	2. Set Register 30 Data=0x00XY (Extension Page XY)
	3. Set the target Register Data
	4. Set Register 31 Data=0x0000 (switch to Page 0)

Register 30 is RTL821x_EXT_PAGE_SELECT, LED config registers are on 
extension page 0x2c

-- 
Michael

