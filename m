Return-Path: <netdev+bounces-192998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEA7AC2133
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 12:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6AB8A243D5
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FF6225A3D;
	Fri, 23 May 2025 10:36:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5018C189919
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747996569; cv=none; b=r0zMtd6Hg7LTM7Q4vXQsauqKIbNJvUfe8u1zFy68st9aY8hJVjg7/Nl38Ymjpn1sZKnHgJhGJI4pTwjkAQEdO+2oBC5L+0DAg5McPDyieoNSQEh1MoCUWN7KlFsxoIYKy7AJUYvbccZ02ySybvVfmf8ZM7iv3C8IUvnCzBOiJpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747996569; c=relaxed/simple;
	bh=8LABh7d/XgbnWK7z2l+q+6ShePWtn6lWb7kmZicD2z4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBLvyKSaHhli6HO4qoFiGs+59HUt6BgRgw/DtRxlwKHM0V1g1bHtPEL0lDdgjhigXl7X1jsRJkWLcr7rtMZymY5jyBLw6hf5ZfXoSP2smvc85/1+NBpB38fHVOVDp6hemDOPPzdbZXHUHT5LaAcBSi/7ts9PGt4KCQh6X6pn7bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 46E1F208A2;
	Fri, 23 May 2025 12:36:04 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ksjesTj4NRZ; Fri, 23 May 2025 12:36:03 +0200 (CEST)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B83BA2082E;
	Fri, 23 May 2025 12:36:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B83BA2082E
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 23 May
 2025 12:36:03 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 12:36:03 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id DC7B131818E9; Fri, 23 May 2025 12:36:02 +0200 (CEST)
Date: Fri, 23 May 2025 12:36:02 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/12] pull request (net-next): ipsec-next 2025-05-23
Message-ID: <aDBPkpKv+x7YFDWJ@gauss3.secunet.de>
References: <20250523075611.3723340-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250523075611.3723340-1-steffen.klassert@secunet.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Fri, May 23, 2025 at 09:55:59AM +0200, Steffen Klassert wrote:
> 1) Remove some unnecessary strscpy_pad() size arguments.
>    From Thorsten Blum.
> 
> 2) Correct use of xso.real_dev on bonding offloads.
>    Patchset from Cosmin Ratiu.
> 
> 3) Add hardware offload configuration to XFRM_MSG_MIGRATE.
>    From Chiachang Wang.
> 
> 4) Refactor migration setup during cloning. This was
>    done after the clone was created. Now it is done
>    in the cloning function itself.
>    From Chiachang Wang.
> 
> 5) Validate assignment of maximal possible SEQ number.
>    Prevent from setting to the maximum sequrnce number
>    as this would cause for traffic drop.
>    From Leon Romanovsky.
> 
> 6) Prevent configuration of interface index when offload
>    is used. Hardware can't handle this case.i
>    From Leon Romanovsky.
> 
> 7) Always use kfree_sensitive() for SA secret zeroization.
>    From Zilin Guan.
> 
> Please pull or let me know if there are problems.
> 
> Thanks!

I forgot to mention a merge conflict between

 fd5ef5203ce6 ("ixgbe: wrap netdev_priv() usage")

from the net-next tree and commit:

  43eca05b6a3b ("xfrm: Add explicit dev to .xdo_dev_state_{add,delete,free}")

from the ipsec-next tree.

It can be solved as done in linux-next.

Thanks!

