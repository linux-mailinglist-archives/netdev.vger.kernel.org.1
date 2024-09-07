Return-Path: <netdev+bounces-126256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908439703F5
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 21:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5776D1C213E1
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 19:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9C016630A;
	Sat,  7 Sep 2024 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gAWxy1iS"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-76.smtpout.orange.fr [80.12.242.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7031662E8;
	Sat,  7 Sep 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725738301; cv=none; b=MFPK5nr6gCb9WKBBd32I3BIF94UeKsmbOjrvRPYDzkxTrG+3v1d9DHL7i5NbEtm1OohjRv8rT9jnFT5tiXFbmnfRCQggad7gg0tg/X1YbGtKzGtE0IvcRjNxU4LsTo/+IOj+n/wb7NbWs28TmBaLKXsDKpBH7DKa4sGUVbqs/gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725738301; c=relaxed/simple;
	bh=80KY32s7jH+WwsZ5XGrcLSAuljECxOPGb9mpfIlT8Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvewUoNz4vSSgDH7+/QOb+f4KaWUq86iuhwOdc2v3NEQR2Be4iAMmdGlFeBvWjr7zblO0LB22Ciz+hdjYT2/NL3VfFJcNW/OkiiqhuRYtRui7wUJrTPA1aw04HtIJbZ+04otvHfUzX5rgn/QJTACiE1McOn9LOHAGK9Brx71EDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gAWxy1iS; arc=none smtp.client-ip=80.12.242.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id n1LNsp8B5S3tRn1LNstmOX; Sat, 07 Sep 2024 21:43:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725738221;
	bh=QlUPUIyiyRIEHialSujayqzNL/PGIaRmBPrXrYsccKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=gAWxy1iSSmBRmGKBx6TF29hvsC4kIAp6VVUAQzwDtxcJcEEA2fDoUPtr3H9h+LTn+
	 7xmnuW1wCuDP/5TT2+x5NzusXyTFJ+Noy2nEg/SvToaDbVmM8sV8tCnvLt4g1ifKy8
	 INR+1qQ4v/kmmuP19EsQoEAKCblw9w6YRlSzrQ5yfk27aZC8shMrmHxJhvxC+srOAh
	 W85Z8fF6VC9/tyG8qGP5AILJ+CIELjsnxudXI+8imxoj9aWTkkNui+ID1y2zN3sQZx
	 REsoPL/1Jx1WhD2ysz8rJ7aCjtyacq9lxOtkYLfv2Su4Bh1stb9ZgEI156iWJUng6I
	 ubH+pb3eRVo5w==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 07 Sep 2024 21:43:41 +0200
X-ME-IP: 90.11.132.44
Message-ID: <3a0eb0ec-48e4-488c-933f-49c45e256650@wanadoo.fr>
Date: Sat, 7 Sep 2024 21:43:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 net-next 0/8] net: ibm: emac: modernize a bit
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
 chunkeey@gmail.com
References: <20240907184528.8399-1-rosenp@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240907184528.8399-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/09/2024 à 20:45, Rosen Penev a écrit :
> It's a very old driver with a lot of potential for cleaning up code to
> modern standards. This was a simple one dealing with mostly the probe
> function and adding some devm to it.
> 
> v2: removed the waiting code in favor of EPROBE_DEFER.
> v3: reverse xmas order fix, unnecessary assignment fix, wrong usage of
> EPROBE_DEFER fix.
> v4: fixed line length warnings and unused goto.
> 
> Rosen Penev (8):
>    net: ibm: emac: manage emac_irq with devm
>    net: ibm: emac: use devm for of_iomap
>    net: ibm: emac: remove mii_bus with devm
>    net: ibm: emac: use devm for register_netdev
>    net: ibm: emac: use netdev's phydev directly
>    net: ibm: emac: replace of_get_property
>    net: ibm: emac: remove all waiting code
>    net: ibm: emac: get rid of wol_irq
> 
>   drivers/net/ethernet/ibm/emac/core.c | 210 +++++++++------------------
>   drivers/net/ethernet/ibm/emac/core.h |   4 -
>   2 files changed, 68 insertions(+), 146 deletions(-)
> 
There was 9 patches in v3.

Patch 1/9: net: ibm: emac: use devm for alloc_etherdev is no more.
Is it removed intentionaly?

Also I made a comment on v3 6/9. It also apply to v4 5/9.

CJ

