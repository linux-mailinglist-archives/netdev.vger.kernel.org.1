Return-Path: <netdev+bounces-144360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4099C6D2A
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA77F288645
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977601FEFDF;
	Wed, 13 Nov 2024 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2YyxFRX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7117E1FEFAB;
	Wed, 13 Nov 2024 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495136; cv=none; b=FMZ7Udw/pEQMNiK4H69GPb/vTm4cVNp+/DiYRa1mlE/WvSLb31XhFzjM2j/wtKUHcLVpdT8n61VV+3bdcUUDJOmO8k4DFM5URxqXmbO41b+gH0hZfbyLY5ljrpq84V3OS5tpv7GhWa3RltbSk6FxYLYB7id8ZRWh69HMdomzBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495136; c=relaxed/simple;
	bh=fR202e2OmToW9x6LjGPbI1AnscN4fiyqn1l3j0n2C+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdJFys+iMMqBddLvgsPMsUfKDviUmbsbFEgElYD1q6s9mPL04iQV/sr8nBb3EzmY0RyAPrE7suS75uIjZOI1G6Usai8n65S2EYFuKglaQhn6oDgJyKZUzBvnb0WecOf+mtvsg28bPvyoaSwyLP9XL+Its2Op48pBSPpyosUS8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2YyxFRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302C4C4CECD;
	Wed, 13 Nov 2024 10:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731495136;
	bh=fR202e2OmToW9x6LjGPbI1AnscN4fiyqn1l3j0n2C+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I2YyxFRX29UbbNn3Od/QlvIAmLBFSWYBBQx26yntcglGDdEwRcqY8yG1bPf9xp5lX
	 P/roEqjIQLNOFwtl0EK6O6AOk76mwvGiLd4Q+vY/e8B5fXNjxyD6KmCF4jaV/US0br
	 +wjokjWJac8SUcxIvwukm+k5Cmw+lI83m8HhycrgLRqlmf/roaKu8dK4KFrjNguYHY
	 ZDrKl7skUe3inUuno6xr93uAtz29uNR2v990TjTBK3hXzhI8BWNv6/S7Vw94hi0TBv
	 UPoJgzki41S7/x4HcoBQJlCsc8j7ComO/s84HsVS5tut4TCP8s8OdP9Hpp4oVOsrbA
	 BZ5rVniwCM0cg==
Date: Wed, 13 Nov 2024 10:52:11 +0000
From: Simon Horman <horms@kernel.org>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: kuba@kernel.org, donald.hunter@gmail.com, davem@davemloft.net,
	edumazet@google.com, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, sfr@canb.auug.org.au, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ynl: samples: Fix the wrong format specifier
Message-ID: <20241113105211.GX4507@kernel.org>
References: <20241112080236.092f5578@kernel.org>
 <20241113011142.290474-1-luoyifan@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113011142.290474-1-luoyifan@cmss.chinamobile.com>

On Wed, Nov 13, 2024 at 09:11:42AM +0800, Luo Yifan wrote:
> Make a minor change to eliminate a static checker warning. The type
> of s->ifc is unsigned int, so the correct format specifier should be
> %u instead of %d.
> 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>

Reviewed-by: Simon Horman <horms@kernel.org>


