Return-Path: <netdev+bounces-35411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C2F7A9637
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF4A1C20BCE
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B372FBA45;
	Thu, 21 Sep 2023 17:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E2199CD
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:00:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD5E170E
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695315495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjlW5/nkiHXJH3GhT21toiBFzmwwGNNfgIoe1kliIVI=;
	b=BQLIso7X8VCvD1YNygpuDAPy9UKT9LULAhlKxln+TnZmD4KETEWzvKJ6cAUcxX116f9fPR
	yjqOr7i1POtqXnpvtWb5dK7smSRRlhLaw+T3KbPmaYVKmSxjuJvQCLX6wJ94NDqcOIy8hW
	Q5athBGeOnUPu4ALQmTtPvBw6Pmmilw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-lVCUqVKDMe20kvtU_L4Bxw-1; Thu, 21 Sep 2023 05:33:51 -0400
X-MC-Unique: lVCUqVKDMe20kvtU_L4Bxw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2bbc1d8011dso8477301fa.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 02:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695288830; x=1695893630;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjlW5/nkiHXJH3GhT21toiBFzmwwGNNfgIoe1kliIVI=;
        b=hIvTLFIsOZ15rEagYe6OhAv4aQhGWnGW8pPN3hCaEEviwe45pRald1hjVFDqM/HEHC
         BxEMY+18VM4dIuHAFyNU9XGouz0TQ5opT5Rj0WgcoVFJOl4wIEtH+rYMWSQ1OEgKJCrR
         O3DgBbzkGo5wjLA7P+hcQZYkzhlVfnWZS6KMpQBTqHYFJ6A7q2lFi4MrqybsFkE7i5CO
         vSb0cBHlg9BNBncN7DMqe68fFEb/stdc9F/x+Cv7wYhnlBn8I8WBmulHOm5glVeuyT2s
         e8MDNU0V3rh6VV5oOtJdwDuL58AdPjopMpzYJbXMaLJV4YTyTw7thw9XI+D46n+3GsDR
         AUSw==
X-Gm-Message-State: AOJu0Yy+qFhBUZAZ/KP3S5YH2aatmceBstYb2BvaU/iI9bYnajf0VYn7
	/Nh+98qX043v5ZjQcW/sfRerXbnkIhybwt3GJnkPWTfLXaRxOAj/Twoy8V5/BLDDp0TTL47+Ls0
	RGej07mxbGujTe48d
X-Received: by 2002:a2e:80d9:0:b0:2bd:133c:58ff with SMTP id r25-20020a2e80d9000000b002bd133c58ffmr4271747ljg.48.1695288830261;
        Thu, 21 Sep 2023 02:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm1jUHOyUKYrFDw8a7X453DCmL8OOKZszp3CMfIm8NWLcGqlwMvFpb3H0+KVRbyUfon5swUw==
X-Received: by 2002:a2e:80d9:0:b0:2bd:133c:58ff with SMTP id r25-20020a2e80d9000000b002bd133c58ffmr4271729ljg.48.1695288829894;
        Thu, 21 Sep 2023 02:33:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906614800b009828e26e519sm748333ejl.122.2023.09.21.02.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 02:33:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D089FE25AEE; Thu, 21 Sep 2023 11:33:48 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Soheil Hassas
 Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, Cong
 Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 0/5] net_sched: sch_fq: round of improvements
In-Reply-To: <CAF=yD-LZmJ-a0kO8UtKaj+NTwYaRFQfZkDVHTthz4gNYJfCN4w@mail.gmail.com>
References: <20230920201715.418491-1-edumazet@google.com>
 <CAM0EoMm87U7sGESCtcekr-Avsx4+WMnOS7HuNztJdE=G8VFs+g@mail.gmail.com>
 <CAF=yD-LZmJ-a0kO8UtKaj+NTwYaRFQfZkDVHTthz4gNYJfCN4w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 21 Sep 2023 11:33:48 +0200
Message-ID: <87pm2blvk3.fsf@toke.dk>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:

> On Wed, Sep 20, 2023 at 7:22=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
>>
>> On Wed, Sep 20, 2023 at 4:17=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
>> >
>> > For FQ tenth anniversary, it was time for making it faster.
>> >
>> > The FQ part (as in Fair Queue) is rather expensive, because
>> > we have to classify packets and store them in a per-flow structure,
>> > and add this per-flow structure in a hash table. Then the RR lists
>> > also add cache line misses.
>> >
>> > Most fq qdisc are almost idle. Trying to share NIC bandwidth has
>> > no benefits, thus the qdisc could behave like a FIFO.
>> >
>> > This series brings a 5 % throughput increase in intensive
>> > tcp_rr workload, and 13 % increase for (unpaced) UDP packets.
>> >
>> > v2: removed an extra label (build bot).
>> >     Fix an accidental increase of stat_internal_packets counter
>> >     in fast path.
>> >     Added "constify qdisc_priv()" patch to allow fq_fastpath_check()
>> >     first parameter to be const.
>> >     typo on 'eligible' (Willem)
>>
>> For the patchset:
>> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Might as well join the party - nice set of improvements! :)

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


