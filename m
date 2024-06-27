Return-Path: <netdev+bounces-107390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE7491AC38
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29584284D81
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58BD199389;
	Thu, 27 Jun 2024 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="L/fQAnQy"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276D519925B;
	Thu, 27 Jun 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504311; cv=none; b=gyW5RYoxmlG3Z0R9MBSFEVZwdGj+98fOXUZj+/m5HXChBFlgT0xhCj88N/rFtTuaGp1zKn0+ehDIx2wehFuicJBla2uqJp9udwnQHzkEHqZeKOc3GlZ6TWIgsxQyt5Gqm/uCpHnlZUlB5oZBYfE6YwuS5NcKgTK+0COkEsN4M5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504311; c=relaxed/simple;
	bh=7/AE4qA0WJBEQxdKHPWvxYLKBHXquA6jz3vvqMefh8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qqe0kJgW4vE5xXzfvU4Cco3pEjC20M9lwEpRJUQpmi0SahyYRm04xh6Y55LbesSmH2FjVyBCI8t9frOV81mWAiepzm3iu8FGz0I6vaN62NPUcZZjBNni5ys7yK0RHTfT7Z7QUxlsFvf5Njjaz/JZWmIy+HLc8hvZubCKe+iIko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=L/fQAnQy; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 33301884D1;
	Thu, 27 Jun 2024 18:05:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719504306;
	bh=sGVGfQPHCdLVaLQwQoA6M9uYJaRXYHydouJN1pcCY5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L/fQAnQyvrD0jLeqP3Ql3EwHVPPtllqV02J7awwVRJm4elqtYBnRfS7XMyq+E7y6m
	 Aqocnq0h199W/L4ejGrYF2RwUoP8oZ21S87XjtOv2pFTUds8zsWwsNT0HRk4Xaaiil
	 uwmC4XmSQKBP7munJCzp15mk7njQ+UbPMj/VnKLwXvPXHaVjfkXV9EgJXwevW8fcXy
	 UQo/xVKqB0eITKaakzrQUan1ofjZTmhA67o2AQEumjIJ/9oR216CeEO0YLYmE2pw+3
	 2hkQhsE2jx0zWk0ZiS3tE1Roof/XT559Ku3eYeEC6vzEuKIqoW5FUcCW0a7h8dP3UY
	 K/5zHVacFMIkg==
Message-ID: <cadb3878-d744-42e0-8e89-1a3892029ef3@denx.de>
Date: Thu, 27 Jun 2024 17:08:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH 2/2] net: stmmac: dwmac-stm32: update err status
 in case different of stm32mp13
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
References: <20240627084917.327592-1-christophe.roullier@foss.st.com>
 <20240627084917.327592-3-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240627084917.327592-3-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/27/24 10:49 AM, Christophe Roullier wrote:
> Second parameter of syscfg property (mask) is mandatory for MP13 but
> optional for all other cases so need to re init err to 0 for this case
> to avoid parse issue.

What parse issue ? Please expand this part of the commit message.

Basically if this is not MP13, and the dev_dbg() is hit, the function 
should not return error code because for non-MP13 the missing syscfg 
phandle in DT is not considered an error. So reset err to 0 in that case 
to support existing DTs without syscfg phandle.

With the commit message updated:

Reviewed-by: Marek Vasut <marex@denx.de>

[...]

