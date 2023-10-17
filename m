Return-Path: <netdev+bounces-41798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AA97CBE96
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D801C209B7
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABE13E49C;
	Tue, 17 Oct 2023 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M93MFRgo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7743D99D
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E005CC43395;
	Tue, 17 Oct 2023 09:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697533766;
	bh=0J00yBt6B+0GI95PaNrYuW82ColdTJxLKzN75HBOfTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M93MFRgowGo0xLvNH6mhY5IHz2AkL7yxlNmuE7f59h0T89aSwLaRh0fll8U2VvMMq
	 uYt3SmBdvdMxZKlHcPYonQHU/Lk7OQTer9zwjggGGYnijGlTHRRzgHKzu3ikmbjsuc
	 igoHi5ZtXAC/Dz1s0Irue5hYTRz+YBVW+/Otljrg7SV4207jGrwNcvu0rdLTOEkncr
	 OnAroEb0QT8ruQQ007OAEJQe05hskjvquJ1X7X2Llt7KGT/GkvGWmbBFJEz466qBQE
	 apkoWKiptypCbWpjR0rEg26YlOozMELZfxcFeRAlJJ3v0VrBCmXpClLfXUIy1kMkdb
	 63Cmh90bJvkdw==
Date: Tue, 17 Oct 2023 11:09:22 +0200
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	dev@openvswitch.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [ovs-dev] [PATCH v2 1/2] net: openvswitch: Use struct_size()
Message-ID: <20231017090922.GQ1751252@kernel.org>
References: <e5122b4ff878cbf3ed72653a395ad5c4da04dc1e.1697264974.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5122b4ff878cbf3ed72653a395ad5c4da04dc1e.1697264974.git.christophe.jaillet@wanadoo.fr>

On Sat, Oct 14, 2023 at 08:34:52AM +0200, Christophe JAILLET wrote:
> Use struct_size() instead of hand writing it.
> This is less verbose and more robust.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: No change
> 
> v1: https://lore.kernel.org/all/8be59c9e06fca8eff2f264abb4c2f74db0b19a9e.1696156198.git.christophe.jaillet@wanadoo.fr/
> 
> 
> This is IMHO more readable, even if not perfect.
> 
> However (untested):
> +	new = kzalloc(size_add(struct_size(new, masks, size),
> 			       size_mul(sizeof(u64), size)), GFP_KERNEL);
> looks completely unreadable to me.

Thanks, this looks correct (and more readable) to me.

Reviewed-by: Simon Horman <horms@kernel.org>

