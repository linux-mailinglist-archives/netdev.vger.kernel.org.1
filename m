Return-Path: <netdev+bounces-131404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C25698E733
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1CF1C23105
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7AA19F101;
	Wed,  2 Oct 2024 23:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkjojiqS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333D119EEB4;
	Wed,  2 Oct 2024 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912505; cv=none; b=eFCriZQ/eRZX2TNxIwSo7fNoBuRuwMMYeQN7mcAv8ZsgsIfpeTzB8M26Lw024H/tHRzNQO1ABcTOSWex4e4Lt05ZUtKvbT0eOuxxvG9QV96w9MrPYYq9MWzKfEORk054ypOsS/+QkoMocuJJDYmXbDARdKiyCJz9viHIcygOpm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912505; c=relaxed/simple;
	bh=ivK1mdK88zEJJKaDyjNSnpq1Euytfizdyl4ZmK0k81U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DadwQ6lYzxFGL9gaouEg25aSpReR9X3ntsEhdzfemnfRFe/lYO57hFg67nlYMv5N0u+CcxSGevoSppPZSxwRTGg4iHMwmvbJPees7nTPykmedU25m3WMbLN1Nsb/wcF2doKErEVfxYA30IuBMYdCE8Fap8lwTcTUj2ERehrfObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkjojiqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D2DC4CEC5;
	Wed,  2 Oct 2024 23:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727912504;
	bh=ivK1mdK88zEJJKaDyjNSnpq1Euytfizdyl4ZmK0k81U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YkjojiqSYAcwPFtkeYAQibAC3ZATq9gVLkkRToGjBC7EsS1iwIX7VzTYGJz13dSFP
	 1Bd4YJwlaiFbfnyKgWnfmRvDmPLiU7Acn62vDbBlNYhHRaER1BnffDM41VYhxjdGAH
	 lnKK8HRzzJa264j7vDvgpHMc2I2O1qKvuVlLR4X3Lq++UWHdek4YmsWw8x94Mg8pO0
	 ZaDWaH2W/tDnqxUsO+3FZ18FifWBx3R0BgIPd/S+p7yhiJhaZ6SsB84sFcIMrjyv4t
	 YeEnFeQ/dmYNRQ2OwSJw8GMzy01GLAqIyGaa5+r5zcmSG4GVU1vMRjkWducPUdpPmp
	 DZLlnwtrjhFTw==
Date: Wed, 2 Oct 2024 16:41:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Conor Dooley <conor@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Okan Tumuklu <okantumukluu@gmail.com>, shuah@kernel.org,
 linux-kernel@vger.kernel.org, krzk@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] Update core.c
Message-ID: <20241002164143.74ba2820@kernel.org>
In-Reply-To: <20241002222145.GJ4017910@ZenIV>
References: <20240930220649.6954-1-okantumukluu@gmail.com>
	<7dcaa550-4c12-4c2e-9ae2-794c87048ea9@linuxfoundation.org>
	<20240930-plant-brim-b8178db46885@spud>
	<20241002062751.1b08e89a@kernel.org>
	<20241002222145.GJ4017910@ZenIV>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 23:21:45 +0100 Al Viro wrote:
> > Quoting documentation:
> > 
> >   Using device-managed and cleanup.h constructs
> >   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   
> >   Netdev remains skeptical about promises of all "auto-cleanup" APIs,
> >   including even ``devm_`` helpers, historically. They are not the preferred
> >   style of implementation, merely an acceptable one.
> >   
> >   Use of ``guard()`` is discouraged within any function longer than 20 lines,
> >   ``scoped_guard()`` is considered more readable. Using normal lock/unlock is
> >   still (weakly) preferred.
> >   
> >   Low level cleanup constructs (such as ``__free()``) can be used when building
> >   APIs and helpers, especially scoped iterators. However, direct use of
> >   ``__free()`` within networking core and drivers is discouraged.
> >   Similar guidance applies to declaring variables mid-function.
> >   
> > See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs  
> 
> Bravo.  Mind if that gets stolen for VFS as well?

Not at all. Slight preference towards not mentioning that you got it
from us, tho, lest we attract unwanted attention :)

