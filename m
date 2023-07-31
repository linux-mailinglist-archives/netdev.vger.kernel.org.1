Return-Path: <netdev+bounces-22939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBA776A1DC
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 22:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4881C20C9A
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6254B1DDEB;
	Mon, 31 Jul 2023 20:29:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B918C3F
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 20:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C78C433C8;
	Mon, 31 Jul 2023 20:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690835353;
	bh=1W+yj8GA7t3f/BHbqf0FlcfwLBIVeALa4X1YrguXOfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FRdLkUectUj54VaOCwx01vdSQwIn5YQEC7xmdVacvmnQN9+5UkO5BWg2HBwQo6k28
	 MOmd8Nr/1ulfY7XhEPT1K5CEzwkqax+C1MKbyD/k5ny/Tsi9X96NCCMVzAXLmiVAC4
	 kDC5VQyHYHP/Jve3PrCGrY+gWIPGevYiQfZ2U9/2h9nfQj1TZdDuA3UgrPdLgyKzmA
	 BIIPkbCG/mM0yGRpM2qLms/R9BIPL+PHP+iXw/0z4hpVcFdVWLv5mf2zf6uWZTSEYv
	 e90V1Bv0KcrLzJ18d6Vy+GwbgXfdCre1o2HzHGRcL4O3Ut6XaP2P/6i6wj8KtoVm4G
	 NB0UtwLUzTzIw==
Date: Mon, 31 Jul 2023 13:29:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@idosch.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCHv4 net] ipv6: do not match device when remove source
 route
Message-ID: <20230731132911.19e4569e@kernel.org>
In-Reply-To: <20230725102137.299305-1-liuhangbin@gmail.com>
References: <20230725102137.299305-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 18:21:37 +0800 Hangbin Liu wrote:
> After deleting an IPv6 address on an interface and cleaning up the
> related preferred source entries, it is important to ensure that all
> routes associated with the deleted address are properly cleared. The
> current implementation of rt6_remove_prefsrc() only checks the preferred
> source addresses bound to the current device. However, there may be
> routes that are bound to other devices but still utilize the same
> preferred source address.

David, Ido, where do you stand on this patch? The discussion on v3
continued after this was posted and we got no review tags...

