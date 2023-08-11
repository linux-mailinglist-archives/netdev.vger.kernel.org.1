Return-Path: <netdev+bounces-26690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A42778989
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3821C2120D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C755678;
	Fri, 11 Aug 2023 09:14:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83312566E
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF909C433C7;
	Fri, 11 Aug 2023 09:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691745296;
	bh=ymeofN/mQflkFKxsxeSW0AByntlJMVKRyAxL76P/EVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jT0KT0Qnk7yACQvD6fCIFku6GUhOzZNU6i0qn31cIyuTlbD0k+IHO3Wb30VR0N8C+
	 gn6w4pWojEy2moHYoiLfj/kKJrccenZAEisj079RuoNsgbdlMRLy4lFvw2t/SIaV2T
	 BNnkGNOdGqHwZvkw0wtZxUieNLfEl4WDd3guvcV+hjqA+d9R8xJUJ1zaDC1atuExGz
	 Rl5Vim4/K3Kfpj8w9WOCqKfYtchVG30RtDA+ZcgCeT9HOMjvwD1Yy+cKQ6Uw4TnFzz
	 szr3rQW166ypMPOrh6rzQOoSTL0oOZY/GksdpsllSyCZ3Xd7/8Nt+pC1Ffx//8JPG5
	 ydNQuYxKRxm5g==
Date: Fri, 11 Aug 2023 11:14:51 +0200
From: Simon Horman <horms@kernel.org>
To: GUO Zihua <guozihua@huawei.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH -next] hv_netvsc: Remove duplicated include
Message-ID: <ZNX8CyvnsP0zhmbA@vergenet.net>
References: <20230810115148.21332-1-guozihua@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810115148.21332-1-guozihua@huawei.com>

On Thu, Aug 10, 2023 at 07:51:48PM +0800, GUO Zihua wrote:
> Remove duplicated include of linux/slab.h.  Resolves checkincludes message.
> 
> Signed-off-by: GUO Zihua <guozihua@huawei.com>

The patch looks fine, but for reference, I do have some feedback
from a process point of view. It's probably not necessary to
repost because of these. But do keep them in mind if you have
to post a v2 for some other reason, and for future patch submissions.

* As a non bugfix for Networking code this should likely be targeted
  at the net-next tree - the net tree is used for bug fixes.
  And the target tree should be noted in the subject.

  Subject: [PATCH net-next] ...

* Please use the following command to generate the
  CC list for Networking patches

  ./scripts/get_maintainer.pl --git-min-percent 2 this.patch

  In this case, the following, now CCed, should be included:

  - Jakub Kicinski <kuba@kernel.org>
  - Eric Dumazet <edumazet@google.com>
  - "David S. Miller" <davem@davemloft.net>
  - Paolo Abeni <pabeni@redhat.com>

* Please do read the process guide

  https://kernel.org/doc/html/latest/process/maintainer-netdev.html

The above notwithstanding,

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/hyperv/rndis_filter.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
> index af95947a87c5..ecc2128ca9b7 100644
> --- a/drivers/net/hyperv/rndis_filter.c
> +++ b/drivers/net/hyperv/rndis_filter.c
> @@ -21,7 +21,6 @@
>  #include <linux/rtnetlink.h>
>  #include <linux/ucs2_string.h>
>  #include <linux/string.h>
> -#include <linux/slab.h>
>  
>  #include "hyperv_net.h"
>  #include "netvsc_trace.h"
> -- 
> 2.17.1
> 
> 

