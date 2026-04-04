Return-Path: <netdev+bounces-275361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qcdjIbr50GkdDAcAu9opvQ
	(envelope-from <netdev+bounces-275361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 13:44:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBA539AF61
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 13:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58265300AB35
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 11:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7B9329E47;
	Sat,  4 Apr 2026 11:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RiUU3osu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87D3332631
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775303095; cv=pass; b=CT7mE+1vsiSXrJv/Vp1RB/XaP/htvPips2ybfR+bB70ghlHvRIY66qhUvA/FxRSsu/6MPJ5ENOZoGxZ9emLOLPZei5OfmVRjPEHXwpLYH5yq0EDh1Le4+LrNzv+HSWHRckqKOioR4nLLdvgtrrM1Nr8zxKbAoEXTlrWkEjqc/Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775303095; c=relaxed/simple;
	bh=VW1DIvTOrY598G6eAPXSPoQfWttzAN2Q8mb2Kw9czrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRuGSIb4ttP/BSrDXTKGDIBFBhCWwQFkgThmwGqNftETM5m1Rcbyvlk7AX28WAMz5eFhkJXiFOeWGR1dwCXBmh/CXV4P3mhpCdNJsYkjf6cxj/YwDf1o14tw5hYKMaI0Ptsx0N4XeQhctJCdLT4v05xo5Zup0eHyP+wRvzsb0+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RiUU3osu; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89cd8596724so32082326d6.0
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 04:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775303093; cv=none;
        d=google.com; s=arc-20240605;
        b=iGEazH8ePfwIUYPh1Td2L7Myz1eV7fg5xL3M6sxl87pcTPsXIQOT9yPnrEkhjx/4D8
         GTwga9MgJj7pO7T+FHuQivoAhSj6rb4o3sQlI/ZjZ8LObt5jHeh047kD/+5v3FTILMRi
         EIdxHZhBsA5exfI+FNKtb3csa+sopxXZ2PLc7Ilj24JRF3qqdMuF0s0PWp9Oo/YCdc0y
         2Zc+ipRSG1+dE+8MN+plsSW89g/ffPm+us4PCEgcHrLb7CKS8XV8mi0DBXpDIRjMmmHw
         NlhffIWwFuVsxP5/FqxN0vQmk8wa82Ez18zkJvXxHZPzx5Fhc226WAO7vC7yZb8yq/o8
         EGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fyMDP4OwVv4RKOfvwNTPXj32dglnNwC37byGuqS3llE=;
        fh=AF5rQv8z7RHidkL4K0G4EHGF4qNy4hQjncMK++LjJ38=;
        b=BWyemm2gQ7ke3a0CXLWm95M+rw1a6qh3S7qqdrstbMTSTCr9Obx3BQ+HC6m+ZcmP2w
         Ha8UPXidNwbOaUa0p4LLnr/emtxhstQEwDND0KcaF7/k71mIixTFEXOWbvdNeoEczpkJ
         ymF43L6FabUe8eIR/KiSCbQLTUzqpX4Y/iq4o2+0kiLHsLq402h7+NsPdxkDLNbDogFZ
         h15QENQKEQDgSdY0HK5ctA+VxHY8ckTcnQNelcDbXlYSZpp2ee0NXNjRlyUMiC7RIZNa
         s8QCoS/SLDaTbgYJHcrqNW1LgUV2Vn0eE/HHeGDTFVuZ+Y5axBobp6uBhctesWb1skhT
         LV6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775303093; x=1775907893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyMDP4OwVv4RKOfvwNTPXj32dglnNwC37byGuqS3llE=;
        b=RiUU3osuu5Ci5DjwPfVrZo9agk4gzMTUWzeBzOv+KZGJn+iuOVxB0Ofq4B/tn6uPC7
         JX97/99ebO0FoQazIdXndZoNMwnm9itnAFmwXwXSB9q0dM3gB7wR3K0WkSFEvEeJRC/u
         b4+DZEu6CPGTCJzwz6fptSm7lYOk33ZXvmzUUnE96/Ha7z/rptdtXJp0cHu0z4K8STmL
         U8e/9lxhZUTVUCytStYHiGFn2eOt0SASoupKr0v0n0lcq/R3WhFF8fyfih1a+Swllpht
         /4uRtVY+S/Dabh4xLnhGZ/6COCafxNOq6BMUKyQBImyG094p6KyJhnVIpx2U4M0q4FKo
         NVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775303093; x=1775907893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fyMDP4OwVv4RKOfvwNTPXj32dglnNwC37byGuqS3llE=;
        b=ewZbTNFQaS9JU9fqZ7cyyWFOrGCvKO/OIt+P0jxo9Pd2BpR5dB7RtiXtFugRxw/drp
         cnfArZR/kxcAoXJmSEIssII5Uc5szhiDdwhS0glL7Gsvb9VyFIeE66aRcavI6QWJ1iAn
         tGC7OnE8m8KyvQwy7m/9SkOmQJkuxmcyqDM1TG1FdvAaC4M7RpXHch7DhOsCUZ+GkmDH
         CZZpRjm339SmWhl1gqXqIux0PhFaR53glVpy16i7hR1J4KI5GMr5UJQwlCKO3g9MLWTb
         4zZTNkip/3dAAU3RP6E602m7AWtfxWL/PzGlFAUsEWoCBVJNhCwP5lNbDPKi2V5yqlNY
         n8Mw==
X-Forwarded-Encrypted: i=1; AJvYcCU+Vb0KbSF+kCpKiZCThHPb1BxZ2f9r0biIi2Gs1lsdcTdJ8T0AHcshqf7OOTLXRwmKtNDpzy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOKNzgJIxq868GsByvhf3qtDZxuDOM57Y7qfctvzm5in4ciA8I
	TSPAdIVbkPn6Rs8FItbbZbxmIiXT6MaEZY9EQzACsxokER8wWlu19u8Zjvjzg2nzlvB9c8fDxKm
	9T/F6hJdpLFKE+6NjM+QzuJZ61BtqhcoeWGFOo+9RpXrnsZjDZZaetwcR
X-Gm-Gg: AeBDieuagphsCd0CPrauul7JfSPAa9f+w1wfnsEcoZLJTWtSREjWyXW8m6nCadVFEvR
	Zo3kErtdWsw5SDI0UQKyPlVykpA8h+E0GafdMinzAcMHEoiDHHNNj+3GZXVrUediqdaad/v+7f1
	sTV8SnLEcsJ6wMSuoZ1hj1uvXVCqLfjL/S9rPfsolNH+QssIYmlYHmA17qP/kCXJhylC2hTfVX1
	8HOylSpWfdT+PSHsU37wKs2ZPMKnoZNeX3uc0BkZvK0YFWUM7J7YiP6era1OUXEQ4CHtw38KQZW
	s6pX
X-Received: by 2002:a05:6214:4e16:b0:89f:48d0:4c9 with SMTP id
 6a1803df08f44-8a704cb264dmr93610946d6.46.1775303092216; Sat, 04 Apr 2026
 04:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402101732.1188059-1-edumazet@google.com> <20260403214418.2233266-2-kuba@kernel.org>
 <CANn89iKUKTYZ7NVNidtdssZXUAa95LmRpTYUQ29uGE99jLmLOw@mail.gmail.com>
 <20260403145010.4b4e5865@kernel.org> <2de5a3d1-cc8f-48c2-a590-09bef92e9adb@gmail.com>
In-Reply-To: <2de5a3d1-cc8f-48c2-a590-09bef92e9adb@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 4 Apr 2026 04:44:41 -0700
X-Gm-Features: AQROBzDkMNSp4NQ23eAf-HBNjt6rEaXZR3BrL7aisUDHAw9zsWhBmMHoqKqJIAA
Message-ID: <CANn89i+QK6cWseXBAbwZaWcUGG6n+CbuWV-4b97x2LmDJoGjTQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: ioam: fix potential NULL dereferences in __ioam6_fill_trace_data()
To: Justin Iurman <justin.iurman@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	horms@kernel.org, dsahern@kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, yimingqian591@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275361-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: CEBA539AF61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 4, 2026 at 3:13=E2=80=AFAM Justin Iurman <justin.iurman@gmail.c=
om> wrote:
>
> On 4/3/26 23:50, Jakub Kicinski wrote:
> > On Fri, 3 Apr 2026 14:47:32 -0700 Eric Dumazet wrote:
> >>> If the ingress device has more RX queues than the egress device (dev)=
 has
> >>> TX queues, skb_get_queue_mapping(skb) will exceed dev->num_tx_queues.
> >>>
> >>> Since skb_get_tx_queue() does not clamp the index, will it return an
> >>> out-of-bounds pointer into the egress device's dev->_tx array, causin=
g
> >>> dereferencing queue->qdisc to read invalid memory?
> >>
> >> This seems a different bug ?
> >>
> >> I mean, do we need to fix all bug in a single patch ?
> >
> > no no, sorry, i'm just sending this out for Justin or you as a separate
> > thing.
>
> Thanks Jakub, I don't know how I missed that. It's not just about a
> possible OOB: it's actually incorrect for IOAM to do that because we're
> relying on a lucky assumption at best (i.e., if queue_mapping on RX =3D=
=3D
> queue_mapping on TX). This unfortunately rules out the possibility to
> have an accurate per queue visibility (which I originally provided for
> flexibility). I've had a local patch for a long time to aggregate the
> queue depth (i.e., sum of all TX queues). It is more expensive(***), but
> it would kill two birds with one stone and solve both problems
> simultaneously.
>
> Jakub, Eric, please let me know if the following plan works for both of y=
ou:
> - (net) fix the OOB reported by Jakub (and, while at it, add missing
> locks around qdisc_qstats_qlen_backlog() -> also included in my local pat=
ch)
> - (net-next) after the merge window, add the new feature
>
> After that, the per queue visibility would be considered
> legacy/deprecated and not the default behavior. Documentation would be
> updated accordingly to explain why per queue visibility cannot be trusted=
.
>
>   (***) the advise to operators in such a case is (obviously) to reduce
> the IOAM insertion (with the frequency parameter), especially at line rat=
e.

Getting qdisc stats can be expensive for qdisc with per-cpu storage
for counters like pfifo-fast.

If your plan is to sum MQ stats, this could have quadratic behavior :
O(nr_cpus ^ 2)

I suggest rate-limiting this very expensive operation, or OAM will
become a nice DOS tool.
(Ie not depend on operators being nice, enforce this on the hosts)

