Return-Path: <netdev+bounces-217996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D2AB3ABEE
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02421C278F6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 20:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40911283159;
	Thu, 28 Aug 2025 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="RX4KbHN3"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB2223DDD;
	Thu, 28 Aug 2025 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414170; cv=none; b=J/DTQvdyFvgLJ8afd4UdQxiCGSPKPNqJEhRULSANakBAZqSNkQwuaIWdfUjOUOK9z2/dNz4PyBFOgsl0RyMo+J7jiBzNy2dSCJ9I/0gGt6/qzhxCb3/22QO9oD0caXp89VN2Iekn8tn7mtS8S+XIx5z5aZJhvAxWNg7t6f7dQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414170; c=relaxed/simple;
	bh=60RN57SGarUcCCrX/TgVHaS61AJnubtnaonWIdw6dIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdNgSqEiCses8kJzVdYtR+I9jTXzMewS1p3qtdKgX1Xk8IF+Bv1QRS8C3scNkhDwrXI/kfgpVZoXL6dBsgq+JAPXdWfDTNfKZSS6gOT1YlT94/PIEqQhukhnhdLCihsmcc/+AnBkxDlGZccf1rMQkVKiqd2vY3S/G+E9AY8Ppfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=RX4KbHN3; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cCYRS12VYz9t8b;
	Thu, 28 Aug 2025 22:49:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1756414164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlZ2XbwdvlkwmUWUwXcI0lT7GL/8wshwLL1RS5RPjS8=;
	b=RX4KbHN39cp5epK12ihpg3Bc1lzIKYRm7O5qpW88PvCqihSyBcE9DOLxfbDLCfoeEOXLhm
	G4EBaYcwjxl0LQ8UaCl/T0m6YB8u5LhSQakXtYgCZgnFwhn/xIKcitIJ0gvG8w0m0cWWxq
	M9Qh/hk2l+bdX2MC0PM1eIS9yPpyXbrhv2o9ppXoqcSzY7523/8L943+som6YdSa6mm2zN
	0o1n0OAmpdxCnZnLvKXGJmdu7YWmUA3CF4qSzusRIhghKTiTZRrhj9iXbJrNojJZ0hYD48
	Ak56s78FPK3fnMTk0otE4dajqM3jvLZZWTVVjvqbK/FTA/nFMrTuC71jTFp/1A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of hauke@hauke-m.de designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hauke@hauke-m.de
Message-ID: <3eecb73c-7c6c-4813-af0d-244156e358af@hauke-m.de>
Date: Thu, 28 Aug 2025 22:49:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/6] net: dsa: lantiq_gswip: move to dedicated
 folder
To: Vladimir Oltean <olteanv@gmail.com>, Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Andreas Schirm <andreas.schirm@siemens.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Peter Christen <peter.christen@siemens.com>,
 Avinash Jayaraman <ajayaraman@maxlinear.com>, Bing tao Xu
 <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
 Juraj Povazanec <jpovazanec@maxlinear.com>,
 "Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
 "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
 "Livia M. Rosu" <lrosu@maxlinear.com>, John Crispin <john@phrozen.org>
References: <cover.1756228750.git.daniel@makrotopia.org>
 <ceb75451afb48ee791a2585463d718772b2cf357.1756228750.git.daniel@makrotopia.org>
 <20250828203346.eqe5bzk52pcizqt5@skbuf>
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <20250828203346.eqe5bzk52pcizqt5@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4cCYRS12VYz9t8b

On 8/28/25 22:33, Vladimir Oltean wrote:
> On Wed, Aug 27, 2025 at 12:05:28AM +0100, Daniel Golle wrote:
>> Move the lantiq_gswip driver to its own folder and update
>> MAINTAINERS file accordingly.
>> This is done ahead of extending the driver to support the MaxLinear
>> GSW1xx series of standalone switch ICs, which includes adding a bunch
>> of files.
>>
>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>> ---
>> v2: move driver to its own folder
>>
>>   MAINTAINERS                                 | 3 +--
>>   drivers/net/dsa/Kconfig                     | 8 +-------
>>   drivers/net/dsa/Makefile                    | 2 +-
>>   drivers/net/dsa/lantiq/Kconfig              | 7 +++++++
>>   drivers/net/dsa/lantiq/Makefile             | 1 +
>>   drivers/net/dsa/{ => lantiq}/lantiq_gswip.c | 0
>>   drivers/net/dsa/{ => lantiq}/lantiq_gswip.h | 0
>>   drivers/net/dsa/{ => lantiq}/lantiq_pce.h   | 0
>>   8 files changed, 11 insertions(+), 10 deletions(-)
>>   create mode 100644 drivers/net/dsa/lantiq/Kconfig
>>   create mode 100644 drivers/net/dsa/lantiq/Makefile
>>   rename drivers/net/dsa/{ => lantiq}/lantiq_gswip.c (100%)
>>   rename drivers/net/dsa/{ => lantiq}/lantiq_gswip.h (100%)
>>   rename drivers/net/dsa/{ => lantiq}/lantiq_pce.h (100%)
> 
> I don't have a problem with this patch per se, but it will make it
> harder to avoid conflicts for the known and unsubmitted bug fixes, like:
> https://github.com/dangowrt/linux/commit/c7445039b965e1a6aad1a4435e7efd4b7cb30f5b
> https://github.com/dangowrt/linux/commit/48d5cac46fc95a826b5eb49434a3a68b75a8ae1a
> which I haven't found the time to submit (sorry). Are we okay with that?

I think git cherry-pick will still work.

I would like to have these fixes also in the stable kernel, if cherry 
pick does not work you can also send modified version to linux stable.

Hauke

