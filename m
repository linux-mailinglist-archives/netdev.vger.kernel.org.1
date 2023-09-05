Return-Path: <netdev+bounces-32144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD4B79306A
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 22:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1DA2810CD
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F704DF6E;
	Tue,  5 Sep 2023 20:54:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E98C14
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 20:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E837EC433C8;
	Tue,  5 Sep 2023 20:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693947239;
	bh=rPD3WYvBqg9PWkPEMXs+yj80x0SnlrDTEIJPptThAxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NqWVB2b+z6W60vXKcAyJOlNDeQSZjzea/uXqVnYc7iCgDpebHFjnDD367NrZOd+B+
	 w7ITI3lz/UMcj/AKpm7M3+eoWxmN2y6/ouzwOGt8niR40hI1BXX2fGle8KQvrKu8Nm
	 ZqWlmszQ2c8UrWNeROdO2qslZlSKz7w09EFm+KeRCeFVgGTfNDvrb/5zX7otstp3n+
	 GLV2tQYnFRud7FsTFz9JiQ9OFnq8SvdRlOaZRFxtS+cpK9zP6W8gfYwvjwIBAk461T
	 CVQ3BMJ2c7Uad7kkOaER3hDLYA1GEBDyt0Hg5M7CAA6t3XLgsKotxFvSqCB5iXDGoe
	 iuHy49aD1XwTw==
Date: Tue, 5 Sep 2023 13:53:57 -0700
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
Subject: Re: [PATCH net-next v3 6/6] selftests: forwarding:
 bridge_fdb_learning_limit: Add a new selftest
Message-ID: <20230905135357.78b57cde@kernel.org>
In-Reply-To: <20230905-fdb_limit-v3-6-7597cd500a82@avm.de>
References: <20230905-fdb_limit-v3-0-7597cd500a82@avm.de>
	<20230905-fdb_limit-v3-6-7597cd500a82@avm.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 Sep 2023 13:47:23 +0200 Johannes Nixdorf wrote:
> Add a suite covering the fdb_n_learned_entries and fdb_max_learned_entries
> bridge features, touching all special cases in accounting at least once.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>  .../net/forwarding/bridge_fdb_learning_limit.sh    | 283 +++++++++++++++++++++

Please add it to the Makefile so it gets run by automation.

