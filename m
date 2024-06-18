Return-Path: <netdev+bounces-104655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C73A90DCB7
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 21:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE37283323
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 19:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8E815ECFD;
	Tue, 18 Jun 2024 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="VrwNhgu4"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B11210EC;
	Tue, 18 Jun 2024 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739999; cv=none; b=WUnpj6giwABKVMkfTjDFR5cGTHZJqEdOxUIKAEWzxjNcP5gJ/rltU+Tpo6RqR6L+xTk3FO/JZUSXdsaBZvu+3HU79LBIYB4RCeAsWVLhb9alMWqDuJgBjl/t41vdCRbFPsQJGCm0w0Rb78kYK7V9X9PADqQSeP41GFgZ1aiBapQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739999; c=relaxed/simple;
	bh=1oiiqnJsXRdv/WF0pn4lymayB9HOHKdn76NUUDDegz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQXfOlOkhpbgS8Gi6+yeXJ031IuyinEBmBxzA8lh3guAJMsQqzJVwGWjUDlhsXAZf12CXUl5sjAD9ZxEnNCRDDKYUN5eHWQ8kpgg3mkily0VWn+KihhSOiV10DRatGfxGODW28Xnz8znzd7RzjaMo2U8yhBX6gs0kl+A/lG1LeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=VrwNhgu4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2757AC0002;
	Tue, 18 Jun 2024 19:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1718739994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rG4sRsDd/6xRCJRJQvFE0uunSAdGcquD+BOsXJyzENw=;
	b=VrwNhgu4xIFNCUD1woGi5FZoLAKdyDQMgjD9/8z/sKyQiL7FWRYAEO++yzN7nKhuA7ZeWn
	xz0geDfMNarScDQfAjQYQPz6z+1mywCeBV4Tb2DcnBh9ctGIQGCrNtaSlm3CeHfY8xf1pV
	57SKkizX812tx05B0P2lyIhFz0DBbK/XwxY3JalhVur9kPDDJw1GZZKXmPDV3/X0X4qBRE
	YBdsMCpV8yrcdiW5vhuZBmx2b2bGxCTWlOkTfKyfBETJfxvjxGU3D8SgpbGjO41kRzKqMD
	KigVoKD8vzxKfZX/j84pZ6vgKFG3Y6HYmO0Ax+Vo9sLKykbMy0ag/bt7InjxCw==
Message-ID: <5266ed1d-ebfb-41fb-9036-b9afcd7ce843@arinc9.com>
Date: Tue, 18 Jun 2024 22:46:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: dsa: mt7530: add support for bridge
 port isolation
To: Matthias Schiffer <mschiffer@universe-factory.net>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <15c28e5ed5fa02ca7904c71540e254617d571eb8.1718694181.git.mschiffer@universe-factory.net>
 <499be699382f8b674d19516b6a365b2265de2151.1718694181.git.mschiffer@universe-factory.net>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <499be699382f8b674d19516b6a365b2265de2151.1718694181.git.mschiffer@universe-factory.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 18/06/2024 10.17, Matthias Schiffer wrote:
> Remove a pair of ports from the port matrix when both ports have the
> isolated flag set.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
> 
> v2: removed unintended formatting change
> v3: no changes

Works as expected on MT7530 and MT7531. Thank you for doing this!

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

