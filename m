Return-Path: <netdev+bounces-246369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA84CEA285
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 17:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CD643016351
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC94A2DFA46;
	Tue, 30 Dec 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="LjhWoVpJ"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster6-host3-snip4-8.eps.apple.com [57.103.76.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215E023D291
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767111655; cv=none; b=GMGTmZNJfofWKvxxndjcNAJ9S98oJBupcxLDeQf1mL1n2PUT6/gtcXj5rjrEN2ZieFsi7un/cZQEHWSHz5jEi0UQfZCUBLB1pBYQLIbERLgS63XcMFxFv2Y0bzQfemZUEbM28Qo7Gz/2rnKqsbwnbiuQUrhZUIfAONMbnOFELA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767111655; c=relaxed/simple;
	bh=dDXWnCq0Za/OuZWyC0m5psZoWkR2+Iv9p0NoWO6hGAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJsIx8PLnuzAbuLWygLlVQU6fGs1Bc11dM51mO26WzcVBJ0JA8Nm2gbwhpiKtfyRgfUpI6sLm1NU68y12mdWJfGMfE6RxFwXipYbNMDO989tL4NJDDT2B+a9KU09qDr5qfiCa0/fNel3u0v0BvyvF6fKyQQ5+Kv77YO3/F+dlp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=LjhWoVpJ reason="key not found in DNS"; arc=none smtp.client-ip=57.103.76.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPS id BE6601800945;
	Tue, 30 Dec 2025 16:20:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=tSItxaKxgrEix3YXJKP7kH4+YC+yo1zWfJ4X9i74RkY=; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=LjhWoVpJBImLPH25iNCinboAeJI+3Mn385QmdQqrBIopquopj+FyfMIaOZB7GBG/VttyX/9zzQ6Uu0aQILVj4dB25u7WYGM1UaU0q7AP8EH3PAO97Rar+nGnVpT0jQNqZSrB1cL9TMSQ6dqaSReNzwRZWmLgN08G1wc+RQcdKfxK125hILAsPt5S7JLZEnK5pHxGVhbDvp6cLRobf0JKCyJdp8eOjMPUdi29YB+CMhkzYW0X4hvOS3csG/Gi5P63hd5GSr/B2tnyaTu67a3SyuXL0/69dUWTvyvrtplcGCO+66BNVMAsLuG82eTlDdliIC/GH/9BwTt7U/i7h1buVA==
mail-alias-created-date: 1719758601013
Received: from desktop.homenetwork (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPSA id BAFF118001F3;
	Tue, 30 Dec 2025 16:20:46 +0000 (UTC)
Date: Wed, 31 Dec 2025 01:20:43 +0900
From: Yohei Kojima <yk@y-koj.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/5] net: netdevsim: fix inconsistent carrier state
 after link/unlink
Message-ID: <aVP72wedMbegkqzs@desktop.homenetwork>
References: <cover.1767032397.git.yk@y-koj.net>
 <ff1139d3236ab7fec2b2b3a2e22510dcd7b01a21.1767032397.git.yk@y-koj.net>
 <e8180dc5-fc23-4044-bd67-92fc3eebdaa0@lunn.ch>
 <aVLc4J8SQYLPWdZZ@y-koj.net>
 <1c8edd12-0933-4aae-8af3-307b133dce27@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c8edd12-0933-4aae-8af3-307b133dce27@lunn.ch>
X-Proofpoint-ORIG-GUID: po66zsw5zFCFgmG7oSpJ4WJ_0KLjmH5g
X-Proofpoint-GUID: po66zsw5zFCFgmG7oSpJ4WJ_0KLjmH5g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDE0OCBTYWx0ZWRfXwkBLL1IHA9om
 eWlKhSnw96R1YxjoeofbFNxwf/cCu92OyqSJKfqGIld4doPkLdXMx5Ti7Lg8my2fM1u2SSBVQjd
 ntqcGWgUt1hLlZFlefDcj9alnZPL6IBhcIyqXKoxH3AfQ7+BwwNuZ+2JYvn1JcRFJx8Z+ADmL16
 VlIl7HPPvci6SH9f2JHi5z8/6uCdEHOE3h745CfEDRqjDc8zPLIaYksYClKGCZugYG06LOXEcj9
 +9927RVf7HEPoaBt/WfhdaG5tBuALjnvqRjAYrTYDkGEoPkxc88ni91mH9jLSdO6HwFnw7qZg2I
 ZP8DcGRyiYPT8xgvGwU
X-Authority-Info: v=2.4 cv=EaXFgfmC c=1 sm=1 tr=0 ts=6953fbe3 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=jnl5ZKOAAAAA:8 a=-R4GPZT43BhAmBvLjtsA:9 a=CjuIK1q_8ugA:10
 a=sCYvTA3s4OUA:10 a=5imOhvl-4yYA:10 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_02,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 clxscore=1030 adultscore=0 suspectscore=0 phishscore=0
 mlxlogscore=392 spamscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512300148
X-JNJ: AAAAAAABtVWw0NogA427bYar3HqBdOi0LuUt1K9jL2dk7SmvZnxJcKOZIbpT/6fJj0lcQd3OG/WlrgRL9QEvkKElmBa6efvMk2VNeUXFd10ROWhf0p31Td894idCtgyzrFT3+wSkBS09//k+OCsOEwNS3FXqe+MAoKeQhjE7Y68NtlDuWtSkV8rwXdrDAI5aTYvvg8OYpW+MpJGrk0/qZSp4UwpswiNuEjPTJUMG+XAj65nHoJTmqwmAXN0g5pzhCCA5qBc+i7Ri+RVixr11soar60GsCSQWL+pk/KGatH7cpGHd4pmQIJQJNaIbwwzqUTsNWjWlZvLnsDH9lb49UD8C8yE/jFc8Wvf+8qiFXC0YBLKdUK+dqVKunCv6P2YwZkePW0Ew5XiKAmJriVLz22DVDfl6qdCJvnU8I8EqQ0G5Nhwh3j/gzNdAwBcippCG/sWqLv+CRV0ZSsPb1uC+HFecwHHA/VB86qfB3OYwKIOfL2292sWL6SQxl4/2zhlG6TBhdjwvfWBdrMW0EAPuLK8d8joLpZCLsraqEeCjItNShdwzYXZrjfNJ5MI+suWVwVZOXOsnSe4QY9jt/kvA2p92XUnIBTP9rUEBwFxJsSS6PrKxW5WtLPLxsNrI4IHQM4JMiNjJIrrP0OKeKP0N4cBNgiShGwK6OPpgOVqkr54RsaLP/eHEnrHTgWxsIs2tAxbTY6HdbWGMdyn+0bYBSA==

On Tue, Dec 30, 2025 at 12:02:22PM +0100, Andrew Lunn wrote:
> > Thank you for the quick reply. I don't intend for this patch to be
> > backported to the stable tree. My understanding was that bugfix patches
> > to the net tree should have Fixes: tag for historical tracking.
> > 
> > > 
> > > netdevsim is not a real device. Do its bugs actually bother people?
> > 
> > This patch fixes a real bug that is seen when a developer tries to test
> > TFO or netdevsim tests on NetworkManager-enabled systems: it causes
> > false positives in kselftests on such systems.
> 
> O.K, then keep the Fixes tag and submit it for net. However, the tests
> should be considered development work, and submitted to net-next, if
> they are not fixes. Please split this into two series.

Sure, I've submitted the v2 patch here.

https://lore.kernel.org/netdev/cover.1767108538.git.yk@y-koj.net/

Following your suggestion, I've removed the unrelated TFO tests and
the netdevsim test improvement. I will post the removed patches as a
separate series once net-next reopens.

However, I kept the regression test for this patch in the v2 series, as
the "1.5.10. Co-posting selftests" section in the maintainer-netdev
document says:

  Selftests should be part of the same series as the code changes.
  Specifically for fixes both code change and related test should
  go into the same tree (the tests may lack a Fixes tag, which is
  expected). Mixing code changes and test changes in a single commit
  is discouraged.

> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
>     Andrew

Thank you,
Yohei Kojima

> 
> ---
> pw-bot: cr

