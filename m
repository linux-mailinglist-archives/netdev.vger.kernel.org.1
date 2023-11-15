Return-Path: <netdev+bounces-47934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B791B7EBFCB
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DFA1C20840
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 09:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6269473;
	Wed, 15 Nov 2023 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3vYmZvm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8BA7E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A95C433C8;
	Wed, 15 Nov 2023 09:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700042223;
	bh=X+SZgUCx1sMXyCywi3z4zbmRNh7ncfzmnwHiCOqMrSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3vYmZvmlo9kWYUE+UTQIdjzmYB8cTaVF6Uc3R5O00L5xXRgahWEGk4m5Z5Z8Lsgi
	 GqCLFcdkz8VBmttzFNC3Re9iSYMRm+1IZM0XGCUqrZiWYbPUgr8XEazgoCUj9fgchv
	 UVL/TQKFNJxvjSu44e56JMR4B7yhFTGQuuDpAiU9cxlytSxNvHROAiSOH8Ai9GIZBB
	 0CGTDkGWVy+rBUwU4BwOpA2QtWhzgTEt7Ic+66c7Ihzs4oEsbrPnDivX9uBNGcW1Qk
	 ycP9uUjs9MSDk+Qa37xFPJZuaQ6ti4gvIlzPbH+9P9wmCd7SjhexSe5XosUwRFgPI4
	 RhGJmWbsNzmkw==
Date: Wed, 15 Nov 2023 09:56:59 +0000
From: Simon Horman <horms@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	Vlad Buslov <vladbu@nvidia.com>
Subject: Re: [PATCH net v2] net: Fix undefined behavior in netdev name
 allocation
Message-ID: <20231115095659.GM74656@kernel.org>
References: <20231114075618.1698547-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114075618.1698547-1-gal@nvidia.com>

On Tue, Nov 14, 2023 at 09:56:18AM +0200, Gal Pressman wrote:
> Cited commit removed the strscpy() call and kept the snprintf() only.
> 
> It is common to use 'dev->name' as the format string before a netdev is
> registered, this results in 'res' and 'name' pointers being equal.
> According to POSIX, if copying takes place between objects that overlap
> as a result of a call to sprintf() or snprintf(), the results are
> undefined.
> 
> Add back the strscpy() and use 'buf' as an intermediate buffer.
> 
> Fixes: 7ad17b04dc7b ("net: trust the bitmap in __dev_alloc_name()")
> Cc: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

