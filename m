Return-Path: <netdev+bounces-287287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJeHFxiKA2pN7AEAu9opvQ
	(envelope-from <netdev+bounces-287287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:14:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD9B528FE2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BACCB309BD85
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BA43AC0DC;
	Tue, 12 May 2026 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE+mRqvL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003DC3AB29B
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616835; cv=pass; b=FOPFijPKbmr0/Ws/E4XDp7Eo9dJOeLltfmxVXwbUi1TMgDpdCsLMwL3beRCPu+l7X2pEBkPuyCCei4ki5OipG3hq6ZottD1jJW146XJmA+pdoM+HsqCcEWjyzEBxnJvaRpFABZnDuJA53IhNFLQUeIoyvHqREOYfpyevdQLwgRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616835; c=relaxed/simple;
	bh=W1UGjXUOUr5pw5lZpfHp70Rnm12IZhxZ9f4qzZHvZdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWr6LZZL7+Sl8OerPkhWdOuokEhajJrnMIFtIAqiIR/O6JqCu2qc140MnDK/+Mw0b6yZtg+KuPTYtd2XmUcvCtQmZ/GGGCdzADYRye7DfJtyJXLB9rpYhBWwHzh3DfIWfsgM2wktJrGK0+ydDEgqxxaK5zvbpoiJ97GzNapI5M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EE+mRqvL; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7bde9d73678so64684647b3.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778616833; cv=none;
        d=google.com; s=arc-20240605;
        b=jD7dt1HteReR49cshcxQaJU69IPHaQpbqxavTtmPmokOuloe5gRC8bQSeyLxRLVH0l
         yxpPv0K2Si6fALFUvLSzMx4PBgZ8vdtcQq2cuw6jnLenNuPXT0/hiyuoh7mqp1jnK3jp
         qsowEpXoKcyRy4cS4LFzIIrIPMPytp1iTabu2oQF7jtutjm5vqisLMmW3cU6PdicY3SA
         2/iHGy/nwemhdlw4nV3Y2oF9eu78GjeFzAIaiMiM5Oje7w1OIAotm/ijLX9Nwx4pO8L8
         4AhRDFFunJlhpIOeO/6fGyCFDyCkCONR6HXEDC2JHjkBRQeZfvkLXcqgZxcEjYW2XT7z
         wwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=18RQIx270SijuQPvP2u+5KmQApCCLoVeABosefiDH1g=;
        fh=uq83Gn8JW4w5nIC0KviLmz/UoKLFkc/KFo2TM+3YxDY=;
        b=C34obsnNx2hDfFGjiAnrsqhNbucVuO3WgDsKjTSkCpafGemnNXeMRlztMCxlYTzqf3
         8dagOl/7RaWYrqKzBO+LP7rkG8kBSPa4mLBJ3z2w5cOM3OQvVHTjD3GCuAMVORaezgaD
         zv6hR81kTs5CUtjkrOSAr640Zi4DUr2DP5sVQMf08hgeUObr6/+5v7/FIQhfyfKXTPYX
         EJET6mwyea38BBgaD0AoIXk6tjZt3KW9mYb3jiCii6UQl+9mS6Vnzy73H4Og3bmdQncr
         +IgOwy8PDOB0D00SL8Qu3scQFZ3edvRYggV/2Wvr2+VC+1+MqWEoO5yaZVqBfT63kJ2S
         Whyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778616833; x=1779221633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18RQIx270SijuQPvP2u+5KmQApCCLoVeABosefiDH1g=;
        b=EE+mRqvLxG07xaQ3nlhUcnyffLMKoyefrfZ/jn0/KPpzlX7c11L7zb48YEOm2HyTDx
         ZpsLX8fD981bigHfB4au2c2IfqHOw1yt93yylb5x9wRThJhZUucTuz4v/0BoqCC3I4nC
         i/9H64cYNJIkJRI7xLVsA0TgZmFUzF1DeC8AqfXZCY6JHTtcnAAdU1Aj/foJWgc2KCWp
         FYVWgourjlZZ8crwELV39epfLYUNHLn5O3ozE0wl5dqMRLs3o0zsEzOqb9N1/L1kBBVz
         fHanTUoAnkJOQNTjC2uxPqGxb90X3DGmeW6+g2JIaWONJEpaN3kalGftQK/kOM18Z1KE
         nL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616833; x=1779221633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=18RQIx270SijuQPvP2u+5KmQApCCLoVeABosefiDH1g=;
        b=ekceNmxqgb/KSVVqjGmnApNMgxw8yxOlfGioG8Y99o6xQnSY3EaD3pC0FsG++PUikH
         +Z5Dtv2g+s4UKmAPhe9kMNQssXG3BkRiztBgGY4GC3DGKOeFIciXThwvL0dHRaZbWvv3
         i6zXbcUC4nH++t0IzqgnMvpZ6xVnFuPlgqA1vF/15fY0m2AuACwr3VCq5w/ALDpwLiGy
         FtRQQZwKzkjDYeuK2R6GMnEfdVPa923RD2pALjstJlE2y5uatrOBPLnTpk/97hpsPika
         nLkCusp0dzyJ/+ksOX4lNYT3iRlp7+TYunjB3nZohmKD1V5Qr66KDopH/gAvUkuzDbu+
         qqLA==
X-Forwarded-Encrypted: i=1; AFNElJ8W2S/n0qrGkx9z88an9S7WTcjyZ2tjPCqlb5QYn6GT8ZqQhlHcywzEG2UWRluBrKufw46bkCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzW+nsRYXRkd1ODFbKPoMB2rBIMyYh3+/TwvAPgTVRBJfOA8EY
	nastRKbs9F2Y7sOYv35mteqrLVnyai4Xm+0Z+txqQeLxQY9CqPEroaIrQZ9BXJMwpAfw4rPyo0f
	8IN6sRcrOI3MBLuSULbivcvcZeQoxd+8=
X-Gm-Gg: Acq92OGh2aJ8PCqcQnVc1hLI6I2OxKsBzr4n2EHXPV51hYD7IWaSvkDzNYHAmTXTLXh
	jjv+hdVXrvvT61EY/PL9L1Wrx4wJkz/P9n/qEC5LJd4O50WQEB3RcwTT1iSdkS97uEtvUR9o87q
	f6nd+N35y2lYwRF8PYgRnLlSbFgQmPtdUCxBqHIidOUOQ5iAYgZ0CF6FMo/MwNBlxLGh9DSh6vf
	P+yMQKrk8tWAriqcOzi/B4v1izIgBVJ0UOwEhNiTFo8fKNbwTHTq3/ZcxApB22Pn1dwKJq+kKnN
	TzbVTaOuOkxqpnSOdwJun3pLJpq8hCxCYg==
X-Received: by 2002:a05:690c:c4fa:b0:7bd:76f6:b3a6 with SMTP id
 00721157ae682-7c50d9488bemr47523917b3.3.1778616832777; Tue, 12 May 2026
 13:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-1-ameryhung@gmail.com> <20260506142709.2298255-2-ameryhung@gmail.com>
 <7f0d8cf18e3e0d60751b2453815a1f0ea62ca928.camel@gmail.com>
In-Reply-To: <7f0d8cf18e3e0d60751b2453815a1f0ea62ca928.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 12 May 2026 22:13:39 +0200
X-Gm-Features: AVHnY4KX0SJeKhrAjXoRIRocx25IwiL34Yyv_drtrnkeYUmF784ybo8h12y8eRQ
Message-ID: <CAMB2axOVZyx4Z+gHJVEtfteTESFQBXL51aCM7UDPw5zwo+wgqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 01/12] bpf: Simplify mark_stack_slot_obj_read()
 and callers
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0FD9B528FE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287287-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:17=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2026-05-06 at 07:26 -0700, Amery Hung wrote:
> > Directly call mark_stack_slot_obj_read() from function processing
> > iter, dynptr and irq_flag. To prepare for unifying dynptr handling,
> > dynptr_get_spi() will be moved out of mark_dynptr_read(),
> > As mark_dynptr_read() would join mark_iter_read() as a thin wrapper of
> > mark_stack_slot_obj_read(), just open code the helpers.
> >
> > In addition, since 6762e3a0bce5 ("bpf: simplify liveness to use
> > (callsite, depth) keyed func_instances") has made
> > mark_stack_slot_obj_read() always succeed. Return void and drop the now
> > unused bpf_reg_state argument.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > +static void mark_stack_slot_obj_read(struct bpf_verifier_env *env,
> > +                                  int spi, int nr_slots)
>
> Nit: this is probably a leftover from the stack liveness commit,
>      but I think that a better name for this function would now be
>      mark_stack_slots_scratched.

Make sense. Will change it to mark_stack_slots_scratched.

>
> [...]

