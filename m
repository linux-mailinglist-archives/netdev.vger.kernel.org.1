Return-Path: <netdev+bounces-43366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A157D2BD4
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 09:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF84B20CB4
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 07:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE8F10799;
	Mon, 23 Oct 2023 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGJNaUL2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D3B10794
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA428C433C9;
	Mon, 23 Oct 2023 07:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698047363;
	bh=Vi7PbFlCzKdEOfiRwN4AmNq9g5sBCASEmCpy+kAcYoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EGJNaUL2HtYILuUJB5b0GGEE5lTA+/plh4fOacyOlp922N8zhp1SUnBLVWRKHwj+g
	 fIebWhJ3ErwZQrpoZvC9zZLCO4yLutm9kY14Z3gAwrWuPf+SPxHwsz8lreWVENXZbK
	 Sb7dAr1mT9sJYD8XypQAGQV3IXsaF5cQZH2RUVRPIgxiXiVe+j5Q7buGJ+Wvfouutw
	 RENl513AAtGh+x5ARh4Y1cJ5kdxFBdiUBB7jtW9IG7bFL0HcdBqXoJh4JXVQKikX/U
	 XMCeK/bKH4bY9ttWYjeFeYqeunzbxrTvm4pzAUU8gKU8NaJDtvRWvtTzbGPiuylPaJ
	 mqa+/D60Y9WPg==
Date: Mon, 23 Oct 2023 08:49:18 +0100
From: Simon Horman <horms@kernel.org>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shakeel Butt <shakeelb@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] sock: Code cleanup on
 __sk_mem_raise_allocated()
Message-ID: <20231023074918.GT2100445@kernel.org>
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019120026.42215-1-wuyun.abel@bytedance.com>

On Thu, Oct 19, 2023 at 08:00:24PM +0800, Abel Wu wrote:
> Code cleanup for both better simplicity and readability.
> No functional change intended.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


