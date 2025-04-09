Return-Path: <netdev+bounces-180834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C9BA82A4D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2942818917F1
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB750265CDA;
	Wed,  9 Apr 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HyWfPfGx"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0834265631;
	Wed,  9 Apr 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212242; cv=none; b=t7H8azMflwksrSbCMvsSnuY1QiD14VgkYRietEHNmYnA2Yw02+/j4zv+1kg9ze4AdwHb4AkyiZCm/sF7igsJ4vFnUftnL5yGBjy0xAnwbedzrnmlHoFWIjg47AMuYXzT022fBSahpt/XlqniAjPWb9LCqbnBtLAIsURSjG4/J1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212242; c=relaxed/simple;
	bh=UIKs6oiDDGVT6GBVwmjJhm9dBlDygaMvkduIBBllUMc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nkCBAGLlW3Wo5ZaQgRNDPP3elD/ZJ0eN9eg3yW8LDy60dCFgaDIVmCyWzUzaI6TepsZs4oREWfs4TicD0RX5wmcBinPPCkJoYgixWwzvwY80SVveJpiaNzA8gyTdSlzg5lVnvPUfT3vwaX9ENOHNtIpvlMdmsPxAIwLKi9EW0HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HyWfPfGx; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744212226; x=1744817026; i=markus.elfring@web.de;
	bh=UIKs6oiDDGVT6GBVwmjJhm9dBlDygaMvkduIBBllUMc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HyWfPfGxJSbZ1tb0BFrEoFRldCHcbGpoxSGgyZZclxRW/bTdVkI1bKHG15q+7a4V
	 dJGxA6bLhL/qx26KmfqT5d83+gYxDxQrjr7/d13WBM5xEsoaS6QzZa64zZ8CVmpLS
	 0aQksS1k5SZDgDN1Rmsv5hwMEw/OXbp/remPfYugH4G1TdGZV7TsNIT7Fs5emdKPk
	 Z9W6XdDJwp9SrOERb6dNPLyi/iHvhVJ7TytDkGn9SE1lcVLUmm2EpvH39qa3mQdyU
	 FtMJ5AX3M5P+ypaR0LHwFvYI/3pyHoAsGPyl/peCGlN3co8xoSIpOucSvM3cmy5Mk
	 ixphjsTEzCXYyRoIuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.27]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLRUV-1tkjRZ1VFj-00T2Wt; Wed, 09
 Apr 2025 17:23:46 +0200
Message-ID: <7ff3877b-1a76-45a1-ad03-922582679397@web.de>
Date: Wed, 9 Apr 2025 17:23:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Abdun Nihaal <abdun.nihaal@gmail.com>, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Edward Cree
 <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>, Paolo Abeni <pabeni@redhat.com>,
 Sai Krishna <saikrishnag@marvell.com>, Simon Horman <horms@kernel.org>
References: <20250409053804.47855-1-abdun.nihaal@gmail.com>
Subject: Re: [PATCH net-next] net: ngbe: fix memory leak in ngbe_probe() error
 path
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250409053804.47855-1-abdun.nihaal@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g3j450taXfQDtq/hsbrkfVMU6HlxQxRNqP+/E+1gL0IhaFGw6H3
 4KVSAAva7cQCQZ/QIKxeGEbpmLjntZ7GDS+8bqmgZuCjT1vuAEfYHIyA2PIkBZUjgPiDcuB
 gb6DsZEE0HzJA6aWNyRNN8WqNHQsmKMs19dYe+l0srf3QcZmwltaIJHsj8hSHQ7YH4c+Gii
 b8gtPuuJRVtzzMpMqdGcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GULwdO+BOtQ=;ud4alpcL+R5jhs1ZPcYUz3bBZdZ
 VuZ04wqRjVtS/clCaoIDYocqQut0UHvns3jDz+BxJzDr4r2vzTDTdqQlEm43Pp79zm0Z4MqJ6
 O716d491EY+zAui4StKy5Jm+JkBRVuV0EHwktZrIujmyC1reEFQ7wcZde1xf/FijCOZnXE9UM
 rozcpGqYYiT0mD1SoIMz/1AJPm8cJoQnvw3L0usI11rsmrWWvEG+NARmCNntXwlmaM+ZqFWb0
 R576hAot8naCAdjAOejHBZGXinIiwjZVIUTf/O8haB+aiWxjWp2m5QjnRAvkkyv2X7NtYKtYX
 +ry5m0ykYaPmjwT2rfcbdNBu9IvG6DOiQa0XtHQPQlnLNm8c1KXqJRZMIEmky9TSFrPuYZI6i
 J0dhiNV6lcjJxkmkBJOM2qLscN13O2EZd2jZnl64u9qa1ut/fM5YWIw4MP0CcTLlPkt/ZKyGA
 OkoQadjXI/KNNrXYdFYiR2amP5gsLqJoRx2CpnXQ9RgxF4PKoh3xSiiX1bwDQvD/8gyCQBVAO
 SvNygbhGXRGx0zsYFc+5aJyA3AQIJurADT9guo+YcHsF2cSA33o1s62oiYaYjaPKAUR/qCSmg
 aYD7LGyo6DUl9k6ATxgp/hU/tVOMvaT/lzRcpoCaevAwDpGIWk3bxPZqenmNViRMsC2c9jQr/
 OXcrGB4de/XygFwnOmc6icuA90iazpccrLP7uppX4xxPrpQXVC8U0C1od0wDq5EdTqHBqM3ZP
 hH+vfL6bety+nKlaB09nf/Gj0aknxMljB0hvwIc37bVnvNOmvO5ykgFXZI3S0AG2GItvJu8vP
 Zl3nEiSE6r5s2PwGLBfedFo/mcOPslZoF9eoIxA6F1UusCSAmTI7IXwdkLqJUEtmPXNkH8yI0
 XseRIXUCY23ydxJCcUzQ3xbeOHB4+YRc4YQCgwoAgNVtwSq9X7pu6iCY//YLzpy/ob+Lhnx1I
 aZOQ5UMrB4No2A3l6cg2OFNvxmTd4usfVVcmldvObjyyj8lpgpaXD55bbtrKN2GgjyaLH330p
 /ae1ypuCjuAb2sXoVctPdrDwxB9t7q/YSoWsTgFWS473rq4/tKkWhTQrXwQv5es/Ad4kL/hZU
 CM44Scg3xr+mGhG2JfmFxN7nCb15wsLz6HLjTqUulykhrNkz0waQ1Xs75vhZXisJMQgPTSQjT
 BalyTYciQITa9yyzABb9xIYGnOXQSYhy3LsIlbzRc/CPcdkZGRRTv4YfRg/ZVEzpj09VgZZCn
 fcdC1u+5m+j0rsiJI0Le9MVGP0KcvU1aQEJPQMsrXS3ujGZO/ozvV80rh23EgoqfotTsCA5KY
 ya+Kl5B5/PrKygPfhBJYnArYZ09n1oTHPEOrB25WEmPbmLg97PRVdWNjKnGisTmrhz453ZMha
 A0eOM2lSyg1DmdHIW0R57ebaXrgqu53vS7lpRnXOXADBL7qqrrQLmR9vQLWPoZjjQG5SAhifs
 l32/FgtQArPfY1Rgcvt6PE6CjkOE7s2IKrMU/URHk3f3069HC7Mr1r4I/C8V5Qqk6G5dRCA==

> When ngbe_sw_init() is called, memory is allocated for wx->rss_key
> in wx_init_rss_key(). However, in ngbe_probe() function, the subsequent
> error paths after ngbe_sw_init() don't free the rss_key. Fix that by
> freeing it in error path along with wx->mac_table.
>
> Also change the label to which execution jumps when ngbe_sw_init()
> fails, because otherwise, it could lead to a double free for rss_key,
> when the mac_table allocation fails in wx_sw_init().

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.15-rc1#n145

Regards,
Markus

