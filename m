Return-Path: <netdev+bounces-53993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AB68058AB
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF6F28219E
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F48768EB4;
	Tue,  5 Dec 2023 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+u2FnOS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70610AD56;
	Tue,  5 Dec 2023 15:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA2BC433C8;
	Tue,  5 Dec 2023 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701790154;
	bh=SclM1eXnYMdnRBvBsf/lJdJQ0p0yUDsjtvGBYqnKRvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t+u2FnOSzD0cZ0AXurNhbOSSJJX0fjLrpxVxj6J14W/se6GIxs6iMIOoGYr9cdPKG
	 z9jBGgLMCmn0X3Q0RQejJxVOJ2S01GZ/pekqoTzjtwYLWVD74qxMlgj6kHFvQ1yBBg
	 2t9Kz2AmDcSrjafmINUo15LXgEQ8V7Iu8xmJBlyk15/u1RUdwloUJqmM8kFwHcu4GO
	 tiITk+KpH4rw7pOy0UredN999rtOK2t05dEFp6I9yrbf/Pw7jFMSr00fhE5MTCDghH
	 ENTAxxXxsIMBrZdJKQaP3+VmpeVsPivJEnxKFLPsee5YTaaKlw8R2lnCJSBEFjK9Fp
	 7NKl4u74A8FnA==
Date: Tue, 5 Dec 2023 07:29:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Christian Marangi <ansuelsmth@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David
 Epping <david.epping@missinglinkelectronics.com>, Vladimir Oltean
 <olteanv@gmail.com>, Harini Katakam <harini.katakam@amd.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org
Subject: Re: [net-next PATCH v3 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <20231205072912.2d79a1d5@kernel.org>
In-Reply-To: <ZW89errbJWUt33vz@shell.armlinux.org.uk>
References: <20231128133630.7829-1-ansuelsmth@gmail.com>
	<20231128133630.7829-3-ansuelsmth@gmail.com>
	<20231204181752.2be3fd68@kernel.org>
	<51aae9d0-5100-41af-ade0-ecebeccbc418@lunn.ch>
	<656f37a6.5d0a0220.96144.356f@mx.google.com>
	<adbe5299-de4a-4ac1-90d0-f7ae537287d0@lunn.ch>
	<ZW89errbJWUt33vz@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Dec 2023 15:10:50 +0000 Russell King (Oracle) wrote:
> I've raised this before in other subsystems, and it's suggested that
> it's better to have it in the .c file. I guess the reason is that it's
> more obvious that the function is documented when modifying it, so
> there's a higher probability that the kdoc will get updated when the
> function is altered.

Plus I think people using IDEs (i.e. not me) may use the "jump to
definition" functionality, to find the doc? 

TBH I thought putting kdoc in the C source was documented in the coding
style, but I can't find any mention of it now.

