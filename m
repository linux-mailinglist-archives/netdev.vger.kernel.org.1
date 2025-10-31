Return-Path: <netdev+bounces-234703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7732C263A8
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C305461B06
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40453224AE8;
	Fri, 31 Oct 2025 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a7ywpVnH"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F681405F7
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928380; cv=none; b=oUvuUvJbdlwgI/nIaFLk+eX2LCKH6JRMMExTNxF7Ly3Au4HbYkbNYTYlPfTyxQ4DuR7KeaC2+iCE8R/me6igXGUazd6Xz9TeRbKLLLpSJZBV8viaHaWEpbFxQQNuNv0ZgdnpAvC8P/EMZCXp/qurwrIY06tbtsWmyFLRQlhXI/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928380; c=relaxed/simple;
	bh=C+M6TEkYf6rnRmSh9Fn3RQsgpScwzySYffxtCQDz4ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oO/UEDq2cW8jypQDoQdH7/OHuWNHqyglZUo038DxBkTdfoW7BNWvsnErycOlqxFGlNUJgngBqd5HTQse2FwXQwys3X17ASVffcOAoS22BwDVvH/wmBDQhYXzurpyJvMWwiEItBYrd8DkXs1W++9rLg/5FF+DF0Pny9zdUHpqM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a7ywpVnH; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AB4B3C0E957;
	Fri, 31 Oct 2025 16:32:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 392CF60704;
	Fri, 31 Oct 2025 16:32:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12CD711818025;
	Fri, 31 Oct 2025 17:32:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761928374; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Prc2FqBCKdzHY6nEpuB9LU3Sy57F4RCmA/VQbF5rrrs=;
	b=a7ywpVnHwP3DxXaeUHlnNNOmBr68JW6/D8Sdwho3OVgzpATcfab+7qTznAIsRfgUC0UjcM
	Ck+5JRJ4G6j9mqujE5RF3nX80IIkAgSgfA0LnNCVMHDZ/gmCBXVi/PIUkX+FMk/A3GvmTJ
	SUOyt2bKTHr5ykKw1g8WKy6cGw6KhQALaV0IZebpYoGbrkmCrgfGY390B2shmJ4JWBA8K0
	zfLffb1eHwV04MuniPkW1+l8CTFIw1+2ub3U6vvoaOwthYagCvsMK8ypY4WGRRJ+S7u2Dg
	SvXmR3qCclupBXLg4FX7hYdt+qWBbQ1rFcXox+HWN3M+r0WhhpD85PAovVCD8w==
Message-ID: <08518010-3997-4e11-b17e-94765e9c1ca9@bootlin.com>
Date: Fri, 31 Oct 2025 17:32:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net: altera-tse: Read core revision before
 registering netdev
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Simon Horman <horms@kernel.org>, Boon Khai Ng <boon.khai.ng@altera.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251030102418.114518-1-maxime.chevallier@bootlin.com>
 <20251030102418.114518-3-maxime.chevallier@bootlin.com>
 <b72e0572-6000-478a-b125-93f079944ace@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <b72e0572-6000-478a-b125-93f079944ace@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrew,

On 31/10/2025 17:15, Andrew Lunn wrote:
> On Thu, Oct 30, 2025 at 11:24:15AM +0100, Maxime Chevallier wrote:
>> The core revision is used in .ndo_open(), so we have to populate it
>> before regstering the netdev.
> 
> All that open does is:
> 
> 	if ((priv->revision < 0xd00) || (priv->revision > 0xe00))
> 		netdev_warn(dev, "TSE revision %x\n", priv->revision);
> 
> So i agree this does not need a Fixes: tag.
> 
> But i do wounder why this is in open. The revision has already been
> printed once in probe. Are values < 0xd00 or > 0xe00 significant? Is
> this left over code and some actions that were previously here are now
> gone?
> 
> Maybe a better fix is to remove this, and make revision local in
> probe?

You are correct. I was focusing on leaving the existing behaviour
untouched so I didn't dig any further, but now that you point this
out, we can definitely simplify that.

The revision is read from the priv->megacore_revsion address, and
stored into priv->revision.

The only other spot where this could have been useful is in
altera_tse_ethtool.c, .tse_get_drvinfo(), but here we actually
re-read the version from the registers...

So indeed we can keep that local to probe, print a warning for
unexpected version, and just drop priv->revision :)

Thanks, I'll respin with this.

Maxime

>       Andrew


