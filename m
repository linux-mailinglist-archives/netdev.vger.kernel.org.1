Return-Path: <netdev+bounces-41825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A127CBF94
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE451C20BD2
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A95C405DA;
	Tue, 17 Oct 2023 09:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6E03F4BA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:38:58 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B89ED
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:38:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 4DAD220078;
	Tue, 17 Oct 2023 11:38:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7gbORI_yoA8m; Tue, 17 Oct 2023 11:38:51 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E1A3F207CA;
	Tue, 17 Oct 2023 11:38:51 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id DCDEB80004A;
	Tue, 17 Oct 2023 11:38:51 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 11:38:51 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 17 Oct
 2023 11:38:51 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 1AC163182ABF; Tue, 17 Oct 2023 11:38:51 +0200 (CEST)
Date: Tue, 17 Oct 2023 11:38:51 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, Raed Salem
	<raeds@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH xfrm-next 5/9] net/mlx5e: Unify esw and normal IPsec
 status table creation/destruction
Message-ID: <ZS5WK8V0+JoTlNmu@gauss3.secunet.de>
References: <cover.1697444728.git.leon@kernel.org>
 <d0bc0651c0d5f9afe79942577cf71e7d30859608.1697444728.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d0bc0651c0d5f9afe79942577cf71e7d30859608.1697444728.git.leon@kernel.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 12:15:13PM +0300, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Change normal IPsec flow to use the same creation/destruction functions
> for status flow table as that of ESW, which first of all refines the
> code to have less code duplication.
> 
> And more importantly, the ESW status table handles IPsec syndrome
> checks at steering by HW, which is more efficient than the previous
> behaviour we had where it was copied to WQE meta data and checked
> by the driver.
> 
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

This one does not apply to the ipsec-next tree.

