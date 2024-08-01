Return-Path: <netdev+bounces-114859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2A094465D
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 10:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACAD284931
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25D316D332;
	Thu,  1 Aug 2024 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="UYAD+Rfc"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12516DC07;
	Thu,  1 Aug 2024 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500381; cv=none; b=TN16EWSjVZomCl+cZJuSMG3oj0tH9BAdQMSQt9i9zmS3NAmHkCCyPJU57gBDMywxJXvUBAVS0lXlBI7prRkTIFaZFJbOFTTGQHWpjihDo+2Ggaj2rgfNMbHuHHYTiSt/09u462uatihGP6z4gTyveJ2yK8MKPo/GFdg8oy9TfH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500381; c=relaxed/simple;
	bh=HWKBAzBDyzI2heM8cmkCFEZvRAjFQUF+sG0AfJIvR6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzGGmn52lkl4iSaOKXxaauy+NbauKNEAdfFOtbeFZ8wnNKripCrAzQIEctt2A+QgQCiAYnCVZceoSY6ctKBQxzXbC7o4JudlVMCZ0AJJKvkjcgkOlQG4stgL2NIdupazK/ZN/Al0fpHGhj1GsCxeOEKgpmpL1VTVnE7kxvPwrPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=UYAD+Rfc; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E42940002;
	Thu,  1 Aug 2024 08:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1722500371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g63gvfrNSM5Rc2RoomCwqaQ8kdbcY6aqPlytYjhxnEA=;
	b=UYAD+Rfcd2PT+JMTAGD6pNejaNbbXLvdY5StscXUUYP4mXCYyq3aTggC+ADIqToCvbmkXc
	/VzcFRLEc8Ua+q8okLGU0LRgnUG9RUGMk1oTAOCkdPpBkLRUYNmDpIITVkJp9PnSpE28ve
	g1xlYybtLh16qa/89uInPOHwOuYjJxOQQFXPQrY7yxsplukLOILWozzrE5XlLekkAfJ0SQ
	rNIHU1A6R2W1XisZUPFv7zvvziVQh89p2pqTELvolBr35FOljvnItiyeNMCT3t4zwFYbYG
	YBHHxFjkkGsyP04Z5t2F07viCEo/LPdnu5SoLyR5YsXcIPSIs127YKWKL3fy7g==
Message-ID: <4c1a5881-ad73-4cde-81be-e2b809bffb2e@arinc9.com>
Date: Thu, 1 Aug 2024 11:19:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/2] net: dsa: mt7530: Add EN7581 support
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 lorenzo.bianconi83@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, upstream@airoha.com
References: <cover.1722496682.git.lorenzo@kernel.org>
 <a34c8e7f58927ac09f08d781e23edc06380a63a2.1722496682.git.lorenzo@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <a34c8e7f58927ac09f08d781e23edc06380a63a2.1722496682.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 01/08/2024 10:35, Lorenzo Bianconi wrote:
> Introduce support for the DSA built-in switch available on the EN7581
> development board. EN7581 support is similar to MT7988 one except
> it requires to set MT7530_FORCE_MODE bit in MT753X_PMCR_P register
> for on cpu port.
> 
> Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

I'm interested in getting my hands on this development board.

Arınç

