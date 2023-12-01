Return-Path: <netdev+bounces-52857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0827580072B
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AC42816C0
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81F61CFAF;
	Fri,  1 Dec 2023 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INJJ73sg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB52C1CABC
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE77C433C7;
	Fri,  1 Dec 2023 09:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701423282;
	bh=duY4rqjDj4jk3Z0QvQbULKPZOaEZ8c5QBix8if1mUh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INJJ73sggfpIGEBv4txPLee3t55CdO1gUCPP8nZUvB/baDq8PjhtvRhJNwXE6IuJu
	 DiGn9jY5fnw9iE9O9dRG766iFnRBu/9EJ99VxZwImLNXHTQlJSgZktUr4fo75tcUbr
	 Us2QDkyFobV1eCZ41T+nx22LEq7/ft7s14Q/i00lKAwE1YGR8tvPcDHdghqMWMOfE4
	 mOfVF4mDz7CWlLeT+HCBb1/owLH/I4x446S9jOAFXOJYLQ/9r94Sp4dh24NSnj9AP8
	 lQt+nxnuKN/4qyL9XCKU1GnZys9SKWd+a1qP4qrGx9ImQzBR0eNmRomMOks4H2j+u7
	 LrhbFNJwkftng==
Date: Fri, 1 Dec 2023 09:34:36 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ivan Babrou <ivan@cloudflare.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 1/4] af_unix: Do not use atomic ops for
 unix_sk(sk)->inflight.
Message-ID: <20231201093436.GQ32077@kernel.org>
References: <20231123014747.66063-1-kuniyu@amazon.com>
 <20231123014747.66063-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123014747.66063-2-kuniyu@amazon.com>

On Wed, Nov 22, 2023 at 05:47:44PM -0800, Kuniyuki Iwashima wrote:
> When touching unix_sk(sk)->inflight, we are always under
> spin_lock(&unix_gc_lock).
> 
> Let's convert unix_sk(sk)->inflight to the normal unsigned long.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks Iwashima-san,

I agree with your analysis. This looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


