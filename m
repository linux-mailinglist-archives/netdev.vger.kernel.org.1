Return-Path: <netdev+bounces-176480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D8EA6A7D5
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015203BC99B
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D8B21CC6A;
	Thu, 20 Mar 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bfA6Lsdg"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB57FBD6;
	Thu, 20 Mar 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479252; cv=none; b=mXfRANI9vjeoK1097HBjo1iKIROo6jXnPWaJFPWPBw6xvHfuoXn8+aeGQ7Tfo/eil9v1E5EPgGJCbRYb8GmCR9xPA8JunjPwVuBCIarMfFW5EavUNUcXKkVWjtNPsFd3TXJA4rK/zof56LlzfIhny+QdQtcc13D7cOFSNtZAl0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479252; c=relaxed/simple;
	bh=Yed3L98sf2achdA6mINQRH7piijS/m3TD77kPOKAHcA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mKTT6xGpXEy8UReZ6w8Hdc4AH2tGMtgN/RIfr+rux89NX77xRbomlsYE30du0Le7xeJVEVPxfybCdqh6khkjSf0c4rz+pSqNc/R6r58uLSi1FDK64HQP54aKlXbrOl8tP+5cotagm8iZwAYNrXkbSiENBOKWRgX4TEq7mu+1qnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bfA6Lsdg; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742479240; x=1743084040; i=markus.elfring@web.de;
	bh=Yed3L98sf2achdA6mINQRH7piijS/m3TD77kPOKAHcA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bfA6LsdgjBtvI2DizTswuNxrVMsFRa++NKotRjV5lCLEoYbVx5wCOUBO5L+u3VC9
	 LYYBqMAPRn9jZ856vm6Fs5j06Ov7EmbZSx5IWvkU5tZv0HnBlAzoRSowQdKEJLZqR
	 Zyam0lR+kwOzpq4dZ3mGzI3gImy6jNeKGUJxhCiZSX61Jm4HrcHFODX7KFOJ5Av3G
	 ny1wqZFB35gp/OK/5j0XDmy7sfgX9KNAleaYS1vI9KB6BF7t5j8IC+VDkIf4utwWX
	 T74GwfleYlraLPEdcpFvgWVbI/DV/ShtNWziViyByEt+FJJfCSuIRJMnShTrBdRwB
	 PvOm2bj0f+hEZRL5Cg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.46]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhWop-1tIbmd0OHL-00hojO; Thu, 20
 Mar 2025 15:00:40 +0100
Message-ID: <fe81f330-c4bc-4321-bd07-c03ee2cbebd4@web.de>
Date: Thu, 20 Mar 2025 15:00:38 +0100
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
References: <20250319112156.48312-5-qasdev00@gmail.com>
Subject: Re: [PATCH 4/4] net: ch9200: add error handling in ch9200_bind()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250319112156.48312-5-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R8RapO+hNRgOyLi4zpg/YqbLfVBEDLfPXqAZEbs4abDg3tW39pq
 1t5qbJB6W7kHa278b97hrkQOJGDo3NJsjeC8l2siT+tudCruh1/d47vLCZev40ExwHU7qwM
 iXivpgR4tyzafgQzi2upu1/SnYr5NC+Q6KcpNv3swgOcAheC29FtJzPU9JzehOUvSiZkYmb
 Rni8Ksy5O8f0Pe52mu5yQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PTvn4IV07MI=;Uvsg1VKPY3fDn6aA6d9j1C1+4ak
 ZH0x9dI5L9MfbVdkK3+pqDlqdkK4gAESik3JLt4ZUvFj8A0VNic7SVt7C82ovoV1lEfdOTK3X
 r6MV+eLaMbuoer/r6zDi/Zno8OmMDsSs6fzUZ0b2mDyS9U6hCeGjQbVhlLDgc47RHv4Bz5Cvc
 MVPlO8ZZHESI3Y2KquPDie2/4luQiK1rzhD5K8SXEgoVUv40vv+2qpEvmJZ2Bk7W/o4CmyKSi
 5uD7lIPywDQ3jJ+lwqdUZaWIyc712+DzUxZ2MemLJA6/fR/zNiYpfuptKoquTvu2+pfFasQPt
 FgnH9EuTULs4vUje/joV7TgzrGzRjMp8sbkG0G3JuxHDQ+4HXj6LV5pZ6P6ALzBQG4tzyBuFI
 rerfLqa05xiM4ymnBmxTPzCfoQVC6LIJrSR0MoaAWi+mxvIUJnHh1A6fNqEmNga4WCwKjNh4K
 pn4gRmOYixsT2poHzsH5ZLC+/hoOjATQYcguN40kLwbBD8dtrYvS26sjSEITDs7oLs+miVpuA
 DHpJ2g4ol0JqRDHeOUjMO9P3XEkm1wPZJxqcXEhMlUE85lq/la+YAUGpW7ghAfG/JWq670t8K
 YEGwKU9N/dux6xsHT7AyLC2HaD73fxVYgVsEI61aJ54izdPqomr1CiU6W2kklQf3W9BoT2zd+
 HjBsWMg/CHiPsGt/+nI9Mt7xYLFblDUxZjORgyEzqfRAQSQI7d98t2lrOHqf7D5Mye8AN1krX
 LhkMUFOcjPPXVJ4HnTfrNgcWF9LDNln2ehzOXz1iOKknAma29JK5q5vrXujW0/aVjz9yZWeZm
 kAd5IXCf1ucUpyVLmtGSOOVuIudg4B3iH6/KuNQbolJgg9siSQBluqmSnlxMVVTrE0CW13m3e
 KP4v6Y2rlqSHBRD49rzGpy4/CCkItjDAdM61qvr63ABxGh5X+4lxJh4WZxK9VXzpnblIxMzWD
 XxggMgSXKhRz35vapUH1uug2djaUJQGiXpY12V9Rw8e22fgbwRgHEqfgy4aK+GpvamE383Dxy
 i6BtKLUJXAXXuB1x5OaD2zuZXzVVOHjDUcc2RxgWJ65eq31uXmV6n16ptdwmZSwuQNWCKFLwC
 D9gZno1PcG98heDjnboPptNJQxR7Vc+MbaZNd0/shzfm+jTy8T2Bw1OyhnSRQKgl2vf50OrTL
 LxOkaepZKC/qITkN/gPdNtIJKVd5l8IigKcIJzdb+uYNHOb4YYzOG99CzVBhwUb3dLI+kWyRZ
 ioIGp8Nj+i8DsfSffamSkiC5FAgrb8aiA0CEwPPWNnVnestc88LiLFQlKEh8HpvYxW/aYbc7M
 +Mq/kh3Omp+tNSwrNqzdI6mR4bvgOhF+9GkY81QYyH8f83qSsrQHC4zbr4/u8601kGvSXNEAR
 A+Vr+iURm0jKwr6CkoNevncM+Y0UEvIByF/ONB6FjQrLQOueGCfeG1xu7nns+wW58aVLBU8sp
 B/w8J1YOH7AoDvBbKTPYQBkZlL3hCC0ebgkG0u2Ji/dVE+qQq

=E2=80=A6
> Fix this by checking if any control_write() call fails and
> propagate the error to the caller.

Another wording suggestion:
Thus check if any control_write() call failed and propagate the error
to the caller.



Can it eventually be helpful to transform six control_write() calls
into a loop?

Regards,
Markus

