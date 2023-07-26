Return-Path: <netdev+bounces-21509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F4D763C01
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AAD81C21349
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1DE37991;
	Wed, 26 Jul 2023 16:10:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7DEE57F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:10:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE721FCF
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690387799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=enSPb+7voJAFo/pOhUdJ4F/qEGNDwDqOBG00zvsVhTA=;
	b=NMLk3g4nv/cEaQvuHC85lyJgRpzX29yKMPPcnWKHBf4+spRZlCAGMXDC59tKRPT5+iuUzP
	6Ql7StRKUZs5vASj3+nDOGWUvBeSXpDOUkCkmPP9MHwNLZLK31zI3u256T4CZBBFyIMndc
	Fyfii85Vrk5OZGe+kRLsGm496Ujl07g=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-tsSw1SFNMYa6UiXLPJrkxQ-1; Wed, 26 Jul 2023 12:09:57 -0400
X-MC-Unique: tsSw1SFNMYa6UiXLPJrkxQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-56cf9a86277so85914347b3.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690387797; x=1690992597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enSPb+7voJAFo/pOhUdJ4F/qEGNDwDqOBG00zvsVhTA=;
        b=I1BtyLe8rHuBhudNY1D9MNuOpsdguoVd5wTrxHpEoPiShdkHbEl0VoCmK8W1Sm3xYR
         EBu4/XO+OXCRRoi2PuwbN6nVAKgxOGEipoxvuqar9QOCweeq+AHbO4mNqcRL1m3wBxbc
         nMxgVXU09ikP59VDtgvSzN3lKJGj2yLHUGqO+ilcJGwPb2cSLnDRYLth0Owta0lCfDDj
         UHJ52+7/NUp2ncLhL3qg9TYUczsIYzQbOUJZiKsiJpsb1PkbNzFyVOG+keV1zKYVeJL7
         WRBn0Xd/dfM3RS8BE+Z+NwtleSW+JJWWIgDm1T3r4jcH3g9N3tpQZXo4Dj63m1beiP1u
         gqYQ==
X-Gm-Message-State: ABy/qLby9hk1nuOBHcFL4JgccY4HVOwGBUbQOdId48SyLGRMNS3k8hgz
	6kuYm9q0fMbzK27fYDt6v74pGLuTNv/Yc2wZ+8xmrFCyB2+1+9MHDTjt5ITt2y4yFFYwFmKvLvD
	nNwoNwhAUIgCu/dXcjCzTkbYlbg6x19vd
X-Received: by 2002:a0d:c8c2:0:b0:576:98e0:32a6 with SMTP id k185-20020a0dc8c2000000b0057698e032a6mr2400044ywd.14.1690387796977;
        Wed, 26 Jul 2023 09:09:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHguvA9RheeftqCu7qXk7juUE5nu9S9te4xaexM3WUpSnKA/+gSwfpAlnNEuQsqqA76/yMUA/PrhqLM8fE3k9w=
X-Received: by 2002:a0d:c8c2:0:b0:576:98e0:32a6 with SMTP id
 k185-20020a0dc8c2000000b0057698e032a6mr2400034ywd.14.1690387796770; Wed, 26
 Jul 2023 09:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725162205.27526-1-donald.hunter@gmail.com>
 <ZMETxe6sXMRvJZ/3@corigine.com> <CAAf2ycnL3a2Q5dAk6n26PDdArZbXgL1Tg4dwodS96K523A90gA@mail.gmail.com>
 <ZMEcm5dIShMa2TQh@corigine.com> <20230726085542.402bcb13@kernel.org>
In-Reply-To: <20230726085542.402bcb13@kernel.org>
From: Donald Hunter <donald.hunter@redhat.com>
Date: Wed, 26 Jul 2023 17:09:45 +0100
Message-ID: <CAAf2ycnex50_9j5jskB2CD22_Mkd7EYQydpcBK1zF9oAEa90mA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/3] tools/net/ynl: Add support for
 netlink-raw families
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <simon.horman@corigine.com>, Donald Hunter <donald.hunter@gmail.com>, 
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 26 Jul 2023 at 16:55, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 26 Jul 2023 15:16:11 +0200 Simon Horman wrote:
> > > As I mentioned in the cover letter, it depends on:
> > > "tools: ynl-gen: fix parse multi-attr enum attribute"
> > > https://patchwork.kernel.org/project/netdevbpf/list/?series=769229
> > >
> > > Should I wait for that and repost?
> >
> > Sorry my bad. I guess this is fine as-is unless Jakub says otherwise.
>
> Right, just to be 100% clear, please don't repost, yet. I'll review it
> as is since it's of particular interest to me :)
> Simon is right that we don't accept patches which have yet-to-be-applied
> dependencies, tho.

Ack, noted. Apologies for rushing it.


