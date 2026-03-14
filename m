Return-Path: <netdev+bounces-267870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ94D+7gtWkE6QAAu9opvQ
	(envelope-from <netdev+bounces-267870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 23:27:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE9128F4BF
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 23:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDECD3018C19
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 22:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42518308F0A;
	Sat, 14 Mar 2026 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rncmNQus"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902861A294
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527273; cv=pass; b=ulz7MDA96bsj+O/iBD3kY+JR25Gevf+4JjyDjDx+gN1dTOwP2IxAhoefN0dPjFkMxB5ntG0Bdgo9jW8glmGpwpWb8MzNjZz7TDEyzGvPPyapHH0L5B5pMui9ce1ltKO/zlrglx2kW1AF0iIdG/UkskyJCNim5ZPGurzj2Xytdig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527273; c=relaxed/simple;
	bh=uePMaTOUsvWAUbIb6Zfz60r228PNEkhTPxZQlsL1v+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQ6/p9i6zjiAXeaxXxRTqAf2NNpC+5ezI5cRF0E9hCTGhHg2AJ9WV8j9mdXByFAQfLKw6/Eo7n+sQ4ouiM7GhzCsHsng0P8dapMZhc1/LHl6RVWgCuVq+P9zbJeW6HMcNRUZqw4hU2aZNr7WNlgAMEbpf02q28ntiayCkMRarec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rncmNQus; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a133cdd4aso43762196d6.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 15:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773527270; cv=none;
        d=google.com; s=arc-20240605;
        b=QRgAhA860cYD787Q+1oClKkx9Zvv9/sQVUeFnWh3S+GWeiwPMeQYdhwq86xl/ZhqZ4
         31B+dBKoaO92H2T7Kppl/9NkPeMJcd62y6nDBeY+S1WyivclqLwN8/lzy6cTqnP8+pYr
         csQsqT4NX60yeYgBpPgJ8BIYgTETN/pWrxZ9J+tZYtzCAC1WL7ygHQOXGJCIszsv5Tv0
         CxMK3ZbbtXxvTFh4cz3jC1eZDDewQvb2KH/C1p7yfuYiAhK249SAa47G2HRngxhPbiaU
         TD52yB6c18FAPIMBGj7bbUmJSwlIGjEgaLAUayH9x1ytBIlSA384AxECcvuHG19bLu0a
         VIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5sBIpkg0W2uJ+Wwzt5yp/5M9NzbPLoHK3wvy8ahvNWI=;
        fh=jJybBRoYFRVdSj2quBuxvBNLHzhp498K40MQPPWisHI=;
        b=Rb0M3G4wiX7PribuH+LpFdTfNZMe5cIF5QGz8fvK8YTGGpMiWEaZBTr7bqptspgqvy
         gsDHde5UtTJQ5DnQqEPZRA/BGANW/yesjyjrRDve8sG7NYvqZa9Q0buDCEn+N68pZ81u
         +NY+0UdfpooEkKGyxRRL2NJDwWo9BVHJoXmBwfHQ6TJfS5DwGhPi/JOXTEIuuhYxqcg5
         MrGuStJpSIL8vOzl2nrWiyPSseXRzblyG3u/sb7Ebu95dAov9XjC42r266RYkBHoqTIc
         cY0udmvenJFObGSb0rcjFs82uZNgNnTQpJ26s0YIyWg9Xa+eFT2aO5MV0nKhA0EwZvio
         n59w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773527270; x=1774132070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sBIpkg0W2uJ+Wwzt5yp/5M9NzbPLoHK3wvy8ahvNWI=;
        b=rncmNQuszuMiSpVCL58U1aCz3cPRvEkHziplclExhv7OVv1qwq0zWXw8wePpHo8hvm
         Z5WmC0FqeVkwaluypwCKmNKKZQ8ArJP6AVaAYMQWDUbvx9eeJshFXbOlanWqzZNbDbr6
         WXJ2uH0WlE0urPpSn3HW9cicQXIzHTE2dlxcDYj4ehf8XCayNlD2NdUm1TNBWfkuPxe5
         FWslO8Gngj0qGhB4xZZsWrKuYCheBka9JhksXKVbgPJTxeksza8oGQ1tuTm/z43xMiMX
         LExVrEGiZUEoVAQkbEWL3hMc1Kcewc9yf/tPDiAPz0i0R8h2WQ0twGdugZPH0umfN+3o
         bjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773527270; x=1774132070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5sBIpkg0W2uJ+Wwzt5yp/5M9NzbPLoHK3wvy8ahvNWI=;
        b=gqGxSPhswEK7iqIxMSaZSxotpd5+sf2DgLW/KzM06m/6SP/JNPKtoSlqaQZAKwsiLy
         VGx2qeU3JkS00FH0aGhdKbE9ATpvWsoDOpotPK3M7g+89254C0w1fZ/MWOGMdkuS5zNz
         flZKqh39hFhpyvk73OfdAOCN5UJabnI9YX6hlUPUqA/XEqXMqbnq058e3ES7YLX/4xqc
         m1c/hR9CpSdpx0zL5O9xDAZV88IA9vQHcRq6akNfn2kz4eG8OxfdKgtLkhCUAD0wn07d
         1M4uli66JLRo22Xze9BPW0sjD2p7Fa1nbLevYdP5p0cZczYoIbnFTbogmGkxUAM2y+7X
         sAyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIy79m75YyUoMr3NN0lyZdLKlLjlvZ2a2g7dwIl2PuJ4Rzv6M10s9v0fQOQVThw6sT4tYAqVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFFocuIuRtWk1x0IoBghRdkGhtmJ7xtRjgzUdVunFIZEe+983y
	dqHV4W09ryYGDrh6+IBMvTEO4aFP/NTxmnJT3PMaoVOt5gpl+3YB3bnrbBmV3xEEzeJfwohfPqE
	JDARhj+i41gloDDf/hkVWQVouMiiVk7gy5tdz9OEm
X-Gm-Gg: ATEYQzw1udUMuzNw9Zq9+8sMJLI0JrXGBdLFp4UeOn5bAH6u6nIMIe+e74jZvr+TMoj
	dHqL+vouo2/+JagYTlru9+HEJKEQLo8QzBFFo9P1pevb0BRSSR8ykaiLBPHJ6G8rTddvsCDdUdd
	VjAIolIjGqwUwKnKFEVqRk02Il9BZ4+JjlottoEXP6EkfQRDaQ4CRWUD289vTvO0JxuJqMOXRFl
	JUqZsBeRIu/dml+efk6w3NjGN0O6dN+XYjkkVDP5aNuH42DAj5kH1pr/IvjoXEXeqdh8DfUc44J
	5bcGVPr1
X-Received: by 2002:a05:622a:48f:b0:509:30b0:831e with SMTP id
 d75a77b69052e-50957cd8e8cmr103330061cf.21.1773527270035; Sat, 14 Mar 2026
 15:27:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314180802.50222-1-edumazet@google.com> <20260314145202.778a8535@kernel.org>
In-Reply-To: <20260314145202.778a8535@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 23:27:39 +0100
X-Gm-Features: AaiRm506YfcHlSrOYXwAAnsMVxf0imNv3XgUy43E7IUjMhAm6LUBFBRK9-dfsao
Message-ID: <CANn89iJ7JUgU64dmEYGvD5sWqpf-ssymNQ=2dZKOY2zPjtq0Aw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: add cwnd_event_tx_start to tcp_congestion_ops
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-267870-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8DE9128F4BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 10:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sat, 14 Mar 2026 18:08:02 +0000 Eric Dumazet wrote:
> > (tcp_congestion_ops)->cwnd_event() is called very often, with
> > @event oscillating between CA_EVENT_TX_START and other values.
> >
> > This is not branch prediction friendly.
> >
> > Provide a new cwnd_event_tx_start pointer dedicated for CA_EVENT_TX_STA=
RT.
> >
> > Both BBR and CUBIC benefit from this change, since they only care
> > about CA_EVENT_TX_START.
>
> BPF still not building :(
>
>   progs/tcp_ca_kfunc.c:121:33: error: use of undeclared identifier 'cwnd_=
event_tx_start'
>     121 |         .cwnd_event_tx_start =3D (void *)cwnd_event_tx_start,
>         |                                        ^~~~~~~~~~~~~~~~~~~
>
>
> https://github.com/kernel-patches/bpf/actions/runs/23096281431/job/670892=
76918


make clean
vng -bv CC=3Dclang >RES
make headers ; make -j100 -C tools/testing/selftests/net ; make -j100
-C tools/testing/selftests/bpf
 make -j100 -C tools/testing/selftests/bpf
make: Entering directory
'/usr/local/google/home/edumazet/git/net-next/tools/testing/selftests/bpf'
  GEN-SKEL [test_progs] access_map_in_map.skel.h
  GEN-SKEL [test_progs] arena_atomics.skel.h
  GEN-SKEL [test_progs] arena_htab_asm.skel.h
  GEN-SKEL [test_progs] arena_htab.skel.h
  GEN-SKEL [test_progs] arena_list.skel.h
  GEN-SKEL [test_progs] arena_spin_lock.skel.h
  GEN-SKEL [test_progs] arena_strsearch.skel.h
  GEN-SKEL [test_progs] async_stack_depth.skel.h
  GEN-SKEL [test_progs] atomic_bounds.skel.h
  GEN-SKEL [test_progs] bad_struct_ops2.skel.h
  GEN-SKEL [test_progs] bad_struct_ops.skel.h
  GEN-SKEL [test_progs] bench_local_storage_create.skel.h
  GEN-SKEL [test_progs] bench_sockmap_prog.skel.h
  GEN-SKEL [test_progs] bind4_prog.skel.h
  GEN-SKEL [test_progs] bind6_prog.skel.h
  GEN-SKEL [test_progs] bind_perm.skel.h
  GEN-SKEL [test_progs] bloom_filter_bench.skel.h
  GEN-SKEL [test_progs] bloom_filter_map.skel.h
  GEN-SKEL [test_progs] bpf_cc_cubic.skel.h
  GEN-SKEL [test_progs] bpf_cubic.skel.h
  GEN-SKEL [test_progs] bpf_dctcp.skel.h
  GEN-SKEL [test_progs] bpf_dctcp_release.skel.h
  GEN-SKEL [test_progs] bpf_flow.skel.h
  GEN-SKEL [test_progs] bpf_gotox.skel.h
  GEN-SKEL [test_progs] bpf_hashmap_full_update_bench.skel.h
  GEN-SKEL [test_progs] bpf_hashmap_lookup.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_array_map.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_hash_map.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_link.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_map.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_percpu_array_map.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_percpu_hash_map.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_sk_storage_helpers.skel.h
  GEN-SKEL [test_progs] bpf_iter_bpf_sk_storage_map.skel.h
  GEN-SKEL [test_progs] bpf_iter_ipv6_route.skel.h
  GEN-SKEL [test_progs] bpf_iter_ksym.skel.h
  GEN-SKEL [test_progs] bpf_iter_map_elem.skel.h
  GEN-SKEL [test_progs] bpf_iter_netlink.skel.h
  GEN-SKEL [test_progs] bpf_iter_setsockopt.skel.h
  GEN-SKEL [test_progs] bpf_iter_setsockopt_unix.skel.h
  GEN-SKEL [test_progs] bpf_iter_sockmap.skel.h
  GEN-SKEL [test_progs] bpf_iter_task_btf.skel.h
  GEN-SKEL [test_progs] bpf_iter_task_file.skel.h
  GEN-SKEL [test_progs] bpf_iter_tasks.skel.h
  GEN-SKEL [test_progs] bpf_iter_task_stack.skel.h
  GEN-SKEL [test_progs] bpf_iter_task_vmas.skel.h
  GEN-SKEL [test_progs] bpf_iter_tcp4.skel.h
  GEN-SKEL [test_progs] bpf_iter_tcp6.skel.h
  GEN-SKEL [test_progs] bpf_iter_test_kern1.skel.h
  GEN-SKEL [test_progs] bpf_iter_test_kern2.skel.h
  GEN-SKEL [test_progs] bpf_iter_test_kern3.skel.h
  GEN-SKEL [test_progs] bpf_iter_test_kern4.skel.h
  GEN-SKEL [test_progs] bpf_iter_test_kern5.skel.h
  GEN-SKEL [test_progs] bpf_iter_test_kern6.skel.h
  GEN-SKEL [test_progs] bpf_iter_udp4.skel.h
  GEN-SKEL [test_progs] bpf_iter_udp6.skel.h
  GEN-SKEL [test_progs] bpf_iter_unix.skel.h
  GEN-SKEL [test_progs] bpf_iter_vma_offset.skel.h
  GEN-SKEL [test_progs] bpf_loop_bench.skel.h
  GEN-SKEL [test_progs] bpf_loop.skel.h
  GEN-SKEL [test_progs] bpf_mod_race.skel.h
  CLNG-BPF [test_progs] bpf_qdisc_fail__incompl_ops.bpf.o
  CLNG-BPF [test_progs] bpf_qdisc_fifo.bpf.o
  CLNG-BPF [test_progs] bpf_qdisc_fq.bpf.o
  CLNG-BPF [test_progs] bpf_smc.bpf.o
  GEN-SKEL [test_progs] bpf_syscall_macro.skel.h
  GEN-SKEL [test_progs] bpf_tcp_nogpl.skel.h
  GEN-SKEL [test_progs] bprm_opts.skel.h
  GEN-SKEL [test_progs] btf_data.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_bitfields.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_multidim.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_namespacing.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_ordering.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_packing.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_padding.skel.h
  GEN-SKEL [test_progs] btf_dump_test_case_syntax.skel.h
  GEN-SKEL [test_progs] btf_type_tag.skel.h
  GEN-SKEL [test_progs] btf_type_tag_percpu.skel.h
  GEN-SKEL [test_progs] btf_type_tag_user.skel.h
  GEN-SKEL [test_progs] cb_refs.skel.h
  GEN-SKEL [test_progs] cgroup_ancestor.skel.h
  GEN-SKEL [test_progs] cgroup_getset_retval_getsockopt.skel.h
  GEN-SKEL [test_progs] cgroup_getset_retval_hooks.skel.h
  GEN-SKEL [test_progs] cgroup_getset_retval_setsockopt.skel.h
  GEN-SKEL [test_progs] cgroup_hierarchical_stats.skel.h
  GEN-SKEL [test_progs] cgroup_iter.skel.h
  GEN-SKEL [test_progs] cgroup_iter_memcg.skel.h
  GEN-SKEL [test_progs] cgroup_mprog.skel.h
  GEN-SKEL [test_progs] cgroup_preorder.skel.h
  GEN-SKEL [test_progs] cgroup_read_xattr.skel.h
  GEN-SKEL [test_progs] cgroup_skb_direct_packet_access.skel.h
  GEN-SKEL [test_progs] cgroup_skb_sk_lookup_kern.skel.h
  GEN-SKEL [test_progs] cgroup_storage.skel.h
  GEN-SKEL [test_progs] cgroup_tcp_skb.skel.h
  GEN-SKEL [test_progs] cgrp_kfunc_failure.skel.h
  GEN-SKEL [test_progs] cgrp_kfunc_success.skel.h
  GEN-SKEL [test_progs] cgrp_ls_attach_cgroup.skel.h
  GEN-SKEL [test_progs] cgrp_ls_negative.skel.h
  GEN-SKEL [test_progs] cgrp_ls_recursion.skel.h
  GEN-SKEL [test_progs] cgrp_ls_sleepable.skel.h
  GEN-SKEL [test_progs] cgrp_ls_tp_btf.skel.h
  GEN-SKEL [test_progs] cg_storage_multi_egress_only.skel.h
  GEN-SKEL [test_progs] cg_storage_multi_isolated.skel.h
  GEN-SKEL [test_progs] cg_storage_multi_shared.skel.h
  GEN-SKEL [test_progs] compute_live_registers.skel.h
  GEN-SKEL [test_progs] connect4_dropper.skel.h
  GEN-SKEL [test_progs] connect4_prog.skel.h
  GEN-SKEL [test_progs] connect6_prog.skel.h
  GEN-SKEL [test_progs] connect_force_port4.skel.h
  GEN-SKEL [test_progs] connect_force_port6.skel.h
  GEN-SKEL [test_progs] connect_ping.skel.h
  GEN-SKEL [test_progs] connect_unix_prog.skel.h
  GEN-SKEL [test_progs] cpumask_failure.skel.h
  GEN-SKEL [test_progs] cpumask_success.skel.h
  GEN-SKEL [test_progs] crypto_basic.skel.h
  GEN-SKEL [test_progs] crypto_bench.skel.h
  GEN-SKEL [test_progs] crypto_sanity.skel.h
  GEN-SKEL [test_progs] csum_diff_test.skel.h
  GEN-SKEL [test_progs] decap_sanity.skel.h
  GEN-SKEL [test_progs] dev_cgroup.skel.h
  GEN-SKEL [test_progs] dmabuf_iter.skel.h
  GEN-SKEL [test_progs] dummy_st_ops_fail.skel.h
  GEN-SKEL [test_progs] dummy_st_ops_success.skel.h
  GEN-SKEL [test_progs] dynptr_fail.skel.h
  GEN-SKEL [test_progs] dynptr_success.skel.h
  GEN-SKEL [test_progs] empty_skb.skel.h
  GEN-SKEL [test_progs] epilogue_exit.skel.h
  GEN-SKEL [test_progs] epilogue_tailcall.skel.h
  GEN-SKEL [test_progs] exceptions_assert.skel.h
  GEN-SKEL [test_progs] exceptions.skel.h
  GEN-SKEL [test_progs] exceptions_ext.skel.h
  GEN-SKEL [test_progs] exceptions_fail.skel.h
  GEN-SKEL [test_progs] exhandler_kern.skel.h
  GEN-SKEL [test_progs] fd_htab_lookup.skel.h
  GEN-SKEL [test_progs] fentry_many_args.skel.h
progs/bpf_qdisc_fail__incompl_ops.c:13:2: error: call to undeclared
function 'bpf_qdisc_skb_drop'; ISO C99 and later do not support
implicit function declarations [-Wimplicit-function-declaration]
   13 |         bpf_qdisc_skb_drop(skb, to_free);
      |         ^
progs/bpf_smc.c:91:39: error: no member named 'smc' in 'struct net'
   91 |         if (!task || !task->nsproxy->net_ns->smc.hs_ctrl)
      |                       ~~~~~~~~~~~~~~~~~~~~~  ^
  GEN-SKEL [test_progs] fentry_recursive.skel.h
progs/bpf_smc.c:113:21: error: variable has incomplete type 'struct smc_hs_=
ctrl'
  113 | struct smc_hs_ctrl  linkcheck =3D {
      |                     ^
progs/bpf_smc.c:113:8: note: forward declaration of 'struct smc_hs_ctrl'
  113 | struct smc_hs_ctrl  linkcheck =3D {
      |        ^
progs/bpf_qdisc_fifo.c:38:3: error: call to undeclared function
'bpf_qdisc_skb_drop'; ISO C99 and later do not support implicit
function declarations [-Wimplicit-function-declaration]
   38 |                 bpf_qdisc_skb_drop(skb, to_free);
      |                 ^
  GEN-SKEL [test_progs] fentry_recursive_target.skel.h
  GEN-SKEL [test_progs] fexit_bpf2bpf.skel.h
  GEN-SKEL [test_progs] fexit_bpf2bpf_simple.skel.h
progs/bpf_qdisc_fq.c:280:11: error: call to undeclared function
'bpf_skb_get_hash'; ISO C99 and later do not support implicit function
declarations [-Wimplicit-function-declaration]
  280 |                         hash =3D bpf_skb_get_hash(skb) & q.orphan_m=
ask;
      |                                ^
progs/bpf_qdisc_fq.c:287:11: error: call to undeclared function
'bpf_skb_get_hash'; ISO C99 and later do not support implicit function
declarations [-Wimplicit-function-declaration]
  287 |                         hash =3D bpf_skb_get_hash(skb) & q.orphan_m=
ask;
      |                                ^
  GEN-SKEL [test_progs] fexit_many_args.skel.h
  GEN-SKEL [test_progs] fib_lookup.skel.h
  GEN-SKEL [test_progs] file_reader.skel.h
  GEN-SKEL [test_progs] file_reader_fail.skel.h
  GEN-SKEL [test_progs] find_vma.skel.h
2 errors generated.
progs/bpf_qdisc_fq.c:375:3: error: call to undeclared function
'bpf_qdisc_skb_drop'; ISO C99 and later do not support implicit
function declarations [-Wimplicit-function-declaration]
  375 |                 bpf_qdisc_skb_drop(skb, to_free);
      |                 ^
1 error generated.
make: *** [Makefile:772:
/usr/local/google/home/edumazet/git/net-next/tools/testing/selftests/bpf/bp=
f_smc.bpf.o]
Error 1
make: *** Waiting for unfinished jobs....
make: *** [Makefile:772:
/usr/local/google/home/edumazet/git/net-next/tools/testing/selftests/bpf/bp=
f_qdisc_fail__incompl_ops.bpf.o]
Error 1
progs/bpf_qdisc_fifo.c:71:2: error: call to undeclared function
'bpf_qdisc_bstats_update'; ISO C99 and later do not support implicit
function declarations [-Wimplicit-function-declaration]
   71 |         bpf_qdisc_bstats_update(sch, skb);
      |         ^
progs/bpf_qdisc_fifo.c:106:4: error: call to undeclared function
'bpf_kfree_skb'; ISO C99 and later do not support implicit function
declarations [-Wimplicit-function-declaration]
  106 |                         bpf_kfree_skb(skb);
      |                         ^
3 errors generated.
make: *** [Makefile:772:
/usr/local/google/home/edumazet/git/net-next/tools/testing/selftests/bpf/bp=
f_qdisc_fifo.bpf.o]
Error 1
progs/bpf_qdisc_fq.c:614:3: error: call to undeclared function
'bpf_qdisc_bstats_update'; ISO C99 and later do not support implicit
function declarations [-Wimplicit-function-declaration]
  614 |                 bpf_qdisc_bstats_update(sch, skb);
      |                 ^
progs/bpf_qdisc_fq.c:619:3: error: call to undeclared function
'bpf_qdisc_watchdog_schedule'; ISO C99 and later do not support
implicit function declarations [-Wimplicit-function-declaration]
  619 |                 bpf_qdisc_watchdog_schedule(sch,
cb_ctx.expire, q.timer_slack);
      |                 ^
5 errors generated.
make: *** [Makefile:772:
/usr/local/google/home/edumazet/git/net-next/tools/testing/selftests/bpf/bp=
f_qdisc_fq.bpf.o]
Error 1
make: Leaving directory
'/usr/local/google/home/edumazet/git/net-next/tools/testing/selftests/bpf'

I dot know how to get past these qdisc errors.

