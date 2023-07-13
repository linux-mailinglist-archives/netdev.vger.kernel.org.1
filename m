Return-Path: <netdev+bounces-17415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C2775182C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AB6281B7E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 05:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC1D53AB;
	Thu, 13 Jul 2023 05:34:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF853A4
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:34:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256AB172C
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 22:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689226453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=SmfB+i5ITyD8VcQT6H0n4jQbBtZaHz3osNrT9kioxiQ=;
	b=NqdSY9QUqllBHTpPVoWI3R2S5L8Go75LijLMG8At1Ttr4M1bqFIPZnW+Bv+4dndT4DFynH
	cWLhSvcbJMqJbOrX0EVRk+ws1JDHFKQNMEQ8hIbhldrsSQ78WKlLW6r8vCS7m35sky4sXH
	8e43CBxa6HpJDr/6x7QvyyjZjB2ID6s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-lswXP0WBPIu0iGQ8v9BE9A-1; Thu, 13 Jul 2023 01:34:12 -0400
X-MC-Unique: lswXP0WBPIu0iGQ8v9BE9A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-315926005c9so267954f8f.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 22:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689226451; x=1691818451;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmfB+i5ITyD8VcQT6H0n4jQbBtZaHz3osNrT9kioxiQ=;
        b=jRR9uKzd9uJTD+vGdeToApsc5gf0Y2TY6qdOaj7PIDGpX75OyVkU15R2NtGrh6YKkC
         KtLT+2Kf86DeiWTAfH//7ytMWpnRyXTT0j0/tsOO6u56X3MfuTO+1vXHewfOCU48UMSu
         BQ4yMHBEDhSLx+ZPuy9fw2It/U2k/cIiX9IpDfSo7c56Mv46nYvj7cflyOaxhEuDyTLI
         wpgGbPHlownAZLDSZNKmHGjpHY7zVPNvjv+/ALHImdnrmJen8iiqZo/MMX3QaxwsECi3
         +YtLNAN1MOWdSxprsx6uQh7AEoPLnNJO7HBwwtyL5mtsNggoeY3hsNBnn97Y7/do7XYL
         GXxA==
X-Gm-Message-State: ABy/qLY88TypXUA/on+CiyXzQTDkyKkclRMpHLMchhUT5e4z9uCADqZ0
	/AJ8H0WV2j62uCFQNMpHXSQB2cwXOttVcbFF+SeFyN6Izzkool75LVDsIoovNOfjQQFK4ym9a5N
	qif1psgWls3TW/YoOIb+JnAo2jXJh2ZFq
X-Received: by 2002:a05:6000:92:b0:314:35c2:c4aa with SMTP id m18-20020a056000009200b0031435c2c4aamr467020wrx.8.1689226450844;
        Wed, 12 Jul 2023 22:34:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGOJnBSbefoa2jYNguz42ZsRuZYJIodpjHhXJuzkLT9wNSNcgOUvRAkGCM4TmbRTEw+GkFxz47vkJZ0YZi65gI=
X-Received: by 2002:a05:6000:92:b0:314:35c2:c4aa with SMTP id
 m18-20020a056000009200b0031435c2c4aamr466974wrx.8.1689226450472; Wed, 12 Jul
 2023 22:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vitaly Grinberg <vgrinber@redhat.com>
Date: Thu, 13 Jul 2023 08:33:59 +0300
Message-ID: <CACLnSDiMD+BH_BBHQUAhSvfqe6jhnm4MOB2N_hog4VMhvdTYVg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 00/10] Create common DPLL configuration API
To: Jiri Pirko <jiri@resnulli.us>
Cc: David Airlie <airlied@redhat.com>, andy.ren@getcruise.com, anthony.l.nguyen@intel.com, 
	"Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, arnd@arndb.de, axboe@kernel.dk, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, claudiajkang@gmail.com, corbet@lwn.net, 
	davem@davemloft.net, edumazet@google.com, geert+renesas@glider.be, 
	gregkh@linuxfoundation.org, hkallweit1@gmail.com, idosch@nvidia.com, 
	intel-wired-lan@lists.osuosl.org, jacek.lawrynowicz@linux.intel.com, 
	Javier Martinez Canillas <javierm@redhat.com>, jesse.brandeburg@intel.com, jonathan.lemon@gmail.com, 
	kuba@kernel.org, kuniyu@amazon.com, leon@kernel.org, 
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


