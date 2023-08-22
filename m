Return-Path: <netdev+bounces-29553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BA4783BFB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 10:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDCD1C20A69
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 08:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DC18498;
	Tue, 22 Aug 2023 08:43:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3F16FA6
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:43:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848071A5
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 01:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692693790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h5XqxWunVaUzrBDpvrs6gkk1I+lYx1WTRAGPmsen7MI=;
	b=UpD9fCvU35gDrKsqB8BIPS8gw26gO3Jxq3sBv3F6/3wxYVYhblk8p7Fp/jTd3pRhrefUdu
	zZs7o9rPE/4wnqE7CvcopkQGjMl4bOjRbwIio1zeIEd/+HW3yTQUC/yFcyPNtS7KY01luD
	PFpMITkC/8K+uw5ZEPr/e1H5ORWWGDE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-LEJApO_QOWWLiIjZj7Dotg-1; Tue, 22 Aug 2023 04:43:09 -0400
X-MC-Unique: LEJApO_QOWWLiIjZj7Dotg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a18256038bso36210266b.1
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 01:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692693788; x=1693298588;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h5XqxWunVaUzrBDpvrs6gkk1I+lYx1WTRAGPmsen7MI=;
        b=loj9tZpV5zmAAMxMtt9TH5Eith5Gqu6skmP9pd3koJBhiIDkhm1tm7L6yt3cVAh+DS
         SSbhJ918L76gSSKLP7zzr4hzvIl9gSDMDwKTLK5m6D8M+btwny4vC4QkbLvcctOktjEe
         EM9cfPlazAeKaSFxCCll0ZapyzzToYKgGTHiT51VypZbIM6y8HWxofZ7LPbkixnVfPeH
         EKScucxXZMdl/dG1ceiLHbVw3ySyDPvDfvmm8lWJQQk74llFk3fMgalsCEVAktkf/tf4
         JR0QotJYTurgJCYtXeLo/oiZbCRTKghXUgp8adID3oKf8Qh0K2AM0K4bPk2GHnUXctD0
         Ijaw==
X-Gm-Message-State: AOJu0YxlDkW5ra+oTsW5IOCnvZOSSYv8lB/qDuXrGHdYlQRjKN4FaA2I
	gQh4ahf1s4EFNZb15RONs1GHH7FZj1rpsldsNJ/JT+9NDuO08DKJ24hfHRxyaARmucFe9VSXtv8
	DLCLWjO18FaAPgYW4C1gal7m6
X-Received: by 2002:a17:906:2250:b0:99d:dd4b:4617 with SMTP id 16-20020a170906225000b0099ddd4b4617mr6005067ejr.2.1692693788034;
        Tue, 22 Aug 2023 01:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqA8otikIe2xzYnlEkpSAb2aCg93CXJ4c7/vccgxM/DQtb262y4BMYqGvYkYCQHHCmTA8PJA==
X-Received: by 2002:a17:906:2250:b0:99d:dd4b:4617 with SMTP id 16-20020a170906225000b0099ddd4b4617mr6005055ejr.2.1692693787730;
        Tue, 22 Aug 2023 01:43:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id e16-20020a170906045000b0098dfec235ccsm7783496eja.47.2023.08.22.01.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 01:43:07 -0700 (PDT)
Message-ID: <1d3b98744dfe0ad0f276239b67e84c26c88aa03e.camel@redhat.com>
Subject: Re: [PATCH v1 net] net: Allow larger buffer than peer address for
 SO_PEERNAME.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuni1840@gmail.com, 
	netdev@vger.kernel.org
Date: Tue, 22 Aug 2023 10:43:06 +0200
In-Reply-To: <20230822024011.4978-1-kuniyu@amazon.com>
References: <20230821191113.72311580@kernel.org>
	 <20230822024011.4978-1-kuniyu@amazon.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-08-21 at 19:40 -0700, Kuniyuki Iwashima wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Mon, 21 Aug 2023 19:11:13 -0700
> > On Fri, 18 Aug 2023 17:55:52 -0700 Kuniyuki Iwashima wrote:
> > > For example, we usually do not know the peer name if we get an AF_UNI=
X
> > > socket by accept(), FD passing, or pidfd_getfd().  Then we get -EINVA=
L
> > > if we pass sizeof(struct sockaddr_un) to getsockopt(SO_PEERNAME).  So=
,
> > > we need to do binary search to get the exact peer name.
> >=20
> > Sounds annoying indeed, but is it really a fix?
>=20
> So, is net-next preferable ?
>=20
> I don't have a strong opinion, but I thought "Before knowing the peer
> name, you have to know the length" is a bug in the logic, at least for
> AF_UNIX.

I'm unsure we can accept this change: AFAICS currently
getsockopt(SO_PEERNAME,... len) never change the user-provided len on
success. Applications could relay on that and avoid re-reading len on
successful completion. With this patch such application could read
uninitialized data and/or ever mis-interpret the peer name len.

If the user-space application want to avoid the binary search, it can
already call getpeername().

Cheers,

Paolo


