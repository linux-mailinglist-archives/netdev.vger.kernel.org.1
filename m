Return-Path: <netdev+bounces-24368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E46776FF93
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 13:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A732282277
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF453BA31;
	Fri,  4 Aug 2023 11:44:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27FBBA2D
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 11:44:07 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB2A126
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 04:44:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c0cb7285fso265749266b.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 04:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691149443; x=1691754243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lUrFw87J/EonZsTIu0z3e5hVDWlHVAsPZroaJWGrndU=;
        b=I6CePuV8rec44TErYNpEh7q43EZeG2X9O+OiwfaTbq6VN4asHfNUFUmZL2ddBKI923
         MNnWyKnnrUQsj2B0znyo+4zNKrTQcbfJoDS5BeId16nkVOeUUQd4bZq+yr/A61A0BZeC
         eOeityR7cHRW0zDh+BqBc0E5DHmoyDDWdoviE4JSB0y080ovMkt2NPCsGcIvLP49v1C0
         sBVT0/+8/AdXtHWSYVobs5IkTYXz7RhWQ/8c211Bf6PsqxNeGaJyaQPr2WC1dLlMUTd2
         hfuzIldJwSz+KKVsHPPxtlgBZzVnirdLilBKcpG6G7jKutgdiBVt2u/Srmgd5/hGSD1X
         u5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691149443; x=1691754243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUrFw87J/EonZsTIu0z3e5hVDWlHVAsPZroaJWGrndU=;
        b=GGUhteVHHjf091dJ27mrPdrvhVj/JwDFyWIKCLYL61V2gGT8wz3jBGMU15sXba+xiU
         XZScmMx80q8DwBl1RwJvvpdUcMi5QcQNtWnpsid0rBAqfIZOy4Y3u3897sXK6gU4L4cA
         faUT1VUzG/9Bfg42HTBPFWpcvfhXLuX/yEI6eNO6fn4OyAiActKOf+gABL2QQZ+p7tvT
         SQyjTIDr98liU8F5lUaL+kxV+DAD9uT+l7RqrEXFX3/JO9TiRE/3UIW8mzrHl1Hdslz9
         SYgcOhhy1EtPTxmf6VMfsOw4jhNnmLYSkED7NVJO0pruBgdKUNIkabtMvCdhgRaoR68Z
         IsqQ==
X-Gm-Message-State: AOJu0Yye26r9o3gLDQtDHExxGTd/0Qe2NDF70gUWORP5ro3aTTx5Ssyh
	CKefkht2XnD2inrNU4F6VzocyuKg8LxY/OHqxBwPXQ==
X-Google-Smtp-Source: AGHT+IFEMlzXf4WiAWLnZS44Qj06dUQtYm9u2EzVWmz7bK2cWSurZWCyRjII9vFcOg9o4hXNyuxckw==
X-Received: by 2002:a17:906:3f1e:b0:99b:cf4f:9090 with SMTP id c30-20020a1709063f1e00b0099bcf4f9090mr1153798ejj.66.1691149443416;
        Fri, 04 Aug 2023 04:44:03 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id q8-20020a1709066b0800b0098921e1b064sm1173023ejr.181.2023.08.04.04.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 04:44:02 -0700 (PDT)
Date: Fri, 4 Aug 2023 13:44:01 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next 0/2] team: change return value of init and
 getter in the team_option structure to void
Message-ID: <ZMzkgSQTDVhRe18v@nanopsycho>
References: <20230804112825.1697920-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804112825.1697920-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 04, 2023 at 01:28:23PM CEST, shaozhengchao@huawei.com wrote:
>Because the init and getter function always returns 0, so change return
>value of init and getter in the team_option structure to void and remove
>redundant code.

Reading this 5 times, I don't understand the sentence :/

Also, why you send 2 patchsets and 2 seperate patches, all for team? Why
don't you send it as one 6-patch patchset?


>
>Zhengchao Shao (2):
>  team: change return value of init in the team_option structure to void
>  team: change return value of getter in the team_option structure to
>    void
>
> drivers/net/team/team.c                   | 60 +++++++++--------------
> drivers/net/team/team_mode_activebackup.c |  8 ++-
> drivers/net/team/team_mode_loadbalance.c  | 39 ++++++---------
> include/linux/if_team.h                   |  4 +-
> 4 files changed, 44 insertions(+), 67 deletions(-)
>
>-- 
>2.34.1
>

