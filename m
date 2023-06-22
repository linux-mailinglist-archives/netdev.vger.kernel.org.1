Return-Path: <netdev+bounces-12946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 712D2739891
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 09:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC8D1C21041
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B47DDDAB;
	Thu, 22 Jun 2023 07:55:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F55E1FB4
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 07:55:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B0B199F
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 00:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687420508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Eox6kzJ0KXGmAxPu1zCtO8SWj1o8YH/kpH0QF8X1TQs=;
	b=Q3SnjzHyYy+Zr+rIoGHg9gpaNMMNOOxtqgzj87cZyM2v88Ka28jZ1jud6UmS0sJeFmjOrH
	e6xGsThEl2gBx6IoAVUxNMxLZ+WH1IY8Ygi8zP1xSUjzH7M0uUH9VRstISRSW4rij2KPHg
	ZbB0ZiI+2bDfchXPXdSEi+AMTRYxXAo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-6zPncc5xMd20jIR0oR_5ow-1; Thu, 22 Jun 2023 03:55:06 -0400
X-MC-Unique: 6zPncc5xMd20jIR0oR_5ow-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31273e0507dso1843819f8f.3
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 00:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687420505; x=1690012505;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eox6kzJ0KXGmAxPu1zCtO8SWj1o8YH/kpH0QF8X1TQs=;
        b=BItj8NZQEB5KFipsR6j24PCcwY9tUjbQ5nrUJag9Z7JZLL8BTf+ODQ/lxrMPWUQ8qD
         J5nQExC9NlHd3NIIauBEwuvbJAbk91coTXN1xppzGq39X/MH51mGezof+S+7GeUFynv0
         0/RmWgU4amd1Pkat0xxTSvLyPOLQ8AOZNJdNZTJjNGYQ6D5WsDQXhpadzyvyRtRGEGZ1
         x6N0TgK0p0V2PoU659CsTUhn8kOeyVp3nAcfrGAg/oqOTnjb6uBtQQN1Is7L8Zus/lDJ
         BcaNTS6AEwoaBNWvJyl+LxrluWA+qQOOlXbubcuXktcX4RBr2Sx8B1mkCwDvAJL557PU
         qAYw==
X-Gm-Message-State: AC+VfDwTBJ4FPtFJiYRgu8siOZXyK7wZqAaySk+REXpJpWYVv3xYQfMu
	CZf1Qg/0zaFZAIbaYQMEutQEynKlbyCsUHrb5gfWx/ZnJY1S5DvuG5eTdSBnph5+Oay1CY7Ribw
	HTIwFYbIOoQlhY6+Bk/eXTd5YNKie7QX/
X-Received: by 2002:a5d:590c:0:b0:30a:8995:1dbc with SMTP id v12-20020a5d590c000000b0030a89951dbcmr13481441wrd.26.1687420505050;
        Thu, 22 Jun 2023 00:55:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5XXdP5mBFYeXjHFqCUFXHfOsqZzMCP4KunAaLqWfIWum2C8ZQg8p8aPknYzd7pBcBBJ2gzkZCOOq3kQ/vNoxc=
X-Received: by 2002:a5d:590c:0:b0:30a:8995:1dbc with SMTP id
 v12-20020a5d590c000000b0030a89951dbcmr13481390wrd.26.1687420504759; Thu, 22
 Jun 2023 00:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vitaly Grinberg <vgrinber@redhat.com>
Date: Thu, 22 Jun 2023 10:54:54 +0300
Message-ID: <CACLnSDiBML3R_K5ncFsuritvid5nGsBLx5pGR2c9pR9L=qhPiQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 00/10] Create common DPLL configuration API
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: David Airlie <airlied@redhat.com>, andy.ren@getcruise.com, anthony.l.nguyen@intel.com, 
	arnd@arndb.de, axboe@kernel.dk, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, claudiajkang@gmail.com, corbet@lwn.net, 
	davem@davemloft.net, edumazet@google.com, geert+renesas@glider.be, 
	gregkh@linuxfoundation.org, hkallweit1@gmail.com, idosch@nvidia.com, 
	intel-wired-lan@lists.osuosl.org, jacek.lawrynowicz@linux.intel.com, 
	Javier Martinez Canillas <javierm@redhat.com>, jesse.brandeburg@intel.com, jiri@resnulli.us, 
	jonathan.lemon@gmail.com, kuba@kernel.org, kuniyu@amazon.com, leon@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux@zary.sk, liuhangbin@gmail.com, 
	lucien.xin@gmail.com, masahiroy@kernel.org, michal.michalik@intel.com, 
	milena.olech@intel.com, Michal Schmidt <mschmidt@redhat.com>, 
	Michael Tsirkin <mst@redhat.com>, netdev@vger.kernel.org, nicolas.dichtel@6wind.com, 
	nipun.gupta@amd.com, ogabbay@kernel.org, Paolo Abeni <pabeni@redhat.com>, phil@nwl.cc, 
	Petr Oros <poros@redhat.com>, razor@blackwall.org, ricardo.canuelo@collabora.com, 
	richardcochran@gmail.com, saeedm@nvidia.com, sj@kernel.org, 
	tzimmermann@suse.de, vadfed@fb.com, vadfed@meta.com, 
	vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
Could it be possible to add PPS DPLL phase offset to the netlink API?
We are relying on it in the E810-based grandmaster implementation.
Thanks,
Vitaly


