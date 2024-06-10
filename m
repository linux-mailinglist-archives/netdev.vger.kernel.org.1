Return-Path: <netdev+bounces-102223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE9A901F90
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34555B258C1
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE767FBA2;
	Mon, 10 Jun 2024 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="A2aN7H7F"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514BF7E57C;
	Mon, 10 Jun 2024 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016258; cv=none; b=bqwe8HLTSMI15c9DDQEmf0d7Ex4nixRbpogtmj+f8yK3t1sdpc9D07ZwzxkrdhCOGtwRFlFp4I8ynvGEgiehYzT7QYUiQkbuaMYCItanEYcZiuYG5///Rvs63inpVUVxiPZFtmG/Doyia2dKOKsa/fnENQXfg/heuy8waFb3yjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016258; c=relaxed/simple;
	bh=31WqgqsA1En9t1GFKek2P2/aC8xYS61kqqjDZ02Wcso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAzKEtulYqw7SrizyIfW4SZjZzeHYcfwORWnEJWipyjaCqYC/E6EYaB81vj8TraT9UmdQ2/eEDwnqRj0lNfeFPcfIvJOq/cdhBCOdrhmH/BBTFKM+GEzE7ENAUKXoI+PBkQWxuWblOrJUXwQvfpDMslyKhLpHNl7V5mMCrqifw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=A2aN7H7F; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id CAE5F8848D;
	Mon, 10 Jun 2024 12:44:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718016250;
	bh=NGkZEG8OlVFpGyha1W1UNqro2WpB4+NK6veQW+zKPB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A2aN7H7Fvy4xDMBpaHxZAGYrAl1vbPCFsC4WiDOI8FP0/eclHGrMMPpv4bAuYi3FD
	 0IxaZkt7nvLzdNfUr1fQOqdxOx/de5M4fP2uooWrtl8W1KuVRRdhxmkzHmtWNgCQQP
	 glN+tfJIqSCvqVZXUulbt143VrxraIThV8smM6fm2b7qwcQ5QXATGyTxOJOZGCBvZI
	 EM5ZVjfru7HIZzgRAOiTRzsBfRJevUDwpxVxg2gi/ngc1h5i08BbXBmbdn7X3x/jXq
	 0I5N+yTVmlH7eA3BGO6bijMYz9Dx3KjrwfMxhZBgc7DywWnS7znSAhq9HJ9x1yY28R
	 iv2tIq6eYjrUA==
Message-ID: <873b03f6-505e-421d-b651-f1617b275816@denx.de>
Date: Mon, 10 Jun 2024 12:41:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ARM: dts: stm32: add ethernet1/2 RMII pins for
 STM32MP13F-DK board
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
 <20240610080309.290444-3-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240610080309.290444-3-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/10/24 10:03 AM, Christophe Roullier wrote:
> Those pins are used for Ethernet 1 and 2 on STM32MP13F-DK board.
> ethernet1: RMII with crystal.
> ethernet2: RMII without crystal.
> Add analog gpio pin configuration ("sleep") to manage power mode on
> stm32mp13.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

Reviewed-by: Marek Vasut <marex@denx.de>

