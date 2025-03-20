Return-Path: <netdev+bounces-176470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B75A6A753
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7053A9154
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1E22135DE;
	Thu, 20 Mar 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Fkh5tHcR"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF2A1684AC;
	Thu, 20 Mar 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477940; cv=none; b=MCHZHE6qmME9U5XySDrJ7CsCpE2U3w4FAFrkHA0zf/mVhLAtbiAmW87wQM4EZXEOPaoj2S7ZY2aNbSpCpWyYN3Ilq8FEYhDIWoiDPSZ6y4ktVH368u7InnKH2iMM6b/F7l8eOpazH5dSJ0aH9MWXwvEpDv7lb1kDHrsHk1Jgsq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477940; c=relaxed/simple;
	bh=/g2TYNHQTa4QuwkVPtx3VulZqjEktao4JdemtoM4K24=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=A49WpjdgwGnw//9FS5ogvc44yvqdaZVMRuXJ/KTSGoqFyHsFXLcPpfHc7IlYytbJhv79MPk1x9L59uO5xV7JwVaxEbLwvcWsGEws7TSn38d+9OsEbFHaEAl2LYj2M1zRv6L0NOR9rT7WNQpzXN8hKV53i9d3qIzvfqx/22QB5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Fkh5tHcR; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742477920; x=1743082720; i=markus.elfring@web.de;
	bh=/g2TYNHQTa4QuwkVPtx3VulZqjEktao4JdemtoM4K24=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Fkh5tHcRbMK8aLMw4nSig2BNycgaC53YNjoLyDezu6aBgPSPUlXY7fUFmTtpMIaE
	 3LA6ZpmnahbgY3WsELbBvLHd4FNUjKVd7h0xlAT3Yh7VswKr9ts48+naplgQPkOpf
	 bFq/QLM4G6jeGAy/PJU7mcD3tpavRA3rqPJanw84DqQ92e0t7eFQ7Wcr57NtiRWdr
	 86cn0pJlmew/Af8Xo9vSX+umkicO9g/116W9xVyW6+66PLFNdbrlShkY7WvnABiY7
	 TC3FsO9B1U2dGoWc1BTNkpvIzJyjGTO4y3OuVlhEX5jDmyViE3cTunJi0qpt8MsZD
	 449tU1V3h9cf+8xDBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.46]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8kEP-1tr7NR073x-008Cz2; Thu, 20
 Mar 2025 14:38:40 +0100
Message-ID: <e6f71776-980c-427b-af31-6594ee290ec9@web.de>
Date: Thu, 20 Mar 2025 14:38:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Qasim Ijaz <qasdev00@gmail.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20250319112156.48312-4-qasdev00@gmail.com>
Subject: Re: [PATCH 3/4] net: ch9200: improve error handling in
 get_mac_address()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250319112156.48312-4-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TiWdkGHLId/D7EqKxoQZKiEvu93F7UvPHa0ep/FaYy4egseKamg
 Wc6VNDVo3mpcGWeW5tqDQGnyFhPSORyHDSzC89SPrxl17UwIEXVewEKVHcPKKcbof0zrbv8
 dcjPRzoU+yrDrciNKnrNDSwnhKd9XOq37i5D4bedWRnLu1WqHQOA0lkF1EUAMSB+yAdCDjQ
 teK6GAULCOAFpqlQgMiMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ysMQEs8WHPM=;HCIDUvQHSvgyZPTyAtQRjm9HFYa
 eWG5wVVLJ0085o1J/Ly7XsDvZ1mJfQCBuGfVcsmr4+9MY+Cp/G9WX3pm8igspGTrF75l7Q54m
 DFA6nYwrBladyMoIt5aUXT1CczFDtNkBwN06iwSJa3xrq4gtym2OpvbDM2JjBgPvLVRG9PdWX
 R6XLMUbFunNahIzvDJkRQUMlXQa8nJczT3tLEi+NwAHe1NdcR1Ef9IG6fzG9LwkweBEIXbD/Z
 tP1q0AZhfDPacHfHZjqMK8KzlhXNL7wYED5MD7ohDGIC6xy/zC+EubdeDal8EFFIMc7s40hlI
 OwJRxJYE2hrK+PPTiXklOH1ChC8HcdUyO2sf855a+f6aBBOFWEI1N/IdpIsjkUVHb9ws4LzHo
 UPwtMHHxRMTV//1zS+GUQ8hgdfOw7wYffkY0w4z5+q+zJSYT3R/Udzp17VPK7bVP4cHnCPekn
 xe1VXWm/i8k/XXGQM39cHpVq9eF4svXQJ4wkoGtncI6ZiWnaNub9D71n0Fq9K7Vbh9VaWnXxJ
 Db9RodmHz4MrRDS9yj6T9ysg6gb88WwkTmECUIza4nNWd+HXE2/Tvl45gCcnYUiC62WsTEaDs
 v/TBpFeEDxm4QpDOemjxtGvvUQhbHFbpV0oMrzifqMn7vqN0oUM4uAqDcBcthzItFILlK28ku
 vELUtS8OX4WdjioPilpT25/27nHy6eSht6T9g9xmerVhPIkyDareFxE9gzQS6QwSFTesAtGtk
 zOHPFYi8zfvZ32pSUr/d91sHIZyen2bI8m735X1faOwgIvzQuTI2k+DOxVczqA0nmwGm+JECf
 G1LCaQ/18i6sIxsyFu/ToseRVTHrNY2Xu+KwtQDzd4uIWCFBgodiUQEGhIcmnYAiUAksQE6IA
 9q5sLSRN28X3tu/HekY/Fv5e1Q57DD8CHc+8b+wHvMNIKTWUVXU+cLIlCp9ztR5N/idsPssKJ
 ZtW7FXMjRq2xII5KFDY6gUPsvsvlGLUjrOr7nfM9EpovrVlUyew3+qLrhisoEX62o2ygfaX8y
 mdJ8ORH1PpzLkn48ADbs2Efip01oWO3Qs84CM0XWYgyB+s9A/edxq1RmEzNjO84Al0jJKzIFm
 hW4WseWIP0KH50a0vVY28VQfVKT1tPZCRw3Pyr+7lreh9jlyfuToRg8pTiQCBnN2Je9PaxjNZ
 RSq+WyFjvbF9z1f0iiUaDxnLx2atfe34L5e9ZxuhGo9GrybDwZaemWoLUd+KjKv/XbUdmCEBA
 KIG0SYACO4eziWCnpR90PHqU0lJB/6Y2VFWR3zMjHk4GcmedviX8KtLMegUUEX2q8wRNR75Ty
 klARCtLkSA4nvwNrvS8QUTE1c3vs0Qk3Rg6RphR5ph8SiFxeQj7ewa/zmNWd6L9se43iR+4yn
 Y73C0Q0qVyN+7LdAYeEw/fg6k3ffOmWxeFB6PxS8NVH9z8kQN6zmf7HfTJnd4O6gwTVR/2v3e
 oKSReED1iYbNtxn2S80K+A5QOK4KCv3Fc1C9Xlj+7tiQjLs+R

> The get_mac_address() function has an issue where it does not
> directly check the return value of each control_read(), instead
> it sums up the return values and checks them all at the end
> which means if any call to control_read() fails the function just
> continues on.
=E2=80=A6

How does such a change description fit to the additional adjustment
of the implementation for the function =E2=80=9Cch9200_bind=E2=80=9D?
Would another update step become relevant here?

Regards,
Markus

