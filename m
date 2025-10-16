Return-Path: <netdev+bounces-229923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2AEBE2142
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5C3423EA8
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F012FFFA0;
	Thu, 16 Oct 2025 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R86uQbSw"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BD2D46C0;
	Thu, 16 Oct 2025 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601741; cv=none; b=JcpjzgykqVIZ6s7GhR/+22JFTt/DKK9v7qnC9dwllbVrg0ZJUsxoccMp2+ekXSrXgw3MVWWy7EFDDSrTRaIGRt8Fgy8pmeGqq0fqSczatkX3BOeD0hb0PFf0HmB8gF4OGkdmuV4hFYFh+Sr3S4kb7KOnfRhXgRG4fg3uMEwi4iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601741; c=relaxed/simple;
	bh=ig/+FDU+0q9A28w5jFSM4PSXgbhgNaEIsEKVfBxrRHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YP0l18pPHXudN5FPfsiEb8JzGT6pV9wibL55ea9t8tzyL8Z+3xlC8vYVW0mu3gYfD9qu1pKO94VZpCSGElIV8fX4hQ9jKjty0+OElbJTBc9mIv1HaBisdtoBKN9qoHi/KfDtx1z3Dh0rP1/Y9xLtyjCbBNUQEZg9tx6fda9ZA/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R86uQbSw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 75C80C03B71;
	Thu, 16 Oct 2025 08:01:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 94D946062C;
	Thu, 16 Oct 2025 08:02:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ADF8C102F22F8;
	Thu, 16 Oct 2025 10:01:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760601724; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=epg/CJTop2yMwEwTNQzhdUDQRTPIOstndBbKQiZycUs=;
	b=R86uQbSwPtfWBGs3P9qIkZwbYZIxEbHPKPfBOUcKnU4E91PDHpMmVcCdfUM39MUUox04kQ
	G1R/ikQ+nU9LU6nWtmUTpv4+0kCjgzQSITC3ZJteHpc3136OMXJz8TxYWYczhU5h3UoXzW
	BJEud93vn7k6MKpWQYYfI+XBV9MNEioT9ansLB4lAk8o/g8NOBN5JMBmK1eoSfBQJDtfFE
	FMqRKBsa/avl4sAJxydw/fS9LGMQUqKMHF/RHU52F2e7G6wcOmVUfpvFOigddgk3DCjz+A
	HZVtwoZl1uyNj06dWK+wvEu1SCwYeGfgKYXxzcjzxABs+bbtI8WcH7GuXguVvA==
Message-ID: <731e8fa7-465b-4470-9036-c59fea602c07@bootlin.com>
Date: Thu, 16 Oct 2025 10:01:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: ethtool: tsconfig: Re-configure
 hwtstamp upon provider change
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
 <20251015102725.1297985-4-maxime.chevallier@bootlin.com>
 <20251015144526.23e55ee0@kmaincent-XPS-13-7390>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251015144526.23e55ee0@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Köry,

On 15/10/2025 14:45, Kory Maincent wrote:
> On Wed, 15 Oct 2025 12:27:23 +0200
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> 
>> When a hwprov timestamping source is changed, but without updating the
>> timestamping parameters, we may want to reconfigure the timestamping
>> source to enable the new provider.
>>
>> This is especially important if the same HW unit implements 2 providers,
>> a precise and an approx one. In this case, we need to make sure we call
>> the hwtstamp_set operation for the newly selected provider.
> 
> This is a design choice.
> Do we want to preserve the hwtstamp config if only the hwtstamp source is
> changed from ethtool?
> If we want to configure the new source to the old source config we will also
> need to remove this condition:
> https://elixir.bootlin.com/linux/v6.17.1/source/net/ethtool/tsconfig.c#L339

What I get from the ethtool output is that the ts config is per-source.
Re-applying the old config to the new source may not work if the new one
doesn't have the same capabilities.

> 
> I do not really have a strong opinion on this, let's discuss which behavior we
> prefer.

Well if we want to support different timestamp providers provided by the same
HW block (same MAC or even same PHY), then we need a way to notify the provider
when the timestamp provider gets selected and unselected.

Otherwise there's no way for the provider to know it has been re-enabled, unless
we perform a config change at the same time.

Maxime

