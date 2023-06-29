Return-Path: <netdev+bounces-14514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B000474237D
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 11:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C620F1C2031A
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 09:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC440AD37;
	Thu, 29 Jun 2023 09:49:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C132A17CA
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 09:49:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC712118
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 02:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688032156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+plDWhXJtyP1/dor5ycSeAGAv25H1fG419rVN4fUTjE=;
	b=goOCCLAYBGBVdWplg8owaMLfYiSMok2Pg4vbW8AaATMbdTDSeKcNkeOtqJy30rBcknHzkL
	9LOquw2b36iI+Rf98e5dRxQldkKsBGsJ2aPjk6v/bndyUIBSwjgzDm6tYUknhRpA4ywhbh
	xY2AR/BopAsMpv183Xq7/UufZbJrOdI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-sJwllddeMkKsAJsjhJyKwQ-1; Thu, 29 Jun 2023 05:49:14 -0400
X-MC-Unique: sJwllddeMkKsAJsjhJyKwQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-765ad67e600so11851085a.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 02:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688032154; x=1690624154;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+plDWhXJtyP1/dor5ycSeAGAv25H1fG419rVN4fUTjE=;
        b=fnNyik1QKJ/DE7149SgQB3auVX+NGxu/ORqpslw5FV9kogT2CZ9ofrRqNfHmj8ppj0
         8y66OOAH4cWDivXwL66HqfslCnfxOcwPca5UMN24dvlcH2H8qhU1S5RvXXsZsiPr73XO
         V/GHe2Auytya/rJUntGC2YROmLhd9w4wE8M0dwkdzNAbjZyXlE337/l51lWUSGxwrbri
         TMd1z2olTXwZ1nncf+dmi8BJqTH2IxMklZP8yjsMrEFE2cOki2PIcUoZS5jgg+SWupMf
         5cJVAyCWfLyGGXWsPnSxSg0r9y9hLkiJCiYTwd8QL+RvALtc1ZSx4XbdBekA7JGB2S8d
         lfog==
X-Gm-Message-State: AC+VfDzcJlOGMI1BVWJ7QKti+QD7QTfj0CMDGXdiPlJGPFEfp2v3uMcH
	Ixxnp3PKwLmj0L0/mOXXY1/80orxh1b5g59QbU0ZyzTB7agx3WkCPAQl5lIsNaFBlAXA6LrvqrM
	1ZexnQ+5FXcG3HrNp
X-Received: by 2002:a05:620a:17a7:b0:762:63b:e10b with SMTP id ay39-20020a05620a17a700b00762063be10bmr2482837qkb.1.1688032153901;
        Thu, 29 Jun 2023 02:49:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6MKPncSPkT64a18nfrR8NCaqw0ntVMDGfolGCj0p8kbs2JxhSlGadGp2eLULzHfa6tC9JYQg==
X-Received: by 2002:a05:620a:17a7:b0:762:63b:e10b with SMTP id ay39-20020a05620a17a700b00762063be10bmr2482821qkb.1.1688032153602;
        Thu, 29 Jun 2023 02:49:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-196.dyn.eolo.it. [146.241.231.196])
        by smtp.gmail.com with ESMTPSA id oo26-20020a05620a531a00b0076715ec99dbsm2323858qkn.133.2023.06.29.02.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:49:13 -0700 (PDT)
Message-ID: <17efd9ffd0bd8a36e18de587d0fbdb511457559b.camel@redhat.com>
Subject: Re: [PATCH] sctp: fix potential deadlock on &net->sctp.addr_wq_lock
From: Paolo Abeni <pabeni@redhat.com>
To: Chengfeng Ye <dg573847474@gmail.com>, marcelo.leitner@gmail.com, 
 lucien.xin@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 29 Jun 2023 11:49:09 +0200
In-Reply-To: <20230627120340.19432-1-dg573847474@gmail.com>
References: <20230627120340.19432-1-dg573847474@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-06-27 at 12:03 +0000, Chengfeng Ye wrote:
> As &net->sctp.addr_wq_lock is also acquired by the timer
> sctp_addr_wq_timeout_handler() in protocal.c, the same lock acquisition
> at sctp_auto_asconf_init() seems should disable irq since it is called
> from sctp_accept() under process context.
>=20
> Possible deadlock scenario:
> sctp_accept()
>     -> sctp_sock_migrate()
>     -> sctp_auto_asconf_init()
>     -> spin_lock(&net->sctp.addr_wq_lock)
>         <timer interrupt>
>         -> sctp_addr_wq_timeout_handler()
>         -> spin_lock_bh(&net->sctp.addr_wq_lock); (deadlock here)
>=20
> This flaw was found using an experimental static analysis tool we are
> developing for irq-related deadlock.
>=20
> The tentative patch fix the potential deadlock by spin_lock_bh().

Patch LGTM.

Please note that the above suggests a possible net-next follow-
up/cleanup, replacing the spin_lock_bh() in
sctp_addr_wq_timeout_handler() with a simple/faster spin_lock() - since
sctp_addr_wq_timeout_handler() runs with BH disabled. Anyhow net-next
is closed now, it will have to wait a bit ;)

Cheers,

Paolo


