Return-Path: <netdev+bounces-307507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OGNwNxpOVmqU3AAAu9opvQ
	(envelope-from <netdev+bounces-307507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 16:56:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A52756243
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 16:56:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=igAt+EmB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307507-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307507-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC3BD300B5A8
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57779492186;
	Tue, 14 Jul 2026 14:56:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F36248C3F1
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 14:56:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040984; cv=pass; b=MP2AUnThfcM8V71jOUuofInxVLNrVIEmDUwgFoLU6yqO+7/6B+iJhxMUQJfp1EEcTrneYuLHlpYgD57ANJdcW/hsgsmPPz09c5a1FeHUw4fAeBZIiiGFfA9mjtSw4Zps3wP7fmtqZxvCt1LHEPXHvFHGvrHLjaktMKTxAuYXMHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040984; c=relaxed/simple;
	bh=CXwQwHmNvO4bUr6Zlm4SdHrmJvOS/Lcja4aSUAKuQBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGElDlshWhD0IjtGTk330RxtClLeonZxS6lwbb642OCcoh5ntMtd3AI3+z0flujZ2rMAwOER6jVMc4dZDAIsSd4+D1dZ8ZISxM2ulXKrL22vdfK0caYffCKzKui3eqyr5Dso7owaR0bJYokbxTbgBVy9d19T4PMjpFyZjndN7pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igAt+EmB; arc=pass smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84864086bfeso4614613b3a.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 07:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784040982; cv=none;
        d=google.com; s=arc-20260327;
        b=ClaUabTMSr5eH+HdOns+oRqZk+oK/IhDHHHfj5IMi2XB9JCXYqCP2nT8IPD3mO8+d0
         K2+h8QnLWTNwvYP6vMoOOzpDdIRZuBseEAhWBnyWELsy6A9T12/ICZXgDW2vS5nyDEet
         ZbDjlFMtAo8vY5UFggb+pCzeQ8hQTZ+Z6OwG8fRZy1Rc+E60A5qe2SZN3MuZbwsHV2Zq
         QJMM/QICK9xqDlE4opEqEeyqIUgFjCXQh7FrSjJY/1nHPWrQS7cgYEKBDAPfkiyKAQO3
         4pYbLzFdBwVh7gNiWJojaKoWLspF5GmrjlBVQM2A5m2+uX1UyeyHkOpmqB66fmf9gFEc
         zIkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ITepx6DjdIxnpEY9Y9KwBEdseYgD6B2WB1LGMQmvPJE=;
        fh=RFEohtmQVvpyJxmQqDfv20Zbpxs3/FUG/wLbuZ7h0C4=;
        b=Co16Phys0Tp6IgaagkvrfEgw+euVfcNtK7tm2bgfZtKfzvh2MiDE7Nz5IRlWkfEGpp
         arIjqqOm26FJDHRvq6+6qxrd2mrAfDNFwPEb/1vwbybyGCm6zxsoJRD4uMoIhRqgoWpG
         SCgOwAeySEymsI9EJSC42vQ5GXhJtxhXAkXzsJNxkycvlxG1j9qMbzAEVuUVTbt1+OOd
         3jTs3Uwq3zfFmD9CbkH7+0gZuDw7Jc4waJkoWY6jmDvhMNxNIDyvyL8PwzAaZYN2evjK
         9l/dASha0t9B2KYNN7yEs0+PsL6kJvJ7h3wtdGRZQ/DMbel6GfQechALhnML6wU1yNmo
         OkGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784040982; x=1784645782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ITepx6DjdIxnpEY9Y9KwBEdseYgD6B2WB1LGMQmvPJE=;
        b=igAt+EmBwXUGowYjv+kja4LpjB6eqdDqBPDFpEPntkKO5clYAMHH24DL6kQHhCwTZ4
         SaCqLXtvPj/ZSOgIBvk2kfyRCJr/UDu5nUABo2J5iAFFklU0wY2llcBD38pPN1pbfvfW
         7JTfICjhJhU270e8lYl+KLnrDnUWC2ncKV60xwrIR+/cfyH7LJeA56cDUAnqFppf90a4
         VZeyRiRIc3y8GmP/LPbzUy+S8Kfc/qnVKbtTjTGscJcN0f/z3ddW5kvp6QW2EsT1fOlc
         LqvX5DD3jdUNFHVuBfGVLhyWJWBvrm+tcJvkq1qIpfdENPe3ifX4eWrU8d19DIqxRT/I
         27zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784040982; x=1784645782;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITepx6DjdIxnpEY9Y9KwBEdseYgD6B2WB1LGMQmvPJE=;
        b=PE2GfYaM4ZCuw8Fbw2g7x+JhWtDecUP5eymmLXDN0BAe3OwJBP+9gOn18TIZVtQ7CM
         /WyEDqHDkEuBX09WNYeTfRK10+rSLK7yD84QHJeypZfHM3hdmAo7Hf62GrN3803uYQo/
         S3iAg7SYDEFE7Fa6eUljYy551YbjpCk0QgSBerMgNN9FXXuODl3JTYqFEsH0rcNC8rbp
         u8/13RHsJVtwGoSA+XxlMyVB4IrX4HWAsOZ6x7aoN9wY2Kj4fQyqaBjnnL19cen5TUTY
         3VSxygzHfSVxd19AkZk1oB5zRX+W22R/d3Gy99iEcj4B4r8DiHjlogWZXhh2VrFZv3nk
         0vnw==
X-Forwarded-Encrypted: i=1; AHgh+Rp7KSph8XxNNtktyzjJuq1sFa98ZL5wPGHAUF1juEFbCVgRx4xzM39apXwPv0qqH4pZpzOYFho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7fKLFw9KyQXqCzpB/nXnyUrreSSwKCFroUAbBCqSbt1UTBO17
	/tN8RaSTb/Etzcql6PCcRx1UZKDZmKxBaJfx1WfMxVXizQwtB78QiMCKHqJQbLIskBW1E/iNe+L
	xu6Mqi3EuRRyodRszXXpGaQpDDOujr1Q=
X-Gm-Gg: AfdE7ckTUfG13RoHZVFQebgBn+W52GSd7LzJPZ6iQ7uUMBdWKaMYagNIxj2EZP5oeTo
	xptclS9Frmh00MkZNWZLIKAtfjk6hqdVR8Vu0xdcKDOPsJcu0oF4/Kj4VQObL1NrV/upapQ0NOx
	ArdeyO3707EedEWG+AXEfrmYACgT1ljIMK9FA9hn7GhnaLXFMnE8USjycx/ra8HRrB5YZ0CRg9x
	mGRX1IZ1ptm/Ongs6+Te3DM6FhVz0Ar6RekaYcrWntJimWw5lQdmJzo434KDkVPEr7EpVYngX6o
	Byo9HdfmCFIefwfRBtG6EID2nl6K5Z8HpceWX4xaHKGhlqkn6YiZ3mmQl9QaTE1A3vgzr3FIv12
	zLgh82nvKafr2xNFMtb8gTKQZc2tDVEqrHXviUMAk
X-Received: by 2002:a05:6a00:23cb:b0:848:2d1d:836f with SMTP id
 d2e1a72fcca58-84a557ee081mr2754412b3a.28.1784040982449; Tue, 14 Jul 2026
 07:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713032021.3491702-1-zhoujian.zja@antgroup.com>
In-Reply-To: <20260713032021.3491702-1-zhoujian.zja@antgroup.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 14 Jul 2026 10:56:10 -0400
X-Gm-Features: AUfX_myh9bJTdUyfEAcHraxX4Ij4RG8Ln7B_AWwpKCELo1Fds9HOrTWa6ax32CI
Message-ID: <CADvbK_d9mPZSvTiGCBJ_qHqbGo+z5BNEEc3wnvPkTFQCxO=MYg@mail.gmail.com>
Subject: Re: [PATCH v2] sctp: fix auth_chunk_list capacity check in sctp_auth_ep_add_chunkid
To: =?UTF-8?B?5a+S5rOJ?= <eilaimemedsnaimel@gmail.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307507-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:eilaimemedsnaimel@gmail.com,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73A52756243

On Sun, Jul 12, 2026 at 11:21=E2=80=AFPM =E5=AF=92=E6=B3=89 <eilaimemedsnai=
mel@gmail.com> wrote:
>
> From: HanQuan <eilaimemedsnaimel@gmail.com>
>
> sctp_auth_ep_add_chunkid() uses SCTP_NUM_CHUNK_TYPES (20) as the
> capacity limit for ep->auth_chunk_list, allowing it to hold up to
> 20 chunk entries (param_hdr.length up to 24). However, the copy
> destination asoc->c.auth_chunks in struct sctp_cookie is only
> SCTP_AUTH_MAX_CHUNKS (16) entries (20 bytes). When more than 16
> chunks are added, sctp_association_init() memcpy overflows the
> destination by up to 4 bytes.
>
> Fix by using SCTP_AUTH_MAX_CHUNKS as the capacity limit, matching
> the destination capacity.
>
> Fixes: 1f485649f529 ("[SCTP]: Implement SCTP-AUTH internals")
> Signed-off-by: HanQuan <eilaimemedsnaimel@gmail.com>
> ---
>  net/sctp/auth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sctp/auth.c b/net/sctp/auth.c
> index be9782760f50..c901d373af80 100644
> --- a/net/sctp/auth.c
> +++ b/net/sctp/auth.c
> @@ -672,7 +672,7 @@ int sctp_auth_ep_add_chunkid(struct sctp_endpoint *ep=
, __u8 chunk_id)
>         /* Check if we can add this chunk to the array */
>         param_len =3D ntohs(p->param_hdr.length);
>         nchunks =3D param_len - sizeof(struct sctp_paramhdr);
> -       if (nchunks =3D=3D SCTP_NUM_CHUNK_TYPES)
> +       if (nchunks =3D=3D SCTP_AUTH_MAX_CHUNKS)
>                 return -EINVAL;
>
>         p->chunks[nchunks] =3D chunk_id;
> --
> 2.43.0
>
Acked-by: Xin Long <lucien.xin@gmail.com>

