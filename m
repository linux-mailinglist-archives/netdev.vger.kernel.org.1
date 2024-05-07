Return-Path: <netdev+bounces-94208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5EC8BE9C3
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676EF1C2213A
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ABF200A9;
	Tue,  7 May 2024 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uuzIcpPP"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6A548FE;
	Tue,  7 May 2024 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100761; cv=none; b=qVIBZ4jo0SQwkvuZKPDeWoBeqs3BDMZ6E+Gfb6PULvEp6GmqMu7ShQV265VTOhJ1iB08b/cQYNwoRJOZbrqu3TBSm8WdkRvXSXmGnyZNry4aLYLpYrOSwZVdhiF15Yy/sQKyZIdsoPnKjR69m+Gr+CAmWbASE3stn1HlajMf3B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100761; c=relaxed/simple;
	bh=S8A9zsnRsFYYjDKBdks2TE6fJGheoskRphy9HwhTQOg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DWgTItOxNNlx9eMDTJ67rMboS5Fh/ZUh8DGNxekvNuT+G0PmzIOaHUJbkVJZagL8j+GFDzu/9ecLb1utvoJ/+ob2RpbdW2VRrzmQVr8Kexu7VkUod74E4N3E7hXCsqXsxyHXGcZfqXS1OiYMgyyCuwGt4f5ZzEwXBxU/pZ5w4y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uuzIcpPP; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715100705; x=1715705505; i=markus.elfring@web.de;
	bh=gPUDrs/Mk0znPw+v9wYlZjQS2DlLDMlwrHz+7dh3yU8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uuzIcpPPdkuzMaFIFNHuTDo3KPjg0p9VsEVyFkRO+CEp6qg9UXDwynzi1VvTmgZM
	 lcC9U9SltotoIGrc7SQTze+ffZy635bKF8w+KXO71MNna2ENdenz7Fx+t8V1Z66fI
	 8Qj8MZqRARZ7bYoWIEvgOMqfI18yzFMnC7wBvBO+lAa1dXkdlJqJC8YpFfkJToxWZ
	 PRl94zQzihewm1PivvJjFbb61Vco5jLnRE5GgCjpBXmmwEANysBSxifxzU09dSh7q
	 w5z+wBvalO4TnWG4+jwdzVTIRpdZJuOu7L8M2Y5VtkUpP7Ico5Vsmchuvx0oIXTxZ
	 nG41BkKNSOoiNAVhkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQgl2-1sI3312TjC-00M7Wc; Tue, 07
 May 2024 18:51:45 +0200
Message-ID: <73a1dc2e-cd7c-4fb0-a2cd-181155776490@web.de>
Date: Tue, 7 May 2024 18:51:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jijie Shao <shaojijie@huawei.com>, Peiyang Wang
 <wangpeiyang1@huawei.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>,
 Salil Mehta <salil.mehta@huawei.com>, Simon Horman <horms@kernel.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Hao Chen <chenhao418@huawei.com>,
 Jie Wang <wangjie125@huawei.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Yonglong Liu <liuyonglong@huawei.com>
References: <20240507134224.2646246-2-shaojijie@huawei.com>
Subject: Re: [PATCH V3 net 1/7] net: hns3: using user configure after hardware
 reset
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240507134224.2646246-2-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UAwRMbroh29s0Ez/VJv3gNYhlAe7D0+EmM7MDCRqf2rzqwcTcdd
 yO8GQFmHLsRZLGrEVaLJG4NDNHbqF0f+KVyxEWLRrVILkcZUMhFIuFHcZdzp4ywbrVA0iHG
 MqcaXAZwsCxH9ZYyUNq18EnRcDJ+Kq94k67l21FyxX7l4i1PFmfnLmbL+YDTnYEgfXAK1Hd
 nKN90sEHcYCYzDyIJhKSg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d0Dcnv/9yPU=;PR+45TPLCU2DRnEStC3sDhDpyIP
 CuwRSfv2z1JUdNyItnEpGQXuUpll9EWP2BjNKPu0oba5Io0tDwfuJcoVHXJLJWu2TaUVWJoUp
 5dDPiuzJ54TQVe1Z4qWyCjGK/lwnvq67Ru0UB4ldjAsdpafA3VJDKTjqJdxsiYKjOJVhaWdEd
 y/0w09TrkQzp0xMrx0bIVyCR3YkvgRMcdWqCpVh4UcpJmPFjTuIdQRtRtH5MzMAnpS0CGB9SX
 0qJyT8Q6UIicIj7oJ24Who0vEp1Km+uX+kdPAbK0cUeCPnkp6SfJu6U4FUhdDXZuChFvwE7vx
 Amk+z3hUk/8NrorkRXuOuAW+ssQbyOb/dIOZDUdHKI1M6Y6rR+eVgCTxVrB6aQONihAMHwWL0
 nSbTrNx/5FtJ8MOYu1mySxzuT9FEXn02abK8+duWnv6Ra+v2hNm7OvSNizsKVbR00SWcgrJ98
 4jG7U5Os0apeykSJYwpm9YOqW0hFDi66E9+pg2X4J9XsxY6+vhVfO8tODSwKYKP0s7rnsdKaK
 7KFMC5C+A7Y+hKU/4BonV28/cNgvdsDmTXMKi9RwUO1ufve/HbiQ2JnoPfIoQ9zf5B2Kk/ZEI
 sdnoBkP7FA2uvIIjcvgJU9IC10+QAM9yN0paM12rdxGVQIqyXGHxGNE1SHejrCovpvW2jyO2l
 WqaKFZbeCWFuyDZ24r0VNGV0NogEL0GOSbFCqJxqJ/snQALk3rk5kId1Ns1BHNyDZ0oBuCssY
 mnbbzP9Yh8oqk7b7zHaAmhMjUQcl6WSrJt4ASENjFqv8Y6NtdhODfQv+JF3J2J9rOYHCRH8fs
 KQ9L0M0TKcNZUyqcnNVun+UZEZUxubACqGPpvppFL6G4Y=

Can any wording adjustments be a bit nicer?


> When a reset occurring, it's supposed to recover user's configuration.

An user configuration should be recovered after a reset occurred.


=E2=80=A6
> and will be scheduled updated. Consider the case that reset was happened

and the schedule will be updated. Consider also the case that reset happen=
ed


=E2=80=A6
> To avoid aboved situation, this patch introduced =E2=80=A6

* Would you like to avoid another typo here?

* How do you think about to use imperative wordings for improved change de=
scriptions?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.9-rc7#n94

Regards,
Markus

