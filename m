Return-Path: <netdev+bounces-30352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9521A786FD9
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E232815FE
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0093288F1;
	Thu, 24 Aug 2023 13:02:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1274FC14
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:02:35 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F134FE79
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:02:34 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-lZCG3vAwOQyzvKQ69jrznQ-1; Thu, 24 Aug 2023 09:02:30 -0400
X-MC-Unique: lZCG3vAwOQyzvKQ69jrznQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 897078D40A2;
	Thu, 24 Aug 2023 13:02:29 +0000 (UTC)
Received: from hog (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C42F140E962;
	Thu, 24 Aug 2023 13:02:28 +0000 (UTC)
Date: Thu, 24 Aug 2023 15:02:27 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux@weissschuh.net, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Robert Marko <robimarko@gmail.com>
Subject: Re: [PATCH net-next] net: generalize calculation of skb extensions
 length
Message-ID: <ZOdU432SDOykeDso@hog>
References: <20230822-skb_ext-simplify-v1-1-9dd047340ab5@weissschuh.net>
 <20230822184644.18966d0f@kernel.org>
 <1e1dde74-edc6-4306-9b1b-0a1b5a658b67@weissschuh.net>
 <20230823075318.4860cebc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823075318.4860cebc@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-08-23, 07:53:18 -0700, Jakub Kicinski wrote:
> On Wed, 23 Aug 2023 10:14:48 +0200 (GMT+02:00) linux@weissschuh.net
> wrote:
> > > Could you include more info about the compiler versions you tried
> > > and maybe some objdump? We'll have to take your word for it getting
> > > optimized out, would be great if we had more proof in the commit msg.
> > > --
> > > pw-bot: cr  
> > 
> > Thanks for the feedback.
> > I'll send a v2 with more background soon.
> > 
> > On the other hand this function is only ever
> > executed once, so even if it is slightly inefficient
> > it shouldn't matter.
> 
> Oh you're right, somehow I thought it was for every alloc.
> You can mention it's only run at init in the commit msg if 
> that's easier.

We could also add __init annotations to skb_ext_total_length and
skb_extensions_init to make that clearer.

-- 
Sabrina


