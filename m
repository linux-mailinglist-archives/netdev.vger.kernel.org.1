Return-Path: <netdev+bounces-15922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D4674A5E7
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 23:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD025281495
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 21:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD832156CE;
	Thu,  6 Jul 2023 21:30:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAA154AD
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 21:30:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15881BF3
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 14:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688679049;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7jc5Xt5OwHj0jB9aQC+Uq3PbScwoHTvSP8Bz1i/QuU=;
	b=HhlIkRaN+kvZ+PWZS7NlqwOB4mb19wUKNAcaNDPtnaa2fTAjHoKLPZBqi7jPmTRTkk2lF/
	sfyui9RxnpgV20c1l6l9vPnNItJvAUCAnldH01wT7I8oOGOiH4zp0YbslNpvrsPX92fR4i
	aTxnGdKNRGk2wwlZ5tMRjj64YJBN9hw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-uM3K5ZytOtW91RyrY0Citw-1; Thu, 06 Jul 2023 17:30:48 -0400
X-MC-Unique: uM3K5ZytOtW91RyrY0Citw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-766fd51ee68so154910985a.0
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 14:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688679046; x=1691271046;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7jc5Xt5OwHj0jB9aQC+Uq3PbScwoHTvSP8Bz1i/QuU=;
        b=OV/6pAd5nivE4e/s/vIWvs+O5uJXrjw7EYx4mgqVGx/W9rnivpfGeZWNjGPig343Hf
         xasUBrnt/4OudGdV3YOgXSVXaNegh80o2bzQ1fJh2oTkZjCPE3nHdDT8Fag6l7x9JFdB
         /O7MRyh3SYKe/nV5hsnrhExxYR5QKwurNuu0TsGDkTOZh4ySGO7GVI/sNk/CamrHzNcb
         9Vbw4NThRCb6kE1RrKY5+AqcNijsDnEY1l+H1pCYbasmKKiEH+D4piACLv+5VZRaVQ1W
         o2kTLOOLq/mBOMc/rLrqPBSX4PBPr9z4dxp7vyP93f5SNTT+2Y8vTvOvmRwbDVPfQGMt
         U/qw==
X-Gm-Message-State: ABy/qLbicdvvMrJuKFy2WI9KO4UeSY50CxWOAwCoa8ohtFuFUFwbcPl2
	+7mlkB1wVcg89wxFjveCJ2Ky1TFalcISqls5uhnu9z2FATF6PiXISFCLKrN+QNnb/HdSmCxJ0T+
	cCkSJnfNqK0y63XOcj3VxtxQpJAcIi/kYyn9hQMoP7ELFXaYQdKRo4WeptYzYVNZzEcfdNHquQL
	w=
X-Received: by 2002:a05:620a:2493:b0:767:6cd5:ec8b with SMTP id i19-20020a05620a249300b007676cd5ec8bmr8376339qkn.27.1688679046782;
        Thu, 06 Jul 2023 14:30:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHgvJsIbhCSjhTrZoP7QXnDNAQZfTuhcVK1JVsu6+bJKK8QySVPVB5tWG6oX59lKUJk0aCmyA==
X-Received: by 2002:a05:620a:2493:b0:767:6cd5:ec8b with SMTP id i19-20020a05620a249300b007676cd5ec8bmr8376305qkn.27.1688679046478;
        Thu, 06 Jul 2023 14:30:46 -0700 (PDT)
Received: from [192.168.2.56] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id m14-20020a05620a13ae00b00765ac1335c2sm1150488qki.75.2023.07.06.14.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 14:30:45 -0700 (PDT)
Message-ID: <eda7b84e56123bce167a64133572440e6806ef1e.camel@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: Unregister netdev and
 devlink_port only once
From: Petr Oros <poros@redhat.com>
Reply-To: poros@redhat.com
To: netdev@vger.kernel.org
Cc: pmenzel@molgen.mpg.de, intel-wired-lan@lists.osuosl.org, 
 jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
 edumazet@google.com,  anthony.l.nguyen@intel.com, kuba@kernel.org,
 pabeni@redhat.com,  davem@davemloft.net
Date: Thu, 06 Jul 2023 23:30:41 +0200
In-Reply-To: <20230619105813.369912-1-poros@redhat.com>
References: <20230619105813.369912-1-poros@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Petr Oros p=C3=AD=C5=A1e v Po 19. 06. 2023 v 12:58 +0200:
> Since commit 6624e780a577fc ("ice: split ice_vsi_setup into smaller
> functions") ice_vsi_release does things twice. There is unregister
> netdev which is unregistered in ice_deinit_eth also.
>=20
> It also unregisters the devlink_port twice which is also unregistered
> in ice_deinit_eth(). This double deregistration is hidden because
> devl_port_unregister ignores the return value of xa_erase.
>=20
Hi,

Is it possible to push this patch forward? I think the questions have
been answered. Or is something still unclear?

Regards,
Petr


