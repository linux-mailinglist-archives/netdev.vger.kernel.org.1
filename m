Return-Path: <netdev+bounces-229545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F20BDDE59
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62A91898E63
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1657319615;
	Wed, 15 Oct 2025 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lVlIUbdV"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3F0BE49;
	Wed, 15 Oct 2025 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522453; cv=none; b=CDFQ1GEkOebcQRUeg8hu4colZh2+HmXC9fSmWBZTG4ULHugdakzODV4r2/JaLxcGJJe6GSwlIew5YMsVEhjzNMxvVJUwXnFR2JTrdomtD8HDwPv50OeJzivfHA6SqGj7V0UWtp5aFA53ZVIKbtIf/lEOIazZTXnRXIolL0BOY2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522453; c=relaxed/simple;
	bh=ZYZeb++Q7oUU3OeJCz2c/nNPN+HuflD/G0ryZYhjFBs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=pbX7Xfhfn+BO7C5EpMGbKfzVbR4j8Jx2CuXDWgog+/9g2VAjPIBhVPSoCWnfh/PVy7cg1e/+pLsl8xIGPHCj+3CrzlVxzrZfbRIsYBItjjrFEpFPHfNf+gXis13+G9FkmOnf/u/F96PE6rzyTLX/1NpEyVxhDroaX5vG3lqHk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lVlIUbdV; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760522441; x=1761127241; i=markus.elfring@web.de;
	bh=HnMcv6iaZ4GQpFvamOdr+OMWZzHdomct536Nj8zJjPM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lVlIUbdV5FWNMKBkNzUI0QDZMl2NZPhvsHh1EvjXsJi0p0arjhE6hxm08eUmZOhp
	 6WjMQ/Pl6J39AO75O9M+pofhrhg/fFgS9kvq/EubjW5/YwqNDueOB7RXaqa7vm8f8
	 bgs2ZwwwGwbLT9ikuXgzAmK8JRKVSgtzZsg9phUWdnNjVgnsMTVY/+CQ5Lz3cOVMA
	 aF93sFXUgf6Gin6W2EVMxNs6KcZBsDwvAPMPB3buy0Cwizkp5okmjE76TAoVDdMRU
	 +pkbBXOxE8NiQNAYo/hmdbM/kQIECZy7PHE5dM1oSEBEl0qvPei1fPvO91TW/7TO8
	 K0coHxk+uKGTZ2LAIg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.181]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLRYd-1uqTxC2qZ9-00IASv; Wed, 15
 Oct 2025 12:00:41 +0200
Message-ID: <b59d625d-18c8-49c9-9e96-bb4e2f509cd7@web.de>
Date: Wed, 15 Oct 2025 12:00:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
 netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Bjorn Helgaas <helgaas@kernel.org>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gur Stavi <gur.stavi@huawei.com>,
 Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Lee Trager <lee@trager.us>, luosifu@huawei.com, luoyang82@h-partners.com,
 Meny Yossefi <meny.yossefi@huawei.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Paolo Abeni <pabeni@redhat.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>, Shi Jing
 <shijing34@huawei.com>, Simon Horman <horms@kernel.org>,
 Suman Ghosh <sumang@marvell.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Wu Like <wulike1@huawei.com>,
 Xin Guo <guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>
References: <68ddc5e9191fcb12d1adb666a3e451af6404ec76.1760502478.git.zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next 2/9] hinic3: Add PF management interfaces
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <68ddc5e9191fcb12d1adb666a3e451af6404ec76.1760502478.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qRdSXG4YKq7oJAjeeIgrk+c0kf5VQ4Ho3ZesAQJz+AdtSDiLhpe
 ZpPHqfNpdu50lEfhNZPV1V5e+0cZxspd2huBO80HQj5EK4DnYKICkTAccvvlXzA2FXOr6d8
 KyzohhhTuWVYeAne1PFtM43jkJpOz25zCTuEF63wz/B+V2tMRI6uVdqlqjtCy1sawF85mPP
 +52I1ot7CbhYDuJ6LDvPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XXaFUKwAvo0=;JnU5QG5r1G/vJMifNjmyMA255wD
 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

> To: Fan Gong =E2=80=A6

Please reconsider the distribution of recipient information between messag=
e fields
once more.


=E2=80=A6
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
> @@ -3,19 +3,325 @@
=E2=80=A6
> +static void mgmt_resp_msg_handler(struct hinic3_msg_pf_to_mgmt *pf_to_m=
gmt,
> +				  struct hinic3_recv_msg *recv_msg)
> +{
=E2=80=A6
> +	spin_lock(&pf_to_mgmt->sync_event_lock);
> +	if (recv_msg->msg_id !=3D pf_to_mgmt->sync_msg_id) {
=E2=80=A6
> +	}
> +	spin_unlock(&pf_to_mgmt->sync_event_lock);
> +}
=E2=80=A6

Will development interests grow to apply a call like =E2=80=9Cscoped_guard=
(spinlock, &pf_to_mgmt->sync_event_lock)=E2=80=9D?
https://elixir.bootlin.com/linux/v6.17.1/source/include/linux/spinlock.h#L=
565-L567

Regards,
Markus

