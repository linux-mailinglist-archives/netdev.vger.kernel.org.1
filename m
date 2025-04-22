Return-Path: <netdev+bounces-184869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0060FA9781E
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3182E17BD8B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 21:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512262DDD1B;
	Tue, 22 Apr 2025 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="oA1tUWXX"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0BA2DA8E7;
	Tue, 22 Apr 2025 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745355602; cv=none; b=qxfuS4h1fLLu60Mcm1mBrKrJfkNEyLoO/ycsNiT4cJTIJ/LmVJB7E82r6b9/2GoLpCD6EXBEWTip7MBEJzCa13zux6uzrncpO2pklVaG0/HOdBIYp1S9MtWZfaTSiwQVc6a000goOe5OG2GhTjqARC10fTojozdXOMwtDpsBhtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745355602; c=relaxed/simple;
	bh=uam3gb5IbWJBT9+xbLlD9Gwv4AiCNpeJITFhF6gzeyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWGA7eT1kLxwp4drLZCBGvoGTadFU1g/NIsIc+TyRhfwCd+GrDVycd1Wn6jkdXTYgVcvg3RmQc0TsyZtTRJDM/UrE+caJl9eG2fuTEnEeT1+GBXUsIufIpBUj027mkIVJ5OEuLpo4PHBqOfE/L1FEF2+tRj0XVZxdT8mk60pco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=oA1tUWXX; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=+FsFGnaVIo4H6AjpaQpT7Z75xpMCOgoIe2eqxjLwdv4=; b=oA1tUWXXGbOEP9pn
	//RCDTN+bxWHlJuNofsOyGKv6c3K3Zh+l0vWVtOHfTjmd6IJe/nIcxWIljoU4/kUdP9auQXUUAFQu
	7gLfXrvlI4SMFVF9V0WP1Gtp4s5HT97tBk2e39qzrGhWa7sBlEtQsSrQAJm3zHs8U/zpRC+co/Fz5
	rkUUsllSsvisS5KvXyiAHoRDrYoVza/hQ46nre0oPB+Mgzj73SuZoznGEC+rrdbdF53fl0zm9WLSC
	nVypVSnejAqdTTwaTkM+RrFx8KhJALRTYntJpeZ+cWruiTjBbJUJResYV5AP46A/E4QxYus12kQ2o
	gZfxaqLBzccUKGqLCg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1u7KiL-00DArE-06;
	Tue, 22 Apr 2025 20:59:33 +0000
Date: Tue, 22 Apr 2025 20:59:32 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, linux-afs@lists.infradead.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rxrpc: Remove deadcode
Message-ID: <aAgDNMfgd6z3tKEb@gallifrey>
References: <20250417153232.32139-1-linux@treblig.org>
 <20250422182229.GM2843373@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250422182229.GM2843373@horms.kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 20:59:06 up 349 days,  8:13,  1 user,  load average: 0.02, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Simon Horman (horms@kernel.org) wrote:
> On Thu, Apr 17, 2025 at 04:32:32PM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > Remove three functions that are no longer used.
> > 
> > rxrpc_get_txbuf() last use was removed by 2020's
> > commit 5e6ef4f1017c ("rxrpc: Make the I/O thread take over the call and
> > local processor work")
> > 
> > rxrpc_kernel_get_epoch() last use was removed by 2020's
> > commit 44746355ccb1 ("afs: Don't get epoch from a server because it may be
> > ambiguous")
> > 
> > rxrpc_kernel_set_max_life() last use was removed by 2023's
> > commit db099c625b13 ("rxrpc: Fix timeout of a call that hasn't yet been
> > granted a channel")
> > 
> > Both of the rxrpc_kernel_* functions were documented.  Remove that
> > documentation as well as the code.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Hi David,

Hi Simon,

> This patch doesn't apply to net-next.  Probably because of commit
> 23738cc80483 ("rxrpc: Pull out certain app callback funcs into an ops
> table"). So please rebase and repost.

Yeh no problem.

> But other than that, this patch looks good to me.

> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks!

Dave
> 
> ...
> 
> -- 
> pw-bot: changes-requested
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

