Return-Path: <netdev+bounces-297095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9EfOOlguKGrM/gIAu9opvQ
	(envelope-from <netdev+bounces-297095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:16:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 620976619FE
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:16:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ERz7Efvz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297095-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297095-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A464C308586E
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA86342982C;
	Tue,  9 Jun 2026 14:58:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D63A43C063
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:58:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017136; cv=pass; b=u/GPRZ6z/ZFhjhzC4UF/eNlxcYtLugaWfXd6Vh5NR8SPmYsF3VoJuL8sUcfjoZ0bhEUKLzZJGcjI77uPAz48Rlyv5lZyFVaB4xADHnpIlq1Ks0bU4pkoJRaqcCKzVb877YDz1LufXoed6tT1qO1osdBEKMm6txe9EqrDRNt0q3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017136; c=relaxed/simple;
	bh=fMh62eLOhdvO0usy4iUY0pf1PF0Zf7FtoOnXowWBotI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmTH56L5EHUIbdQrqoAW0sOeZ4E7KgyXy1/f2RdHr0stpa+JMW5qRLYjwX/HXRdVzyq43pfgE8ef9M3O9UnU5vJsTEpy6ioAv0YrAoevPJL/ViicD7PKz9CcDIwzs7/3HETn3M8TMtYsp3PMXlsGDS8q7bSd406NHqOAi+3iVSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERz7Efvz; arc=pass smtp.client-ip=209.85.217.53
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-6cfcad4f979so4787723137.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 07:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781017130; cv=none;
        d=google.com; s=arc-20240605;
        b=ZCIDlCqBJ2QKTN/aziAOA0hi78h/3avTiPpIuDohSWUv2B3jrGRJxKHcOHWGqSOAZs
         lKXr5zyHDk1vgnfHvk7PiF/jcozRtQZZO1NJhnv9Q2DPPmXzBFBgoL8soAjR+m1nl3aG
         JBoMZ5SeBcofvO1yP7xfXr1fTaxhRQtbS9PbBWOEEZgX91QGgNxjCyWoLXbwQP09upeX
         nBSJf0fgPPOt6xc3WF9MwCyn+kqSOd6dOetJ+m2ow3P8vPNIEL/4j7GyJ6kifAJ+uCZi
         9yru/JMXXdSyzS34uNQQzeq4DSHW+SebJtH7FrzbUgQlBFW5mh60f4w2ADIiLp0KuQ6I
         tlrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H57Owih5QKKzWEDODczf7OTcTvzt7lC+ATYjGHBhng4=;
        fh=yVRB8AABuSIM0bCw+Jy1fEHlxNwXDi7h4ZvoGPAa5nE=;
        b=fnjk2p2G38epd064Hf25k0IuAzwNocAKNurqkaB3m339Ylrxb6CPqjiUaHihsgyV3V
         5i9SkParclFf0ZLp33Ulf12FirWtIsTw0/D5YT9VdkSZ5IZKzMONcFED/0Zyl4A8t+tU
         8cvF+kOt1eEZtsSbCEHygTN82F9iIpV1YpHWKWzEdIcSwT76EFhE7fPCenWlTTWTv22m
         oYG80tRNJ5Vfle9Tu/8Ak/1YmLWry7U4xHmD7/02l4wic5JqTqjTpQBcAsYrbQ0AFN0h
         CUKhMmbKrKWgrwrfEuSZaj9HVDvXSCfd1okU0jpPMcYwe+eLii2r+svbaUhAGw9ei1Wi
         lj3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781017130; x=1781621930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H57Owih5QKKzWEDODczf7OTcTvzt7lC+ATYjGHBhng4=;
        b=ERz7Efvzss+oIrWfuAQM51JuSf5iuhPf3GAG7+vuM/8Bw8OmHP4zsQBbWSZrHUYknP
         2clPmlZwWSpsKcohPRII72UAXYFc5ho+nrBqF0GJLtcvFToOEBFvHMzLNAxsbyR/IqjS
         a6o52pnmZGvFker90Cdf/hrCM4FlGq5Ce7X7Ze4uMVD+6nctSdanHH/7cSDbk+snC6QH
         xAJdEZkEfG7j8aVSns5Mj5xzs9VtswHtlrHBs+Ugt5JeimHj4U2GmJ1UBgYbJ+OxV0CF
         tMq8vSkKuE7r6yJysUXeGsdiGBqq+iBLGXhdsGdfla2EJwaRBwrt/nj2tu2J3rL1h9zt
         Ltsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781017130; x=1781621930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H57Owih5QKKzWEDODczf7OTcTvzt7lC+ATYjGHBhng4=;
        b=MFXtlLJ8qNA82pyaLH/v7izoIasTRWNMJqunsMuo+jokcQ0iKuw1IjoZqF2jHwjvWM
         1ajc+R6btWHI0C+JPvZd37NQro88+WpPv6vIPOXprEBmJuxmxgymYCJrcehmDxP3Qnk1
         HTBr0Hkfz9m2wDXIhYOibD/VarIhNKtWyBkkSSC4TQmCoEKT6jevW9eXnIYOYyhGmWWm
         ZkwKDnXdZ24SR/673Q/wFyXntnIsiXBoDjLK5YQwGWrRfncRqzYDSsR+cGR/FMagsZpF
         Mdfa8BRmOa6TICv8bmJWL/RrecgmKu6unJflgt13iyI2j50bM9whORQ6bQlBT9cQBry3
         XAtA==
X-Forwarded-Encrypted: i=1; AFNElJ8qqaUSwP3O0J/UPFUtEOBEcgy0jdOVWrl9ZsRsG5mPkBpjbrdQNTxNi1kes4WIsqDHfYS1vV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqxGVhbUiEzaU4+sA6PZpprdwI4p8vS/Finr3QAKA/uQl6VyHq
	XbMAn11J6rW2Z+cpjHP7mcpIfI6WWSGZjlHZA193u8uh2NJL1ss2u8poSUhyT4Ggwz1wD7qqLbo
	NIt9Za0a1A5PoLphv00NXfaAu/m/mkriUM2PR
X-Gm-Gg: Acq92OHFvdrd1AzKx7uB3gX7Tc3TOt0CIOx5asXmVO0VhBgGgDhsSDJfyMJk6GdqYyb
	g8h3Wy9QTX3vpwzW/Pj/EqMc/7R6q+lPln2vFw7JcYWTd9Pa9I8p2P9PUaAHeTscCGpHqApKEMm
	psaecU9p2xm2WNTRTwGVxVr17V8h9dFSRqUjvB0homA9Ad4Pks8IWoFBDDmOeA0S5mUoKWL0uZG
	Cp/4/HELB8FoRMx11xIOGOFYqK3Z3uCcMbkJ9woZ3hZBE1CBUqxpU7sdbw2l6IMh3k9azlr/JEK
	bhqBq9LT8PQHciFWE9DMf70uuLxaCiujr+5ekjmOx+f4N6nkz0n/FMdy6/IOjg2N6mwHI0RyXkV
	f2SLY1o9IVQc8DvCh/AfAl6u+wZAnjItzkPo5aP3c3sXSK/l9+iMQIeAikl+qkg==
X-Received: by 2002:a05:6102:8001:b0:618:442a:9e76 with SMTP id
 ada2fe7eead31-6feff813ee1mr11333035137.10.1781017129848; Tue, 09 Jun 2026
 07:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608122234.459098-1-michael.bommarito@gmail.com>
In-Reply-To: <20260608122234.459098-1-michael.bommarito@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 9 Jun 2026 10:58:34 -0400
X-Gm-Features: AVVi8CfBBT7d0bAskWAVYMw__d7eXDupmpTg3qFr9V9XwUvjdbrVkT6ocmLEXwg
Message-ID: <CADvbK_ed+J=k+xBFQYszROgK9f9zevTmxEsjrX3Ow1rN3rp8Sw@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297095-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 620976619FE

On Mon, Jun 8, 2026 at 8:22=E2=80=AFAM Michael Bommarito
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
> v3:
> - Simplify to a single bounds check that the whole address parameter
>   fits in the chunk, written as an addition to avoid unsigned wrap
>   (David Laight); drop the redundant lower-bound test and the
>   param_space/plen locals (Xin Long).
> v2:
> - Regenerate from net/main so the patch has index lines and applies
>   cleanly (Xin Long).
> - Use unsigned int for the decoded length and compare it against the
>   remaining parameter space after the ADDIP header (David Laight).
> v2: https://lore.kernel.org/all/20260606183821.1688525-1-michael.bommarit=
o@gmail.com/
> v1: https://lore.kernel.org/all/20260604175803.2142975-1-michael.bommarit=
o@gmail.com/
>
>  net/sctp/input.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/sctp/input.c b/net/sctp/input.c
> index e119e460ccde0..864741fae4187 100644
> --- a/net/sctp/input.c
> +++ b/net/sctp/input.c
> @@ -1204,6 +1204,14 @@ static struct sctp_association *__sctp_rcv_asconf_=
lookup(
>         /* Skip over the ADDIP header and find the Address parameter */
>         param =3D (union sctp_addr_param *)(asconf + 1);
>
> +       /* The whole address parameter must lie within the chunk before
> +        * af->from_addr_param() reads the variable-length address; other=
wise a
> +        * truncated trailing ASCONF chunk lets it read uninitialized byt=
es past
> +        * the parameter.
> +        */
> +       if (sizeof(*asconf) + ntohs(param->p.length) > ntohs(ch->length))
> +               return NULL;
> +
>         af =3D sctp_get_af_specific(param_type2af(param->p.type));
>         if (unlikely(!af))
>                 return NULL;
>
> base-commit: 9988931df99cf5d68af360e1f23b9c674a0b1b4f
> --
> 2.53.0
>

Acked-by: Xin Long <lucien.xin@gmail.com>

Note in:
https://sashiko.dev/#/patchset/20260608122234.459098-1-michael.bommarito%40=
gmail.com

The pre-existing issue reported looks real to me, I may address it in
sctp_verify_asconf() and sctp_verify_init() in a separate patch.

Thanks.

