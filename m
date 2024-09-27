Return-Path: <netdev+bounces-130143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A075988931
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 18:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D301B28280A
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 16:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AEA18872F;
	Fri, 27 Sep 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="KDOPmqJA"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A371714B6
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727455040; cv=none; b=sT4vbj+G8S6t85jcK66KGAxn6fYpqNeqxztNP66AZac39s65utz4aA3P4wW85ORMdMjM6YhD+TB3oP/VoiD804j+5WXWB8t6xPjBGQdmCgCUUZJjOXzcONjZbiSmqtvAxDhGjGOZOxKhATP7mbfzXquILmxpdh1j8FZ0PC/8yQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727455040; c=relaxed/simple;
	bh=kG7beUEDBu4spnoxNTU7xqUf6zhqs7qRcLM8FX8fXHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W4RIq1ifYtKV8X60zKurLLVvDp4fJ9nRdYu5LvXe+XpSMZbs9WGpekeofvWvgAUCbUaFC0FPz4qUkQWeQvZrO5nww7mZvpDlGVt6wwEkJB9toU649EaAJHQrmx8j0f9lecSyMGcTsSoCS2eYUvquStWxuDC/GE+MtxDKCJy0Cn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=KDOPmqJA; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2CD408839A;
	Fri, 27 Sep 2024 18:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727455036;
	bh=uR0tH3U7QzW4VSSqPaCwB8EBiTCMVM4YBGwkc/W9yL8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=KDOPmqJAo2PWyGpgb7L9EsEUyi1NuwP2yzPBoKAythfX2mEOnVit8Mo6XWkOaK6Dm
	 7BfPNkC7j1OfLBx2gza/TMom7znUYwMfrmmhl+nbHAiRdpZ+UbfpTOV+kXJALP0Et7
	 F+cO/t+U0yo+/eJM0NhnAIfsXOaCVCGklEfMG8/WKSuTRZslFVDp/Dd5JIJusU+4BT
	 RW9mLBJoG1JaywBU3SIwpiwN52voYzjH2TYxuhj+aBDXALNr+DdPD5uQ100D4OFGKY
	 7cF0xN8rRWUs/T8kLZtBhK9b4aV7vxTmV28s1+twL2OEk+ECej2MlbdzcWH9199RnF
	 rmNxSNqZqhzrQ==
Message-ID: <e74c3f69-3c17-46bb-95c8-50075db39cb8@denx.de>
Date: Fri, 27 Sep 2024 14:12:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: realtek: Check the index value in
 led_hw_control_get
To: Hui Wang <hui.wang@canonical.com>, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
References: <20240927114610.1278935-1-hui.wang@canonical.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240927114610.1278935-1-hui.wang@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/27/24 1:46 PM, Hui Wang wrote:
> Just like rtl8211f_led_hw_is_supported() and
> rtl8211f_led_hw_control_set(), the rtl8211f_led_hw_control_get() also
> needs to check the index value, otherwise the caller is likely to get
> an incorrect rules.
> 
> Fixes: 17784801d888 ("net: phy: realtek: Add support for PHY LEDs on RTL8211F")
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !

