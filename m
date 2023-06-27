Return-Path: <netdev+bounces-14303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3442A7400B4
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 18:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2622810B5
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF9D19E46;
	Tue, 27 Jun 2023 16:18:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B55B18C3B
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 16:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6EEC433C0;
	Tue, 27 Jun 2023 16:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687882707;
	bh=XppdZpUuGPfDiV8/12odDlU2ubSnA32BV8wWtFnFFqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t57IfEl6+hTqjabvXA+7xzNJ5Ob89MhZc6R+CWuDOGQEcHoTc9pEc9+gNZaYkmgYP
	 P5EKcXLxr8vCzPkGLpSNmqscVfIXyi03ZUK8U+bi01/lewGKSxT5OZzKJKbozInkGs
	 UrlzdzA3dNHXTTTURoFGfxZyQ3xKel4PK8I29Eu4Dd8rySARubVrofsII3dgnIxHjj
	 r+6oHR+RIrOiMbsr0UmMyPibo4iKZrXU9v9j8y6lwyzOK4WYrUu3cBuQpwTWxbWpiT
	 876y9awkKG6cx4PYLqDt9ftXs/BUq0ikeij/JRBthkcy0JgAp9E7bAr41rK30oVuzG
	 htleCZFQ89Vtg==
Date: Tue, 27 Jun 2023 09:18:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, Xiubo Li
 <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>, Matthew Wilcox
 <willy@infradead.org>, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] libceph: Partially revert changes to
 support MSG_SPLICE_PAGES
Message-ID: <20230627091826.29d397f4@kernel.org>
In-Reply-To: <CAOi1vP-ogmcKE3brjEsm+zLvcXJa_5tGjv_XMsrnZuZUhXonhQ@mail.gmail.com>
References: <3199652.1687873788@warthog.procyon.org.uk>
	<20230627085928.6569353e@kernel.org>
	<CAOi1vP-ogmcKE3brjEsm+zLvcXJa_5tGjv_XMsrnZuZUhXonhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jun 2023 18:08:19 +0200 Ilya Dryomov wrote:
> This patch looks good to me.  I have been meaning to actually test
> it, but, if time is of the essence, I'm OK with it being merged via
> the networking tree now.
> 
> Reviewed-by: Ilya Dryomov <idryomov@gmail.com>

Thank you!!

