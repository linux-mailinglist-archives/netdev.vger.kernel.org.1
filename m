Return-Path: <netdev+bounces-122815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E0F962A7C
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8304B282080
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09781898EC;
	Wed, 28 Aug 2024 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rphFqmtn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143C16D4C4;
	Wed, 28 Aug 2024 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856016; cv=none; b=m1TzY5xYjHuDxRgAdL3FrbYi6sizIOcd9dcpUMug1HiglbB0L0TneDMBeneLEx0On0jXaV8K4fL2ewAU955NDsDeS6akPIuboxgaTp6NCsInfH4gNiSQnxPWpgy9oi6cs8N5ybVIo0shFtYLCBqmgNccp5eVWvPkZgVw8dxNAiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856016; c=relaxed/simple;
	bh=kWOb+wQ9A2zCO7oUYQd4vrSK5/C5vUzR9g3OavAnYEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/IZg411RxoXEZcNSus6++YlGvnQi0/gDmpp+Vc6mpTzvE32ICXGSYpmrJMRz6b0FSUSGL7rYEhEooPeZPnJamQZgtyv6CuYxyjjc1Ynma47XpB93qg3Ju17BzKqIUjyHS1whgtSQ/n/EfwfP7MJiv8Onr/pmFI0wRpqYFjPOFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rphFqmtn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BA7C4CEFF;
	Wed, 28 Aug 2024 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724856016;
	bh=kWOb+wQ9A2zCO7oUYQd4vrSK5/C5vUzR9g3OavAnYEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rphFqmtnoLhkVu6j9RVSSeSzronoZC3tuEqLUr/YP3AT3yBD8XCG/dHpOk7zgfDs0
	 uJSL8xCYlViuypURIDQXP2b5LvMEjXeaU3LOtW4OjjvGR7ViiPdHux58S+8rzSLSB3
	 AN81s+gT/+uJ6cvdu5LsRxuhn8/YTzW6CryUG5h2FZxwcRX7pE63xB+yHDp+xiPT3F
	 Jn2LgHgzjINE/f+OXiCDjgkGFVqH9Vfy/XLnaino8bfncxOpcL8J8dbUwU8wLf3D6S
	 d1ttnWFLGApPZ8fyL7+Zd9nZj4tynDIeNDgyidtygahGTph7eSs9w+zO8oIa9i49eD
	 Y9tAVIRpg2qQg==
Date: Wed, 28 Aug 2024 15:40:12 +0100
From: Simon Horman <horms@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5 next] net: vertexcom: mse102x: Silence TX timeout
Message-ID: <20240828144012.GJ1368797@kernel.org>
References: <20240827191000.3244-1-wahrenst@gmx.net>
 <20240827191000.3244-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827191000.3244-3-wahrenst@gmx.net>

On Tue, Aug 27, 2024 at 09:09:57PM +0200, Stefan Wahren wrote:
> As long as the MSE102x is not operational, every packet transmission
> will run into a TX timeout and flood the kernel log. So log only the
> first TX timeout and a user is at least informed about this issue.
> The amount of timeouts are still available via netstat.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>


