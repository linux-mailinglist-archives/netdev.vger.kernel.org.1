Return-Path: <netdev+bounces-50968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866FB7F8593
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 22:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47ABA2814E6
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 21:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27253BB41;
	Fri, 24 Nov 2023 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYj1IJst"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53DA364C8
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 21:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAF4C433C7;
	Fri, 24 Nov 2023 21:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700862313;
	bh=W0gOSulFjRpKuDgx7QfF+NEbvp3XDv65R2HNVz6cvS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYj1IJstkIcB3hQFKz1G6BybBXW91CeWPfIpHdcFPRtiDcierwodaiDvF+PW4F7Q0
	 IC52PuWvE0YwzL4YvFV2JiuFRVfr2S31cWrRFzOLOC5UYjOiwNnePrWzUzkkvibLWe
	 20fdQvMu7/9g6rUyVf689SWShyMPbXglx6Il8ju05PeBW8Bepf6rT4McOdbHMVX6DC
	 zJBdiMHN2bb9Aw+spr6R8Xv1rYL+cUej/m5La3NQJVMdgHKZ2mpWfmWSeLAu5SsWRJ
	 j8TvchBz1TFIsGfFiDLgrCNX798IUnxqCYRtp7M8Mu/Tvttw1ubR28r+EOy1ix7iNl
	 i9IWeB1hVjiuQ==
Date: Fri, 24 Nov 2023 21:45:09 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 3/8] tcp: Clean up goto labels in
 cookie_v[46]_check().
Message-ID: <20231124214509.GA50352@kernel.org>
References: <20231123012521.62841-1-kuniyu@amazon.com>
 <20231123012521.62841-4-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123012521.62841-4-kuniyu@amazon.com>

On Wed, Nov 22, 2023 at 05:25:16PM -0800, Kuniyuki Iwashima wrote:
> We will support arbitrary SYN Cookie with BPF, and then reqsk
> will be preallocated before cookie_v[46]_check().
> 
> Depending on how validation fails, we send RST or just drop skb.
> 
> To make the error handling easier, let's clean up goto labels.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


