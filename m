Return-Path: <netdev+bounces-18684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFD6758450
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F70B28162D
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C10716429;
	Tue, 18 Jul 2023 18:15:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE6A14A85
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 18:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4D9C433C8;
	Tue, 18 Jul 2023 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689704110;
	bh=QH0xYXdTL5ojivjEzeCT3IU9wzvatahM/LtkztuvSTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M2xJPN8NkR7qyXSRJpzqMsqZ0hj4ofVwtTavhx3nB43D9hiF17Jgg0vUBjoG6GOyZ
	 NHkodP8ygOWRSS9EcGASWagCYZyhTXUHuYsu/CHwV0wazaWRQoZmVa0kpq7LXp2KEo
	 28do4tKMH65/CCglk9STCpu4TQbBi/e0ydhVmLGH3TWi1Je5kii3sUONcHdZqYy8U0
	 8duXFGfRsHj7lNVAeSuuI6a3XqyZcESPQZSAS3CRKS7mCfin+89r6P8xdnFUriaByd
	 /8tmr35CcRgdRHefUBhC2OWYDewm1En+PQlBGS0Xnera7dOX1hV4Lo/tGRsDCtGUpg
	 Kr8fgqNGjuE0g==
Date: Tue, 18 Jul 2023 11:15:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mina Almasry <almasrymina@google.com>, Andy Lutomirski
 <luto@kernel.org>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, David Ahern
 <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC PATCH 00/10] Device Memory TCP
Message-ID: <20230718111508.6f0b9a83@kernel.org>
In-Reply-To: <ZLbUpdNYvyvkD27P@ziepe.ca>
References: <20230710223304.1174642-1-almasrymina@google.com>
	<12393cd2-4b09-4956-fff0-93ef3929ee37@kernel.org>
	<CAHS8izNPTwtk+zN7XYt-+ycpT+47LMcRrYXYh=suTXCZQ6-rVQ@mail.gmail.com>
	<ZLbUpdNYvyvkD27P@ziepe.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jul 2023 15:06:29 -0300 Jason Gunthorpe wrote:
> netlink feels like a weird API choice for that, in particular it would
> be really wrong to somehow bind the lifecycle of a netlink object to a
> process.

Netlink is the right API, life cycle of objects can be easily tied to
a netlink socket.

