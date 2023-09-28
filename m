Return-Path: <netdev+bounces-36726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5F27B17D6
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 11:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 43F5E281A2B
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 09:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDED1D68A;
	Thu, 28 Sep 2023 09:51:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E73217C6
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 09:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB97C433C8;
	Thu, 28 Sep 2023 09:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695894685;
	bh=cSDK+UH2nr0GMiVRWIpaakkw5si/jCZFr2FE2PgYopQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxmkfzbSA9rWkkV7y1pH8ttaXkDEb3qcaPrCrO5FyOub/Fc5PrNUTEvws/N2GTHhu
	 Uf7MzEmwKone+bIR9v1q3YbGvBkZKbvIOEUSNZKNkhEZ7y/cx20vufw4WuxWGuxIrD
	 1UosEyYmUQ0SdmXXKeePFt0AqECR8ONEvD8rh9Aq5ayaqddPI8gDp8il9mFbIHIe9F
	 J01BCAkwzpo/fZAfqEKPJ72Gv/YmpW8lKlKnvATGsogNAkPZVhNCxYTVmHMGkYPM9I
	 8+TYLCpYuqSnsMPfpnXUCZkAMDbKWHgxXyhlwBmq1BS7VS9FK3cwlj/b6MPEvej5zD
	 NGyn4MJyGAEsw==
Date: Thu, 28 Sep 2023 12:51:19 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dust Li <dust.li@linux.alibaba.com>
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
Message-ID: <20230928095119.GR1642130@unreal>
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
 <20230927034209.GE92403@linux.alibaba.com>
 <20230927055528.GP1642130@unreal>
 <20230927121740.GF92403@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927121740.GF92403@linux.alibaba.com>

On Wed, Sep 27, 2023 at 08:17:40PM +0800, Dust Li wrote:
> On Wed, Sep 27, 2023 at 08:55:28AM +0300, Leon Romanovsky wrote:
> >On Wed, Sep 27, 2023 at 11:42:09AM +0800, Dust Li wrote:
> >> On Mon, Sep 25, 2023 at 10:35:45AM +0800, Albert Huang wrote:
> >> >If the netdevice is within a container and communicates externally
> >> >through network technologies like VXLAN, we won't be able to find
> >> >routing information in the init_net namespace. To address this issue,
> >> 
> >> Thanks for your founding !
> >> 
> >> I think this is a more generic problem, but not just related to VXLAN ?
> >> If we use SMC-R v2 and the netdevice is in a net namespace which is not
> >> init_net, we should always fail, right ? If so, I'd prefer this to be a bugfix.
> >
> >BTW, does this patch take into account net namespace of ib_device?
> 
> I think this patch is irrelevant with the netns of ib_device.
> 
> SMC has a global smc_ib_devices list reported by ib_client, and checked
> the netns using rdma_dev_access_netns. So I think we should have handled
> that well.

ok, I see

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

