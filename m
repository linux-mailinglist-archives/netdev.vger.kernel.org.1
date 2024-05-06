Return-Path: <netdev+bounces-93735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2088BD03C
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D6E1C24234
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B1613698F;
	Mon,  6 May 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jk8aJL4C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD47811E7;
	Mon,  6 May 2024 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005607; cv=none; b=Tzb32A48LPVEsxyU+F5ct0OF/TIWP1pugpnGhP9Or/Q5GJo7w+N5iq7lqhr7VJM/BXu+OntSuyiGk0m65MqRegD9CcHf0JeiLVqWWSkc1FCNjDCfULlWPzQNGNJd83S4QniXwTfplUeN+mUtR+7ITDyd8zI6/uNjQofVc79gq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005607; c=relaxed/simple;
	bh=WGXmiojuwyUlrWCas3x3xw7zG7o9mcYX/J2i6endN0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TtiNGnwr6d8r1UAnXonH7Ig/N6vsmZAvBgVN/tQ+PQMfDGn2mgx1bBoDPQk/3myiqCmO6T8mQlYBbvj/PmJ+mQJdi7KUs/+ljMnkSZ+KRXdtAWNacw8FVjD1GlifqKq2Me/V69J+x9MUvjn7Cg8q1lT7IY4FfIVk0cMHCy8/x9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jk8aJL4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C40EC116B1;
	Mon,  6 May 2024 14:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715005606;
	bh=WGXmiojuwyUlrWCas3x3xw7zG7o9mcYX/J2i6endN0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jk8aJL4CP9zQEc/W5zos2YVKbvsteqzrxxPLN3rT/hGU+8kZObwcNizisNpKFp5Yd
	 6iqyKsKElOq1UMpEzXUtxd7wTCdncV9OA231f+kC6sbAbiMARqnw8hAAhcvv4A77p9
	 8QWSgu5TvhlOQUaHeU8samxnMInU/GGFVHH4wM1TQuFcS9i58Sa2un77NO5i/Wk1Ga
	 RIuFBtRkzTl4VkbjhGPavkjz+Fgb0/Y67pjsS0olU6Sg9MPgGC+hmP72S2bJFM5BSC
	 wI4qfv758H/hNlxOFKztEnCQpHHTW4VE1LK9zZWvM+kHAaNHC+0daL1BoYKlXBuUwe
	 TMfVcvl8UKKEw==
Date: Mon, 6 May 2024 07:26:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erhard Furtner <erhard_f@mailbox.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: WARNING: CPU: 1 PID: 1 at net/core/netpoll.c:370
 netpoll_send_skb+0x1fc/0x20c at boot when netconsole is enabled (kernel
 v6.9-rc5, v6.8.7, sungem, PowerMac G4 DP)
Message-ID: <20240506072645.448bc49f@kernel.org>
In-Reply-To: <20240505232713.46c03b30@yea>
References: <20240428125306.2c3080ef@legion>
	<20240429183630.399859e2@kernel.org>
	<20240505232713.46c03b30@yea>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 May 2024 23:27:13 +0200 Erhard Furtner wrote:
> > On Sun, 28 Apr 2024 12:53:06 +0200 Erhard Furtner wrote:  
> > > With netconsole enabled I get this "WARNING: CPU: 1 PID: 1 at
> > > net/core/netpoll.c:370 netpoll_send_skb+0x1fc/0x20c" and "WARNING:
> > > CPU: 1 PID: 1 at kernel/locking/irqflag-debug.c:10
> > > warn_bogus_irq_restore+0x30/0x44" at boot on my PowerMac G4 DP.
> > > Happens more often than not (6-7 out of 10 times booting):    
> > 
> > Could you try with LOCKDEP enabled?
> > I wonder if irqs_disabled() behaves differently than we expect.  
> 
> Ok, after a few tries I got a "BUG: spinlock wrong CPU on CPU#0, swapper/0/1" LOCKDEP hit. But this does not happen every time when I get the netpoll_send WARNING:

Oh, can you try deleting the gem_poll_controller() function?
Unhook it from ndo_poll_controller and remove it completely.

