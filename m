Return-Path: <netdev+bounces-178352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6FDA76B25
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88EC37A2F90
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8732D214213;
	Mon, 31 Mar 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6zOPj1v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608AA213E91
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436133; cv=none; b=ZkTf1++MO6ZSpJh3hEwTZU/SgeHTayv+9pkHnFpzwPpvaNmuD+ZPrZOmXxI9NCIMiPV/iOn/49HIUWBUTiP7JxMiIPcNUyvXAcppIVxuYoDWfKlXapMQTTojjEuDH3BcDzpzcVTDRD8w70uUftT4+emYa5l3lbDvSQlfkjjR+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436133; c=relaxed/simple;
	bh=AX1kEEmrGWttNwZe0PZSd9Dx6AmZmTkWGZCru2n3Cds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5qo582D2Ux0kvS3vcdS+jtRtvrijUK/1pldDFmlxgB5vf6EtImBXvzsCISrfCe3fDJfaz9rOCjG6njfEhbYYfHda/PprzHli08FTTT7rX8HPjQtFVOvWvA3tuenuFJrTw+kF4K1wAitd92nZg8motm16J3yKlpst+r7/PsE4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6zOPj1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5325BC4CEE3;
	Mon, 31 Mar 2025 15:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743436132;
	bh=AX1kEEmrGWttNwZe0PZSd9Dx6AmZmTkWGZCru2n3Cds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6zOPj1vRNfXIV1oWLw92eNhqGCb80lpffwUG7LH1ltcMMoSp+/QzPB71M/zFNH/4
	 ZCyLI8U/FAucV0CsfEWU0dCL5Ox79YyA4iNy2WucJUiyXqsJ53p8c1aBgyhebfdaxF
	 YrP5n2JJJJi3P7OFnFQnWfFJCZgsfBoehUOGbDIK15btJtbDCG116Z44+Ywv/zHRbE
	 72Ba+i2QgBjMe2j42IH0VPTriz8QfvK8IkXs/lDFGvFL9pYqCw9B/agXPWADnF3+yI
	 xmMvRR9gJQ/7rd0WfdrVAbwmiI8JC4cg6TWnD7Gb44BBgIG2aciR57DFURSPMjV3Io
	 cUKCh4VhFQESA==
Date: Mon, 31 Mar 2025 16:48:49 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net] rtnetlink: Use register_pernet_subsys() in
 rtnl_net_debug_init().
Message-ID: <20250331154849.GC185681@horms.kernel.org>
References: <20250328220453.97138-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328220453.97138-1-kuniyu@amazon.com>

On Fri, Mar 28, 2025 at 03:04:48PM -0700, Kuniyuki Iwashima wrote:
> rtnl_net_debug_init() registers rtnl_net_debug_net_ops by
> register_pernet_device() but calls unregister_pernet_subsys()
> in case register_netdevice_notifier() fails.
> 
> It corrupts pernet_list because first_device is not updated
> in unregister_pernet_device().

Hi Iwashima-san,

Maybe I am confused, but should the above line refer to
unregister_pernet_subsys()?

And perhaps it would be yet clearer to say something like:

It corrupts pernet_list because first_device is not updated
in register_pernet_device() but not unregister_pernet_subsys()?

> 
> Let's fix it by calling register_pernet_subsys() instead.
> 
> The _subsys() one fits better for the use case because it keeps
> the notifier alive until default_device_exit_net(), giving it
> more chance to test NETDEV_UNREGISTER.
> 
> Fixes: 03fa53485659 ("rtnetlink: Add ASSERT_RTNL_NET() placeholder for netdev notifier.")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

...

