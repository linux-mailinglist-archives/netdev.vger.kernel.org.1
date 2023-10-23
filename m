Return-Path: <netdev+bounces-43534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 835CF7D3CBD
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1639728159B
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21B55679;
	Mon, 23 Oct 2023 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdQaMRyn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DA5200CA
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7ABEC433CB;
	Mon, 23 Oct 2023 16:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698079119;
	bh=It2Eq6456oIB3m4HFRo0jRa19bilUVa2a5KypipIxeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EdQaMRyntLSGxldGG+JLEtEVXWKr/fwCPY111hx+aAe7OoXA/53XlzPmcQBs0VIXb
	 XzVrGgDZooB2U3W6zFr7aPM7dSguAvO6+aqhTGUiApFlRARiqx/sX1dM7rHHw2+VWL
	 Gs2DZ0lZmZIQERrqrOo/03HII1e5GG87XxDnkQwTk+B7JgWQ2aUS2DbdyHacgqWcR9
	 SgO0uPvjdAYfIOJFLD9y694G0xo7eSYHGOxezoHd7+QU5wrUZKkvgLKJCG/xbjIOpg
	 Jl8jaSoEGCePgYlRiAQbjZcRg8UIV7UXtxXEkDOgkzYKpp4Iqyw8V9YxrJ47srIdSV
	 oq5P3D8f/7ncA==
Date: Mon, 23 Oct 2023 09:38:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Networking <netdev@vger.kernel.org>, Loic Poulain
 <loic.poulain@linaro.org>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 1/2] MAINTAINERS: Move M Chetan Kumar to CREDITS
Message-ID: <20231023093837.49c7cb35@kernel.org>
In-Reply-To: <20231023032905.22515-3-bagasdotme@gmail.com>
References: <20231023032905.22515-2-bagasdotme@gmail.com>
	<20231023032905.22515-3-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 10:29:04 +0700 Bagas Sanjaya wrote:
>  M Chetan Kumar <m.chetan.kumar@linux.intel.com> (commit_signer:15/23=65%,authored:14/23=61%)

14 patches authored and 15 signed off?
Let me be more clear this time - nak, please drop this patch.
-- 
pw-bot: cr

