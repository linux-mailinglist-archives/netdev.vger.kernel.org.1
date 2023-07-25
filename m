Return-Path: <netdev+bounces-20925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532C0761EBB
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9672816C2
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66CB200D0;
	Tue, 25 Jul 2023 16:39:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EA13C23
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:39:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66FB10F7
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690303191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+Td0aLhaj5/B+MwZ9s3+5y+Qnr2a0G/TGHZWk6IzCk=;
	b=iAR9rUWqPt8M06YED8W+rREQ9/dEIBNQ+kctTvCHw2l/mbswlcgjlZvEhQs3bbA2X8YtDO
	2GaMp0km7GVDLZav8A+fHbe6eBP4V9bn3fxvdJPMTGjyDPPuNbpmAKmPjxfaPUwKC4G0qy
	jAOZstffqXucRxWQcsgerDGVjklAoyE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-HFobbQBYOPOgtwUoCuD2OA-1; Tue, 25 Jul 2023 12:39:50 -0400
X-MC-Unique: HFobbQBYOPOgtwUoCuD2OA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fd306fa3edso7401665e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690303189; x=1690907989;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+Td0aLhaj5/B+MwZ9s3+5y+Qnr2a0G/TGHZWk6IzCk=;
        b=Subn0EZ5zrM/BR0G7//Cvo9IzTFr+xEWXpvowBvLMO+ntgBsGmAYDAQq/aEAY7pryb
         B6tajIOKnFH905KPBpQloVsUYIyggDhfRH9VCXEbnMacTnkkaQjMCzw43278xqo6Q5J5
         0S/abNOIrlmdViOoLY1fG0CWt/kIRPEuxnTi9NWqFYLLoqf5sqDcPX/SGvx8qXAyu2nQ
         eqe8VisRX2uOcEdQR+YSmrO2gEwd4Rnc0QR6OtYhNfcLty45X+1h2N8u6qP3jxOKvqJn
         EU/zKjCaheTUIM3kpT3vkkI8slN4NXiEvLdVe/e2K/P5+rWpLDf1oTqi646KAmiu2oXK
         YnqA==
X-Gm-Message-State: ABy/qLbjrb8rtX5qWvsL9N5oZAI4LecxrEn0zt9IEP+c2H0SYJHnSzdE
	HpRI0mu8lhaBQz0XwL3MGRc+84yrZcCXPDYvPgbnNBCyK5QYvW/0E/aVE6lJiR5K0XjPXrsjgWD
	VM9u2qaYVbSpcQWYL
X-Received: by 2002:adf:f78a:0:b0:317:3d36:b2c1 with SMTP id q10-20020adff78a000000b003173d36b2c1mr7404702wrp.7.1690303189551;
        Tue, 25 Jul 2023 09:39:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG0AEDqlZOk8TejMp9asXUf5OuA/ynieIdjMIagaihYcZLRh4WB7DcsQNlZZYdCbEnsU3WwJg==
X-Received: by 2002:adf:f78a:0:b0:317:3d36:b2c1 with SMTP id q10-20020adff78a000000b003173d36b2c1mr7404684wrp.7.1690303189209;
        Tue, 25 Jul 2023 09:39:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-81.dyn.eolo.it. [146.241.225.81])
        by smtp.gmail.com with ESMTPSA id x12-20020a5d650c000000b003143aa0ca8asm16859535wru.13.2023.07.25.09.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:39:48 -0700 (PDT)
Message-ID: <1653e6858a6e127da40ec5a8317d4b15f99a0194.camel@redhat.com>
Subject: Re: [patch net-next v2 00/11] devlink: introduce dump selector attr
 and use it for per-instance dumps
From: Paolo Abeni <pabeni@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net, 
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com,  petrm@nvidia.com
Date: Tue, 25 Jul 2023 18:39:47 +0200
In-Reply-To: <ZL/qU/cwvPlLR3ek@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
	 <ZL+C3xMq3Er79qDD@nanopsycho>
	 <87ca1394a3110cad376d9bfb6d576f0f90674a2d.camel@redhat.com>
	 <ZL/qU/cwvPlLR3ek@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 17:29 +0200, Jiri Pirko wrote:
> Tue, Jul 25, 2023 at 10:36:31AM CEST, pabeni@redhat.com wrote:
> > On Tue, 2023-07-25 at 10:07 +0200, Jiri Pirko wrote:
> > > I see that this patchset got moved to "changes requested" in patchwor=
k.
> > > Why exacly? There was no comment so far. Petr's splat is clearly not
> > > caused by this patchset.
> >=20
> > Quickly skimming over the series I agree the reported splat looks
> > possibly more related to core netlink and/or rhashtable but it would
> > help if you could express your reasoning on the splat itself, possibly
> > with a decoded back-trace.
> >=20
>=20
> Well, since I'm touching only devlink, this is underlated to this
> patchset. I don't see why I would need to care about the splat.
> I will repost, if that is ok.

Not needed, the series is again in 'new' status.

Cheers,

Paolo


