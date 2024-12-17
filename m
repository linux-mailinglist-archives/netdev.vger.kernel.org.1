Return-Path: <netdev+bounces-152698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC149F56C3
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 20:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB5F162E4F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9121F76D6;
	Tue, 17 Dec 2024 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ifm.com header.i=@ifm.com header.b="xxJGzqby"
X-Original-To: netdev@vger.kernel.org
Received: from pp2023.ppsmtp.net (pp2023.ppsmtp.net [132.145.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5D18A6A8;
	Tue, 17 Dec 2024 19:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.145.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463161; cv=none; b=SGU2jo2+kTKokt/uXXuOaZnQkpKrXxKTEowYLr0BLOW+80xfldiiCp3Xfk+yDIfyfOjFYmdH+k2DNbiqxdCTV6mN5i8M639ooqmd+LqKKg9vV1Memmzb2i8JfPiPQImVLHzREr8twy3molIS09XazJWy7QY0xE9kisnsn8samC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463161; c=relaxed/simple;
	bh=w9dbGeFnL3k1D3m7XCUxkyb4ID+a3FLTsx0p3/iB8SI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zx2qF9jBCx7nmUltJn44yVPjE1FEHpBujgr9EsO3ZRHOrXOqIKmQ7DN2w2Nunt8pVsfyrhLVyaEAVM3B0HfQnm4YUFbqx1dLKmJQpa7+d4RUrrYAogmOzxZWV83AheNfppsYv0UBOdDRrXfr3DR0tKc8kaUgpPRDIBJDlLQvHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ifm.com; spf=pass smtp.mailfrom=ifm.com; dkim=pass (2048-bit key) header.d=ifm.com header.i=@ifm.com header.b=xxJGzqby; arc=none smtp.client-ip=132.145.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ifm.com
Received: from pps.filterd (pp2023.ppsmtp.internal [127.0.0.1])
	by pp2023.ppsmtp.internal (8.18.1.2/8.18.1.2) with ESMTP id 4BHIgXfb000336;
	Tue, 17 Dec 2024 19:57:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ifm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps;
 bh=ZKj965WpvLbeTmB6JP+uoy/NU2h11IUjRbuu3J1Q8V8=;
 b=xxJGzqbyu2cIWCAG2dyrJiTv2PUuuCrYulLWwp6It8ZKDQodAKqivZjUa1Vqz42lGQbw
 28M0yVYleDD7luKchuholS21b/k8/aMRQfETODX07COtAmJxllz74bw/UF6My/yBQE0p
 8U4ya9S+IyDZU6hyjl6ogKKaSXTn/a52n6mC+JYt1Q81d8YgYswH98gpODN23K5Q2UMM
 Q28WwLUCSqVi9qqfFH1B2hTDL3ahq5FD5gb+fmfJHfWjJ72bt2xruHkO4WVkZWBm8j05
 wP7E2UjWnd3grwXudn6+JMCucnILdgMM+Xke6JiKVBK/mnYj+VU//sR8PJy45+wZAzbU Rw== 
From: <fedor.ross@ifm.com>
To: <andrew@lunn.ch>
CC: <UNGLinuxDriver@microchip.com>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <edumazet@google.com>, <fedor.ross@ifm.com>, <krzk+dt@kernel.org>,
        <kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <marex@denx.de>,
        <netdev@vger.kernel.org>, <olteanv@gmail.com>, <pabeni@redhat.com>,
        <robh@kernel.org>, <tristram.ha@microchip.com>,
        <woojung.huh@microchip.com>
Subject: Re: [PATCH net-next 0/2] net: dsa: microchip: Add of config for LED mode for ksz87xx and ksz88x3
Date: Tue, 17 Dec 2024 19:57:18 +0100
Message-ID: <20241217185718.189989-1-fedor.ross@ifm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <c934f10d-1a75-4ca8-bd0b-f08544c7d333@lunn.ch>
References: <c934f10d-1a75-4ca8-bd0b-f08544c7d333@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DEESEX10.intra.ifm (172.26.140.25) To DEESEX10.intra.ifm
 (172.26.140.25)
X-Proofpoint-ID: SID=43hk4kpya9 QID=43hk4kpya9-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_10,2024-12-17_03,2024-11-22_01

On 12/9/24 7:22 PM, Andrew Lunn wrote:
> On Mon, Dec 09, 2024 at 06:58:50PM +0100, Fedor Ross wrote:
> > Add support for the led-mode property for the following PHYs which have
> > a single LED mode configuration value.
> > 
> > KSZ8765, KSZ8794 and KSZ8795 use register 0x0b bits 5,4 to control the
> > LED configuration.
> > 
> > KSZ8863 and KSZ8873 use register 0xc3 bits 5,4 to control the LED
> > configuration.
> 
> PHY and MAC LEDs should be configured via /sys/class/leds. Please take
> a look at how the Marvell PHY and DSA driver, qca8k driver etc do
> LEDs.

I'll take a look at it. Thanks for your input.

Best regards,
Fedor

