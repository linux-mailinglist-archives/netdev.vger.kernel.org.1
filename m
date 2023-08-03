Return-Path: <netdev+bounces-24053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6F576E9FA
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB33A1C21511
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF59A1F179;
	Thu,  3 Aug 2023 13:22:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA71E528
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:22:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36842E48
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 06:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691068938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNTHDdg/8y8LZ/kyOzqf0q4Up0RQizeLF6R2Nz/km3o=;
	b=bakDvd5rFfSJup0hV2VK9NCHVEnIQAdCiHOjC11gbBzBWY9bDrlMBL1im1G9HckLOqlE1W
	yrz3MuBjkWuiR+/AYwXhyv8TyS/TS1Z9whvCNPeuzE50XxavOzRwgfNEXYPkKZSguiAW8p
	KhnsNfFk5Wd7tCiygo7zf9cDcvMWX0Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-cCjFGKTxN-qEsvEmdJc5ZA-1; Thu, 03 Aug 2023 09:22:17 -0400
X-MC-Unique: cCjFGKTxN-qEsvEmdJc5ZA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63cc3a44aedso2294506d6.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 06:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691068936; x=1691673736;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BNTHDdg/8y8LZ/kyOzqf0q4Up0RQizeLF6R2Nz/km3o=;
        b=IFad51Tb8up4TY/ieRvsGQEtaiZ9KTB3O+04qdY1g//6B0QWA8SD13kOP4N263QDDM
         uQnXmoH5ex5DWl84D6buLFubv3PfGopKyHqVu9KsSUAYe1I4NuREgDQ91peiY57qh2/v
         BEUD4nV3Nc/eEk2v5yybYteZRfMzIi4CxPytFVrfJU3cidIMNSBhIX/IsvUgtZxuPq7Y
         eJlm89MDIZXPqxjcwb4m7haD/MRpJJeDlHeQhDAlysgRXJ/VUsQ/CJ47c7CP7aUraMcP
         OS9ZkaW9mMLmH6OsymQzwMpmJpIWau8ez0Es616GZz7soGdRx0N31cBLe5/rGVb6EDnx
         R/+w==
X-Gm-Message-State: ABy/qLa/JrObfgySVd9tbevMJGAtclAKb2RlhNCNTOUjmo2p8zEaGmNf
	m4MDtv/TzFXeAM6F9yc8TfK8q0z4Hsy4yK8Sin7cQXUEu4KvQG+TCietsDP2QrEwiIz51ip7tmY
	AhbbDGKlbJzvLbYFh
X-Received: by 2002:ac8:7d90:0:b0:400:a9a4:8517 with SMTP id c16-20020ac87d90000000b00400a9a48517mr17924161qtd.4.1691068936706;
        Thu, 03 Aug 2023 06:22:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHqLxU/E4sYmLXRhgaw/0xEY4EC2L0mYwpjXh1EAJzhzXzHaIC/+6zCE6ZmGqdXbhMs9U4PhQ==
X-Received: by 2002:ac8:7d90:0:b0:400:a9a4:8517 with SMTP id c16-20020ac87d90000000b00400a9a48517mr17924148qtd.4.1691068936451;
        Thu, 03 Aug 2023 06:22:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-226.dyn.eolo.it. [146.241.226.226])
        by smtp.gmail.com with ESMTPSA id a26-20020ac8001a000000b00403ad6ec2e8sm6217311qtg.26.2023.08.03.06.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 06:22:16 -0700 (PDT)
Message-ID: <8470c431e0930d2ea204a9363a60937289b7fdbe.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 0/5] selftests: openvswitch: add flow
 programming cases
From: Paolo Abeni <pabeni@redhat.com>
To: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Jakub Kicinski
	 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
	 <davem@davemloft.net>, Pravin B Shelar <pshelar@ovn.org>, Adrian Moreno
	 <amorenoz@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
Date: Thu, 03 Aug 2023 15:22:12 +0200
In-Reply-To: <20230801212226.909249-1-aconole@redhat.com>
References: <20230801212226.909249-1-aconole@redhat.com>
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

On Tue, 2023-08-01 at 17:22 -0400, Aaron Conole wrote:
> The openvswitch selftests currently contain a few cases for managing the
> datapath, which includes creating datapath instances, adding interfaces,
> and doing some basic feature / upcall tests.  This is useful to validate
> the control path.
>=20
> Add the ability to program some of the more common flows with actions. Th=
is
> can be improved overtime to include regression testing, etc.
>=20
> v2->v3:
> 1. Dropped support for ipv6 in nat() case
> 2. Fixed a spelling mistake in 2/5 commit message.
>=20
> v1->v2:
> 1. Fix issue when parsing ipv6 in the NAT action
> 2. Fix issue calculating length during ctact parsing
> 3. Fix error message when invalid bridge is passed
> 4. Fold in Adrian's patch to support key masks

FTR, this apparently requires an [un?]fairly recent version of
pyroute2. Perhaps you could explicitly check for a minimum working
version and otherwise bail out (skip) the add-flow tests.

Cheers,

Paolo



