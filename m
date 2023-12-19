Return-Path: <netdev+bounces-58716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0BD817E56
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7350D1C22E9F
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C05BE73;
	Tue, 19 Dec 2023 00:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adw+jVlp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FDFAD30
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D199BC433C9;
	Tue, 19 Dec 2023 00:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702944083;
	bh=FAY0m/a6XfAczCZwQ8o24OOTPbUY8816RESYnftuyo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=adw+jVlphJXd9htMBkkbwRIfheC1Y5bVqmRudz90pPlXvN+luIRbxe26UYGknWbon
	 jZcFTT/7LJI6KSkjlUjS15WnRLPip66Teox6LBxGxFh+aAReVpEg4jE3r5LyGTiMqX
	 uckWFfcj/J6ddezWJcsuOIv+VZ78qwU2so3B+g4ZYtBiMCo3uA4JwRZ5uTgOy7O2Vn
	 QhbXCnZccKlangFB0wmpbOK2FAFiUXBvgy3MrkZv4w17eJkwb3nxyOJqEuQRZ4Usr5
	 hvacB8+DDuIOldNoNU7cprfnfstiRwz/QGnQiRBagRVoyLiUAnzu7IGHPnrJ7s2WbO
	 zNA1xtwckJJ3g==
Date: Mon, 18 Dec 2023 16:01:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 00/12] tcp: Refactor bhash2 and remove
 sk_bind2_node.
Message-ID: <20231218160121.34cf8a3c@kernel.org>
In-Reply-To: <20231213082029.35149-1-kuniyu@amazon.com>
References: <20231213082029.35149-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 17:20:17 +0900 Kuniyuki Iwashima wrote:
> This series refactors code around bhash2 and remove some bhash2-specific
> fields; sock.sk_bind2_node, and inet_timewait_sock.tw_bind2_node.
> 
>   patch 1      : optimise bind() for non-wildcard v4-mapped-v6 address
>   patch 2 -  4 : optimise bind() conflict tests
>   patch 5 - 12 : Link bhash2 to bhash and unlink sk from bhash2 to
>                  remove sk_bind2_node
> 
> The patch 8 will trigger a false-positive error by checkpatch.
> 
> After this series, bhash is a wrapper of bhash2:
> 
>   tb
>   `-> tb2 -> tb2 -> ...
>       `-> sk -> sk -> sk ....

Someone marked this series as Deferred in patchwork, could you repost?

