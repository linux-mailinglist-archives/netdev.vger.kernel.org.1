Return-Path: <netdev+bounces-131587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E390898EF4C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981531F21E72
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A311865F0;
	Thu,  3 Oct 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hAYLZlAc"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1916BE1C;
	Thu,  3 Oct 2024 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958931; cv=none; b=OiKf7YZoQnGFxeRL8mb9a0Z+kFEFKaWyngpRnR7PtBy4dVBlbBivbwgLDx2xQUy5zstz0Rwuy+BhVsOYvbtHNYAxC7ZufNA4w7yJAi2HHvTu6dBFWJ1WO8LK5uu8g5sZFBhdw+9JwbmZ28acMQjIEE6dSr8Anb+HXahxOZLpBCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958931; c=relaxed/simple;
	bh=dX1lwuTM4JZA3FMlV7WmqyFSLpT7WpN5NQHhwim0jS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONW0XfPX/lZTnGxj89HIzyqVd+6YC0UDPxSdWLJq4vWpUA5/EOKt306ByfVlGN+h7nLR8mkm+VMjU5VWf1LyZ4+LFHAPQXWrnQ9O4sMUhSSR/krZZt8k+ii+uwSQ2QNBjRfSfn6HPHyA8mVOjrp/jqDdoxAoH8sgym2hRv7rDDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hAYLZlAc; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727958899; x=1728563699; i=markus.elfring@web.de;
	bh=ohU9x5TH8lUQ31sJJDJLdGFIGYcmJHHEVJBKIgyLxY4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hAYLZlAc+DTcOatjRclOUCHn+HtQC7o59q+pG4PFrE+MTb48eIV70os56fUEVCeo
	 OTZUNWC9ugIGRUVe6Y/uSL2FTRfhAqMtOaUT5ZFkyF3eWUM+Dev8bNDsousq4LaIW
	 uNjHK3lJcA2T1zvwXsZluDRak327TxPH3uNf0WBRockBChyodyLVg18i5E/RVAFOb
	 4wKIKgwHSc6w4eO64tbMpMgk4idQjSuR1kdJOcJXJegvggyPJ78SuMvsFhI/CeM/7
	 iTEH7nCunQlbJi6WEUhgLOJ8A6TtJ1AXbZoU4VPbaCJdypMIwp0kOAwtIy2FXaTul
	 3Zt8U+rm/8YXMdnFQw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6b8s-1roSdB1ORS-016L6b; Thu, 03
 Oct 2024 14:34:59 +0200
Message-ID: <63de96f1-bd25-4433-bb7b-80021429af99@web.de>
Date: Thu, 3 Oct 2024 14:34:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cleanup: adjust scoped_guard() to avoid potential
 warning
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
References: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:trfPFBdDsORavmVVDpe+GGEgbMqWbbj5yZ54NKl24Zf+f68ghe4
 rFG0KKBU1v+UJcDDLM/GxfcoM3Mkmz+GI0zhdTds8aO8pZ8st1m1pOjBYW81ltxcHCCntKH
 t9vPlhCvztcV9fWIpUveKi04d5gV3XHNeGmQA6013ZovurH3l3AkMrLjZZjUNDgBwmXzY1u
 yM8yw1GbozFcLqhwfhjgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e9IbK/kx6WI=;0RuvU8aVTjpbufjy28RAWIj5yox
 T1IinAPN41Iwhd5Qfcnc1ow42eWJ8ynPJfJ909PK9HkgUK7iv9+579Zbx4uNXRELS0bdVNzZ8
 eqKlDBbSDtb92RatedC+eZDajd+bl6EoIDayL5MQEF8CoEAb/vBK8AzaKD+1r/BFAkc3jEoIj
 qtaeDCI8zWJnZQnqqFaExHI7m1GzIJeBh8JPiE5RBP3zru65fDTSebpAdwdhY4DktsUJCEN7c
 xnjj12TsfaOcOtke8u+xzlqv3CaQGdturpJ25v/o2DcvM94mdjZ1MRJj8MGLpQ4SlQcNo5FX8
 nLSc8GHUwjQEhWNeuOk0/2Jy86iGHK1V2yWm5gvAF9xwaLgAySAobW1jNG/XBNj8pKKl/vc8M
 t39OyPGidgry7wyCbx+5SBOX7vx8dhDHad3U4yaFD2I15RxUlL8EbAfLkOJmTlkgPzDWupUy2
 rc4kBO0kuIHp0mQdYBbchnPom+BjlG3fRNTVgJEePUeG4sjMWmqI5QmCZL3xEgmZtfcoYsYrn
 Bbtlt8X6o7UqLZ/ilLIsyrfCdSMS0te8Y/gTImE0ApQhimb0s3KbUDuH75REwqUNW274F9koP
 koo2r5i/6QGwLnun7yQLbzOEZEuCb5K5l5akln3On7H+0CBo+C678LwdjY8AQSPW8e6egf/Zi
 YOPjqfxSLH3pkLLVexKIDrjhtLMtIEUtz02Uif5hBA2zaovRmh7sxJTQwL82KxKqgHTN3KZWX
 ryIwtvTpHzVSXQ3ZqkY1Rjlx8GG8nQaOu6LBFdwTH9/oCoDx+F/GqkR4O1IOMGj1RZBXTpQjv
 O2eDACIF5BbxyLyKN/gBgAJg==

=E2=80=A6
> PATCH v1:
> changes thanks to Dmitry Torokhov:
>  better writeup in commit msg;
>  "__" prefix added to internal macros;
=E2=80=A6

Would you get into the mood to reconsider the usage of leading underscores
any more for selected identifiers?
https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+d=
efine+a+reserved+identifier

Regards,
Markus

