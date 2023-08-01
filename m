Return-Path: <netdev+bounces-23076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D310C76AA36
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 09:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8523628144D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 07:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FD31EA8F;
	Tue,  1 Aug 2023 07:44:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B0620FA
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:44:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786DF26A1
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 00:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690875870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NqXQpdHpV8Ezvm5Ot+Q+uVycSyLQP6CCe0dWhYuT94Y=;
	b=FmTpng9IaLOnX1WVGAUNwOd50GV+prlntFgyDo5eXOnvz7ysK32YRj1mQYEmaGLRkoBrBE
	N3YLxTlU4Nf7CndYnjc5ZRFXAxt9VQlKs8Y6wafCxZI0VwmKomzWESf8nDf+TSVmY3Uac4
	DWE8VpoWnxnBOt8ANeOw9CT/2WUf7LM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-0FSItXj_PG6DdpyPJ_FmLA-1; Tue, 01 Aug 2023 03:44:28 -0400
X-MC-Unique: 0FSItXj_PG6DdpyPJ_FmLA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76cb9958d60so29954485a.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 00:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690875868; x=1691480668;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqXQpdHpV8Ezvm5Ot+Q+uVycSyLQP6CCe0dWhYuT94Y=;
        b=e9+pS0fMtuw09nUxY7ZsgDAg+m78HmqIHgAFiMBp7LPfxNdsOo+yuXS9pVK2/NQi+W
         PP6E+9S+MkzdWcdD3DQhxmPqShYX/mvMyEcKxK1GQwbjoqLOdSLHI3fMAAxmRJnLSmfJ
         xIj/y2XXiFNAxxlDiaEl2eo6S3yvMCVzfIaAtCetc3i+khLL/A8lPyyVP7IePb3H+Fs0
         J1IJnOHDI4a1qeIzNRiV+E5UL7Kushg0VOGRDVIRZWxrJzIla4k9IrFUJvd1YQN8tOR6
         0LvZUBolKoY4PGInNQ/BcnovyJcGMUsit//xyod0/vlhRcPbJWVYy0yOQYKQK5bjXX3S
         Ddpw==
X-Gm-Message-State: ABy/qLZLGtkmwQ0BdtmGN+bDxbMHbDQW1tOfMI+2DLL+olL3UzFnv8mg
	VXwVGeyhOyUwpfOpvn6KqGx8if87u4Yp5K9dGxQL5IOwp+Jx0kAl8x8TFrWaLgY3g11QUWGsZrG
	ZDXZu3gr+gxEvyBWZfWXmVzVg
X-Received: by 2002:a05:620a:2401:b0:763:a1d3:196d with SMTP id d1-20020a05620a240100b00763a1d3196dmr11749449qkn.0.1690875868208;
        Tue, 01 Aug 2023 00:44:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFtiHX4Gzu39qMYgYQMXjB5BxCkE29IapHRH0veL6ley9egkDZ2BXpTaPJcFd+GV6SCcVoAqg==
X-Received: by 2002:a05:620a:2401:b0:763:a1d3:196d with SMTP id d1-20020a05620a240100b00763a1d3196dmr11749443qkn.0.1690875867867;
        Tue, 01 Aug 2023 00:44:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-251.dyn.eolo.it. [146.241.225.251])
        by smtp.gmail.com with ESMTPSA id os28-20020a05620a811c00b00767e98535b7sm3961257qkn.67.2023.08.01.00.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 00:44:27 -0700 (PDT)
Message-ID: <19a3a2be3c2389e97cacd7e7ab93b317b016ef94.camel@redhat.com>
Subject: Re: [PATCH net] bpf: sockmap: Remove preempt_disable in
 sock_map_sk_acquire
From: Paolo Abeni <pabeni@redhat.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki
 <jakub@cloudflare.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 tglozar@redhat.com
Date: Tue, 01 Aug 2023 09:44:23 +0200
In-Reply-To: <64c882fd8c200_a427920843@john.notmuch>
References: <20230728064411.305576-1-tglozar@redhat.com>
	 <87ila0fn01.fsf@cloudflare.com> <64c882fd8c200_a427920843@john.notmuch>
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

On Mon, 2023-07-31 at 20:58 -0700, John Fastabend wrote:
> Jakub Sitnicki wrote:
> >=20
> > On Fri, Jul 28, 2023 at 08:44 AM +02, tglozar@redhat.com wrote:
> > > From: Tomas Glozar <tglozar@redhat.com>
> > >=20
> > > Disabling preemption in sock_map_sk_acquire conflicts with GFP_ATOMIC
> > > allocation later in sk_psock_init_link on PREEMPT_RT kernels, since
> > > GFP_ATOMIC might sleep on RT (see bpf: Make BPF and PREEMPT_RT co-exi=
st
> > > patchset notes for details).
> > >=20
> > > This causes calling bpf_map_update_elem on BPF_MAP_TYPE_SOCKMAP maps =
to
> > > BUG (sleeping function called from invalid context) on RT kernels.
> > >=20
> > > preempt_disable was introduced together with lock_sk and rcu_read_loc=
k
> > > in commit 99ba2b5aba24e ("bpf: sockhash, disallow bpf_tcp_close and u=
pdate
> > > in parallel"), probably to match disabled migration of BPF programs, =
and
> > > is no longer necessary.
> > >=20
> > > Remove preempt_disable to fix BUG in sock_map_update_common on RT.
> > >=20
> > > Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> > > ---
> >=20
> > We disable softirq and hold a spin lock when modifying the map/hash in
> > sock_{map,hash}_update_common so this LGTM:
> >=20
>=20
> Agree.
>=20
> > Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
>=20
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
>=20
> >=20
> > You might want some extra tags:
> >=20
> > Link: https://lore.kernel.org/all/20200224140131.461979697@linutronix.d=
e/
> > Fixes: 99ba2b5aba24 ("bpf: sockhash, disallow bpf_tcp_close and update =
in parallel")

ENOCOFFEE here (which is never an excuse, but at least today is really
true), but I considered you may want this patch via the ebpf tree only
after applying it to net.

Hopefully should not be tragic, but please let me know if you prefer
the change reverted from net and going via the other path.

Thanks!

Paolo


