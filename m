Return-Path: <netdev+bounces-17167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FBB750B06
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835C9281927
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724EE34CEB;
	Wed, 12 Jul 2023 14:29:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652E31F95D
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:29:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE9F2136
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689172165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=SmfB+i5ITyD8VcQT6H0n4jQbBtZaHz3osNrT9kioxiQ=;
	b=UuFg+m2Yvq/cYBpAgRMODwJ54BqHfYqmezUXh1VJIWgEP0vfhBG1M0pRo81QTilsuArSDw
	W8mdLhVObMlcS1VxSYDBJ10HohWfUJe/NMmNu1iW/HDvI1ejebyhz+z5LaQc6zKYXbXzu/
	HLk7qiwAh7we4NiMCwkxNA8KUHsO9n0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-jmNICAahO96mb6CTK49cKQ-1; Wed, 12 Jul 2023 10:29:24 -0400
X-MC-Unique: jmNICAahO96mb6CTK49cKQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31273e0507dso4504486f8f.3
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689172163; x=1691764163;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmfB+i5ITyD8VcQT6H0n4jQbBtZaHz3osNrT9kioxiQ=;
        b=HSLLs1hT0K5wKQU0fmyRiKgzAXO103d6wuhSNNLpmTB8hC5+rNtOeGIwYjOfvBg2iG
         ofMaNRIybyt+hoz1Q/80DqJ2kwz7GtL0/E4uR0c2uDv9Y32SniL1vikRys0GWqD+hs0M
         ApGuJ31b8Ytqu2qNhg3LHDdYfXU7hAZ3mvNIUg+Tr364It7qB+zG1p6gI9y3BEMBTn8r
         fq0vFGrcQti6PVCbSEUU4dIs5zVSb6fy5Dfqu867u/dFImqYRjgPieNzXri8dcewLout
         wOQiOhNW0umQ/rGikDkzlgIIEbhtEh5bBNf1lpIzA+WapoB1MJBUxp25DnPOy2kwiL8K
         iiug==
X-Gm-Message-State: ABy/qLZ1mVWNAx5yXf2GZHsM4aaV2dZXQXye+78c37mXMYJpTlHkyxyW
	V1YeZXIkQWXugsqo2JOjz7RyA5ZNiV5OWjknvPhYIzbpgoNhd7FSZF8RX51p4EjIUJNLaMT2zku
	s9dohQ1ltWZ8YNw3STplTJhNhmw5qRD2r
X-Received: by 2002:adf:ec8e:0:b0:314:1ebc:6e19 with SMTP id z14-20020adfec8e000000b003141ebc6e19mr17387218wrn.64.1689172163292;
        Wed, 12 Jul 2023 07:29:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrLy4XTfg4SYrDedL3LjN5ZHr+LA3Ut1XmsVNXLi1zBJheiu9Ajx5OzglpHTo4/1SshVrdO+NlkBUDSAisljg=
X-Received: by 2002:adf:ec8e:0:b0:314:1ebc:6e19 with SMTP id
 z14-20020adfec8e000000b003141ebc6e19mr17387145wrn.64.1689172162850; Wed, 12
 Jul 2023 07:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vitaly Grinberg <vgrinber@redhat.com>
Date: Wed, 12 Jul 2023 17:29:12 +0300
Message-ID: <CACLnSDhA1io1tU0rVvuz6KYx3-c_4zEniLEs3KFUqsvLWATYWw@mail.gmail.com>
Subject: Re: [RFC PATCH v9 08/10] ice: implement dpll interface to control cgu
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: David Airlie <airlied@redhat.com>, andy.ren@getcruise.com, anthony.l.nguyen@intel.com, 
	arnd@arndb.de, axboe@kernel.dk, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, claudiajkang@gmail.com, corbet@lwn.net, 
	davem@davemloft.net, edumazet@google.com, geert+renesas@glider.be, 
	gregkh@linuxfoundation.org, hkallweit1@gmail.com, idosch@nvidia.com, 
	intel-wired-lan@lists.osuosl.org, jacek.lawrynowicz@linux.intel.com, 
	Javier Martinez Canillas <javierm@redhat.com>, jesse.brandeburg@intel.com, 
	Jiri Pirko <jiri@resnulli.us>, jonathan.lemon@gmail.com, kuba@kernel.org, 
	kuniyu@amazon.com, leon@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux@zary.sk, 
	liuhangbin@gmail.com, lucien.xin@gmail.com, masahiroy@kernel.org, 
	michal.michalik@intel.com, milena.olech@intel.com, 
	Michal Schmidt <mschmidt@redhat.com>, Michael Tsirkin <mst@redhat.com>, netdev@vger.kernel.org, 
	nicolas.dichtel@6wind.com, nipun.gupta@amd.com, ogabbay@kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, phil@nwl.cc, Petr Oros <poros@redhat.com>, razor@blackwall.org, 
	ricardo.canuelo@collabora.com, richardcochran@gmail.com, saeedm@nvidia.com, 
	sj@kernel.org, tzimmermann@suse.de, vadfed@fb.com, vadfed@meta.com, 
	vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
I'd like to clarify about the DPLL phase offset requirement. We can
live without it during the initial submission. The addition of phase
offset can be an increment to patch v10.
Thanks,
Vitaly


