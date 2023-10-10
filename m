Return-Path: <netdev+bounces-39395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8D67BEFE1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 02:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79002817B1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 00:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40D837F;
	Tue, 10 Oct 2023 00:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn5tjchb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95F9377
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AA1C433C9;
	Tue, 10 Oct 2023 00:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696898846;
	bh=U6LEJYuUeVc0ijopRiWP1lyH7WNEe7pADKgTe1SDe80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zn5tjchbfOIbLTsxVx9nsT5GsC1moZatY656JBJxwH77OnOe+vUCNNTWWB+GteyKZ
	 60thf5w+lh/S4firKUBP6mb+qCZq0DMHhRmxTcUr6h6ROVeFyxHbWiw6iHly+YlwQ7
	 Dd29A3803LA6/Yxlp3O7Kn2Yx2IZ+RmwSBGssyKvD51T+YjAOy3+n8k/JqyWxuJZl6
	 ymGQ+BBRDPMWGe20THjmdKcK2UOYgXUKACG511v3itsK0V0/foyYm7OnpqxXb+fbMB
	 0MgEiA6g8o3mpT8ruar9mzBGCru3gPpAHUy6nZs74wpGKMhGGH1NQxpqH816U1mduO
	 zIdUZMKkI62gw==
Date: Mon, 9 Oct 2023 17:47:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: netdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
 linux-wpan@vger.kernel.org, Michael Hennerich
 <michael.hennerich@analog.com>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, Doug Brown <doug@schmorgal.com>, Arnd
 Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/10] appletalk: remove localtalk and ppp support
Message-ID: <20231009174724.1e42b9ad@kernel.org>
In-Reply-To: <20231009141908.1767241-1-arnd@kernel.org>
References: <20231009141908.1767241-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Oct 2023 16:18:59 +0200 Arnd Bergmann wrote:
> The last localtalk driver is gone now, and ppp support was never fully
> merged, so clean up the appletalk code by removing the obvious dead
> code paths.
> 
> Notably, this removes one of the two callers of the old .ndo_do_ioctl()
> callback that was abused for getting device addresses and is now
> only used in the ieee802154 subsystem, which still uses the same trick.
> 
> The include/uapi/linux/if_ltalk.h header might still be required
> for building userspace programs, but I made sure that debian code
> search and the netatalk upstream have no references it it, so it
> should be fine to remove.

Looks like it depends on the ipddp driver removal.
Could you repost once that one is merged (~tomorrow)?
-- 
pw-bot: cr

