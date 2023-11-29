Return-Path: <netdev+bounces-52148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA627FD95D
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53975B21333
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760D6315B3;
	Wed, 29 Nov 2023 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3O7voHE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1863159F
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 14:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382C7C433C9;
	Wed, 29 Nov 2023 14:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701268155;
	bh=TeXzHb7rxKXQGXucrw/Ty/eqYEy5dqm0uu/JKO7RDCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i3O7voHEX9nwvQnJXx+x/l0uWqkVQvdAG5q4p3bznL6GqphqcrWs3xFHrQ8QI/oPi
	 lNmWjgwa9JSdXyIuoBuXqerZJuECGpkCKl+ZH+M4+4WdrDS6HtsTg176EV4ShNUCW5
	 74vO/32ri773Hg8T1+F7X62xkD1hHHTvOHaVEMEz+B5Pu2Lc94AamDXFejMn5DgGVK
	 74kTTH2DyszHJFugM9TQ9/a5NIFzY+8wnrbrtwAXkgCspTtViqeF+Mf1HxL2Bs4rzi
	 K1XKEAxa6HRKtIqP31DRapZ0z0qUqTCdIRHAVe/eJoY6N8ZxHzb/zX810zld/zkWC3
	 feN0/SCLMbyRw==
Date: Wed, 29 Nov 2023 06:29:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Alexander Duyck
 <alexanderduyck@fb.com>, Yunsheng Lin <linyunsheng@huawei.com>, "David
 Christensen" <drc@linux.vnet.ibm.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Paul
 Menzel" <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 13/14] libie: add per-queue Page Pool stats
Message-ID: <20231129062914.0f895d1c@kernel.org>
In-Reply-To: <e43fc483-3d9c-4ca0-a976-f89226266112@intel.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
	<20231124154732.1623518-14-aleksander.lobakin@intel.com>
	<e43fc483-3d9c-4ca0-a976-f89226266112@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 14:40:33 +0100 Alexander Lobakin wrote:
> > Expand the libie generic per-queue stats with the generic Page Pool
> > stats provided by the API itself, when CONFIG_PAGE_POOL_STATS is
> > enabled. When it's not, there'll be no such fields in the stats
> > structure, so no space wasted.  
> 
> Do I get it correctly that after Page Pool Netlink introspection was
> merged, this commit makes no sense and we shouln't add PP stats to the
> drivers private ones?

Yes, 100%.

FWIW I am aware that better tooling would be good so non-developers
could access to the PP Netlink :(  I'm thinking we should clean up 
YNL lib packaging a little and try to convince iproute2 maintainers 
to accept simple CLI built on top of it.

