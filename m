Return-Path: <netdev+bounces-14804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 228E0743EF5
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 17:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084B01C20BE9
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 15:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1388316423;
	Fri, 30 Jun 2023 15:33:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B7416415
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 15:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B676C433C0;
	Fri, 30 Jun 2023 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688139212;
	bh=YY8/bCzFCPE57qh5AkwPDAgLNjakHgRTdvWZmqV57VA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N0pfFcCIgh98mjmTeDC+Ct7EH9/QWz0a+kmyDggfq2pot8qPAmQzP5NFMihIKxdZW
	 BWzVVCfZV9n0+Q8FueNNWgczPYTwZ01TrAKswY9PeEXrHy86UfpKgv+doXgRNLJMzS
	 oqPyBCbUATh78OKXk79CksnzhR0BSYGaypf+VqPlFARQdcv1c8JGGUhXmwWTzSz11+
	 unx+4qBkRBDfRHwUr8WOvI+BgUwEr7rJlwKU0Bk0mDCmYmwXKL14f/82GbSGaBjiKO
	 1n7OYVkddAp0S1B8L4B2rRNKbE97MUDTMtofMLeF6Sh7OuldwkNuIWRNyLel4rvpUe
	 eIK6zxP3sXBvQ==
Date: Fri, 30 Jun 2023 08:33:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, Aurelien
 Aptel <aaptel@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, Willem de
 Bruijn <willemb@google.com>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
 <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>, Matthew Wilcox
 <willy@infradead.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH net] nvme-tcp: Fix comma-related oops
Message-ID: <20230630083331.6e1527bd@kernel.org>
In-Reply-To: <ZJ7yyEiUWBTf8cCp@kbusch-mbp.dhcp.thefacebook.com>
References: <59062.1688075273@warthog.procyon.org.uk>
	<ZJ7yyEiUWBTf8cCp@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jun 2023 09:20:40 -0600 Keith Busch wrote:
> We don't have this breaking commit in the nvme tree just yet, so feel
> free to take the fix through net if this can't wait for the next nvme
> rebase (we're based on the block tree).

Ack, will do, thanks! We'll most likely send it in a PR later today.

