Return-Path: <netdev+bounces-94597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D428BFF56
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FF71F29FE6
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2037D075;
	Wed,  8 May 2024 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV9g7Oo6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329E79B9D;
	Wed,  8 May 2024 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176088; cv=none; b=LFztigO5Y96c0z+gqw9Wn0E6WhvCGhX0f6b8+u3vd2uhbiDQW+VXl7fdHGTrwR3OKXFRYpEE+Ux9Xr0XnTkMFh6ZFXnzajLLgoKEZumgRCG1tktIuho+3zBHNOHpe4MkZISCI7F8AUPMCHsz+nILpW2nFRMRyJUnvRglxJwR4XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176088; c=relaxed/simple;
	bh=xgHln/S0N3xK3r9g48jliwLklyosUPHMKzEFivOOsFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fowvA4/OWGfwU85JbxX8SiCUKvdZXyUzUp+qW+t//u0b7v0yRzDXNTcd+0tM5LGjUFwLeL8MzrGj4M0JBDJwvGxJ3mSyuhEqBZGTBEBjAIQcipG+mbEAj+d3+jR0eIrZeucMM6cIubCLdkrpm+q3EBbAc2Ka5YljYgLkF0ZwqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV9g7Oo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59BCC113CC;
	Wed,  8 May 2024 13:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715176088;
	bh=xgHln/S0N3xK3r9g48jliwLklyosUPHMKzEFivOOsFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eV9g7Oo6aO4YBPs5bYhHrXa84k6uIdcZjdL8HHkIG2T0iag+LPv9vxwLxZMKZmRQp
	 TFYUVEMfmpe4sfsA52OayAmHd9ftUj/zYyCXQZ+EtFP4OSeLSOXoJsNhFkcFw4jZ6a
	 TJEgGmhfdwafv0hg9VVkVik3buLHJFnpfrzR62LiwujKAdTEgmaIjAxRmb2xkMUrfo
	 FdxvUdp24w/XgV+KfZRWEmee9ZuwAXAjUCGT+O7kF9WBilofRH7n6tkapwqlq7xf2e
	 +qFLNcA3XlVlovFYwxr9FWjzTdNOKLiGHUsCa+CM/m0bsHVYFFvfYp2FaocBRb53Bx
	 xb5Ye07+8rGGw==
Date: Wed, 8 May 2024 06:48:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erhard Furtner <erhard_f@mailbox.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: WARNING: CPU: 1 PID: 1 at net/core/netpoll.c:370
 netpoll_send_skb+0x1fc/0x20c at boot when netconsole is enabled (kernel
 v6.9-rc5, v6.8.7, sungem, PowerMac G4 DP)
Message-ID: <20240508064806.10b95d29@kernel.org>
In-Reply-To: <20240508105505.098efd6c@yea>
References: <20240428125306.2c3080ef@legion>
	<20240429183630.399859e2@kernel.org>
	<20240505232713.46c03b30@yea>
	<20240506072645.448bc49f@kernel.org>
	<20240507024258.07980f55@yea>
	<20240506181020.292b25f0@kernel.org>
	<20240508105505.098efd6c@yea>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 May 2024 10:55:05 +0200 Erhard Furtner wrote:
> I could do that with the explanation you stated. But should any
> further questions arise in this process I would also lack the
> technical background to deal with them. ;)

Alright, submitted :)

> I also noticed a similar #ifdef CONFIG_NET_POLL_CONTROLLER logic shows up in
> many network drivers, e.g. net/ethernet/realtek/8139too.c:
> 
> #ifdef CONFIG_NET_POLL_CONTROLLER
> static void rtl8139_poll_controller(struct net_device *dev);
> #endif
> [...]
> #ifdef CONFIG_NET_POLL_CONTROLLER
> /*
>  * Polling receive - used by netconsole and other diagnostic tools
>  * to allow network i/o with interrupts disabled.
>  */
> static void rtl8139_poll_controller(struct net_device *dev)
> {
>         struct rtl8139_private *tp = netdev_priv(dev);
>        	const int irq = tp->pci_dev->irq;
> 
>        	disable_irq_nosync(irq);
>        	rtl8139_interrupt(irq, dev);
>        	enable_irq(irq);
> }
> #endif
> [...]
> #ifdef CONFIG_NET_POLL_CONTROLLER
>        	.ndo_poll_controller    = rtl8139_poll_controller,
> #endif
> 
> 
> Should it be removed here too? This would be more cards I can test.
> So far I only see this on my G4 and I think something similar on an
> old Pentium4 box I no longer have. 

That one looks legit. Note the _nosync() which solves the immediate
IRQ masking / deadlock issue. And the rtl8139_interrupt() function
actually does the packet cleanup in case of 8139too.

