Return-Path: <netdev+bounces-234705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0B2C26246
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFE234E335C
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA591232395;
	Fri, 31 Oct 2025 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HSf16hby"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F331E520A;
	Fri, 31 Oct 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928576; cv=none; b=TJh5FzL2+VCLqRO3K+N4NpeJ6LT6JC8x29PX569u1hUdErBoPMqZsoFei+s7brtHwl/wKsnuBwONloaV1NcesaHBnlvBrew6DjONngmZ4mNRGezW/AKiiysS44N3fPcDFqkYk7gDCH+jJnwRbOZ9gz/GOf4vrotDKotGAvwevJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928576; c=relaxed/simple;
	bh=BfAYDsu24xYDS3UbLqzDGnqaChjV/Uf3LpgagaGo84k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffek9aaXt0Iwo0Y/T9lgSce6/BiLJ9uVRHUPsTwZb1U1LLGCKFHARU+2+Yc1EHJ6Mu4wvUOyJ55v7HspZpeU/xmJb54Bth0Ac6xZ4Y3ZXmMjn3wPlbOxfUtyVtg2dvc9KxzCjHCK5sJUwGijRWT4cAqefNv59Fx2Id8+W9Zxw/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HSf16hby; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id ACBCC4E41445;
	Fri, 31 Oct 2025 16:36:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6E8AD60710;
	Fri, 31 Oct 2025 16:36:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F4D211818082;
	Fri, 31 Oct 2025 17:36:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761928571; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=K4nuxAhIBJ/YHlliKv9PA4NJS9mp4qzGhFSuKxxUv3k=;
	b=HSf16hbysLYSzdGRGtpOcthofrEv+y1K8lEqZ+JH1kQBz+WEOfBoIjgB0utmfT0XMYFn+/
	Yp4Vz/IxSq7aWziQNc0odC5W882BcLKKwPOGu7+d3aOeS4b4QF89Bzwh5uZgwrwgFdvBfr
	vW9SL8+/O3mEsN+cQTYjxU2jO2xPwt2cPU/MK8wCzHJSym5iCnOKtVuwiBbbeX3Hs6cAvx
	SDD3RqZOu3UnVs4rTJkfdqZtSRYYjKHoE0wTwwrNqZB1UxpG7IlynHrOzpzRKVR9DKct/V
	VHGJT8pUd8ihcKT4P4oRQeFgBwbewAsLSiVSCuK4dqNehkSK4vNNBrtP3c6Bzw==
Message-ID: <b7bd5e55-1e49-49be-a298-3a92d21a6567@bootlin.com>
Date: Fri, 31 Oct 2025 17:36:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] net: dsa: microchip: Fix resource releases in
 error path
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251031-ksz-fix-v1-0-7e46de999ed1@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251031-ksz-fix-v1-0-7e46de999ed1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Bastien,

On 31/10/2025 17:05, Bastien Curutchet (Schneider Electric) wrote:
> Hi all,
> 
> I worked on adding PTP support for the KSZ8463. While doing so, I ran
> into a few bugs in the resource release process that occur when things go
> wrong arount IRQ initialization.
> 
> This small series fixes those bugs.
> 
> The next series, which will add the PTP support, depend on this one.
> 

This series targets -net, however all the patches are missing a Fixes:
tag :(

You'll need to add them for the next revision :)

Maxime

