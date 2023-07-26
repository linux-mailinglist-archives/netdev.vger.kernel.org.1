Return-Path: <netdev+bounces-21670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2617642C0
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 01:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809DE281F87
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C867DDD6;
	Wed, 26 Jul 2023 23:55:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5B0DDA8
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:55:22 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9610E0
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:55:19 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-406bd9ed61cso2062071cf.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690415719; x=1691020519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HL340E0SJKmHgbaF1XpYBoG5T26SgwNCOYXvoxGoik=;
        b=FolSCL2tu72lFoc+kEPZl+lghMAnGcKEsl8PvR7skz/uzHbws0z7KOUtjdm46XRhHX
         20xQ/6e1b5rwVv1O520zs7Gy3BfCBz/ITudkRD+AJS8hXDBmzW/9oD9btCsDMDgmVEIw
         Ryd2nT4Y45+JNNARO41nM1jxvW003265X8uOafXD2/te6RVZDMHPRTBduX62PswqhK7t
         F2+fMECsu96dLECpbkOYnk8JC9wqnaq2XmJ4+vQMxsAxj6rNGVa1MpyoVsNxttzECnbz
         B5ErrnSf4JQjpJEkv+mf0n5lcz967kg/dNOof7LZbuF/nSDRMGv4IBq44t7pqKAEOwko
         GNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690415719; x=1691020519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HL340E0SJKmHgbaF1XpYBoG5T26SgwNCOYXvoxGoik=;
        b=AgGlGQ/oQn+aYKLSDRlFy99XFc5YoG+4p6f1bGSAeHpV4t8OK5k3CJFL5v7dw0cnEs
         HJESy5AKrr8QABnfAhK+o3xL847VIRyp0l4ZXv1U8Hfpr9LW8rlafkroJkSWilVL4he/
         bhUVpvmIm034teEgRqfedKPUBg+NiMlapzXokQSUWNlMH2JCVzqCN+z9pPWXFNZSvLwv
         P5ireOSCKIvYJULhxFF77o58IlH9uvMP2PxE770uNmswyih5cAB9CDk9ABvgSyHPM71Q
         pVm5VfQXpev/uoE9qpjMGidmDVhCCwLgkEiSlakOmoNr2/YCq05eE0Yro3dTm7PQ6m52
         XIiA==
X-Gm-Message-State: ABy/qLYcxoqhK0swIo8fbmR/+U52FUul8AXFEpSfX5bVXHOR8awKHWXd
	Drb1s7ClwWccfepF/XPcVKBWG0XqUMkvfH97WN1YHw==
X-Google-Smtp-Source: APBJJlFKNJk+gSy1t/fiT+JdR0xZN3nw+ZNGCWM30wyRRrD+HYWzhqfARtUZ2KdSYPMW3MAZo0oA1Q3t82LjXAlfbZY=
X-Received: by 2002:a05:622a:1302:b0:403:ff6d:1ec1 with SMTP id
 v2-20020a05622a130200b00403ff6d1ec1mr4106337qtk.48.1690415718885; Wed, 26 Jul
 2023 16:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725233517.2614868-1-sdf@google.com> <20230725233517.2614868-4-sdf@google.com>
 <20230726163718.6b744ccf@kernel.org>
In-Reply-To: <20230726163718.6b744ccf@kernel.org>
From: Stanislav Fomichev <sdf@google.com>
Date: Wed, 26 Jul 2023 16:55:07 -0700
Message-ID: <CAKH8qBvix3YLwrFjMspk3Wttc=CfYW5xJgQt86x2Jg98v2Y55w@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] ynl: regenerate all headers
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 4:37=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 25 Jul 2023 16:35:16 -0700 Stanislav Fomichev wrote:
> > Also add small (and simple - no dependencies) makefile rule do update
> > the UAPI ones.
>
> I was thinking people would use:
>
> ./tools/net/ynl/ynl-regen.sh -f
>
> for this. It is slightly more capable. Can we perhaps hook the new make
> target to just run that script?

Oh, didn't know about this. Something like this maybe? Ugly?

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index d664b36deb5b..c36380bf1536 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -3,6 +3,7 @@
 SUBDIRS =3D lib generated samples

 all: $(SUBDIRS)
+       (cd ../../../ && ./tools/net/ynl/ynl-regen.sh -f)

 $(SUBDIRS):
        @if [ -f "$@/Makefile" ] ; then \

Or, now that I know about the script I can actually run it manually.
But with a makefile imo a bit easier to discover..

