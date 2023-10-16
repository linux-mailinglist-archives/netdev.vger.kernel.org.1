Return-Path: <netdev+bounces-41216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C1A7CA41E
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA19281582
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7111C6AB;
	Mon, 16 Oct 2023 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBpJm/4s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E91A29A
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C881C433C7;
	Mon, 16 Oct 2023 09:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697448516;
	bh=6JVObMnC4svsaTvSG8K5uJD/aYfQg4KvX/i+ng9zLzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tBpJm/4sfi9pjqlEPxEwfuMGj9VpZ8GCNsqNmZnLYM2MX9jk1qfXPaH5jsagRjnVv
	 d94EeUHhfTrZ4wYMGj3cYtHMf2gvjTFFkU4RsPZu47pwFDZUbv1dmw7HfiumUUO/vl
	 3CYNbn6Tl9U33BORhE3diJDkYm9fpKEL8xtrP4FTX+lz3hGft2E5xnhKkAljt8X8r7
	 UMEI/0DuleO/IrXXW0p28inkbFVW3WH9zlWjfpqctGjbVQT1qQZj7klW1YTOpHuaPV
	 r6ZNqjYs1YPWCRXc7l8IGy08MD6ghpDaGuuN3ibMZh+o8vSBLKTxdAndnlook3eklG
	 YMnHl9017y8EQ==
Date: Mon, 16 Oct 2023 11:28:32 +0200
From: Simon Horman <horms@kernel.org>
To: Liansen Zhai <zhailiansen@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuwang@kuaishou.com,
	wushukun@kuaishou.com, Liansen Zhai <zhailiansen@kuaishou.com>
Subject: Re: [PATCH net-next,v2] cgroup, netclassid: on modifying netclassid
 in cgroup, only consider the main process.
Message-ID: <20231016092832.GI1501712@kernel.org>
References: <20231012090330.29636-1-zhailiansen@kuaishou.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012090330.29636-1-zhailiansen@kuaishou.com>

On Thu, Oct 12, 2023 at 05:03:30PM +0800, Liansen Zhai wrote:
> When modifying netclassid, the command("echo 0x100001 > net_cls.classid")
> will take more time on many threads of one process, because the process
> create many fds.
> for example, one process exists 28000 fds and 60000 threads, echo command
> will task 45 seconds.
> Now, we only consider the main process when exec "iterate_fd", and the
> time is about 52 milliseconds.
> 
> Signed-off-by: Liansen Zhai <zhailiansen@kuaishou.com>

Thanks for addressing my review of v1.

Reviewed-by: Simon Horman <horms@kernel.org>

