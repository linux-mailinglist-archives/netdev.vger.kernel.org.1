Return-Path: <netdev+bounces-95551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F13DD8C29AD
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 20:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65291F241F9
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2B51D551;
	Fri, 10 May 2024 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljOzX//d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFDE1C6B5
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715364164; cv=none; b=WkgHH7KXSLir+y23ZrN3q7+/jm7S58j4MKWJSwFghWBltnSVURadbDcjlALRAZ8FMsGIeJgxRGAUfah2Hn5yYxmo7IdtbuhLRIIrb7N8QrvxBQeeqgIGLBmc0LKj8cvZxgo7OBlsSqQ8DlVHx1fcQ+h+4ot5tJWID7Lwy49qgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715364164; c=relaxed/simple;
	bh=xm+kiLLS4H6nGh2+/nAmbDeCw1HXdzaw+cZYU08x/UE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaCyb7LomItkwJeOAf8a9DBaOHR9yjLn3Fv8qFbwe67BNnxjfHz5Ig/2QMeSdtQIQC5e+gIGLvW4mX+zq7+8FnOmGGl2DC2P+CqxDFYqd1dIrkcde0dU6tpUXX1yvBx8WXmgYE6+B8PvzOAsQOXG6Y1/sWKyxvltFPIWR8ORv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljOzX//d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21C5C113CC;
	Fri, 10 May 2024 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715364164;
	bh=xm+kiLLS4H6nGh2+/nAmbDeCw1HXdzaw+cZYU08x/UE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ljOzX//d9xJktdse3HW/VxGvJRbQBtHlb2MydejisgmQjER94lGOk8g9lPXTcV3Ww
	 bq/TZke9DiuJcp88zoGyMeCO57slcbwGHmLF8LErCdtfa+bnfX/70RvRl0++Tf/QTb
	 nan/8XqMBTZmluSdLZEnAHbLDEsoLL7fp6RBqj3+AKHVkngosJb3wWTjomYIenH/nD
	 nRU0HsqUlVWd92VXC762AD5RwlGgHRzu8LijYU+U/SkpRF6lPhWWms9TuPn0Y6K702
	 mIWjTt7orkQYcSYqDCHUrxoboQhUzuyp1BL8WWgsPzdJM9jRXVzd6f18Ccwujjvuko
	 vV/ZYlBztEGmw==
Date: Fri, 10 May 2024 11:02:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Simon Horman <horms@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
 Jaehee Park <jhpark1013@gmail.com>, Petr Machata <petrm@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, Davide Caratti <dcaratti@redhat.com>, Matthieu Baerts
 <matttbe@kernel.org>, netdev@vger.kernel.org
Subject: Re: [TEST] Flake report
Message-ID: <20240510110243.08eed391@kernel.org>
In-Reply-To: <20240510164147.GE16079@breakpoint.cc>
References: <20240509160958.2987ef50@kernel.org>
	<20240510083551.GB16079@breakpoint.cc>
	<20240510074716.1bbb8de8@kernel.org>
	<20240510090336.54180074@kernel.org>
	<20240510164147.GE16079@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 18:41:47 +0200 Florian Westphal wrote:
> > What does that mean in lay terms?   
> 
> This nft version chokes on syntax, but I cannot reproduce this:
> src/nft --check -f /dev/stdin <<EOF
> add table t
> add chain t c
> reset rules t c
> EOF
> echo $?
> table ip t {
> 	chain c { }
> }
> 0
> src/nft --version
> nftables v1.0.9 (Old Doc Yak #3)
> 
> No idea :-(
> 
> I tried building both recent nftables.git and v1.0.9 tag and both
> parse the test file for me :-(
> 
> Also. nft-flowtable.sh is still not working on nf infra even
> with the updated version while that script works fine locally for me
> as well, even with running via vng.
> 
> Maybe there is an old libnftables on the system that is used
> instead for parsing?  Its bundled/installed with nftables, can
> you check that ldd nft doesnt show some other distro-installed
> version?  Other than that I have no idea what could be happening here.

Good call! The LD_LIBRARY_PATH was including things in wrong order.
I change that for the next run.

> > Question #2, for the ebtables test - do I need to build iptables?
> > I built nft with
> > 	./configure --with-json --with-xtables   
> 
> You need to add --enable-nftables for ebtables-nft, or you need to
> use the old ebtables tree, i.e.:
> https://git.netfilter.org/ebtables/
> 
> both should work.

Picked the old tree. Let's see..

