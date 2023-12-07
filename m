Return-Path: <netdev+bounces-55012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0C18092E2
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 22:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0701F20FE2
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D321F4F8B5;
	Thu,  7 Dec 2023 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QibC/3d0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B338C4F8A8
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 21:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7ADC433C8;
	Thu,  7 Dec 2023 20:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701982802;
	bh=WngsTC3WrtSoVu+SNUKTyQTquv6b6nCOOxtyRjZcQUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QibC/3d05hHmYkX1Jz7cRepb48hT+nxuEF8Tc6YNUvxJ84NrHVGRiCQeuBxxqZeVm
	 SHeU9JCpRwyJ8h5pAwdr29OCfBxBbKVbKcM0nuAzoS4+GTkVTe7Pm+Wb6CeHNMMe4h
	 8UcKlwKdewK0LvFdKIewBBxjNQWOYm0r5YjTZDQtInBidqo9d4TJzTG2yRBVYECxtj
	 y0Ib2P/vAGUHMtfhm5j55e8vBJc/QWBOsWVhTJWgJh4T6JOm5erdQPiepn6RK5FJQL
	 Wwvq00KWbFuXqmj8HqwNn3wp1XnRZl8FAyjOpTtQz0KvXxVEB0xTkX0cEntp99Ne1K
	 kcZX4K7d4+B2w==
Date: Thu, 7 Dec 2023 20:59:56 +0000
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us,
	marcelo.leitner@gmail.com, vladbu@nvidia.com,
	Jiri Pirko <jiri@nvidia.com>, Victor Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH net-next v3 1/5] rtnl: add helper to check if rtnl group
 has listeners
Message-ID: <20231207205956.GJ50400@kernel.org>
References: <20231206164416.543503-1-pctammela@mojatatu.com>
 <20231206164416.543503-2-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206164416.543503-2-pctammela@mojatatu.com>

On Wed, Dec 06, 2023 at 01:44:12PM -0300, Pedro Tammela wrote:
> From: Jamal Hadi Salim <jhs@mojatatu.com>
> 
> As of today, rtnl code creates a new skb and unconditionally fills and
> broadcasts it to the relevant group. For most operations this is okay
> and doesn't waste resources in general.
> 
> When operations are done without the rtnl_lock, as in tc-flower, such
> skb allocation, message fill and no-op broadcasting can happen in all
> cores of the system, which contributes to system pressure and wastes
> precious cpu cycles when no one will receive the built message.
> 
> Introduce this helper so rtnetlink operations can simply check if someone
> is listening and then proceed if necessary.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>


