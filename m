Return-Path: <netdev+bounces-175396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDC4A65AA4
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92DB3A3CF6
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A199A191F92;
	Mon, 17 Mar 2025 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="JOYBjSqy";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="93c4xiqc"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8821B191F6A;
	Mon, 17 Mar 2025 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232202; cv=pass; b=o6Bt4YRv0HKrF8Np52Qm/+X1seTiF+5EWwWJSriZisXCpyjEtbg9tP9lTX+sxFFrvE46hj6I11HQ5AH4YWqsvh12rOv5tEtdeLBov39v1oWMyHUIo/lppk6kBZo9S+3PEgTIGQweVnRBfhpygA532w3w3jRS5C5eHxjZXmEDcoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232202; c=relaxed/simple;
	bh=RYIopjR2qgrNYwGQkkxP3+1JQavSU17P1hzaMcAd6jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+yiXrhhEe9HKq/M9hqStcYJSVYzuf7yfCkeCy4Sg+5j3xEvTkRjL5OT3ih+/zTzCS4xTFAPp3kVwfyWy7NhG83y6nEPYwJl14SUS0+1m86bzFbvciVTWaZ/5eR8NUNgOEQRPPG/H/q5Kqhd7QnA2rIvxuSrGX1BNqbVDciGbhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=fossekall.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=JOYBjSqy; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=93c4xiqc; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fossekall.de
ARC-Seal: i=1; a=rsa-sha256; t=1742232189; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XfgHVJRnEvFIRyE426AlIuioq0G/tdnxXZyD1uIeuvRaG70EVm4YmEOTfG12a9CMqk
    mKQG9rE5sqC+em2XEGOV7Fx43T23caf4h+ATilgBqZymOhg7WK6oUyY2PtLRnbwIFFxi
    NpQaendhS3kOdh/0joT9wFE9RbYZpHnP79hJX+1zbZyNN7CvKBuy9uZXG8s/ghw7zlc0
    CljQzQ+Zd0RxD7keaquA01I9bZRtnkzX8qqwWhMHaC6iansnUCiz8nh3jU2rRwZFbyiv
    uSsxVWyO7pDgMOiOuzGnKEjG0Xuu9gAqrgHQ+6SXO6AHM5fQ2Vqb4qANhSiZkaCciEoF
    PmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742232189;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=/F59a+Gyfd7TXHZvd6LrEwh4rqsiLmj2inzcAmSmSFY=;
    b=L5mD7c4zbZi0t/GUUsXFfdjyd8dykl50izCSuMOUgMDzou0nwW8KbOX293zz92dXVc
    KaiO7BHteG6NnIPj/9UH/zWeYjQuRaQ/col8GBTY3uzwc398qTrY3UB4j0uiZ+14LZPn
    DjrYRho1gaoQrJgD+QLvNBkIwwLDpVAfGAEQ5robwIHs1v7yrj6ZcrLPoRidrxmzeXT4
    jH4sc7CCDdM+t2JDapQn8bLazaq4gsXYbi7uSMUlonMSTsDLB2dN21MTNZePUc4sIXxK
    VvZMetblZeWmvSNzA4RBR7JE2SbZKidYGqxb7gtcRBtxnM6MlSkDuUv5tPJU469bTHTp
    nRMA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742232189;
    s=strato-dkim-0002; d=fossekall.de;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=/F59a+Gyfd7TXHZvd6LrEwh4rqsiLmj2inzcAmSmSFY=;
    b=JOYBjSqyA9/kzFFs1vABkhE6tnNLb5PsVSwja8MDpymu9dO6pimi8x7tE9i8ew9z2b
    NlWwvlrrlDDHyTm6EFjIb+rP5cc9wwvnf3xBdMX9H5iftS/TyAoOx0ZapDVtOzkXKMDN
    +guc5IORIAHZldRz1z+Wln3X7GX45hbE8niZJyXOfCHqnOCVtK2maxU8Jk+gtFiMT8Mc
    8KCylmNmQ5mMO5RuG89YfuIiDkVyqZhnWzCVTkXKGkxWZJenjfQp/D4VT81DKEOlPi4r
    161cZFtcQO8tgnkHmIKzdWg9W9F2FCg7tuIXAMl77IbkQG6oEgv6KrsERP3Yle+S6m1x
    QvBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742232189;
    s=strato-dkim-0003; d=fossekall.de;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=/F59a+Gyfd7TXHZvd6LrEwh4rqsiLmj2inzcAmSmSFY=;
    b=93c4xiqc27zLBuVEXw12t9TDnq0nVlILl7vHll2Z+fjJgST97i014xdGzX7HWJJWs9
    57yLVmOW23R+Foi8giAg==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512HHN9FQQ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 17 Mar 2025 18:23:09 +0100 (CET)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <michael@fossekall.de>)
	id 1tuEBA-00032Q-1G;
	Mon, 17 Mar 2025 18:23:08 +0100
Date: Mon, 17 Mar 2025 18:23:07 +0100
From: Michael Klein <michael@fossekall.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next,v3,2/2] net: phy: realtek: Add support for PHY LEDs on
 RTL8211E
Message-ID: <Z9haewIdFv4bed3H@a98shuttle.de>
References: <20250316121424.82511-1-michael@fossekall.de>
 <20250316121424.82511-3-michael@fossekall.de>
 <Z9gEP_w6WvuCC_ge@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z9gEP_w6WvuCC_ge@shell.armlinux.org.uk>
Content-Transfer-Encoding: 7bit

Thank you for your insights,

On Mon, Mar 17, 2025 at 11:15:11AM +0000, Russell King (Oracle) wrote:
>On Sun, Mar 16, 2025 at 01:14:23PM +0100, Michael Klein wrote:
>> +static int rtl8211e_led_hw_control_get(struct phy_device *phydev, u8 index,
>> +				       unsigned long *rules)
>> +{
>> +	int ret;
>> +	u16 cr1, cr2;
>> +
>> +	if (index >= RTL8211x_LED_COUNT)
>> +		return -EINVAL;
>> +
>> +	ret = rtl8211e_read_ext_page(phydev, RTL8211E_LEDCR_EXT_PAGE,
>> +				     RTL8211E_LEDCR1);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	cr1 = ret >> RTL8211E_LEDCR1_SHIFT * index;
>> +	if (cr1 & RTL8211E_LEDCR1_ACT_TXRX) {
>> +		set_bit(TRIGGER_NETDEV_RX, rules);
>> +		set_bit(TRIGGER_NETDEV_TX, rules);
>> +	}
>> +
>> +	ret = rtl8211e_read_ext_page(phydev, RTL8211E_LEDCR_EXT_PAGE,
>> +				     RTL8211E_LEDCR2);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	cr2 = ret >> RTL8211E_LEDCR2_SHIFT * index;
>> +	if (cr2 & RTL8211E_LEDCR2_LINK_10)
>> +		set_bit(TRIGGER_NETDEV_LINK_10, rules);
>> +
>> +	if (cr2 & RTL8211E_LEDCR2_LINK_100)
>> +		set_bit(TRIGGER_NETDEV_LINK_100, rules);
>> +
>> +	if (cr2 & RTL8211E_LEDCR2_LINK_1000)
>> +		set_bit(TRIGGER_NETDEV_LINK_1000, rules);
>
>Do you need these set_bit()s to be a heavy-weight atomic operation, or
>will __set_bit() being its lighter-weight non-atomic version be better?

I don't think this needs to be atomic at all, as the phydev lock is held 
by the one and only caller (phy_led_hw_control_get()).

rtl8211f_led_hw_control_get() also uses set_bit(). Should I change those 
also to __set_bit() in a separate patch while I'm at it?

-- 
Michael

