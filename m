Return-Path: <netdev+bounces-18934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86CA759211
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB641C20E0F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9F8125A3;
	Wed, 19 Jul 2023 09:51:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6390F10786
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:51:45 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839B0EC
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:51:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id F1FBD20743;
	Wed, 19 Jul 2023 11:51:42 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lrklfh0PX56d; Wed, 19 Jul 2023 11:51:42 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 2F4AF206B0;
	Wed, 19 Jul 2023 11:51:42 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 2934080004A;
	Wed, 19 Jul 2023 11:51:42 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 11:51:42 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 19 Jul
 2023 11:51:41 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 572E33182BCD; Wed, 19 Jul 2023 11:51:41 +0200 (CEST)
Date: Wed, 19 Jul 2023 11:51:41 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Louis Peens <louis.peens@corigine.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman
	<simon.horman@corigine.com>, Shihong Wang <shihong.wang@corigine.com>,
	<netdev@vger.kernel.org>, <oss-drivers@corigine.com>
Subject: Re: [PATCH net-next 1/2] xfrm: add the description of
 CHACHA20-POLY1305 for xfrm algorithm description
Message-ID: <ZLeyLedVE2pwGEnK@gauss3.secunet.de>
References: <20230719091830.50866-1-louis.peens@corigine.com>
 <20230719091830.50866-2-louis.peens@corigine.com>
 <ZLesfwnwXZ22A0fA@gauss3.secunet.de>
 <20230719093509.GJ8808@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230719093509.GJ8808@unreal>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 12:35:09PM +0300, Leon Romanovsky wrote:
> On Wed, Jul 19, 2023 at 11:27:27AM +0200, Steffen Klassert wrote:
> > On Wed, Jul 19, 2023 at 11:18:29AM +0200, Louis Peens wrote:
> > > From: Shihong Wang <shihong.wang@corigine.com>
> > > 
> > > Add the description of CHACHA20-POLY1305 for xfrm algorithm description
> > > and set pfkey_supported to 1 so that xfrm supports that the algorithm
> > > can be offloaded to the NIC.
> > > 
> > > Signed-off-by: Shihong Wang <shihong.wang@corigine.com>
> > > Acked-by: Simon Horman <simon.horman@corigine.com>
> > > Signed-off-by: Louis Peens <louis.peens@corigine.com>
> > > ---
> > >  include/uapi/linux/pfkeyv2.h | 1 +
> > >  net/xfrm/xfrm_algo.c         | 9 ++++++++-
> > >  2 files changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/uapi/linux/pfkeyv2.h b/include/uapi/linux/pfkeyv2.h
> > > index 8abae1f6749c..d0ab530e1069 100644
> > > --- a/include/uapi/linux/pfkeyv2.h
> > > +++ b/include/uapi/linux/pfkeyv2.h
> > > @@ -331,6 +331,7 @@ struct sadb_x_filter {
> > >  #define SADB_X_EALG_CAMELLIACBC		22
> > >  #define SADB_X_EALG_NULL_AES_GMAC	23
> > >  #define SADB_X_EALG_SM4CBC		24
> > > +#define SADB_X_EALG_CHACHA20_POLY1305	25
> > 
> > Please don't add new stuff to pfkey, use netlink instead. This interface
> > is deprecated and will go away someday
> 
> Steffen, I have general questions.
> >From where did all these SADB_X_EALG_* values come?
> And there are they used?

The pfkey interface was used by the old ipsec tools:
https://ipsec-tools.sourceforge.net/

The development of ipsec-tools has been abandoned
in 2014, as you can see at the webpage.

The pfkey interface is still there because the ipsec
tools are shipped in some disto versions that are
still under support.

Anyway, this was a reminder to me that we should
start the official deprecation process soon.

