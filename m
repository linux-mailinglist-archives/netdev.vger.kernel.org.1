Return-Path: <netdev+bounces-266798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g6lBI/L+sWkvHwAAu9opvQ
	(envelope-from <netdev+bounces-266798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 00:46:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D888726B6CF
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 00:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6374F3041794
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86743286D57;
	Wed, 11 Mar 2026 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAKRFXyG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F462DEA62
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773272803; cv=pass; b=pZmazQ9hFl6rgYNfPmXu88xAW/0fP6vhK67wAGr+plp6HcTYDNYx8Ii9S19+bJqDO9j7pseE2KUH608qhHOipmL40oFXSHMOzCFCkgkwi+Gt/EVCAkNeuoS7aqz6XqdamJNRdSYbKiM0fbRTxVunWY+1BP160IiiMOR3U3F9cCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773272803; c=relaxed/simple;
	bh=YzwlSLZluk3858XZRDyxkAqSA1LftqWFcrpjEtN8CtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lv2oVI4Ah24d/BEXrxghYTcnAq7eSKSC70yFsZcanYQl8bBWqYWzl5j0MDJrjYKmzXSw6dJ0+WvJBJcBTb+HgNcDSXjbYk5fLo92hthl4pxb68cPblmZpSWpeFK2AlJBo705zZs8rKu5nPmqwQeNuU0tXbQePZiMpc4qqIcCzJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAKRFXyG; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7986e538decso4005837b3.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773272801; cv=none;
        d=google.com; s=arc-20240605;
        b=T9+uvqPjNy4pgQ5yrgGz5+88DRnNRM1a0F4KfAcovQxfDLLLe+/W6UUeKmnVKSZ0Ji
         TwjFWgrNrZAgDm39CEjXBnxJyebrGqB2p7OSK2VL29YtAGz68zU9O8YGyldsi1MvY27s
         PK6VvuixMu9Qkj8agSZ3KZHSsZQiVu+z8YJrdcPuDChGxof55rHU3kV8+85r5QbBlXT/
         9nc40L9ifrU+zpbG80ivv1GBQSPvFjxUqSabLXVsfuy11m/caTIOtc4hNV9PxmwBRI0M
         7Jy35m3E6zzTJNu//fBMaba4p8mD0KfHFkrcDsah0DS2HE9bpbG3SwmBZYFmhstsdWuD
         KKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9QhoL+0nsFv3FtCdUoKE1E6URC65BZ67JqpmCUBl840=;
        fh=7wNR09DoJVZVGMwKUaT377Kc/1CStZfxoxI/O6pVIIM=;
        b=Css2ygnLLhfhzhLPT3tLa9oAHsoELSQeUkRc5Kn26oo741ppiId/s0kDiiRo9L2ll6
         Q0TUbBw9utwWpGWSo8r3pPQFYdkwGHpRvg2d0TyT1EnKPbD/8/jplw3MZXcLRWQqD/sY
         GOuftoz74vhdW4n+4EaV5NZe4ViEd44BS4UORzev0Wcx+HX4OkdjbjpXdFIGLiNOzFqe
         o35cOD2pkzE3E1MXXUbEaj0rBJIws0Rc73W0f8u4bIagibn65Vh10c6N0yUKKsJd1GkM
         5KMCgBipS8FPpVU1XxUwKcRSIC1zgS7Mc8bsiAuNOiDs0rjw2xSCfsz/F4sxA0caK9kL
         3n4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773272801; x=1773877601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QhoL+0nsFv3FtCdUoKE1E6URC65BZ67JqpmCUBl840=;
        b=NAKRFXyGzHEIUlQy62kCxE6I3Kh9hGMNxRU4GdBs1tYA31cTJ0Cwu1MCgirm/6QwbF
         NmVIcnfPuo5TnFHnustDqSQ/dXdydJzXr8UAwmhP9aRrEvCWZCMCQOzkEjN508na5psz
         E+0Qz5qEfxWsDxoQYX2VlsjEso3Ryi7dL3gIe9XHl6dhwyqNoj3fumeuM39Eo4N34sRs
         DkMoP3R/Yr5/GGh/7w5nkIl2776fcBGxar/Au1VIevLZ7tWLvm+sVkPfYNT4cIRYE1cg
         zN88gF2vvzzkQvZk8JEMPuI/0F7mXJTzWyQtdbgN/LNKexYbspzina8I7TA8BYNekQd5
         lstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773272801; x=1773877601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9QhoL+0nsFv3FtCdUoKE1E6URC65BZ67JqpmCUBl840=;
        b=rhkKEv0iUotIxkvj9qI9Bbx1jPSswa76lIT7pQMMLbh11wvMz8yhjvpDWwU8aTXegP
         hXx5CKqjTsjuXy5WQDKUpaMCR4KoW5L9SxFkg3xgiRcVCMSdTDSLaov5BjNi2c76xw5w
         1+pLJfh3zFBSCM/E6ILDFQ2SedC/QZnbWFw3765diWjP6AOalmR8aMXWEkOj+i8HzZSF
         QBn1qkta41yjuwhOSTBFT7OxEvRbc0zLyb5eEPZ0gh1cbw3eEUPwSdTk+l3JUsdI4jHs
         fBEp7Ht4UL63pqNvCcNA1p0pzjr3L/5BY541ohy8JVHgI1I7XJxrvCOLCDIZNIHPDmFH
         Rjug==
X-Forwarded-Encrypted: i=1; AJvYcCUYQnuvxX+Br10S3QPo0rNcl1IimWBLqMI7bME4BTHi/J0W7iffIz4A3LeeV9ZhnVxU1xPQ66M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVw+N+NvN9hv8JDQnEPjQ3jgwrlo/X50FSM6JgwcuoQhGNPAC0
	bqjDJt5+NWl3HdbkFlTIqTu8KvN/fTYmxSrsxYmRDlM+2W2hAvod099nOi5Vf2FrL2XH8aE463P
	4puwXY8AXMTFK1uu8wMWJhMFV9muA/yU=
X-Gm-Gg: ATEYQzwOp6vsQilxxfAZsSHOyCAvEWn22BXgrx8GZ/OXhbw5atg18A8YRMNRVz8HA7G
	sFt0VogkLZ8NzYSEvrpTZLi0DMC3zy2lbT5G7PeyAddbMF9DJbs/mbGA83dgSAcmSJ5scVRX8Kz
	MeKCIwHmF4VRidld2LVYNmMn96fBTg+vXRrZ86MdXqiY6ucOhR40o2tjL6CtvHDScyeoogwuDON
	u7t+29hb6i4LzDtQBkWTfJMnSuRqzjSJmmsDA5WeYWKtG3vHmYNwftfDUwJexNCYDVK56sR++iN
	vZiY7Gr2Q4O0oX5L9Q==
X-Received: by 2002:a05:690c:e3ef:b0:795:272b:1ea6 with SMTP id
 00721157ae682-79917ea6cf3mr44490447b3.8.1773272801107; Wed, 11 Mar 2026
 16:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-6-ameryhung@gmail.com>
 <CAADnVQKkXKyqqW5zFC+N2NaU+7wD1XouqF9T=ReNivCKDWcFiQ@mail.gmail.com> <CAADnVQLCKi_QL1FeybW+6MH6FAOAoRJyW06UvtX3my3yNSH5eQ@mail.gmail.com>
In-Reply-To: <CAADnVQLCKi_QL1FeybW+6MH6FAOAoRJyW06UvtX3my3yNSH5eQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 16:46:29 -0700
X-Gm-Features: AaiRm50_avam9ZgMQfkCECKQ73-LOT500KiNfIihQv9dXnRXeHQ6OLmOIngxum0
Message-ID: <CAMB2axOmWD8oDc-TVxS2NzWjvvwXCo+N-kyqj2UWV8OTe5_yiw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 05/11] bpf: Preserve reg->id of pointer
 objects after null-check
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,meta.com];
	TAGGED_FROM(0.00)[bounces-266798-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D888726B6CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 3:30=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 11, 2026 at 3:26=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com=
> wrote:
> > >
> > > Preserve reg->id of pointer objects after null-checking the register =
so
> > > that children objects derived from it can still refer to it in the ne=
w
> > > object relationship tracking mechanism introduced in a later patch. T=
his
> > > change incurs a slight increase in the number of states in one selfte=
st
> > > bpf object, rbtree_search.bpf.o. For Meta bpf objects, the increase o=
f
> > > states is also negligible.
> > >
> > > Selftest BPF objects with insns_diff > 0
> > >
> > > Insns (A)  Insns (B)  Insns  (DIFF)  States (A)  States (B)  States (=
DIFF)
> > > ---------  ---------  -------------  ----------  ----------  --------=
-----
> > >      7309       7814  +505 (+6.91%)         394         413   +19 (+4=
.82%)
> > >
> > > Meta BPF objects with insns_diff > 0
> > >
> > > Insns (A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States =
(DIFF)
> > > ---------  ---------  --------------  ----------  ----------  -------=
------
> > >        52         57     +5 (+9.62%)           5           6   +1 (+2=
0.00%)
> > >        52         57     +5 (+9.62%)           5           6   +1 (+2=
0.00%)
> > >       676        679     +3 (+0.44%)          54          54    +0 (+=
0.00%)
> > >       289        292     +3 (+1.04%)          20          20    +0 (+=
0.00%)
> > >        78         82     +4 (+5.13%)           8           8    +0 (+=
0.00%)
> > >       252        320   +68 (+26.98%)          21          27   +6 (+2=
8.57%)
> > >       252        320   +68 (+26.98%)          21          27   +6 (+2=
8.57%)
> > >       119        126     +7 (+5.88%)           6           7   +1 (+1=
6.67%)
> > >      1119       1128     +9 (+0.80%)          95          96    +1 (+=
1.05%)
> > >      1128       1137     +9 (+0.80%)          95          96    +1 (+=
1.05%)
> > >      4380       4465    +85 (+1.94%)         114         118    +4 (+=
3.51%)
> > >      3093       3170    +77 (+2.49%)          83          88    +5 (+=
6.02%)
> > >     30181      31224  +1043 (+3.46%)         832         863   +31 (+=
3.73%)
> > >    237608     237619    +11 (+0.00%)       11670       11671    +1 (+=
0.01%)
> > >     94832      94836     +4 (+0.00%)        4787        4788    +1 (+=
0.02%)
> > >    237387     237407    +20 (+0.01%)       11651       11652    +1 (+=
0.01%)
> > >     94832      94836     +4 (+0.00%)        4787        4788    +1 (+=
0.02%)
> > >      8103       8108     +5 (+0.06%)         459         459    +0 (+=
0.00%)
> > >      8076       8079     +3 (+0.04%)         457         457    +0 (+=
0.00%)
> > >      8177       8197    +20 (+0.24%)         459         460    +1 (+=
0.22%)
> > >      8083       8086     +3 (+0.04%)         458         458    +0 (+=
0.00%)
> > >    237608     237619    +11 (+0.00%)       11670       11671    +1 (+=
0.01%)
> > >     94832      94836     +4 (+0.00%)        4787        4788    +1 (+=
0.02%)
> > >    237387     237407    +20 (+0.01%)       11651       11652    +1 (+=
0.01%)
> > >     94832      94836     +4 (+0.00%)        4787        4788    +1 (+=
0.02%)
> > >      8103       8108     +5 (+0.06%)         459         459    +0 (+=
0.00%)
> > >      8076       8079     +3 (+0.04%)         457         457    +0 (+=
0.00%)
> > >      8177       8197    +20 (+0.24%)         459         460    +1 (+=
0.22%)
> > >      8083       8086     +3 (+0.04%)         458         458    +0 (+=
0.00%)
> >
> > The table is missing names.
> > State columns can be dropped instead.

Program                   Insns (A)  Insns (B)  Insns   (DIFF)  States
(A)  States (B)  States (DIFF)
------------------------  ---------  ---------  --------------
----------  ----------  -------------
ned_imex_be_tclass               52         57     +5 (+9.62%)
  5           6   +1 (+20.00%)
ned_imex_be_tclass               52         57     +5 (+9.62%)
  5           6   +1 (+20.00%)
ned_skop_auto_flowlabel         676        679     +3 (+0.44%)
 54          54    +0 (+0.00%)
ned_skop_mss                    289        292     +3 (+1.04%)
 20          20    +0 (+0.00%)
ned_skopt_bet_classifier         78         82     +4 (+5.13%)
  8           8    +0 (+0.00%)
dctcp_update_alpha              252        320   +68 (+26.98%)
 21          27   +6 (+28.57%)
dctcp_update_alpha              252        320   +68 (+26.98%)
 21          27   +6 (+28.57%)
ned_ts_func                     119        126     +7 (+5.88%)
  6           7   +1 (+16.67%)
tw_egress                      1119       1128     +9 (+0.80%)
 95          96    +1 (+1.05%)
tw_ingress                     1128       1137     +9 (+0.80%)
 95          96    +1 (+1.05%)
tw_tproxy_router               4380       4465    +85 (+1.94%)
114         118    +4 (+3.51%)
tw_tproxy_router4              3093       3170    +77 (+2.49%)
 83          88    +5 (+6.02%)
ttls_tc_ingress               30181      31224  +1043 (+3.46%)
832         863   +31 (+3.73%)
tw_twfw_egress               237608     237619    +11 (+0.00%)
11670       11671    +1 (+0.01%)
tw_twfw_ingress               94832      94836     +4 (+0.00%)
4787        4788    +1 (+0.02%)
tw_twfw_tc_eg                237387     237407    +20 (+0.01%)
11651       11652    +1 (+0.01%)
tw_twfw_tc_in                 94832      94836     +4 (+0.00%)
4787        4788    +1 (+0.02%)
tw_twfw_egress                 8103       8108     +5 (+0.06%)
459         459    +0 (+0.00%)
tw_twfw_ingress                8076       8079     +3 (+0.04%)
457         457    +0 (+0.00%)
tw_twfw_tc_eg                  8177       8197    +20 (+0.24%)
459         460    +1 (+0.22%)
tw_twfw_tc_in                  8083       8086     +3 (+0.04%)
458         458    +0 (+0.00%)
tw_twfw_egress               237608     237619    +11 (+0.00%)
11670       11671    +1 (+0.01%)
tw_twfw_ingress               94832      94836     +4 (+0.00%)
4787        4788    +1 (+0.02%)
tw_twfw_tc_eg                237387     237407    +20 (+0.01%)
11651       11652    +1 (+0.01%)
tw_twfw_tc_in                 94832      94836     +4 (+0.00%)
4787        4788    +1 (+0.02%)
tw_twfw_egress                 8103       8108     +5 (+0.06%)
459         459    +0 (+0.00%)
tw_twfw_ingress                8076       8079     +3 (+0.04%)
457         457    +0 (+0.00%)
tw_twfw_tc_eg                  8177       8197    +20 (+0.24%)
459         460    +1 (+0.22%)
tw_twfw_tc_in                  8083       8086     +3 (+0.04%)
458         458    +0 (+0.00%)

> >
> > > Looking into rbtree_search, the reason for such increase is that the
> > > verifier has to explore the main loop shown below for one more iterat=
ion
> > > until state pruning decides the current state is safe.
> > >
> > > long rbtree_search(void *ctx)
> > > {
> > >         ...
> > >         bpf_spin_lock(&glock0);
> > >         rb_n =3D bpf_rbtree_root(&groot0);
> > >         while (can_loop) {
> > >                 if (!rb_n) {
> > >                         bpf_spin_unlock(&glock0);
> > >                         return __LINE__;
> > >                 }
> > >
> > >                 n =3D rb_entry(rb_n, struct node_data, r0);
> > >                 if (lookup_key =3D=3D n->key0)
> > >                         break;
> > >                 if (nr_gc < NR_NODES)
> > >                         gc_ns[nr_gc++] =3D rb_n;
> > >                 if (lookup_key < n->key0)
> > >                         rb_n =3D bpf_rbtree_left(&groot0, rb_n);
> > >                 else
> > >                         rb_n =3D bpf_rbtree_right(&groot0, rb_n);
> > >         }
> > >         ...
> > > }
> > >
> > > Below is what the verifier sees at the start of each iteration
> > > (65: may_goto) after preserving id of rb_n. Without id of rb_n, the
> > > verifier stops exploring the loop at iter 16.
> > >
> > >            rb_n  gc_ns[15]
> > > iter 15    257   257
> > >
> > > iter 16    290   257    rb_n: idmap add 257->290
> > >                         gc_ns[15]: check 257 !=3D 290 --> state not e=
qual
> > >
> > > iter 17    325   257    rb_n: idmap add 290->325
> > >                         gc_ns[15]: idmap add 257->257 --> state safe
> >
> > I'm not following. The verifier processes above as a bounded loop.
> > All 16 (NR_NODES) iterations.

This is not a bounded loop IIUC. Note that there is no else branch for
"if (nr_gc < NR_NODES)" to break the loop. Therefore the verifier
processes 17 loops after preserving id.

> >
> > Why presence of id on 'rb_n' makes a difference?
> > It will still process 16 loops.
> >
> > Which insn is safe vs not in the above ?
> > One after gc_ns[nr_gc++] =3D rb_n ?

It is while (can_loop)

>
> One more thing...
>
> How does it interact with reg_is_init_pkt_pointer() ?
>
> That pointer has to have id =3D=3D 0.

I haven't looked deep into the case. Currently, skb is non-referenced
for non-qdisc programs, so skb dynptr won't need to track it.

If there is ever a need to track it, we can assign a reserved non-zero
id to the unmodified pkt pointer. For reg_is_init_pkt_pointer(), it is
already checking tnum_equals_const(reg->var_off, 0), so maybe it is
fine to drop the id check (not sure).

