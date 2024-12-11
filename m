Return-Path: <netdev+bounces-150963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 682839EC309
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 04:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262491884F96
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A58209F3F;
	Wed, 11 Dec 2024 03:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amJicojj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A5220968E;
	Wed, 11 Dec 2024 03:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886921; cv=none; b=UKc9soQa7Mbo6qJruEwQOg1OOQ27ImxbDL4kQc8f6ZnKjacOEKqNqVztvQ0NXMktG6FS8zjvfBJNPiuZvInJARooaaRw1WAkWdV9gv8H/oqpt9oscIM8pOWzbpyHsWRJOQeFsuQcfBWQOqVA3Y4iGLR4MmoSAUTrv21HvzNJVy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886921; c=relaxed/simple;
	bh=UOIegFMatyydnbsJT2DjmYU88VsiAetEPrZp/GBSlxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hp7tgUZFz2WUUsKVztsUaxVmtMvwgF6e442Sfed2+Hed5BcW/W6FWV8HeMHSYnkokAn7qdP69DMcYrlBKc4MJjULHxRVY/7pQoJomoRPsBgEuCda0haM/OBDWMG+LX2+OaKhbNQdznOxY2FRa/Qz9PY6Me2ZLex7jcWNIPT2QPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amJicojj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA64C4CED6;
	Wed, 11 Dec 2024 03:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733886921;
	bh=UOIegFMatyydnbsJT2DjmYU88VsiAetEPrZp/GBSlxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=amJicojjJn5U2OX4RrlJLkyeS1558jOIJQJQAofXYgsjKB7q55DNYBb8/NIdTz90I
	 YViRNV8qEDeIe2fxhoArUywvw6i5q3E1lOQX/ExNYGs8Y9HY98bdox8QboWVFPMtne
	 NOFc5cMGbX4VZl/6u2d/Qk0ssVi79O+2qdF7R2GlLX+XkqfPgK6c8JJ1BLUTbOY7VJ
	 BGqRaNo7VSftjRwV822D+b8Ga7nzz1OE8t0+hpqQS8mI/wF9jk5B0B7dHTiWp8ecbR
	 jUTXMtJen1EAExHwFI/nmrroMZxR591826YSMCUdYosaqa7J0tFT5e1C1aP9rq1lH4
	 U2bDxc4gNjp3g==
Date: Tue, 10 Dec 2024 19:15:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] net: dlink: add support for reporting stats
 via `ethtool -S` and `ip -s -s link show`
Message-ID: <20241210191519.67a91a50@kernel.org>
In-Reply-To: <20241209092828.56082-2-yyyynoom@gmail.com>
References: <20241209092828.56082-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Dec 2024 18:28:27 +0900 Moon Yeounsu wrote:
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&np->stats_lock, flags);

I believe spin_lock_bh() is sufficient here, no need to save IRQ flags.

> +	u64 collisions = np->single_collisions + np->multi_collisions;
> +	u64 tx_frames_abort = np->tx_frames_abort;
> +	u64 tx_carrier_errors = np->tx_carrier_sense_errors;

Please don't mix code and variable declarations.
-- 
pw-bot: cr

