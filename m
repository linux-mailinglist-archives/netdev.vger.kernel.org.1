Return-Path: <netdev+bounces-54047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFAB805CBE
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 19:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6671281E87
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7B56A34A;
	Tue,  5 Dec 2023 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XoptdEkI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A284D5A
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 10:01:53 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id AZjvrRTwOSNyBAZjvr0n3q; Tue, 05 Dec 2023 19:01:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1701799311;
	bh=hvbZ1hzkZAW9+ll+Cf0H0hMrUli14aQS6HIa8H1AiEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XoptdEkIyaphDGvNlkuK50h82d3TT88V3o4uepBihG58+UUJ9+WkFgg+i5GXukzuB
	 m6di0bERiVC9fyjAJbBYKflD1Uaoq9Q+yirlHlHFexeL4ircFJQC6pU7RWM1qE0bIh
	 bH1OZNcd/vrsuS+ieYI9rU0yqSbcePcmLZOUCAaoKh54B/ctCPvySPch5rf9U4IoMQ
	 ICZKlktLrX8zVPrOiGqDiIQSvNrgiQZCMPpwAZj59Rp3W/h4uYIyOFc4zQhyIvR0EC
	 AorPDR1vYKF9CbT1fjB07NijCvh11KyQRUjPpU9k5Zrh9m2BW5vpimmezFYsfizEvY
	 U+SAmVVoRm3AQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 05 Dec 2023 19:01:51 +0100
X-ME-IP: 92.140.202.140
Message-ID: <e6752370-7aba-4b47-90ff-7896a49ba84b@wanadoo.fr>
Date: Tue, 5 Dec 2023 19:01:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller
 driver
To: =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 Dent Project <dentproject@linuxfoundation.org>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
 <6eeead27-e1b1-48e4-8a3b-857e1c33496b@wanadoo.fr>
 <20231204231655.19baa1a4@kmaincent-XPS-13-7390>
Content-Language: fr, en-US
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231204231655.19baa1a4@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/12/2023 à 23:16, Köry Maincent a écrit :
> Thanks for your review!
> 
> On Sun, 3 Dec 2023 22:11:46 +0100
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> 
>>> +
>>> +	fwl = firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
>>> +				       &pd692x0_fw_ops, priv);
>>> +	if (IS_ERR(fwl)) {
>>> +		dev_err(dev, "Failed to register to the Firmware Upload
>>> API\n");
>>> +		ret = PTR_ERR(fwl);
>>> +		return ret;
>>
>> Nit: return dev_err_probe()?
> 
> No EPROBE_DEFER error can be catch from firmware_upload_register() function, so
> it's not needed.

Hi,

up to you to take it or not, but dev_err_probe() also logs the error 
code in a human readable way and it saves a few lines of code.

If I remember correctly, it also saves some bytes in the .o file.

Other than that, it is a matter of style.

CJ

> 
> Regards,


