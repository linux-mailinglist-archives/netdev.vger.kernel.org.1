Return-Path: <netdev+bounces-39500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E09E7BF8B1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742251C20B86
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E034C6E;
	Tue, 10 Oct 2023 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NS7lJDG1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0F182BF
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:31:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF0CB9
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696933871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1C2ePqqy9Lk6VTckZlTq+a1e83GQqbEDpw2ShG10pB0=;
	b=NS7lJDG1MK+qISuHTrfr/EUh6vCQ2+BSO3fxLtRA5uPS4RAsY5d1DVokL6iYkisWslFh+a
	H0lGbmv3UbDHnWJML7N16JIk6koH0KRlMcolW2jvne4+pRxolELd65zXJxQ4Vtk13aVSxD
	iY34g5ZuzGeTJIe4Kn6eqblz4Q5HE0g=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-AVtV6zdLOtGiQ0rG_RaJ3w-1; Tue, 10 Oct 2023 06:31:10 -0400
X-MC-Unique: AVtV6zdLOtGiQ0rG_RaJ3w-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50301e9e1f0so1398307e87.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696933868; x=1697538668;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1C2ePqqy9Lk6VTckZlTq+a1e83GQqbEDpw2ShG10pB0=;
        b=j+tl/ibVX6ElT8CGlN9IcCNnk14nJVZcxC5UJMK/aA/XJL3U+5n/WcMN5ZBOV52Vx9
         8NtqjuONHb81CQz1RYLEjt1lW5FMiuSjkKXGit9h/CWxUGzpJ7sg9ff15KQJDEFALeaD
         qAXOggpmWtxBdFPMWvzijhKiL6tRQKeib9eMDXiBmMIPO5VDCnt+o/kJ2RUcEcc9AK9t
         5b70xrd38rxQN6mlyshB8hHgDR2buLcPbroLDkoXoz2N/8GC8BaGu0RjLWu4av2Y8b0G
         lVRCL69n8KAE09fqQuld3e7bvAeAJFVe1l51bjuMqU4EQ3gskNBTS597gqaAV3GMd4Pb
         l4ng==
X-Gm-Message-State: AOJu0YzxYrjTxdJC7QQtbIfFWYbYRH3JIlP6vEa8zh8b0PoPBy3tt4x7
	bzH1VY60QIi2jg7CshABGuL9LM79EU/e5S5xGKPdHVlVDP5OQsG8zP+hce57xB0WGLvp6fxy49n
	3qYOHPvFk7iXqfJ4y
X-Received: by 2002:ac2:44af:0:b0:500:8b8d:d567 with SMTP id c15-20020ac244af000000b005008b8dd567mr13954364lfm.1.1696933868576;
        Tue, 10 Oct 2023 03:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4zbsYE0b6xpuabrHTXmkVT5Ih05AnKqJobbYn9oPPUXFCdOy98fOtleNCBIYF/2hGX1lXUg==
X-Received: by 2002:ac2:44af:0:b0:500:8b8d:d567 with SMTP id c15-20020ac244af000000b005008b8dd567mr13954336lfm.1.1696933868226;
        Tue, 10 Oct 2023 03:31:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-243.dyn.eolo.it. [146.241.228.243])
        by smtp.gmail.com with ESMTPSA id o9-20020a05651238a900b004fe7011072fsm1760741lft.58.2023.10.10.03.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 03:31:07 -0700 (PDT)
Message-ID: <417e00407c64ccc39fce35bdb41b6765363d9fb1.camel@redhat.com>
Subject: Re: [PATCH net 4/4] selftests: openvswitch: Fix the ct_tuple for v4
From: Paolo Abeni <pabeni@redhat.com>
To: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc: dev@openvswitch.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Adrian Moreno <amorenoz@redhat.com>, Eelco
 Chaudron <echaudro@redhat.com>
Date: Tue, 10 Oct 2023 12:31:05 +0200
In-Reply-To: <20231006151258.983906-5-aconole@redhat.com>
References: <20231006151258.983906-1-aconole@redhat.com>
	 <20231006151258.983906-5-aconole@redhat.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-10-06 at 11:12 -0400, Aaron Conole wrote:
> Caught during code review.

Since there are a few other small things, please additionally expand
this changelog briefly describing the addressed problem and it's
consequences.

Thanks,

Paolo


