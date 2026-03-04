Return-Path: <netdev+bounces-263987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N7wFBB7qGmHuwAAu9opvQ
	(envelope-from <netdev+bounces-263987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:33:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD20206693
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B74931CD792
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD2A33D6F9;
	Wed,  4 Mar 2026 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yJGtS2/i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49DE3DEACE
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648155; cv=pass; b=U98A9YXH5hWrK1/WS0KP2p6CWEUjrjZDf4gkUlW8kaT2q0ktjvADVoDA/jmnjdIZWdLeBZZ+u6KAuVQMXriSvW/k/Or0Stw1t5eGcWpQh4Ir1ikecZPrxmY6tEAhLKyCqNTBOOioCnpYJn6kBVwYuTFwV9/ymdG3+aawDR60nyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648155; c=relaxed/simple;
	bh=9MwzP3uhQnku7obL0CECuVhwCCCsDCe3y2WbQ/ADWWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOhuBzwI23UW5jWuBmTQpEtV7Z8354j15kU1VraGLfxkml8YRmCMXDFcW0rbNHD7RAY+vjHnzxLGM9kGZbC+Gd618lAgpdke7ZsvGPbj9pCg0ICQbkC7O1fYwdJA4l6IViVYABSr6aZ499Movru0xVUrC69S1E1OaO5iDdhGzFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yJGtS2/i; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506362ac5f7so66129481cf.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 10:15:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772648152; cv=none;
        d=google.com; s=arc-20240605;
        b=dWC2KW49aAIu5Mod4CP8nI5cnxIBJboG8DZwgXSGYi+2iE/eRIts71+Ql89vJ6eiuJ
         gngXhvaybbZNAmW112DC6R81a9eZFuUgRqmLcZdHeU0nLVvXuKnRVdLZF3jZLcDUBLf8
         9PzR/grcn8uNHbdE+jRkPp4i71oWeZRPeL+/oz7SVBt0zXc8Wndlpjf5SFKwUL2yFnus
         tAZqinVAYrYEdA94TMSn0uE63uEu4SOESWQdbIvwVRxnBne69MxGc9sUbd1Wg8FwCroN
         JdiT4aVHDWcp7lAED07u33BjIWrSBjWCr5rf4gDIp7ezXNmuYyodJPbeM15yJXhfigjW
         yalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XcOBwlD6MQYPkUV4YAb3fb3w0HLmtc6PEbH9Af68W8o=;
        fh=Ov7W0LYbzbEdLyB82OLEKLRbND8ZwXTTfwyvadrYAy8=;
        b=Jp0DbTEqAXAnVnztOcqtJWQZ+ttlQrsT/LZlngYNw9zlFbLRIsSkLnN7c0GTvos+6W
         R637I+cKEv/1jtthsbwOAOr7r2zN1B1D1XEhh6HyuSDWIC7rLlcwxbb0Vltnfc1zmEZw
         2R4+1PaFQyjLxHypuV1pTnqMSWA2JPjqNoB1eB0JxSi0Y1W4XWg0aJbqxeLrD9IEohvR
         xudBRt4Z5rNl07PKwJwqL2F4W+FfYBX+AeQRP/a5IN3Lc6RDcLocM9slBBNy0lCfbV/u
         g8oP5xVKX2Plm8cXzHhyYIs1NAPE9Cw38znctc6BZ6sL874Z2dXwOF85fmE+exzLnPLm
         zn8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772648152; x=1773252952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcOBwlD6MQYPkUV4YAb3fb3w0HLmtc6PEbH9Af68W8o=;
        b=yJGtS2/ihA4fm35w13e6pcmk2o9uQWOwktFVSk5BYpEbo3WWpVfpwrvclt1ZQU+BzI
         YZrTKuIT6lbdHTJjgF0gU6X5KhQfpf2EfC34hdess7WthRfcdlPyVMdKZDV87M2cpzZZ
         iGBC8SjvWi6HMhFtr8FxbWHVwdUlFw0jPXFO6e4tkWCylZ+W9nIvUjmI9s0Wb5JfLnq1
         Ch2d2xDWtIt8TKwyRse1hDFG8vKUf6zyOtNJFocU/AmYNOtv4Ox0LOk0ZMjeBcIkInfa
         s9+Kg5wA0VNKy1EVD4zlphF5RvnkvFnGsILwsdcyKLizZLG08C5pig9OCH6xRnL92nqD
         SyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648152; x=1773252952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XcOBwlD6MQYPkUV4YAb3fb3w0HLmtc6PEbH9Af68W8o=;
        b=pOdWS9zeHKeM8lTWi+fIoJyi8gEikRAzoWNWGxlFW4fRYimBJvum6dTkpjA+gwisOv
         oDemSZNGDYBqh918YhFGPwtVTCKtoC+ZAgCkj8s28ij3RYmZ+oZLpiyVdAu8cdO3JwSQ
         ZBAINV9qp2Ob1lUuJgw1dEeSzg1J/dKDMUdQAlkvka+Q2MzHL8w/ue4W1AtZctFsNnYA
         8GQcik6wrzhyChU8tkpnreCJ4tsy6TnUqmzgIlMOQ7bpzdH6o8Qe2hceIcbKjyOKqETz
         rGEhFE36gIU872k3cS/11Vh3zCFWDCf1DO9+Qjx+6fTqL+WFezbMLLU9e9S+kj30jwj5
         M2Ng==
X-Forwarded-Encrypted: i=1; AJvYcCU5l3g4bJP6+/ZEchkXgwdHQXdMV+cWv7jDYwEzJWijGRMY18dV4h7EgrW1rfz9Q8EPXt4RNPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkZB2nVZO3iBSeaFtUso6dWpFVETBtFeIeSd79LrqGTWJRk9w8
	Of65pcTgMaQffxOwGgZwCG+Lv+BUE1BaGA0CVCbvKhIH0Lo63K/IgBsCdWkD5Sdn4kShn5+HBTm
	lZ/TZ2KC8n/Vw527+iABuwaudbJP5k05agsLeMBke
X-Gm-Gg: ATEYQzyA+avxlAW7EiL/vsG8+KS5KACaGcn46XzOfs5j0LGxHVkEgXRlZ+Yzq8NR3gH
	YhOV7A6FmiVvo08ALHEtIMxVYvj6vdBmtztkr3In8Gy2lhjWIUTaOTt+Yab6hLQ7kJSBsl0BRUF
	A52N7L61yKJFz3o3t22O6Qt1is5a82zmnep4UtSVhK8fAiccYRNQhnf7nRQA3oBye0tWeROXd3k
	mOiL3lCwQ7OFBroxcU8eulm0J2sG6XkyEGLio1VPBdgXsFDnnb46+hOCgA1FVnl3J2tqUYwNdpp
	JGkB3F7y
X-Received: by 2002:a05:622a:1386:b0:4f1:b947:aa04 with SMTP id
 d75a77b69052e-508db2ca0bdmr38936101cf.18.1772648151053; Wed, 04 Mar 2026
 10:15:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304111517.2088694-1-kmta1236@gmail.com> <072854a1-0521-40ef-b963-6e3e56084281@kernel.org>
In-Reply-To: <072854a1-0521-40ef-b963-6e3e56084281@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Mar 2026 19:15:40 +0100
X-Gm-Features: AaiRm504-7or6_xU6D4WOOgH2jGgHMALSXeOqt3vfn5JgtFDBEissEU0hjIFp34
Message-ID: <CANn89i+Vdj_CnnJZEwp9dfiAV-z1eSFBp+4a9z6FDS5Rw3k4EQ@mail.gmail.com>
Subject: Re: [PATCH net-next V2 RESEND] tcp: shrink per-packet memset in __tcp_transmit_skb()
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Keita Morisaki <kmta1236@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mptcp@lists.linux.dev, 
	Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: ABD20206693
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263987-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,kernel.org,cloudflare.com,vger.kernel.org,lists.linux.dev,davemloft.net,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 7:09=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Keita,
>
> On 04/03/2026 12:15, Keita Morisaki wrote:
> > Use struct_group() to group the three fields in tcp_out_options that ar=
e
> > read unconditionally by tcp_options_write() and bpf_skops_write_hdr_opt=
()
> > (mss, bpf_opt_len, num_sack_blocks), then replace the full-struct memse=
t
> > with a targeted memset of only that group.
> >
> > struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
> > CONFIG_MPTCP=3Dy (typical distro config). Every remaining field is eith=
er
> > assigned before first use by tcp_established_options()/tcp_syn_options(=
),
> > or gated behind its OPTION_* flag in tcp_options_write(). This memset
> > runs on every transmitted TCP packet, so shrinking it from 96 (or 40)
> > bytes to 4 bytes reduces per-packet overhead on the hot path.
> >
> > Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=3Dy):
> >
> >   Before: rep stos zeroing 96 bytes (5 instructions, 12 8-byte stores)
> >   After:  movl $0x0 zeroing 4 bytes (1 instruction, 1 store)
> >
> > Also add opts->options =3D 0 at the top of tcp_syn_options(), which
> > already used |=3D without a prior clear. tcp_established_options() alre=
ady
> > clears opts->options at its top.
>
> Thank you for this patch! It looks good to me:
>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Apparently my Reviewed-by: tag was lost.

Reviewed-by: Eric Dumazet <edumazet@google.com>

