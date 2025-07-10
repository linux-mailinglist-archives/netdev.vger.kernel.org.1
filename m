Return-Path: <netdev+bounces-205826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4947B004EF
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 16:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D0F4A21EB
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 14:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5C02727E9;
	Thu, 10 Jul 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f0TLvDl8"
X-Original-To: netdev@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8B271456;
	Thu, 10 Jul 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157006; cv=none; b=nG+ujswrIOwGhuBxMypasVs0m1pXqmQNYUpWdaff0jPlOo/w10wvyijgoc1kTZ0mLMIkcRXk6Pu2d8lPseI6UeT9FocL6buao5pJFoxLS9FLnT7eXV2v7+XktbFvyLgmCaW1aiECaT/IpxY1lAhMKoh0Tfv59NcLrf19H5yYicY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157006; c=relaxed/simple;
	bh=mPp5H/pNukYa5NUBq0aQh0anhclyiXfY7vE1nPk0VTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irF5By5wlHwwy3WBnvuATZTwnldNgvcEW9wV4Bqj1cmyr33UEfsdX0eVLnC8aAOsm+GQnoG3v7bnsnEJ5awZ2vIIRDYywpg5h4aJlrfNRPobwY/bi7Hk2TJ75IzU/V2GIbdADhkMzubQhqJzIa8k2GS/AeX5SYmRhKfGdZ4Xwf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f0TLvDl8; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id B08B9583FAC;
	Thu, 10 Jul 2025 13:53:37 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52526442CD;
	Thu, 10 Jul 2025 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752155610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6oPPvEhp8Ik88bxmQPhOVUx66A2onWuiWPh0/keNbk=;
	b=f0TLvDl8TkFp5jnGtNAUkwSy9+3bIfhFHYDZbLYKP1NfCaEZkNFScTJTgycSw/TwQpVGAu
	mH98japgMA+4ClBT4sJqAHIMozhaI6Pf3cR8A8IIH/1RnQ3DqrvU5xudSGv6btyCfxhwbT
	o49jZKx86u+dB5f7PSHzhCFTJVuIM++gpA8ULCZs6jfxTaWaa7i3CpBTGAjRkB5MLjlxXH
	wvxSb4DipFL2b91Eov/r4dwM0mf7CBcxomhF7Pzzj5Rgo8hcqpTZAu9p4+qNmLDt4/tpQ8
	8u3dwtK4M57NeMUI3IBH2pGWiuJYfWhcR1m39kuXsh4QY8G9yZ7ve/uWBXqZzQ==
Date: Thu, 10 Jul 2025 15:53:28 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
Subject: Re: [PATCH net-next 2/3] net: fec: add more macros for bits of
 FEC_ECR
Message-ID: <20250710155328.5d5b54b4@fedora>
In-Reply-To: <20250710090902.1171180-3-wei.fang@nxp.com>
References: <20250710090902.1171180-1-wei.fang@nxp.com>
	<20250710090902.1171180-3-wei.fang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepfigvihdrfhgrnhhgsehngihprdgtohhmpdhrtghpthhtohepshhhvghnfigvihdrfigrnhhgsehngihprdgtohhmpdhrtghpthhtohepgihirghonhhinhhgrdifrghnghesnhigphdrtghomhdprhgtphhtthhop
 egrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

On Thu, 10 Jul 2025 17:09:01 +0800
Wei Fang <wei.fang@nxp.com> wrote:

> There are also some RCR bits that are not defined but are used by the
> driver, so add macro definitions for these bits to improve readability
> and maintainability.
> 
> In addition, although FEC_RCR_HALFDPX has been defined, it is not used
> in the driver. According to the description of FEC_RCR[1] in RM, it is
> used to disable receive on transmit. Therefore, it is more appropriate
> to redefine FEC_RCR[1] as FEC_RCR_DRT.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

