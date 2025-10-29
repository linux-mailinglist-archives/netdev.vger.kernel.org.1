Return-Path: <netdev+bounces-234177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32045C1D98D
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 23:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D375E3A35CE
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 22:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBCD29E0E7;
	Wed, 29 Oct 2025 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfVh3pyY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB7421D5B0
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761777494; cv=none; b=QjSgLw/L8jgZ/EoR8sJnOQ5iT83c6eQhUJfJNUNg6dbxZLfw6CWTsW2Mi+Hb2pcijuM1FptOJzd4rJJLy0TiHSS2ecebcMnA2pImd+eHV88O/lpayK0AAAdXBd6GHu6g4pS4KZ/anIXgRmMYYssO1GzZi1qHDp4Z2bjMf6SOIo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761777494; c=relaxed/simple;
	bh=BVskhov3Xg8BYfhlY7/y2ipqSmtxG6yGEuH9tMUeDtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GyPBieFxHDFmjgU3ArMxd7YXcblWsH2C54mu40Iq9uY/7LU/ps/T+v28KIgXICDo9GLNthjnzx4qvW8+Spco4FaEy4KBZejZiOsDhCOFo83QFYaLj+vFZS7ZucgrDtIBrmBCyCx0wm/HXKMMJb1yGyQDfLHh0Sbq3jvnwkx96Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfVh3pyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAB4C4CEF7;
	Wed, 29 Oct 2025 22:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761777493;
	bh=BVskhov3Xg8BYfhlY7/y2ipqSmtxG6yGEuH9tMUeDtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qfVh3pyYvwWRZb001lqs6biHuaDkOjAI69YU/OmcEfNitws5PNDLhGC4RnEGdrLCQ
	 tmVJZeFhBJvIfYRrAndGACnDeTeJo0+5NBpWOpUNEzQRrKiAdfIfqlkH5SSrvLQqYb
	 aPMLD8pJoet3kiLP3z1Y0UtyBNXaPGeKob5AJnuvUhck+nCeml09LYOaJ9dTe82D+m
	 aHUX5zjTamltNtYjQPe0eyexMGYjYo+w90BWu793V00vcdi8CDtSs+jqwpTXiM5UMB
	 69lFnJkqzNKad+ARn14iwS738ZSmW8xRrXuLKcx6+L3uXjLNDMgJRWSgRzgGOV+X/1
	 9wpKFouZFBOPA==
Date: Wed, 29 Oct 2025 15:38:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org, Kory Maincent
 <kory.maincent@bootlin.com>
Subject: Re: [PATCH ethtool-next] netlink: tsconfig: add HW time stamping
 configuration
Message-ID: <20251029153812.10bd6397@kernel.org>
In-Reply-To: <8693b213-2d22-4e47-99bb-5d8ca4f48dd5@linux.dev>
References: <20251004202715.9238-1-vadim.fedorenko@linux.dev>
	<5w25bm7gnbrq4cwtefmunmcylqav524roamuvoz2zv5piadpek@4vpzw533uuyd>
	<ef2ea988-bbfb-469e-b833-dbe8f5ddc5b7@linux.dev>
	<zsoujuddzajo3qbrvde6rnzeq6ic5x7jofz3voab7dmtzh3zpw@h3bxd54btzic>
	<8693b213-2d22-4e47-99bb-5d8ca4f48dd5@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 18:53:20 +0000 Vadim Fedorenko wrote:
> >> Well, yes, it's only 1 bit is supposed to be set. Unfortunately, netlink
> >> interface was added this way almost a year ago, we cannot change it
> >> anymore without breaking user-space API.  
> > 
> > The netlink interface only mirrors what we already had in struct
> > ethtool_ts_info (i.e. the ioctl interface). Therefore my question was
> > not really about this part of kernel API (which is fixed already) but
> > rather about the ethtool command line syntax.
> > 
> > In other words, what I really want to ask is: Can we be absolutely sure
> > that it can never possibly happen in the future that we might need to
> > set more than one bit in a set message?
> > 
> > If the answer is positive, I'm OK with the patch but perhaps we should
> > document it explicitly in the TSCONFIG_SET description in kernel file
> > Documentation/networking/ethtool-netlink.rst  
> 
> Well, I cannot say about long-long future, but for the last decade we
> haven't had a need for multiple bits to be set up. I would assume that
> the reality will be around the same.
> 
> Jakub/Kory do you have thoughts?

hard to prove a negative, is the question leading to a different
argument format which will let us set multiple bits? Looks like
we could potentially allow specifying tx / rx-filter multiple
times? Or invent new keywords for the extra bits which presumably 
would be somehow orthogonal to filtering?

tl;dr I'm unclear on the exact concern..

