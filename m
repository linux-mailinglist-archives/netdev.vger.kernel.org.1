Return-Path: <netdev+bounces-27932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C7C77DA9C
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA371C20F09
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 06:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC2EC2EF;
	Wed, 16 Aug 2023 06:46:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CD21840
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 06:46:52 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC84106
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 23:46:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9fa64db41so93887331fa.1
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 23:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692168407; x=1692773207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfMA8d/EOg/li5lIqvSjinrv9s5gkR6xSHttMnq5lxw=;
        b=CjjGG1D/lqtZ0NbuLk9OgP8rnmqvsZuiVwZfw4/kQqwxtj3E7vSbx9eQfupvWBstu7
         JyL8nJ+o1oBgmAb6JacYGm7cN1Z18QWk23pfPi9+YB+q/TQRjfXvoH+yTejFuFdh+lHZ
         LZP5Ug4TdJLa+uuq/RjKts+OgK5nQKX8QWiECSSMwJgZxmhsHeJuV1adBqkpsG727v8N
         h1sAvfzuMVmJ/sRzJ0v/trkNju4E9PjVcQMcPtIzuCkQNa8FFd2hgeFFGjzHgAyck4qB
         AOYSwK+yVGUxQkrbqNS2Y3iMRn0vSFjihezQ9JwaE/2puZx/Vb8IDEUj190vKWWVYT8G
         Ylpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692168407; x=1692773207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfMA8d/EOg/li5lIqvSjinrv9s5gkR6xSHttMnq5lxw=;
        b=Zpq7vNqXkWbuQ7YXABZAlv8JVmyBVcaqMTli0aheBZ4L4GagEzZhIT1seN31fE2Cfz
         sE+GNo/ibrP3yh6l3R6risCj60cHuaOLQT2KbR77WCtxkvOGr79R4ejZbeA2LOZ6P4O5
         Bgrsb//8GXd00NkYHMbuFmXQNEYFOO5YoVJfklc5EdfxtmSIJfJHA5Po7BL3UgnhXjMj
         Wpwm0o+iK6th3zOttnXqTmkJY+qDX50YDR9ybNUDVaBvNNajnoktg35MLoIsP/3d9PCS
         mq6Jucbybxa/zmyzkkLHcq40Nx2xxMctdWuxmaYJgF1VbM42LuI4A5nFZVdNlm52Cqen
         SzLw==
X-Gm-Message-State: AOJu0YyJw+OG8k9NJ95dym94RJIDA4zqueMAHeHexlCmJARD4tg0ptTW
	IIkI15qzcMspghZQVo4WITjbxQ==
X-Google-Smtp-Source: AGHT+IHwi985yvTEWfaXcokQZtx39fVsYWxSYZB3E+6o1HGlHQVx00XLXgkak0vVxRalMbdmToTcig==
X-Received: by 2002:a2e:8013:0:b0:2b9:d79e:7d45 with SMTP id j19-20020a2e8013000000b002b9d79e7d45mr641061ljg.50.1692168407488;
        Tue, 15 Aug 2023 23:46:47 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fbbe41fd78sm20159273wmc.10.2023.08.15.23.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 23:46:46 -0700 (PDT)
Date: Wed, 16 Aug 2023 08:46:45 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	f@nanopsycho.smtp.subspace.kernel.org
Cc: xiyou.wangcong@gmail.com, netdev@vger.kernel.org, vladbu@nvidia.com,
	mleitner@redhat.com
Subject: Re: [PATCH RFC net-next 0/3] Introduce tc block ports tracking and
 use
Message-ID: <ZNxw1eHBdVeGCWH2@nanopsycho>
References: <20230815162530.150994-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815162530.150994-1-jhs@mojatatu.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Aug 15, 2023 at 06:25:27PM CEST, jhs@mojatatu.com wrote:
>In this patchset we introduce tc block netdev tracking infra.
>Patch 1 introduces the infra. Patch 2 exposes it to the datapath and patch 3
>shows its usage via a new tc action "blockcast".

This is very brief. Please describe motivation, how you solve the
problem, provide examples, etc. From the cover letter, the reader should
know what is going on without looking at the patches.


>
>
>Jamal Hadi Salim (3):
>  Introduce tc block netdev tracking infra
>  Expose tc block ports to the datapath
>  Introduce blockcast tc action
>
> include/net/sch_generic.h |   8 +
> include/net/tc_wrapper.h  |   5 +
> net/sched/Kconfig         |  13 ++
> net/sched/Makefile        |   1 +
> net/sched/act_blockcast.c | 315 ++++++++++++++++++++++++++++++++++++++
> net/sched/cls_api.c       |   7 +-
> net/sched/sch_api.c       |  83 +++++++++-
> net/sched/sch_generic.c   |  37 ++++-
> 8 files changed, 463 insertions(+), 6 deletions(-)
> create mode 100644 net/sched/act_blockcast.c
>
>-- 
>2.34.1
>

