Return-Path: <netdev+bounces-295877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wz7uK3PxImoyfgEAu9opvQ
	(envelope-from <netdev+bounces-295877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:55:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E56649858
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:55:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EED1K7WV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295877-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295877-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E1FE304673B
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73743B8950;
	Fri,  5 Jun 2026 15:44:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780213B71A5
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 15:44:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674290; cv=pass; b=hcBHLSB2w9oePN42TgZ2FubkNH2ZPLiuaOnbNlQpLxHGnZNgbimlNQB9BDB6gKJ/MMxWgLHc10G712C7MPV/5tcrhjqVlSaXeV9/NRvt2dRZhZsAFw1qfaEHGGkMU1UyZlo3yDkxNdRBzPlZLI0UFqeajDMKn6Rt9LbbW2A9rMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674290; c=relaxed/simple;
	bh=SIGgm/L1alKIv4HN6O02Y8AvR/R4pzEs/XXPa+5prPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Et9V/ntcuUYoNekr4z7ultCs45d76J0GzZQZN3IvbDAbBwiZnDTkx/nzLPMv7xWbBcDkb8ltL7HLb7n64FAmRtDkX41AN0dmQo69U5Vq8QcWTyM5n/BKLZyQlpG5Jh334BQPLG+YMyR2Fu6nQuOqnd5LXyTWQmelSLF/U+pfZu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EED1K7WV; arc=pass smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8419ab3a297so901924b3a.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 08:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780674289; cv=none;
        d=google.com; s=arc-20240605;
        b=HD9KfbUZnhMxUxKDRTNH3UMYdsiCTYweHBFtyjA8tSh3KBGM9OKCVA8okaVUfq9zAY
         S30mq4hbywAe8gLwXY4rLfvFmJoGAC52Dub54bAGDOAGoBrznWu2On6E/h6WK8lYh3XC
         e4k3/8vGwPozZMy0pliNM+NDkcISygLgT+bF3SCI94DIHM35jiGE8YpW/PS2Ex1SANG3
         OmlVVnlEW6bkdWfX6tTg4T8dxbpvs9iQu/UZ0CF6JkVv6mGLS3ePOZQlJdIdJV01g50H
         eJYXIm08kBzsrHImiBArDv7K9Sh/RaIwoYJc+QH/8WgpLN3MPBZznD4KSew7RTtSGPKD
         HnfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=91XmWNp/2iuNXAgWrEcWczmYAUf6TIOw0lYEdA91tpA=;
        fh=+7ppmbZ0WLdgBjyQ58g0yjPg49p7Hck8hWcRXy6tZtI=;
        b=IE4tyfoDjkT3fgj0buR4c6h6a/3UzbpinPJtCzX8JCSaxR+0sO45cr2RKGyPGgT6n/
         Dzic0Q6z9YvqrLxwvbnJYc+aExAXmtW22VIQtaXCFP4F6Wq2+r1LfXw6VencTIFJWYfU
         FE4cyOolJoecason9gUFx607UysWcDbXRW0wPCR8MsFrQcqTwHq5PKSfCPaIlkbzPT+C
         S2urKsBvyn0iyNZ8H0eNYKdEjW+/5IhwJpwSTocvm3UFCsgkJk3gjJUY1OiStgAJEazh
         ajbRvNCnnDVbilsvjQBoLc8H51b+5zf9itRLxzsCDz1derQfQbiBcO6CLxVps0Gu86Vd
         RT9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780674289; x=1781279089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91XmWNp/2iuNXAgWrEcWczmYAUf6TIOw0lYEdA91tpA=;
        b=EED1K7WVmN65zfZ6kY3DmsF5XSMrrbruJRVL99TDp1ST9ei4VUudLzE/swtQGV+NeU
         71xRLn1qGon/1v9RYZthCFAFTXFHCLBG1m3wikzuZUkLYezyQE/45lnJgNP23CDK+/33
         oP4CQ8K08O6pG47DEAleQ1fGx/snmJEBdanUdAOugDyry3wTFjjUZKKbRWkSsXG09V/B
         OoA/V1IHXudq0SzCua4eJoBWUN+9FdMX/iPeAvz4p3KiTEotRDLmvLCQL73QvD7094KQ
         BNecaCWgMyomVNir5YoKK24OwY4+XzyHtietKgiuwoM7CQPfhc2VVcl33wfIFXuCNZQI
         nQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780674289; x=1781279089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=91XmWNp/2iuNXAgWrEcWczmYAUf6TIOw0lYEdA91tpA=;
        b=s7xeTNvr5m2q91rIF2txWbpvEPWgP/UeOmEIE5wna9PG7tEnGhEWoc9AmUPyuDfMdF
         t1sA7F5cgaaOtHPnLdUttVXH0SrwHE2Zpy3Zl/lmujF97ivg0BlndXWdGv2umyx2Jiis
         BafbMzH9BIWpwDVOdPr/4mCRrzZ8ghT87mJ8QTgixs6Uw+ugYmglinDboQp3DcOeX6dG
         HCJ6igOpjZ/gmq6VTFpNZxbyiUqe4yPzuEZg2l+viagSzKGWzWoAK74JMSPPp6OjHbvk
         e9+G1EdL5XLp5jABsrn2UJUumvtIHVdMj7/DhQYzlVQ6qU5xYqDFU7NDoiLOWC3fGhuA
         Kb4w==
X-Forwarded-Encrypted: i=1; AFNElJ/QR5FOvKiMfn8Jul7CTiGX6yGqkXF6oBqJqlDoI5VG/AMf9x9C8s/hemcMAuB4ENMeJ2nCXss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4rOTJZZUZUn/BLpg5iP37ZwxOB/WRofSoiZ7AO6SBZvESlpTP
	U5TSsAz9xwQKprwZbXlRV3cTiQVws47/3QfWzNXVsqRzu1hkKamX9opo9A9GIVv2nY7SZYqPNC7
	pZXEUT7BryiKetpw2wgbCO2IQdYn0SB4=
X-Gm-Gg: Acq92OGhd5eeN4SDYa4NCwD35jbHQELrH89C2rMMVlc5pJ1YDy9QYY8cJRdtp9i6+hW
	+C4ULkaYGwF/O04QO+ahj3QTBl20M0fuLAud/P85LUXieGtGeJ+cCVR07sF8ledy4pJymjE3s1l
	0OWKaoy+x7TZmxhfwN5LJRQiCLpp+La+4BLj8DBBov8tNCwiCTf2aHeZ/16FxHGsW9/cPEh+6WQ
	u99sM4aLpiwxY+WHR75k0+5kb90Aw3vYXFXdfRhjzd0Lkn7u1qWFIOEeNf4xHh1vU4MVEVrvSWB
	+SoalNbHFuDMjhR2T4Z0hYhGsNm75sTVJb2pgfczX9wGhyqkJOO6HazKGbO8MzpftNeEOxkWM0r
	Tbdaotnnflby9SzM1/o+uJl2XBTCI0afvHmGiqGxPwRk9QMl36w==
X-Received: by 2002:a05:6a00:9098:b0:842:8985:340 with SMTP id
 d2e1a72fcca58-842b0fa550fmr4179929b3a.35.1780674288619; Fri, 05 Jun 2026
 08:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604175803.2142975-1-michael.bommarito@gmail.com>
In-Reply-To: <20260604175803.2142975-1-michael.bommarito@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 5 Jun 2026 11:44:36 -0400
X-Gm-Features: AVVi8Cc57qodMTHcO3Ah7wF-7tLXcfiDwzWLYHPyJXuCdUMFogbSOhqiEe0qEc8
Message-ID: <CADvbK_eKM8qD6p141W1y0KsbTTm9bjRijg8ZnyyRbce7DBf9zg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Vlad Yasevich <vladislav.yasevich@hp.com>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295877-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:vladislav.yasevich@hp.com,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,hp.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4E56649858

On Thu, Jun 4, 2026 at 1:58=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> __sctp_rcv_asconf_lookup() in net/sctp/input.c only checks that the ASCON=
F
> chunk can hold the ADDIP header and a parameter header, then calls
> af->from_addr_param(), which reads the full address (16 bytes for IPv6)
> trusting the parameter's declared length.
>
> An unauthenticated peer can send a truncated trailing ASCONF chunk that
> declares an IPv6 address parameter but stops after the 4-byte parameter
> header; reached from the no-association lookup path, from_addr_param() th=
en
> reads uninitialized bytes past the parameter.
>
> Impact: an unauthenticated SCTP peer makes the receive path read up to 16
> bytes of uninitialized memory past a truncated ASCONF address parameter.
>
> The sibling __sctp_rcv_init_lookup() bounds parameters with
> sctp_walk_params(); this path open-codes the fetch and omits the bound.
> Verify the whole address parameter lies within the chunk before
> from_addr_param() reads it, the same class of fix as commit 51e5ad549c43
> ("net: sctp: fix KMSAN uninit-value in sctp_inq_pop").
>
> Fixes: df2185771439 ("[SCTP]: Update association lookup to look at ASCONF=
 chunks as well")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  net/sctp/input.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/net/sctp/input.c b/net/sctp/input.c
> --- a/net/sctp/input.c
> +++ b/net/sctp/input.c
> @@ -1196,6 +1196,7 @@ static struct sctp_association *__sctp_rcv_asconf_l=
ookup(
>         struct sctp_addip_chunk *asconf =3D (struct sctp_addip_chunk *)ch=
;
>         struct sctp_af *af;
>         union sctp_addr_param *param;
>         union sctp_addr paddr;
> +       __u16 plen;
>
>         if (ntohs(ch->length) < sizeof(*asconf) + sizeof(struct sctp_para=
mhdr))
>                 return NULL;
> @@ -1204,6 +1205,16 @@ static struct sctp_association *__sctp_rcv_asconf_=
lookup(
>         /* Skip over the ADDIP header and find the Address parameter */
>         param =3D (union sctp_addr_param *)(asconf + 1);
>
> +       /* The whole address parameter must lie within the chunk before
> +        * af->from_addr_param() reads the variable-length address; other=
wise a
> +        * truncated trailing ASCONF chunk lets it read uninitialized byt=
es past
> +        * the parameter.  Mirror the bound sctp_walk_params() applies on=
 the
> +        * INIT path.
> +        */
> +       plen =3D ntohs(param->p.length);
> +       if (plen < sizeof(struct sctp_paramhdr) ||
> +           (u8 *)param + plen > (u8 *)ch + ntohs(ch->length))
> +               return NULL;
> +
>         af =3D sctp_get_af_specific(param_type2af(param->p.type));
>         if (unlikely(!af))
>                 return NULL;

This patch can't be applied:

https://sashiko.dev/#/patchset/20260604175803.2142975-1-michael.bommarito%4=
0gmail.com

I cannot apply it on my local repo as well.

Please fix it.

Thanks.

