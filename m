Return-Path: <netdev+bounces-229313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D5CBDA772
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3360501DF5
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335472FF65D;
	Tue, 14 Oct 2025 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IFUZeWse"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202C28D8DB;
	Tue, 14 Oct 2025 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456307; cv=none; b=lIMAJbVIkEmsg20Qmf3UWZ0AILNrObtLYFI0ruSNNx1gwdYnNbCSjGMcrI19G82iR+J26rGi6ftqJsPCLL17702N9wNHCons0sClN/K5apxmB8NyXZD+WbcyRnbZ68yE0NeReyclxUFf849OmR79k5CEEFIVr4QRTPxVy0/mp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456307; c=relaxed/simple;
	bh=q/WXLPQSkMRoyEVZFpT4T/dKh8qmtV542z46Ju4P4PQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=NnbjDJgn8iCRFbPGXdMikOFOCtC6M2fJ5sHcFyHyOjJPpj8SyqNHS83cxHBx/Vvh/cTl4aVeYxmKUVZ6xwvH/XMyQRRc93i/Y8hHnIY/rGUz0hO77w1K7EWsT0axPj4fVU7LEYJeDd/cNZJjMKwJVY7fHcOkEx3K+0fko1ffoPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IFUZeWse; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E4FB81A1375;
	Tue, 14 Oct 2025 15:38:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B2059606EC;
	Tue, 14 Oct 2025 15:38:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 71D02102F22A4;
	Tue, 14 Oct 2025 17:38:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760456301; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=q/WXLPQSkMRoyEVZFpT4T/dKh8qmtV542z46Ju4P4PQ=;
	b=IFUZeWse8HRhQFNtoBGScDbnJkoQPZcRUWyOenFV6hXjNstqT2i9PMmh1s7H/PcwmR4iYV
	HQ3euPHogyYNwvo08rWjjdckhpPEOok6iGD/VPNfs8oZIrRfIkloH5tkuwgAyMNJXgelPh
	dVhbCY93z8z4CStvKKER0aQ2C7zrIHFSMixiYFFEb098b6baDoHaKmkshcVGO9LywkQt0C
	4yeIOsUXZ4y2hVaD+/JbXGcxno17v311yi1BNfCzIBPSwakyvdXZANQ8RhIX6oTjFKr4KE
	azyLrV+7p0S7kUal3JHaLt15/5JYSbB5dLV6PSnVRAwa80rllD59ZaUuqg27cg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Oct 2025 17:38:10 +0200
Message-Id: <DDI5O7901X78.1VI8B7669OVP8@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net v6 0/5] net: macb: various fixes
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, "Harini Katakam"
 <harini.katakam@xilinx.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, "Sean Anderson" <sean.anderson@linux.dev>
To: "Jakub Kicinski" <kuba@kernel.org>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
 <DD2KKUEVR7P1.TFVYX7PES9FS@bootlin.com>
 <20250926134056.383c57a2@kernel.org>
In-Reply-To: <20250926134056.383c57a2@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Sep 26, 2025 at 10:40 PM CEST, Jakub Kicinski wrote:
> On Fri, 26 Sep 2025 09:56:25 +0200 Th=C3=A9o Lebrun wrote:
>> What's the state of maintainers minds for this series? It has been
>> stable for some time, tested on sam9x75 (by Nicolas Ferre) & EyeQ5
>> and Simon Horman has added his reviewed-by this morning (thanks!).
>> But of course I am biased.
>
> We'll get to it.. having the revisions a few days apart rather than=20
> a few weeks apart helps maintainers remember the details, and generally
> leads to lower wait times. FWIW.

ACK! I'll make sure to stay on track for the next ones. It hadn't
occurred to me that maintainers do forget, which sounds dumb once
written out loud.

Thanks Jakub,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


