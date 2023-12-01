Return-Path: <netdev+bounces-52859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6C9800733
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C654B20E4D
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969561D559;
	Fri,  1 Dec 2023 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu5iKudz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0FC1BDC4
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D195FC433C9;
	Fri,  1 Dec 2023 09:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701423365;
	bh=6VwLitIGltbQw4jzJkLbc6ew9y/ZCWEoMWkK42cbYVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hu5iKudzi46aoSLjLExHyDKl75hTgV3jEnqIuuoxtVX7HUSYDdCaf/hWQz6jmKtzC
	 8oQ+BBOaxFCryH1XaGVjWTtTaePNEm74r9JRjvcIhZqN1lksvj/BSCLg0ASCVo60+K
	 oflJ0USlLt9HZ78CVdnK4IWVb/J1vEUF9LccMzMu/BCUZG2DmC5L20HZkDwt3U3DiO
	 RvHB6sbWX5UWkpxVP+eK/F8GbivOhrgc7JDKpw8CksBotCmb8sQm/u44EknDy06snP
	 x5oByZPJwwjSm3YpL3kXIwRZPMzQx549tBpb9wfGMfIreXFhLe4aPmi75zxPy6+2Dw
	 vagfjGWLUlF9w==
Date: Fri, 1 Dec 2023 09:35:58 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ivan Babrou <ivan@cloudflare.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/4] af_unix: Return struct unix_sock from
 unix_get_socket().
Message-ID: <20231201093558.GR32077@kernel.org>
References: <20231123014747.66063-1-kuniyu@amazon.com>
 <20231123014747.66063-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123014747.66063-3-kuniyu@amazon.com>

On Wed, Nov 22, 2023 at 05:47:45PM -0800, Kuniyuki Iwashima wrote:
> Currently, unix_get_socket() returns struct sock, but after calling
> it, we always cast it to unix_sk().
> 
> Let's return struct unix_sock from unix_get_socket().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks Iwashima-san,

this looks like a nice clean-up to me.

Reviewed-by: Simon Horman <horms@kernel.org>


