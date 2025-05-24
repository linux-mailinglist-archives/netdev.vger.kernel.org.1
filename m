Return-Path: <netdev+bounces-193201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6645AC2E51
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 10:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94ED9E7516
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480D413D531;
	Sat, 24 May 2025 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="sTEdrC0D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-74.smtpout.orange.fr [80.12.242.74])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7FC4C98;
	Sat, 24 May 2025 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748076946; cv=none; b=P5NJjnxAf6xDCGx4iI5BtXaauVyoaTssw7LDeiKrA6TuJSi4K/jI77feCL3m3nUBFLqiJZBrDT+5DGRIJpTgUSG26nkYS/2ANCq4jEQy8C6pwPJLiT7dhtf2KcxZATHGBBYZ+9TN5QndVCD7QCtf/Cb1++LjJU/TTFgPdS6bWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748076946; c=relaxed/simple;
	bh=WMIY4j3Sgu5Ef+S2ioQ76hl0mDTM6xszXJq/KHGWE6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pNgib2GljiYKR+CW9v+c+nX1ghv9XHHDnzHafF4Zzpz9ZGgZS3+b3+qHGSc7SeDTbTBgfEHjXQQagHotuNOSYu13wf6SF4RgkFdkH2wieTVKBSunbN51tHlglcom6J06FMWsIfc1WVd8IvHtlrsXrBufvSBqDw3Dx2jKb/fG9LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=sTEdrC0D; arc=none smtp.client-ip=80.12.242.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id Ike6uMjyN9ZLlIke7uwbb3; Sat, 24 May 2025 10:54:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748076866;
	bh=XYBFJ9U8mLqbbc+8f0SAmMzl/oGwiW2pOKW6PfNaUxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=sTEdrC0DBn7oWtbnLgUXHImJiDKkX1AGajfKV0lWlBMrXZdL6Y3JiD+BcObayhREZ
	 +SApgEFK+URDi5StLfr88TRbIIEh3kkQSI5ry/c7sSSshkuThg7/LD3URWldrnBa01
	 boAEBYBhxkqTSXaj0aH3oWnmYJwFKcZO3NuPBjkqd60Yvk/kTRdasyY+KPhtfYpx8p
	 hBJ0PPowjgqB8tgEEXS+uNtL7LbzNk7AcIAorHKE+3vsa0GsHxxqwwxFQMPkBiYQei
	 ywwpfpYEEWB9OeW5ATKOOv6uZmG9FGGI1X08HufsOaOdIiFBPpoyEm7hXZDWjCcWpC
	 r7dlaRNlq9IEA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 24 May 2025 10:54:26 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <7ae4c256-b14e-4add-b5f1-8b861e853407@wanadoo.fr>
Date: Sat, 24 May 2025 10:54:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] net: airoha: Fix an error handling path in
 airoha_probe()
To: Simon Horman <horms@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
References: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>
 <47910951a3fa3c3bd2a942210e821d9301362128.1746715755.git.christophe.jaillet@wanadoo.fr>
 <20250516201625.GI3339421@horms.kernel.org>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250516201625.GI3339421@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/05/2025 à 22:16, Simon Horman a écrit :
> On Thu, May 15, 2025 at 09:59:36PM +0200, Christophe JAILLET wrote:
>> If an error occurs after a successful airoha_hw_init() call,
>> airoha_ppe_deinit() needs to be called as already done in the remove
>> function.
>>
>> Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 

Hi,

I guess, that is patch should also be targeted against -net?

CJ

