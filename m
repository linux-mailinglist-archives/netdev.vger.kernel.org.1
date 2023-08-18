Return-Path: <netdev+bounces-28734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB3A7806E7
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 10:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84811C21546
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAFA168CA;
	Fri, 18 Aug 2023 08:11:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC768E56C
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 08:11:12 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B992D69
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:11:08 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-407db3e9669so148381cf.1
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692346268; x=1692951068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nB/EhVQb2w0gbRvzvRtWWQKrBAv25MgBV6S5W07gfWQ=;
        b=KSTYho1yGqW/oS2GxajhRClTs35qWDtblO5mQK7UZnq0EBTDlOHt9QX6vqMQhujdGY
         u+rQ968eBOtIwBKpXxjE9mg3PNibpY6jfXZJlCsVEBmlf+8XtMERDmdjsH9yGG5ZN2JW
         HxVxet3Obh0b8JoVM25KB0Ycw4gHqQbxKrukzqM7GAwhtrBDP2VIfPNkt0oGpphhjoRE
         Uw4UN5YWs3mNLYzOmHALd+Eb8cCvjRE+dh+TEQzCz0WACuIK65rr9agg5bsUGXJq/4gd
         P3Qp90r1oP4t6FRibrwSB0Xg1+CnaiK69piwGSQ9oLcLH/pFHzL8l4Ukdees36V6NXSo
         7ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692346268; x=1692951068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nB/EhVQb2w0gbRvzvRtWWQKrBAv25MgBV6S5W07gfWQ=;
        b=FWG9Au90JybzaEdNgHNM/JjaXpa9f+xqW3mn8qn4cf+z94Hdn4s5N6k2gAq41WaBij
         YTdLAHVgk9K+H4QJztIwkV1ZfngWRnzXDgnluSfxuMjVoyOh3+MGNsBwehKX8mj1z6rd
         +ShxPeXVpz0i4lH3Eu07Rbgfits3zXY0pcYrFJRhU0xTS1FcQd3X8zRJ4oQiuQq9Cag8
         um0PG9Ibhngf/gZRedm9f4uDSE2hBdCslqGyMoQlZP2SW0JsGnvDh6Bp8R37F3WMpEFk
         t0NJXTmUmn9Q8TAbGBOOBzU1jLpg+sr+l+7XrCMw4hW6iFesKLPhNSQ5GWHvDWvL/t6Z
         pjeA==
X-Gm-Message-State: AOJu0YwPFd2TsTfielSU97uwQmZkYnisLtNr4ss65nr5LaQ92aniY1uM
	GthwRcRwtSaTIMPj9cpiuJxGDqh6Ctuwud+HGw4sVg==
X-Google-Smtp-Source: AGHT+IETvWnc5I0cHGp5gulHuBnQQ1VdwXol1k71H3IVTJyn8R/1TwKRWmuJA5Nn/xzYuYQ4yndKF2X4TXljVvy1Y4M=
X-Received: by 2002:a05:622a:1b8d:b0:3de:1aaa:42f5 with SMTP id
 bp13-20020a05622a1b8d00b003de1aaa42f5mr104060qtb.15.1692346267663; Fri, 18
 Aug 2023 01:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816220203.1865432-1-prohr@google.com> <ZN8mbEnFGBCr3YLj@vergenet.net>
In-Reply-To: <ZN8mbEnFGBCr3YLj@vergenet.net>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Fri, 18 Aug 2023 10:10:56 +0200
Message-ID: <CANP3RGcs47pf8JrRnYXf-T-xazoT+K0c_YYSzCys_MbBHWKFrA@mail.gmail.com>
Subject: Re: [netdev-next] net: release reference to inet6_dev pointer
To: Patrick Rohr <prohr@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, Lorenzo Colitti <lorenzo@google.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

feel free to also add:

Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>

