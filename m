Return-Path: <netdev+bounces-233441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7526DC13514
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 08:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23541891707
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 07:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4771DD0EF;
	Tue, 28 Oct 2025 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E1TDoIWG"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440933EC
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636746; cv=none; b=Ziq7htwRsWuXW2Bcwcl55tLIEPIKGXDo9S4G8nyX/2aZxBlINh2lImrUa2ZVuYS0Y7Xa3KfvM7NMbTGBQAt0IuLhlSa6JJ00sXitCXDi1eWyv1CTyNCAtvStW84H9liVGjmc+7/7FBEiTyBBiETetqvqnCwkgqVTv4+BqM7F6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636746; c=relaxed/simple;
	bh=QgjanEDKdZW1E/ynJYUU7L7dgOBgDc3MfXfqKRoQCDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HU0CBEjUrNV87O7TCWyF32ShSzs+dn+lNNrtBcEEn9tV6/2eLWIzuLkA/PXcPrx8eYPvBGbbkpW3AwSPS59+gKJp1ptDeCN1W0ig8bq+knPPfU9bDiJkkvoXcq/HIFsxr7Vbe2yK/3m2h+WPzz6y/tRRoiKTLl5OvnDmY8Eyd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E1TDoIWG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0DE211A16F4;
	Tue, 28 Oct 2025 07:32:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D636E606AB;
	Tue, 28 Oct 2025 07:32:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E60B3102F251A;
	Tue, 28 Oct 2025 08:32:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761636742; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Q/suucpwQP5ri710TiMw7ND697IjPa4KHiZZ9pnqduk=;
	b=E1TDoIWGzE2+RVZDXJaei9238MNXcbAWWFfVjCxz3SBiqDHKNY++tGjRxCsHL+AvcuRA60
	xw1WbkUtQ08J9stsrW0WD2ydJWmkKvjjiv8KqyRZO1W2tWyLXOEM3g/OpywbIc9G271OCg
	n7qt1vixSTlKsAdLruiH9QXlLa2BROmMfiL094WgSwIrEiM8QTdz4y0oF17LupOxz/nJxo
	FFaCl6KYxxci8cPuwyHO6Imr2CkY88kkKGUibekDRtosOKu9gX8OtZ28obfHjKP0hEnwTA
	U8BX+hKWREqLV9tvS79sJa9sIYn9UNqbVwCyZVu3yfWRygbMtxCIPexsPmulFA==
Message-ID: <c06dc4a6-85b4-41e9-9060-06303f7bbdbc@bootlin.com>
Date: Tue, 28 Oct 2025 08:32:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 3/8] net: phy: Add 25G-CR, 50G-CR, 100G-CR2
 support to C45 genphy
To: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
References: <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
 <176133845391.2245037.2378678349333571121.stgit@ahduyck-xeon-server.home.arpa>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <176133845391.2245037.2378678349333571121.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Alexander,

On 24/10/2025 22:40, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Add support for 25G-CR, 50G-CR, 50G-CR2, and 100G-CR2 the c45 genphy. Note
> that 3 of the 4 are IEEE compliant so they are a direct copy from the
> clause 45 specification, the only exception to this is 50G-CR2 which is
> part of the Ethernet Consortium specification which never referenced how to
> handle this in the MDIO registers.
> 
> Since 50GBase-CR2 isn't an IEEE standard it doesn't have a value in the
> extended capabilities registers. To account for that I am adding a define
> that is aliasing the 100GBase-CR4 to represent it as that is the media type
> used to carry data for 50R2, it is just that the PHY is carrying two 2 with
> 2 lanes each over the 4 lane cable. For now I am representing it with ctrl1
> set to 50G and ctrl2 being set to 100R4, and using the 100R4 capability to
> identify if it is supported or not.I

If 50GBase-CR2 isn't part of IEEE standards and doesn't appear in the
C45 ext caps, does it really belong in a genphy helper ?

You should be able to support it through the .config_anef() callback in
the PHY driver. I'm absolutely not familiar with these high-speed interfaces,
so maybe this is very common...

Maxime


