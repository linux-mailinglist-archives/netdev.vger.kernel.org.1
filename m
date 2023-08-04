Return-Path: <netdev+bounces-24444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F028770362
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5A81C2182C
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5024C14A;
	Fri,  4 Aug 2023 14:45:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88AFAD48
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:45:26 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7521746B2
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:45:25 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4036bd4fff1so338171cf.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691160324; x=1691765124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwNZu+1zP/QOg8USFqLTw0qd/bPjnT4qgdmjKtaqwCU=;
        b=4YQoOIk1oDbfLKcCqDoo2B0dxBnkm3LkR5eukbKGqJozLk8P2GDJLCNJrjwZHlJEoM
         zGgRH2Tjp/9VM7ClxO8linK/+Wv2Opatyx0NuDpfgsNR/ZWv5UqIhBqjp9UERS7qzrW4
         Sz6U3OrRxfKpoUMlSa9nXWjL1x44URTewtsjNvB1+EX0WZWZgFMIdryXS8XqZ/+Wzpsq
         SHw3LL/gRnx0Du/AX9Nu9Qum97RlLcc+aazVFqpqvLYhCagJBFt21Tr0uBt8rTRJIdty
         3TSlp2cjt6URc3Mwzf0Wy3fwRHMByAuRdyCSJ/+6qffBVF0J6NbjeGVwFDTK3QQReMJm
         vTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691160324; x=1691765124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwNZu+1zP/QOg8USFqLTw0qd/bPjnT4qgdmjKtaqwCU=;
        b=gIooZiPyzItVHiYhnggnspWl4iEjOXzqH3EZkrlvRcnaS4THkC1x8ETxtU9XIpaqSa
         Z8P8wReq1PpDmvCi/Is0+xUKwzToCK8xMuKp19JpK/T9b9Pc/Sj8I0JqhvFdqGiYGyaC
         DkoF3tELViGfJftVy018aGuY5Z7GahoP8mUABU4r9xnlHoug5VuDLRSvy7YEQ3tSevT8
         5I2g5oh2SU6WvH17R2Q3T4VX8FduOps/CfEj+pr1x/1owzpc5yRTNEEhVDGq+hp+L0wG
         4WQbPmYvvt1c1Of+59Ah2bvOUdBCLu5KeAY5SHWl7ZivnJRngRGCVaIKIfTJ3q6e0XiQ
         O5Ow==
X-Gm-Message-State: AOJu0Yz1QGEmUOsGLGhQHHSrw4fwId/vvduSU6A/bvz17d6dn5gwJ80s
	GI7ILCkLkBFrzSLHAICpxsQeiDYb4n7artv9LfFibpkyoiWizwjJoQbjjg==
X-Google-Smtp-Source: AGHT+IEa3yQiPGj22e8sJNBfL7xGpxHzKuLMLyQawjgPmCJi+Plzy4nunuGhNioOpxp6Y1gRrzQYxeaJFc18NXXtiMM=
X-Received: by 2002:a05:622a:1894:b0:40f:b556:b392 with SMTP id
 v20-20020a05622a189400b0040fb556b392mr284196qtc.12.1691160324238; Fri, 04 Aug
 2023 07:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802092340.9640-1-edward.cree@amd.com> <ZM0M7UgvMPFmDfie@luigi.stachecki.net>
In-Reply-To: <ZM0M7UgvMPFmDfie@luigi.stachecki.net>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Aug 2023 16:45:13 +0200
Message-ID: <CANn89i+VYvOrXPFNgqKjTJ+EeMUngXrVzoppynkn2HBnYAdqEQ@mail.gmail.com>
Subject: Re: [RFC PATCH net] net-gro: restore check for NULL skb in napi_gro_frags
To: Tyler Stachecki <stachecki.tyler@gmail.com>
Cc: edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org, 
	Martin Habets <habetsm.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 4, 2023 at 4:36=E2=80=AFPM Tyler Stachecki
<stachecki.tyler@gmail.com> wrote:
>
> Given that this case is rarely hit, and given that there are some perform=
ance
> concerns raised wrt this change, it may be beneficial to hint that this
> branch is unlikely.

This is already done, a compiler should already infer this from this code:

if (unlikely(skb_gro_header_hard(skb, hlen))) {
    eth =3D skb_gro_header_slow(skb, hlen, 0);
    if (unlikely(!eth)) {
        net_warn_ratelimited("%s: dropping impossible skb from %s\n",
                                           __func__, napi->dev->name);
        napi_reuse_skb(napi, skb);
        return NULL;
    }

