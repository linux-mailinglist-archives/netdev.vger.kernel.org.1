Return-Path: <netdev+bounces-20817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3329376139C
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 13:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCDD1C20DDD
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 11:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6C11EA91;
	Tue, 25 Jul 2023 11:11:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC2D1DDFD
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 11:11:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32679213B
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 04:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690283515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/C2x6UkxDqXMHuNkvu9dHZBiNdozr8nUZzdxBqIYl0o=;
	b=aYfzd4QrW1bVnF1IUvuUZiBBExUtMf138piMmofi6505ohJd0RKepFHkv4MFwd2s/k5T3i
	j7o2MAXJr4P7MS+cxv3fPuXT2cuqdXvOsXbtMZJoCdlNh5t7Z/SyedoxoJLui3Pw0XybJ1
	/vAne6VIg8P0pOvj5kpAFafmLK5Yy6M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-bPqpekYFN1Chf9_urlFjkQ-1; Tue, 25 Jul 2023 07:11:54 -0400
X-MC-Unique: bPqpekYFN1Chf9_urlFjkQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-767b80384a3so100471085a.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 04:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690283513; x=1690888313;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/C2x6UkxDqXMHuNkvu9dHZBiNdozr8nUZzdxBqIYl0o=;
        b=I6ic4HTOz7Y6QZ1FfVdPyzrBU6XcGdJEHxumWQXZP2X/c3ATz8Mst0u50kHY8QpWqN
         UHDPmbjnagYNKGjiqUslwj6s1EBKRYHJFlDKWF3m9lgv5hE+B19yj/e7mQlGrdhUG9mm
         osD7fcahNjRZeZCiFdquwNEnM4xp3mgQG9mYVVsykOIyz+Lle/1LUDjOuJXudtqcPPk8
         AMby9CVAYF3mcPxmeos3btONFJku53FRguNjzIGc0Ow8QzanUVgnjGEPwwoUe2F02nTf
         CHwY57cjwZV3tu2RZFtlaa82TVEWodJieAs7b4SAHyHBkS/8tJFE6CUJInh3mt04NXNR
         m1YA==
X-Gm-Message-State: ABy/qLaw8xTNxx3c4m0DI6ynl5H6PK31eWu7nZ/fiQdT+XfNCOrtRRJN
	BW5tB5mqQ0g1fo4URLBxiqV5oJ7UqQneaytS5ySDKHGI6wGn5sTz9/p6XbJrRBj40KbbNkMyR91
	Ck1qTKkBwV+9vx1oe
X-Received: by 2002:a05:620a:1917:b0:763:d32b:5095 with SMTP id bj23-20020a05620a191700b00763d32b5095mr14463328qkb.6.1690283513572;
        Tue, 25 Jul 2023 04:11:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEuT/2MvivBTtbzSXdj+BPpFrfn3amSvH4jG8mCegWN4L9KpcAYJ+k/7Py8ZTpLwIxbLB4Zqg==
X-Received: by 2002:a05:620a:1917:b0:763:d32b:5095 with SMTP id bj23-20020a05620a191700b00763d32b5095mr14463307qkb.6.1690283513260;
        Tue, 25 Jul 2023 04:11:53 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-81.dyn.eolo.it. [146.241.225.81])
        by smtp.gmail.com with ESMTPSA id ou26-20020a05620a621a00b00767b37256ecsm3594420qkn.107.2023.07.25.04.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 04:11:53 -0700 (PDT)
Message-ID: <e5655b23861d3c4b5684665874c19f37952b2e43.camel@redhat.com>
Subject: Re: [PATCH net-next 1/2] net: store netdevs in an xarray
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	mkubecek@suse.cz, lorenzo@kernel.org
Date: Tue, 25 Jul 2023 13:11:50 +0200
In-Reply-To: <20230724120718.4f01113a@kernel.org>
References: <20230722014237.4078962-1-kuba@kernel.org>
	 <20230722014237.4078962-2-kuba@kernel.org>
	 <20788d4df9bbcdce9453be3fd047fdf8e0465714.camel@redhat.com>
	 <20230724084126.38d55715@kernel.org>
	 <2a531e60a0ea8187f1781d4075f127b01970321a.camel@redhat.com>
	 <20230724102741.469c0e42@kernel.org> <20230724120718.4f01113a@kernel.org>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-07-24 at 12:07 -0700, Jakub Kicinski wrote:
> On Mon, 24 Jul 2023 10:27:41 -0700 Jakub Kicinski wrote:
> > > I still have some minor doubts WRT the 'missed device' scenario you
> > > described in the commit message. What if the user-space is doing
> > > 'create the new one before deleting the old one' with the assumption
> > > that at least one of old/new is always reported in dumps? Is that a t=
oo
> > > bold assumption? =20
> >=20
> > The problem is kinda theoretical in the first place because it assumes
> > ifindexes got wrapped so that the new netdev comes "before" the old in
> > the xarray. Which would require adding and removing 2B netdevs, assumin=
g
> > one add+remove takes 10 usec (impossibly fast), wrapping ifindex would
> > take 68 years.
>=20
> I guess the user space can shoot itself in the foot by selecting=20
> the lower index for the new device explicitly.
>=20
> > And if that's not enough we can make the iteration index ulong=20
> > (i.e. something separate from ifindex as ifindex is hardwired to 31b
> > by uAPI).
>=20
> We can get the create, delete ordering with this or the list, but the
> inverse theoretical case of delete, create ordering can't be covered.
> A case where user wants to make sure at most one device is visible.
>=20
> I'm not sure how much we should care about this. The basic hash table
> had the very real problem of hiding devices which were there *before
> and after* the dump.
>=20
> Inconsistent info on devices which were created / deleted *during* the
> dump seems to me like something that's best handled with notifications.
>=20
> I'm not sure whether we should set the inconsistency mark on the dump
> when del/add operation happened in the meantime either, as=20
> the probability that the user space will care is minuscule.

You convinced me the 'missed device' scenario is not very relevant.=20

The cursor with the dummy placeholder looks error-prone and/or too
invasive to me.

I'm fine with this approach.

Thanks!

Paolo


