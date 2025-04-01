Return-Path: <netdev+bounces-178634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 777F1A77F2D
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 17:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3330016C82C
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20FD2046A8;
	Tue,  1 Apr 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="j8lLEcLt"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174D2EACE;
	Tue,  1 Apr 2025 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521866; cv=none; b=c0DGWKZ3JtT/9gwnuMvt+BZlCbV4wA/lJzIj1K8ozLNBIjbA4HHSfqbuaoyIuXEXm45TFywH6+Y+CYI+YbDvxSJc3erjVUaieWQwjcclkr4ahHL9auteKqW4yZgtKXAU0F2yn5H3aaIwVqLbXmYYKElmtHGJ1S6/bZYlos9wOhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521866; c=relaxed/simple;
	bh=aKe+UrjQqsBcfIGYc6KdcxoN+1wJZX+CaVO+RJM2vjk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=saG1e2A1GzKcheIUvBi5by/XSlRe0PTkp4vV2bdmtMWut5dqEV6IgfA5S+WS3tGdRDYOP2n0Y31XzcLiBetXqDqVGQFiXuvt5oiFEa/DWYrNVzQhRyZf/5ZSfmUUzYvSLflB3sdeqmWr+oUbIXyoXXJkubSJi7cioKlk+WSxgAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=j8lLEcLt; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743521858; x=1744126658; i=markus.elfring@web.de;
	bh=brNkqSrtHqItVMdw8H2joMsIf58KrB5AZqOKMhsX514=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=j8lLEcLtbgNAcCc+uyijihHxt/z3dn/2YmwuCnhNjSKTHFOS981rosw0FzP6Vxs8
	 T/ZtZB90u+kyosAVIPV+fo79zBC6fi1mrN2E6IjjKnQohbDq7QnRqY0eCR7qhn56h
	 SsmFQ0Ivo3zPsT0h1bZL1BlWXBIT+Wch4+HFk6TnQ4KbVeejqFkWM/wU+2zjXFIn+
	 UzSaW7JJfeW5S3VpUKTK0mrzfQz9MpeayjmfMVkeEPJmelb4z6qRP/rB24ivzv9cP
	 VfWqu97UwSjrYZJp8QqBq7oVKDfVgTHCYSsY2rt6KCDB+a4+KkQXYNUa7qW38vL6+
	 SLnSXYCxWnYUOAXRuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.54]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMAE-1tUS8N3nj4-00iffO; Tue, 01
 Apr 2025 17:37:37 +0200
Message-ID: <f85c219e-2463-4d59-84d4-5807bbcb1a41@web.de>
Date: Tue, 1 Apr 2025 17:37:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250401145330.31817-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v2] arcnet: Add NULL check in com20020pci_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250401145330.31817-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oO/FAZFSZEiM+ASYPQSAF5CZcgIgII08lNNbsegTNzvR3wO7tkd
 NbnovQN5gSMI07DMZYkYnFYzH8pjhElqQ9MYYzstBo8JCAmWdcd5JHPWOb17OAZxEiq/x/+
 NH0Q4GUR5mOQEvwgn22ZaqEKcFdmIn0szULtMPYADGWU+FQkAc6QymVbkMhXDq0/bmOJ9WH
 oL6/QZMrtv5Z74fyxmLuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0vquusVhoJ4=;pgtAkuFf1nkQQL4utwa2fnBREd4
 NmTz2WBP+s8068eQZPCHOfKpHYaWTKGniVymEY9SsqL6f9pKFaHHK0i3pey/fDf1WLDhKAjSS
 LHFq4f/3IJaqHo0I5u43qy4VTQWZei2OO2TgVMBr5z3Juit/eclq6uY2+InUxgFTQs6qV1K02
 FGfnHjRJ0xeLKuFTsBYXgsQBc981jucrv0oxv8CdoSOphECCwCnvqjP08sJ8bRowsKkhN6H3I
 QtZwIiiFZMabsrid4JRKA4d/Kv8gsZsfoEIT+hFw6UhxqCMIQbOQ3RhJSAXqpJIGqGx3MyT8R
 fLA0F8BwKgVPuCCq6O4YBw5e0tVOq1VT1rDshf5RU8Iep2bUVBKr1gs0BKVa8HK5A1EiC2Q3e
 QlTU/3gSGD7daj/qVyhSEC0yvUC4tYEDzqvKYkfEf2KFpgTby7jGg+JDKuz4Q4KIEiGEmOgUQ
 wgWgo5k7pYcRJXFHts6dr7Do/tMKKQl46AcBSVc+uVQpWsS4pCt1IR6wTW0IA6pA5dlcYeai/
 mEVfA+3Vnda1zO/lgKKBaAyhvt0s4ZQMcPMa4mz2SOsOoTcVJR7YoPcROuTjAxqzPpnM5NzNk
 avXneqL/2Dh/F2gS/S6mGjn4FzxqPhM5c56cPFIZvex2ufNdztjQ5Oc+sAAmqaqIEseYLEcEq
 FBjBIc77OjcHQxQav7chwUz8H2EvZ+3ppITatlnbmnIx+HQeg4v82GdZXCxs1eC9pD3f6MNQs
 HqOJWgEmxnBRV5KHQ3vaSKJr80wgqIGrihWt2TtAd/brfLcYt87j6Kja2cHvcTPR23xq2dwUp
 d5FaKZ4l9zG2vyGp1OdeIsQKJryB5hDh61eio17g8tWl/kJYIuP++b1+QouR+BQsTaZ105amh
 YfessXR6kmV5rdiuVSp2vs0t6IC69tZdPsgEy1OKFU5VOUkc39NFLvhIOBy5IJoUBKrOX5EXj
 wbHiGk9scmoUzLq2bBlwbpxJfx3KnIjzIj1l9pnlpZkJfVqZF/hnthqadWOk8yCxO5h6Z1U+9
 kfDjz8y39zBZu4u+eNVp1JsU7GhJVjm/N+sokfE+fhTh4A6EgTJ11ykdcsFHmadWU+NrlEyfD
 FmHRWZNb26s7aonWHh1Pktfluau1GU5a62na0nBIP09ghDKc2ToPvgvxqfpQ60wDwuebqh7s8
 QycpdLaf9GGA0l4J4CFjGrZBOahznMyjsuvQ03Dee/uJoAFUi7Z2l6NfCybnylYOvkEWzLILR
 iziZE4Eztc47MjnZzb/Rm/lODb7lqQSjSzuWvuoopYg5e00aonRNGf6j5cT2VnvDIhl1rkXjh
 pAMjQG/v5QLk6DmxDHR7Hid8+Kdd+eftMxW1IMDHcG+GdElr0w4Qo5bisuvR+dteqm4IreS37
 s/Y3yZzK/Nr1eX9lrFIc+7YxzIA24HO9xzNYblFTpRjIE/P4Gjm4SIre/vOdoRloCCCFmplEp
 JWYIAVD9RJ1rqucahsDW8i0Rk0945Gs0v1xSsLqPEvA8Qwr3s

> devm_kasprintf() return NULL if memory allocation fails. Currently,
=E2=80=A6
                call?                               failed?


> Add NULL check after devm_kasprintf() to prevent this issue.

Please complete also the corresponding exception handling.

Source code example for further inspiration:
https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/net/arcnet/com20=
020-pci.c#L239-L244

Thus I suggest to use another label like =E2=80=9Ce_nomem=E2=80=9D for thi=
s purpose.

Regards,
Markus

