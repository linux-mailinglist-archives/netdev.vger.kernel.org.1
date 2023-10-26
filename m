Return-Path: <netdev+bounces-44403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D521A7D7D8C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 09:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A33B211FE
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 07:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EAE11C84;
	Thu, 26 Oct 2023 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiunzlF0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E254A50
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 07:22:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44419116
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 00:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698304932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZJkB38/zw4XAEeeCL9Roq4pYoTYCFvhY7CDxbqwXS0=;
	b=AiunzlF0s2HMU1sz+dFgNkYX7IvZgc81ZEgxHKYSC/i/7e9p2dLzXZUFrXYDujlDwyKWhJ
	2RrbTuch1TSYWGiblfXr6O4iWmA/k6pyUtgTCRs8skl69mMjqjkWXt6aQLqFAQJyyPuhWU
	Jl6xE9Q6S/MqefSdRYAa48prGgbfurw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-7Lpd8Mn_NIa0l26T_ZlmNA-1; Thu, 26 Oct 2023 03:22:10 -0400
X-MC-Unique: 7Lpd8Mn_NIa0l26T_ZlmNA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9c167384046so1848066b.0
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 00:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698304929; x=1698909729;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ZJkB38/zw4XAEeeCL9Roq4pYoTYCFvhY7CDxbqwXS0=;
        b=PSU6VXm2RYP9/3aER/9McPZx9K/2/Hb7V5tvdYP4sWahfLodISMDuzyEiAfXKfYXTL
         0Di/jmBanjQnV5iDyhUd0K2XEIo+x/peBfI1XcM7kiRPxbqDcPl2Q2+sgZSGqnqVVzy3
         ajQCueSM8bLHPaXIhP3DukysSzCpKk/aaYNFmJQDa2mGUIQKnzQt40D+Da7E+/XLk4IW
         RT7fAeu/Us/0msX7TyAjACdLhqT7LCt7niOtVq9XdWMHf5Lni12RJ7hKZzPfQ4ZHzJaL
         rnS30NFLvO/FiyL8VW7KL8ONq+fxwkOAWWPoJc+TqIwRmrZ4zDqbEoZR7IgAZQM0xFWf
         PEQA==
X-Gm-Message-State: AOJu0YyzkhZwkfoxAFgIrMbkI2QbduvGEWOXL7uaTbv5CdUpsSLFa/1f
	rGDGksDhTuTva8et4LfIC90dO3pjJjZy01j/Z3Jf/lFBQzL0qlU6UTkXz0LxMiVVhK/bhdlYK9w
	gZ2A74wkQlYS/zCdv
X-Received: by 2002:a17:906:6d8f:b0:9c9:603c:407e with SMTP id h15-20020a1709066d8f00b009c9603c407emr8068032ejt.0.1698304929379;
        Thu, 26 Oct 2023 00:22:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiqm3J1X0mq1YRAUrKSxwrYawpgs3wu4cuGHSmjF2OVu9Mp1a/tpcR0y8zIaFQ4jGcVwc1RA==
X-Received: by 2002:a17:906:6d8f:b0:9c9:603c:407e with SMTP id h15-20020a1709066d8f00b009c9603c407emr8068018ejt.0.1698304929028;
        Thu, 26 Oct 2023 00:22:09 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-52.dyn.eolo.it. [146.241.245.52])
        by smtp.gmail.com with ESMTPSA id vl9-20020a170907b60900b00989828a42e8sm11040909ejc.154.2023.10.26.00.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 00:22:08 -0700 (PDT)
Message-ID: <5436a58dc63d7e7cc2cb2fbda722f0c0406e88bf.camel@redhat.com>
Subject: Re: [PATCH] Fix termination state for idr_for_each_entry_ul()
From: Paolo Abeni <pabeni@redhat.com>
To: NeilBrown <neilb@suse.de>, netdev@vger.kernel.org, "David S. Miller"
	 <davem@davemloft.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox
 <willy@infradead.org>,  Chris Mi <chrism@mellanox.com>, Cong Wang
 <xiyou.wangcong@gmail.com>
Date: Thu, 26 Oct 2023 09:22:07 +0200
In-Reply-To: <169810161336.20306.1410058490199370047@noble.neil.brown.name>
References: <169810161336.20306.1410058490199370047@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-10-24 at 09:53 +1100, NeilBrown wrote:
> The comment for idr_for_each_entry_ul() states
>=20
>   after normal termination @entry is left with the value NULL
>=20
> This is not correct in the case where UINT_MAX has an entry in the idr.
> In that case @entry will be non-NULL after termination.
> No current code depends on the documentation being correct, but to
> save future code we should fix it.
>=20
> Also fix idr_for_each_entry_continue_ul().  While this is not documented
> as leaving @entry as NULL, the mellanox driver appears to depend on
> it doing so.  So make that explicit in the documentation as well as in
> the code.
>=20
> Fixes: e33d2b74d805 ("idr: fix overflow case for idr_for_each_entry_ul()"=
)
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Chris Mi <chrism@mellanox.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: NeilBrown <neilb@suse.de>

Since the affected user is in the netdev tree, I think we can take this
patch. But this is also a sort of gray area of the tree... @Matthew are
you ok with that?

Thanks,

Paolo


