Return-Path: <netdev+bounces-12814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B501D739016
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC78281749
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD52E1B8F4;
	Wed, 21 Jun 2023 19:31:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A319E79
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED7AC433C0;
	Wed, 21 Jun 2023 19:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687375893;
	bh=aSUfMQ+z77ChqbqenDG0JSS6hcwr+vm4UXaeb8jHlQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jPdLqHqn54FUNrjYTKlMEhYzJ2+3WHygEcp/pUrvVCrm6TzKFKRnEfBnXscl5Tfqd
	 Bx+63S5vnrPzLODXe88YpmryxodiMFU9kZrGgbgmACzJs3mWRXuiw7n7V4jcqbyKkm
	 vjBo9u2m/KxD7S5gEsohpjaxj4gy5wdyeXTcO3JNN3PI0sLycmjATqbY5455tacJvq
	 HgXoQHkE18uqbc0qfadsJzUyARsKtBUvyZoYwZ2+mOgHhw+Ez3heqiFJANWoA1YLIF
	 +IoTejpDR8Ov9HzTLufaWzgvWjUBuX+85eTHAvNuLbLROMGzWwtPRbn9FApqsR3Jsg
	 1O1z+mT2SvLEw==
Date: Wed, 21 Jun 2023 12:31:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Boris Pismenny <boris.pismenny@gmail.com>
Subject: Re: [PATCH 4/4] net/tls: implement ->read_sock()
Message-ID: <20230621123132.2e0b487b@kernel.org>
In-Reply-To: <476d2cd9-ae32-a4e6-4549-52c3863d4049@grimberg.me>
References: <20230620102856.56074-1-hare@suse.de>
	<20230620102856.56074-5-hare@suse.de>
	<5bbb6ce4-a251-a357-3efc-9e899e470b9c@grimberg.me>
	<20230620100843.19569d60@kernel.org>
	<bae9a22a-246f-525e-d9a9-72a074d457c5@suse.de>
	<35f5f82c-0a25-37aa-e017-99e6739fa307@grimberg.me>
	<f8d789df-8ca7-9f9a-457d-4c87e2ca6d0a@suse.de>
	<476d2cd9-ae32-a4e6-4549-52c3863d4049@grimberg.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 12:49:21 +0300 Sagi Grimberg wrote:
> > Good suggestion.
> > Will be including it in the next round.  
> 
> Maybe more appropriate helper names would be
> tls_rx_reader_enter / tls_rx_reader_exit.
> 
> Whatever Jakub prefers...

I was thinking along the same lines but with __ in front of the names
of the factored out code. Your naming as suggested in the diff is
better.

