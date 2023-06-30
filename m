Return-Path: <netdev+bounces-14708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1073D74344A
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 07:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402F91C2091A
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 05:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142BA1FCE;
	Fri, 30 Jun 2023 05:34:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052B61FC5
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 05:33:59 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966B93583
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 22:33:58 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40079620a83so178251cf.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 22:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688103237; x=1690695237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVktAUTo8uqqiwGeF3etOt9dgoCyOsZaU9oSN6UEZBE=;
        b=37sn0xlL0STS3tToajGcCaIcWU2UbLFGoVgjNL7zfRHQZ3wAJXov4luYHzHYf6phIB
         6s43JYgF9MtPsFk9w5T9IZy+NsYsBb/mPAwFaLjPp3XT68Nci0E0GHfcY07GxlxqfXSm
         GGiWeklNLLxBgu6y6LuoitKvoejsIywVwRrpqjsntNW/Gxv4uK6CXtDh/0NvXuCkNqun
         iam8LBz++AkvKxNgLEJeC4CFgErOfJ7RS4Fpnjj9BdYCNX/sMZVwJVM+b1saWaMDo5SD
         3YkigFIE4EHi72mBLW99H8OFjtUP0scmoE9d90L2E9GN7+1xS8BNXhUDbcAwOmWXZiup
         euDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688103237; x=1690695237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVktAUTo8uqqiwGeF3etOt9dgoCyOsZaU9oSN6UEZBE=;
        b=BTYfoFrv85j9gRYpjU2PU7AwMs28I57Pulftu7Q+NyJBvx+SeCe6iXyocTBHnP41jL
         aebPoCMOPRs9Auw6Id1oc+/lp5+1J49AelDXwBbUaTZetK/xP4B/elR8VaX93c3HmyNR
         gAeoOVIZV50Qw37l4aX/LlAbZ0/He3gExjTsd/jIa6bnZgEZWgu7VY8EfTf3eROyRELK
         FgCi+V5Il/KKG5GJvoQQJ1Gr3GJRlQhgticsUvHiRpD/1aAF8RBb1u8zSrnz4aDNUwVv
         b0ift89DW1mRDxST+Flg75jdsNMceX4lHz4ussZF1ccMXDrRQtx5Y/BQAxm/LbaNoElj
         AKEQ==
X-Gm-Message-State: AC+VfDxtn/RQbvgcf+1KV+IaTTi0QBY7sJxl1cHb+YarfwSb8nZuQh1W
	snscO9tgCXAI4wdwjgNSkS/pzF8ol/mYigrLIhqw2A==
X-Google-Smtp-Source: ACHHUZ42pHAQjS8oNAQHuXraTYAthPXAQg0vmckJ+g/JK/W3yZ0uwon02og73a/o/nMdcIHS66b0v9fIhBVdP16B0J8=
X-Received: by 2002:ac8:7f4e:0:b0:3f8:1f30:a1f2 with SMTP id
 g14-20020ac87f4e000000b003f81f30a1f2mr801884qtk.26.1688103237494; Thu, 29 Jun
 2023 22:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630032653.26426-1-qiang.zhang1211@gmail.com>
In-Reply-To: <20230630032653.26426-1-qiang.zhang1211@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 30 Jun 2023 07:33:46 +0200
Message-ID: <CANn89i+Yw_3FEjo_dYSknhmyfoOCD-1S0OSRR_GoyMjQPjcu6w@mail.gmail.com>
Subject: Re: [PATCH] net: Destroy previously created kthreads after failing to
 set napi threaded mode
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 5:27=E2=80=AFAM Zqiang <qiang.zhang1211@gmail.com> =
wrote:
>
> When setting 1 to enable napi threaded mode, will traverse dev->napi_list
> and create kthread for napi->thread, if creation fails, the dev->threaded
> will be set to false and we will clear NAPI_STATE_THREADED bit for all
> napi->state in dev->napi_list, even if some napi that has successfully
> created the kthread before. as a result, for successfully created napi
> kthread, they will never be used.
>
> This commit therefore destroy previously created napi->thread if setting
> napi threaded mode fails.
>

I am not sure we need this, because these kthreads are not leaked at
present time.

pktgen also creates unused kthreads (one per cpu), even if in most
cases only one of them is used.

Leaving kthreads makes it possible to eventually succeed to enable
napi threaded mode
after several tries, for devices with 64 or more queues...

This would target net-next.

If you claim to fix a bug (thus targeting net tree), we would need a Fixes:=
 tag.

Thanks.

