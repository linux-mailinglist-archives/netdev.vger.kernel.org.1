Return-Path: <netdev+bounces-247447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 107CBCFAAB5
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 20:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F05730050B2
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 19:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373F534D4E4;
	Tue,  6 Jan 2026 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wt1oY/nA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F3034D3AB
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 19:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767727843; cv=none; b=V8ZPs6/Rf92osmGXXgAbJb36j472jiPIUNwkC00fRmngocZnArt/FQaHstbhUlO+GYlredzurp/MH2vmlcHacl2+QG9+0iKEbE3+1TWduttuNfFqw6BK93cICoke/o+1ivcfdl+e+FZf3J1qcFt6VIkuc0Z0vaxY8tlvzKxTmak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767727843; c=relaxed/simple;
	bh=P3Gnd3qqWm3u6hLqvo/Zeg+ePO3tUXuFY3/2YrolhpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FxWakbt1Ra9XjZUkH3MqFMF8GYJyq8XrwcpAmbvyK9VZFS5WS/X2cKAJ3mdqYafNRyIHlvDHBVJf64WeS9izdeSGbE0azPMIwUV60m4S9tqlDIvRZUK3tAcUmBS//4ut76Ynb9bGU/lpuKIrJp/lzlpsrUAhnB5F82fRmctHHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wt1oY/nA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429F2C116C6;
	Tue,  6 Jan 2026 19:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767727842;
	bh=P3Gnd3qqWm3u6hLqvo/Zeg+ePO3tUXuFY3/2YrolhpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wt1oY/nAAiKL4aY1gsxKMadngQiJvwYDAssMtfZfYCPccDdhHOgxeLy5R/CiNdz09
	 cqctvL/raT+kdGrFOrxXH4Mlu7U3fbHdbIqrSY2vitDSSL8CaEvslbW1yEWcfEPBXq
	 rZ7m7YJlRuZnfE0kiAEGnQxYlcfHsBlw2bnN917l7iyKZaLtpBACrDdjR6Gbd6+J9+
	 oyIOwgkhlWPyZ1oijyAvjf1JvfKL8TGgISuIiLVaKkxb7YDum2sCHYzGUdurLwE2pn
	 x51F7gCfBTkgb5+cFs83Rl/UUZ/eJsWXPPQp935z0Q1m6x9JuJ/4jybxrGLruvbmbH
	 9SAQESpDJEEOg==
Date: Tue, 6 Jan 2026 11:30:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] net: update netdev_lock_{type,name}
Message-ID: <20260106113041.18423d86@kernel.org>
In-Reply-To: <20260106164338.1738035-1-edumazet@google.com>
References: <20260106164338.1738035-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Jan 2026 16:43:38 +0000 Eric Dumazet wrote:
> Add missing entries in netdev_lock_type[] and netdev_lock_name[] :
> 
> CAN, MCTP, RAWIP, CAIF, IP6GRE, 6LOWPAN.
> 
> Also add a WARN_ONCE() in netdev_lock_pos() to help future bug hunting
> next time a protocol is added without updating these arrays.

Looks like we're missing ARPHRD_NETLINK

https://netdev-ctrl.bots.linux.dev/logs/vmksft/bonding-dbg/results/462041/14-bond-eth-type-change-sh/stderr
-- 
pw-bot: cr

