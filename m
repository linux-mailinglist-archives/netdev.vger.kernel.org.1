Return-Path: <netdev+bounces-53179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3853E80199A
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 02:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6791F21131
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 01:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D72EC3;
	Sat,  2 Dec 2023 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o83XZZG7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3717C0
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 01:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10020C433CA;
	Sat,  2 Dec 2023 01:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701481344;
	bh=keXwvYodk5CPjyK+JgfJBskzaK+jJ09/X6xc70sp0CE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o83XZZG7ukGwnjKgnJTtOQ2B2dXyllqlAVjmj07ve+L5TIQxsIyiVjJYmrO0iu1nI
	 3iX0Txswh/FpUCbOvI53SqA6tD716JI7xz7bl34v64wl6u15lRmHwhrI3vUStIsnnQ
	 UgFwRrRVz8NefAu3wN7iqv/ISXnCP2wAMhE5nJMOpcCB04l6wxXEW2xxG8YaPaMBgA
	 +658YUCVEM23YfJvfQX+egsIG3SooyCxA2w9siIu3VOUAiy63Q5q99flhTco57JB3e
	 ZhPINYDKt/SMx6JpAJn3xJQyDfuAPP2QqytKuIgmjQ6PjGClwEV3j3LvQ5AjgEAnDZ
	 FVGmVfTsZqb/g==
Date: Fri, 1 Dec 2023 17:42:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <brett.creeley@amd.com>, <drivers@pensando.io>
Subject: Re: [PATCH net 0/7] ionic: small driver fixes
Message-ID: <20231201174223.34c6ac58@kernel.org>
In-Reply-To: <20231201000519.13363-1-shannon.nelson@amd.com>
References: <20231201000519.13363-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 16:05:12 -0800 Shannon Nelson wrote:
> This is a collection of small fixes for the ionic driver,
> mostly code cleanup items.

Hm, looks cleanup-y indeed. Majority of this looks like net-next
material, really.

1 - fine for net
2 - perf optimization, we generally follow stable rules, which say:

   Serious issues as reported by a user of a distribution kernel may
   also be considered if they fix a notable performance or
   interactivity issue. As these fixes are not as obvious and have a
   higher risk of a subtle regression they should only be submitted by
   a distribution kernel maintainer and include an addendum linking to
   a bugzilla entry if it exists and additional information on the
   user-visible impact.

I doubt serious "user-visible impact" will be the case here, however.

3 - I don't see how this matters, netdev is not registered, locks are
    not initialized, who's going to access that pointer?
4 - cleanup / nop
5 - cleanup / nop
6 - fine for net
7 - optimization and a minor one at that

I appreciate the diligent Fixes tags but I'm afraid we need to be a bit
more judicious in what we consider a fix.
-- 
pw-bot: cr

