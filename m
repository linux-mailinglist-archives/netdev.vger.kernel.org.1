Return-Path: <netdev+bounces-267665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMXkFBrLtGn+swAAu9opvQ
	(envelope-from <netdev+bounces-267665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 03:42:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAABA28B6FD
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 03:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16A1A308C616
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 02:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0782D6E66;
	Sat, 14 Mar 2026 02:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBDdoy8q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEE32C11C6
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 02:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773456150; cv=pass; b=jvtTmZ7T9XhdrwFodeiVGFFcZ0eBVvX8y/tPYSSJV24MGOdeA4SFtbcVGI8gB7ufjtVUDACC0yzp4fwCDgSWt7jhdgpKxUWGPqMcTg75tMMOZpF1Jh+v89ylX/qOMINwpm87syn+YxPnnZFzTbEmJ9+auu/8/f33CENxKNpvpJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773456150; c=relaxed/simple;
	bh=5efamlu/6h5TA6qznlB6+GKsMaEIxOQX+VH0GW13OvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMfk9MXD7iLiKp5l7sgLvr1vBQc6wvRcicbcuLhtzqk9cTBcFwaOWjCd4ouaQ0tpGHz7qvRaZaFWKvHfR88YHGv8LyK+htriM0NPOjgajvAy1PHwgFSXz7DlF/wNvcXUZ6noXQd6rirOM91Fq2Zhe1rGmJrF0hT0/8ePVCoQLuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBDdoy8q; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so24749975e9.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 19:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773456147; cv=none;
        d=google.com; s=arc-20240605;
        b=FOPi0+MkCBHkuCRowbTEig8k6Sg5zsX3Ntrc9zqy+Ubk12cF8ga/oAMTuBkPKONWgv
         U8BEmVZ+dhAs9oDnjvzJAIlm/Nr9KEhWIUF+qfY2elch5hjKRHRTJgZe2Mj2cbtSmsii
         ilAbk46SEHitwQhBcKdEvQJ5RYsOJ1PeZjDd9vpzrAgvXeA5A8ny4vtZDmQb9bSOzlxg
         M2gB40VlbxVrKvd6XbDPVjZoVhOnHI3yecOgugG/l3ZwgdJOi27glDdO7sYQ3iRVVc6G
         ZmGcmkurf0FUn8vnMzGrIHQvqP/zhRUFEbG0weyyW736w0R60xwTgNKDXv05eU0Pt6lp
         ImMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oJ/4Kkexba+G7whq1UxwvFb4fZjvu7eByDNhfOE+P3I=;
        fh=JduNlAaP29VlEMjBRG7Zb/KS3w3XIWhv8PpUoMyNNG0=;
        b=BaQhk1QPJnNrJGDg+t35UMvNsdIvS51ibZjlB+uEUMLiYqunNxxyGrZeGMwkGNCRUb
         ESAMdCUp2vjttbGGkat5G/YNOxHdkxR9Q2InH7kKfesJwJcfG1xlnc66y8mOoKeKbfCj
         yNIo13ao6OTycPPFbrSaoQYZyKuRe5CVG5DiOp/NeKOFgJsE8E8xsk+F5jFyeeNicje6
         nZ5UG4ws/VobgBEzT7slfxR6IaxKLKsF6eQX/cnFsqHQmh9YleehArAEorSLCriNeL6X
         K4yeSo9v60WFZ3oYpa/B1ZCvbpqtRSaN3OLnjA/dzbuHxEcvmU1Bu0MKxLIb0bF4rbLy
         jcDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773456147; x=1774060947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJ/4Kkexba+G7whq1UxwvFb4fZjvu7eByDNhfOE+P3I=;
        b=dBDdoy8q0iJvGD9DRshvqHzTKrCkIeDLjXaA0Nj/NLEXkjC4nOdWR0BRHIIV8mbth7
         NLt65FIhJ7aTQRbaAqhCa1wTrGefv77M2N4dTAATfvdLUPggaRbqavOG2FOrJXQIBqiG
         +442WlXBqZv3TCIKerGiyT0MkAwCp70g53NX23vjoXb6F4lMef0IRNmuEr0pp5r5dCHN
         tpgabsWd3UB6I5JxI3SJqk8bo37Z3kV7qd2keZRAzfZitds4geOTssjWy6DFPTDSgma1
         yVI3vRBIADufOx0RsywAWH6jUiGoPhpB+L1q47dZ6ecYwNEjc7FmdzlW/q1PZ4QBwR5Y
         H6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773456147; x=1774060947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oJ/4Kkexba+G7whq1UxwvFb4fZjvu7eByDNhfOE+P3I=;
        b=fIJX3uCMsnivv7X4YH2zU3gkBa0cYZ5XBn80kxXbly6GHJwDBaN7BjQA5VcvHRR1vx
         /sGEO/j3xTXdSB55coycKBTaxlvpJz/F7iQSEt1o3Ntmv2iba6+ZFB/M2ulqCej1LmtI
         4ONPQz3sJGT3zbnJ7CPR/4jMP35ROtDo10sSJzsgohGSzeAISmi0wMwJefctFFcQ6XCP
         aOCkbrvl7ENBDvGPrmIFuwoWyIzRkcg4qYCxFlxBxu3W4tWbndDv0d/o5O/H3DMPBliA
         bHHhy10NUS6jS4mFWFdh0CoAmhag0zJQEWb1v8EDxP51Mx1axxqxXS0jwIwYvHBHLbsr
         ToWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/Ss4s/Ec7QMq1T5wlcnDrwq8D9YlRtD1ZKqDusA7q5l/NRMZxlCqLCMCa0oEGF4aeMRnhPEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH4HGFlptB2kPDkttwlLDyymRuq3OnQjZN3m5uKcLFHnEsHX1P
	10ZAdzzjDHE8TVE3jgYdiPT3g723+1iC2ZNVfh92wcIdAiV72yqhcn2F4Mf88NwHXx0bcVo+9p7
	KCPtC/7+2hyR4SSCXMLVGwFcDB0aDQiw=
X-Gm-Gg: ATEYQzxuLWbO6NJ4fWedIGHgywXy7Y8Jm8K6ZKi/VMI6wQN0YLElrTg4nrgYgbEgbFP
	+Q5/JpbkXo6MMIEJ56+KenhzLKem2g/oE9CfTH++7alPQQShoRL+Tq3ZqwDluah/cmRkddaaBWH
	nUodaa2j3sDuSXuot+7JK81dPESpn2GfE+sdoEGric1H0OwI62MUGOmoAjpxQpT0sxBPQey2I75
	g96286o6F68fifFYYq2vsbyrKBK1bebFxuXVUMj8j60ScAKYxWZxgH1LJgt4LYfm/uMxOb7xvdS
	qgLnR2yIGUDvE/wRD4nXLxTFAK2r4fAoIWcmLYU9lv0aEpbJaAk8pKPAkxH9dLabqKHAGB08MUf
	PDg==
X-Received: by 2002:a05:600c:1d1a:b0:485:3d00:efd with SMTP id
 5b1f17b1804b1-485566cfacbmr93486995e9.7.1773456146954; Fri, 13 Mar 2026
 19:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313130220.18590-3-slava.imameev@crowdstrike.com> <4955a2c6a7fff7f4e383149e3b699a2af5eab965e414f3f19443b1caa97ba53e@mail.kernel.org>
In-Reply-To: <4955a2c6a7fff7f4e383149e3b699a2af5eab965e414f3f19443b1caa97ba53e@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Mar 2026 19:42:16 -0700
X-Gm-Features: AaiRm52oCGV0a1Sapwhi7UF0cUrBG8nmXyaBC9dXPLJgEdUbmwHD1ZVrTgnP0U8
Message-ID: <CAADnVQKcutn9QO4UjfcnPw+Tnv2pmHavXCa-BC083rrgP8w_ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add trampolines single and
 multi-level pointer params test coverage
To: bot+bpf-ci@kernel.org
Cc: Slava Imameev <slava.imameev@crowdstrike.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267665-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[crowdstrike.com,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAABA28B6FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 6:55=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c=
 b/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c
> > new file mode 100644
> > index 000000000000..b507dc850543
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/verifier_ctx_ptr_param.c
>
> [ ... ]
>
> > +SEC("fentry/bpf_fentry_test_ppfile")
> > +__description("fentry/struct file***: struct file *** inferred as scal=
ar")
>
> The description says "struct file ***" (triple pointer), but
> bpf_fentry_test_ppfile() takes a struct file ** (double pointer):
>
> net/bpf/test_run.c:
>     noinline void bpf_fentry_test_ppfile(struct file **ppf)
>
> Should the description be
> "fentry/struct file**: struct file ** inferred as scalar" instead?

Pls don't ignore bot reviews...
Do you agree or not?

