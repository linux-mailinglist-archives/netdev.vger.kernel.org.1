Return-Path: <netdev+bounces-304660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2kdwOZYZSGpbmQAAu9opvQ
	(envelope-from <netdev+bounces-304660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 22:20:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6E770577E
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 22:20:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=O1VZSQ4m;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304660-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304660-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0180301D4D0
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 20:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC7933439A;
	Fri,  3 Jul 2026 20:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49C9322A2E
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 20:20:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110030; cv=pass; b=SVxWCj63+InS0CFAY/UVKKA9y6Gx60dbjpHYsKeP+LAhk/s3MO0DK0dHZPy2fX8RozNcGZahOvio8Pmy/Pn8IShnrQMf7EFX4/y513cmUBeFLFv5F6skw3dCcOCXx5rMqi+9CYy+GFk81LkRkxWMTupnudo8FBD2YEM/RWjaikI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110030; c=relaxed/simple;
	bh=MZaSDZbIsGKPO5iamZxXJcXj5gxxHuIU5T5iRXZGMo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SW1O3FaQEAwkd8K/1GTm8XEB5cmTgH7kyj6rQKJn0dW8+baaPq6KXXQUAiMFBa3dX/MxookbYvtM/xq1TpMuR+Yna9vO/pWes5wCshIaMiJhC3LfNzusylEo2dvAD+m1jbCgUAn+o55Ha7Qy05bZcFe6zc71KVamQOJzQSW6yHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1VZSQ4m; arc=pass smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84592b55832so634662b3a.3
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 13:20:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783110027; cv=none;
        d=google.com; s=arc-20260327;
        b=eCOHZusIfSMbbV/XTQNc1liVKdiiHkCq4LrM/coC/2qkirs55p8xiGqgWKjf4YBlWP
         KiYCDOiBT4cA39MDJNb8D2WTGtBhToTcekRtmI/f47DWSLi+fB8EzRsTXx5k0AROrV9K
         jslUJB0mIhWgT2nKkNhsh+mPUnpgSR9GYC6+u6vljVSoqHyFOmfJSj/66Gmn/Xwd4DNG
         Xqa//EuNQHs6Ze6IBKv40rtrLvJnc6Fbiz/yjvNZiWg7BEuHBusnCj1sanP7I4ZijgFv
         vAnvZlPoXQ7yejbhk8arjtwy2n8USlnPfmoQpVwj7vvpRk4aZKYupntp8+5mkWeovm/L
         rvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WBwO0HLXnTzvJ7ulzeXmj3dtZfisJSDVwZYhfGTddaQ=;
        fh=d2/xECAaAAQP8QhNtxjVzrURoI/qfVBkCU6RJP0TvFk=;
        b=hBmw0bwkvRFtdVVusEwHXMwFoAwGB/ScJnMwpSGzY7YVrZTZFlw7LsoqT3A+ucBj06
         8qSe+OYAYFsjLe7HVsudnzJ551za05ZijLBAI6d60mKfEUNnZ+R3oSA9PJmEuqqWYQ4a
         nhji2IBCsqftD0Td030cN8BH61Mv1zAdtLZ8+pd2D2ZkH/nx3V9SrS9c908KzVj8YT34
         hZkbX6ULu+Lz3Nqc9aWtJhhdoqREv6ngTpgOHsz3rmbsDJIuEEsDRwERUTi5MPz+R+U5
         93aceVHXioI8At5uSovdYYuE0bQoYuURKckz8IcKctA02p7aVdo7JHyo8d7hY27Bsxj/
         O9ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783110027; x=1783714827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBwO0HLXnTzvJ7ulzeXmj3dtZfisJSDVwZYhfGTddaQ=;
        b=O1VZSQ4miK4CwxFfA+3OCJLrkTPjUP4lCkkTp3GN7TAyVT4Xa6VOfx4CDaLGcOd2F6
         o1Q+8ZT08P2RNlxzSzxzJ+UvrVrsm9Lo1DeCoFW/AlxnCGV5hcs4uYF2WSWh41ZOk9Z2
         Jaes+Ka9C6v073gjQe0JDosgLCHSQeF/W0P5/vBStB9O5wxC6BnBhTC485KUk2BQDMVq
         8ngRjGMGwj6PZeD81130JhkvJKTFqLXxG4RwhAZoJXfDvz5uR0mEu9Q2DDDt18F0wMMj
         O1ou8+Hu0xDSNOpRvID9iip7+ZF4PeASrgeEQBOxxtEc+rEzBbAfBMxTMA6Bp6CH/Jb1
         +YRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783110027; x=1783714827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WBwO0HLXnTzvJ7ulzeXmj3dtZfisJSDVwZYhfGTddaQ=;
        b=tPwrVx2/k+cXV8cPpPYncNt/xrYjayO/qFS2O8sLmgC5/IQtfSgSukW7snasOOWsXu
         rjNozeC2ryN9y/GTdrO1d5wJ9sRctsrlXBXs2l9xtu4w3WVZ6Z4HWXaztbDfqi11KIVb
         fbO9TzC3lqlMBxLuztOpWU7nDq3jIL7zPrFJv0T8pnU93VHR5313cdjABwu9vcpaB3F0
         L3vMDztllDjHLg6903AiDlvRz+yUTyZz1LWmHU7jD+zi4Qtv2ibpw6ZI0/QaRtf55Epj
         sJMqp6t91sBS6ER+cOpNNn0tYCvIZGsmrzHyHEfX53DR/ZAW/4ZPJpMAjdhjVh6bk9Vp
         pauQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDCHvaQCbS7zkRdocjgAeQJvnrGo7Ct5Ym1h9PNfeoGkyLXXChrG12L8GTEpyy2G4UPUA0zHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGvmBgbvuFlivO2jhhuzCdeuEZm0uzNdhp+TUMMJkboUlH7zAL
	vOD+kbnz7gNzrsTCA9xnkiZcbCffCcMHJDkcTXGfYhsIfBjZMpA3EgcKaJXSvxU9c6XpTN5Leyt
	aON8iKWEnCcFEIe4i9eMuotHB8Bw+ugBfXSKh
X-Gm-Gg: AfdE7clzeHWBzxhh+RClsKpbuRHJqyAweQmGoxYQC6DcGVlgXM53mfyGXpVBHuPNKE1
	TtGYRFpZHGvctUxtNkfsthzu41/PRGBIOvJN9np4Jmx7KXwt35XxctHB7NDrdbjMCiGbpd6UXK6
	Pz4IpCG9gGZmNm+mp2vt8SpMq7dhQd7qypsIj/UdJ1ssHBHQGtjDfYoMMney8lBlVLjw4QKdpou
	NLzN6F34jKuA+QdRTUdp5cvA+NySqLkkqMAL7vk7IFisNlps20Km9AqXxMZSdsycSV9Lx374lN8
	BUIE3p6RZ2fVYgUBvCvlsN2vANSWO5k8+N1yt/vc5fkgtPOct7n+V+FP9xzZqOI+onDEmbG2OSH
	/2mYGq0k3AqK+QuIE0nlpljJ+/I4QWQ==
X-Received: by 2002:a05:6a00:8d6:b0:847:997b:1182 with SMTP id
 d2e1a72fcca58-847f6fe98f9mr789555b3a.59.1783110026811; Fri, 03 Jul 2026
 13:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782798905.git.xizh2024@lzu.edu.cn> <e62943a59f5e1c7a68beddc1dbebe50a9a036c16.1782798905.git.xizh2024@lzu.edu.cn>
In-Reply-To: <e62943a59f5e1c7a68beddc1dbebe50a9a036c16.1782798905.git.xizh2024@lzu.edu.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 3 Jul 2026 16:20:14 -0400
X-Gm-Features: AVVi8Cchq3Ik_ZvAHeFYTBg5iJ2SK4hiW8mxIoJVb97RzOxxGipeMSZfow_CVuc
Message-ID: <CADvbK_fsEC=dViaQMDVD4BQY_i=Yv=GHfyQdFkHxSVeannjjhg@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: sctp: fix AUTH HMAC list overflow into auth_chunks
To: Ren Wei <enjou1224z@gmail.com>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, vladislav.yasevich@hp.com, 
	yuantan098@gmail.com, dstsmallbird@foxmail.com, xizh2024@lzu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:enjou1224z@gmail.com,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:vladislav.yasevich@hp.com,m:yuantan098@gmail.com,m:dstsmallbird@foxmail.com,m:xizh2024@lzu.edu.cn,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304660-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,hp.com,foxmail.com,lzu.edu.cn];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C6E770577E

On Fri, Jul 3, 2026 at 3:19=E2=80=AFAM Ren Wei <enjou1224z@gmail.com> wrote=
:
>
> From: Zihan Xi <xizh2024@lzu.edu.cn>
>
> sctp_auth_ep_set_hmacs() may advertise a 12-byte HMAC-ALGO parameter when
> four identifiers are configured, but the association only stores ten byte=
s
> in c.auth_hmacs. sctp_association_init() copies the advertised length and
> overwrites the adjacent auth_chunks field, so sctp_auth_asoc_verify_hmac_=
id()
> accepts forged HMAC identifiers and sctp_auth_get_hmac() indexes past
> sctp_hmac_list.
>
> Clamp the stored parameter length to the association buffer, copy only th=
at
> many bytes when initializing an association, and reject out-of-range HMAC
> identifiers in sctp_auth_get_hmac().
>
> Fixes: 65b07e5d0d09 ("[SCTP]: API updates to suport SCTP-AUTH extensions.=
")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Xin Liu <dstsmallbird@foxmail.com>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
> ---
>  net/sctp/associola.c    | 10 +++++++---
>  net/sctp/auth.c         | 10 ++++++++--
>  net/sctp/sm_statefuns.c |  2 ++
>  3 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> index 62d3cc1558..760457def6 100644
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -260,9 +260,13 @@ static struct sctp_association *sctp_association_ini=
t(
>         asoc->strreset_enable =3D ep->strreset_enable;
>
>         /* Save the hmacs and chunks list into this association */
> -       if (ep->auth_hmacs_list)
> -               memcpy(asoc->c.auth_hmacs, ep->auth_hmacs_list,
> -                       ntohs(ep->auth_hmacs_list->param_hdr.length));
> +       if (ep->auth_hmacs_list) {
> +               size_t hmac_len =3D min_t(size_t,
> +                               ntohs(ep->auth_hmacs_list->param_hdr.leng=
th),
> +                               sizeof(asoc->c.auth_hmacs));
> +
> +               memcpy(asoc->c.auth_hmacs, ep->auth_hmacs_list, hmac_len)=
;
> +       }
>         if (ep->auth_chunk_list)
>                 memcpy(asoc->c.auth_chunks, ep->auth_chunk_list,
>                         ntohs(ep->auth_chunk_list->param_hdr.length));
> diff --git a/net/sctp/auth.c b/net/sctp/auth.c
> index be9782760f..4d14bd6185 100644
> --- a/net/sctp/auth.c
> +++ b/net/sctp/auth.c
> @@ -447,6 +447,8 @@ struct sctp_shared_key *sctp_auth_get_shkey(
>
>  const struct sctp_hmac *sctp_auth_get_hmac(__u16 hmac_id)
>  {
> +       if (hmac_id >=3D SCTP_AUTH_NUM_HMACS)
> +               return NULL;
>         return &sctp_hmac_list[hmac_id];
>  }
>
> @@ -510,6 +512,9 @@ int sctp_auth_asoc_verify_hmac_id(const struct sctp_a=
ssociation *asoc,
>         hmacs =3D (struct sctp_hmac_algo_param *)asoc->c.auth_hmacs;
>         n_elt =3D (ntohs(hmacs->param_hdr.length) -
>                  sizeof(struct sctp_paramhdr)) >> 1;
> +       n_elt =3D min_t(__u16, n_elt,
> +                     (sizeof(asoc->c.auth_hmacs) -
> +                      sizeof(struct sctp_paramhdr)) / sizeof(__u16));
>
>         return __sctp_auth_find_hmacid(hmacs->hmac_ids, n_elt, hmac_id);
>  }
> @@ -708,8 +713,9 @@ int sctp_auth_ep_set_hmacs(struct sctp_endpoint *ep,
>                 ep->auth_hmacs_list->hmac_ids[i] =3D
>                                 htons(hmacs->shmac_idents[i]);
>         ep->auth_hmacs_list->param_hdr.length =3D
> -                       htons(sizeof(struct sctp_paramhdr) +
> -                       hmacs->shmac_num_idents * sizeof(__u16));
> +                       htons(min_t(__u16, sizeof(struct sctp_paramhdr) +
> +                                     hmacs->shmac_num_idents * sizeof(__=
u16),
> +                             SCTP_AUTH_NUM_HMACS * sizeof(__u16) + 2));
>         return 0;
>  }
>
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index d23d935e12..21cda509a0 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -4431,6 +4431,8 @@ static enum sctp_ierror sctp_sf_authenticate(
>         sig_len =3D ntohs(chunk->chunk_hdr->length) -
>                   sizeof(struct sctp_auth_chunk);
>         hmac =3D sctp_auth_get_hmac(ntohs(auth_hdr->hmac_id));
> +       if (!hmac)
> +               return SCTP_IERROR_AUTH_BAD_HMAC;
>         if (sig_len !=3D hmac->hmac_len)
>                 return SCTP_IERROR_PROTO_VIOLATION;
>
> --
> 2.43.0
I think real issue is the member:

  __u8 auth_hmacs[SCTP_AUTH_NUM_HMACS * sizeof(__u16) + 2]

in  struct sctp_cookie.

It's supposed to include a 'struct struct sctp_paramhdr' + N * hmac_id.
However, sizeof(struct struct sctp_paramhdr) is 4 not 2, which causes
the overflow when copying it from ep to asoc.

The right fix should be:

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index affee44bd38e..cccc662561aa 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -312,7 +312,8 @@ struct sctp_cookie {

        __u8 auth_random[sizeof(struct sctp_paramhdr) +
                         SCTP_AUTH_RANDOM_LENGTH];
-       __u8 auth_hmacs[SCTP_AUTH_NUM_HMACS * sizeof(__u16) + 2];
+       __u8 auth_hmacs[sizeof(struct sctp_paramhdr) +
+                       SCTP_AUTH_NUM_HMACS * sizeof(__u16)];
        __u8 auth_chunks[sizeof(struct sctp_paramhdr) + SCTP_AUTH_MAX_CHUNK=
S];

        /* This is a shim for my peer's INIT packet, followed by

Please give it a try in your test env, Thanks.

