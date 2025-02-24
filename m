Return-Path: <netdev+bounces-168947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EF8A41B4B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 11:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D79189A07D
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 10:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54B6255E21;
	Mon, 24 Feb 2025 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NmTz3W+x"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03275254B1E;
	Mon, 24 Feb 2025 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393314; cv=none; b=di22lALJwin2ni6/d7SazkHCd4rXWfgB2UoQpFsCfGfP7nwFvrRyLY2JnJ5u7NWgoVJy6g+QSy6yDnEyJOFF2DxMe11T6BWmCcdYbnEyan4OioWwrKYDKBZzvYysT6tgNfdCh1THcLE7y32LUNMhxsQIDEAqkZpieYJvXizeTK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393314; c=relaxed/simple;
	bh=+slKAxwE4DeokI82jRZ6SVAqxHDic6FLYoo4hJ7Jw9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBHFZwjQCyN0fgC2z6xAYZKDXGJ3+E3wqmF3PyFC2dR7/uYJNgtMvmTEy9pn0AciGZln1oxL42es/NiT7XUlSIU3YAi0ximRB1v6oN4z0ZItOxbl6yZlZXfx6olrGNyKcyWXFbqi0le8fVhhYDYpEFSjniBMAXkg+GYK9+jOouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NmTz3W+x; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 10B2E44124;
	Mon, 24 Feb 2025 10:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740393311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wkvVrJjKIGs4iFLG8vSHGkD0ysqCc9enUTK/nmKkbHw=;
	b=NmTz3W+xn0P3GrO9pTZvl+iRiHcKJSh5ci5FGR862qa5JQYMoDQPyg3hM+TVlw7WrWnJb2
	bQAMPSg7eM3yc2Mrn7TxuBJLHcKx6566h7iJUJKAyqH2a9+egzl5eFenW7WBs+mVF+c2tW
	hXrgeqh5844adfnjPY7RoLtNlZ3S+xd8ZUhrqoMExHNz7SY/cj7W7qmSKVDnmW045RsYbs
	lqdDGhmHzmv23bWcr2EcAFdDIp1fqwlR+rRujX7lE2xYYRZvUUOCGHXnyJcTPnQmZcwgrh
	pcvsdIO5/eBDuQKbYWi2y25gaC+8sMkoPzZqgkGVCveuB6xnjcYO9SaQNfvHlA==
Date: Mon, 24 Feb 2025 11:35:08 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Harshal Chaudhari <hchaudhari@marvell.com>
Cc: <marcin.s.wojtas@gmail.com>, <linux@armlinux.org.uk>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] net: mvpp2: cls: Fixed Non IP flow, with vlan
 tag flow defination.
Message-ID: <20250224113508.2911ccf4@fedora>
In-Reply-To: <20250224062927.2829186-1-hchaudhari@marvell.com>
References: <20250224062927.2829186-1-hchaudhari@marvell.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepfhgvughorhgrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohephhgthhgruhguhhgrrhhisehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepmhgrrhgtihhnrdhsrdifohhjthgrshesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghml
 hhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Sun, 23 Feb 2025 22:29:27 -0800
Harshal Chaudhari <hchaudhari@marvell.com> wrote:

> Fixes: 1274daede3ef ("net: mvpp2: cls: Add steering based on vlan Id and priority.")

Well, that tag should be alongside your SoB (just before it)

> Non IP flow, with vlan tag not working as expected while
> running below command for vlan-priority. fixed that.
> 
> ethtool -N eth1 flow-type ether vlan 0x8000 vlan-mask 0x1fff action 0 loc 0
> 


> Change from v1:
> 	* Added the fixes tag

This should be below the "---", as it won't be in the final commit log.

> Signed-off-by: Harshal Chaudhari <hchaudhari@marvell.com>
> ---

here

>  drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
> index 1641791a2d5b..8ed83fb98862 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
> @@ -324,7 +324,7 @@ static const struct mvpp2_cls_flow cls_flows[MVPP2_N_PRS_FLOWS] = {
>  		       MVPP2_PRS_RI_VLAN_MASK),
>  	/* Non IP flow, with vlan tag */
>  	MVPP2_DEF_FLOW(MVPP22_FLOW_ETHERNET, MVPP2_FL_NON_IP_TAG,
> -		       MVPP22_CLS_HEK_OPT_VLAN,
> +		       MVPP22_CLS_HEK_TAGGED,
>  		       0, 0),
>  };
>  

Maxime

