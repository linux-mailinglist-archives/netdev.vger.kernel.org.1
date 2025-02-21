Return-Path: <netdev+bounces-168684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED562A402A0
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 23:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A2A16507A
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 22:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F7F2045B2;
	Fri, 21 Feb 2025 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD8l3Hfp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37FD18DB0B
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 22:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176812; cv=none; b=pyqfhVIMZbev78F0S2d/5z1yeGgUmZ1LwfBDTC+DEuLYfGLJfkjD1q0OeQsgvyEM6GKAHOLimYyag8Sajyn9ebUvDUIlrZVzAg/7PWMSatt0o55/XRr92sDjtnb+06wSs+OeV0Jrg7qecyGWXDicAI4m6femEttZwAwZLAbfY6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176812; c=relaxed/simple;
	bh=JYIZp6oz2BlHDzWW7UOSolxuRxr9OKOgkF/GatOg+lY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVQVjnAIbhLINwNz1BQfHSo4T9m0hVb+wAiE9qBsMii2A4ya4DdVgXtLmczlCMm0RXQZWo49Fppgbj4K2XEK15dpuUAovSRczCUDdjzUpzheHzs4vddNzvw20Fg0qSo0gMzL35UFv1U3TBLMHY1IITdfZFGdDw9CgfqVFgqnloQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD8l3Hfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06344C4CED6;
	Fri, 21 Feb 2025 22:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740176811;
	bh=JYIZp6oz2BlHDzWW7UOSolxuRxr9OKOgkF/GatOg+lY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OD8l3Hfp+bk5GlWSCORfoSR6mRo+OZgM44R3ssUK9650oUXRETvnC+EnhZhEc61mJ
	 61HQBVApFeiw2YfiptVIAlmopa0lWls5Co7c+OhX6URkkMkvuZvb8vISps6tWRHoue
	 7kBcp65zDc/MaDS5V+RbIsyhcbdecYt99lqXcLAS2k6Q+TTaT033ziQihS3T6f6tp+
	 +BmwEaRpai/QAPjeDYQFf2UkytyIhxZL8fx3ju7Pzg4ei3tBHuxuegyG5y29fdDynX
	 LL9BdjTsnm9hkK3PRtU7u63yZsSeFQFV/1NoDiO/yX6W5mgFy/7a078Smh9rG2Tb/y
	 4FbpzWkM7xQgA==
Date: Fri, 21 Feb 2025 14:26:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Gerhard Engleder <gerhard@engleder-embedded.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 0/4] igb: XDP/ZC follow up
Message-ID: <20250221142650.3c74dcac@kernel.org>
In-Reply-To: <Z7jnxolsaLICS6zD@LQ3V64L9R2>
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
	<Z7T5G9ZQRBb4EtdG@LQ3V64L9R2>
	<878qq22xk3.fsf@kurt.kurt.home>
	<20250219180651.0ea6f33d@kernel.org>
	<Z7jnxolsaLICS6zD@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 15:53:26 -0500 Joe Damato wrote:
> > No strong preference. If rtnl_lock is not causing any issues 
> > in this driver, the we can merge as is. I haven't followed 
> > the past discussions, tho.  
> 
> Don't mean to side-track this thread, but does this mean you've
> changed your mind on the previous virtio_net thread [1] ?
> 
> Or maybe I'm just misreading your response there? And instead I
> could re-spin the virtio_net but dropping the first patch and
> dealing with RTNL in the code like this series is doing?
> 
> For some reason I was under the impression that the virtio_net
> series and others like it (like this igb series) were being held
> back until locking work Stanislav is doing is done.
> 
> [1]: https://lore.kernel.org/netdev/20250127133756.413efb24@kernel.org/

Yes, you can probably respin v1. Let's not block this.

