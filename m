Return-Path: <netdev+bounces-104473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F99D90CA59
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A061C20BB1
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB9313E032;
	Tue, 18 Jun 2024 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="m31V2R7s"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004FB13DDDA;
	Tue, 18 Jun 2024 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710244; cv=none; b=EOFixWEwVJqTCOJYedql4QlJG8yfyGRyLeOKqyER6q1aVOij44iiZOHfxlXdLcM410WgkIh2Kl6coSva5BuDvslcp0yyX5r2pk3wEekSne0/+gv7EyiA6My9eqEGzJYXp/AqQlq/64davwaA8ZyEIWhqc0Vpua5G3sAZEvQASOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710244; c=relaxed/simple;
	bh=Fvq1y+koqj8fOQevp53Pmnpz9AgYuJGBtdWNg1G1Scw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbV6kdR2nCnjJb1ik6ZQwdoD/oqI+VLZDJPoK11FzQx72uHMVQBmo4VwwoKCnufq4DBHX2B+lRmRIhR3/9sgwnUmA4OeYkHK1+k4fmmlAw6eNvvhFSaC7YqageN7PPcVN00VNziXq79HPmSI33dTgotwcEqULFssuybzkcF2ebg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=m31V2R7s; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718710214; x=1719315014; i=markus.elfring@web.de;
	bh=Fvq1y+koqj8fOQevp53Pmnpz9AgYuJGBtdWNg1G1Scw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=m31V2R7soGq6GQZ+fiv99i2+9GduwzVKaySyLRE/OTx1VFLkL2D3oEUsyeOWFbQD
	 tkaJXVq7ZHnChpeezbdBgd48xvelMK+rWNCwrunUznKHfUz0lN/KBGZo0YT5xJxBm
	 pfTDyQ1V/84BV2dvfF1hyI8L2j8JDh9oa5PVt5M1g64Qg1M/xFhfF56SD10XRNtYq
	 68gpJRZo+HvL7jdraLFfrq9j/8TOE+jzXLmaeFBTZLWVXhGus4XIDaxXpwhOIZpY/
	 TtKda8mnJ1UDCE+yTsQm5NFYLY11ncgmMny+xuioApBQTSZ3eOusTDzNoDpGjgSZb
	 TgzrKRlRThNPR9ZwyQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6Jxd-1sPtj23usT-00vvRF; Tue, 18
 Jun 2024 13:30:14 +0200
Message-ID: <3f3f57dc-88c1-44ab-a69a-457633360fbd@web.de>
Date: Tue, 18 Jun 2024 13:30:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v20 02/13] rtase: Implement the .ndo_open function
To: Justin Lai <justinlai0215@realtek.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Hariprasad Kelam <hkelam@marvell.com>,
 Jiri Pirko <jiri@resnulli.us>, Larry Chiu <larry.chiu@realtek.com>,
 Ping-Ke Shih <pkshih@realtek.com>, Ratheesh Kannoth <rkannoth@marvell.com>
References: <20240607084321.7254-3-justinlai0215@realtek.com>
 <1d01ece4-bf4e-4266-942c-289c032bf44d@web.de>
 <ef7c83dea1d849ad94acef81819f9430@realtek.com>
 <6b284a02-15e2-4eba-9d5f-870a8baa08e8@web.de>
 <0c57021d0bfc444ebe640aa4c5845496@realtek.com>
 <20240617185956.GY8447@kernel.org>
 <202406181007.45IA7eWxA3305754@rtits1.realtek.com.tw>
 <d8ca31ba65364e60af91bca644a96db5@realtek.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d8ca31ba65364e60af91bca644a96db5@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HQWoZ1zR902uFm4bsPscR4h5SeyaamFsUAkVv9Cl8KQq08NyzhW
 9Dbnm7muODpM/JkLKyK3pdzHHDN9crnYVmb8mMhakJFQ1QWaC0de7E4966E1FIZ0tIjG3Ey
 fKf5/uCGrjq5JvOYkyXr/cfgLDD/bpciBObRaE+s3la4IvStEm3oQb3s9FjxNCDoaujRYAp
 6oUQ6gj+5eKEZV97/y/0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YmUCZHo1Yd0=;hAaTHTQxgNJCPZcDGMgj94JTeMO
 7yjAb+NNCP/Zud39D1AhLOVlwTCWpPWICtKjPB2/VXixeItg099hoahf4dCBS8r2MWHymV+7L
 i7npaGN9jDMR4YNqhyG5MW82gOKzYyY9cF128JjBlYSMopnrWDbo5d4lPugoO/CukW/eWV6NL
 qu3879fhlRqxjzCy4zXicCV+qQoEno1UxEjTUIw3xfvN6hT/aUN0u+on5SWx32E2dWdFpYq3M
 f7f1qdgiHhoeqgSh/pvTrw9fCgrl3T9BhV8J4CCu4LfbaQjoUNHrdztPx90I0ORCFau0h6TTq
 mQEIOM9vQHNYSD/7hq3iautK9jGE3pjYrh/DgMDisGGM2uVvPAmk4pj6JtrSif2F2qD8QhBjJ
 HJ4vaLn3P/FzPIevoxuxAVy5+m8r42y8UC93KdS9Qo4QY1E1+CzAD46Su9CnxqdlgcSZkNJ+I
 OijVN6/dlvDsZIXZ2F4+uwLJxx7sZ7YbUEGmw8iUA+UDrU+QVAj85aYweDl9SQuIJTa6ITeOc
 DCZqsEEVfxX0FgtrL44vMvPvS9svVxnT6hqbE0LB83GtCTpTbvm+Go0Qi6+E+KQINxsp7Bj/1
 EmbruTVBySheUs5sZLddcVE7/L77MzmDnYwIyOvBl8gSaVhbXoT61E242UGZqW/7EIZQrFQB+
 FT00mp9CZk5uHhN6OARaTNG7rJ4RQtwV5Uwuv+/ktsF7q9TgQtv/K93hMziyyICy7ukr0RC0d
 0pZjN/C6pioIc9USTfzevWvIzN2F8ppmi/Nmh7nntogc0D6dv3K3kSors4nnWrtIiG3jVJMfH
 z+wneR+JaWarQx+FDYE+EP/6aSDzpJNq4rWU4Ov1K1fzU=

>> I dare to propose further collateral evolution according to available
>> programming interfaces.
=E2=80=A6
> Thank you for your suggestion,

I became curious how the clarification will evolve further for adjusting
API usage in some ways.


> but since we still need to survey the new method,

Would you like to take another look at any intermediate application statis=
tics?

Example:
Looking at guard usage (with SmPL)
https://lore.kernel.org/cocci/2dc6a1c7-79bf-42e3-95cc-599a1e154f57@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2024-05/msg00090.html


> we want to use the goto method for this current version of the patch

Goto chains can still be applied for another while.


> and make modifications based on Simon's suggestions.
The change acceptance is evolving also according to known software transfo=
rmations,
isn't it?

Regards,
Markus

