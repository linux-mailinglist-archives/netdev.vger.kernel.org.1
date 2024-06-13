Return-Path: <netdev+bounces-103117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5748A9065A8
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697541C21615
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323D313C8E3;
	Thu, 13 Jun 2024 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Q2o3oOpm"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFA013C8EC;
	Thu, 13 Jun 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265064; cv=none; b=i4mrapRH+0ynccAE/S5WT9vY2vtbSnT/m5/THvHZ+rYTDfsBraB2NG0f85ON9Ux7uGy1GFA8ess+u5Oc4/YF/++FioEAsEIkVZFhuohEbV0c+kJYL5FJI1TV6WIdEacOIPcXhP3jyaaHE8QVIk9g9LBOc9VDa7t4VHjvhn+4KZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265064; c=relaxed/simple;
	bh=2U6VMYoQe5rwvZHCfig+zhidXmOGMsfZYrDromw7V7o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zja0JjKDAjcNJXflLfxkQ+DZnduqiy/q08hYQJRMqekBdDlgIfnJVR2H5ZVaMeSET5tRWUIVtPzmgSA3/9w/Yq8JWSdUl63ntuN82feu3Zs0NuYgv7+Kl3GM+ncSaqPWk2Pj27rWMjHXJS2WZFWyzUxKqdQQBzlVTS1ZVvIP/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Q2o3oOpm; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718265030; x=1718869830; i=markus.elfring@web.de;
	bh=86XHRC8lM3zR78u7whQ1QmYwLWKa5DrJEHBzTG8nFA0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q2o3oOpmDFKOciSavRbVDNZoxn5cfQeL+fttqeDO4yT6wJa2INgILEGsyx+WrM22
	 W3N0YWeMJCZ7Q2wWAW+P3+EGnMsELMT9+4nRkC1Fxh62IK+QtADLMv/QzbroWxrE7
	 B4Rdbt+ydSLQqCqmWhDLDzYa1G6umyU7bEB+L3iJ2tkK2CAF+pXBC1nKwrjCs5sj/
	 10mRZV7kEtQB28rDIBQPM7hLM4NrIKo9enc9j2V4sR4C1mYlM1qRdXPdDobLph7L+
	 AL/D4jIAWtmoRceJYaLhTjuNsInDkF+DcmDqKlWujXgnov24ghSrhM9cW1m22lmLQ
	 eiwMpuSq9de4bfdjCA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3ouw-1sQMMA3CFc-00xWbH; Thu, 13
 Jun 2024 09:50:30 +0200
Message-ID: <1d01ece4-bf4e-4266-942c-289c032bf44d@web.de>
Date: Thu, 13 Jun 2024 09:50:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH net-next v20 02/13] rtase: Implement the .ndo_open
 function
To: Justin Lai <justinlai0215@realtek.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Hariprasad Kelam <hkelam@marvell.com>, Jiri Pirko <jiri@resnulli.us>,
 Larry Chiu <larry.chiu@realtek.com>, Ping-Ke Shih <pkshih@realtek.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>
References: <20240607084321.7254-3-justinlai0215@realtek.com>
Content-Language: en-GB
In-Reply-To: <20240607084321.7254-3-justinlai0215@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zT2eDDbCbkAb6TadagnKQKkdrgmhpoPIXLLgkHQKF2xNWCSr8UE
 Fe9EwmhShJ9T4hvcC1VG5Tef0fMj7FZK+XI5/BDbmIIFktF8QmvnGy3wPUzzdxM+6miGVIQ
 tY3gZQQVmj/uRI1mJ3CeLKlM3LM7H0FWTkY8hJ+m6ZoO7NZdRXTE8BSFWtvmwYd3zgGyq4G
 GZ0SRG0zaCk1XjvX11bvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bPMSKqIDmNg=;1s7bZP01Mg+SoE2pyTmiWtVKX1O
 nih5VoK6GtdGEBqdtN7o6edm7axYQptZvaW1x9iE8JUInpgIqHrZPeUPaP3T59WizG1P5/jtn
 ztwYXz2Y8fLp2iHzKjITY6+jzCcZ7t7ebXD8iVwkWRCqoxyg0yTSXNmkQMuDdpPVzDxq+ofTC
 6O/TXKxm4AFmOh3UWZC7qWoHgtCfysX+od21Icszbn9L0wFRqWLTRVJe2zxV9rVoceoMBMFv0
 rf7e7j86Jh4F5pCqkMTsf6shlZKAHENyJIjlAhPHlv34ynSFPSq599OOpSuFtlurWIjrl7PTm
 3Sf2f19Fvr80QNZaNFIu27sPW+3RDnDpMXgBNz76I/ic7TNVi/g0QeaEry1UAoS72W5KlRVIm
 AoTXqlorS4h7KcyEqTjKfVS2Qjr0htIF3xp8AZvOLul24uqFfYrQ/+zwscIxtW7MNfKyKwEvZ
 90HNZYpxb1VHjESZJu7g68g967R70msUT3N7cNpPBx1kI1mu3cL7jXbhCYut90bc8BFJbohov
 wte0ulagnYPJWBd4rY5dOXChuBOW5/a+j3afdUiRfmetFbMp+mHhBvcHerc2i2bgPClhVo45H
 INuq2Su2qNJUxj/A0QPhbtcaCCqawiNZWbn3JmgdybMWyiL49zesge4452Xi6D695ecmkIyA+
 ngzqkUtXSTAEieh3fkU+fH/VV3eQZcb5e0jKnPqCuGOXXr1fSBqqKis2vXnzXwdgPsK5ShMl6
 O8aC853Sp3eCrS1de4sfYacuA+4Jp8GyBr2KRykd8HCV89ed6n6CDw4oMvbkZkCkYXwMa4IoD
 jJYBWY+ErFMgOOdmSEtjZxPwkz/hucjo9rLTA0sipTAj8=

=E2=80=A6
> when requesting irq, because the first group of interrupts needs to
> process more events, the overall structure will be different from
> other groups of interrupts, so it needs to be processed separately.

Can such a change description become clearer anyhow?


=E2=80=A6
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
=E2=80=A6
> +static int rtase_alloc_desc(struct rtase_private *tp)
> +{
=E2=80=A6
> +			netdev_err(tp->dev, "Failed to allocate dma memory of "
> +					    "tx descriptor.\n");
=E2=80=A6

Would you like to keep the message (from such string literals) in a single=
 line?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.10-rc3#n116


=E2=80=A6
> +static int rtase_alloc_rx_skb(const struct rtase_ring *ring,
=E2=80=A6
> +{
=E2=80=A6
> +	struct sk_buff *skb =3D NULL;
=E2=80=A6
> +	int ret =3D 0;
=E2=80=A6
> +	if (!page) {
> +		netdev_err(tp->dev, "failed to alloc page\n");
> +		goto err_out;
=E2=80=A6
> +	if (!skb) {
=E2=80=A6
> +		netdev_err(tp->dev, "failed to build skb\n");
> +		goto err_out;
> +	}
=E2=80=A6
> +	return ret;

I find the following statement more appropriate.

	return 0;


> +
> +err_out:
> +	if (skb)
> +		dev_kfree_skb(skb);

Why would you like to repeat such a check after it can be determined
from the control flow that the used variable contains still a null pointer=
?


> +
> +	ret =3D -ENOMEM;
> +	rtase_make_unusable_by_asic(desc);
> +
> +	return ret;
> +}
=E2=80=A6

It seems that the following statement can be more appropriate.

	return -ENOMEM;


May the local variable =E2=80=9Cret=E2=80=9D be omitted here?


=E2=80=A6
> +static int rtase_open(struct net_device *dev)
> +{
=E2=80=A6
> +	int ret;
> +
> +	ivec =3D &tp->int_vector[0];
> +	tp->rx_buf_sz =3D RTASE_RX_BUF_SIZE;
> +
> +	ret =3D rtase_alloc_desc(tp);
> +	if (ret)
> +		goto err_free_all_allocated_mem;
=E2=80=A6

I suggest to return directly after such a resource allocation failure.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.10-rc3#n532


How do you think about to increase the application of scope-based resource=
 management?
https://elixir.bootlin.com/linux/v6.10-rc3/source/include/linux/cleanup.h#=
L8

Regards,
Markus

