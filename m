Return-Path: <netdev+bounces-73516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CBA85CDBE
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70A91C22D2C
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108E046BF;
	Wed, 21 Feb 2024 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7MbC4g/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C5522C
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708481406; cv=none; b=r6K7G/2YOKojDkWDDDYtduD2gDq/8shK8jIuBWFibGpfI5zr9wAY665UoFvLphWTUOodyrABX+ASBFHj+fxrPO/1cODnDYeR//QNghKngerjfM/2dVhfEYgo+zMiA8BJWmBkf6pUDTUV2uP2lvIouxBlVtJH3qJnA02VMee3K9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708481406; c=relaxed/simple;
	bh=uaRInFWMemD0iWHq4Tvjf5vub0MNKpgJp9isd2knTow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6L+CZDwGlm+Gw07M2vu77y9G+1jRBePpcgC/U/z7DoHEUucayxhdCv7qGRCog5hFW7Jz2Woo4U9A7hvjZDY573V5sjhZ6JTaeIvAdHuIk9VHFTXcvZxD0hbLDCyBvCKY/v/1McP9V4EuFLZmvvKtFJUO/YMtGh4pPhW92CREbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7MbC4g/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2140C433C7;
	Wed, 21 Feb 2024 02:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708481405;
	bh=uaRInFWMemD0iWHq4Tvjf5vub0MNKpgJp9isd2knTow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y7MbC4g/rDMlv7gCbNx2orRMhZuOrKfvAR2fY90u+mb8RVY3yMyh1bvcTXgGnGiiG
	 EvFkiWVS0TVV/EDDm40QRb/N851PXIQ7YltsJdfoAFS31mf+KL19swu+CsK9mgExPb
	 R4O+v8bWfk+BE99U2I974gZslG1fRwULqHi+LmnO5BsZwrlYxbnGAn7dgxrSFXZ7dV
	 8PcdWb/BXEecFywUDSi6vY5FmHmSTlk43ILd/ZSG/hzHyzsSCpp51ojvSqscSibyFX
	 dp/7SUeTGvHq4b9avpROBed/t4z6VqWdni19YDDN3uP0FNWs8kV4JLWS+ybHw5sESO
	 PP/sR33Kghmgw==
Date: Tue, 20 Feb 2024 18:10:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com,
 swarupkotikalapudi@gmail.com, donald.hunter@gmail.com, sdf@google.com,
 lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 06/13] tools: ynl: introduce attribute-replace
 for sub-message
Message-ID: <20240220181004.639af931@kernel.org>
In-Reply-To: <ZdRVS6mHLBQVwSMN@nanopsycho>
References: <20240219172525.71406-1-jiri@resnulli.us>
	<20240219172525.71406-7-jiri@resnulli.us>
	<20240219145204.48298295@kernel.org>
	<ZdRVS6mHLBQVwSMN@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 08:31:23 +0100 Jiri Pirko wrote:
> >The "type agnostic" / generic style of devlink params and fmsg
> >are contrary to YNL's direction and goals. YNL abstracts parsing  
> 
> True, but that's what we have. Similar to what we have in TC where
> sub-messages are present, that is also against ynl's direction and
> goals.

But TC and ip-link are raw netlink, meaning genetlink-legacy remains
fairly straightforward. BTW since we currently have full parity in C
code gen adding this series will break build for tools/net/ynl.

Plus ip-link is a really high value target. I had been pondering how 
to solve it myself. There's probably a hundred different implementations
out there of container management systems which spawn veths using odd
hacks because "netlink is scary". Once I find the time to finish
rtnetlink codegen we can replace all  the unholy libbpf netlink hacks
with ynl, too.

So at this stage I'd really like to focus YNL on language coverage
(adding more codegens), packaging and usability polish, not extending
the spec definitions to cover not-so-often used corner cases.
Especially those which will barely benefit because they are in
themselves built to be an abstraction.

