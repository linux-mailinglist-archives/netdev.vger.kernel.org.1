Return-Path: <netdev+bounces-21378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E60763709
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B3D281D3B
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D38C140;
	Wed, 26 Jul 2023 13:06:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2BA927
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:06:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C487C1FC4
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690376775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vQoTMW34xUn55v5rAK/33BPpM1DP7zmeyGwBEvanyF0=;
	b=C2Z36C7DDabIlkt6Km312YlbhcDE+0OESgqo+bl7WWGBXUaM0kkkxlbSsjxIDK23ZZbrjn
	hN4YRqo3V/9Ks2z37yjXz7q3JfSzp8OVDfH8Xi5YUUvhzAMt7daTOUUpwNFHH181G+jNVC
	JOZx7ioyIJ5o+phEAVMcJ1jGdwrQ5P8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-zSPDxv0cMwCTaDU35D_zRQ-1; Wed, 26 Jul 2023 09:06:13 -0400
X-MC-Unique: zSPDxv0cMwCTaDU35D_zRQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5704991ea05so79412197b3.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690376773; x=1690981573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQoTMW34xUn55v5rAK/33BPpM1DP7zmeyGwBEvanyF0=;
        b=LRxhs3S1XPIK35rSjKAIiMPg16bNNB3gVYpR0GwmRZgd70CtD/xEcu1R39SAHAUNWy
         Q0zg5duVA/n2sg7zGXuliH1+jx2MmsqjBhF6rV/EP2EtJDuFqXDfi79LgM9aqsplJg+N
         TQaLxIl/4ylwSPNvCeMJnmSe8T4G9UFz8AI6S2v/jvPaYJE9rmpbVsJsH0nyrouFW/ok
         HSOCLnPLU3jll8ibCMHyV6cwqtilAId3YVtcQK7cHRqMI9QapEWVvz7zZPLVYhmOp+EP
         EnPd8RQ9Z/A9b+jXHdwc2ARFh5Js3Hv477WcGZWof4eqHX58c72TgOTgHX7YL6YadYoE
         UhcA==
X-Gm-Message-State: ABy/qLYw4W+ZSOGVfOtg/4e4QteYxodSOeR/sliYs6tVcmcYgrOB0vIE
	+kQlig/g8UZweKZaAE9zWsuHBJ/QE5W6JNB+XkruUB2ltawEY7rAG8/P0l3LhE0p5oaG9bFJ2pO
	kicuOKy3HTte5h4roSHfP/CiGPX/YpQSQ
X-Received: by 2002:a0d:ebc6:0:b0:583:7b48:9436 with SMTP id u189-20020a0debc6000000b005837b489436mr2094872ywe.29.1690376773247;
        Wed, 26 Jul 2023 06:06:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHthhv6OSeOSN5NNEzoD+BcJ+mGw5ks+OhCrUL1zbBu1tZp1+DVjx3QWC9dL11R905S69VnDfNxG4gGYPELnIk=
X-Received: by 2002:a0d:ebc6:0:b0:583:7b48:9436 with SMTP id
 u189-20020a0debc6000000b005837b489436mr2094847ywe.29.1690376772945; Wed, 26
 Jul 2023 06:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725162205.27526-1-donald.hunter@gmail.com> <ZMETxe6sXMRvJZ/3@corigine.com>
In-Reply-To: <ZMETxe6sXMRvJZ/3@corigine.com>
From: Donald Hunter <donald.hunter@redhat.com>
Date: Wed, 26 Jul 2023 14:06:02 +0100
Message-ID: <CAAf2ycnL3a2Q5dAk6n26PDdArZbXgL1Tg4dwodS96K523A90gA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/3] tools/net/ynl: Add support for
 netlink-raw families
To: Simon Horman <simon.horman@corigine.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 26 Jul 2023 at 13:38, Simon Horman <simon.horman@corigine.com> wrote:
>
> On Tue, Jul 25, 2023 at 05:22:02PM +0100, Donald Hunter wrote:
> > This patchset adds support for netlink-raw families such as rtnetlink.
> >
> > The first patch contains the schema definition.
> > The second patch extends ynl to support netlink-raw
> > The third patch adds rtnetlink addr and route message types
> >
> > The second patch depends on "tools: ynl-gen: fix parse multi-attr enum
> > attribute":
> >
> > https://patchwork.kernel.org/project/netdevbpf/list/?series=769229
> >
> > The netlink-raw schema is very similar to genetlink-legacy and I thought
> > about making the changes there and symlinking to it. On balance I
> > thought that might be problematic for accurate schema validation.
> >
> > rtnetlink doesn't seem to fit into unified or directional message
> > enumeration models. It seems like an 'explicit' model would be useful,
> > to require the schema author to specify the message ids directly. The
> > patch supports commands and it supports notifications, but it's
> > currently hard to support both simultaneously from the same netlink-raw
> > spec. I plan to work on this in a future patchset.
> >
> > There is not yet support for notifications because ynl currently doesn't
> > support defining 'event' properties on a 'do' operation. I plan to work
> > on this in a future patch.
> >
> > The link message types are a work in progress that I plan to submit in a
> > future patchset. Links contain different nested attributes dependent on
> > the type of link. Decoding these will need some kind of attr-space
> > selection based on the value of another attribute in the message.
> >
> > Donald Hunter (3):
> >   doc/netlink: Add a schema for netlink-raw families
> >   tools/net/ynl: Add support for netlink-raw families
> >   doc/netlink: Add specs for addr and route rtnetlink message types
>
> Hi Donald,
>
> unfortunately this series doesn't apply to current net-next.
> Please consider rebasing and reposting.

Hi Simon,

As I mentioned in the cover letter, it depends on:
"tools: ynl-gen: fix parse multi-attr enum attribute"
https://patchwork.kernel.org/project/netdevbpf/list/?series=769229

Should I wait for that and repost?

Thanks,
Donald.


