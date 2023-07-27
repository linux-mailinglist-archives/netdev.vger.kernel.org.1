Return-Path: <netdev+bounces-21993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70000765913
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9074C2823CD
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8989B27137;
	Thu, 27 Jul 2023 16:46:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443A27124
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAC3C433C8;
	Thu, 27 Jul 2023 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690476401;
	bh=M2LZ36F+lMlPv7IbDxr9OkG0Nwl5lPobXvBwSQLLr24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dXwF4lEy0vQ59liIabwJF9pBaFgr5QDk5/GC+zw7rs4EJCG7qEGgXWuaahd+ypOzr
	 4rBjcSA++KtiZAWDRQnFzl99b36qAUG/2Q4Yi6Fs8bSOJQvn/97T5C6nb5zTpwM3rq
	 uNyoWmJwOChwe+ZlIU+pFwufZ2BBzhwFX56dybZCEhBDrjJtsX4Hp4zLc1o0FGCpFL
	 EZc1Vu330NUAMW9RbpL9Fd3A5rU2bR7k2oNlzzOmhK0a0dT4aBt23PSB2co6Tich94
	 +NzT+0DKKrPRUYxdimC2QG+5Cn3fqlqbUrBAvVEmPvhGLYNGsrnWk2nxzw1m0Kz5sF
	 XhO7vqDXVkDVw==
Date: Thu, 27 Jul 2023 09:46:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, leit@meta.com,
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] netconsole: Enable compile time configuration
Message-ID: <20230727094640.09c17f48@kernel.org>
In-Reply-To: <20230727163132.745099-1-leitao@debian.org>
References: <20230727163132.745099-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jul 2023 09:31:32 -0700 Breno Leitao wrote:
> +config NETCONSOLE_EXTENDED_LOG
> +	bool "Enable kernel extended message"
> +	depends on NETCONSOLE
> +	default n
> +	help
> +	  Enable extended log support for netconsole. Log messages are
> +	  transmitted with extended metadata header in the following format
> +	  which is the same as /dev/kmsg.
> +	  See <file:Documentation/networking/netconsole.rst> for details.
> +
> +config NETCONSOLE_APPEND_RELEASE
> +	bool "Enable kernel release version in the message"

We need to say the word "default" in a few places, to make it very
clear these are defaults.

I'll defer to others on whether this option makes sense, as I'm
probably too familiar with the problem you're solving to be impartial :S

Also the posting is pooped, the diff is listed twice.
Keep in mind the 24 grace period for netdev postings:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
-- 
pw-bot: cr

