Return-Path: <netdev+bounces-26509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D34E777FB7
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370E12814F3
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC2D21514;
	Thu, 10 Aug 2023 17:59:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE320FBF
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E22C433C7;
	Thu, 10 Aug 2023 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691690383;
	bh=zMZBAlIYuXts1JWarKGJe9B8Z9TCqF4od1Y1jiyno/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BF5r4c4gIvQFQi5eUZ708LH7BFjr3WyT+hyC1REdcPPuTAW7OBAXNiU+0dZRyfWYY
	 iGlOJcRModXhO9DfwIHXq139mTNMhZfD88YUCcuPd5lN3d6ZZ6h/cgHWpwyI6P5sPG
	 opRssifeP7s6KjRaSh7ZQUbMBtpyDAWe+c2H/K9Pah/N7JUleVIzbyqlRmnBo72X+t
	 iFwsfM/dlZIryHHh8/K/O+TEeatLGt72ib6xLEe4h7/cVfMbbWMENJWlMZ7Q7Wn0NU
	 fQ93VyfrtlsLo62E4d0teVy0ONmlL+sLJvGX93xEVtNpoUcfpiyTQAWZCpnAQu7uts
	 U3zEIQ0FlFkMQ==
Date: Thu, 10 Aug 2023 10:59:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
 <lcherian@marvell.com>, <gakula@marvell.com>, <jerinj@marvell.com>,
 <hkelam@marvell.com>, <sbhatta@marvell.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net] octeontx2-pf: Set page pool size
Message-ID: <20230810105942.2bf835a6@kernel.org>
In-Reply-To: <5e481c98-bf82-283f-e826-82802a2bd7d6@intel.com>
References: <20230810024422.1781312-1-rkannoth@marvell.com>
	<5e481c98-bf82-283f-e826-82802a2bd7d6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 19:09:21 +0200 Alexander Lobakin wrote:
> And if the ring size is e.g. 256 or 512 or even 1024, why have Page Pool
> with 2048 elements? Should be something like
> 
> min(numptrs, OTX2_PAGE_POOL_MAX_SZ)

And someone needs to tell me why the 2k was chosen as a value that
uniquely fits this device but not other devices..
-- 
pw-bot: cr

