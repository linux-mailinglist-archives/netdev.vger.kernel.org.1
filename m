Return-Path: <netdev+bounces-14222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816EA73FA06
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 12:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13771281044
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 10:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A98174E7;
	Tue, 27 Jun 2023 10:18:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F141C10F9
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 10:18:39 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FA03C15
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 03:18:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-313e34ab99fso3557762f8f.1
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687861101; x=1690453101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gT7GboGGDk7AitS54Ow1poGL7UR1gfZLBCd0QKdV4C0=;
        b=C5OXmNsX0m80OIL6Emr3JWyhtE0S88G7Rwlsr6ZmfJU130SsETmmm6+Ce6D9TL1Gz8
         nDoBo+bvQGs6hMHJoPMI3jmFchyOb5ggBoDyzMzwB3l/DFkSZVi8LIqb99E7t0K7IiWh
         6uNrq1/A/CUTpd7fCD/3Kvpfd0Cqs2VWR6zUajX6+4UiDtM84yFga/qi2QD5GNSb6yZI
         OZEY8BdqDtB3AjzNVqO9QSby+3KFiKFHnFMY7wdtW4B+V54Gbbk1wPnSRIlNU68+niLX
         rkP/hxL4xyd7j1h27zQw0raPbp3oAHhgriG7W5v5BHo71+8tBHHQ0UEwjElbpVakhs8m
         XyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687861101; x=1690453101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gT7GboGGDk7AitS54Ow1poGL7UR1gfZLBCd0QKdV4C0=;
        b=inEMfwHGZ95t+GbqqcjOsyELkTmCsWHJ5ULMg9y0gNIsZI+3sGSN13XwMUyrGf+axS
         Mje2t0m8zDL97anJzF9aJWkwB26sdKrXRfbsfJq6BNX9J+ic+JehaewxzqcIceD5ibqY
         6CtNQ9DnSgt4ce/qm1euTu8bhlT1smSqClfp7++TX5wuDyyUiJk4QFbbpuWUaqdeDMfT
         uoepRTSubfrztN9PNDIUchGc+noVlVhM0/RrABA+rYc2O5GuW6FcTLQfoSmD322WPhD6
         Rhg6xaliINxC2HNIB6AwM2EwEa7E2ud5lG/LogJHjeqLW241Nrq1886CkviGWEtBw607
         mdRQ==
X-Gm-Message-State: AC+VfDzJqNsU1xnxrhfbhnjZS8622K9wLFtD67V553l7S3/F7VtlkxhE
	SMI7YXWqJ6FxqOnA56Su7RoGbA==
X-Google-Smtp-Source: ACHHUZ6IABQj80YZlbwlRcPCQeFmBfCPH/Nv02/YbE4SHjy4A9ioFacLP6XEwynurT1i4MOWCkpn+w==
X-Received: by 2002:a5d:5009:0:b0:313:e146:1816 with SMTP id e9-20020a5d5009000000b00313e1461816mr7669279wrt.24.1687861101257;
        Tue, 27 Jun 2023 03:18:21 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id cx16-20020a056000093000b00301a351a8d6sm10065190wrb.84.2023.06.27.03.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 03:18:20 -0700 (PDT)
Date: Tue, 27 Jun 2023 12:18:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: kuba@kernel.org, vadfed@meta.com, jonathan.lemon@gmail.com,
	pabeni@redhat.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, vadfed@fb.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
	richardcochran@gmail.com, sj@kernel.org, javierm@redhat.com,
	ricardo.canuelo@collabora.com, mst@redhat.com, tzimmermann@suse.de,
	michal.michalik@intel.com, gregkh@linuxfoundation.org,
	jacek.lawrynowicz@linux.intel.com, airlied@redhat.com,
	ogabbay@kernel.org, arnd@arndb.de, nipun.gupta@amd.com,
	axboe@kernel.dk, linux@zary.sk, masahiroy@kernel.org,
	benjamin.tissoires@redhat.com, geert+renesas@glider.be,
	milena.olech@intel.com, kuniyu@amazon.com, liuhangbin@gmail.com,
	hkallweit1@gmail.com, andy.ren@getcruise.com, razor@blackwall.org,
	idosch@nvidia.com, lucien.xin@gmail.com, nicolas.dichtel@6wind.com,
	phil@nwl.cc, claudiajkang@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, poros@redhat.com,
	mschmidt@redhat.com, linux-clk@vger.kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [RFC PATCH v9 00/10] Create common DPLL configuration API
Message-ID: <ZJq3a6rl6dnPMV17@nanopsycho>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Jun 23, 2023 at 02:38:10PM CEST, arkadiusz.kubalewski@intel.com wrote:

>v8 -> v9:

Could you please address all the unresolved issues from v8 and send v10?
I'm not reviewing this one.

Thanks!

