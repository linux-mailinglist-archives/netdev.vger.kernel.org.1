Return-Path: <netdev+bounces-246383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B76CEA7F8
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 19:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27A11300F5AA
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 18:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED1D32C312;
	Tue, 30 Dec 2025 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="QrxzF4bz"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster1-host11-snip4-1.eps.apple.com [57.103.64.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26B732ED41
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767120260; cv=none; b=J+kTddYicAHhHmC8X3W8mSFsBvcacYE3OkGn1sxJ7XultITVGDoeBNxUcjtcjU9f48Xrr1W3jJj6UMmZjQy7mwDvZ4n7DLgvQZVbIWHUBmtYdU8S+Kj14qwB+arQ1TAeZOGhHj3MxPYf85f/zB7Ip19GJrwEspPy/j6Hlq7MsY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767120260; c=relaxed/simple;
	bh=SMImo3ORCUvjc4xSB2lVMeLPBjj8z9R8OTx4XA5kTtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bwb090vUVISB+lNdi3L2mDHmZbHKyTDvxQa76om4aGpR4R+bo2DRtP1RptVJQKZ5pkQOd3h07Jfzy42M6rVJaEhj5z7UXjk+I6ecNq2dPB/fq/1i3OIbbHVyisssQfG6tlFsgn3ZY3Ouy5Yc8Q1j/WZtCOlJvhly5dLirtgFFvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=QrxzF4bz reason="key not found in DNS"; arc=none smtp.client-ip=57.103.64.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-14 (Postfix) with ESMTPS id F113D18001A6;
	Tue, 30 Dec 2025 18:44:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=O7v4N3Ho181TS8rbUxfrU8UvYC9fe90w67sMGyAnWuw=; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=QrxzF4bzzKE60Zw6D+dU9P5B9jCl4CfrqUIypIaWhlfpvWTjENrmBTboT1+HaNj7437f2lSyYDzUt7eb2zZLicKD58+ViLQM/KBEYIIVT0GWwMMDULWmDwgOFyEZOw8Dv9Ztf4PS1o8OC8Cs8fIqyEWJbiIWBek/1rn2NTsWW4aLg6loC2rmXrzkJx88x3WPySvso5cOQXz/yEHaTnwCAGJtpz421XYYbLj885YTRGGt4vFQzmU8BJa0p1UX2O6ZBijWxr51NUZ/53RCedKfKnW/UEZC+lq62a+LiEQWDHoIm7P5kayWE5KGUqs63D4r5w+19pau+dEE42IEwv6JZQ==
mail-alias-created-date: 1719758601013
Received: from desktop.homenetwork (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-14 (Postfix) with ESMTPSA id 443431800091;
	Tue, 30 Dec 2025 18:44:15 +0000 (UTC)
Date: Wed, 31 Dec 2025 03:44:13 +0900
From: Yohei Kojima <yk@y-koj.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/5] net: netdevsim: fix inconsistent carrier state
 after link/unlink
Message-ID: <aVQdfaYqt2ahDSs3@desktop.homenetwork>
References: <cover.1767032397.git.yk@y-koj.net>
 <ff1139d3236ab7fec2b2b3a2e22510dcd7b01a21.1767032397.git.yk@y-koj.net>
 <e8180dc5-fc23-4044-bd67-92fc3eebdaa0@lunn.ch>
 <aVLc4J8SQYLPWdZZ@y-koj.net>
 <1c8edd12-0933-4aae-8af3-307b133dce27@lunn.ch>
 <aVP72wedMbegkqzs@desktop.homenetwork>
 <2a1e3bdf-e6b0-4c6f-ac59-cda5ec565b82@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a1e3bdf-e6b0-4c6f-ac59-cda5ec565b82@lunn.ch>
X-Authority-Info: v=2.4 cv=Sej6t/Ru c=1 sm=1 tr=0 ts=69541d81 cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=jnl5ZKOAAAAA:8 a=JsK1SPK4e216-w5R4n4A:9 a=CjuIK1q_8ugA:10
 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-ORIG-GUID: epIuVc9zcgsnq4mFuT0SgnnC9KF-Af0f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDE2OCBTYWx0ZWRfX2O8/4Aqg+e0L
 LuzqyoFHa7AunJKhyJBUgVnSJ6sTjvGgHn1dJwXPWvFLe8K2L7VVzT2nxqJwXYYs3OXThCNt4kp
 NkhBawBtVvRK48yBVU452f4dEmbnM4vnqd4qQdbUdt2YPT2p26Qlk4VOr+qRNERkJH0ci64moXN
 odvWIQqh7ETGe0suxI6Lgo3Rl0o6ijvmAIXYrKn54VpN61JRWWfJNGshYnIKJy6eNmIy5kvkOgv
 Vx9c/GMw7ApJgyeDkoGYjjyoFQGlVOZAZKhkCIaU51TYRz411Aqpa3n/FbDUitRqpZei3QN5496
 NV2IJvybfuLjzxd33Wr
X-Proofpoint-GUID: epIuVc9zcgsnq4mFuT0SgnnC9KF-Af0f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_03,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=363
 clxscore=1030 bulkscore=0 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512300168
X-JNJ: AAAAAAABzZCSw2rxN2xzCib0hoT3zdOphpmJr4yEPIAskY48vNPaBPOkfAXP0qz/l09tFPym6Zt/2zlrhASbbJBThJu0cb3m++RfRPHnITHgVKjzvBPe19ObbqPl/ydrGSDkOA6PZXKOtiIt5+bXNfE8ABoQvjVSzzP3a+dhfxrDncVFjSUqT9jemVCE0Ry2ydqhFmQkU+JEkzXZ4tm0dUEZH8l7h1S0o5co3DmYAZs+oAzOP2VSa2qWWmPywfKT6dnsDnpLwAhKDzaHq8uTsaANhS7mbAFAQDqoax3wJeMtU704HcjecedUbVKZGs2Tg4EVuo/wlHjWLPIhKo+xx6E7bNjEd1PuQPsDxptrp4+c20IiJTC/PM/L4Dznqe4pssTcV8aqGVtGDGExOvu1on+iqtwc1RiH3jd6W7x395IYPGvFcQnB6L0zAuUG7u0sAUjbfY0KKoBVItd01kwN691HzS0+SWCIywUWxKj7jCtxI7WwgRthPVCekCB3lrt+4PS97SDxJr4TswUr5Tc0fwMb+sCvbTRE2ZywDh2YdGMIn1qHVuEYJENm0uw07ewM7Kz0Ld3sso66tb9AZFqtFIwgbKCzcqMa9M4SHkhV96cacG+DpXwIARp8Z8jAdqiSzxKa1QoR2WUaAiX80jd+aZtO0o401jQQgvWY9/h6qXX1M+OLKLrL8uet7EXg06Lxb9GPWqMqGCjIQ99uwFb13P9xKIVcbP7hswq7ZPiseEFOLwws

On Tue, Dec 30, 2025 at 07:38:01PM +0100, Andrew Lunn wrote:
> > Sure, I've submitted the v2 patch here.
> > 
> > https://lore.kernel.org/netdev/cover.1767108538.git.yk@y-koj.net/
> > 
> > Following your suggestion, I've removed the unrelated TFO tests and
> > the netdevsim test improvement. I will post the removed patches as a
> > separate series once net-next reopens.
> > 
> > However, I kept the regression test for this patch in the v2 series, as
> > the "1.5.10. Co-posting selftests" section in the maintainer-netdev
> > document says:
> 
> Thanks for doing this. I don't know enough about netdevsim to be able
> to do a proper review, so i will let somebody else do that.

Okay, thank you for the early review!

> 
>    Andrew

Best regards,
Yohei Kojima

