Return-Path: <netdev+bounces-14508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4FA742207
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D25280D90
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324C88814;
	Thu, 29 Jun 2023 08:22:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F68801
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 08:22:39 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A523A8E
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 01:22:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-313f3a6db22so428674f8f.3
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1688026957; x=1690618957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pnekQegzwsRisctNnmboo1Flv3vcYES0Lp+fckFN5sY=;
        b=QAmw8VvKPSKCa2K72rY2EW7V5lfX1lj+u/ACfv1Lx26QU/dIWS9faLaO9CZ17mMODc
         b6o/klntMdQqnroCYdNwla8FudZSYjpcRttWd5o8K5Gtlq9bcYQWm/SHdoKkCAhs9WW1
         KXp3TvZhEX/NLfsF/peaplmVa7L8ChKCi2Ykc2Gy4gLnFbYvgeDYufZ+b6ZIUq7lR9Ik
         grbNHJXGfMr3ChwJ3EnstUMChWbIT3wqtJDUA5u81A23t9LYLCAoU41TZxGUmHOcBrE/
         P1MM/p/SDZM9S2D59RbMaL94BIUGSkPWAhGmwBDC37C/V4VyCgZN200t/RgDEX7n3TaO
         GkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688026957; x=1690618957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnekQegzwsRisctNnmboo1Flv3vcYES0Lp+fckFN5sY=;
        b=g2wQ15vSwcntXPvsGA9gcXAUyBe5m6vrtx4gyZdBdkyC95+Pe8CaOp5zLDuWGdk5Yv
         yjeX5PXvqm7yoLXRBA/KyJhIDZfT9Sy4Dfax6YHyzzkwa5tnht8YFAxD5LBl4d5IeyL5
         vPH+nfNLacDqdQQLYJXl+IRRDZoGghH6iZuFWlnFGKJfOIbDNmNAYmerGDacBfKMrx9I
         5jz9DL/W08B0Yo/rXj+HnM3M4PDNmrEhz/VC/lwR84GioUVpmgneHBB/qY+znp5ZGWHk
         9OX7/r103UEnbYPXBLhAI8jJt4MvjNmCCYUCu/hBTB1R3jhcP122RybYgraMJwq19BNn
         6m1Q==
X-Gm-Message-State: AC+VfDxBwD/M8dObddcmcJ0fTI6vrCszynuqWYUr4kjqdc0FiDc8Vj9X
	uoBgfpBScJYlHHKyfsDcofoeQQ==
X-Google-Smtp-Source: ACHHUZ4JXzVgHJuPgHk885EhxpRoKdPImG5fW7Lkuhbe5Byutu+bzpvcBvxdLy7fTClkzPvy9enJ1Q==
X-Received: by 2002:a5d:4985:0:b0:313:f5f0:8efa with SMTP id r5-20020a5d4985000000b00313f5f08efamr8300725wrq.18.1688026956848;
        Thu, 29 Jun 2023 01:22:36 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4649000000b0030aefa3a957sm15272550wrs.28.2023.06.29.01.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 01:22:36 -0700 (PDT)
Date: Thu, 29 Jun 2023 10:22:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vitaly Grinberg <vgrinber@redhat.com>
Cc: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	David Airlie <airlied@redhat.com>, andy.ren@getcruise.com,
	anthony.l.nguyen@intel.com, arnd@arndb.de, axboe@kernel.dk,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	claudiajkang@gmail.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, geert+renesas@glider.be,
	gregkh@linuxfoundation.org, hkallweit1@gmail.com, idosch@nvidia.com,
	intel-wired-lan@lists.osuosl.org, jacek.lawrynowicz@linux.intel.com,
	Javier Martinez Canillas <javierm@redhat.com>,
	jesse.brandeburg@intel.com, jonathan.lemon@gmail.com,
	kuba@kernel.org, kuniyu@amazon.com, leon@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux@zary.sk, liuhangbin@gmail.com,
	lucien.xin@gmail.com, masahiroy@kernel.org,
	michal.michalik@intel.com, milena.olech@intel.com,
	Michal Schmidt <mschmidt@redhat.com>,
	Michael Tsirkin <mst@redhat.com>, netdev@vger.kernel.org,
	nicolas.dichtel@6wind.com, nipun.gupta@amd.com, ogabbay@kernel.org,
	Paolo Abeni <pabeni@redhat.com>, phil@nwl.cc,
	Petr Oros <poros@redhat.com>, razor@blackwall.org,
	ricardo.canuelo@collabora.com, richardcochran@gmail.com,
	saeedm@nvidia.com, sj@kernel.org, tzimmermann@suse.de,
	vadfed@fb.com, vadfed@meta.com, vadim.fedorenko@linux.dev
Subject: Re: [RFC PATCH v8 00/10] Create common DPLL configuration API
Message-ID: <ZJ0/StDYFANB1COA@nanopsycho>
References: <CACLnSDhkUA=19905RKk=f1WBkd3jTEDcvytJCgavi90FroXb5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACLnSDhkUA=19905RKk=f1WBkd3jTEDcvytJCgavi90FroXb5w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jun 22, 2023 at 09:44:19AM CEST, vgrinber@redhat.com wrote:
>Hi,
>Could it be possible to add PPS DPLL phase offset to the netlink API? We
>are relying on it in the E810-based grandmaster implementation.

In which driver you need to implement this?


>Thanks,
>Vitaly

