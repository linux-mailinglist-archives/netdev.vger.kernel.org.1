Return-Path: <netdev+bounces-32735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3467A799EC8
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 17:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90929281167
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 15:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C62B79E1;
	Sun, 10 Sep 2023 15:18:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF356FA5
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 15:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E593C433C7;
	Sun, 10 Sep 2023 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694359093;
	bh=FzXvtdg+0ajHhjpoiaDzKl8wP+4FrX0l/Qwx3xGSXZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eH56V4FYlz/V3h2aGnZBunqCrMEceXNcg8XW1wPj94e2KmDuCtOeM0jeSeiN8lwia
	 rOEK2M36pdQc0cUV7qGRvG4NR3fcGGYrpmlGqrN5ETFdlFX7k09rViMZYmfAAfYMt6
	 ihcXgzFPkPM8ryzloaPaCXxboPGelBmCcHrfIgHDuxgVpqYOzq+KROYAeZW+p7pG0W
	 svxr9NPKIG2F/8spCA8zZ9MDtxJycG5EgIwqrked62ShRbut1E6rwYXXkkgprZ2d1f
	 DmsMRtGR+Wb21qvI9S5cpbJy9+96J1uP0GwjkwHhvfA+HkFRdYb/+MC9MQwuwAMqDB
	 D3fPjjF3R79tA==
Date: Sun, 10 Sep 2023 17:18:08 +0200
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Yanan Yang <yanan.yang@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] Fixes for SJA1105 DSA FDB regressions
Message-ID: <20230910151808.GI775887@kernel.org>
References: <20230908133352.2007218-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908133352.2007218-1-vladimir.oltean@nxp.com>

On Fri, Sep 08, 2023 at 04:33:47PM +0300, Vladimir Oltean wrote:
> A report by Yanan Yang has prompted an investigation into the sja1105
> driver's behavior w.r.t. multicast. The report states that when adding
> multicast L2 addresses with "bridge mdb add", only the most recently
> added address works - the others seem to be overwritten. This is solved
> by patch 3/5 (with patch 2/5 as a dependency for it).
> 
> Patches 4/5 and 5/5 fix a series of race conditions introduced during
> the same patch set as the bug above, namely this one:
> https://patchwork.kernel.org/project/netdevbpf/cover/20211024171757.3753288-1-vladimir.oltean@nxp.com/
> 
> Finally, patch 1/5 fixes an issue found ever since the introduction of
> multicast forwarding offload in sja1105, which is that the multicast
> addresses are visible (with the "self" flag) in "bridge fdb show".

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


