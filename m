Return-Path: <netdev+bounces-295431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zAU0EDX1IWq2QwEAu9opvQ
	(envelope-from <netdev+bounces-295431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:59:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91860643B84
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:59:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GDeAJUUr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295431-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295431-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7499B3015711
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 21:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BF12EEE8F;
	Thu,  4 Jun 2026 21:56:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1373BBFD7
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 21:56:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610217; cv=pass; b=X0HXjviLX3EhcKSP0BSEdLPj9SO+BWl35uTU99AkNC9m8uzxZSZudkPKoAB3KPdRZavfrBTNWOL/jloKEG2VEsZxEO7PnBK020+/vXWakqoZNEv8aYL3qz1WkBYcVfaMZaqFvLLTJjdQyidP4eIn+369brTAyz9WuUVs5WXgTM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610217; c=relaxed/simple;
	bh=GIdR7oXqN0/LHonkwkN7zibl3m3ihCq0T2taL9KvOb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptZT5M11/+9v+i9RGJtvlAtyHwnd7LaYA5WNvfAOEVwhseDzngLYuS/tf5RzE2TQ/AcGkXbQfsU3x92sLbMixbeuYy9MLs9LcfQ1IHZXTsku0j6slhEHaPi0NVjDxfUb1eMkughl7cf2kwJvZNvbGvY6033fNzcuXBDUjmhsXes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDeAJUUr; arc=pass smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84229481d44so569754b3a.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 14:56:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780610216; cv=none;
        d=google.com; s=arc-20240605;
        b=g4/lYDAjEYHzUtTus8Rs6NfcNW+ltlPNn6Q40fbLOTQqJqgEJpuvKcFs+ohGGoOuHA
         79DFzy6sG43F8/wd6n8WQlKi2qG9pf97dv+1vMLzu8Ncd1yox0faUM3tjmiKz9Qi9UHU
         0wiVV2vKR4n1u1bGRqXwv2lza8f2yyrJ1gXmtuAY2hNC9qI466aip7EP5U8+ULQjIQud
         yXMa1D+K8QNnE0o4wpmCEbG4KDbSUgpkTJvWU/Oq3cCsQGZA247+SIi7vP94WMWJVptv
         xiWTpqRZ3sV0hS6xCNiE6i5LrbEHmTTpn3vHc7AYB+tT/0+o8tPfhlOT3cKe1ng7YWK9
         Boyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B4P/E5eJRLHfKf3xAmuxsjbx58eaDCcmLeQej3n1fA0=;
        fh=A7Gf0h+BSxANZPyd/202dd7odkMopc3XmYTdDroGHTY=;
        b=PaUFhIIm0yXIJcRhz69MLqjCvnUwsKCvtSLaad4zRp3wwk4C6vIicDkybbKnNqWz/+
         q6mjotM0b4RlW7tdjdBgfG5cJrj7yAoe0QqqRYwLolvnHfXvNdpMsiIGXYd+zwmVWk56
         uW6jhFuHR0+ziIShrXqxOviyFfUEgY89iM3Z7Jr/ZwoGLDrQ1pFRWqgdwCOuehvOS0EX
         Tp12UxEXi2jjTGHb7IFVZYVys6Ywia8ZEipbVqMnIPgaXSpnwwUHHFp1VH+GyVdqIuwP
         UjC4O9sorHdqZ0s5cfaisGObfYfhgPlDymZMS9X9fMr8HisieIWGcA7RbBbFA4phA/R3
         p8pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780610216; x=1781215016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4P/E5eJRLHfKf3xAmuxsjbx58eaDCcmLeQej3n1fA0=;
        b=GDeAJUUr2FNIMnSIcQ9d5U4kqK5otWjjbAECP2YiTVpJ8i2oVLo+TBEff/J//y02mA
         KCy+2Uqie0pqFKLBts1+JUmDKgVSmDLxe91G3ELB+QWVfoJnjw8KKkG8GC9meb3UTLe4
         UDawuyFW1HcXtVh+Hy7AdL4orPo4V4IvXnPC9y1RsvRk66BpjCpyqWf1JONcLZ31vfjc
         epUm9zYKVlKCE8B9IsAgXRHETLC4azq2EgK9uwv7g2W7dmgiazen/txBJHjl7FNvf7JD
         r+eVWV+Tj6KcsDjyKMMCNrdhQMfKT3B/skmCgT0ueSu3m/Se8Vj5KghM4/AT3T5w7Dpj
         ug6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780610216; x=1781215016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B4P/E5eJRLHfKf3xAmuxsjbx58eaDCcmLeQej3n1fA0=;
        b=cosUDxckiXsddUhQ1cmSSo3QaYcYoiGR2rXPmp9vCtUmaHiDriDsmM5L7toxBOvGIE
         rgnEaeknaBepdRU10gaDAm3lRWLnjVcV3LDe/IhWHFutCkXb6a4DJLwf/RmhlTXsbPTA
         vF4mV39Pt0laNS0yS4WqXtMZvuD3Ru+NWg/XWQ5ylKTQv7XDU2FDA93Nb+5d1qjXI7N3
         mGybdEkn8Wbez29MO0Be5lRwXj5fnXkaeBRhkV0JDsQmgoPkZNiUfoTXZskmuKhZ4+8G
         J4UbtSIA5FdMMqilvGB3VrT9kDHu1Hs2su9B5Yk+7GZp9C6SkZChQuuISX7Qbbpx5ad/
         oD2A==
X-Gm-Message-State: AOJu0YzRxCuTrL1Zr6XWLaQFGHGViXwQv8G5O8i6Myz1LQYgXRGBlND2
	30hkgSbPAHWtWbve+sXVUQ4iyxPDY1tLGnLvp6yQbZLyWm+z36CGpXAoeUc2IBlohGTz/PZYNjR
	f7OjDq4WZAkGV7p2KEWkwJJJWZRS+LmQ=
X-Gm-Gg: Acq92OF2vwWQspaKIR59++G7jf+9UexNBvG+Nsv+Udn/x20vIYnhSqgPkuk07Mew2zz
	nr3bn/2UgCYIXJIU4LHho5rXWECSVFJvuAGi5D3Xb7MzkliD0abQDX03s1NQhQP1eHV4DrOt1+I
	0AkMn7YJQ4Mk5bZ9gAqJj4LUh0NHdKO2p7n5PkUIV8dsBUOf/iKhu778A1SVKSypI5xkKGkx3gz
	yrFeR/Z5M6ULby1/JjAZbWyhQjl6CQuBjp4QgzGjWF2uGGrq6r973oK2WQM3y7G6YLDRXnc3HPB
	undxiiCclqIscBsU46u5gZl1+THNyjrCA6DtBMpvENEtZE3qKWCk6Mo4bic/ZeZahdtGi3b9YiK
	u17nXrsyyNUB8FmTi
X-Received: by 2002:a05:6a00:982:b0:81e:ef16:b288 with SMTP id
 d2e1a72fcca58-842b0ea4a70mr489004b3a.22.1780610215549; Thu, 04 Jun 2026
 14:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eb60825fa22d6f9e663c7d4dbb69f397b5d34d42.1780362366.git.lucien.xin@gmail.com>
 <20260604104712.3904260-3-horms@kernel.org>
In-Reply-To: <20260604104712.3904260-3-horms@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 4 Jun 2026 17:56:43 -0400
X-Gm-Features: AVHnY4KeqM76a83Gitn5qA73uaqekrRS_cFoPicNj3QEsgW6dv5w_KCYuv_b4us
Message-ID: <CADvbK_fZ760o-A1JkFvzTphdsH9Qugj+BE+UCOba3v4GQJdtRQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate cached peer INIT chunk length in
 COOKIE_ECHO processing
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	marcelo.leitner@gmail.com, bgeffon@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295431-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:marcelo.leitner@gmail.com,m:bgeffon@google.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91860643B84

On Thu, Jun 4, 2026 at 6:48=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> From: 'Simon Horman' <horms@kernel.org>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> sctp: validate cached peer INIT chunk length in COOKIE_ECHO processing
>
> This commit adds a bounds check to ensure the cached peer INIT chunk
> length does not exceed the available data in the COOKIE_ECHO buffer
> during unpacking.
>
> Simon says:
>
> Hi Xin,
>
> Although the issues flagged below are flagged as pre-existing I am
> wondering if they directly impact the effectiveness of this patch.
> Could you take a look?
>
> > diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> > index de86ac088289e..85264862fb6b6 100644
> > --- a/net/sctp/sm_make_chunk.c
> > +++ b/net/sctp/sm_make_chunk.c
>
> [ ... ]
>
> > @@ -1759,6 +1760,10 @@ struct sctp_association *sctp_unpack_cookie(
> >       cookie =3D chunk->subh.cookie_hdr;
> >       bear_cookie =3D &cookie->c;
> >
> > +     ch =3D (struct sctp_chunkhdr *)(bear_cookie + 1);
> > +     if (ntohs(ch->length) > len - fixed_size)
> > +             goto malformed;
> > +
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does this check also
> need to ensure the length is at least the size of the INIT header?
>
> If ch->length is small, for example 4 bytes for just the chunk header,
> this check passes. However, sctp_process_init() appears to unconditionall=
y
> read the init_hdr fields:
>
> net/sctp/sm_make_chunk.c:sctp_process_init() {
>     ...
>     asoc->peer.i.init_tag =3D ntohl(peer_init->init_hdr.init_tag);
>     asoc->peer.i.a_rwnd =3D ntohl(peer_init->init_hdr.a_rwnd);
>     ...
> }
>
> Could an attacker send a COOKIE_ECHO chunk with an embedded INIT chunk
> truncated to 4 bytes and trigger an out-of-bounds read past the SKB paylo=
ad?
>
> [Severity: High]
> This is a pre-existing issue, but is cookie->raw_addr_list_len properly
> validated against the remaining payload length before use?
>
> If SCTP cookie authentication is disabled, an unvalidated
> raw_addr_list_len could lead to out-of-bounds reads when
> sctp_assoc_set_bind_addr_from_cookie() calls c()
> to parse the bind addresses:
>
> net/sctp/bind_addr.c:sctp_raw_to_bind_addrs() {
>     ...
>     while (addrs_len >=3D sizeof(struct sctp_paramhdr)) {
>         param =3D (struct sctp_paramhdr *)raw_addr_list;
>         len =3D ntohs(param->length);
>         addrs_len -=3D len;
>         raw_addr_list +=3D len;
>     }
>     ...
> }
>
> If the unvalidated addrs_len is artificially large, or if a supplied
> param->length is larger than addrs_len causing an integer underflow on
> addrs_len -=3D len, could this bypass the loop condition, read into unmap=
ped
> pages, and cause a panic?
>
Yes, these seem like real issues.

We likely need more cookie validation than just checking the chunk length
and raw_addr_list_len. This was probably missed because the cookie is
generated locally, but it can still be maliciously modified.

I will try to reproduce and get them fixed.

Thanks.

