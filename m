Return-Path: <netdev+bounces-184922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD62A97B62
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F5A3A2B08
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE6B21C179;
	Tue, 22 Apr 2025 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="r6GM2i8U"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC3C215160;
	Tue, 22 Apr 2025 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365978; cv=none; b=qQB3WXvn3gIkYP+LdHG5+KIbjVr7PTO1gRelhCA3+lfywzarcd8F8SJmO9rE0Bb14kINSFPabjOJNERozBoFa60lpKYcgihNgmnOaERQP81iVa3FClGbdSKuecXpraM6sdf3EOn7yL97Wg+uTkl2sK22NXtopTsvXMzqoHuxA9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365978; c=relaxed/simple;
	bh=poAB5gUqh8tzXC1P5DDkf9pwsWA1peC6ef8GdUAh1uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0ibo0jlQKqBsTMBMuSQC1gHN73qHZ84jvV2Y7g+dAaVMYAP/ONApygfa3nwsxKaMr6647Wo7JJITQGJ0bMypYDaor8z+TqT+7jkes/ikeqOHePoxH3wVWKkrq/Ab4uEzqmzjmTvWdNvlIUxvS7c5ha3tIc280v6Ba1l8ho6yfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=r6GM2i8U; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=UXTBln1mekQhfNVo/rkMsBjEhYD7eu3mX9VBliaGAh0=; b=r6GM2i8Uy7V/wAw9
	AUfqFnEOs5GEjdK/NlOQyX0Pu3oC+1zs2ylb01XSW2ielJ/VKXRziU2q0NJIlhUYZHVCk0S3aoYY1
	Wob/ARj6nzL37DOiIk7yB26P8TBMF25LVNrD6cGcv7dtNOIJyMOIKt68eWc9yQRzAsisqvi621Vha
	dDz2Y94u/7Skxrcw3gWZ1WXqYMwgv0w8rwICPiMLy4MSKBsmyoLX5u6h9DBB/wg+GKs3fWJ3A06sI
	bbvUSbB10HEAaeU4cSr+ypy+Wx7yhpHYKC+Y2nDUaG9YqVCN5VMxPxZ6ABUPEhSEyaWaFCIyM6zDD
	uKrk0NobkgM7hA3SjA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1u7NPu-00DCTV-1e;
	Tue, 22 Apr 2025 23:52:42 +0000
Date: Tue, 22 Apr 2025 23:52:42 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, linux-afs@lists.infradead.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rxrpc: Remove deadcode
Message-ID: <aAgrytcmlOGW-iv7@gallifrey>
References: <20250417153232.32139-1-linux@treblig.org>
 <20250422182229.GM2843373@horms.kernel.org>
 <aAgDNMfgd6z3tKEb@gallifrey>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aAgDNMfgd6z3tKEb@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 23:52:01 up 349 days, 11:06,  1 user,  load average: 0.05, 0.03,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dr. David Alan Gilbert (linux@treblig.org) wrote:
> * Simon Horman (horms@kernel.org) wrote:
> > On Thu, Apr 17, 2025 at 04:32:32PM +0100, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > Remove three functions that are no longer used.
> > > 
> > > rxrpc_get_txbuf() last use was removed by 2020's
> > > commit 5e6ef4f1017c ("rxrpc: Make the I/O thread take over the call and
> > > local processor work")
> > > 
> > > rxrpc_kernel_get_epoch() last use was removed by 2020's
> > > commit 44746355ccb1 ("afs: Don't get epoch from a server because it may be
> > > ambiguous")
> > > 
> > > rxrpc_kernel_set_max_life() last use was removed by 2023's
> > > commit db099c625b13 ("rxrpc: Fix timeout of a call that hasn't yet been
> > > granted a channel")
> > > 
> > > Both of the rxrpc_kernel_* functions were documented.  Remove that
> > > documentation as well as the code.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > 
> > Hi David,
> 
> Hi Simon,
> 
> > This patch doesn't apply to net-next.  Probably because of commit
> > 23738cc80483 ("rxrpc: Pull out certain app callback funcs into an ops
> > table"). So please rebase and repost.
> 
> Yeh no problem.

v2 sent, see message 20250422235147.146460-1-linux@treblig.org
(I left off your Reviewed-by since it deserves a recheck!)

Dave

> > But other than that, this patch looks good to me.
> 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Thanks!
> 
> Dave
> > 
> > ...
> > 
> > -- 
> > pw-bot: changes-requested
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

