Return-Path: <netdev+bounces-255494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AniOc9OfmkJXAIAu9opvQ
	(envelope-from <netdev+bounces-255494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:49:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B0BC3941
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E59DD3011F24
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDF0367F5B;
	Sat, 31 Jan 2026 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKE1i082"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD25367F50
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769885389; cv=pass; b=fXSwASgD080jkNXw+1BTH4UDOSBmnp7G1h1Eq5uGhgRuzVTrJrVHTPDPwr+4DQLOgwMmGGzHm+A0Z93yG/j2DLCG/wqyfyuuCvX1m5oLf7TY1FNa+ApStG+S1kARMcepbjsM1D+c76nf+mgQKTNefl+D6NotbyI0bdpBG9Fs1mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769885389; c=relaxed/simple;
	bh=dEPIDbpVDGVStP2kmKFvVuPvvr0MPhgKCs/HsINDJWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdGEXc4VIbScYbVhhQdqyEOS6nDDmc5pKX0EDXr7pMoh2DUx+P+QrFoeRF3k2++n6FlL2bFO5fJOaVdegEwJh3s2LLTT0g4VdJpL/VjLUeyqUZ+2zNwKVrjyVN6CPQFCZ+Bnth5oStAAjgcGJgEGW3u8RlDXwGxz78wGAYaQ2lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKE1i082; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-649655f14daso2947351d50.0
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 10:49:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769885387; cv=none;
        d=google.com; s=arc-20240605;
        b=cdBpON8dcWqotknZIZfqm5QRkDC9PpQZtNZHk9IcK8K+tpl8NGHxxMRHITndl316ox
         94woKzDALKAxc5+IwpiIxD6Uxiv/BfUF+LqGhn4tvlnoVzQGtyruAVlkNTTmttZNFkZ7
         z69OFF67VP+m7QTZLy9GzF+bhfOgH0wp3bPe3pgLs+EZM2U4EHoiMNzED/Tq+KC7cXF6
         DLCU5tAJXaRL05M4IKeE2icSkXHnpeVLIfVJyEZI/TOd3YrU3I8eXA6KYDlLdPSVYpzQ
         zxSsSlhOBI+jJJPtVHORaZpn3M2+K4gIENr3Ihj//B3T2KO69rKapif6IYifQO2tkW5q
         q/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oXHEZMRB2IMrYQ/E3FqCsNDjQQs4Qzp+JLdtQMC292A=;
        fh=YvIvw3qWx3T82wTrRSVqjJvVNS9z4dhIycQnY+5C1Sg=;
        b=VkkLCRwpCjjkmETGxMeI4IW0qh9UI36VO4Lf6qeqgO2CVUCBt/bR1Awt9dgucPaVGu
         MTBYif6hQzxeX1lf1ZHhj2eFTtS2KcdGskgZQM2RzrPpnZwM+JcSRErkalthuA49vsRO
         7sObnHNqeHnL49oMm8IAYG0Tvlg853rhCfSxsmvgMMhxgfJgAlYleY2wssnsdNcMoWnU
         pXIw8o9FM4dgiYoVzz+ClsugTqxzZ0Nmi1xC4NNBBozMTgmK0HsmgwgOKJWlEpF5NzGG
         xPWqsWK0rpKPPPE2WMWH8KlUvLTAgc/jrNJC8oSI4Hsht3tIZm3jyOEdy7LeHzKhXzvg
         NXZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769885387; x=1770490187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXHEZMRB2IMrYQ/E3FqCsNDjQQs4Qzp+JLdtQMC292A=;
        b=FKE1i082Z2NwDu4VoMW/vaPiRWhY3cYSHXiFeP60l/GRCm96J8NRch0H5L+ka3Mig/
         TPNbsJLiYvdPLAkX7MiZjogmJbWC9odVahKTikyEYyAkrqqO0ZYeWbMiDn4cpZuvBTuE
         cQYHvMpT8fMMF0bJRfDwv4h21VsokUoo/SJMjBtOkyecZGfhdV4DFEu9FCVzSQrfQRst
         vrZu1TpsvWZ5RcQAmwE4H/Tpxvgg9FtEIlRZqhk+rOdMlE7GOuHy9okF0Mc1WepCw0e5
         kaTavF4RWv11YkJM3AbcGqhTYlK23eiuoauv3QLj4O8kxCXL7aDo02yo2/eBprJFd4VI
         Y2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769885387; x=1770490187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oXHEZMRB2IMrYQ/E3FqCsNDjQQs4Qzp+JLdtQMC292A=;
        b=qBAc9XLcbRs1qiTuCxYNPbL5F5GXaalidPjEY6EXLvQTWQCCQ0h1NIcRXyK70Sh0Vi
         Wz4e+NKGG2cmL0AA4J4oEZpfww+nMlP0IT4E8Nnv6EvvwlbjZ+X/umqphRgGwsX/EDSK
         9CNvGqjBsCyx8eVG5h8kbeOpMiBTXqRRGFX2VllAPl7DRh6/TABOmsSwy60crWbQF/YB
         nToLqaqlhkrKi7FID/XW/trFocLlxKpjtfWtISbSYzSlHIdUx0LpMxUVmgVROWo9xkny
         u4wLX0cIcvGhzWJ2M38PpQsplU2tWenFuAnVqxvTrQYww6XleB+jRuVZJLz9NW6Vzuz6
         v7yQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3oKVGkF0w11y5gEufkF/5IxlGw0RDqMBOaVqveQEOUqBwY4cQXzMlY+VlGKez4OdP+EAQAEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNibhXgLTP7aG8uAVJEUYTpTegpNiwooVJolF0OANGBfhIMJg
	sIxndXYOzEpyHVZwOUN9b9Qpjk9u7rNl7wWewvIkSQTagIx6JY6yooUHzTEXQeVumlB/cEOOJcP
	exLz07Y+K4evAg4TTOFY8Gs9RwViRYHk=
X-Gm-Gg: AZuq6aJXtJfNVCx/GhYnEgtaMm3qKWRYN10yNy2IRl7a/2L4nlCSmyYkR6RWxy7qJqN
	lWO522kS72Mu2amfEnq7+yNHllYJCG2e6Mffb64rFEIyRkmIE+qIi6EgJW/sILh2M2wb5TWy57S
	xGqhqAq+6pmXKBirVTHtQbsPC52AUv2Hs9v7PnKXZhN5J+uU/7Gmf83fumgDnIOPHSQAq7ffLvt
	BzEn/5P+aYzTz8hXW0mgYu3JkzeR8d5wHkucoimBGcEhvHjtVlBd5BSG51jSWqAUQ6+D0svlKWp
	LRumPg==
X-Received: by 2002:a05:690e:1249:b0:649:5685:450b with SMTP id
 956f58d0204a3-649a8501d25mr5195022d50.81.1769885386844; Sat, 31 Jan 2026
 10:49:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131050920.2574084-14-ameryhung@gmail.com> <82944fa5ded226a7a91da123ec384e8e353df448628c47850c6bfa9917f85960@mail.kernel.org>
In-Reply-To: <82944fa5ded226a7a91da123ec384e8e353df448628c47850c6bfa9917f85960@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 31 Jan 2026 10:49:36 -0800
X-Gm-Features: AZwV_Qjt76zOwuZDomZAmIgIfiKk0V-KRrOkxhySSSMNB-cnFg6UnsRAQ65kVsA
Message-ID: <CAMB2axO4=-b4PekKq3OzB8o3DeMM-0oCF7w_P2cfyHkYK4ab7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 13/16] selftests/bpf: Update
 task_local_storage/recursion test
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kpsingh@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, haoluo@google.com, kernel-team@meta.com, ast@kernel.org, 
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255494-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50B0BC3941
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 9:33=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.=
c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> > index 42e822ea3..559727b05 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> > @@ -117,19 +117,19 @@ static void test_recursion(void)
>
> The comment just above this hunk at test_recursion() says:
>
>     /* Refer to the comment in BPF_PROG(on_update) for
>      * the explanation on the value 201 and 100.
>      */
>
> Should this comment be updated to reference the new expected values 200 a=
nd 1
> instead of the old values 201 and 100?

Indeed. Will update the commit message.

>
> >       map_fd =3D bpf_map__fd(skel->maps.map_a);
> >       err =3D bpf_map_lookup_elem(map_fd, &task_fd, &value);
> >       ASSERT_OK(err, "lookup map_a");
> > -     ASSERT_EQ(value, 201, "map_a value");
> > -     ASSERT_EQ(skel->bss->nr_del_errs, 1, "bpf_task_storage_delete bus=
y");
> > +     ASSERT_EQ(value, 200, "map_a value");
> > +     ASSERT_EQ(skel->bss->nr_del_errs, 0, "bpf_task_storage_delete bus=
y");
> >
> >       map_fd =3D bpf_map__fd(skel->maps.map_b);
> >       err =3D bpf_map_lookup_elem(map_fd, &task_fd, &value);
> >       ASSERT_OK(err, "lookup map_b");
> > -     ASSERT_EQ(value, 100, "map_b value");
> > +     ASSERT_EQ(value, 1, "map_b value");
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/215393=
40647
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit message demonstrates deep BPF subsy=
stem expertise with detailed execution flow diagrams that suggest human aut=
horship from a domain expert.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Stale comment in test code references old exp=
ected values, causing potential confusion but no functional impact.

