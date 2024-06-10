Return-Path: <netdev+bounces-102224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AE5901F92
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEEC1C21B78
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033AA80043;
	Mon, 10 Jun 2024 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Z6Dlxle9"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF27F7C6;
	Mon, 10 Jun 2024 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016259; cv=none; b=HnObyqGwn/2Ftnw7An1R0Tpldbhz0AyQzbIo+W3QZViwGf2olD05sd0qreqYvM8fErS6FSHnyphRTcy4fcXxGBvIAwrurG/tDrUqB0/pYGRzYXwbkmHTSJkeULwxc6HK3OcnAmzZMOnAkLa0qeTuHzoJd5yczZXLh8FyuGcH88k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016259; c=relaxed/simple;
	bh=128o3gvWJ4EnZ/1Qk8lG3SRBrykh67Xe4uLcurjbTx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+WUF/ih9k+DLrHOteXBTVRi1PFi2SPLSFXEGYRVWylFwypkcqXL9RMYPy3SQBdumaWJtApp/As31yFpyssouS/kYd2kea9zZwiuecOZR/4H1kTKfJ8b1ePe7SMyEkW0AZtNa35GBnmkld5z3TvHUBYpqCGQ1QHEReqfjUW+cMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Z6Dlxle9; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 42DEC884A7;
	Mon, 10 Jun 2024 12:44:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718016251;
	bh=128o3gvWJ4EnZ/1Qk8lG3SRBrykh67Xe4uLcurjbTx4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z6Dlxle975c7Qb0BO+1LlGsfNmEbA+xKkAQR79TaepT5MyHkbIrXWaKnVzgBSiVMP
	 skNUGQKtyecyezF7WAq0L/AB3y6aBWNJiRJgh4u0UjJKOjDpQ3ypH0cYsLC+snawDV
	 HeZQ+2h8IdzektxembK5kVq9XSXB4+nET/X6HnA9gQSDcCP81gOus4jfj0M3jw65hL
	 pTcnGchIw4FHHUdTqTRPyuVDbgOoOjVkKqlThCdsa6Yfm42E7L29u94GfqJwtKVg3T
	 lvUqXPsX1/I3v55EHYru3RUNrq61+QiDIYB+4Ssd+bMZzLILD9Id9Ibo3nDpeGcojG
	 iF2OksMIb+1DQ==
Message-ID: <7342028e-7c05-423f-a18e-d59d4e11cb40@denx.de>
Date: Mon, 10 Jun 2024 12:42:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: stm32: add ethernet1 for STM32MP135F-DK
 board
To: Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240610080309.290444-1-christophe.roullier@foss.st.com>
 <20240610080309.290444-4-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240610080309.290444-4-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/10/24 10:03 AM, Christophe Roullier wrote:
> Ethernet1: RMII with crystal
> Ethernet2: RMII with no cristal

crystal, with Y

With that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>

