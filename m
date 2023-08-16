Return-Path: <netdev+bounces-28028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347FB77E01E
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 13:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2475A1C20E99
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76AA101ED;
	Wed, 16 Aug 2023 11:16:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D4101C8
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 11:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E48C433C7;
	Wed, 16 Aug 2023 11:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692184611;
	bh=wfhySSnPK75SKJ9vyK9+QFR5+bImMQwF+/PIQmTua/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NI7KTXynb5crT3rAJwh9tudjya++J9+kamFqQjnVdxIWmv+inAgkrelMfl8d+Vg4U
	 KU5PNDU4WAmY24PvegTFeIysG1P5Av4P/WgCg+FOu384kbsN7M4w7FEH2MTNu9k4DO
	 P1RVMmI7lwqMXeZYwcGw7+bSh2fpVfy2K8Y8OvDraxNASkMGn+UYoYnMsoXflMwdKA
	 O1HUknXRSyp8upNJfiT0CJ542nONDCsz8oFucll8yfF68QFhw8+W5Pzvjtul7sHzWw
	 gFHQAk8LKUKLYmtQGFq6/SUKjAziJfDhEgw2xuj6HFg1SAX6WSvfjpQ2uh4oEduXqE
	 PrGbtWqgXM2Kw==
Date: Wed, 16 Aug 2023 13:16:46 +0200
From: Simon Horman <horms@kernel.org>
To: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org, coreteam@netfilter.org,
	bridge@lists.linux-foundation.org, gongruiqi1@huawei.com
Subject: Re: [PATCH net-next v2] netfilter: ebtables: replace zero-length
 array members
Message-ID: <ZNywHiWhaL6pRZsd@vergenet.net>
References: <20230816093443.1460204-1-gongruiqi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816093443.1460204-1-gongruiqi@huaweicloud.com>

On Wed, Aug 16, 2023 at 05:34:43PM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> As suggested by Kees[1], replace the old-style 0-element array members
> of multiple structs in ebtables.h with modern C99 flexible array.
> 
> [1]: https://lore.kernel.org/all/5E8E0F9C-EE3F-4B0D-B827-DC47397E2A4A@kernel.org/
> 
> Link: https://github.com/KSPP/linux/issues/21
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
> 
> v2: designate to net-next; cc more netdev maintainers

It's slightly unclear to me if this should be targeting
net-next or nf-next. But regardless, it doesn't seem
to apply cleanly to the main branch of either tree.

Please consider resolving that and posting again,
being sure to allow 24h before postings.

Link: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

-- 
pw-bot: changes-requested

