Return-Path: <netdev+bounces-36975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF06E7B2C35
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 08:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 039791C20968
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 06:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428A88C17;
	Fri, 29 Sep 2023 06:12:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E938C13
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 06:12:26 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9AF92
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 23:12:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 4DFC8208B0;
	Fri, 29 Sep 2023 08:12:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ucTzWLStxeh; Fri, 29 Sep 2023 08:12:22 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1875B207D1;
	Fri, 29 Sep 2023 08:12:22 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 151C280004A;
	Fri, 29 Sep 2023 08:12:22 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 08:12:21 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 29 Sep
 2023 08:12:21 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 292483182A8E; Fri, 29 Sep 2023 08:12:21 +0200 (CEST)
Date: Fri, 29 Sep 2023 08:12:21 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Eyal Birger
	<eyal.birger@gmail.com>, Eric Dumazet <edumazet@google.com>,
	<devel@linux-ipsec.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v6 ipsec-next 1/3] xfrm: Use the XFRM_GRO to indicate a
 GRO call on input
Message-ID: <ZRZqxbLhQvxuzlYA@gauss3.secunet.de>
References: <6dfd03c5fa0afb99f255f4a35772df19e33880db.1674156645.git.antony.antony@secunet.com>
 <cover.1695722426.git.antony.antony@secunet.com>
 <fe62776017f4f4af6f15adef66acb64081735734.1695722426.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fe62776017f4f4af6f15adef66acb64081735734.1695722426.git.antony.antony@secunet.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 12:15:03PM +0200, Antony Antony wrote:
> From: Steffen Klassert <steffen.klassert@secunet.com>
> 
> This is needed to support GRO for ESP in UDP encapsulation.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> Co-developed-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Antony Antony <antony.antony@secunet.com>

Thanks for picking up that pachset!

Please provide a bit more information what we are doing
with that patch in the commit message. Otherwise the
patchset looks OK and is ready to merge.

