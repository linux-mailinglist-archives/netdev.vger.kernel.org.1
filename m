Return-Path: <netdev+bounces-32143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C841793068
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 22:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A901C20960
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F77DF6B;
	Tue,  5 Sep 2023 20:53:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF2DF69
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 20:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611A7C433CA;
	Tue,  5 Sep 2023 20:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693947206;
	bh=McSbLrGFeETjic6sxW1tV/OSWfLMVGkO3zyx6fwzAD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UmYaix6CMXspfjsBHFwu9TqeDcbAUtZLSJZhiKGh93y/eTW0vFVZJksebBSqKMjLO
	 yIHp6jvY+64Ln8w9tABawpSdI/0EU98HLVDxShMib/n1t5txZ6egG1AnL0vai4ViSu
	 bc1R5cApLR25xwhR+9zvoRBDokPdWly7zgnJNoDBsij3zR3yM7k3zlWR5T1GyCoXCg
	 yVL+CAHlxjfdsaEbDjhooNsTX5623b7o58ClhAkBbfBcbIDHrVU4YzchWihT7JFr93
	 jXgHIN+ALaNkt7RHe3guGRF88dO+XDHjysqWtho5zmrjGIwd42IgWry720IsAq+KNL
	 bU8iSehESqm+A==
Date: Tue, 5 Sep 2023 13:53:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Oleksij Rempel
 <linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu
 <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, bridge@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/6] net: bridge: Set BR_FDB_ADDED_BY_USER
 early in fdb_add_entry
Message-ID: <20230905135324.1b9f7be4@kernel.org>
In-Reply-To: <20230905-fdb_limit-v3-1-7597cd500a82@avm.de>
References: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
	<20230905-fdb_limit-v3-1-7597cd500a82@avm.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 Sep 2023 13:47:18 +0200 Johannes Nixdorf wrote:
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1056,7 +1056,7 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
>  		if (!(flags & NLM_F_CREATE))
>  			return -ENOENT;
>  
> -		fdb = fdb_create(br, source, addr, vid, 0);
> +		fdb = fdb_create(br, source, addr, vid, BIT(BR_FDB_ADDED_BY_USER));

Please try to wrap your code at 80 chars. Also:

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


