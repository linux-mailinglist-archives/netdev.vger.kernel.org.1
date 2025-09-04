Return-Path: <netdev+bounces-219950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F355CB43D69
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BDD3BB90E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA0D305043;
	Thu,  4 Sep 2025 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLmzmxUP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0009B304BC4;
	Thu,  4 Sep 2025 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993075; cv=none; b=a8Y2Z7guLK2Y7StrOllFaWFjP2e3NmYJcAJRutPUIce8vSZPN+98V2QbPxYfztOEI7unTik3Dst5n8XmwO7coy5+lsWa1sr8zXT/JbsET+OkpNyJHBeqCOmg5kOm8/frpR+RqQAmtqri/r2UQJYZtej98RKq5+n7U4lEH8RrZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993075; c=relaxed/simple;
	bh=IZYPvmhp4Lu67EYKMyAIk7sdK71xXGH4/n1ufrRtfgU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGVFxp/KUKhh7VaaMod/R7C4iG92T6dtLUU8RmvFA7Znd4w4oPJMtrjZvXoFDzDT7BpUNBO3+tE11GohsFTkdOX1MlfDw4rwhzImv+MluI900d2EA9NqtJ6Uibk99E/a2Ez/dZqdaf+fm46pm1ggDRgvuGnxb4DTYPJ9cVxnxVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLmzmxUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D530CC4CEF0;
	Thu,  4 Sep 2025 13:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756993074;
	bh=IZYPvmhp4Lu67EYKMyAIk7sdK71xXGH4/n1ufrRtfgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NLmzmxUPhrUNM/sfjImKJAHD31D8b9GHAc1ioUIZLX12iEeXiOAZOHok9OBF3Fxiq
	 /atb96duOLqQMAa7f/7zFPzpRTmGmiYC5mv8uI4IW7lJMKvFu0BTqDW55qhDwkg842
	 kCjXJrDGNNKTKwUX9NMf6XtG43LxmCYvSgk6U+Q+YUf6mNYWGC0h7glxQkPJ20LbxP
	 YCM5nR0eS7r0XI1J4AtBkwyGsLQkYDWg+NSuzU5bmsmAgu9WqjYgMC+GHpcE5BoI1F
	 8zGtHZHYCtWwbBGd+12NQqWYZIk4Y5GJwFJwntobpugQuXr9tfN2Mt8uV/7LjNXzh6
	 ii9GmFTlCfbQg==
Date: Thu, 4 Sep 2025 06:37:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Wei Fang <wei.fang@nxp.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>, "Y.B. Lu"
 <yangbo.lu@nxp.com>, "christophe.leroy@csgroup.eu"
 <christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>
Subject: Re: [PATCH net-next 0/3] ptp: add pulse signal loopback support for
 debugging
Message-ID: <20250904063752.3183d523@kernel.org>
In-Reply-To: <aLmOfsgjumBX3ftE@hoboy.vegasvil.org>
References: <20250903083749.1388583-1-wei.fang@nxp.com>
	<aLhFiqHoUnsBAVR7@hoboy.vegasvil.org>
	<PAXPR04MB8510785442793740E5237AFA8800A@PAXPR04MB8510.eurprd04.prod.outlook.com>
	<aLmOfsgjumBX3ftE@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 06:05:02 -0700 Richard Cochran wrote:
> On Thu, Sep 04, 2025 at 01:55:43AM +0000, Wei Fang wrote:
> > Vladimir helped explain its purpose in the thread, do you still think
> > it is pointless?  
> 
> Vladimir gave practical examples for the use case, so no objection
> from my side.  I just wanted to understand how this is useful.
> 
> Next time, it would be helpful to have that info in the cover letter.

+1, let's get it reposted with updated cover letter.

I'm tempted to ask for a description under Documentation/, tho, 
I'm not 100% clear whether authors expect users or driver developers
to exercise the loop. Maybe such distinction doesn't even makes sense
for embedded devices..

