Return-Path: <netdev+bounces-65531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D18B683AEF2
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE67B213BD
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3037E57F;
	Wed, 24 Jan 2024 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCPbRu7h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D297C099;
	Wed, 24 Jan 2024 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115561; cv=none; b=PUPyKlKcfL7wxL877BA9qp0tP9lsfiBXQ4Q1857YlOKnkyow5Wvr3bKvlquvh/tEhVtxG+EptaQHBwu+aihS2Ds3V9xfOmFrKBYwPn4rLxrIfTbEhbEqGlNudu0C/x8ljju5yv/76HJjqC3Ff92AB0QZdpgyayS6dwrsCf5vRCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115561; c=relaxed/simple;
	bh=byt1HPkup/k26pW6jGcKn/6P5peTR5D28548JftCIIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DuCgfPXYmdm0pzEjoUTOEbwsL36wnQaQpnQ/+lSlbMbHdX65W78grxpnivwu5bAbpTnTp9rcbRkNzjEWCPbQsZ31jQWuni3QVryX0lwoRNbWsrFq82JFDx+7TK0qGKXe88VIyUdC1jhU750rGRBTiE6Cx6WGohZxb7L1XHaXGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCPbRu7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E483C43390;
	Wed, 24 Jan 2024 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115560;
	bh=byt1HPkup/k26pW6jGcKn/6P5peTR5D28548JftCIIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hCPbRu7hdOW21F7bZ37sSoNu20HoenfLzW6hNVJjL1fF9oPvyEaEdhBi8AXwnknPx
	 P08n6mlajN+GKfejCBanw7xR0eiNU1Gv1uRvOBS+CMQBS3lezAemLJdxPpj9M7v0oW
	 3EPn1NDwRvfYyVydjHXNlZHvjcJ/vaIYMhe+5UBYoaFc7W9sOUdVdPwpCGhheNEYCv
	 rSAKBGHTKdOdHVeQ7VyPz9TgVHkw8Su/L13Lt6h4WdXu0fQgozbru1aPSnuFOrsfZI
	 lpXltt/ZnYzSJOJyPe027inaxUk+k1bexfUjWS6YWCdC2L4Wztdf4HO6lxxexxDwar
	 Hl2IwX1kB2wiA==
Date: Wed, 24 Jan 2024 08:59:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <20240124085919.316a48f9@kernel.org>
In-Reply-To: <aae9edba-e354-44fe-938b-57f5a9dd2718@kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org>
	<Za98C_rCH8iO_yaK@Laptop-X1>
	<20240123072010.7be8fb83@kernel.org>
	<d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
	<20240123133925.4b8babdc@kernel.org>
	<256ae085-bf8f-419b-bcea-8cdce1b64dce@kernel.org>
	<7ae6317ee2797c659e2f14b336554a9e5694858e.camel@redhat.com>
	<20240124070755.1c8ef2a4@kernel.org>
	<20240124081919.4c79a07e@kernel.org>
	<aae9edba-e354-44fe-938b-57f5a9dd2718@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 09:35:09 -0700 David Ahern wrote:
> > This is the latest run:
> > 
> > https://netdev-2.bots.linux.dev/vmksft-net-mp/results/435141/1-fcnal-test-sh/stdout
> > 
> > the nettest warning is indeed gone, but the failures are the same:  
> 
> yep, I will send a formal patch. I see the timeout is high enough, so
> good there.

Well, kinda, to be honest I did bump the time to 4000s locally.
The runtime of the entire net suite 1h 10min - that's pretty much
the runtime of this one test :) The VMs run the tests without
HW virtualization, so they are a bit slower, but it'd be nice
if no local hacks were necessary. 

I haven't sent a patch to bump it because it may make more sense
to split the test into multiple. But as a stop gap we can as well
bump the timeout.

> > $ grep FAIL stdout 
> > # TEST: ping local, VRF bind - VRF IP                 [FAIL]
> > # TEST: ping local, device bind - ns-A IP             [FAIL]
> > # TEST: ping local, VRF bind - VRF IP                 [FAIL]
> > # TEST: ping local, device bind - ns-A IP             [FAIL]
> > 
> > :(  
> 
> known problems. I can disable the tests for now so we avoid regressions,
> and add to the TO-DO list for someone with time.

Sounds good!

