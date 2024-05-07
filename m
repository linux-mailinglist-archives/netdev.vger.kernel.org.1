Return-Path: <netdev+bounces-94236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B73B8BEB18
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 20:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078EE2876E0
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B718016C873;
	Tue,  7 May 2024 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FKPkDXTu"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281941635A6;
	Tue,  7 May 2024 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105155; cv=none; b=uk/KpDWVPObsgfIQIdxqoSWXMGs9jbDlIKMx1qFdMkOGRfjSYfb/eXJmrJgTkcjolxipluojBbcbEWPmRZa3XwPPpTaLTys+NenixqULejaRnCGXrbf+Z3Qtxwz7Zwf+2sPUwpb7ttlXEMdveM5GNQB3O7S0L1alpoLKjckZGF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105155; c=relaxed/simple;
	bh=KwgLxBAb3iwpt/iHMxBuGpes7bPXDJu6zekRMK5A15g=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Wjs73+g8leUoB/Ia5ZGXkNaJPRZ6KWy6d+8Y/7o9OiMPRBD8JjfDx85jVQSzs9keA/cV7Bf93Zhw4fthiH7a9Dgq6c4zqAynCRXj1B6MVGNRf4Uknkrb9eDiAM4CmEiwVfZpgeSj1uYY7ABDIdRBdnu0myvqC2qiK2jQBeiTIgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FKPkDXTu; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715105114; x=1715709914; i=markus.elfring@web.de;
	bh=KwgLxBAb3iwpt/iHMxBuGpes7bPXDJu6zekRMK5A15g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FKPkDXTuO6UzJyDNra68QLidcEjaQ6FMzZNRo1DMKZsyINUfwpOKuodSvLjFTTih
	 S/cMyK7la5OzQLlREXvjRtJA329VqmujRTV4eA5YSxVTXdEiVxReh90aICANGzTxq
	 uz+NMCW2TxxmznQN8S9wSSg2zNXjMMFUTpdn86DoHIgsbMCFcVH7uTJnwz0+M0b1C
	 kjhBDiC3i9kMaQ7Mf9DaxBU5hjRitZV6kKyn8dE4K0vKK2CzzIbZCe8gPLJozEGDD
	 x7phrhq+uX9fNUjaK1rUZAGBm/uM5qA1C6wjGUu9fDZCPgzhAyftY0X7llogQrqWt
	 UuV8nAx3wvJdGjoZ6Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOm0r-1sGAL71mVb-00ObnB; Tue, 07
 May 2024 20:05:14 +0200
Message-ID: <1c658f95-d3ed-489b-b000-d219e125604c@web.de>
Date: Tue, 7 May 2024 20:05:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jijie Shao <shaojijie@huawei.com>, Yonglong Liu <liuyonglong@huawei.com>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Paolo Abeni <pabeni@redhat.com>, Salil Mehta <salil.mehta@huawei.com>,
 Simon Horman <horms@kernel.org>, Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Hao Chen <chenhao418@huawei.com>,
 Jie Wang <wangjie125@huawei.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20240507134224.2646246-8-shaojijie@huawei.com>
Subject: Re: [PATCH V3 net 7/7] net: hns3: fix kernel crash when devlink
 reload during initialization
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240507134224.2646246-8-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4ljOFxrLOUDQYHqD33BOOnE6MAXLQQm3Fqqr5teS3PZBCUUulsw
 QggAeDCg5mo8zcK5o8VNtct3Vkq5yW8aw3wrvDyxJUPiqsQhAZHUX5hZ1on1hdw1j9kSgUn
 Mefhg4WlgjuJSv1+yvBFJiP8iOqVFl+5mAWB43+FiZO/xd7AiQcVv6vFR27uK1DlHvRwr4X
 9ErYPcasZ2fSapJJs1juQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rzAuSBM7lXY=;LxDZWg3qyJ1os83KwKjeM6yvo8M
 KKgD/J/19ip7fW1np5A7wRtzk+R+liuH99FaGk6fv8Cb/Rm4BsxUeMsaLKp6KW4oK4IlULaKB
 yhrzDemgc+3ZAiz2xPfBpay1suA6ia/bV3M+RSPeB2ESIrZxY9a/oTascqWfMDb/0QH+3UF7g
 nrdmUSTwmBLXcy/aHqbhJ2swu0s+lkzMgBaim9R+PTsQHljnSSDmeeF2x4gFxDW0hyEC59LcD
 1avZtZuVF7vZmf7L/+7crlD0ubp+5eCFyQkJT8K9Rpkm7E+lmvczzcTSsPqIyxpihC2xk1Dto
 /omDTr9h7kpX94sV5+BElY65sjs7hFCGAU3xmNMqr3bI2A9gmcSeY4yYlPr66Op8J5a5i9a9A
 3u9PBZtMryk+4LKH274u0jou1TgJ8/tIsKNW88T0fI+UENEszJ3BB08bGpIunw/YzoBMTqaMw
 7iv1Gn+1MbU4g8pX3dJ1G+HAf4hHtnDi+jvF88Fe2Cei0c2XmVQ06ClXvvNLzf4OQDjdTsz9I
 O+iGV19+6T+4OzAOJ5zmXo7g+uAYhrYl1HXQoYYP75JpXrKFg9tJpy5guFvPMqrQRfYV+HyJJ
 lWqgjfi7jwyk7DMDcUtZBl0S+ODU1nbadbDEyWRRWPmYy2/qJzRNpaW4tcbrQF77xZb2OLWl9
 JXfsIfDYv41pPSfT7tqnbNIOtV4bioT6rpXkbkYxzdfvfNjIZMGyar3LH2Kzwo71a4gsqRkq2
 yRTlj9uZFsTG+iMcfAkt3fWKGh5uoDjG1vWrLGGJMecVaNd52TypecIeCqKkP0HbYSy7hXcIX
 /tHq6Q8CzXJHFKib/gUOL0qb914398dMfq8BwG60v3ctQ=

=E2=80=A6
> This patch fixes this by registering =E2=80=A6

Please choose an imperative wording for a better change description.

Regards,
Markus

