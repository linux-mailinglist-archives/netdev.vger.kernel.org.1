Return-Path: <netdev+bounces-29121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE8A781A8A
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 18:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7031C2096D
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136B86FAA;
	Sat, 19 Aug 2023 16:34:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C208946BC
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 16:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70624C433C7;
	Sat, 19 Aug 2023 16:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692462869;
	bh=9KhxC5+qLl8U+3gWEQ1APAdBB43op+Pi5lFkyH+srxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIZBLoPwd47Fl66QBbNxQ2rbIICYZ7kcI8CxXJGx3a8XEvNZGNKJG2hdVttahbwo+
	 No+81EjB3YQS5D2lEuKIR/v9IassvV1JyQwxyyeFbLWV668b5A0HKLyse1vTmvP1o+
	 ByR1T/Oc7buGf3XlAGmJdT+0mnLU0ypEmxX1RsntAlUIHbSTvk4Yub/CagLUzkBlwG
	 Rldp+wT0Ky6QZKqNY8OOGqRzvaEHH0muj+n52++xD7GYgjYCXL/UExibguTsn070/W
	 o42dDzPjCMU6USH0A4DUMfJzjr4nBy1QyheDprs/p9kFn/7NYszOml6jsKt4ibeSBJ
	 2l5j9UQF7xwUQ==
Date: Sat, 19 Aug 2023 19:34:24 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Patrick Rohr <prohr@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2] net: release reference to inet6_dev pointer
Message-ID: <20230819163424.GS22185@unreal>
References: <20230818182249.3348910-1-prohr@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230818182249.3348910-1-prohr@google.com>

On Fri, Aug 18, 2023 at 11:22:49AM -0700, Patrick Rohr wrote:
> addrconf_prefix_rcv returned early without releasing the inet6_dev
> pointer when the PIO lifetime is less than accept_ra_min_lft.
> 
> Fixes: 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA lifetimes")
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Simon Horman <horms@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Maciej Żenczykowski <maze@google.com>
> Signed-off-by: Patrick Rohr <prohr@google.com>
> ---
>  net/ipv6/addrconf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

