Return-Path: <netdev+bounces-257290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EZJO8/nhGlf6QMAu9opvQ
	(envelope-from <netdev+bounces-257290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 19:56:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5481CF69D9
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 19:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9EC13010142
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 18:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500973093AD;
	Thu,  5 Feb 2026 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMv3Zw2a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E173093A6
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317773; cv=pass; b=rTPlKqbvi92tkxY4ve0am6Tn3n//xKCQEPBL/FQmIdvOB6HDM/ejxLtp8AcskrBCDAvlZEyBIY7C0ernOPg63FClMU4aK2rqUw7vpsUr2S0TohOnXufBI9swkgIZ/+BpzQn/1lOkwYW9388VmxKeukf4xMfzi7QJkSL5sPQdobI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317773; c=relaxed/simple;
	bh=UTAeTogqMPOzWsl43rYalxijcnMd4QsYh0uYCJzTId8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nz1sGU5clD8KZ3KqvuWwsgDXG9wiI8ZbQKAcGJ1Ot4s6ZtoFY4eAUjUWObSPZvzomATC2TtKr4gIIjNAcJYrYRnaZi4AuE/sqhhJF4knhiGi2x/aH9mmGdeidSYuOtQ5jRZIZWoqYfQvdxnoCD1HrLbjRJN8s8efaTsG4hJX71o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMv3Zw2a; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso687041a91.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 10:56:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770317772; cv=none;
        d=google.com; s=arc-20240605;
        b=BjY1/By78+aVRq3fpVB+o1ffiXWs3rHaORwKSu2M195mX958i0zYu44SVcciCWhX3r
         6Ov4qY+6PhJ7pp2lHvw3Xi+OMIV1KeVh0OTVLvKETIZm+erb1QTGMb9E4zqFQD+j53se
         oQyLq+2mfa65Eep1mohUol3s3LI2t72wGdYSEPcCTzki1i5h+pLtGyEkxNFPreQHep6a
         kytlsSw1Q00IAOmgr1hDMqo/HwxoqcOzNbZhDCoyOp2HzO73StjeQNw8j0UZX01p9fm+
         wmKQ+Wx9hlNk7weAyS9rCbUFSkU2cFUA6X2+bxFlBiQqc+goM+poXrMaFj912FsEA9L5
         IRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=80WFsFgkgPBLtk7OvSKjFaYy+3cWwSZUPkBNVljL2Sk=;
        fh=Og8+GYJxQS3UHQoSJmo5a1kiEAxrFF0MZgXzFvNY2w8=;
        b=cqh9k3drASIVmRB4XOQ/pvesbLXHpOtoLvMs64/aoTI039NXXNnqzNamwT61YB+tX/
         tHEdytXrNo2GHRmBDyhwLGDsELR9vb6sFLI+go64weVWJQejGd5mF0PaqdKUI6AaQSfp
         gyoRZ297VAWFg+xeKbGfaOdMjY81MwoMNatOhQug4mjotCvBzBJ1R4Etb5+D/DqFQCrY
         B7bb5BwD9tadbo15HzZpDIXLksnLCvCjMSZfCy19/pJTcrtQksBCBmx6npqYHJXGhzxB
         2OcuHdmePsBl9XVb80YW4DLvqbcBarTtJA5RqzVhmWQFfs2b9WmCdzWgknGiaXNollIc
         EfcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770317772; x=1770922572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80WFsFgkgPBLtk7OvSKjFaYy+3cWwSZUPkBNVljL2Sk=;
        b=lMv3Zw2a+QeA2cN8eABE/FT4y6vVlCp7pT3IoxX+Bg2ldQLofHOWSVw3WGKQk9i4ht
         nDuvNL/00V/K+mDNEzQ6XapgzytpieQk8+hxXxNudzjLBQHDUhM1d4olkBLORw2H06qK
         CMU1aaCnO1V6pQBfSB8dIdWR6HsP0kXkn/96LuwlMjftJxTnR1OvRdQPJh9b912lenyp
         JpZ1rsxigAdJO5tBdhaKWZ9HfOIdkGbkDhBEoe8mxl/iEyNjaul36l375PlvxuIwr0D7
         MZ81Q/xyWp6seSAdKhPeFCfAISKtQbhIKrtGd6OTzQXsqL4DlL1rcS8ZHtzCa56V4OZ3
         fD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770317772; x=1770922572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=80WFsFgkgPBLtk7OvSKjFaYy+3cWwSZUPkBNVljL2Sk=;
        b=rrWqzepj+JekhxGfGHGTt+hW08/QDtvcYSV+ar+bmtjbioQ1hf49+ZKdCPzlnAb3nI
         EtYSP8rHK1mOsCFKc+FG11l+Zwlc1Anep/jARCvcQRaKghuqLKC02G/4rojfMzL+U8o3
         q7dFaMizEReculKzF0x/ek3CL3UsZQXD/LtAitg+wOYioAQ5iLwdaonrF1io6u5wQ1Pp
         PNBexd85XrowuITXChOQ3+HMbRKvQazAcMlm5b167BChdPGvP8Y02lndhKraQ569hvMR
         fyIuID+wjYpfRICovJpt68bE31Hh+m5QHQQDDuDRpaHUoe0LgDnYoyKYjgS+Zqmxw/zf
         UA1A==
X-Forwarded-Encrypted: i=1; AJvYcCWXuRZ+J8F2TEo1LQEgSPrpB/ofxluE7nPyxu9mMKqEo8Zj/C7kXK3WqAT3XHe9kN4M6EW1Z5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YydEEuz+v3eF7V3LtL60AcyK4CGakO8xzhhFeS1on6VR24hPVdE
	jNCVm8/nZOQQj+d0XPgqC2o+d2VRs42cQxsDdOBKTA0o2gHpESnrMRoz7N85x0LCAz8sOfeGzSs
	kvg/eOTKOg+sQhPr0q08qP/6Lfqv5YqQ=
X-Gm-Gg: AZuq6aKSYGV4wbYkyG6K5iOIkaexcbPYia7RL2CY98K1uX5eM1RDxvN9+IAoHl6HxN+
	k7F9VAwaggrdlWiX8MDfo6tqSPH79L0MGJgA1ploxsFShhxX94bAkYiykLJyjik0UlE9BS05zVA
	4ykyCmqKFaYJfl23gOLle30dOpCHLiRqRbvsZsKL0sFPgnbOIDqJE+A5hjrfoqotK3wb8wE4nGi
	WeE14E6neJOFC7jkiI7Xjjr3YCQCOS0FIsUerYRX1vdQy96Rk96kwXhfnaAvesRvvJI8EfcTlVi
	emdvjCL6vUrM6yv77SiqGLBURkvD
X-Received: by 2002:a17:90b:3d89:b0:34c:2db6:57a7 with SMTP id
 98e67ed59e1d1-354b3c50bcdmr29630a91.8.1770317772303; Thu, 05 Feb 2026
 10:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d3a376cf555e7740330a50d83e6201c9084bff01.1770042461.git.lucien.xin@gmail.com>
 <20260205115518.2195328-1-horms@kernel.org>
In-Reply-To: <20260205115518.2195328-1-horms@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 5 Feb 2026 13:56:01 -0500
X-Gm-Features: AZwV_QhMX6JEvl213fgLGN4KP_FM-9zVeYTAxoLTMPmESDUtW4x9IOxJ01wxKVg
Message-ID: <CADvbK_fsXE6MkgF9KMVThTgsid9Tgkyjrvwyek9NM1jd0KZ4Vg@mail.gmail.com>
Subject: Re: [net-next,v9,06/15] quic: add stream management
To: Simon Horman <horms@kernel.org>
Cc: steved@redhat.com, marcelo.leitner@gmail.com, aahringo@redhat.com, 
	alibuda@linux.alibaba.com, jbaron@akamai.com, hare@suse.de, kuba@kernel.org, 
	tom@talpey.com, linux-cifs@vger.kernel.org, daniel@haxx.se, 
	quic@lists.linux.dev, jlayton@kernel.org, tfanelli@redhat.com, 
	dhowells@redhat.com, linkinjeon@kernel.org, hepengtao@xiaomi.com, 
	pc@manguebit.com, kernel-tls-handshake@lists.linux.dev, 
	illiliti@protonmail.com, xiyou.wangcong@gmail.com, 
	andrew.gospodarek@broadcom.com, mail@johnericson.me, edumazet@google.com, 
	pabeni@redhat.com, matttbe@kernel.org, netdev@vger.kernel.org, 
	smfrench@gmail.com, metze@samba.org, mbuhl@openbsd.org, 
	chuck.lever@oracle.com, dreibh@simula.no, davem@davemloft.net, 
	sd@queasysnail.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257290-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.alibaba.com,akamai.com,suse.de,kernel.org,talpey.com,vger.kernel.org,haxx.se,lists.linux.dev,xiaomi.com,manguebit.com,protonmail.com,broadcom.com,johnericson.me,google.com,samba.org,openbsd.org,oracle.com,simula.no,davemloft.net,queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5481CF69D9
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 6:55=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> quic: add stream management
>
> This patch introduces stream management infrastructure for the QUIC
> protocol, including a hash table for tracking active streams, functions
> for acquiring and releasing streams, and logic for detecting stream
> ID limits.
>
> > diff --git a/net/quic/socket.c b/net/quic/socket.c
> > index b86989080184..d6f25669c693 100644
> > --- a/net/quic/socket.c
> > +++ b/net/quic/socket.c
> > @@ -41,6 +41,9 @@ static int quic_init_sock(struct sock *sk)
> >       sk->sk_write_space =3D quic_write_space;
> >       sock_set_flag(sk, SOCK_USE_WRITE_QUEUE);
> >
> > +     if (quic_stream_init(quic_streams(sk)))
> > +             return -ENOMEM;
>
> If quic_stream_init() fails here, the function returns before calling
> sk_sockets_allocated_inc() and sock_prot_inuse_add() below. However,
> when initialization fails, inet_create() calls sk_common_release() which
> invokes quic_destroy_sock():
>
> quic_init_sock()
>     quic_stream_init() fails
>     return -ENOMEM
>         -> sk_common_release()
>             -> quic_destroy_sock()
>                 -> sk_sockets_allocated_dec()  // underflow
>                 -> sock_prot_inuse_add(..., -1)  // underflow
>
> Can this cause counter underflow since the increments never executed but
> the decrements in quic_destroy_sock() are unconditional?
This is a good catch, will fix it.

Thanks.
>
> > +
> >       WRITE_ONCE(sk->sk_sndbuf, READ_ONCE(sysctl_quic_wmem[1]));
> >       WRITE_ONCE(sk->sk_rcvbuf, READ_ONCE(sysctl_quic_rmem[1]));
> >
> > @@ -52,6 +55,8 @@ static int quic_init_sock(struct sock *sk)
> >
> >  static void quic_destroy_sock(struct sock *sk)
> >  {
> > +     quic_stream_free(quic_streams(sk));
> > +
> >       quic_data_free(quic_ticket(sk));
>
> [ ... ]

