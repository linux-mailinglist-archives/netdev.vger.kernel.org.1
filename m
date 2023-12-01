Return-Path: <netdev+bounces-52989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79222801054
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095F8281D96
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B10541C97;
	Fri,  1 Dec 2023 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFXaGY9B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3FF25747
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 16:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD47FC433CB;
	Fri,  1 Dec 2023 16:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701448684;
	bh=zG8KDrkxIk2Q1ZblKRqr9Hql1q33q9BSOtjUFi5ffpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FFXaGY9B2zoCNjL94KAmLsxJpMdgMm//+W479QN6Imp2W7CuKSUmccbXjVWU1+1ad
	 d5amx110PunpiYozf8zxGhmjV/H/68gQrzTJSR13q6I5tjM5uGMOU3F2RpbKaZlP4o
	 xk1BYpfVIXKHCe9OFSLcANnK3Jk8qqJLqSv2BlO+33H9jyQijEritq8x/5KAY0DYHl
	 7J0+uy9oxNEMF0U3FY+9GNFlY3XWovEgMFzd9YCqEi1CJbbojMX4IZGGzavIIv4syZ
	 rQzPiJTJcqqPIOUUqceCbYXNXoZFO4f7ZgZ8eyiRr7LmBOH8m88ygWS8s16MJjmH11
	 rS1CIyjBnlWsg==
Date: Fri, 1 Dec 2023 08:38:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, corbet@lwn.net
Subject: Re: [patch net-next v2] docs: netlink: add NLMSG_DONE message
 format for doit actions
Message-ID: <20231201083803.0e9ccb6b@kernel.org>
In-Reply-To: <20231201153409.862397-1-jiri@resnulli.us>
References: <20231201153409.862397-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Dec 2023 16:34:09 +0100 Jiri Pirko wrote:
> +Note that some implementations may issue custom ``NLMSG_DONE`` messages
> +in reply to ``do`` action requests. In that case the payload is
> +implementation-specific and may also be avoided.

"avoided" does not read quite right here, perhaps a native speaker
will disagree, but I'd s/avoided/absent/
Feel free to skip the 24h wait if you agree

