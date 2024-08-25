Return-Path: <netdev+bounces-121744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B71495E4E9
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 21:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887091C21BF9
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 19:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313B4155CB5;
	Sun, 25 Aug 2024 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="s0MOgxLA"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404528366;
	Sun, 25 Aug 2024 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724613738; cv=none; b=XII5m/z1Te87m0JNh6Nmd0hs5gX8HGNhNheSLtlh46P3wN/lSzxr7weCbJeeaLK2B0cNDoGlp2PmlnD2aqp2N6V0gFQXMDpT4CnanZVmArzUE1yjtWDNeePbdgzWz6SKT1nUZASuhTQXfG/dwdu/rBI4zZjfCjc4PuPbnUyGmpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724613738; c=relaxed/simple;
	bh=5uhNKINWMgH1S2yx5920iLeFa3IL/pKDpZ06BC+JBew=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=QmIcpsU9aRZmOBv9HHP3/LpRoQl5blUGaC50+l+LH6JRi1vEZPZy43QPsnQAP/pI52pacz6FoMgX3eQgVlB1OaAlTxfz/RkdAFn96ql1/8R5Cp5DeB4oFFOXfxR63TUMMda0DyD+ucXBhf1OREbR8w0ZIBUmGkmBXBFa3+QZqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=s0MOgxLA; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1724613694; x=1725218494; i=markus.elfring@web.de;
	bh=HqzjFZ5MqDyBzxWkec8d0zrPxLxUGStyV1i6cN1vgvU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s0MOgxLAWT9sM80WGcmoAfhWvIWEi2EAGzVFuZzlVSmiLJDBa4jX/2RzECEIIS+O
	 rzZfJDCBZo1l+XVmblWpQEbsbbuy9TaPAZ+muoeVHdz5F7XYDtXTAKoUq3bnzOLJg
	 2sAGaWNhP4x1KgODgLaAE17LCOcfRKPpbRHyREWxHoDorxY8NDyU3fuhzwZS4XwCm
	 tf3H3Sj/z3xhEP5lRxWSFxZwA2yURQl1aB31LMC37CWJeXIhmBerm+hPRcfz/eZlv
	 o2vD3OG39/op+DCZ3uIpM8y89vX2T8nIN1CxByYUK7ck6VShg2EFqm5Bb8UJUVRLJ
	 vU00tSBlpmf64O2Xcg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqZQS-1sMDaI1ODo-00nJd2; Sun, 25
 Aug 2024 21:21:34 +0200
Message-ID: <dc803f66-5f85-49d3-81e3-f56a452a71bf@web.de>
Date: Sun, 25 Aug 2024 21:21:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Salil Mehta <salil.mehta@huawei.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240825185311.109835-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] net: hisilicon: hip04: fix OF node leak in probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240825185311.109835-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2NVGSOK6IXgqH6/Bw7lduNJGL3LadftsiSIMZ52Qy9tlu/HZtI7
 2wuwyYtXsFvne/VCzzpTNtg4AzkerQ2FPUVPpzldoAV3AzwpHcDhnw21+bdRkcwYvRMWJNd
 Rj2i9e2DfnXjKqaLyuKbr68cSJuhqYkspXq7UESfWuUJXMM/X4oG5Wj5jIQwrBZItqw0UBI
 nTn904bWUuA9nekkjcMzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oYRNF0SmW0A=;B5l6BoDvfcXe1Pgmw3qj4e32YjF
 YQFZeeRqXnEQvz1KWitJptx7FcDlKoj3BfR4iD99Iv/FVm7SkBXH+SGzuI+tmbYlgOhYtBS1J
 eZo69bFYc+qy/5gcbATE23ayQtkGYrQlqHJj+5wGdq0/eYHwBdfibbi7385Ozjsrvbuk4ibDG
 QSTpPRNybuogZ0frVdx2oJ00LUeCE7esZXwIVwVRxjetX/xgo04Udti9r9n2i0mRwr9uKZAPt
 +Vf0euEcr6626IlfMbH7kuyRQY7oSpcfsIUOQKSPh6+D4+NPjkSWnZFh2XcmWT5kZ0SPVcxNl
 PMVTvkKET9pVEBePPwQI/jlAj3JiwF+7GdzXulY6wSRXzbjBT8DUmkbgY/JBlU+9Ivsr3bqdX
 BYbYbEEt7O2dg088zIbKUMXikqJc3Rh0hSyd/QBgnpaFBOPepN5d5WS+uuen7L1r1zNQy3aLU
 avvmDhHSdgIJ0ZjlG4V3bKqi4qqcUO9umXszMJ7J5LuApT0YUx+NXCZMM0m8DnRGXdQnRyChi
 gu8SdyQNYMxrn/Xf/UrcapbB2Adx+PB/jNkci0Xo7fTSL4ZyQIOF0C525JJa0Htc1cbpA5sm9
 2/48KOZvQZgfABzrq4W8O90luuSvorg3U4ETUlE5xDMyCy8T0b4yTkynxZDGbw2TfjKbMnwpQ
 /pLTU5T+WKIJeTP4vQIWq8PKtPcP52tEJgri8t2F3EuK34ahwu8eUkhT+IgTP+bqE8/RNqIrO
 Xsz4N7LxaAFzFtSkk4Y8l1Jyz3EDqXbo8ttu6U6OrPW6dMqUJCDv+qj937YM6/3tlY6M/plKm
 PEabX5on8dfp3bT3MSjwIJCg==

> Driver is leaking OF node reference from
> of_parse_phandle_with_fixed_args() in probe().

* Is there a need to improve such a change description another bit?

  + Imperative mood

  * Tags like =E2=80=9CFixes=E2=80=9D and =E2=80=9CCc=E2=80=9D

* Can a corresponding cover letter help?


Regards,
Markus

