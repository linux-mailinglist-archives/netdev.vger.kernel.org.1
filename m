Return-Path: <netdev+bounces-106345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1429B915E93
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D2B283621
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 06:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210BB145A19;
	Tue, 25 Jun 2024 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="D7jplpiD"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2A1B806;
	Tue, 25 Jun 2024 06:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719295469; cv=none; b=aBw3w4KVIkFyM1C0m0Mmyct2wfvi0EDd9IBgKL3Kd8mMjMJT8n0R8LERukLwtu2doAQ8mTTaj+ItRAhtZqNvYjkeC9XjTcRXlXeLPH5SsY8h62h2NY7lYgqlDvh4ovLf3nZWCG73FXEsGWw8YqICxYRvOE9u+hmemAoOGkldtXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719295469; c=relaxed/simple;
	bh=G9iMMo+W8nOtYyZbqZ05BNh7FcAsBj+cSAO31Zj8voY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/Ps4ACsJD8fztwG1p2AewisxOTFemyBs1frJfVdOw7xcS4jilYD9B0CYBGQwdOjlfJr4VAdvSR0YWkHTR1d00FjiLfqFRKDeuMhOEfd2LDY7oUyp5vrXPqZ8vFIM9XWGrrcI+ow1uCxl173k+EL9fjAiMj2H0tU12RQJY+Mf2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=D7jplpiD; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D1D420004;
	Tue, 25 Jun 2024 06:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1719295459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQhW0YrsoS77fHFLhKP51Iz2UDrcYungvJwShyjCUiQ=;
	b=D7jplpiD1B0DcMM2VYZqchOGz0Q0UqY0bDaMVhb1DwIIQTATvsKp1HGovIAb0rWGNAwlA5
	vYvy0yW/M30pH24fan4wJzMQbjxeKHMQZV+uowidLojsXsV7gaWd3F0c6ehCMIhfkvJnAW
	ofxrMXnQr3EineuiPcwD2/T7PdrQDXDhQ8ETuiIguzGR6/bQGUXVQvrOXHQuIUe3NvTcyj
	jyW8CbF+9Ux6NwaDZupxNfQ2GXm109g1Vy31TsO3k5ajuZ+/TfztCuiwQawOjGYHgYwryE
	ws1Y/MgWFk/jSrqZ6goskxyNjlOuPVc+fGgldn3+yp6Dc9d5S55Z1jGO24kWSA==
Message-ID: <3f487664-e2dd-4283-8731-4f17d408511b@arinc9.com>
Date: Tue, 25 Jun 2024 09:04:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: net: dsa: mediatek,mt7530: Minor wording
 fixes
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>
References: <20240624211858.1990601-1-chris.packham@alliedtelesis.co.nz>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240624211858.1990601-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 25/06/2024 00.18, Chris Packham wrote:
> Update the mt7530 binding with some minor updates that make the document
> easier to read.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>      I was referring to this dt binding and found a couple of places where
>      the wording could be improved. I'm not exactly a techical writer but
>      hopefully I've made things a bit better.
>      
>      Changes in v2:
>      - Update title, this is not just fixing grammar
>      - Add missing The instead of changing has to have

Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

