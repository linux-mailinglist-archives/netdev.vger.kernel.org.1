Return-Path: <netdev+bounces-267668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0hk+Ho7gtGlutwAAu9opvQ
	(envelope-from <netdev+bounces-267668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 05:14:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DEC28B899
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 05:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 486C6303B7DA
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 04:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05A5314A64;
	Sat, 14 Mar 2026 04:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZD1JkgY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565522DB7BD
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 04:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773461642; cv=pass; b=AU2xQlv8l2uLKmmUCVTjU7m0bc+2kF1Q0hkFR/HR/vLlGaeYrlcGQn+gqE07+ET4CaC967JMPjUR1y2VTaSpOCC6CO+1sw4DsJUd8m9zk07nZ8JvycJHFzrQmy7JhOCf/L2NJfZdllvbnZgTA06xgmkzs3M0VbKq9t3FptsF5oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773461642; c=relaxed/simple;
	bh=HzsNQ9jkXHrU1GlKgD93zLJxHSJuQW4od8SyC7cW01M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVTf4eaTiKKKJ3mU2iSL0OCRaoAFnJZEvCsyTNcRy2gRk3T/hQDe9EWw0XUZ5G1F8QZ3sJT2qmGbU6SScKnw65T6kCNgAykGy7wyUVxOwvkLs0J2VZAswGlTKhrdSAvJJqXedk8tDV06E+jM6WGKXezBCE2aPCBuNyEPFNlb1OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cZD1JkgY; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5094ba0af1aso29147311cf.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 21:14:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773461640; cv=none;
        d=google.com; s=arc-20240605;
        b=GbyxpS60Bq418BcGzjI+XH+FfZ8Lj8XE3655c+yG9SYlfKPZNYQSPrr+DukUUuwhfh
         +flp436JpBpYscVgXN7zztaftz2Y58zhVYLkVJGz3hPwZ4cNbsnCIoYp+Oj7vnI3o3D4
         CxfjoZeEM6p4mdnMj0zdscnc1L1m7w6XVUZlJbTfUe/R9aMwkBO0G2OrBhmHWITeVAuc
         jhsT3yJB4D1O2ZuK13oHVRgnTh3xldRx/2y7gXULBZL7Jl1CjDq+NdQKGyWRO+0MOu7h
         WcpCmtX01ZMQBE2Rc6fnOYPN4m9Zyi7CcDWV+IwnKACZ3aY1tzSqZRbQvNcMGpeSnm0C
         x04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sly2qHIvbY051CLg2hvc6NuzuyJY6s6PgyFRPoLcPfw=;
        fh=tAOl/i5YQ1Mv0dbpbaYdswiIxf65qo9EIYIJ4TWTSXI=;
        b=BGBrfti8VGOJc/RK2vUvtgGlZ3XgBdGHjZvD31KJPOGchNXcol5B2Aglw7dtH2HRoo
         5ujyhOAl0yl+XG4HBHPy3gPaw7NA+F8YqNiMCx7bZygePXsGDNUbj3A3LNJ6fkLSAWlH
         DFY4PHIY1qaHdIDj+4E90Q3XMcy/e3+fiNRGuqb0yl413nkPfYf/z2Qs5DMF7Nlmj0mB
         YEDr3JvnF1EEh8RZfdiqrRuLQtrbn6X1cZ3Iwxh5p/rjMO1KzCaHi6cF0ZUeNlKphE+Z
         YEAXwnMuLMfFfs7DyZp2cQBqq4tZ01ZGTYFteDlA6zA3ehnPGwzR5N8urxtTdaC2frY4
         FV+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773461640; x=1774066440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sly2qHIvbY051CLg2hvc6NuzuyJY6s6PgyFRPoLcPfw=;
        b=cZD1JkgYSpgQ5ijPgMKIvRJhVMp9Zzx0fii638rG8IjM35vc45XKylJlsKyvdfQ2Hx
         fcquSBWbnTQ3gzDtx1eNePXuc+9cK85pn6akCd3G9BM83LSnqM68z2S8112OBuCFz/kl
         haNc4Fyk9VvLw2T/KPlTScNORy5X86KwduuQqLSc+WTKOH8VEucM+QJiUMz0J7c5UpaA
         VdKSgKTKz12xuSD9pWzMBc/vXcY64RLTOFe64uYOf2XFlM3be7FMxqNL7lgAPns7NA51
         FnltTVW6LRzY/BC5lC+D4KJY1godKJu2QGv00zYqRxo0F/OhiUUbLbQPJ8ZMlcHXuB7I
         eUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773461640; x=1774066440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sly2qHIvbY051CLg2hvc6NuzuyJY6s6PgyFRPoLcPfw=;
        b=eHTmijgxbcDozPkXF9SXllNl08s6bMK6lbTx5+IZ5Z3YIok26j0AGXt/LcvvcRJw5p
         BPkhMt9PW33xJ+1FFPvSK6a3Hp18VqZnJGi5m8fwapnp9rPuhNvYQbq7a9VYWcq4+HGR
         NPqigA8FPE6NwOH+jJ1OVw6TyIX0pgWzSyq64ltPNE1KLg00GtLrOi8yjUMIg1VYu+6C
         FHoDk/Re9n4B/LTpCBFxw1N5jdEAYYQt+gyPEuWDNwNiIgBIljX5kyzhgjfAYgD8A8o9
         7O9iG+TCK3L39jlXL1p1p1KJUecQipTH5MlskkIa3v2lJR2BGTChC9FwX9i1kY4irWnW
         PHZw==
X-Forwarded-Encrypted: i=1; AJvYcCX3RysIFLJkzaXCwD7fGRD8bzpRWYw8/ilUPai/MwrlKyrbbwMcFKh1hgn5XWCTdim0tqlHQ38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFC0+gFT9ZD7HmiVNBV8DPjLmwBSbWqd+6EBM/1chh99LJb5Mm
	MyawtS/cix4bnprQShrRXEQ9CR7SWZSB7dOY1N2vxoOCT6QSuFHFYTuSGCDReH1/v3NRPbjLYiS
	4I0FvQnM2VxSYdbmksQDzmjzni31n8PsGWyzxNbPz
X-Gm-Gg: ATEYQzw3stbfZgeJPuiSU+vL5a4/9nsl2VQJzfzof4CGkNB7uEaMecyHJS1IvpKNkgP
	VsOMRNdQn4AAmvvK+m8oqk9L5V1JtaDu51VulN7qgsFgVMXMkGisbaEJN7946hUX5xjFDhVmr2L
	/zZZCP13yfmJcz9eRNIkH1DZ82fQUt9evX0R6MfBkJzPqK8iENPxONaRUcfUSXydHc8kLki0CMd
	3pjQWrH88J0sCT6FUabVDO0t54PUbi3ecg9ewz0I8sw0A0Mhs55xSLZEHAH0stlF/in/xLi0OB/
	5cYtuQ==
X-Received: by 2002:a05:622a:1313:b0:506:9e57:8ba9 with SMTP id
 d75a77b69052e-50957e6e003mr72479211cf.35.1773461639854; Fri, 13 Mar 2026
 21:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313202802.1201129-1-edumazet@google.com> <20260313150710.0edaa6b9@kernel.org>
In-Reply-To: <20260313150710.0edaa6b9@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 05:13:48 +0100
X-Gm-Features: AaiRm51IdcwHMOXlrp4s0qw7_yj7U0iqt6-vxL441rZyOdgylq1jy2-yic19gGw
Message-ID: <CANn89iJen547z-NOnu4QBe5K=92+tfeaO8T5A0X=_0vHdgQ4RQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add cwnd_event_tx_start to tcp_congestion_ops
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-267668-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6DEC28B899
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 11:07=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 13 Mar 2026 20:28:02 +0000 Eric Dumazet wrote:
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
> BPF selftest are not happy:
> 857
>   progs/tcp_ca_kfunc.c:121:33: error: use of undeclared identifier 'cwnd_=
event_tx_start'
>     121 |         .cwnd_event_tx_start =3D (void *)cwnd_event_tx_start,
>         |                                        ^~~~~~~~~~~~~~~~~~~
> --
> pw-bot: cr

Ah, I missed this because the bpf tests on my side have many errors.

progs/bpf_qdisc_fifo.c:38:3: error: call to undeclared function
'bpf_qdisc_skb_drop'; ISO C99 and later do not support implicit
function declarations [-Wimplicit-function-declaration]
   38 |                 bpf_qdisc_skb_drop(skb, to_free);
      |                 ^
  CLNG-BPF [test_progs] for_each_multi_maps.bpf.o
  CLNG-BPF [test_progs] free_timer.bpf.o
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
  CLNG-BPF [test_progs] freplace_attach_probe.bpf.o
  CLNG-BPF [test_progs] freplace_cls_redirect.bpf.o
  CLNG-BPF [test_progs] freplace_connect4.bpf.o
  CLNG-BPF [test_progs] freplace_connect_v4_prog.bpf.o
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
  CLNG-BPF [test_progs] freplace_dead_global_func.bpf.o
progs/bpf_qdisc_fq.c:375:3: error: call to undeclared function
'bpf_qdisc_skb_drop'; ISO C99 and later do not support implicit
function declarations [-Wimplicit-function-declaration]
  375 |                 bpf_qdisc_skb_drop(skb, to_free);
      |                 ^
3 errors generated.
  CLNG-BPF [test_progs] freplace_get_constant.bpf.o
make: *** [Makefile:772:
/usr/local/google/home/edumazet/git/net-next/tools/testing/selftests/bpf/bp=
f_qdisc_fifo.bpf.o]
Error 1
make: *** Waiting for unfinished jobs....
progs/bpf_qdisc_fail__incompl_ops.c:13:2: error: call to undeclared
function 'bpf_qdisc_skb_drop'; ISO C99 and later do not support
implicit function declarations [-Wimplicit-function-declaration]
   13 |         bpf_qdisc_skb_drop(skb, to_free);
      |         ^
1 error generated.
progs/bpf_qdisc_fq.c:614:3: error: call to undeclared function
'bpf_qdisc_bstats_update'; ISO C99 and later do not support implicit
function declarations [-Wimplicit-function-declaration]
  614 |                 bpf_qdisc_bstats_update(sch, skb);
      |                 ^
make: *** [Makefile:772:
/usr/local/google/home/edumazet/git/net-next/tools/testing/selftests/bpf/bp=
f_qdisc_fail__incompl_ops.bpf.o]
Error 1
progs/bpf_qdisc_fq.c:619:3: error: call to undeclared function
'bpf_qdisc_watchdog_schedule'; ISO C99 and later do not support
implicit function declarations [-Wimplicit-function-declaration]
  619 |                 bpf_qdisc_watchdog_schedule(sch,
cb_ctx.expire, q.timer_slack);
      |                 ^

