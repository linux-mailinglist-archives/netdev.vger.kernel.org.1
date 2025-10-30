Return-Path: <netdev+bounces-234459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CC4C20E17
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 16:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D954A1A225F3
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D070032A3F2;
	Thu, 30 Oct 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD6iLxC5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3522222B2
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837264; cv=none; b=Ru6djmy+eXG/+fFumhPWiUxALFYHgY33Mx4K525JJ0Q/TmQ89EjtPRj9AhgdcAsdkXYHyRlhxzzTXWjpg3CeZ0/lJV0B6HhUbJrjMkItbnsYRPHkNIxEN2C5Fl97Jyce2ksKVOnNqNi/KwLa3kV7ymmx1yWdSrwU7jIP4Njiwy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837264; c=relaxed/simple;
	bh=psWbWhUPwX1ZHJCxk5AblVP7r5p/NFWJtCoe0iurEQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3tPObotaC3bU0UkUFoppVenRLX/Ae/OnroTqdgNr77OUUUe5foBZjzPRZ2oPcnKj9P93lsu6vEy1vnOqvx/S3igdWyC04cT9UiOG+u0AjGNdDCH5FuiNjd5OvIHXZfUyhNThLwsEo9R0LOt1uVc1j1h9idhA24tKVSxkLOBlWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD6iLxC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED56FC4CEF1;
	Thu, 30 Oct 2025 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761837264;
	bh=psWbWhUPwX1ZHJCxk5AblVP7r5p/NFWJtCoe0iurEQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kD6iLxC5675z+FY+zI8txsfMA268s/zV9OKCDi1RrLJdM6oeLav/MZuZeOhwMSfTu
	 zaEt2s75otS2kfqwtJGTh8gFin5vVUKaIXDyzduxzaLWB+JI8lD6r/ibz55YsaWD57
	 3t7/t0G1I2P1+7SbHRFBr6/mXZwRIG9ymeUa29P5EUdi43L4ybsgsC1hh+6P2Q7xC2
	 bPwoAIQguiJdaLCrNl9NRUCfhvnxp48wJDAj4GCcuHoXyxNi2ehAfDrt5wu4FHEauG
	 tpJDdljRNn5ZylSt177w8t7+FxyttC9TI0zjnGLOhjt77MHGs9pk0S4aJphT7i9403
	 J7bHUF7Jzpv0g==
Date: Thu, 30 Oct 2025 08:14:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Michal Kubecek
 <mkubecek@suse.cz>, netdev@vger.kernel.org
Subject: Re: [PATCH ethtool-next] netlink: tsconfig: add HW time stamping
 configuration
Message-ID: <20251030081423.2bb43db6@kernel.org>
In-Reply-To: <20251030153723.7448a18e@kmaincent-XPS-13-7390>
References: <20251004202715.9238-1-vadim.fedorenko@linux.dev>
	<5w25bm7gnbrq4cwtefmunmcylqav524roamuvoz2zv5piadpek@4vpzw533uuyd>
	<ef2ea988-bbfb-469e-b833-dbe8f5ddc5b7@linux.dev>
	<zsoujuddzajo3qbrvde6rnzeq6ic5x7jofz3voab7dmtzh3zpw@h3bxd54btzic>
	<8693b213-2d22-4e47-99bb-5d8ca4f48dd5@linux.dev>
	<20251029153812.10bd6397@kernel.org>
	<20251030153723.7448a18e@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 15:37:23 +0100 Kory Maincent wrote:
> Jakub, as it is already in uAPI but not used at all, would it be possible to
> change it or is it already too late?

We'd need a very strong reason to consider changing it now.

