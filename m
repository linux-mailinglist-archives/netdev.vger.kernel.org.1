Return-Path: <netdev+bounces-43805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EC87D4D9E
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16C21C20AD0
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D6D2510E;
	Tue, 24 Oct 2023 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FDB1C3E
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:22:16 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60BCAC;
	Tue, 24 Oct 2023 03:22:14 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qvEXx-0007XI-Co; Tue, 24 Oct 2023 12:22:01 +0200
Date: Tue, 24 Oct 2023 12:22:01 +0200
From: Florian Westphal <fw@strlen.de>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Florian Westphal <fw@strlen.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexander H Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH v4 net-next 1/3] ipv6: drop feature RTAX_FEATURE_ALLFRAG
Message-ID: <20231024102201.GB2255@breakpoint.cc>
References: <cover.1698114636.git.yan@cloudflare.com>
 <a79fe77d7308f7e6de7a019f23a509b84cbacd79.1698114636.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79fe77d7308f7e6de7a019f23a509b84cbacd79.1698114636.git.yan@cloudflare.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Yan Zhai <yan@cloudflare.com> wrote:
>  #define IPCORK_OPT	1	/* ip-options has been held in ipcork.opt */
> -#define IPCORK_ALLFRAG	2	/* always fragment (for ipv6 for now) */
> +#define IPCORK_ALLFRAG	2	/* (unused) always fragment (for ipv6 for now) */

Nit: Why not remove the ALLFRAG define as well?

Otherwise the series looks good to me, thanks!

Reviewed-by: Florian Westphal <fw@strlen.de>


