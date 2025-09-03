Return-Path: <netdev+bounces-219748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9814CB42DB3
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 01:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C03C564FA1
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 23:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB842EA479;
	Wed,  3 Sep 2025 23:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ydn6NR7q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82CA2D0621;
	Wed,  3 Sep 2025 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756943711; cv=none; b=iBMopo2aPbzFnxG4NYL+yI9peLlquRGcUXS/o0jACt6lkq4bwEDzHRtBjxEJezZo2GPUYv7OIUKT2KLac9s3g4KZLr9juehWwlmyQ25Ls+vzD9iK96NecZNd0iWFob06Erui004914kuCUT/CAf0B+f0lYsXeLmngdvsfjRVtBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756943711; c=relaxed/simple;
	bh=zdc6tBKdWK4w2jnHsmX59OMLZjib39x0xamQWfT0I4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myYPM9fQHBqCjac9pxyu/67YvQCZNwMnkySRPDEg3orUAQGZb4z84rIvoYa2ao1GwnOJ6KS+5yqcDDazFTqkkRFKZ2Bf1Z6pMyT1Xl7JgH+l3TjQMyduMAIB2QrLmD+yBEy4fxt1/EKNZ/TAClwIBbUf/q7R+/dbNaSgeGs4S6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ydn6NR7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E510C4CEE7;
	Wed,  3 Sep 2025 23:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756943710;
	bh=zdc6tBKdWK4w2jnHsmX59OMLZjib39x0xamQWfT0I4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ydn6NR7qqN6iLnJxjbJnqREuiX/tcbVX1MWA8BYYjdXmO3/ZLdCjO5IkprhwIZ1Sd
	 cLUt3h9CM8+fPnC4P3pHtrjiDYXIt+zn5qsvBkZVA4WpCfYhm3UICWMjMZ8ZjExdNR
	 L3t3q2aG6uZFQExwx+y+3l5bvqrWo4bfTIDebcrdpjaN0NlGKCRv1h47G5clwOWcZr
	 chE8/BRlERzD1pHHy5mZojYZElZwst9TB835h2KhGUkFSudL10KvIurQUvnQfouwks
	 aNvTG6620TsjupVK+/aBqk6ayMoH3Yhkj/YFGnHWRgKNmLRQ2qXye7PVzxGC00xGj/
	 BAFdUDakaI4HA==
Date: Wed, 3 Sep 2025 16:55:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com (maintainer:MICROCHIP LAN966X ETHERNET
 DRIVER), Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
 (maintainer:SFF/SFP/SFP+ MODULE
 SUPPORT:Keyword:phylink\.h|struct\s+phylink|\.phylink|>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCHv2 net-next 2/2] net: lan966x: convert fwnode to of
Message-ID: <20250903165509.6617e812@kernel.org>
In-Reply-To: <20250901202001.27024-3-rosenp@gmail.com>
References: <20250901202001.27024-1-rosenp@gmail.com>
	<20250901202001.27024-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 13:20:01 -0700 Rosen Penev wrote:
> This is a purely OF driver. There's no need for fwnode to handle any of
> this, with the exception being phylik_create. Use of_fwnode_handle for
> that.

Not sure this is worth cleaning up, but I'm not an OF API expert.
It's pretty odd that you're sneaking in an extra error check in
such a cleanup patch without even mentioning it.
-- 
pw-bot: cr

