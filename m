Return-Path: <netdev+bounces-25846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BFB775FB0
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECECF281894
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47537182D9;
	Wed,  9 Aug 2023 12:47:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D68BE0
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DA6C433C8;
	Wed,  9 Aug 2023 12:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691585276;
	bh=TmUP36KRvLCsPoh00aN7EEj9RbH9FI0r7T+FB+MCggo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CcGiEqraA37Qd1v2UfMWgPuV2tHZOBss60+3YC5TBGOXiuVpPuEmBnUcgZCd3bdLB
	 hMOUya8Pw3Hgx2w3cMTUPuV9bpDDyT978vGMe9mZ52ZETPcoNkHXIPlyOKqr9J1WMZ
	 ZcYO5dfWAeH5S9LirwDGGTYwdti/xew3/uANAPB8v2M8Ai8bBhprq6kMXQqyQXgrO6
	 I0oRfbqa4dNOJy1PRAIDF4DAaIOrYLiVLDOPGGwwqBEr9xFQ2fJZaXHpL+DuAfRRM1
	 +Dz7gVLokimE5Srw6DEY5d0hs/gjhA+LJBBnERQEYFToTKTGXOugIdp5W+Cet2kruK
	 reT7PKqfdCGaQ==
Date: Wed, 9 Aug 2023 14:47:52 +0200
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Ping Gan <jacky_gam_2001@163.com>, Manjusaka <me@manjusaka.me>
Subject: Re: [PATCH net] tcp: add missing family to tcp_set_ca_state()
 tracepoint
Message-ID: <ZNOK+MeUTXXOhD9S@vergenet.net>
References: <20230808084923.2239142-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808084923.2239142-1-edumazet@google.com>

On Tue, Aug 08, 2023 at 08:49:23AM +0000, Eric Dumazet wrote:
> Before this code is copied, add the missing family, as we did in
> commit 3dd344ea84e1 ("net: tracepoint: exposing sk_family in all tcp:tracepoints")
> 
> Fixes: 15fcdf6ae116 ("tcp: Add tracepoint for tcp_set_ca_state")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Ping Gan <jacky_gam_2001@163.com>
> Cc: Manjusaka <me@manjusaka.me>

Reviewed-by: Simon Horman <horms@kernel.org>


