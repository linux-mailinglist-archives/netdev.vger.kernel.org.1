Return-Path: <netdev+bounces-229204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF69BD94F7
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1189A192598B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9811231352D;
	Tue, 14 Oct 2025 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GhDsFk+/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68AF313530
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444467; cv=none; b=VXzEKFU7RhsZWTquuj27/hEfgjDa8QYkn70FX41ZcMMugrXl+8D3yLhLjNPbMj4mRbc76D6B0piv+nAiURk4SKAQjJfGmK9drPUPt9jEb6HIQWG5MeJ406iF328zNkC0vtbQ1hoveuG1Zn2cTr+NK633SLtcy9DJ6u/UiUWFwFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444467; c=relaxed/simple;
	bh=NQBkTz2by13SB0ClSnpbFlYvS2ORjjmIsvaHomcBs4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeqjotgU0fUmm5Jrx91p0J4A+Gxpv31s5vSrWMfdtchXJt/+BdzVXmD7GZEQPOPR8oBYC2lBbKSCakvj9INo0z/gmdA9ihi0TRHEhJDlOi1OS2m/4ffAw5+0VU1MvefHQnvar08q5kfVyNj+gby2Z7ak8PDdnBRZDQv+P2CL188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GhDsFk+/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j2mitmj8ohFWgr5WJ0EVTwbZGaIATAxauNtgk8bzpdI=; b=GhDsFk+/bFMZM+kbgvl3z59hMm
	hxRObmpthiv9WaTTZ21XGwKvlnOi2DmaQ0SZZdL7HHaEuOyWY1BWTuo8Z2qwxI0M7tGNLGohO4gOq
	C1Wq+5Br7NCqOe+tm5U4z4bhmDuAbAVMjfm+c/bd6kORlQwzh3jW9l1FVlKjwoQdDR4E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8e1N-00AuHb-7u; Tue, 14 Oct 2025 14:20:53 +0200
Date: Tue, 14 Oct 2025 14:20:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jan Vaclav <jvaclav@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next] net/hsr: add protocol version to fill_info
 output
Message-ID: <fc340ed2-8d1a-4e1e-bd3b-88194248817d@lunn.ch>
References: <20251009210903.1055187-6-jvaclav@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009210903.1055187-6-jvaclav@redhat.com>

On Thu, Oct 09, 2025 at 11:09:08PM +0200, Jan Vaclav wrote:
> Currently, it is possible to configure IFLA_HSR_VERSION, but
> there is no way to check in userspace what the currently
> configured HSR protocol version is.
> 
> Add it to the output of hsr_fill_info(), when the interface
> is using the HSR protocol. Let's not expose it when using
> the PRP protocol, since it only has one version and it's
> not possible to set it from userspace.
> 
> This info could then be used by e.g. ip(8), like so:
> $ ip -d link show hsr0
> 12: hsr0: <BROADCAST,MULTICAST> mtu ...
>     ...
>     hsr slave1 veth0 slave2 veth1 ... proto 0 version 1
> ---

Patchwork probably accepted your delayed Signed-off-by, so this might
be accepted as is. But please wait 3 days and if you don't see a merge
email, resubmit.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

