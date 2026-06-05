Return-Path: <netdev+bounces-295924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bCqJERMPI2qLhQEAu9opvQ
	(envelope-from <netdev+bounces-295924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:01:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB3E64A665
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:01:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=esoVDV3V;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295924-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295924-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C00C3026F2A
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1D11F30BB;
	Fri,  5 Jun 2026 17:57:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DDE39A05E
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 17:57:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682254; cv=pass; b=HabKkVDpOLnFJxO/wGQf2+7CxAs5NR17NYrM/JVcbKhlAMT/DiHW2Fu3CKpPDKvxk0xV6zc3RTCKtMRvkPbbjbeTZ4kpR/9jyhbW4XxX38Kx3gXxXgR8QqeMZiOroXpn3MELhBXoQqjR6tmDxdxciGtJc8TjOqtCiA2IzU6l5Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682254; c=relaxed/simple;
	bh=B/ePAnDi7gjX0wObDwCkcVlhRTzzZqaKwRsAtFuwlh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0WG8/YAWrYizLxWRQOiTqhN21boYvZ8HfaE01WGvI+Kr/4SxveA8EFAZdN1q+45ZmYTeeg7PdIj0wWZ8cttzW7uf0z+2cdz2SQsQO5z1YdjeQ16ENA1DdJVJsiS76lSCwKCmWMvduxX5OXSeEGbL3mCpdVie3+p7gJxEMHyirw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esoVDV3V; arc=pass smtp.client-ip=74.125.82.176
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3074adb8fcaso1713418eec.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 10:57:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780682248; cv=none;
        d=google.com; s=arc-20240605;
        b=hmHQCd8/g+BmIyTuMoJ1jzYIKVGfDr+YIR9bEYu1fA7yLX96P4yd7zYKJw10IrYT4U
         ztbDX/pr4ue2eMCN3Qm87U2TFYeaKjuS0wZ+FP7EufWj7+6ZlpPK2WPV8+dyIb+pwvWa
         wEpIrLlKoonLtbI7r1QTTfJUQESMntP3vbWF9Uw2sQHkSiJJpViNhOKGQTcXr+Su4o/G
         YChZKe8yNfwW0oVtej6JnzT3R+SPtlZKFQCix4eP4ks03x/H0b6Q3ptfa2pcZ4tnnMHJ
         5jNm+WpRN0YTAdSF/1UEq1zsIuRs2La6jq4XxCd84K9yOPAjKIiwpzeaM2xEAPCecusV
         b31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cmSM1b2FxFpkiErqZSBNSk3eQpOEWiURszgQnptqPlc=;
        fh=TANDjI46mvb6IGcaKdvwOHI+OLTpk09h3MhkWoFs8Ww=;
        b=JjZT9jaqxymfBcvnStyyAj1rFxRbwjyW9aczsjJJV414r7Qo1/Ez/iIjXCQBZKs+NI
         BIEJM4iJVMqZZHegA2TXy7hKbEXIeUv0TbSBmDUrV9yiKNRljeru2gEkLUEl7AK5huqW
         AkIS4xr9HjcwlCEhpnJCD6+y0NJjRZyZ2Q2vqqTOVR4ecraX3aWGgMkGEmh07ZEK9+MA
         SB9CqekXhIKhb2g69I617awMJDLsZe/WYYlJHPm2TxdfD6izmQ+aiRmnGsr/tRoT4J3J
         FE0CHPupO5QugUC7dM2hXiggCEToxPv+S1BnptcqsLgf7Hr7G1YBPSSVN2N1IR/vNOtr
         /Ssw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780682248; x=1781287048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmSM1b2FxFpkiErqZSBNSk3eQpOEWiURszgQnptqPlc=;
        b=esoVDV3VnGime31kxXJNGInUTNjEb0i69m58l9nOGHEspsPvfjceG07TlkYtFVHggd
         dxUlBTYVMpYhipG5zqeZ7dTETiM954JW5iRAxuQJcNskYppHhFeitVxfajKLyuXeBxcr
         0u4jy0P/T6Gq5LvdSJRkEWSSzTGwMYlIsDzBNiyLoeb8n9wxOeYclooniQULklHHAC8Z
         itLtIJDQx2KDJfJPm/ApqqCfy8nMsmxv/Flkcn4yseM5TzOq5kMQNn0Xh0153sApty3W
         Y9wPTIyGgihEEOEJXjf7aO0Bk7Q8vU09zaxc8qxLM6yqwaHtFDqSK0jmaX2gvb0hc/mN
         1+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682248; x=1781287048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cmSM1b2FxFpkiErqZSBNSk3eQpOEWiURszgQnptqPlc=;
        b=qRIJ0alLZEtIZ5UMVajnuLMx2GEHdZZVY/IXs4JYR8mF+ccBh1ORFgDU42CqQ/15If
         YtS8UpYMyLWxuGwC/nbXI/5NH2oh06YAbk9hmBWqSZi40KiRZeONpyT460xLZM9NKqfv
         QO7zFSropbyX8etFQn38Yf3NWu/C7eHY/wY9c6TAW+IiV02jNfsixfDCp2LdxAn/b9F8
         WzB7zPdgRfchVysmaMvwibKad0J7OfYq4i2w8hqQSQay7SRK7fLV/qN42c1hwuNMnw8a
         IFZXOmGiiTVapMHAMict2QKmK1xRBOGZuO0Lf0KjeLaDitVVlGtN5oW5K7Hw7ruz5JOh
         q9VA==
X-Forwarded-Encrypted: i=1; AFNElJ/Ftxh5eUsyI0nCkuMuhh+YX97M71RMdMAcy6sJ2J2ugPrDojXFlbIbGhcqMQqijHB0DaiX2CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlPCjKOhUSqtOvLLT2Hy46RhU5U6Ow/AGOkqSv3F550ReDLY9k
	bDW3By10rOxwza3I3lJuWxfKwjs81DpcFSJc50AMl5zH9SkOmLFckuOR5cCW0eE3c86MwCgg/tO
	Tn0m6EZGM+iidn78bIExiJ9kg6NFXhRCleg==
X-Gm-Gg: Acq92OFGcXQcKnhFAJH01gVaB5+pAXrwSWSauImMXCSMD2PqCn6IutOIjz6MgUaDdpq
	eukeg02FXqg6zNAkth7QqCM+RMy2KM26X7x80tY3i+alef1drW/JGFtGumA0Q3OkNYrsMnftYyE
	A6l5FE/kqyGsMbvq7IkR3lEO9g6XAsVQcxqJ+XcbvtdJ7dBFnV6uYK0CmRuq0gIzCA8flfRAu0Q
	LIsMTLJB3IXfCIcGbMR11OUqrV1wCVl+YGju1jpGs/DzxlMdw0ZWNRQQZObIEqMsBIfdXO0eiOm
	2RlpvZW3KP23i473thcCmWNioOV+rb5c9A==
X-Received: by 2002:a05:690c:6a11:b0:7d1:c256:b5c2 with SMTP id
 00721157ae682-7ed11288b78mr49193467b3.33.1780682236167; Fri, 05 Jun 2026
 10:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604220904.1032145-3-ameryhung@gmail.com> <a5988106169c7350f39a4d07b36b679a5fb39cda49ca371cb79c23da7b63971d@mail.kernel.org>
 <b4302a13ccae77b304a09b47c58565c8ff1970c2.camel@gmail.com> <CAMB2axPLpxk8fh-Qp2sGwtsZBCE42DLo+h8pB+ObffLifP9aZg@mail.gmail.com>
In-Reply-To: <CAMB2axPLpxk8fh-Qp2sGwtsZBCE42DLo+h8pB+ObffLifP9aZg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 5 Jun 2026 10:57:05 -0700
X-Gm-Features: AVHnY4Iiyh1DufQo6AdcLUGItcW4SgUvYf0y6EkKBe7FclLb_9ezORLnhygaKT8
Message-ID: <CAMB2axOOG3ptDkWvTDpGut+EmDeroe3GPR3obb-Br_Dg1aGmgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:eddyz87@gmail.com,m:bot+bpf-ci@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:kernel-team@meta.com,m:ast@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:bot@kernel.org,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295924-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,iogearbox.net,meta.com,linux.dev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BB3E64A665

On Thu, Jun 4, 2026 at 4:27=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Thu, Jun 4, 2026 at 4:21=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Thu, 2026-06-04 at 22:59 +0000, bot+bpf-ci@kernel.org wrote:
> > > > commit 89f2be9817e074d02702d22068104fb9fd9aa103
> > > > Author: Amery Hung <ameryhung@gmail.com>
> > > > Date:   Thu Jun 4 15:09:03 2026 -0700
> > > >
> > > >     bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
> > > >
> > > >     refsafe() compared each reference's id and type but not its par=
ent_id,
> > > >     so two states whose PTR references differ only in the parent ob=
ject they
> > > >     were derived from could be wrongly treated as equivalent and pr=
uned. Fix
> > > >     it by checking parent_id too.
> > > >
> > > >     Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > >
> > > This looks like a bug fix for parent_id tracking support. Should this
> > > include:
> > >
> > >   Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking an=
d fix dynptr UAF bug")
> > >
> > > When commit 308c7a0ae885 added parent_id tracking, it updated several
> > > safety-checking functions to compare parent_id but missed adding the
> > > parent_id check in refsafe() for the REF_TYPE_PTR case. This caused s=
tates
> > > with different parent objects to be incorrectly treated as equivalent
> > > during state pruning.
> > >
> > > > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > > > index 5945956a7573..06d9ae24f006 100644
> > > > --- a/kernel/bpf/states.c
> > > > +++ b/kernel/bpf/states.c
> > > > @@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *=
old, struct bpf_verifier_state *c
> > > >                     return false;
> > > >             switch (old->refs[i].type) {
> > > >             case REF_TYPE_PTR:
> > > > +                   if (!check_ids(old->refs[i].parent_id, cur->ref=
s[i].parent_id, idmap))
> > > > +                           return false;
> > > > +                   break;
> > > >             case REF_TYPE_IRQ:
> > > >                     break;
> > > >             case REF_TYPE_LOCK:
> > >
> > > This adds an extra check_ids() call for parent_id. Could this make it
> > > easier to trigger the WARN_ON_ONCE() in check_ids() via BPF_ID_MAP_SI=
ZE
> > > exhaustion?
> >
> > I think the bot has the point here. Let's switch to reallocating idmap
> > or failing check_ids() if there are to many ids (probably an
> > unrealistic scenario).
>
> Make sense. I will switch to failing check_ids() first since it is
> unlikely for sane programs.
>

Actually, looking at it a bit more. I think I would hold on changing
check_ids().

This patch should not increase idmap usage. parent_id refers to id and
therefore check_ids(parent_id) will reuse an existing slot.

The id_map is indeed more likely to be triggered since there is also
an intermediate reference for reference dynptr introduce during the
refactor, but that should still be very unlikely under normal usage.
check_ids() also already fails in this scenario by returning false. So
overall, I am not sure if we need to change it.

WDYT?

