Return-Path: <netdev+bounces-49418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF197F1FC2
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 22:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC287281F3D
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACE238FB7;
	Mon, 20 Nov 2023 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKQEZKtO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E56F38FB6
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 21:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5678CC433C7;
	Mon, 20 Nov 2023 21:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700517184;
	bh=9RqEIpuLdVNZNHQa0nNGH5rDz3KYaKakSinhvKWkJiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IKQEZKtOaFgUogApHmwRGDszSun7xUOeNSfn9fJzwqll2hlDNa0mqCGtvvZ6N55a4
	 FtMIf3tRuFWftWjW7Q1vQ7Q1HV0tLtQ4Ccwwg9f2hqF/2X+Ajme4IBwpt5jQk4ulc0
	 bu+c0DNJSG/Wfimighx0qGswrZj20WgoG78T9ez7dHeTUgduG8T2KUdjJC781F0haC
	 7UvUaO8WbuWMFVkuMasQqMRbHPaIHujWpWMlfzwwVEvIori6rLke1vtrlVwVaFlWz5
	 iNkAW6me4t7ccEWSvWUY6p7UcSpn0+Ogh1nmMQabFF3Qey6+VtXzr0eMJwMROsQ1QW
	 FoerVtRfC1duA==
Date: Mon, 20 Nov 2023 13:53:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: correctly check soft_reset ret ONLY
 if defined for PHY
Message-ID: <20231120135303.0e64bc81@kernel.org>
In-Reply-To: <655bb7e5.5d0a0220.59243.9a2c@mx.google.com>
References: <20231120131540.9442-1-ansuelsmth@gmail.com>
	<20231120094234.1aae153e@kernel.org>
	<655bb7e5.5d0a0220.59243.9a2c@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 17:50:53 +0100 Christian Marangi wrote:
> On Mon, Nov 20, 2023 at 09:42:34AM -0800, Jakub Kicinski wrote:
> > On Mon, 20 Nov 2023 14:15:40 +0100 Christian Marangi wrote:  
> > > Luckly nothing was ever added before the soft_reset call so the ret
> > > check (in the case where a PHY didn't had soft_reset defined) although
> > > wrong, never caused problems as ret was init 0 at the start of
> > > phy_init_hw.  
> > 
> > not currently a bug => no Fixes tag, please  
> 
> I know it's not a bug but still the referenced commit was wrong. Can I
> at least use Ref to reference it?

Not sure what you mean by "Ref"

> Due to the changes done to this function, it's hard to catch where the
> problem arised with a git blame.

Right, and you already quote the commit in the body. No objections to
repeating that if you want, maybe:

Introduced by commit 6e2d85ec0559 ("net: phy: Stop with excessive soft
reset").

but as a part of the "body" of the commit message, not tags.

