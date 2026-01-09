Return-Path: <netdev+bounces-248574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC2BD0BC72
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 19:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C281230142C3
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 18:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3998E350D77;
	Fri,  9 Jan 2026 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eou/lZfh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EF73451C1
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767981711; cv=none; b=VqJHDnXIyK2rh/8X0eshIP57lYK88F8RFDPWB0fGIoabUtg+90+6v/v/sESvO7kzHYotkcvdkUUzMvlSs82zy3mDHUSAD0+j7aB1DpE61paOhro4gaRhH3+4hjunaJjQSSv1LAs9/4sQvpvRti9jlM0mVoWWekG7HGP32Y0RTKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767981711; c=relaxed/simple;
	bh=3MS1IGZ4sLLliA7RlCP3LlxEIiQXEZyhKYHXOdYgc7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUMS55BL+8+PqClmoEDKXmn7TlOW9IpRoITcaSa3EOByS6P9HzuuJMvnYg70OW4DUYdz2DBgIjFPjdlNyqHyacGD2C4Y45RcqAXqoy0tUEmkPhuTUrqD9xz2LNEoExz4OKIYN9sY8btJ37gRTt+VF9rIPvn/WXWx1RTDbiP190A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eou/lZfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A10C4CEF1;
	Fri,  9 Jan 2026 18:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767981710;
	bh=3MS1IGZ4sLLliA7RlCP3LlxEIiQXEZyhKYHXOdYgc7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eou/lZfh9K10Ut3RAVNQ9RtcYC/zRSUbmM+ZPa8yu8eA+hsSlRm9qkFvjkkRv6w9W
	 xmaDoCucW4hpDKpxtOqFU9hVWt7ESD7o1TT6yMv9S6zSj6oDQhW2qlb3iAlkvxGvIX
	 O9ixLkg21+hKpf8dp5qWtjTL1FlS79uYtkumTYG3/E5rYjUTEAMcX/LODJEu91H0Ty
	 ums/899gpYvlcTVZ/awxp4qQnbm1T/Dj1n2JV0svrGy2DRqHqQQB0HwjiXEZe1OaS0
	 8CWws1nhEomH0gcHPkNgtrB3gWVwlH+O/8mn6HHjnlEzNUTTPfJciEBfwYHO6XvLEP
	 i4v12GWsbUmww==
Date: Fri, 9 Jan 2026 18:01:47 +0000
From: Simon Horman <horms@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] docs: 3c509: remove note about card detection
 failing with overclock
Message-ID: <20260109180147.GN345651@kernel.org>
References: <20260107071146.30083-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107071146.30083-1-enelsonmoore@gmail.com>

On Tue, Jan 06, 2026 at 11:11:45PM -0800, Ethan Nelson-Moore wrote:
> The id_read_eeprom() function has been fixed to use a time-based
> delay, so this issue can no longer occur.

Hi Ethan,

I guess this was fixed quite some time ago, given that the driver
doesn't see much attention these days.

In any case, I think it would be worth providing a reference
to the commit where this was fixed.

> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

...

