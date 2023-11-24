Return-Path: <netdev+bounces-50969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAF77F8594
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 22:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06947B20BCF
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 21:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF73BB48;
	Fri, 24 Nov 2023 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOk1362D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57328DB8
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 21:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8228AC433C7;
	Fri, 24 Nov 2023 21:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700862330;
	bh=EkMaEQwUreFLQ1ELbQcllTRz1Kf4RhXGVucLS1M8ODI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOk1362Di7TKoE4i8u0WfCMtj+QlmaaKfMXiW7LC8ENAhCHvEXyYg+ip9sBCsqrLc
	 Vdi5mGAE3MSJ8W7CtNeF5DP1EYb9EPWBYUg6ELHKkZOe1UwmDhIlEAskMAT1W7K26Q
	 LoCIk+lbP5kAwLtU5bAz5ZOtbkb2tjvbVdW8qEme+lwJEtWK+wBpo/qhOOUSjTGeAV
	 61+mFkJDrTIjt8VODaRgVlS9ImiK5uO43cm1bsEAerVfSBiMzl/h/v/zdSnb0yb8+I
	 iQUziPG/Qq6Ol05w5mZNlJKdS3aSqIX3aLP8M53qwyGh1KbSFO9m5/DzafzH9X6uew
	 cUSFlHtQ/rPQQ==
Date: Fri, 24 Nov 2023 21:45:25 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 4/8] tcp: Don't pass cookie to
 __cookie_v[46]_check().
Message-ID: <20231124214525.GB50352@kernel.org>
References: <20231123012521.62841-1-kuniyu@amazon.com>
 <20231123012521.62841-5-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123012521.62841-5-kuniyu@amazon.com>

On Wed, Nov 22, 2023 at 05:25:17PM -0800, Kuniyuki Iwashima wrote:
> tcp_hdr(skb) and SYN Cookie are passed to __cookie_v[46]_check(), but
> none of the callers passes cookie other than ntohl(th->ack_seq) - 1.
> 
> Let's fetch it in __cookie_v[46]_check() instead of passing the cookie
> over and over.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


