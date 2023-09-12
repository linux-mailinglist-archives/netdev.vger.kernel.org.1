Return-Path: <netdev+bounces-33274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C2979D423
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF2C281C73
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C5118B07;
	Tue, 12 Sep 2023 14:56:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DADD179A0
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB720C433C8;
	Tue, 12 Sep 2023 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694530567;
	bh=K8MlBu2tU1IeOfUPJeKgOT829M9/JAbQwVa/5HOGa7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHwyoR/KHuF8M/96K6/mBaoqdzdWCNKwGozbJylH5sfG1xHJJMyVltAOFP2WPdru6
	 iEM0he1DYvlVAtYdTO1ySU9tG+DuwPctSK3YMmJGtN+eWpl18aD1bH5FQp7z+hBuLl
	 onR82wJRP9Cswf85ug2S4/HEDO3FK93b15yEnxLgpLY8GFLFYimwXAvUk2X1kUkVrN
	 IqMblGGSaT0BvAuk559BhrTBMR4Dt74UII20L8w0XS/nzHl7jSLa8BfGxqP59eHZPI
	 BMXDbdV9D1drHeyCZqb8/IoedhXo7I+dEp883mEZOc0sBYMZbgsPtGRmRrgE6b0JuL
	 CyZ/jJ/1UbCTA==
Date: Tue, 12 Sep 2023 16:56:03 +0200
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH net] ipv6: fix ip6_sock_set_addr_preferences() typo
Message-ID: <20230912145603.GF401982@kernel.org>
References: <20230911154213.713941-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911154213.713941-1-edumazet@google.com>

On Mon, Sep 11, 2023 at 03:42:13PM +0000, Eric Dumazet wrote:
> ip6_sock_set_addr_preferences() second argument should be an integer.
> 
> SUNRPC attempts to set IPV6_PREFER_SRC_PUBLIC were
> translated to IPV6_PREFER_SRC_TMP
> 
> Fixes: 18d5ad623275 ("ipv6: add ip6_sock_set_addr_preferences")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Simon Horman <horms@kernel.org>


