Return-Path: <netdev+bounces-73057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C1B85ABE1
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5090A283943
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31D8524BC;
	Mon, 19 Feb 2024 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t76fdkos"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797BC524AC
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708370243; cv=none; b=pCacu3Dk2CoZPKb11w/UMzlGO+R04vfMHzsVyhfB3vSKX0m9/NU0gh7zwWDgKoST4E/9Xa5B4ZHlHpBbr/azU4qBf7R4gddCf7PKOmoKURn+ANOegViZAb+x9m1tabsSgSj9oRNDQIeJJUyRhwL5/VoQ69JZvaGYV/avtytqHlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708370243; c=relaxed/simple;
	bh=00Kaq7+pxVhLHXNmy32DDKOmEo30LUCzCvdQZ7m79dA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JkzXa2h3zCYzWSo/x6AuzQOSvJi6/iss/DRt1o8BuvccnrC6VmbvESB+0EQABiJMH5WgBX4cO/5g5UzvvbYGobEnHq5eX10ntW4z24SiExafjPx1iZrIdOhMChq1kvJqA1RVumwePwz+oqU+P1ibyBBVGunZEzHzDh5pZvQUXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t76fdkos; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99B5C433F1;
	Mon, 19 Feb 2024 19:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708370243;
	bh=00Kaq7+pxVhLHXNmy32DDKOmEo30LUCzCvdQZ7m79dA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t76fdkosZNZbgm+/g4AIBowzkeR3gY4BDsX8xdrANXrSp5PmXbLLzAd1ZEihB7ReY
	 qLLw8XkuVgAuS/gGtW38+ZNlD5ih8JM7MFdoEPA3cZBsKrh4R7D1OtFy0AgVLotOgy
	 fv7YGqa+ezJqhTZ4RZD6la2XoEvD7BZYPZf3rSGrh6hWMBWSGDv/c5SL8i6d3lPOnG
	 OsQ9hU505TjWeOOU/yGzPo1iFYSauAluqkW7uCElKNfonk2c1GrfUdC7FWO9j9jNiJ
	 u2Xfed2iOghRE/vbYmVp/EVg3X8Fg6twhvk5T62Gn2gGqzriLJgcFpT1yUpo/wPu6t
	 NbQpE2Y5gtqVg==
Date: Mon, 19 Feb 2024 11:17:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [TEST] gre_multipath_nh_res takes forever
Message-ID: <20240219111721.2f97be53@kernel.org>
In-Reply-To: <ZdOG8oxNu5gOImDd@shredder>
References: <20240215095005.7d680faa@kernel.org>
	<ZdOG8oxNu5gOImDd@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 18:50:58 +0200 Ido Schimmel wrote:
> > I bumped the timeouts for forwarding tests with kernel debug enabled
> > yesterday, and gre_multipath_nh_res still doesn't finish even tho it
> > runs for close to 3 hours. On a non-debug kernel it takes around 30min.
> > 
> > You probably have a better idea how to address this than me, but it
> > seems to time out on the IPv6 tests - I wonder if using mausezahn 
> > instead of ping for IPv6 would help a bit?  
> 
> Converted from ping6 to mausezahn, but the test was still relatively
> slow because of the 1msec delay we pass the mausezahn. After converting
> to mausezahn and removing the delay the runtime dropped from ~350
> seconds to ~15 seconds on my system.

Great!

> I think I will parametrize the delay for platforms that might need it,
> but default it to 0 as it's not needed with veth. The same change is
> needed in other tests. Will submit it together with Petr's selftest
> changes.

SG, thanks!

