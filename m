Return-Path: <netdev+bounces-178023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E33A7406E
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B15F3A9525
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 21:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A6B1CCB21;
	Thu, 27 Mar 2025 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFiARGf+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE016A956
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743112246; cv=none; b=XTs9z0H3O6PPgfiyG236ic4UjoehQqC9QQFTDtMMbx5OiscBXk2WMG3zBCGPm3VE/FWnHUyrmhGUzBFmcOmRJfh/jdWUgDuNtdK1sAT3xg/I3Yl6NxlNGqUHWiax5XjFDwCAe5XJYGCLyeB8e6zt4igpk7vR71dnl7UBKinb4tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743112246; c=relaxed/simple;
	bh=tTqhZMtYfEoJp5oPDVSQi+o/kESuLDQ0pjfjGGSq9fw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGonjPxypPlSuoCgV/yldCGiTW8FLmoulqpQwANvEF7m8JLM8woJAU8KvQtNk8wEAcocJUP6d1WCCGMsgXWVgpvos8tOni7st2EowfO9lHY2HYMwi3raKXxNElxkBaA70PHKO4zaeMaHqNJWZ/zzIf1Pwn01i8tcqtCoR1ATZz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFiARGf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158E5C4CEDD;
	Thu, 27 Mar 2025 21:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743112244;
	bh=tTqhZMtYfEoJp5oPDVSQi+o/kESuLDQ0pjfjGGSq9fw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YFiARGf+dW1oeCNr+9NU9m+rMRzl0DG7R2Olmq0vfM0wyhkcuE0UVAfl+p2+OnUPp
	 aI3eprLgepTzrY+ms6V7SZArlR6mWJjVBKub1sg5gu3oNtr2jSR5X448DEEFZEX56W
	 HgNFS0yCkIRtqyQ7mpwKd8LOqT5SA+U97jGgRq87xDxDMoy86bQ0vQ87z579jKopbB
	 6uqEVrWN+nvVbBVwvPDS29h8A7R7AsRmyP5yliRVGf0V75fDOFLjOpNiyTftzaP1P2
	 RLA02anP261BWOVKQoh49ineGm510Qy/sUD6fgVErAJeqezclIF9WREqIRW2YJ5t6z
	 GXBuM6BOHwDYA==
Date: Thu, 27 Mar 2025 14:50:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net v2 08/11] docs: net: document netdev notifier
 expectations
Message-ID: <20250327145043.0d852f86@kernel.org>
In-Reply-To: <Z-W7nfFdv8u-SZTY@mini-arch>
References: <20250327135659.2057487-1-sdf@fomichev.me>
	<20250327135659.2057487-9-sdf@fomichev.me>
	<20250327121613.4d4f36ea@kernel.org>
	<20250327123403.6147088d@kernel.org>
	<Z-W7nfFdv8u-SZTY@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 13:57:01 -0700 Stanislav Fomichev wrote:
> That sounds very sensible, let me try it out and run the tests.
> I'll have to drop the lock twice, once for NETDEV_UNREGISTER
> and another time for move_netdevice_notifiers_dev_net, but since
> the device is unlisted, nothing should touch it (in theory)?

Yup, and/or we can adjust if we find a reason to, I don't think 
the ordering of the actions in netns changes is precisely intentional.

> netif_change_net_namespace is already the first thing that happens
> in do_setlink, so I won't be converting it to dev_xxx (lmk if I
> miss something here).

I thought you could move it outside the lock in do_setlink() 
and have [netif -> dev]_change_net_namespace take the lock.
Dropping and taking the lock in a callee is a bit bad, so
I'd prefer if the netif_ / "I want to switch netns but I'm already
holding the lock" version of _change_net_namespace didn't exist 
at all.

