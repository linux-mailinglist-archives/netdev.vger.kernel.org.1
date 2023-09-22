Return-Path: <netdev+bounces-35862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4472F7AB693
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 18:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id F082828213E
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 16:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB25F41E3B;
	Fri, 22 Sep 2023 16:56:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC77741AA2
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 16:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CCCC433C8;
	Fri, 22 Sep 2023 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695401787;
	bh=/eTeTHTvssrg8z3yFsGI31ppa4ela1QgunAl0hsiLmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2JXk//FC1wY59KvmAXDd66soeGAR2wxpjkYppSP0VFKqj142qb1pwro5m22a8PQM
	 vWVGw3PdIB9Kk2bSQXnvt00d6ml4oBNckIbwVotXJhLeB0S40LCEgdIKoYsEJv0enQ
	 HGoPdUhXxPAc8ItOgjmCsarN5jCsSsizhElPAFtIjLwybMLpiwFtAHj59bSois5H36
	 jMEDtlZ0hFvdnpOvezgaYHapNN9oYYq7IPqeHNvSmTgRQQXMjKK7CqKmW4g7+cKzMG
	 2va37oG8s43O8+HDe2ouvBH5XYLY45OYv01ys5xcMN09xpRpzZB5QgojsTEM+hpdyd
	 KVZ1Beh3Owq+w==
Date: Fri, 22 Sep 2023 17:56:21 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 0/8] net: more data-races fixes and lockless
 socket options
Message-ID: <20230922165621.GA224399@kernel.org>
References: <20230921202818.2356959-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921202818.2356959-1-edumazet@google.com>

On Thu, Sep 21, 2023 at 08:28:10PM +0000, Eric Dumazet wrote:
> This is yet another round of data-races fixes,
> and lockless socket options.
> 
> Eric Dumazet (8):
>   net: implement lockless SO_PRIORITY
>   net: lockless SO_PASSCRED, SO_PASSPIDFD and SO_PASSSEC
>   net: lockless SO_{TYPE|PROTOCOL|DOMAIN|ERROR } setsockopt()
>   net: lockless implementation of SO_BUSY_POLL, SO_PREFER_BUSY_POLL,
>     SO_BUSY_POLL_BUDGET
>   net: implement lockless SO_MAX_PACING_RATE
>   net: lockless implementation of SO_TXREHASH
>   net: annotate data-races around sk->sk_tx_queue_mapping
>   net: annotate data-races around sk->sk_dst_pending_confirm

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


