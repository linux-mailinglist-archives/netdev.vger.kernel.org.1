Return-Path: <netdev+bounces-253484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IFKBZ1rd2nCfQEAu9opvQ
	(envelope-from <netdev+bounces-253484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:26:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5BD88CEC
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF7463004F0C
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6623385B5;
	Mon, 26 Jan 2026 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDGEanDv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6003F7494
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769434009; cv=pass; b=DA7vFReewiQ6g3yESTd2SyIe3U1raYElrO7WLF4wRxgqKYFS4ZpKbGxXD+uPGOdSxXlu0hbPmLXTiNLV655WwmE6EBfrP4HE4gNVZ3kpPmYwh7lilYVoHy34ESwhcDsUm2lvhe0oxg3NZmd8sqGStpIVfbqcfaYe2mbuer9Ntks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769434009; c=relaxed/simple;
	bh=BX64JmH75Zpil8XSGmc7fuBqvPJ74wuAVwHgMmKcf9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhhoVO1xkuN2jF/QMKPnJ5eKVEAxTPM1s4h/PJw1v0q57qvQBeLGJimFyQ3gJ6DjyVd/ddDaGdcsuKgiBCs4J9tFTIGYMl4ffvv4WUCMmAmYfhlWWTpoznfnXHzRpzqpEy8Jf+CHb7lXv0h4fCo1T3MSGZy/319IQinmYWfRU80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EDGEanDv; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5014b671367so54486361cf.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 05:26:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769434007; cv=none;
        d=google.com; s=arc-20240605;
        b=ekw8o/UiIRpX7gRvTQx42xgBPEjwbmpeAsPVoP5rZovyxF60h1jbp9z4I/OrnnYQoR
         SKMbXccqBKyOKc+POUGrepk2QqFh9Uvapn1fGAVczbzSGw7uKHD67ciWzdiWxdAWGgC3
         MBxLlEZh9u+hGMM/ijNMo53jcs3ftoxSxyKAbhywoMZsvfuiFIO7A1UnS+hsFo3eqE2t
         6IwkfciDWom3sA7NUH4tcONzOXz8EmEIdsdhY7Oay7w+FQjsr4Ow20LH6X8j9fNZXWoV
         O6+SB9GjaFwFQEFSumSGrOzO8zDJjBgL43DP/27Ja8ZPdEgewfHzwcr45sB59cTIfExJ
         je+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GwQrtPKSS8MhTcYPEdEzMX0OJ91zHhN3YjN3JV6Yq6g=;
        fh=bAUC2FANIKoCxMbjYtI5QmAcRjUm8anSQWKqtwhW6x8=;
        b=fxWSKG1G/npG8VXl8Y3xGcGqr8a6+2CtX0YOL1IP45YUV/yHN1uB7dBIs4efoGoqxc
         4pPorCH+3B6iMJhoTolphQn4mAstyrS2zuYLyjTxnkiuBWg2DtXs5Z9YkUo0v1umBbkS
         cx7IXIf8HLZ1Fg4LyH0CBhCBo2ImK4UoFr6l/3uDO4bji1VMyAOSBp+4SChp+1Sufe6u
         565CpcL1TNRDZ5PddulofVeg/hICkbF8/1TNtZt4aTPJhWFIWbQCTsqoovjmegMvumST
         TFZLxXa4S6r2SQmPOzItL4m7+CgXSFke619/k3HTg9+7igyTM36lhGHu2y9UKfafb5+U
         8VyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769434007; x=1770038807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwQrtPKSS8MhTcYPEdEzMX0OJ91zHhN3YjN3JV6Yq6g=;
        b=EDGEanDvNT4Wyn5nIPReezRhtmbEaUy+2Cyq7Ej3ujlYF0qm2mEejLjFL4B4LeRMON
         3GUkp7Zv6bIf4Q1vLzRliQwcrSDmeri0HkUbm/By3ksTj0/P4HrUP5J++QxQDDEucda7
         DaoxAfh2jY144BdiuSGkPhF+TNi+UOcioJnqiKIIdAQFTPBe1cd+e0o4n+Cx/GQPXCXJ
         7XQ9xdLCaaRGjZSumtGiOOvEBVPiua5g1yqI1xW7JPFTvJjqjawcsa3urPE8TDEHuXF7
         zB3Rwn/OwPLcr/219M5tvhRc5c3CanQnqqb+Jg+WV+TvVKTLyEbjOrqp7dL/6EXVHu62
         d5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769434007; x=1770038807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GwQrtPKSS8MhTcYPEdEzMX0OJ91zHhN3YjN3JV6Yq6g=;
        b=L21R74szpapoG/sRHTugVyX9JIyBBf2ma6zcNUf1N2qgTWaBOyqxhHk+8GX/jBJrjI
         /6maHL2m7w4HeF1UTpDVi9a8QCE/4jUayCeppuXDZGD7vkxjtlRon1jVIwApYA0WV2dT
         qCfGIdGtBKgQKaIBz2hPwQGbtU7A/nSukuX3Djjw3oFty2tIR0KGaECJRy7afDDPW9j4
         U5sT/N/tUChdDUuOnyrAzka/8lLw5vnRZBy8NodU/cCHMM66bApKzJnmCvwDEKlWzJQf
         wUF1HpW1R07cBj4/jrDXxMyB0lIQneO5RP+YcEjKW6p6T5/zMlp4HuXSSj0oxrxpel5m
         B56Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcYC88HCXUb+g7agj74gwnSghPIR6ZzIBZdapn6KvIsTiiBXswSzEXdKhFAoNcQHnBJsm2GS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKIJyGPwukN0vJUjTHBRlWTuSGEcZUCslAXnqXgIKpa7HCXlx5
	EjE8llXPPhKLdwd+LRaDLWAAkFnZC8gQWLQWvZQPSxmST48foRcVYGRxTGOI9cP1dDDj7t0Z4SJ
	s/O5fXaXm+ET3RGhTB7TjMEoJRtUtiZ8JxFVmpd63
X-Gm-Gg: AZuq6aJ0217HPFNdSEuNpJstnCzkpe8Do1M7+8Ax4X8QJSBIhpsMHzZw0nj9mknVcOL
	vO7Rjzcmy4gmgo2S3WQ75EplShlmYAFal0GmMC8u64IH8oF3qK2bBFsICsfT77humGsi36YMZnG
	uhsRX8eWOeisEDwE2L3gtYuv196/5e3wbXDXt1KxbBEA1PgK5Ti08M/5aqclFsuZvrDoGCsNSqG
	iLetmo3lPzlPyCPJsA5uE5I5Gl+50MIaYi4VyCem7zNLawbdXvmDSE6k5uzV3phK0CyI/ZaOqWF
	544E
X-Received: by 2002:a05:622a:345:b0:4f4:d298:b47c with SMTP id
 d75a77b69052e-50314bde895mr44108571cf.28.1769434006965; Mon, 26 Jan 2026
 05:26:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6954bc70.050a0220.a1b6.0310.GAE@google.com> <20260126114332.23955-1-sohammetha01@gmail.com>
In-Reply-To: <20260126114332.23955-1-sohammetha01@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jan 2026 14:26:35 +0100
X-Gm-Features: AZwV_QhmxFYxmShT5gsyJQWDXcDKCuEtSOICrxjGxqht-VPWWCf8urrICQPg7c4
Message-ID: <CANn89i+txkMjnxtaXtFJucNCLehhOdCw=5KBGpxCMj2v2erLNQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: skbuff: fix uninitialized memory use in pskb_expand_head()
To: Soham Metha <sohammetha01@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, martin.lau@linux.dev, sdf@fomichev.me, song@kernel.org, 
	yonghong.song@linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kernelxing@tencent.com>, Kuniyuki Iwashima <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>, 
	Mina Almasry <almasrymina@google.com>, Eric Biggers <ebiggers@google.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253484-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linuxfoundation.org,kernel.org,linuxfoundation.org,vger.kernel.org,syzkaller.appspotmail.com,googlegroups.com,iogearbox.net,gmail.com,google.com,linux.dev,fomichev.me,davemloft.net,redhat.com,tencent.com,rbox.co,intel.com];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,mail.gmail.com:mid,appspotmail.com:email]
X-Rspamd-Queue-Id: 9B5BD88CEC
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 2:22=E2=80=AFPM Soham Metha <sohammetha01@gmail.com=
> wrote:
>
> pskb_expand_head() allocates a new skb data buffer using
> kmalloc_reserve(), which does not initialize memory. skb helpers may
> later copy or move padding bytes from the buffer.
>
> Initialize the newly allocated skb buffer to avoid propagating
> uninitialized memory.
>
> Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D619b9ef527f510a57cfc
> Tested-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
> Signed-off-by: Soham Metha <sohammetha01@gmail.com>
> ---
>
> v2:
> - No code changes
> - Resent to netdev list
> - Added Closes tag
> - Added Tested-by tag
>
>  net/core/skbuff.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a56133902c0d..b0f0d3a0310b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2282,6 +2282,9 @@ int pskb_expand_head(struct sk_buff *skb, int nhead=
, int ntail,
>         data =3D kmalloc_reserve(&size, gfp_mask, NUMA_NO_NODE, NULL);
>         if (!data)
>                 goto nodata;
> +
> +       memset(data, 0, size);
> +
>


Certainly not.

You might wonder why we have GFP_ZERO ?

Answer : we do not generally want to pay the price of zeroing memory
_unless_ absolutely needed.

Fix the caller instead, ie root-cause the issue, thank you

