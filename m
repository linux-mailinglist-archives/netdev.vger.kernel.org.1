Return-Path: <netdev+bounces-159721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4334A16A24
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08691636C5
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 09:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419281AD403;
	Mon, 20 Jan 2025 09:59:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B2CC2FB
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737367180; cv=none; b=Xzy8bfktDgpHxOqSMyFO6oPVLXRV14zT5VpfFmb0GeDKcOoG4IBWC1HMb7rP2D+zbUPsf4ZcSXPNFCeL+IHnJcDLf79fr6/99UZogoZ+6uuH0SrPiOS2rbDwA6Fhm7e1Ft9Zi5dIZgesBDxtIqQEFcXw9FyO70Col44YFpUK93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737367180; c=relaxed/simple;
	bh=Gw8wsQkHM0sDtp2QvURFO3m4h9uIqqkdPlp/2WdQJ9c=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=f5b3jkostmAzMxMjGgdJFjMXQwPzOQ3LWNpmpM80TP8FvYnQfGCxQweJb5gf1pseFRlYnlGfnX0/0OU2RwqqoG1Bsj4JfCaFE5SfankgCt1gRi3Vzp9/sj/R4jKTAa91lRvBZvRzVJyXPGa5/1RxmrIRZwkftdrR95KB79n9acA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas4t1737367144t093t62445
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.197.136.137])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 17542201142139390390
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: "'Andrew Lunn'" <andrew@lunn.ch>,
	"'Heiner Kallweit'" <hkallweit1@gmail.com>,
	<mengyuanlou@net-swift.com>,
	"'Alexandre Torgue'" <alexandre.torgue@foss.st.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'Bryan Whitehead'" <bryan.whitehead@microchip.com>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"'Marcin Wojtas'" <marcin.s.wojtas@gmail.com>,
	"'Maxime Coquelin'" <mcoquelin.stm32@gmail.com>,
	<netdev@vger.kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk> <06d301db68bd$b59d3c90$20d7b5b0$@trustnetic.com> <Z4odUIWmYb8TelZS@shell.armlinux.org.uk> <06dc01db68c8$f5853fa0$e08fbee0$@trustnetic.com> <Z4pL3Mn6Qe7O45D7@shell.armlinux.org.uk> <073a01db6add$d308af40$791a0dc0$@trustnetic.com> <Z44dOlfRN5FmHcdS@shell.armlinux.org.uk>
In-Reply-To: <Z44dOlfRN5FmHcdS@shell.armlinux.org.uk>
Subject: RE: [PATCH net-next 0/9] net: add phylink managed EEE support
Date: Mon, 20 Jan 2025 17:59:03 +0800
Message-ID: <077f01db6b21$ef6e07e0$ce4a17a0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJuuL6961zeRYLpn6fcQniPsxo8VAIOTZqlAVk2sswCDJNSGAGgOtUSAjt5IngCKL/5j7GdDUgQ
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OEeUM9u23o4fex/ezZhTh0TEF9bKwflqu7KBqIlRa/q8wIcXqygekuB+
	cF3s9dyscXioDRC+Zt3lqn/t7a7NfwVS+iqKBo+ptyDDp8iE6XLrbSi03rZO+9Sd9giV1jH
	KZ1+1pGqkai0b3knaO7TSmlbJ2zs+jqrLuhY5HQO4OGvwojbWJh6hxCOvtHBPYcXJEEc2U0
	jGUDMsxgVIz78cwrzSaf43WqwbxLD8Y+KgK0mudNA9J70yakuSQ6AUBWVWDTyJzvu5njU8z
	SxyvhYjs1TEU02tnCqrvxqmfUTCOEwDMoJScZe5cJElcM2JGgzHATokZbH38gD7Rd0JJdBu
	Crla1UTQXrzkJhkwKIEoE5RN+zXplxzH6pZf1pYr/oHYo/grxfT28/ueN2BASBTjjX9IKmj
	FBgcqjVIhomgsvswALC3aDX5QbZ9Gdm4VFYwpxkrBSnf+Mfl/ZPgTo4GcdmsALA26peUJWt
	OX+sazN/fyFxoeLv4CF8OspSllpH9KtIlzupZjLgN53Z8L4YbY4uO9v96bRy4HWbeboDfe2
	olVtrQHDLNrwTkFLKWgGmkQlijjN3/Af/TYutvXgZPqCQeS+XijrPImDGAKkVTBeUE2srEH
	zPRxycvVHPfLqz/s+KjI3kf+ht3OO4OzOP34eIq9giV5VhLLnz1QTfmWrhd2SxZa6+b/xQ0
	TUxK+PjY5VTgxxoUK624ul3qM6tOGp0h6R3Mnws4jphOFUDy0kPdLtJWOY0p//gJ95NK4ua
	fvq7BfiTK6I/RrQetrA3ibXomRndcy6DE+VnzmOQZY6n8vAPV2eovylFxVsoL9wNPsJu1D6
	3mz4Sapnrq6lPpLL9jkPnGBRO0d3+L6d017USflvQ7GOYCS/oxETXnp10BAAtr4D++yPsSb
	N6R8JsfIqeLj4zQUFu+NW8g02RIHyGC1TGDVfAoxfXa51TigyXI9o+/6op0K7qsGuTTAGVT
	9cZPNKqaRKrJCTbwggaJ3ynKwRglq5lW6TSfg8M6M7iXXgBUhnM2TWPsuCua1taT3mExNxz
	uNGsLdfQ==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

> > > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > > index 66eea3f963d3..56d411bb2547 100644
> > > --- a/drivers/net/phy/phylink.c
> > > +++ b/drivers/net/phy/phylink.c
> > > @@ -2268,7 +2268,11 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
> > >  	/* Explicitly configure whether the PHY is allowed to stop it's
> > >  	 * receive clock.
> > >  	 */
> > > -	return phy_eee_rx_clock_stop(phy, pl->config->eee_rx_clk_stop_enable);
> > > +	ret = phy_eee_rx_clock_stop(phy, pl->config->eee_rx_clk_stop_enable);
> > > +	if (ret == -EOPNOTSUPP)
> > > +		ret = 0;
> > > +
> > > +	return ret;
> > >  }
> > >
> > >  static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
> >
> > Test pass.
> > Thanks.
> 
> Thanks, I guess that's a tested-by then?

Yes, for this patch,

Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>


