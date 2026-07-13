Return-Path: <netdev+bounces-307286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5bzgMERYVWqDnAAAu9opvQ
	(envelope-from <netdev+bounces-307286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:27:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 634FF74F40C
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:27:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=occITeni;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307286-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307286-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A45A304C048
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADE035CB95;
	Mon, 13 Jul 2026 21:27:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DD733A014
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 21:27:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978047; cv=none; b=n3tctNL9Wojw2HUgbS0KrIzOLFUFMdCWeS9Gxx650ikXzTZcvQkMmgRneFtf1DWvr6AOOYxOvkBbz4lGIiAJattdeWfaEXB0lZd4oatNSKWfyQF0I4es5p4Rs7qeA7QFOocEsz2L4X3yM8xSgBxR7VfWfd0Jf9aVU7bvxWU1+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978047; c=relaxed/simple;
	bh=6D4BSK+3T1nAiGUpMmtNjk230tXko9pc9t83etZFzeI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ASeJSEUGT7/oTsm1nd9KIGu8hv/ouzjuEv7j9aEpLP1jNHg0HkZdLyhpLtnerr5lp1nvvF6DKBOgAA3mcJwu0K6Onj1F/3YCa43d4z+FLAXLZxjvtGzS50uD5sO/z9IZULe1XXePZh3fLC0T3PQVebylpJUuOig0E9QhIvpP6V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=occITeni; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-384c94c9414so291168a91.3
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783978044; x=1784582844; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+USb3n4BDL969RhM6AFut2RcEXsxb0pNRXhYra/sKHA=;
        b=occITeni3/o9TT3l1OusAcPoV8PGL/cch5kYRpqzXUZcwB1uNaULdpCcrogGpDsncp
         Oe4HsCEUjuFcrxy3SdWykfqxz1nSjVEoyOtYf49ktgS4aQj9NnBjdND8ChOtVUSomzP3
         2/7lY29kf0kJYnJOxT0imCbQ4F7hlNcSrc81s4AO10OVxIaz6d+FpK+6O0l3kjtXEpPw
         euqb694AyWe1Ne6GzTQSDcRr0H2NQI8hDA+HRYrpgv7mQCLtpcvnNNPyGr3BCVVse0ig
         jTdOkO8SlFu5Am1xJTOnp/WQoEGVzDh8VQapRd1D+9QgwvsFGieAj5IrD8DNK0/x1Rse
         yMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783978044; x=1784582844;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+USb3n4BDL969RhM6AFut2RcEXsxb0pNRXhYra/sKHA=;
        b=V5GlyJM41+kqCQVDhhVvUwFxOXQ+q9b6YdPzsK1QdtZSSMJSn9syi2b7cVcuysbnq9
         tBbb48A28pfxMC8Gwg2ROl2830l1R0Fa0Fckepq8vNZ+qZ0ply1/JNAr4w1vrli3LXPQ
         wRXCjrcbGNoaWrt3O2ACaoBv+iAFLYP/Wh2210jUf3XCmGeSf1Q8BiN+9vcC3r84rJVU
         Zbu7na0ZLgDA/9Cqs4JOjOKu4LFhWRvfwZMwrF07PPxNf2nOTWC1Yob4TVdr564QXcGn
         raxU90Z3FlbJzJAUUZ9/GHn9RS/GM2mmqjSWVKgjxHtcd5NI8bP2DF7S7/O9tX1TB6MT
         ucKQ==
X-Gm-Message-State: AOJu0YwlnC6YJ86Eqbw886R7HVttwk14OZnMpyJHjRkE3bbw2hPT/ihJ
	qRT6q78czdDH0N0CBQ7cHOU635iV/i4c1ot5HlkOGrs+EC673ri0tfk1kUeoNJyrw6g=
X-Gm-Gg: AfdE7ckSg2+IVOy3tft09GeF42X+1Rdto09TspYWo8NRZSzycU7NsIzI7lg9IBQbGCC
	9B9RYD5wbHQpy/fe+pgzC4aZCa2uPzXu4i91dRsH+ATy0NZ75iGNW91xuKuKNCulGEvXWDtIrFT
	BhABt+5u8aF9CYp3pGAFk1XdTakYcdGZh/nupyIQgbnOsyNIblwpdM027BvZenRao+H6xHR8Wkb
	w3yD/6V/awMdjYm8y00hAJuAWA28cwWtImJQpx3rDuCYvVwCDYIRBrDEQbFxmGF0esauU9WbdHi
	Q8BB3RpVvmAFtH14ucwSMgdYWl+aiJhWxq2ikTCpwBigg02KoaveFqCDiot5ieL6P9PHVr94/QS
	BlrS7rHii+1D9OPcL6aLeYGxPHs9jXQpvM2hoJXLBE8Qhe0pRkMPUp/FnOMeFKMKyI5Olt3PPiP
	I3mkieSrI3RB3Yo+JrVByrOAsBUJ8M77vyuziqM2888301P6ilKpFg
X-Received: by 2002:a17:90b:2d10:b0:37f:9ce1:735f with SMTP id 98e67ed59e1d1-38dc779f507mr9978583a91.32.1783978044021;
        Mon, 13 Jul 2026 14:27:24 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172faba3sm433937a91.11.2026.07.13.14.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 14:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 17:27:22 -0400
Message-Id: <DJXRFQTMYRTX.16Q66ORKV2WCA@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 05/15] bpf: Replace prog_list_prog() check
 with direct pl->prog and pl->link check
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-6-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-6-ameryhung@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:kernel-team@meta.com,m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307286-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 634FF74F40C

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> prog_list_length() and compute_effective_progs() use !prog_list_prog(pl)
> to skip a 'detaching' pl.
>
> When pl->link is not NULL, prog_list_prog(pl) returns
> the pl->link->link.prog. This does not work for the upcoming struct_ops
> patch where pl->link is not NULL but pl->link->link.prog is NULL,
> because a struct_ops map is attached to the cgroup instead of a BPF prog.
>
> To prepare for the upcoming struct_ops patch, this patch
> replaces the prog_list_prog() test with the
> "!pl->prog && !pl->link". In __cgroup_bpf_detach(),
> both pl->prog and pl->link are set to NULL, so testing
> "!pl->prog && !pl->link" is the same test to tell
> if a pl is being detached. This change should be a no-op.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

This change itself is ok, but now prog_list_prog never returns NULL
under normal operation AFAICT. Can we add error handling in the
remaining two call sites? prog_list_id() especially, since it blindly
dereferences the result like so:

	return prog_list_prog(pl)->aux->id;

Imo it's worth it even if the code gets slightly more verbose.

> ---
>  kernel/bpf/cgroup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index b64f6757096c..b100c04cb9c8 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -408,7 +408,7 @@ static u32 prog_list_length(struct hlist_head *head, =
int *preorder_cnt)
>  	u32 cnt =3D 0;
> =20
>  	hlist_for_each_entry(pl, head, node) {
> -		if (!prog_list_prog(pl))
> +		if (!pl->prog && !pl->link)
>  			continue;
>  		if (preorder_cnt && (pl->flags & BPF_F_PREORDER))
>  			(*preorder_cnt)++;
> @@ -482,7 +482,7 @@ static int compute_effective_progs(struct cgroup *cgr=
p,
> =20
>  		init_bstart =3D bstart;
>  		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
> -			if (!prog_list_prog(pl))
> +			if (!pl->prog && !pl->link)
>  				continue;
> =20
>  			if (pl->flags & BPF_F_PREORDER) {


