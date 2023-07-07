Return-Path: <netdev+bounces-16057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECEB74B2FA
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 16:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F9C2816FF
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE482D516;
	Fri,  7 Jul 2023 14:21:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77A0D2F7
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 14:21:51 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B38110B
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 07:21:50 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4036bd4fff1so297221cf.0
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688739709; x=1691331709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YzcEN8sL+SbJU/4j7ElOz8HzSX109GbxshTNxdwHOM=;
        b=GCKlUGEVb6aH7r/AOclMN1bOHdnJrze/cKh7XnKUR3K5hwsn0HZZCgpNAvh1WVxfux
         jBpDnlOTKcc393pCJyJut1iqJWW/yy/GZKg0QSVIsi4oTp84PZqF5JskRdy8HJrVF8QU
         MAft0Mb9KkdMY9xuXnL0/kdLHHX5GPBHyy5IwxXVY3LhYdcGaPymYM5ZXhzGB1+twEo8
         eg/7Y/U/0sjYwMMDIYZE3Jpez/AAUM8GlInUDYLJ57pfv4z0N33ctuErYcfCjR9k4tun
         8IE4vLdYfi9O+DJSJuriBnkpItamt6wRrKGT7Zk94kyeI13720xq1PheP1/FmEBCp3Fg
         ItvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688739709; x=1691331709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YzcEN8sL+SbJU/4j7ElOz8HzSX109GbxshTNxdwHOM=;
        b=B1/m8Y+OnElxDjfY/aRgGFvX5WzcIZKt+p0khwJqKRjkLKSDu9IkkzyvEVXAYL6a9q
         jawmXiw7O6WTFn7UMChR57Jxvxf8Iyv/DJZySn4j2qqt4fKi/5SLKaKF3cSSDe+N5OTz
         tw5yXMevkD4QKnbGJ90rDAlSlAYmeFBlLXFuetr3KHGyj+KmNlAz+hzDEZrlpcWJEu4x
         ZOL6SFMe6qKvGOJxdpuUnbYL9UJJCvZE1jHML6oisb8kGEdYCI/rzM2CAp6nNujaXZc0
         15o/y6MHrdrSrKSVzKrsjSJpsjqJRc6Fp+/d9vuCjmsFx7fs+ctpT9CX4rh04FkxCzXA
         CEoQ==
X-Gm-Message-State: ABy/qLbjLcOOBB81FZskY9ilSlf6tvCmnfBmp5qPQAGwt86LpiPF5ITn
	gyuBoGOXF6HYQxSBpNppXJKVrmyWfFimCvIDEwsszA==
X-Google-Smtp-Source: APBJJlF8hcqB1EFVjm4Ky/dypZl0bel4E71yWz7JrK9bKZpjmXHTyWo4I215bw1nDLrW9TyNsiSPnBsE0ss4aa4JDVY=
X-Received: by 2002:ac8:5fce:0:b0:3f9:b8c2:f2d3 with SMTP id
 k14-20020ac85fce000000b003f9b8c2f2d3mr152813qta.19.1688739709457; Fri, 07 Jul
 2023 07:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230704001136.2301645-1-anjali.k.kulkarni@oracle.com> <20230704001136.2301645-2-anjali.k.kulkarni@oracle.com>
In-Reply-To: <20230704001136.2301645-2-anjali.k.kulkarni@oracle.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Jul 2023 16:21:38 +0200
Message-ID: <CANn89iLOGdFBJHe4L2Lk_iaNEvLYG5KYGxF=G9d_Lx9dU8Wv-Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] netlink: Reverse the patch which removed filtering
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: davem@davemloft.net, david@fries.net, kuba@kernel.org, pabeni@redhat.com, 
	zbr@ioremap.net, brauner@kernel.org, johannes@sipsolutions.net, 
	ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org, 
	socketcan@hartkopp.net, petrm@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 4, 2023 at 2:11=E2=80=AFAM Anjali Kulkarni
<anjali.k.kulkarni@oracle.com> wrote:
>
> To use filtering at the connector & cn_proc layers, we need to enable
> filtering in the netlink layer. This reverses the patch which removed
> netlink filtering.
>

" the patch which removed netlink filtering." is vague...

Convention is to name the reverted commit with sha1 ("title"),
to ease reviewer work ;)

