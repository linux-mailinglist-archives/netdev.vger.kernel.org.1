Return-Path: <netdev+bounces-13474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CCB73BBC0
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DCA71C2126D
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE66AC2DB;
	Fri, 23 Jun 2023 15:34:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B4C2CB
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36D6C433C8;
	Fri, 23 Jun 2023 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687534484;
	bh=5F/1bOj9rfDgivkCjgiGDm4pRQrUOqnlQhxZnmM/tEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cg49VDk6Q/0V8Ky7B5OSjJut4pWQJc2k/BYq4Trm7CFPZl2+XUik/NuJd2+y1xPmy
	 tFN/toiOo/Fz48wFP6zXHx0zKPYsfK9k4Sl8NQdXSPwMiNiobVR8+ZTxRRJk5qbYgI
	 wqByPPhj5JQWpFcdzAG/PeBJjtxUyDO9jPVkvRIPinILjnSRFKSeplHDF5CcQhpVw0
	 Oyn3VJ8xQDUiKXVK3vSMOYqGtFx3jGwadzHO7yjmY6Rd5ZMcGsh9NyekbSSX29Qu7s
	 PoEkWZd/smvNPEBemEpWsHMdIkQOBu1tN7dsHxUizSvA7aDGSkO2B0x96NB3uhcp86
	 /Rs5PIFczsJag==
Date: Fri, 23 Jun 2023 08:34:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Pavel Machek <pavel@ucw.cz>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: dsa: qca8k: add support for additional
 modes for netdev trigger
Message-ID: <20230623083442.02b17d69@kernel.org>
In-Reply-To: <64956c02.5d0a0220.ed611.6b79@mx.google.com>
References: <20230621095409.25859-1-ansuelsmth@gmail.com>
	<20230622193120.5cc09fc3@kernel.org>
	<64956c02.5d0a0220.ed611.6b79@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jun 2023 05:10:47 +0200 Christian Marangi wrote:
> > Something may be funny with the date on your system, FWIW, because your
> > patches seem to arrive almost a day in the past.  
> 
> Lovely WSL istance (Windows Subsystem for Linux) that goes out of sync with
> the host machine sometimes. Does the time cause any problem? I will
> check that in the future before sending patches...

Unfortunately for some reason patchwork orders patches by send time,
not by the time the patches arrived, and we use a time-bound query to
fetch new patches. So if the date is too far back the patches won't get
fetched for the build tester.

