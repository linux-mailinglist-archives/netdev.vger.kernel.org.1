Return-Path: <netdev+bounces-66860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8F88413C7
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 20:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA521C236BF
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CBB6F083;
	Mon, 29 Jan 2024 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrUlDns9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC476F09C
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706557984; cv=none; b=GFFbHXYFsFutKrsnDuYK3VxlMLMrRXTJY+2haPrjTb03TUAmGP/0dRwsPWg5z67YPSUJnfD0w5AJMPX5Oax1h2y5ZyO8BvM81636G8vpvdQcCUYtCu9QZiPZ0j9aDbSf2lGqpJ9ABT1VZNz+F6O9Bsq3Tcpghi5JOn5Dt5gEfy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706557984; c=relaxed/simple;
	bh=79gSPovBIv1b8PM4z33e9Njo9+y0ThhwiNmItJ04uYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKe0/494xwDlUQudszo9X4rbf4ps38fpKJpAc3WWvCD5OhZUlkGV9s/w7x+QI1v3We/N6TCiiE/LBx1PcyTeC/1AKmdzd+WwTQ+PWIEQyJa7hfBowhHoyKqbow8gcjggCZJiWhpyLtsl7zFo97UdmdxQWwBIwVw6KvG1uhyRFCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrUlDns9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2158C433F1;
	Mon, 29 Jan 2024 19:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706557983;
	bh=79gSPovBIv1b8PM4z33e9Njo9+y0ThhwiNmItJ04uYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrUlDns9/Tz5mMiti1LW38AC0+ykHGogH7mNt2d5PnRQN6LHhyz6pBbrbIQoelMdb
	 QiUcVU1Lb1m1DTmddFUQZcOMqxDoQa/BQcP+UvcoJsuOMAXCYNGKPHjrk4vGc76wo5
	 ntPPzxkmCQyfqWMEQX/0mG5YyLsmJOga1nFgC6uC5RiyJlXstbk5lU2Rhvc+CNEO7J
	 qQViGxLflE7J1akxIFax2alXimbi0YOQuGCYWYZ2N0TqSiWUZKEUUdW7Vf5vzGrhj2
	 wWzaZaUqmJcnxBduhkjfstnQmBrEA4wkD7db+4bsuw3AuXH9rAga+qhnbbKGQKsxTZ
	 3VdNEoVRtNatQ==
Date: Mon, 29 Jan 2024 19:52:58 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 2/6] mlxsw: spectrum: Remove mlxsw_sp_lag_get()
Message-ID: <20240129195258.GM401354@kernel.org>
References: <cover.1706293430.git.petrm@nvidia.com>
 <60abbc61e47cce691121e761340d6cc5d7f06f4e.1706293430.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60abbc61e47cce691121e761340d6cc5d7f06f4e.1706293430.git.petrm@nvidia.com>

On Fri, Jan 26, 2024 at 07:58:27PM +0100, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> A next patch will add mlxsw_sp_lag_{get,put}() functions to handle LAG
> reference counting and create/destroy it only for first user/last user.
> Remove mlxsw_sp_lag_get() function and access LAG array directly.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


