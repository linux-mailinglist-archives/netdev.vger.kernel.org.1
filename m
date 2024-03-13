Return-Path: <netdev+bounces-79700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA65F87AA6B
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 16:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDB11C21592
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0773F8C7;
	Wed, 13 Mar 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+vu4nEX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C145978
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343872; cv=none; b=T387rS6FUduLqd8QxYJcD2Mbtum0aM5gVe14oQLkXTaIFvS4QuvsDOr78B1QhJwAunNCJzzgJJLvFPJDY7wLpF9KNn6fl4+tQbJTxJLSSHkTiUjr+UwJpABR42lqVOHsmJWt/zASd8VRuPLaY7zU9UWvjX+Ve5mDmJWjYx/XmFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343872; c=relaxed/simple;
	bh=GCDDZL4RSOwLqhzKGuj2sPZuyhUfO+FSbpErQ7LKahE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/RCmVGhFVmTqr+JnK4u6g+2htMF1fxddC/S6zD86tglU7FMiCkxSunOQFgG2QXNJe+sc4dwwaUy7zVdJ4+ZxYAccgASscZi7MXZsnf3cqEPVVMUiy4geENo8KfnELiIJODJUP1aIsAWNTCg9nTK/u+KpbMBM4xrienePEP+zFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+vu4nEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6BDC433F1;
	Wed, 13 Mar 2024 15:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710343872;
	bh=GCDDZL4RSOwLqhzKGuj2sPZuyhUfO+FSbpErQ7LKahE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I+vu4nEXdQsVka920jGIomzVIM8NwXGJSnBr2Zqvp0+OxSgK766NU/WbjVE1C1cqz
	 xukC6AurosY+80dCdsaP0cB1Si7PkhNYw6bTcaUE/wYDBYd1ebNX5mGgtSb6vQrb8I
	 y4lApu3y6Isbuxhr/6JPFS8h/sRsShZJQXYVNbhqPYv+zVuPCrVupf7fr/JX7wtUob
	 n2n0TTiP2xeGWNKakJPOalBxBfKmV9kIhdwMoa7bbbHmHZHwkIFH2jsEqAIe3B+DXN
	 xCw4KnCmENHTx3WKoOdIxbfs4ex2YUXhn5gHAob310FU+AOHvkXYmhreGlJPFMtNEe
	 8D7fpkqaaVuYQ==
Date: Wed, 13 Mar 2024 08:31:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, arkadiusz.kubalewski@intel.com,
 vadim.fedorenko@linux.dev
Subject: Re: [patch net-next] dpll: spec: use proper enum for pin
 capabilities attribute
Message-ID: <20240313083111.4591590d@kernel.org>
In-Reply-To: <ZfG_C6wi4EeBj9l3@nanopsycho>
References: <20240306120739.1447621-1-jiri@resnulli.us>
	<ZeiK7gDRUZYA8378@nanopsycho>
	<20240306073419.4557bd37@kernel.org>
	<20240313072608.1dc45382@kernel.org>
	<ZfG_C6wi4EeBj9l3@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 15:58:19 +0100 Jiri Pirko wrote:
> >> I think I have his private email, let me follow up off list and either
> >> put his @intel.com address in the mailmap or the ignore list.  
> >
> >Hi Jiri! Do you still want to add him to the ignore list?  
> 
> If we are going to start to use .get_maintainer.ignore for this purpose,
> yes please. Should I send the patch? net-next is closed anyway...

With the current tooling I think it's the best we can do.
If someone disagrees let them shout at us.
And we'll shout back that LF should take care of creating
appropriate tooling.
But shouting seems unlikely, I sent a patch to add Jeff K 
and nobody batted an eyelid so far.

Send it for net, it's like a MAINTAINERS update.

