Return-Path: <netdev+bounces-40913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5C97C91BD
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D799B20AB3
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4A1367;
	Sat, 14 Oct 2023 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcMBcBB5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05467E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6733C433C7;
	Sat, 14 Oct 2023 00:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697242634;
	bh=vLvOaEPuC1BYwKAmpu9Nz8KcUbjUhS1EcNVCw0Qexxs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tcMBcBB5FCHwKhA9dv9Ovo+nzv7iNSvxGgpV4RLj/xfH6Dc6IeE8xvyZDpaPKDt9l
	 KuwdfIU1UNuDoirqn45ByYsQIqP3x7XhlDWQxFzSGea8dwZjScPDhQ6qFg1sfd+WxU
	 /XtGBrRqDlLaYr5D6wFvZYJZI7Ff42UXNkOn2lCotsOYsMDzTGnJmHOFQQPJqmP9Mn
	 M95E7kOjkxfQya/m502KrF4vc6KntjsDYHaxrCxbJkIMY3VW+LDuMZv7nxhmAHpwpr
	 fMzLm9QWcnV/BCZ+1DjYls4SWwjU7ea4NlcVybyGvxYrMyw+kFb6fPOyTBhTdaDd4O
	 uk+sZAllHckXQ==
Date: Fri, 13 Oct 2023 17:17:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ma Ke <make_ruc2021@163.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tipc: Fix uninit-value access in
 tipc_nl_node_get_link()
Message-ID: <20231013171712.0817d810@kernel.org>
In-Reply-To: <20231013070408.1979343-1-make_ruc2021@163.com>
References: <20231013070408.1979343-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 15:04:08 +0800 Ma Ke wrote:
> Names must be null-terminated strings. If a name which is not 
> null-terminated is passed through netlink, strstr() and similar 
> functions can cause buffer overrun. This patch fixes this issue 
> by returning -EINVAL if a non-null-terminated name is passed.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

You have now sent 14 incorrect fixes to Linux networking. 
And not a single correct one.
I would like to politely ask you to stop.

