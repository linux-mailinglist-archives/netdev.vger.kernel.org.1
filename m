Return-Path: <netdev+bounces-267292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFbTLdaDs2msXQAAu9opvQ
	(envelope-from <netdev+bounces-267292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 04:26:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEB127D133
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 04:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C9EA30B0A57
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E3431355C;
	Fri, 13 Mar 2026 03:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euif4JZE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCB3230BD9
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773372352; cv=pass; b=h5BT1hpF/JJ+INIopICfUtYPxwDvlafqcGTzuxXAHxc46PW3BXi9lpb7VCOkZ1ias+EeNrudgut0wWJa+Kw5ZKysFQtyi393nUq0sv1yTrSNFdEaY5fiJAv23UnUq/TmX5sSV6h712seNtmiyzfRH7+rgocClhqtmrwomYAOnXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773372352; c=relaxed/simple;
	bh=jJS+hhpnUVOG/Ej47nAnN1GzIMfATuqoW3/771u/U+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+Nng16zf4y8KcbPlnIVnb2MGHvoqrXynD7RdB1aZPNfcg0ay2BMkaSlDj/vR8pMXNsy7pq7jmp2KjUYGkl2SWI/5nR9C1+3j2GNU0Uj4tRbswxLG0708gXOB1/uizuJ/w9f0BumQDhWfrLdS/jvNt4ABx64TRmUmuN/iZqkNSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euif4JZE; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso19614605e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773372349; cv=none;
        d=google.com; s=arc-20240605;
        b=aykbkO6Qxj+CmvpW4TeJS9IhFF27jca/shZ1VEKObf5gW19/SJbHEnYKOJXlQ5GRxN
         OSPuXue0wtjTpMdq+p/s37rnDCG/Gcmm/Ve/AK81rCjtvhBr81C9k/Umig0l0iW2xiKe
         lpyaO/tvkkDGxJDU/E6f7MCgBx1TAzBMSJL3hVNAzlkknpYKi7NsNosypc3keGWT0g7x
         FP/MUEfjwvmiXWNhel1UcljswluuNBd+qRDetCkkQOTCwccFaK/S4uFqq28Mi0Zb9Ke4
         75Ue6IuH6sLXhIB/un+V+e5TzlZjRN3Ll9cKt8fR6q9eNMuDNbSSv8OBmtBkvBoto+kk
         0nHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DjdNkWmuFGHAULzlA4K3CXU4TqPSpjiv6ig00VxhSt8=;
        fh=6nGmo/gtkFePMMM3n6gkN/jncoP1Q5lvA0pio6c0rZA=;
        b=DRWyGHoc6IG2bTwfTw9AMVxMVddx338tzNgBz5ajOOLadF8dK0iuynesGzzL1Y2tRt
         fyQ2vslEeutQCZAbGyCSuUZgpxgLZiguUCDJWJ2Ti6PSrVtJkks2dEnthf0DlZWo257Z
         VW74zw2U9DinkYKO2/i1QATcr/CM9cvjv6zS2ZXCUlz7Y7hrtqwOAhDJh+hwe3SNAlCt
         9GBdxiOmBuU/SD5MY5/luLjgsr1++mp4w6R4Zy9jn7D8zX7wceQS9PUJ7mV1UorvkQKw
         kGwRLzOGLVfGES6skyHOi9qhVGZRYcdwwhdE4iLHGXoxtEaiUQ7isWXsgQzqibBzT5P6
         6qVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773372349; x=1773977149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjdNkWmuFGHAULzlA4K3CXU4TqPSpjiv6ig00VxhSt8=;
        b=euif4JZE+vjNViFVoElHdNGDKly03h8ZDMvwh1xvoBbdfEwiJru15jF6gQ+wdpsR0h
         zvISHzESYE/IJW2DhaJqkb/PmgsC+PEQp2HNgZfDmtjA6Be58Mql62r0J4yx6tfpBWab
         e5NAhb0RZ/ogEnSvDcVm8iKn8U6PB0Qc8Osqan9YqPkAjv04QJIWnx8h0+fFroBkM6ie
         scYZaMR0KIppwV9KgddshEe+5Mgjg118hNF1xNE5YSv0AfW90AzArPGLwy0TBwf252UV
         eVnv4gOuFj1mbahKHKSmS7RJI8DBCmT5r1XBAsQio7TMq5PfyVZehhkZLL8tSySpTckq
         Bylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773372349; x=1773977149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DjdNkWmuFGHAULzlA4K3CXU4TqPSpjiv6ig00VxhSt8=;
        b=UQ+3AFw6V8EMcT4AJwHiEdnHLVXQSVrXNP4OprS/LRn27PNLH01eLlC1rowL+fuDdB
         AHYcuXcT9U0DieSGyf2AeM/HI+YtczH8oOAvr5c8oRvXkHy2pi1Ib+zHBRLOpIfASOD2
         ScDBCgMmYhioD4FE5gLH2mbjefau59PFj/qetvo2E6l4fbvsKPW/Ras97M3AZKSdJwF7
         poDI2RBzNDPcUymPyXJfmpCU6jLI0s9nvZsg6s/6+taQ18rniT0fAOAX5KG+LFbb5Kjv
         6CQ0fEMN26JXNtb0bCtkk3P9K5X9cwQ/rKl3QyR4j3t7D/Z37hfrBs6Fq0AXmKHFmsax
         wdKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjuOZWe+RP5UfuCi68/N4ba6UWNjYhiqRyM23Ko2LW2el1RRDsLeedPd93uTyqQ8IoSnInB64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2vY2/U+G9JVo+n9t+9s35zWkx4f7+CambM3yYpuLgZeaVRHhL
	JHt/Io8NXh0Dv+3LmoqYo3bAeeklUtzSoq4Fi3FnUMmjQcc/vVthn0R4FZixTsize3Bwbh9IrEy
	Bau8+H4lEc5wIHokLF4qeZ2YTnYJrewk=
X-Gm-Gg: ATEYQzyE5jvvBtX/O4Jw5WmL7HnnYwfSjwYwUXBrM0UpfiVyxEMvzMX4zxXYSpF6uxf
	5XsuoCyUOw5Uu4uPcO3armBae49TcQsZOqJ3DOou06jKnXeiRLkSMZviOmFfl1f2ifk3eQ3VFrO
	mksBg/Sw/7dljLknuHHlbQtg3WSyG8+vjFd1DM4sqV50zCzpRV8ajsWh32czRZWI8yeka6A4z9o
	PxMQfTG42pygee/351dhV1YCbJbDbzeipoyoFFD/DHHhBLVv8AugHbhmZKY/yujy8/l0pe+A442
	R1Ssb+HQVdekfPJm7uKdkbRIVlGKjIcKWFedkvWHfnbrrlR2Ce0to+x545hqjcWOjdY=
X-Received: by 2002:a05:600c:19d2:b0:483:703e:4ad9 with SMTP id
 5b1f17b1804b1-485567027e6mr27457915e9.19.1773372349282; Thu, 12 Mar 2026
 20:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
 <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com>
 <CAMB2axNR6qPRVy5YCiMygVseS+k9JxY9DFONNHD5Lt8=wD9MGQ@mail.gmail.com>
 <CAEf4BzYTO9e-UAEd+W+ftqQZLUZCWHWXAYVnVjHeNtsZL1=Pdw@mail.gmail.com>
 <CAMB2axN+8+V+29r9tuoVF57ObpvkUE5d5_8jtd5iRPYq4_gLGg@mail.gmail.com>
 <CAEf4BzY1O1Ne9Rf+O2terCT8f9e6pNFr3N4hOv98N84ZoehCaw@mail.gmail.com>
 <CAMB2axN8Qe6r_siq5_6od7D_kDZPcYw_Z6KVOFtXNJVKzajqzw@mail.gmail.com> <CAEf4Bza5bNf6MsgNrr9WqE5ZKhRQ_PwtdCEwaWAVLJNmAZzv=A@mail.gmail.com>
In-Reply-To: <CAEf4Bza5bNf6MsgNrr9WqE5ZKhRQ_PwtdCEwaWAVLJNmAZzv=A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Mar 2026 20:25:38 -0700
X-Gm-Features: AaiRm50PvuBQGkWhfwi1pHRbvVaBb5_HrvDIvQ0oA3BFbrNbnKznFi_Ct8lbq8g
Message-ID: <CAADnVQ+kQys+50hammWjsLFE8DK6FKgn1mPnKu3c9O_R64vJMQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type flag
 based on prototype
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-267292-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FEB127D133
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 1:10=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> > > I guess I'd suggest
> > >
> > > struct bpf_dyntpr *const dptr
> > >
> > > to mark this through type system? that is, *constant pointer* to
> > > dynptr, not a pointer to *constant dynptr*
> > >
> > > WDYT?
> >
> > I think they both make sense from different angles, but I am not sure
> > which one is better.
> >
> > From purely C's point of view. the pointer points to a struct dynptr
> > that should not be mutated so "const struct dynptr *p" is correct.
> >
> > From the BPF dynptr abstraction's point of view, the pointer points to
> > the underlying memory (e.gg., skb, file, ringbuf, etc.), so "struct
> > dynptr * const p".
> >
> > Any way we choose, I'd suggest that to be a separate patch. This patch
> > at least makes things consistent and fixes a logical bug.
>
> if we could rely on decltag, I'd go with that. But *const is unusual
> and stands out, so I'd go with that. I wonder if anyone else has any
> thoughts.

I think C is inconsistent in how it propagates constantness.

struct foo {
  struct bar b;
  struct bar *bp;
};

const struct foo *p;

all fields of p->b are read only, but p->bp are not.

So both:
const struct bpf_dyntpr *dptr
struct bpf_dyntpr *const dptr

cannot really express that a memory that dynptr observes is
read only.
So, imo,  btf tag is the only option, because we can define
what it means precisely.

