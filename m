Return-Path: <netdev+bounces-42530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB1B7CF31E
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F58281B1C
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 08:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51FD15AD2;
	Thu, 19 Oct 2023 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233063A1
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 08:46:14 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093DF136
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:46:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D77BB206D0;
	Thu, 19 Oct 2023 10:46:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1EQu7fvTyBy9; Thu, 19 Oct 2023 10:46:06 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 26D9F20539;
	Thu, 19 Oct 2023 10:46:06 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 1B2FE80004A;
	Thu, 19 Oct 2023 10:46:06 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 10:46:05 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 19 Oct
 2023 10:46:05 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 246D2318302F; Thu, 19 Oct 2023 10:46:05 +0200 (CEST)
Date: Thu, 19 Oct 2023 10:46:05 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, Raed Salem
	<raeds@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH xfrm-next 5/9] net/mlx5e: Unify esw and normal IPsec
 status table creation/destruction
Message-ID: <ZTDszYAuNv16bGBO@gauss3.secunet.de>
References: <cover.1697444728.git.leon@kernel.org>
 <d0bc0651c0d5f9afe79942577cf71e7d30859608.1697444728.git.leon@kernel.org>
 <ZS5WK8V0+JoTlNmu@gauss3.secunet.de>
 <20231017121357.GC5392@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231017121357.GC5392@unreal>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Oct 17, 2023 at 03:13:57PM +0300, Leon Romanovsky wrote:
> On Tue, Oct 17, 2023 at 11:38:51AM +0200, Steffen Klassert wrote:
> > On Mon, Oct 16, 2023 at 12:15:13PM +0300, Leon Romanovsky wrote:
> > > From: Patrisious Haddad <phaddad@nvidia.com>
> > > 
> > > Change normal IPsec flow to use the same creation/destruction functions
> > > for status flow table as that of ESW, which first of all refines the
> > > code to have less code duplication.
> > > 
> > > And more importantly, the ESW status table handles IPsec syndrome
> > > checks at steering by HW, which is more efficient than the previous
> > > behaviour we had where it was copied to WQE meta data and checked
> > > by the driver.
> > > 
> > > Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > 
> > This one does not apply to the ipsec-next tree.
> 
> You are right, sorry about that. It is based on two net-next series
> and I didn't expect such a fast response. 
> 
> 1. https://lore.kernel.org/netdev/20231002083832.19746-1-leon@kernel.org/ - accepted.
> 2. https://lore.kernel.org/netdev/20231014171908.290428-16-saeed@kernel.org/#t - not accepted yet.
> 
> Do you feel comfortable with the series/xfrm patches? If yes, Saeed can
> resend the series directly to net-next once patch #2 is accepted.

The xfrm changes look good and it does not conflict
to anything that is in ipsec-next currently. So
send it to net-next and I'll Ack it.

Thanks!

