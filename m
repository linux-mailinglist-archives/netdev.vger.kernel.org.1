Return-Path: <netdev+bounces-106139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33246914F26
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F10282E05
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A75140386;
	Mon, 24 Jun 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="kkg3iz3Q"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD98013E04D;
	Mon, 24 Jun 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237113; cv=none; b=WEPFzuZyQM2LPSwgcnZ4I18TnHXTOkcAeyWGdWvXampwiLSfzvMEosmj3sHqLZJf7n9onK7LIEshbfjliaCL5/n1aSu9vKUfcCX33ppQQtl4ilgcfVviUQKSHP2k6l1K0ztbLGTAu3E4i8c+9Smck56FeksB9gPO6FsLTIh7Iu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237113; c=relaxed/simple;
	bh=ibg0OLXyWOZolWbWFU/ynqVEUdwhaQbCT9GwDymCcis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mI67+DeVb0DbWG/IhVrc5plTU+UX4GsSf0NX+IJPxr9hedMDvPkhm736bOMHlqTwsWRlqDIT9lF2WePUYD/hUAUWn6R0UqRP82AJpvIl5QS9GFlKtpqdWQaoiJpA17+CLPGe6eH5hRT99Rk95fTh69LhMfxvvqub68a8jOKL+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=kkg3iz3Q; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E914E8837A;
	Mon, 24 Jun 2024 15:51:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719237103;
	bh=zQBOVmzO9SvkgEQ9JVsBSxZIt7i40lv4/ThnV63YjfY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kkg3iz3QEsjt1e6/0VIQfqDZGOjS4rEGeN6q5NZqenrqrTR5W7+wmBy2h92LYEu9s
	 ntMPNFbarb4dOYwGtxCSiDOlpa4Zt7W0+eeQ9SVLoNhyqd5qOmX+xrvtstxTe3SwQE
	 aiFCwg+J3dchY7zme1f4ywX1FQSfrtALKk8idi9T699+q9XDdxdIbVwwAAhWUxbsf6
	 5AVBqb5QnB33mLUTRAv3rcVuaHAFunfHZ8pJIZ/BGletWayAvZ5qAH+j7ImoS3IelV
	 t1ItP8tzalAlrlTN2Lya3Go3pLVOnhMmZb2wKNCjHOEui4IL9R3zHWl6Ha2QBpeqj/
	 pOqL6/Qjkd1KQ==
Message-ID: <7006a500-9e2d-4cb9-b328-14b19931d5fa@denx.de>
Date: Mon, 24 Jun 2024 14:22:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v3 1/2] dt-bindings: net: add STM32MP25
 compatible in documentation for stm32
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
References: <20240624071052.118042-1-christophe.roullier@foss.st.com>
 <20240624071052.118042-2-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240624071052.118042-2-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/24/24 9:10 AM, Christophe Roullier wrote:
> New STM32 SOC have 2 GMACs instances.
> GMAC IP version is SNPS 5.30
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Marek Vasut <marex@denx.de>

