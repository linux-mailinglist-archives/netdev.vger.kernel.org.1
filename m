Return-Path: <netdev+bounces-55174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7120809B22
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 05:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330121F210FF
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 04:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1BC15BE;
	Fri,  8 Dec 2023 04:47:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5D910C8
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 20:47:50 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rBSlz-008JH4-T5; Fri, 08 Dec 2023 12:47:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Dec 2023 12:47:45 +0800
Date: Fri, 8 Dec 2023 12:47:45 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
	tariqt@nvidia.com, jianbol@nvidia.com, leonro@nvidia.com
Subject: Re: [net V2 08/14] net/mlx5e: Check the number of elements before
 walk TC rhashtable
Message-ID: <ZXKf8f/hjw1K6Qyp@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205061327.44638-9-saeed@kernel.org>
X-Newsgroups: apana.lists.os.linux.netdev

Saeed Mahameed <saeed@kernel.org> wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> After IPSec TX tables are destroyed, the flow rules in TC rhashtable,
> which have the destination to IPSec, are restored to the original
> one, the uplink.
> 
> However, when the device is in switchdev mode and unload driver with
> IPSec rules configured, TC rhashtable cleanup is done before IPSec
> cleanup, which means tc_ht->tbl is already freed when walking TC
> rhashtable, in order to restore the destination. So add the checking
> before walking to avoid unexpected behavior.

I'm confused.  If the rhashtable has already been freed, then
surely you can't even read nelems?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

