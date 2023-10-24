Return-Path: <netdev+bounces-43777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E3E7D4BEE
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 062FEB20C92
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AD922F08;
	Tue, 24 Oct 2023 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHuaor/3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E5521A08
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 09:24:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCB4C2
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 02:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698139473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zX4o0gBmLAaG4/9qtaFDnjVgsGB5Bz4c+S6DOjjDtvY=;
	b=QHuaor/3ZhMVw3bHLZ32nqjxXBWUwJPviXtlYn6Lb5cz8B41kQHxkX74QxVYx2G6CloerQ
	TIChvjKpGksyJefN/MUsgyBmpGmD6vTiJLFT9eAY4UrXZDDRSQ53Rs1Rz3XrsM8yG04eVS
	latk38OOf+KUy4jtde1h7sYRYvVQJBo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-DnMzHARgPNCACzoN_Pskyg-1; Tue, 24 Oct 2023 05:24:32 -0400
X-MC-Unique: DnMzHARgPNCACzoN_Pskyg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5401004754cso631761a12.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 02:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698139471; x=1698744271;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zX4o0gBmLAaG4/9qtaFDnjVgsGB5Bz4c+S6DOjjDtvY=;
        b=oNuJjHrXnz7zEZb5JXrQVMvL1jNN8uyM1cc6j6I8CsubHfAD5I+mWwmyLz1u0Flobz
         4ghVNJoMuMBe5tV+gCPxCAQrBYKRaorBbwzT722Kmkx8JUyPchcz89ocD27tD+jyQZF6
         ien4gVY01cXcQXmniijQAAwDjVgeCi7PbAZPdMlqkyl86Sb42JczwYlrXXUL5IvjnaDr
         FofPrahB4Ke8FIx+iMiGwNtJyHkCHLXQdd+8zC5hgqGlLvHQvKxv0isN69VerjZ3xMbg
         nmT7jL4RLYJBCwnYvYhhZghvCCRnR0jHL9vU4FTV+hKsnavN2LqTz3cpXeHarXEDAzkg
         PyCg==
X-Gm-Message-State: AOJu0Yy79yrh1w6VkhwFkbAZ+OJblmff10x86Iq8QSTqf9GbCdOb7i0k
	0RiLHs7sLtu9MLcH5jPMUC66hSmEGheN1QA/xxRmldEVlmIq/vAU/4KSLgnRWQueNg7GnpljKEA
	3L4it6dVuxYexLp3d
X-Received: by 2002:a50:a6dc:0:b0:53f:9243:38e0 with SMTP id f28-20020a50a6dc000000b0053f924338e0mr9657108edc.0.1698139471117;
        Tue, 24 Oct 2023 02:24:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtllyxRIgJgPEKqqcoYxJwRzPOEeGahQKFzUjHLJqdGTZ7IGs2zYx6QZdzlrGyNA8GJ2SKfg==
X-Received: by 2002:a50:a6dc:0:b0:53f:9243:38e0 with SMTP id f28-20020a50a6dc000000b0053f924338e0mr9657095edc.0.1698139470817;
        Tue, 24 Oct 2023 02:24:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-191.dyn.eolo.it. [146.241.243.191])
        by smtp.gmail.com with ESMTPSA id s24-20020a50ab18000000b0053de19620b9sm7803671edc.2.2023.10.24.02.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 02:24:30 -0700 (PDT)
Message-ID: <796915d9964d6470dc035785b83d74b8753d8ca0.camel@redhat.com>
Subject: Re: [PATCH V2] net: ethernet: davinci_emac: Use MAC Address from
 Device Tree
From: Paolo Abeni <pabeni@redhat.com>
To: Adam Ford <aford173@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, aford@beaconembedded.com, Andrew Lunn
 <andrew@lunn.ch>,  Grygorii Strashko <grygorii.strashko@ti.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 24 Oct 2023 11:24:28 +0200
In-Reply-To: <CAHCN7x+ttO7yLkrc80issyjum_P1rcK9d5Keoyfxa-3krz8ssg@mail.gmail.com>
References: <20231022151911.4279-1-aford173@gmail.com>
	 <97e1f76a-3505-4783-838a-10b9cacee8bd@intel.com>
	 <CAHCN7x+ttO7yLkrc80issyjum_P1rcK9d5Keoyfxa-3krz8ssg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-23 at 20:22 -0500, Adam Ford wrote:
> On Mon, Oct 23, 2023 at 7:14=E2=80=AFPM Jacob Keller <jacob.e.keller@inte=
l.com> wrote:
> > Looks like you didn't add the tag for which tree. Given the context, I
> > would assume net-next.
>=20
> That was my intent.  I sent the e-mail to netdev and CC'd others.  I
> thought that was enough.

For future submissions: there are 2 different netdev trees, one for new
features (net-next) and another one for bugfixes (net), and you should
specify the target explcitly in the patch prefix. See:=C2=A0

Documentation/process/maintainer-netdev.rst

for the more details.

Looks like this one is targeting net-next.

Cheers,

Paolo



