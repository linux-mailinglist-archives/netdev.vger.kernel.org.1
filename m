Return-Path: <netdev+bounces-231128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C497ABF5856
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 300E0352A4C
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5562284686;
	Tue, 21 Oct 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JejDprwl"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70445221F0C
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039142; cv=none; b=byV5FXmvG3Yxfu43kmNap4u2SaHxLgxDtxEztmZaqAoEtm3n8NWldkP1QtTRgN+sHZGVGlZApHciwvRKG+gusg/zGvpY/AsVwNuYoqp3bn0W7fRFhsA9G+CatTEQtlkBx6dsEagzpgwOXcBy0+dXeQTqVmDgKpqMXJvlt3Q8PJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039142; c=relaxed/simple;
	bh=FCQ74zzf7PMaDBq02X1r3Jy/kD2zmjpWhtB4w7YbLIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lklop5ToRsBQ0Uel8E3dBH7Tfj66PzVU13RcyhUfijAJmFx+iWNhTrsqCxzS9wuYNBNlE4vco8WsY0u7yAOaf9KtjfwpFUuARAkAINLLxxog+IGfZB/9AjJwBzqZQxKiOgVOJNKJ6zBZwpMWtMbKfDFVNDeSDyNrWtanxXRhKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JejDprwl; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AEDDB4E41235;
	Tue, 21 Oct 2025 09:32:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 849E560680;
	Tue, 21 Oct 2025 09:32:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B5D57102F23A8;
	Tue, 21 Oct 2025 11:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761039136; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=dlDkAq1VSlkhX1Mtmjitmb/y9AT4xni68v3r5mMJ44c=;
	b=JejDprwlP6tFnfjWSSFt421IQ6GyFjUkMTUJZh8j+CCTdBwPMgIvXrtOuogtrHLGTFSyvL
	d4YtI8/wLDT/e3ATO+gBjwCvSpAVywyFhanT9etwrEYarTHV7bD+YfkARDyhQvp5p0B6Vk
	R+fXP7yyisfwrW+WOveU/gRxjNLcFEqR3vU2qBeRs/hLJ9Glpm/gcqTPn9ftkdH7NfCNzC
	3f5H8QtYbkXvV8WYIMM1GAh6CbgaPdG6rdoh9HsN7AjxpIBqtzs+zcoGwgIIMpqHiNkbGP
	u9AZFpmj41QzfGgiN1oD7f/MRe867Nx95FCdyTLbgnnbEpPGM0blelVliBhkJQ==
Message-ID: <563f3f1b-985f-4a9e-a32c-cb8e9b6af43a@bootlin.com>
Date: Tue, 21 Oct 2025 11:32:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/4] amd-xgbe: add ethtool phy selftest
To: Andrew Lunn <andrew@lunn.ch>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Shyam-sundar.S-k@amd.com
References: <20251020152228.1670070-1-Raju.Rangoju@amd.com>
 <20251020152228.1670070-3-Raju.Rangoju@amd.com>
 <ba2c0a35-eaad-4ae7-a337-b32cdf6323c6@bootlin.com>
 <9ba51a79-5a0e-42ab-90aa-950673633cda@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <9ba51a79-5a0e-42ab-90aa-950673633cda@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 20/10/2025 21:07, Andrew Lunn wrote:
> On Mon, Oct 20, 2025 at 06:19:55PM +0200, Maxime Chevallier wrote:
>> Hi Raju,
>>
>> On 20/10/2025 17:22, Raju Rangoju wrote:
>>> Adds support for ethtool PHY loopback selftest. It uses
>>> genphy_loopback function, which use BMCR loopback bit to
>>> enable or disable loopback.
>>>
>>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>>
>> This all looks a lot like the stmmac selftests, hopefully one day
>> we can extract that logic into a more generic selftest framework
>> for all drivers to use.
> 
> https://elixir.bootlin.com/linux/v6.17.3/source/net/core/selftests.c#L441
> 
> Sorry, not looked at the patch to see if this is relevant for this
> driver. But we do have a generic selftest framework...
> 
> 	Andrew

Ah ! And this also looks like this driver code. It seems to me that the
main diffence that the amd-xgbe selftest brings is the ability to
fallback to MAC-side loopback should PHY loopback fails, so they don't
1:1 map to these, but we could consider extending the existing selftests.

Besides that it seems that the generic selftest are more efficient wrt
how they deal with PHY loopback, as they don't re-configure it for each
selftest.

I don't necessarly think this series should be reworked but this is
starting to be a lot of code duplication.

Raju, maybe you can re-use at least the generic packet generation
functions (i.e net_tst_get_skb() ) ?

Maxime

