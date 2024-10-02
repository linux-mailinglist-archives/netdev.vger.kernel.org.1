Return-Path: <netdev+bounces-131385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873F498E60C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B72C1F2352E
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 22:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B06197A6A;
	Wed,  2 Oct 2024 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mKLw/M3b"
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC128F40;
	Wed,  2 Oct 2024 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907709; cv=none; b=crXJ8aKY2KcnnuFvVtsAFyjQTtdONY7t3LcqGH3NKJAx5ed+V/UEdAz88QOQ41yWZkOxd9mox2Tu5dCyaq0SYSXiFT0hpQ5+eQ1Z3fVcwGbC0UjxM/V8sXdUPbtUoev3oBn2HCM87KnNJQqdmOuWvCeOYiN73Ujne9oq/+Yqhi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907709; c=relaxed/simple;
	bh=3xkNFjhndBi2NJr/wIHDe9ubnQq7Xme0ApXZtBGzZVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2AA/696i/gpAYvdtWo5qDowub9eV+2nddnOqjCuspaF0KTWR8OkeBO/R5kkRRiys6KNSSbYLzb/RyAmT6krAe+eyt1Ols0YHXH54mKvYA9x+/en4HCPwdeXB99NkKb/lr7lVHoVDpiHQZGP3s93lpD41R8DWllywjUOMtko1dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mKLw/M3b; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w39QCXOp2vubXByXi/wud83PQEHzA1OMaM5tEOzwOzs=; b=mKLw/M3bChotovbK5XaoXI/+/K
	44TOcGNgvReTggRpY7Wd/R1aydL25Zla+eF61O0yF1zw/e4+VvjifJ7xpj6t1y94d3KznyPQKvZIU
	t8+uj22L3Vpb81ad6s73ezOeFFd5i6crPP2CEKMh2dFffDPlAlMXDVQxi6D9Bf3x5fJK2JpmgfByY
	YhgCBFx5eJ2WrTL3z4o/ZfjOf+0AND2iFCbObrQUduDAZfHw44IAPCgXTLs0WgRNICO9X7O3g3SuS
	jijhz4HS/vns08DCbhHBqJoX9HoAChE3pIG0/ffVASYfKhDItjXVE2X6rLiJOth/knWegyfsaKx+e
	/7wR+yeQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sw7j7-00000000KY9-3wxg;
	Wed, 02 Oct 2024 22:21:45 +0000
Date: Wed, 2 Oct 2024 23:21:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
	Okan Tumuklu <okantumukluu@gmail.com>, shuah@kernel.org,
	linux-kernel@vger.kernel.org, krzk@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] Update core.c
Message-ID: <20241002222145.GJ4017910@ZenIV>
References: <20240930220649.6954-1-okantumukluu@gmail.com>
 <7dcaa550-4c12-4c2e-9ae2-794c87048ea9@linuxfoundation.org>
 <20240930-plant-brim-b8178db46885@spud>
 <20241002062751.1b08e89a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002062751.1b08e89a@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Oct 02, 2024 at 06:27:51AM -0700, Jakub Kicinski wrote:
> On Mon, 30 Sep 2024 23:20:45 +0100 Conor Dooley wrote:
> > (do netdev folks even want scoped cleanup?),
> 
> Since I have it handy... :)
> 
> Quoting documentation:
> 
>   Using device-managed and cleanup.h constructs
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
>   Netdev remains skeptical about promises of all "auto-cleanup" APIs,
>   including even ``devm_`` helpers, historically. They are not the preferred
>   style of implementation, merely an acceptable one.
>   
>   Use of ``guard()`` is discouraged within any function longer than 20 lines,
>   ``scoped_guard()`` is considered more readable. Using normal lock/unlock is
>   still (weakly) preferred.
>   
>   Low level cleanup constructs (such as ``__free()``) can be used when building
>   APIs and helpers, especially scoped iterators. However, direct use of
>   ``__free()`` within networking core and drivers is discouraged.
>   Similar guidance applies to declaring variables mid-function.
>   
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

Bravo.  Mind if that gets stolen for VFS as well?

