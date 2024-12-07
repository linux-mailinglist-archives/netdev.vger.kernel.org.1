Return-Path: <netdev+bounces-149865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C173F9E7DBC
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 02:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB541886DFD
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 01:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A8622C6FF;
	Sat,  7 Dec 2024 01:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQDgy4wD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4615722C6E8;
	Sat,  7 Dec 2024 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733535131; cv=none; b=XE1q8s+tZoA5tllA1TtCA1bPx/nosUhW86g/SMqD3Vc9a9XvaGphLhe1VcrxV/9zaDNsVTxTUVefaMBvqxuL27jT9H+ucNC+6X5A6ZmaST+vIDuY2wObu0VCfHGYHDInfqkbS/omFkuy5JOpeBNbAJ6dfNeC8aFlDWMz7QNmsq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733535131; c=relaxed/simple;
	bh=L/w6Rf42nzOgdNeNz21pHGIFlrSPjNLkdvscmHfU6J4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0fTzIWAUAlbxtJCDIr9VsmgkdFPC4yr6+9aU0dNcB72pNJ573nTDkgA2OTlMQVCo0kJ0rb3Q7MxiWKAipJ1v5mWN4MD9dgTijW2uR0v3L4rjAWRPQarBpTkc2JA8C2UAh5vRmXQyvTmz4Yv6FsUAzOERkmBnMTLwCRkRcPcCiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQDgy4wD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A0FC4CED1;
	Sat,  7 Dec 2024 01:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733535130;
	bh=L/w6Rf42nzOgdNeNz21pHGIFlrSPjNLkdvscmHfU6J4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dQDgy4wDBGNgYU9b6Zw6HzHN+xI1synkMjbQbtADR1bRoZEY+pgZLswF39sHrBB4N
	 f1c4ysEKhejt0RmGzC0AKBL8MydUO+N1axjhLquvszlq8bcCb/18Ncgnt9kZ3PeNsp
	 acIcy85U4Ing1U4dMhNlVeJKTLIxkcfH5CJ+H44LzDohcHY77dBWNwNn6bTm0232pd
	 lPKunEHupQuYX8MfyE4LYRJy2aW30PZ66bArS5GwGftcsp2PWUgIrwMDzNNIdD9u67
	 4KUZT3QQ7O3pb3lgygcwCyJro2cU2YpNZBs997whQ6TLbJsMwK0YTF6qnh8tXrivra
	 RcOidGKA+IyRg==
Date: Fri, 6 Dec 2024 17:32:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCHv4 net-next iwl-next] net: intel: use ethtool string
 helpers
Message-ID: <20241206173209.6f9fd5fe@kernel.org>
In-Reply-To: <20241207004737.33936-1-rosenp@gmail.com>
References: <20241207004737.33936-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Dec 2024 16:47:37 -0800 Rosen Penev wrote:
> Cleans up the code quite well.

Maybe the ixgbevf changes, yes, but the rest of it is just churn.

