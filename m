Return-Path: <netdev+bounces-109954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DA092A75F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCA61F21060
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE3F13E8AE;
	Mon,  8 Jul 2024 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxTLsOGi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57E61E876;
	Mon,  8 Jul 2024 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456397; cv=none; b=iwUuhcoPNcrXXEvN+717sLIP8YH5Wt8COUkXg2Msm26HKlFQZ9Dwmi9kRQt37/PEcvtarT/HhNg+yXj1PTXpzLAqp6pkR+nRB8Ark2LShbKLm6Pp48YXX/C4najZbuZ3LdZgXK3YwcmvUukHNbAgj/LMZKn2pviLO+dW1g885eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456397; c=relaxed/simple;
	bh=a71drwP58QxmafM51zPnXJE/VMh25mmPQBmVIieTbpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReUQemwmiZk+jQijRMNxpakn4kDvq/Lx2+5SszyFnDocb+moghQELS0+trpb6g0vdgqn5Yy5G2N7QEsaoWKmKNz89rGuzYwjQjM+qFlnDvsdy4DmcKNFqGy1KLalQjMGXCVJtPvlM9ZMV4T+ARtEmrtCuNORMs6iM8IISTX4bVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxTLsOGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF78C116B1;
	Mon,  8 Jul 2024 16:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720456397;
	bh=a71drwP58QxmafM51zPnXJE/VMh25mmPQBmVIieTbpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mxTLsOGi45hglJ8Ql3wohw41J3alZ30CjzOFi8fgOonhRha6MguSU8TWrnNmTuhj2
	 Rfb83DwO++OndUOW48uL4tkcaz94bEaQ+3keDsvmKJKnnXAYnD6HhJT6uAuksfTSBV
	 xFiPkGfUa0yqRDt93PFcTlYT2h5HkfNZLrhYju+cHTwF8o08EIOIH7Fk5peDUSA3bj
	 TGoOlmXuoGNPYt7+7CEo+WdbczGj50jU7bNrucn5C+5/gXFgXu4xihyb61vCSzaf/B
	 RNMkqWXkcD4Ctu+7OIPveMKTByoKSEdk16DIkxDzF1ypeumCU2dMDYilGEVKe1nytZ
	 OE7W4CtzwBfpA==
Date: Mon, 8 Jul 2024 09:33:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Christian Eggers <ceggers@arri.de>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Juergen Beisert <jbe@pengutronix.de>, Stefan Roese
 <sr@denx.de>, Juergen Borleis <kernel@pengutronix.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] dsa: lan9303: consistent naming for PHY address
 parameter
Message-ID: <20240708093316.535b16ab@kernel.org>
In-Reply-To: <20240708121352.gnhhjuvvoxpjhtpv@skbuf>
References: <20240703145718.19951-1-ceggers@arri.de>
	<20240703145718.19951-2-ceggers@arri.de>
	<20240704192034.23304ee8@kernel.org>
	<20240708121352.gnhhjuvvoxpjhtpv@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jul 2024 15:13:52 +0300 Vladimir Oltean wrote:
> On Thu, Jul 04, 2024 at 07:20:34PM -0700, Jakub Kicinski wrote:
> > On Wed, 3 Jul 2024 16:57:18 +0200 Christian Eggers wrote:  
> > > Name it 'addr' instead of 'port' or 'phy'.  
> > 
> > Unfortunately the fix has narrowly missed today's PR.
> > Please resend this for net-next in a week+.  
> 
> How does this work? You're no longer taking 'net' patches through the
> 'net' tree in the last week before the net-next pull request?

The fix has narrowly missed the PR, IOW patch 1 has missed the PR.
Patch 2 is not a fix.

