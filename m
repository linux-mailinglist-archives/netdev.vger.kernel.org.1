Return-Path: <netdev+bounces-20539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE0C75FFD8
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 21:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E051C20C1D
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFFD101E0;
	Mon, 24 Jul 2023 19:35:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEFE100CE
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 19:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA18C433C7;
	Mon, 24 Jul 2023 19:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690227348;
	bh=+3SNOt1+WZwJata7+r2bIJ7TFCvk4aRi9FuKIxNSs58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f/f7ORKUlKe81g7fI716ruYhgDBzhpBjZilLIqEUDahKxfHcQneQp6a5IoB0HMYAt
	 WxdZI1sNJZU7LJ6WLc+P7eGIUHJp+Clf+KGZAhcmKGkg/j7L8zyTJAy2A873bSOIgf
	 /XNiQiNpR1HCZKP5+R57LgYzAZo4Q9BnVNROa6OXzfbhBuBDGfdvluVV7NL0hMrzar
	 WEYmLDqJ/zj/mf+3J+AWj6K/PrJBjnaLEi0Z3+6HKzw/5LFsxoiUSk4py2F/5re29j
	 GdBo+d3QbiXgBIbN4BeyOD8pNhyomD+LENIA/iN+1RDhjcc+e1SdKouVfPh4vVfg5a
	 wWdX4f87RzhpA==
Date: Mon, 24 Jul 2023 12:35:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCHv8 0/6] net/tls: fixes for NVMe-over-TLS
Message-ID: <20230724123546.70775e77@kernel.org>
In-Reply-To: <9f37941c-b265-7f28-ebec-76c04804b684@grimberg.me>
References: <20230721143523.56906-1-hare@suse.de>
	<20230721190026.25d2f0a5@kernel.org>
	<3e83c1dd-99bd-4dbd-2f83-4008e7059cfa@suse.de>
	<9f37941c-b265-7f28-ebec-76c04804b684@grimberg.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jul 2023 10:21:52 +0300 Sagi Grimberg wrote:
> >> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> >>
> >> Sagi, I _think_ a stable branch with this should be doable,
> >> would you like one, or no rush?  
> > 
> > I guess a stable branch would not be too bad; I've got another
> > set of patches for the NVMe side, too.
> > Sagi?  
> 
> I don't think there is a real need for this to go to stable, nothing
> is using it. Perhaps the MSG_EOR patches can go to stable in case
> there is some userspace code that wants to rely on it.

I'm probably using the wrong word. I mean a branch based on -rc3 that's
not going to get rebased so the commits IDs match and we can both pull
it in. Not stable as in Greg KH.

