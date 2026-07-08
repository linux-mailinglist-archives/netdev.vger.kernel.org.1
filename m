Return-Path: <netdev+bounces-305625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oGLvOqCaTWoT2wEAu9opvQ
	(envelope-from <netdev+bounces-305625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 02:32:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA6D720A33
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 02:32:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=everpuredata.com header.s=google header.b=EIszkM6n;
	dmarc=pass (policy=quarantine) header.from=everpuredata.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305625-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305625-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0F0C3017272
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 00:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEC71EFF93;
	Wed,  8 Jul 2026 00:31:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4415E1A0728
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 00:31:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783470719; cv=pass; b=ZdbZYehVLFpqhDYP8igp6L5ja4l4qmKia7e8lyL5RXFOW8PBXYq1WhcCmdrk0hLtz637Z9mM0dlzQy4EQUtMe3mskYVA3RnDLjiRsHsFb17U5RCqkC8fxoFGAtKCOz3D6oKA9iuL6QPb0zMdVu+IWySPI0uftSAWuhDxuKWdH8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783470719; c=relaxed/simple;
	bh=HHtBIbskIh+m9w++qNm60vMk1f/mNAO7xvuc3gMNv6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqqeXQSxyTbLEZbQ/ji66pNb1MzoXMkpLr6KG2xDyuJ8hA1wBb/79YYF5/mcxOdTGnkg1lwtT5SKmAwN0gzIcw6CFm7gUtmsgidXNeHnD0FVZaEZc7vTgobWDGfBZ13SB//5oYzZKfHcqlRYN6pUEjpmiWJTfdlryq22cmgYpSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=EIszkM6n; arc=pass smtp.client-ip=209.85.222.54
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9696369925aso54997241.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 17:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783470716; cv=none;
        d=google.com; s=arc-20260327;
        b=aQEkv3MPI1FrzgBAwU9yAn0VMpzJLqvtMZb8KVpo4sQQUOFZNxEWnE6IMINTIKpJj+
         8kquwpKmqxx93lqkdW3qHlw7x/O60Y4cUm0MW7e+6/Kcr9D9dVYSllqXLcUiQbng1UDJ
         53AyLPP/mCMCfTd9E2sMOnR6SUNTn5kbqHJqrRwhxuxyvBCLOwcXEtJYmkcv9GpHhVTE
         PY8jEe4E/z3Tmedwhx4qkT3jqqozxKbQ+b7TTySU+nWnvWIAHbRI3BxNJ05RCmIysbxy
         sEB0YmqId++YPnq3jJe0/rEMT7ynVIoJbhsRA7mZdTM9XoDy9OGd3Azc07vjBI0iDBaN
         yMlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gMqRBa6YcW2f6tkE8vRfFB3wqWpIHYCmRuC1201gvRY=;
        fh=reRGh0q29iWwtYNIvipnBvLUrzpdhjqiBe5D1yij8eE=;
        b=L0ePveD1joqO5LJoCgzFeWZLNzmb9rIlsDrv0adoHhJFz+YbAvOhzxXhL+y7rbZbyd
         anB8wHZ6bzD5DoanUCOAxPqFycoRZjFB90DRlUa/k0Kkf5KI1nJqjPePr0f+txxj2roG
         pJ3bt82uI3yAUifVMsmNlpTKlTt9zgYh9zvtxbNVzClW3QwEmCKM+trdID05h4VhyDAL
         y1L7vD0BJs/FkVidaMJzEto4WRqKEMVMiPGWglxUQLy8wmS/9xDPv55zEfR9KmkFLqPz
         vTIkr0Y3gkorPcgYw/Jh3kVos/J2K5CN9tLS5pl0FTxKssPeZQtXJ/owC0i1oZ/KkbuL
         hpeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1783470716; x=1784075516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gMqRBa6YcW2f6tkE8vRfFB3wqWpIHYCmRuC1201gvRY=;
        b=EIszkM6nYA3ESaIF7dcLSDro6ZyVcf2sr8b6NbiMJqwOfv4CQs8hjH44OrgAdgibgi
         uTyEKpmcf7CMvCzMachb6m891/LvvzxX6hqSVYVrI9l9ld2WVMS0FX9NnU74i22dOo+G
         RDNOTvgJhtbEAT8qMZmtylDJ3vMfLNK/aI//VtY3Yn8H2ockr5WNspaTyc/e7kkDLb0I
         ra3G1ROBgObCE7Wn94kIflcfBuNksCXzH1kMneQ8FQbSVC/f+VLVjx3P4od1+e0IP15O
         wh4uEYmvFiS1t7Ws/Nsfu3QZt1jgeg/cF9wFiQfZ1ul94a3FTa5YgCS6x4B37H9+/BVY
         9/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783470716; x=1784075516;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gMqRBa6YcW2f6tkE8vRfFB3wqWpIHYCmRuC1201gvRY=;
        b=CvAYfb09xZZ/II4KI8ceWD7nQG9/TGmy1sVN8pt9IO5QP1rRZxFtPDaD753L7OI09v
         G0sO4NZTvrttimUkHR7SnfNr5NF2YTurtwkrDbOqwYaCNeb5uDhxnVdZfw1e8nQB+OUW
         9vfrgUyUDwueySB/7bAELBEkKGGQDUcbDHw3E7pSCGYMDFjtPfBcoG1t/PUiE93XJDQF
         AwH6Eg12NyedRlKv3fTMiXmTWaRE7xXl2P7M7E9xIGXqlJadlSS13lo8tXna2UtQSNr/
         Bw5vs1gySnttJK00GIG+O6RnAIBoTdyM+HyBBfb58G8S6bXbub2EefThkcJ8B0utRHAk
         dCng==
X-Forwarded-Encrypted: i=1; AHgh+Rq2DSQ68wdz97aZNhmUF4tdFReam6H6HuSEp1ZGExqnPnaGkcWNWI77MywZMBIKvAb4fqApQH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVB6+vOjYbKgIZLGH3lXVt08zZdKWB5GBJdqNQsrQhL7z+XWDR
	aRGvgIyZO91XQfdfKwb6BvltGDApm+hltyRazdwJ14HJ3+c3OFt5ONZIQaGyWNjHKAQdgWHyht8
	T96G8CR1FvSOJWjX218hQIx6etLooiRHyO64XJMnVvQ==
X-Gm-Gg: AfdE7cntvhSySwQY/7+C+y9BO5XiD+BlIyCWtcyl428Xk96ycPq5YBDfwS+kSyFPVDG
	fpo1zG4u/Y5VUfD65ld/BpTAPgp518XFplsKPacYWyUf2IYKRxNCmv4FIOOoKhStCTEQfYR01Zp
	omDuRJz/kcuRtogchGNWdtf75hP4SZqlovcdSTdyskWGNZDg3qge8iBGP/DDmAP/54FU4PNk/Ao
	6h6M+yCGUfxJkyeJw6VkCc05N8GXf4Jkkx0gvUvR1uBMzaiODoJsbqdsyYwQg8pCQufRCRtDOVj
	6BkNDT0XhvC75qqNm02eVgagxdD/YwHjLihSRUu7QizRZHkXd/Dzo+XbPAZdCnQKY0sV6OoNLrw
	VmVOBkvX5NTAIG/Qgn9JtLi/H9VsStt4h7tMwf6lF4bxpK6SqIRPDJwX0
X-Received: by 2002:a05:6102:5e97:b0:738:bce9:6afc with SMTP id
 ada2fe7eead31-744dfc76692mr31466137.0.1783470716180; Tue, 07 Jul 2026
 17:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707232325.61396-1-nils.juenemann@gmail.com> <20260708000207.64401-1-nils.juenemann@gmail.com>
In-Reply-To: <20260708000207.64401-1-nils.juenemann@gmail.com>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Tue, 7 Jul 2026 17:31:45 -0700
X-Gm-Features: AVVi8CeP8MmKYrvVR1SnAGqfJ4VjenjdU7yyZC_aabrRPpIuTS-qOFwzUhOfxxc
Message-ID: <CAKaoeS3RbLP=D1G6HHaSfQLj4VSi_W=HZ9EnKxKia_EjcT1vSw@mail.gmail.com>
Subject: Re: [PATCH net-next v14 0/9] tls: Add TLS 1.3 hardware offload support
To: Nils Juenemann <nils.juenemann@gmail.com>
Cc: borisp@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, leon@kernel.org, mbloch@nvidia.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, saeedm@nvidia.com, 
	sd@queasysnail.net, tariqt@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[everpuredata.com,quarantine];
	R_DKIM_ALLOW(-0.20)[everpuredata.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nils.juenemann@gmail.com,m:borisp@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:leon@kernel.org,m:mbloch@nvidia.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:saeedm@nvidia.com,m:sd@queasysnail.net,m:tariqt@nvidia.com,m:nilsjuenemann@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[rjethwani@everpuredata.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-305625-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[everpuredata.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@everpuredata.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,google.com,gmail.com,kernel.org,vger.kernel.org,redhat.com,queasysnail.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CA6D720A33

On Tue, Jul 7, 2026 at 5:02=E2=80=AFPM Nils Juenemann <nils.juenemann@gmail=
.com> wrote:
>
> On Wed, Jul 8, 2026 at 1:23 AM Nils Juenemann <nils.juenemann@gmail.com> =
wrote:
> >
> > ... so I cannot run the crash> struct queries against it.
>
> Follow-up -- I recovered enough of the truncated dump to read sk after
> all:
>
>     skc_state     =3D 0x01   TCP_ESTABLISHED
>     skc_family    =3D 0x0a   AF_INET6
>     skc_num       =3D 0x1bb  (443)
>     skc_dport     =3D 0x0ba2
>     icsk_ulp_ops  =3D 0x0
>     icsk_ulp_data =3D 0x0
>
> Both ULP pointers are NULL with the socket still ESTABLISHED, so the
> NULL at the fault site was not just a transient register value. Does
> this point to RX resync racing tcp_cleanup_ulp(), with the resync path
> holding no reference that keeps the ULP alive?
>
> Thanks,
> Nils

Thanks, one more thing. Could you post the disassembly of
mlx5e_ktls_handle_rx_skb from entry into the CQE_TLS_OFFLOAD_RESYNC
branch through RIP+0x10a? I want to count how many distinct loads of
sk+0x4f8 the compiler emitted in that region.

The fault-site load being fresh does not by itself rule out that it is
the only load, and that the earlier source-level tls_get_ctx() in
resync_queue_get_psv() was folded into the same one. If so, the
observed icsk_ulp_{ops,data} =3D=3D NULL on an ESTABLISHED socket would be
fully consistent with inet_lookup_established() returning a plain
non-TLS 443 socket, i.e. one without TLS ULP attached at lookup time.

If instead there are two independent loads, with the second
legitimately reading NULL, then we are looking at icsk_ulp_data
changing between them, which would point to a separate race/teardown
bug worth bisecting.

