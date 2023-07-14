Return-Path: <netdev+bounces-17853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9D8753477
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4811C215C7
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD441748D;
	Fri, 14 Jul 2023 08:00:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F95279CF
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:00:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD5A3A88
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689321601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slaUONSg+DlN+ayFEMZVhhuszbKRkMcTnza/85oVWyg=;
	b=Q9yDnoPMmVYUHtpcYrehQAtqMeyQmbWLl0L3XBYVmnVTP+KpxiDQDXRqJ81bhnDzumnvIP
	059ftAj1bDyjLl5MR4tGmEsJB/0eNnFcDHNeqTCdDw8hFTM+Wb9aZ3f8aOBZ7F9pXuoiPa
	hoatSCwjikTKeaoZTQdXOvmb3fbFPXo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-LRMGKcd7O_GDA5wDV_eEQA-1; Fri, 14 Jul 2023 03:56:12 -0400
X-MC-Unique: LRMGKcd7O_GDA5wDV_eEQA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-401e1fc831fso3570281cf.1
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 00:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689321371; x=1691913371;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slaUONSg+DlN+ayFEMZVhhuszbKRkMcTnza/85oVWyg=;
        b=ehq751skZifno0rGIJB/TwrOLHpTAvFvx9rsGE/EECYzfBOsogdLVy6d4s71cNRFcJ
         RCbejEZwD0SQKdeHLOUBwxRmOAS0sJjqjcJTl/NfkT81b+4cPNxeuCTz6qGrPBAT8cL3
         TlY8T+tqUJWJlgNQqfv8sSzoY7ouzG+sENES3v5gWRKkB8KCineavSAw4pniSKU+yuh2
         JZuZA3ze03VTigzQGYy6MG44PVdA1YBqWg2jpQCL1g4VNota+kFQcESA+H5cQ4bY6ncw
         KdgPp7a7s9v8H7zcZEipc+DEckEJ3/dle1sp4jBM7DvYil7nkA/sf+3T3Dlxikm7MtkT
         H7qw==
X-Gm-Message-State: ABy/qLZW45wBXkojuifN+LMaYXH5mheSpTUeYesDIDkT0vRjNVRbMJmp
	Msr3yZzDysIhY20kVefaZzVr+NbQFabTGs38rMynMSlsQY242bBtpHORfMDyzclC/FTmNKNJR2S
	2k58sThe/p9DhAtuw+8W2+RRH
X-Received: by 2002:a05:620a:46aa:b0:766:3190:8052 with SMTP id bq42-20020a05620a46aa00b0076631908052mr4599744qkb.0.1689321371422;
        Fri, 14 Jul 2023 00:56:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEXapRXHsT2nSqUsEGRif2238r11GXN5y/Ez68arHueu7sEEY6KOYZwO2c1VhLcxcmaQwriGQ==
X-Received: by 2002:a05:620a:46aa:b0:766:3190:8052 with SMTP id bq42-20020a05620a46aa00b0076631908052mr4599732qkb.0.1689321371094;
        Fri, 14 Jul 2023 00:56:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id q26-20020a05620a039a00b00767b7375eadsm3582939qkm.39.2023.07.14.00.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 00:56:10 -0700 (PDT)
Message-ID: <22c30f70a632afb65b6cb2a7554e919673d48871.camel@redhat.com>
Subject: Re: [RFC bpf-next 0/8] BPF 'force to MPTCP'
From: Paolo Abeni <pabeni@redhat.com>
To: Stanislav Fomichev <sdf@google.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Geliang Tang <geliang.tang@suse.com>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,  Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>, netdev@vger.kernel.org
Date: Fri, 14 Jul 2023 09:56:06 +0200
In-Reply-To: <ZLCELtTGksxGwaFZ@google.com>
References: <cover.1688616142.git.geliang.tang@suse.com>
	 <ZKbzs7foUw+eeNnn@google.com>
	 <20230713054716.GA18806@localhost.localdomain>
	 <ZLAxAc1/UXcbIJBo@google.com>
	 <CAADnVQ+aPyWea4QUD9TFNpr43u052zuqOXzGaqmM8-EeMrW6rg@mail.gmail.com>
	 <ZLCELtTGksxGwaFZ@google.com>
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
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-07-13 at 16:09 -0700, Stanislav Fomichev wrote:
> On 07/13, Alexei Starovoitov wrote:
> > imo all 3 options including this 4th one are too hacky.
> > I understand ld_preload limitations and desire to have it per-cgroup,
> > but messing this much with user space feels a little bit too much.
> > What side effects will it cause?
>=20
> Maybe all that is really needed is some new per-netns sysctl to automatic=
ally
> upgrade from IPPROTO_TCP to IPPROTO_MPTCP? Or is it too broad of a
> brush?

I think it would be actually too broad, see below...

> I've also CC'd netdev for visibility...
>=20
> > Meaning is this enough to just change the proto?
> > Nothing in user space later on needs to be aware the protocol is so dif=
ferent?
>=20
> IIUC, if you use IPPROTO_MPTCP, you just get regular TCP until you start
> adding extra routes (via netlink). That's why their current
> unconditional IPPROTO_TCP->IPPROTO_MPTCP rewrite via ld_preload also some=
what
> works.

FTR, it the other way around: when using IPPROTO_MPTCP you always get
MPTCP protocol handshake that downgrade gracefully to TCP if the peer
does not support it. Then multiple paths can be added/enabled by
different means, but that is another matter - a quite orthogonal one.

The transition to TCP in currently not completely for free: active
(client) MPTCP sockets fallen-back to TCP will keep some overhead vs
plain TCP ones.

Being able to control the IPPROTO_TCP->IPPROTO_MPTCP change on per
socket basis do offer some advantages e.g. constraining the change to
the sockets that are likely to complete successfully the MPTCP
handshake.=20

> > I feel the consequences are too drastic to support such thing
> > through an official/stable hook.
> > We can consider an fmod_ret unstable hook somewhere in the kernel
> > that bpf prog can attach to and tweak the ret value and/or args,
> > but the production environment won't be using it.
> > It will be a temporary gap until user space is properly converted to mp=
tcp.
>=20
> Asking every app to do s/IPPROTO_TCP/IPPROTO_MPTCP/ might be annoying
> though? (don't have a horse in this race, but have some v4->v6 migration
> vibes from this)

I can do only wild guesses, but I also expect such "transition" to be
extremely long and/or incomplete.

Cheers,

Paolo


