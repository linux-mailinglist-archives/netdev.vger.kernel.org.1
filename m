Return-Path: <netdev+bounces-238934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFA0C6149D
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 13:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58B914E5F7F
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 12:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59F72D640D;
	Sun, 16 Nov 2025 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="gbE7CM0N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E4222256F;
	Sun, 16 Nov 2025 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763295961; cv=none; b=Y0lY6+r/OhuVkiVMlidijI6aiWgVRomTE9BF/EEs5Jf2KjR1Y0cRalFGPocYRzmf7eCaaZZJ9MQRwI4kwFyvFK7DKegax/7Cc/deT+Us+DaW2DFspZABnHjTMbpqPyT0z2UYUtpOkLUueLplxfWk0Cj9wRC/OqkcKLUDRuILI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763295961; c=relaxed/simple;
	bh=kClM97ZV0xHAhFhYdVnIuaBrHpIXn69pRXLepiwbH+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxdHoUwlwl5Sd6StbWn0h7XPjpsN7+cga01vcmps5IrseFh6Ndl9LGPY6G9v61ddc0cMDv2C1OrGzWMoUPzFJq2guUoxb0l2wc2MChyN+/F8lA/5/kUbA8AD7IUJcrN/SQL1WM472EUGWhm3dGpa2WRseWNfI5JjYRaNfCVeXv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=gbE7CM0N; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=b2Tzy4wpEnBc0N39re5MYS8e6Cpyy1OT/u1kY6JsWT4=;
	b=gbE7CM0NAwSA09/hPaYqd21DLNQ39SGc+N7sEA4KoeUHRwGOlm6GF/W5hlEwlJ
	Wd0LVyxzpZ8znLc/wDxdoiLXIGn/f28f5RVE3nkUOLL74fmgmMaK8/ZtqqypcUF6
	gqp6HZcYfY3/FohbeCd3OfoGZZuW2sLTndSv8lHHUuPBI=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCHw0agwhlp52glAg--.8033S3;
	Sun, 16 Nov 2025 20:25:06 +0800 (CST)
Date: Sun, 16 Nov 2025 20:25:04 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: jan.petrous@oss.nxp.com
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Enric Balletbo i Serra <eballetb@redhat.com>
Subject: Re: [PATCH v3] arm64: dts: freescale: Add GMAC Ethernet for S32G2
 EVB and RDB2 and S32G3 RDB3
Message-ID: <aRnCoAjkfti12We1@dragon>
References: <20251103-nxp-s32g-boards-v3-1-b51db0b8b3ff@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-nxp-s32g-boards-v3-1-b51db0b8b3ff@oss.nxp.com>
X-CM-TRANSID:Ms8vCgCHw0agwhlp52glAg--.8033S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrAryrCr17tF1DZr48JF48Crg_yoWxWwc_Cr
	y7GF4kAasrAFZ7Xa4rKw45XFnYga15J348Jws8Xr12qas5G34DZFn8t34Yv3yfZFZ5A342
	9wnYvr10ya4ayjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjHmh5UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiOAJ53mkZwqJzCwAA31

On Mon, Nov 03, 2025 at 10:24:01AM +0100, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> Add support for the Ethernet connection over GMAC controller connected to
> the Micrel KSZ9031 Ethernet RGMII PHY located on the boards.
> 
> The mentioned GMAC controller is one of two network controllers
> embedded on the NXP Automotive SoCs S32G2 and S32G3.
> 
> The supported boards:
>  * EVB:  S32G-VNP-EVB with S32G2 SoC
>  * RDB2: S32G-VNP-RDB2
>  * RDB3: S32G-VNP-RDB3
> 
> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

Applied, thanks!


