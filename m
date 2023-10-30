Return-Path: <netdev+bounces-45158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4A57DB35C
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 07:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6411C209F9
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 06:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AA36116;
	Mon, 30 Oct 2023 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCxBo5/X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C686E611E;
	Mon, 30 Oct 2023 06:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14C9C433C7;
	Mon, 30 Oct 2023 06:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698647569;
	bh=uS06Ju+9wQb63NgRCk5gVWNfgyaCuxPX5b/orf5IjmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dCxBo5/Xa+NR+4PuGzSnGslLviQ8+mEi+dfnLv7k4/E9Ri+6a3bd9QleAbB7U+G+D
	 2y3JjB44cT27EAp0Tx4XLhvD9u04SIQLVjwIcUOnZIybPaWC3IKr5pT0NsVL/AVVF5
	 jaEg6QMxLr7R8qRiBxZpeR3REZaWKLHj+HV1FqxyJD0wjAcp3g6A6iFQKvi/mAnz3Z
	 NyD69S9Gbd3q7uvKLv5cerZK0jPYgyRb2hz1CxEY+//yv+XUEsyrsRloWHsudO7hRC
	 6nbo5OHBava38kh1ktcTkDSydx82Jvy1cPE+fUYBAkV1rYZvcphTRhFDfrlxSyzwNR
	 A5+gfksBg245Q==
Date: Sun, 29 Oct 2023 23:32:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, Geliang
 Tang <geliang.tang@suse.com>
Subject: Re: [PATCH net-next 00/15] mptcp: More selftest coverage and code
 cleanup for net-next
Message-ID: <20231029233247.51cd95aa@kernel.org>
In-Reply-To: <20231027-send-net-next-2023107-v1-0-03eff9452957@kernel.org>
References: <20231027-send-net-next-2023107-v1-0-03eff9452957@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 15:57:01 -0700 Mat Martineau wrote:
> Patches 1-5 and 7-8 add selftest coverage (and an associated subflow
> counter in the kernel) to validate the recently-updated handling of
> subflows with ID 0.
> 
> Patch 6 renames a label in the userspace path manager for clarity.
> 
> Patches 9-11 and 13-15 factor out common selftest code by moving certain
> functions to mptcp_lib.sh
> 
> Patch 12 makes sure the random data file generated for selftest
> payloads has the intended size.

I was finalizing the PR already when you posted, sorry :(


## Form letter - net-next-closed

The merge window for v6.7 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Nov 12th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

