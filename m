Return-Path: <netdev+bounces-21666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7490B76429F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 01:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC2A281E80
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF20A953;
	Wed, 26 Jul 2023 23:35:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE21BEE4
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:35:23 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848102704
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:35:22 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686c06b806cso321730b3a.2
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690414522; x=1691019322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDxdbKiiiYQiNbCN4B9wjKhopYHVjYGiNuTcbzMN3kA=;
        b=07s5atTQVXgGKDt/f1BcJyHFCrDYfegGrdVVa7oEp80XaY+5LG3654iNKvVVfVP94b
         L6yuaqJOU0e9Hc+GMl84jEPS6pSofHwy3itjgnO33WG6UrpSJ90yWxIFsQTkzxuIiWeP
         OB54qO/aeFQqVPPH0XrZ4kv/jifl+esMt2eVULRYVEz3umoBXnOfHqs334qhEOt+xoNv
         syNisudZl5J9TtLiqwOWGC/MBgXH4CombB6PxkEqVW9m7/ofl5TPuupTvJzSNHq50nHH
         niVT2cg0/duUhTfALr18i6mk1bcSt9uw9rrA6K0zQStgzNTaf5SYrEdDtgIXvRGkaLlq
         Yvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690414522; x=1691019322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDxdbKiiiYQiNbCN4B9wjKhopYHVjYGiNuTcbzMN3kA=;
        b=SP0BA3V05/kmEhUflrQDewbLNpkv/0oq2gh9c3ve5+TUrDiddjgfdDTVB1awyhsAaT
         OrkSVZjzFLQrXaVNd9K/a/pn0+ZEpFAzNyQ5Rg1NkRqkGe2el1dpHd3mgKH5XbNf50wW
         vRKRfToURkvw8k89P5Q+28ZsswhliirufyR8itJnvJLwPWSufyBNXIqjhvkylgy8Ms1L
         zeYzxbB1WsE3aunLFzA424hGS8oKeWSNywtSpZjkD59KMGIkNmNHt1iuDEuq7xlBCZMI
         9bXwV1rofT2bM9WNEL27iSVX9EW/bfY+l+h5UMvOaiCjIcOQycuyCC8bpmyE5KtGAlmE
         H9Ng==
X-Gm-Message-State: ABy/qLZ+/jAT0fw0mfuQSTJXwD039UfOlEXSv8CsVP4CwM5oNm+K4b6j
	G0R1sa2MR2q90qPMWpEMdfMk+xF2TU0Feu+Qtypk2g==
X-Google-Smtp-Source: APBJJlF1MDRJ1YL8Jz6dlUlEzLCV9LAbAmfA0ffJ+MboTsr+4Mh/UghuLZxpbfirjvjfppv8UzLqupI9nIK2R7U88x8=
X-Received: by 2002:a17:90a:7d08:b0:268:468b:2510 with SMTP id
 g8-20020a17090a7d0800b00268468b2510mr2679187pjl.37.1690414521842; Wed, 26 Jul
 2023 16:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725233517.2614868-1-sdf@google.com> <20230725233517.2614868-3-sdf@google.com>
 <20230726163317.6f120200@kernel.org>
In-Reply-To: <20230726163317.6f120200@kernel.org>
From: Stanislav Fomichev <sdf@google.com>
Date: Wed, 26 Jul 2023 16:35:10 -0700
Message-ID: <CAKH8qBsgzQdicm9sjUEfQN-RTF3Ba4rmvmCwAqtckbgT1DsbCA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] ynl: mark max/mask as private for kdoc
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 4:33=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 25 Jul 2023 16:35:15 -0700 Stanislav Fomichev wrote:
> > +                cw.p('/* private: */')
> >                  cw.nl()
>
> I was about to apply but I keep having doubts whether there should
> be a new line after the private marker. I know - a very important
> question :D
>
> Quick grep of
>
> $ git grep -A1 '\* private:'
>
> shows that all(?) current uses have something immediately following
> the comment.

:-D I was too lazy to grep. Will drop \n and respin!

