Return-Path: <netdev+bounces-23338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB35C76B9DA
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 18:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A9728187D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800D71ADEC;
	Tue,  1 Aug 2023 16:42:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B1C4DC7B
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 16:42:56 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A29210E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 09:42:48 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-579de633419so57640127b3.3
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690908167; x=1691512967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjJYAPQwhBH1tNOvk5+y2uVRsR1UJGpdCrK2Bal18A0=;
        b=fo9mfeegk2LZX5Y9ejYMeXp/LJ8/FRNtPKHEZgMtxPeVzBgwXm8WzfWk88smxlKVYi
         Hd42QGXOSea0phSxPKSSLyqx7B4JovEA//JrDPfPXsGIMo50We4ORJz8VmGxy8MLp+ec
         zT6HHGsQ4wkdsBzj3/bmD260rYeJ86Y9kroB25RdLxWCX+LgbJUTSVily+9aa5O3lnzl
         uuwenZqAod31RmF7zJp0d7ZmOC47nHPJcLCyF8zK6EnKn0AcrOhnMDNc0TTxoqUaM8PN
         TQO0QsJrmq+wshK8SzU+VjPK5F6VC7S1FHx+dRADt56zmbeJufekWYhTtK61Qi5q0yCi
         YLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690908167; x=1691512967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjJYAPQwhBH1tNOvk5+y2uVRsR1UJGpdCrK2Bal18A0=;
        b=d9es0YcjItuESp0IyHsJPjIN2p0bO3p1WExEwhu4HS7YjB5j3S6e2FG/0g4RtU0Kef
         MVpptlpDhyvcgD0r4ShEzUvjR+53kslCGExU+NfdoXh/BwUNDnIRljFvtgarRMXlEhce
         st6UAZZqVLFbIuuWj9CGF/P8tbS+zX8LPNsBiUPZxiLNaQA+nKV1PX/OF1a0RTqnUCri
         T/adK0h3jmxSUetA7SHpUpjaHwmkVgYyCOSxr6YzzR+Ml2SxCU0Opyp7zWGoEmOxGw+P
         cTZpRmy/dEfI4BABJESItuHgbNLZNU5y6ycvbhi8g0P4Luu3QNNW2j2W2tzg22/sNCRq
         4d/A==
X-Gm-Message-State: ABy/qLagugOeBB7EYHxZIDcmWp/DtrnSD+pw4P3ph8BB+cWSoURBx0zk
	1LJr79z2lKtxTaijkVzWgYr1QJNy737wVVlW7xbBQvnxWZdNz7Pdzg==
X-Google-Smtp-Source: APBJJlGBqmDaOnxMqThBvheaXOpM8pw+v+T95Y+Q4Tx2EZUrSCxjIN7ezDKQKzRWz7GBOqeid5FjuLfmkwi/J6uWolQ=
X-Received: by 2002:a0d:ea01:0:b0:57a:8de6:86b1 with SMTP id
 t1-20020a0dea01000000b0057a8de686b1mr11087937ywe.31.1690908167207; Tue, 01
 Aug 2023 09:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801143453.24452-1-yuehaibing@huawei.com>
In-Reply-To: <20230801143453.24452-1-yuehaibing@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 1 Aug 2023 12:42:36 -0400
Message-ID: <CAHC9VhSqvzogdH2=PuGnD5W4FAquWEL5Se2qVvzyAMP6CQ1G0g@mail.gmail.com>
Subject: Re: [PATCH net-next] netlabel: Remove unused declaration netlbl_cipsov4_doi_free()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 10:35=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> Since commit b1edeb102397 ("netlabel: Replace protocol/NetLabel linking w=
ith refrerence counts")
> this declaration is unused and can be removed.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/netlabel/netlabel_cipso_v4.h | 3 ---
>  1 file changed, 3 deletions(-)

Thanks for catching this.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

