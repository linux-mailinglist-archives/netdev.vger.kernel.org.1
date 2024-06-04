Return-Path: <netdev+bounces-100459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AE18FAB6D
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 08:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DD21C236E8
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 06:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97F013EFE4;
	Tue,  4 Jun 2024 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="R8TTouyD"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0542F13E888;
	Tue,  4 Jun 2024 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717484020; cv=none; b=vDzzNOuvIwtyGQOQM8/a2dyl2Ovd7tqe/CyowjCZTFr4tWVVA5xaLQJ2K2jFUHk99GP0e4s0e77JKH+E/0Qw1pqqNJNmmTf5o7TCZV9Bl3f+tGwHcSTViBsvGnKnSZfj+c+jRHJSl00MPtcTpK3akHN0yk04BhMvOrjUbQNsoZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717484020; c=relaxed/simple;
	bh=RSowf/I9aOA339JySQCOp/ThvQd9Ll78uf2zt8yj3fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LY4t7bF7RF1l7ENf7Ll4fQtpgTPaMFVIOu8rHsXlQiPPnjw9GTT/zZtOSGLNbIlJEFeeIzSAZQpQvI+GJsR4kg4wLFc11e+7Dl8QRdhj27Xp1k99aSzkHdMgk+qSMlfh8tTIRJ8qPjadEl/bWu9ipT1kgBLFdwsc2ca0YiQjTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=R8TTouyD; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3CBE788428;
	Tue,  4 Jun 2024 08:53:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717484016;
	bh=z8LELpLRxNFVqAyf1ACDj5F4E+vB1ToGwte/0yWmT9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R8TTouyD7xrGY6pYqt0QGch0CdwlTVTgJL9PgEZzaaqbKp00nL6BzWtst44+cU/5B
	 OgGw+GFeLcmg8x1v7GQG9BcsTgOAQ1VhkrHYngFLB3L0/i622mftzOb3sUKYEaFb3B
	 E9PRg+7SoBAKA4Blg2bQVDx6JRTVBZ8KcoDO+/Bgp08PPQSAi2VKgQrLZCnfWJtcj+
	 ulVLG+2LAF1aUZujbH4oWAqYJPgHyulEJhHNWMpyUbUsayekfjJZCXD6Xy6TdHrPLI
	 zz0/shIZ5iPb0F4xgCg4/UlT8VAmYxF8HtnWKmA+G73aR3DBoCXMuXIYhkyuk5xk6Y
	 SlBDyrPzVzqzQ==
Message-ID: <6c0ba026-55f5-4b9a-8cfa-864c289940a5@denx.de>
Date: Tue, 4 Jun 2024 08:53:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] net: ethernet: stmmac: add management of
 stm32mp13 for stm32
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
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
References: <20240603092757.71902-1-christophe.roullier@foss.st.com>
 <20240603092757.71902-8-christophe.roullier@foss.st.com>
 <d5ce5037-7b77-42bc-8551-2165b7ed668f@prevas.dk>
 <a992ecc9-bbb7-41af-9a0a-ff63a55d1652@denx.de>
 <9bbcd934-1d47-4e98-9e02-9ed18242bf1e@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <9bbcd934-1d47-4e98-9e02-9ed18242bf1e@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/3/24 4:38 PM, Rasmus Villemoes wrote:
> On 03/06/2024 15.01, Marek Vasut wrote:
>> On 6/3/24 1:30 PM, Rasmus Villemoes wrote:
> 
>>> Also, please include a base-id in the cover letter so one knows what it
>>> applies to.
>>
>> Just out of curiosity, I know one can generate cover letter from branch
>> description with git branch --edit-description and git format-patch
>> --cover-from-description= , but is there something to automatically fill
>> in the merge base (I assume that's what you want) ?
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information
> 
> Seems to have been in git since v2.9 (2016ish).

Nice, thanks !

