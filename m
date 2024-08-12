Return-Path: <netdev+bounces-117693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1094F94ED45
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0588281F96
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326B717B4E9;
	Mon, 12 Aug 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STjZT7/A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E4F148837;
	Mon, 12 Aug 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466637; cv=none; b=UBDC2SPcQyhA4ey0nqIIBFA4Kcd9bybGjbjPE6hFwsiW8me79QJF7iegXbdnFf5nFTbHctgwBdoKzPnx17UhE3lilxrv6CQLfeGRSMYKMHXSmhsWx7vHDnm4RZQbAnSexcR4sq2AVplw4/LpnOwDHXbnYhLO02m8DwiL3HGAwc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466637; c=relaxed/simple;
	bh=JgbF432Pmvij/pc9wq3llWqB9hFHm9hSuTcR5c7Ng2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwPF/QSE4XkQa27SLpLZKkCeCHz40pBC0c+WlbZTWo7wEimijVAUsS+4WDSCrmhaag53Kby/Pa9BqkLoihYMh6j3fps4HGR4Z4azvfJtb50CTCuB9a7sqf0Q6lgFGtPvDqagB4AdHwFjujuUYLB0F/ujdyRkBQLDADQzEhY1zZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STjZT7/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB47DC32782;
	Mon, 12 Aug 2024 12:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723466636;
	bh=JgbF432Pmvij/pc9wq3llWqB9hFHm9hSuTcR5c7Ng2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STjZT7/AiSoJOb96Itm0opcpfqr46dawL+QAUda6bxaIC/XKV4snmxO5voO4SpioA
	 11VqrwPO5UjnJZR1yogc84snIoe132w4wpY7RLVmWTy+lvt4raYLJ85B0V5DAmuy3P
	 HjfwcEJsqB0p8izKStLaaI10cIiw7o58G9oae60vAQ+D6PAxdYJL4JMHQohqNJax0z
	 lEf/Uf+xtPrw3/7L2UUnECe7+R4dD3GXedyj9v20sDjSKdSDba2cdhWHZi+2IeAyN4
	 mMlAbIz3oQaHCZiYsIpnifsLTbxkKyJRgFqUc/D/x3ewftpCQ1+/u9+XW2wo86dwfQ
	 4mmDwuLOZVvHg==
Date: Mon, 12 Aug 2024 13:42:24 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, vburru@marvell.com, sedara@marvell.com,
	srasheed@marvell.com, sburla@marvell.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: octeon_ep_vf: use ethtool_sprintf/puts
Message-ID: <20240812124224.GA7679@kernel.org>
References: <20240809044738.4347-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809044738.4347-1-rosenp@gmail.com>

On Thu, Aug 08, 2024 at 09:47:27PM -0700, Rosen Penev wrote:
> Simplifies the function and avoids manual pointer manipulation.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Thanks,

The code changes look good to me and my local testing shows that it compiles.
So, from that point of view:

Reviewed-by: Simon Horman <horms@kernel.org>

But I do have a few points about process, which I hope you will
give due consideration:

1. It would be good if the patch description was a bit more verbose.
   And indicated how you found this problem (by inspection?)
   and how it was tested (compile tested only?).

   This helps set expectations for reviewers of this patch,
   both now and in the future.

2. You have posed a number of similar patches.
   To aid review it would be best to group these, say in batches of
   no more than 10.

   F.e. Point 1, above, doesn't just apply to this patch.

3. Please do review the Networking subsystem process document

   https://docs.kernel.org/process/maintainer-netdev.html

...

