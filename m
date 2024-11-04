Return-Path: <netdev+bounces-141415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3E69BAD45
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5455A1C20D5F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 07:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A137119993D;
	Mon,  4 Nov 2024 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="T6BGzjR9"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB8E19882C;
	Mon,  4 Nov 2024 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730705950; cv=none; b=P6sK23yQl13N1e3QdzezAn4K0lmqgvvJ3GhjUmTJicn8FF+x62jyY7pjUz2NCS6bYmgnJTdGrqJOpJvVUUNKZcxtk/GGnMnhuO3YQdTbEeRkCy/Sgz825a5tpSj2UumZ9BXtiZ5VjtHOPYcwSjA+ke/uit1pglNtZg3LbLKVMdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730705950; c=relaxed/simple;
	bh=dIgNhzZFyb1tXkgTHvIdpDIM02zQr2IiVDUJNky1d/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiyW/nt6w/up9YFhlg5hnM7NIO+ENWJqSA8cMuO7HCP3yVwFrYM9Ar+I829CUxmLy/nAqW6RFl3znZqHMk194u/yItc4SBtRHk8nFbY0bnVXiiAqwBMkDJzHWPqkP6dkposk9AP7h6meSWpAKz0ljQUX8u20xO7znDoOegDCzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=T6BGzjR9; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730705914; x=1731310714; i=markus.elfring@web.de;
	bh=dIgNhzZFyb1tXkgTHvIdpDIM02zQr2IiVDUJNky1d/w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=T6BGzjR9qHpHgAiSuapqTrEoCeH2muA5KZvtfw4WveK+c/L8Lj6CRg/k9+ykopay
	 lQFrZkN7Tpef0vCOVZVnX7xIjcg3AABrpjMSaaOddF0k0N1DqnqxwrVpHBFg06hia
	 cSHMebibM6BYPzxsnvLXGYRFcFaZqE8j/Mcz6KVTVMqrzA5Z8jteKD4NS07iiU/e+
	 NMGlBxo7+rLxfhQ1l0VhMClYDI+cudRROQ/+qbeT8FWoC3lCAlV/OzzqQkd1OGN/G
	 UnufZOK5ukfEmJyL7mVFrPk0/Vr0Yy1c5lCcTRWNWVy5aH4uoGen13aLpYiJxbnsR
	 iM7yPxDkn6j962hfHA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVaYw-1tHfHJ38I0-00MHDG; Mon, 04
 Nov 2024 08:38:33 +0100
Message-ID: <8e0f08e3-c1a8-4143-b204-f4f3d4c944d0@web.de>
Date: Mon, 4 Nov 2024 08:38:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: netlink: Fix off-by-one error in netlink_proto_init()
To: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Jiri Pirko <jiri@resnulli.us>, Juntong Deng <juntong.deng@outlook.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Thomas Graf <tgraf@suug.ch>
References: <80516b25-a42d-48e1-bcf9-27efe58f44c6@web.de>
 <20241103173133.96629-1-kuniyu@amazon.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241103173133.96629-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FWtIKQ7c0Cwrs4FPnWy8DKm3sh5ESkKIxeAU8qkiAf3WHjUN3lx
 YcH29QVaV/VMK9EFuzFjJ9Mz+zZkMXxMYwgqx4KLtUhMucPcF2f/A5OgwiTG0ZPd1Lfy1B4
 bKN2A8SnA9dkbXhDtoKZfRDtrX6F13LNYl1/pGfuVFEAYDoA65DNaRfT+gDiLFDGM0CDqZR
 xBqtXXO8zid9X/amSB8eA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PVYWG6k8Mp0=;kBSwYs89OCNIhYO0Aiji6oDDsP5
 +yQ/1a9mfn4F0Mt3cGU18c3MjjGyGKPndUEoCitNam1dhbf0wAXOM5qc9LQvyiCAUK5Ffhgde
 xOPvetRVjPIdazWu36PtyvwteHmEXPtuL1KL76qhVuWMBwIGJC//G+Q9J0JbBjQsOnlTH78hO
 k0m19/jJO58AsMO+ypO6Ubi+mptkK6tVwnqa3e9hU/bDWzau7DfvQvz7rCztVVboR8mqW0X+H
 z2taCszAMrHm97MiCJW0G9VxszmrJ4Uj7YLujWaVqok8W9SeEyJPDTtNZIZgu9VXLm/3dk4sD
 rYke6xtmObgaPI+6sK4pQQGsynf3S0Uy0YiflM25n3fPmSIIx3qFz7j45Al5sKOu4or/PkNA8
 ydePFy/pDU9Dq5sw//2pLgAeD85eLjHnzfuPhj9jXLXV7ZI6nDhtdbl1v+ibEcP7c/lHSqMBz
 7EvmhnkVCyAySYlDpxgGsjxv646K7iJiDNUPraYgC6jWWJZjnpVdjuqHw6INDAffi1AJDavFm
 IQxpuafvM8Zl0ZNVa+7FVelXcAxxLV/wdDI5YLm9h85/2O5gTRstjgAyHpi0qDaTm1F3TqOdO
 seFJMM+XKNE/72jk0/MMnEhrT2dKjdr5nPjHMxWoDX400gwD7DxteXg/+beIjU+aNTYwSH830
 C0zj6TGExN+EwHbg1Fmcf4atWLB2hFCPyw/HoVt/0aXhg5XTwHkBHHBM5bgVoszVnQF2sNQZs
 QKNcaVPsyEY+7EjOWs/sraMkxeeOjrXHfLjc97I88KHPVh4VVCusD9IjcpYiCXV2csWbg9zrt
 dRZL9KMOcYC75wKvJ/vNiGkg==

=E2=80=A6
>> Thus use the comparison operator =E2=80=9C>=3D=E2=80=9D instead for the=
 affected while loop.
>
> This patch is already applied to net-next.
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/comm=
it/?id=3Dbc74d329ceba

Thanks for your reminder on the commit bc74d329ceba23f998ead4f716266da5afe=
319f7
("netlink: Remove the dead code in netlink_proto_init()") from 2024-10-31
for another contribution by Jinjie Ruan (also according to your suggestion=
).

See also:
https://lore.kernel.org/linux-kernel/20241028182421.6692-1-kuniyu@amazon.c=
om/
https://lore.kernel.org/linux-kernel/20241030012147.357400-1-ruanjinjie@hu=
awei.com/

Regards,
Markus

