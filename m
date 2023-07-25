Return-Path: <netdev+bounces-20642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDC0760527
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 04:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B526B281700
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 02:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3FF1852;
	Tue, 25 Jul 2023 02:21:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB967C
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 02:21:07 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11434CD
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 19:21:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D9EF0207D8;
	Tue, 25 Jul 2023 04:21:03 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Owl_UwH7-u7I; Tue, 25 Jul 2023 04:21:03 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6571C207C6;
	Tue, 25 Jul 2023 04:21:03 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 53FF880004A;
	Tue, 25 Jul 2023 04:21:03 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 04:21:03 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 04:21:02 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 473303183CE6; Tue, 25 Jul 2023 04:21:02 +0200 (CEST)
Date: Tue, 25 Jul 2023 04:21:02 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Simon Horman <simon.horman@corigine.com>, Ilia Lin
	<quic_ilial@quicinc.com>
Subject: Re: [PATCH net-next 4/4] xfrm: Support UDP encapsulation in packet
 offload mode
Message-ID: <ZL8xjo40TSPxnvLD@gauss3.secunet.de>
References: <cover.1689757619.git.leon@kernel.org>
 <051ea7f99b08e90bedb429123bf5e0a1ae0b0757.1689757619.git.leon@kernel.org>
 <20230724152256.32812a67@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230724152256.32812a67@kernel.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 03:22:56PM -0700, Jakub Kicinski wrote:
> On Wed, 19 Jul 2023 12:26:56 +0300 Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Since mlx5 supports UDP encapsulation in packet offload, change the XFRM
> > core to allow users to configure it.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Steffen, any opinion on this one? Would you like to take the whole series?

The xfrm changes are quite trivial compared to the driver changes.
So it will likely create less conflicts if you take it directly.

In case you want to do that:

Acked-by: Steffen Klassert <steffen.klassert@secunet.com>

Otherwise I can take it of course.

