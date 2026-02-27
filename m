Return-Path: <netdev+bounces-262001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2+YbI14lomlJ0QQAu9opvQ
	(envelope-from <netdev+bounces-262001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:14:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA59C1BEEC9
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CD3B30D63A8
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B227C3E95AC;
	Fri, 27 Feb 2026 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDWXEEej"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594CA25B1D2
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772234075; cv=pass; b=JBxg24VzBahWKWBuhCsLbsH+5H2GudNI/TvmtI3IodQWi6xU8A1pV4SSzIiSZyDnCirFfpt48KMVSk8VY3n1Ix88KJfyUkci8xnbLBMC5NkYdoXd7iYOFOEiA4XQehYTbHpjJyogalG6btpcGbc2RnaOmc1k23B/AxtE6OsX4DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772234075; c=relaxed/simple;
	bh=J3b6vc+tOHAVCzK0au98UT//OGVL9k9k622Myb8Zz2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sT6YGL+PMNRAYjIj9kubOFTFUbzDjReAIDJ36nszFzwDNxgXaqZ0qsbKUr+TNybaCzWtRM5pHJPQN8ngjd/4q4PIVmk+CnCHdaGIMtHS6v/tvtZjNiuLceenWowLjbxLBLo3IwNzLmrWinW9J9XLmud0NXijpuK6I+DvgtbAvr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GDWXEEej; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5069a785ed2so66571cf.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 15:14:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772234073; cv=none;
        d=google.com; s=arc-20240605;
        b=j98nlUCCtNhqop2fz/2eN/2OvAACR6/LP+fP7sYRbQ7MM5vNdeivNn0/fII8cvhGuR
         X68JWCzHSSmYNw5nkB+huMURIgbtsGhrIEEFFN4SnXspQWAdAfeuWSNKc1M7PEd2L3hw
         aWEC51nrgnIOP1rgPlE3zzxz5spFCKMIWuhrIsLEczHLzoHYtieS5lEgW5pFB9wZZ43Z
         EbMILX9f9VBsAAcUFlejCjHlbfbUr0JbHUzBE2f/pbRKr7woQ7mqjHz8adVOR9nnxY0c
         Yv0bnWOb3cCwo93IcQTT4xmSAVkgqkwz6/5n25FSzYNzCv+C18iCKl8dtEF+0YjqMkZe
         PDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PHrjTZJ/ludJtcAtHqM2ccn7IPWxmV3xmjA1wISavJA=;
        fh=zQCiRxC0l1a62O8aUMqzYUPgYzfeYxm/OVAWi85QcMc=;
        b=AvGWL3XWepI1Gq8V+lIeArYfuSVhClcHdAbjg6acJDnHxxhU+Mesc1A6IGR7xHmP+Z
         6xFADOVXbdDXo+ZC/lBXZMMFk8EJ+k+d5sVjb4YplWn3C6HINSx5zq8lQR4hpucdL0jM
         B17n3gXpFOwSfbcZTgXickTAaL0RArtBQ9qPj57wPRBd8nYbsAmn9S2nMrtV4S7wTHkz
         OEqonOnh8HoH9he8Vg5AmAi028GY9q56SkzTnOo7L9u8dU8eEqw2+p/IkFSSdSZPP1KS
         qe7B1x26tp5D4r8p7Szqg7nxxKA9Cb3Vy8W48ZJUdpWilBTiPJBNC3BXhS/qCsCdoZr4
         wTnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772234073; x=1772838873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHrjTZJ/ludJtcAtHqM2ccn7IPWxmV3xmjA1wISavJA=;
        b=GDWXEEejVIsDx55vDy27p/EEaoligf/sw0MoQx+LgMZnjhVMGuHUejAL+CrNAZaXAl
         DKjITxB9KIKfZAaeUoUjdCZceCsj7Gy/Y2dRWiq79UoyIo/xgMVz7N+88evXIrW6Aikq
         QAGyhbd8h1W2ejJxBKwX594Nmo6nGnbtuGh7f1TDCne2kWoxav0vF2D15YAzyU1DSGvn
         QD/mpPqsGZ/DdRMOj6WoRR9/mEyC7Rc0lyRTmYADO0clfU4EXBgbJzPD/ExanUYScE9j
         9c78zGWxLqSKlIqhELkRf1bNisPl/KjmWfpxm3lQJmzZjS9UWHBEcTucSbTr35VeeT+y
         67ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772234073; x=1772838873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PHrjTZJ/ludJtcAtHqM2ccn7IPWxmV3xmjA1wISavJA=;
        b=Yakq/cX9G3Kdcw4lhnMmWygaqGozw056+kftWbYJKGdkwPRfTFnrU3BnJh+MKobscl
         R++HdfGGQWJy7qpv34MoRZYLiQ7ziZSf8euo8/qVUF1btJFNzvpZilyd4wWIugMVk1Ur
         txpTHuLMfXbqDymVMTJK8HsvUQyqZSQOCXFHfyHtYwxANGExxwNITz8oy+9+ndi/9yDa
         C7g4GdwS/q9cJFPgSbscc6u4/irxm+k3UwIdCjOMpTFPKGvM9GAM1u61Av2DKBoKP6cf
         7SOUS1pmNuSsXL+Ol4Lm2VSG4GMPK5cfs74eSa1gxHpzkJX7BY97/YQhRBkyNU8ZWQdm
         NMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqByAiTbdFWxHG7h6xJwaAUPGjgxtK89c7oMrvHEGh0740KSyKJyZBwXr/YBIWt/b+C42VfIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywNbxcXQcpxoz2l0/8RK9m/MmxCZId/me+wuggjPmBEV21/jwA
	I61UGZeKj83WZWMzlRMW+c/fBGUZsgpf5w2KhpiABShKcAaMpHtbk8b067mKpHj1aNLQ0j26i/S
	d2IhL5vjv/JxCDx+1W2EsyZR6KcpYTFtcPf+aAfUt
X-Gm-Gg: ATEYQzzG/EnGS1jicR8UUaVYMRfZoKVN1/UvrSYlwfjeZxMucyqXe/4m4MshpRhmTfU
	rQliwjWFgadtBpe83f3nHqg36Jt3LR4MkhycR6OZbKZ12xXiEtISs6Fw2twbO+TbDgOAZmctvWV
	o00F+dFlHGlqx8OkHCjqVQJc45SQNH0sePLEj1twaTRGCoxp9poPZik3GdDlSLk63+D7RhosMOt
	FnOacmPjrgpF7kGqV2yMKktEZLdLIsCVZMG/2dr1FgEh6pHX4ZRVEOUTT0rUJBV7iBq0f58R8yD
	3op+5A0=
X-Received: by 2002:ac8:5dd1:0:b0:501:3b94:bcae with SMTP id
 d75a77b69052e-5075fe651d3mr2304671cf.8.1772234072872; Fri, 27 Feb 2026
 15:14:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769509130.git.antony.antony@secunet.com>
 <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>
 <CADHa2dAxVFQULCKnsjSmSPrK+VTJyyT-5P5BAYGdhO5wKDKqig@mail.gmail.com> <aaF_SAQj4WT8jRaO@krikkit>
In-Reply-To: <aaF_SAQj4WT8jRaO@krikkit>
From: Yan Yan <evitayan@google.com>
Date: Fri, 27 Feb 2026 15:14:21 -0800
X-Gm-Features: AaiRm50RfCsDRdNp9ozDLxsAZSi7IdFQviiBLjcP_FPn4UGRHCUZCPnuyQUOd4Y
Message-ID: <CADHa2dCF=Cq2SMYgjHcs71VedwYaDmUXPWnNbv=46+11Mz0otA@mail.gmail.com>
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 8/8] xfrm: add
 XFRM_MSG_MIGRATE_STATE for single SA migration
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony.antony@secunet.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chiachang Wang <chiachangwang@google.com>, devel@linux-ipsec.org, 
	Simon Horman <horms@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	Nathan Harold <nharold@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262001-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,linux-ipsec.org,paul-moore.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evitayan@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DA59C1BEEC9
X-Rspamd-Action: no action

> Anything that we leave as implicit copy will have to be "forever"
implicitly copied with this new MIGRATE_STATE op -- unless we find a
way to pass a new "clear these properties" flag (probably via a list
of XFRMA_* attribute names)

That is true. I also have the concern that if all updatable attributes
follow the "omit-to-clear" pattern, we lose the extensibility. Thus
ideally we should switch to an "omit-to-inherit" model for some, if
not all, attributes to ensure that adding new SA properties doesn't
break backward compatibility.

On Fri, Feb 27, 2026 at 3:26=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> 2026-02-26, 17:44:51 -0800, Yan Yan via Devel wrote:
> > Hi Antony,
> >
> > May I request that we also support updating the XFRMA_SET_MARK as part
> > of the new XFRM_MSG_MIGRATE_STATE message?
> >
> > In Android, the primary use case for migration is switching the
> > underlying physical network for an IPsec tunnel (e.g. VPN, Wifi
> > calling). Currently, due to the limits of XFRM_MSG_MIGRATE, we are
> > forced to use a separate UPDSA call to update the set-mark. Supporting
> > XFRMA_SET_MARK within the migrate message would allow us to update the
> > addresses and the routing mark together in one atomic call.
> >
> > Regarding the logic, I believe the set-mark can follow the same
> > omit-to-clear pattern as XFRMA_ENCAP and XFRMA_OFFLOAD_DEV.
>
> I think this raises a wider question: clearly definining and
> documenting which attributes need to be explicitly provided
> ("omit-to-clear" as you write), and which will be implicitly copied.
>
> Currently it looks like we copy:
>  - all the crypto stuff (aalg/aead/etc)
>  - security context stuff
>  - coaddr
>  - replay/replay_esn
>  - pcpu_num, if_id, tfcpad
>  - dir
>  - mark
>  - extra_flags
>
> but not
>  - nat_keepalive_interval
>  - offload
>  - encap
>
> [gathered from a quick read of xfrm_state_clone_and_setup + the
> definition of xfrma_policy]
>
> Anything that we leave as implicit copy will have to be "forever"
> implicitly copied with this new MIGRATE_STATE op -- unless we find a
> way to pass a new "clear these properties" flag (probably via a list
> of XFRMA_* attribute names), but then we could also implement that
> with the existing MIGRATE code.
>
> --
> Sabrina



--
--
Best,
Yan

