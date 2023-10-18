Return-Path: <netdev+bounces-42291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A1E7CE128
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A791C20D14
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8F438BDC;
	Wed, 18 Oct 2023 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNzHdGeB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2C915AE2
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:27:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A5410F
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697642854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LO3U/3O7orcDX1UKblPetHP+0g37M+8wNFC9UUNpGbg=;
	b=gNzHdGeBfVV08Mr1gmnugUi7jCdA5oCAuonhsjsigNLJGJGxBkWga0oH32311DvAksyqys
	/1y2LVHBvz/7d5Vx2SR4iRuSJGXqPZaanoJJz2GHZGunZa7pEmjHZSVZcVrpgokZQMAjOU
	6V8f74PL18WzxxG8mkUUnwnBVT7mOoY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428--aapdgDnM_W6SfJDeaCoYg-1; Wed, 18 Oct 2023 11:27:23 -0400
X-MC-Unique: -aapdgDnM_W6SfJDeaCoYg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d35dda745so46250986d6.0
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697642843; x=1698247643;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LO3U/3O7orcDX1UKblPetHP+0g37M+8wNFC9UUNpGbg=;
        b=g+ZS1V8L53cZX0DSDCMk98V+X4376okb+8SC/HL0s5OlWDaZJGfNkaJ8x9O+KFOfAM
         wp6ylEMs9PSnBNZnRsgtXq5pXy4H9JlFU9ilWrdvGLz240nkHR+x4pKFU33KkXCa6jZl
         L5HYDbLBjtdtqJbJ3BVnvij5hyOHhG669ewOoRbz7yuN6BJLjC/9cgUPZITPd8dN8mQl
         9voRaKU30FQd/W7gNArC2Pic0Cil4/mUGzBhooJq+wJBmUVhZvQNhauGjba6MG3wu0bs
         bOsdPexdW7WS6IKqrnbSAZNmkh7B1DaoHgluO8umrvKfkY07xYKdvk667zUGlSgo28Og
         PzJQ==
X-Gm-Message-State: AOJu0Yzr2JSRZ8+MDr9jbp3x5AjHFB3kkqgz934MVTN15G37LqEP6MJZ
	7xKc67cxGrvtWW49Q6CLdjPFCiQykLe0MeN3wlxV3d+Xsj3kBU4ccbEE9jbaQn/lm+xjhSav+AD
	Rp9G2ADRIYBzESx31
X-Received: by 2002:a05:6214:2602:b0:66c:ffe1:e244 with SMTP id gu2-20020a056214260200b0066cffe1e244mr7592514qvb.62.1697642842906;
        Wed, 18 Oct 2023 08:27:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6fCGqNMshOHcVQgHFixpMRES/AbjqtXvQxpoRaWfInZXTWRZ0YrGHrSAVlJmDRabVuafBLg==
X-Received: by 2002:a05:6214:2602:b0:66c:ffe1:e244 with SMTP id gu2-20020a056214260200b0066cffe1e244mr7592455qvb.62.1697642842210;
        Wed, 18 Oct 2023 08:27:22 -0700 (PDT)
Received: from vschneid.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id dy20-20020ad44e94000000b006588bd29c7esm35137qvb.28.2023.10.18.08.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 08:27:21 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David
 Ahern <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Tomas
 Glozar <tglozar@redhat.com>
Subject: Re: [RFC PATCH] tcp/dcpp: Un-pin tw_timer
In-Reply-To: <CANn89iJUicsEdbp7qrsaSUg8jQ=dBUr0nK296LxXp5rnPrw8cA@mail.gmail.com>
References: <20231016125934.1970789-1-vschneid@redhat.com>
 <CANn89i+pQ3j+rb2SjFWjCU7BEges3TADDes5+csEr1JJamtzPQ@mail.gmail.com>
 <xhsmhil74m10c.mognet@vschneid.remote.csb>
 <CANn89iJUicsEdbp7qrsaSUg8jQ=dBUr0nK296LxXp5rnPrw8cA@mail.gmail.com>
Date: Wed, 18 Oct 2023 17:27:18 +0200
Message-ID: <xhsmhfs28lzmx.mognet@vschneid.remote.csb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18/10/23 17:00, Eric Dumazet wrote:
> On Wed, Oct 18, 2023 at 4:57=E2=80=AFPM Valentin Schneider <vschneid@redh=
at.com> wrote:
>
>>
>> Looks reasonable to me, I'll go write v2.
>>
>> Thanks for the help!
>
> Sure thing !
>
> BTW, we also use TIMER_PINNED for req->rsk_timer, are you working on it t=
oo ?

Ah, no, that wasn't on my radar. This hasn't shown up on our systems
yet. From a cursory look it does look like it could lead to similar issues,
I'll add that to my todolist. Thanks!


