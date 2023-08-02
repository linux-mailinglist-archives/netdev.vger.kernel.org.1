Return-Path: <netdev+bounces-23563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D9A76C7D8
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBE3281D42
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AA053B1;
	Wed,  2 Aug 2023 08:03:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200A353A7
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:03:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1551E212A
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 01:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690963401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oo+8dg/DBj2V+G5oZvUMnojMP7aeWCXmA1VlhFSPE34=;
	b=SXn6W5xWy8NeVTte4GPeviFPpf2UqFaOMoJD58BA5unExfin1QiHN7Bx30n2mntnThe6pO
	HKLcdRogmd1E/GpxFp1HLd7N+E4h6iZ3ILh41epV4Gfcyftt4OfQQc73ja1yizO77Mor6r
	PMBYc6c3XwjGlMNrzxJg6jw+RLHAaf4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-l4jOXHkmPuq-HgZlplOzEw-1; Wed, 02 Aug 2023 04:03:20 -0400
X-MC-Unique: l4jOXHkmPuq-HgZlplOzEw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76cd4e1628eso2861785a.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 01:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690963399; x=1691568199;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oo+8dg/DBj2V+G5oZvUMnojMP7aeWCXmA1VlhFSPE34=;
        b=FzGZvOLtWBTJ0glHV5itisdMm1dxoGZXZ3yKI6gLTnvMhRntAh+Ho9Kl4ibwetE322
         Bgp2mbAEGSCbbO4NKVvtFdNfe6bpI2hwLXvpjLkwJF64WuLhkoOdl9C+39aHgJQyvRYD
         OHL5FGJ9hpF5vuhzuLoS38WW1p8zfDn4ITJhU6i3D1YY7I8/e9fkLWCgUPln4RcwJ0Vw
         49nRAnEDLrTusxXSTNvHymTggpt7Jzx/FT7U2aO2mIVQXtvqrP5GglsuKwIDBT/2Sv8R
         jTCv1OpNDBylxwnT5+4PrK1A++5YKCLHX5OXiPhCIWlpw5Oz0u3lZuJtUZp9swhiQi3V
         IAJQ==
X-Gm-Message-State: ABy/qLZBj+z0DrghXs2dYTPvdC1K2SxD+Y/BzX1PnzeHvzq6U2JkGvHi
	bd7oYXQNM2Gu9CyeYy4FL6Tma7NMZClJFVJUhUVu34r+D+S/siGoVcKjtGohU7jnBDdCjJNzhS8
	cVz1UK4ul72d0dz7Z
X-Received: by 2002:a05:620a:31aa:b0:767:7a4c:1b9e with SMTP id bi42-20020a05620a31aa00b007677a4c1b9emr15272963qkb.7.1690963399773;
        Wed, 02 Aug 2023 01:03:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFnNAWWhSXb/HktBSfXGFmabV1fvsy307saOx2MgChsfs7xTXLkVxm9csctRpjZ4apFAXP/zg==
X-Received: by 2002:a05:620a:31aa:b0:767:7a4c:1b9e with SMTP id bi42-20020a05620a31aa00b007677a4c1b9emr15272941qkb.7.1690963399461;
        Wed, 02 Aug 2023 01:03:19 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-7.dyn.eolo.it. [146.241.233.7])
        by smtp.gmail.com with ESMTPSA id p12-20020a05620a132c00b0076c9cc1e107sm3299044qkj.54.2023.08.02.01.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:03:18 -0700 (PDT)
Message-ID: <1b51c79c59cb3ec4be95e993be9be2e5d9441670.camel@redhat.com>
Subject: Re: [RFC bpf-next v7 0/6] bpf: Force to MPTCP
From: Paolo Abeni <pabeni@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Geliang Tang
	 <geliang.tang@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Florent Revest
 <revest@chromium.org>, Brendan Jackman <jackmanb@chromium.org>, Matthieu
 Baerts <matthieu.baerts@tessares.net>, Mat Martineau
 <martineau@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  John
 Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,  "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris
 <eparis@parisplace.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>,  bpf@vger.kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev,  apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org,  selinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Wed, 02 Aug 2023 10:03:12 +0200
In-Reply-To: <20230801004323.l2npfegkq3srzff3@MacBook-Pro-8.local>
References: <cover.1690624340.git.geliang.tang@suse.com>
	 <20230801004323.l2npfegkq3srzff3@MacBook-Pro-8.local>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-07-31 at 17:43 -0700, Alexei Starovoitov wrote:

> I still think it's a hack, but its blast radius is nicely contained.
> And since I cannot propose any better I'm ok with it.
>=20
> Patches 1-2 can be squashed into one.
> Just like patches 3-6 as a single patch for selftests.
>=20
> But before proceeding I'd like an explicit ack from netdev maintainers.

Just to state the obvious, I carry my personal bias on this topic due
to my background ;)

My perspective is quite similar to Alexei's one: the solution is not
extremely elegant, but is very self-contained; it looks viable to me.

WRT the specific code, I think the additional checks on the 'protocol'
value after the 'update_socket_protocol()' call should be dropped: the
user space can already provide an arbitrary value there and the later
code deal with that.

Cheers,

Paolo


