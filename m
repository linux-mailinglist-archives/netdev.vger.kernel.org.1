Return-Path: <netdev+bounces-15938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C9C74A8AB
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 03:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC4F2815F6
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 01:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A67110B;
	Fri,  7 Jul 2023 01:54:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006677F
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 01:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B2DC433C8;
	Fri,  7 Jul 2023 01:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688694865;
	bh=poyz3TbO/25nZod2DR4xrtKAvBjqQyx4u3E/hLp+TjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LR4fp03QomfTikxL2XlK0mMNRCcl67j5iRa4y+mQv9wSF1Zhkit1t1ttKqGCGScbG
	 JrhWAJwnhh5QiGLM0sLJ20Z5y1HKvZPJ3EyGtH87m+cCSUw0bNUHvqp09ysUIv2tAL
	 UPI+EJ+nZukXtxbHPyRNT/upf+TrUf8zWyMm7yBQfl7UWXKI+Gfg0O6mGTqyx1MHGP
	 AzldhAejqEJCvOmIY/H0nfGdMAuk8N/aFE23RnOeJkNj1g9V0wdekK6tVi34ZA9VtY
	 dIMDmbuHk1NuOF5ztCLAFiJkakyRBc5wQ9iwicCAjSf4S+M0MEP2syV5mpeXEPNsjD
	 tZHunRFLiqQrg==
Date: Thu, 6 Jul 2023 18:54:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= <machel@vivo.com>
Cc: Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>, LKML
 <linux-kernel@vger.kernel.org>, "opensource.kernel"
 <opensource.kernel@vivo.com>
Subject: Re: =?UTF-8?B?5Zue5aSNOg==?= [PATCH v1] net:tipc:Remove repeated
 initialization
Message-ID: <20230706185424.3c42a750@kernel.org>
In-Reply-To: <SG2PR06MB37437B48A4A7B0902222CDD9BD2DA@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230706134226.9119-1-machel@vivo.com>
	<20230706084729.12ed5725@kernel.org>
	<SG2PR06MB37437B48A4A7B0902222CDD9BD2DA@SG2PR06MB3743.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Jul 2023 01:21:52 +0000 =E7=8E=8B=E6=98=8E-=E8=BD=AF=E4=BB=B6=E5=
=BA=95=E5=B1=82=E6=8A=80=E6=9C=AF=E9=83=A8 wrote:
> Hi Jakub Kicinski
> : )
> I understand, but I am confused about whether my modification is wrong?

The changes are so trivial they are not worth spending time on.

And you haven't read:
https://www.kernel.org/doc/html/next/process/index.html

