Return-Path: <netdev+bounces-294767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vECbMYE4IGoAywAAu9opvQ
	(envelope-from <netdev+bounces-294767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:21:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72843638825
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:21:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ChEbDLU+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294767-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294767-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B6CD3092FA4
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1D543D50D;
	Wed,  3 Jun 2026 14:14:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B39743E9D5
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 14:14:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496081; cv=pass; b=NVQJ3QkWLnRFBOAO0puscjEqfPh87xVvTR4C4Ekuho5yANQxyWEU8u3CaEkqpBW4r8CmwmIBKv3YOYmomlerxyUxfkg1y70Sr86gbLShyCGeuyQ3uy7UalcOoiSGLt5dsyfjZ5xQYe4xrNibYRyBEm7H7AMFEhlRf7ZTKAmTgZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496081; c=relaxed/simple;
	bh=GVn5Lv9HKRp9C9WqvkbPPVBvO9kfeaXDD5rNKVVFxPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alxMmMxw1x/lH+PKyRPT4R9um52766rIpaRynIcoMMGMEAIYtcZGhLIW6XhUpEUMlfDon73WXfQDA+U5KUzbJaHLy5d0xGe41uuA+V8xBDJu3J/DUUGxGR+ZccXdK3GiBLtqK8s96Kx+7JdGcAI1ecqe78fN3iHHTw9xTJplGbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChEbDLU+; arc=pass smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-842848fd613so771819b3a.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 07:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780496077; cv=none;
        d=google.com; s=arc-20240605;
        b=UA6LZCT7Qfm2SzpPoQ8PFq/qlYa1eLp2elTr7V07Z3Bu/kONru+xIc14ze6lycscBB
         pIMjzI5/+3qqfPp1P51VSxDiizVsPsfjCEEeb70V4uPn4YRxFtAymUbW5nwjD4+0XXfx
         AtErQ6dMl/funsoXIgLHev+MYGO5BZ2PJHKEOlAPXOfuS23I9Zr5OWEwxg4HQ1dJEVu3
         cai2c/HnlG/hQh2lGq6UZ42VrTZQNIKHzl3ps1XJRlsDdlDpQ1g+bNQFnrBWSs6Q7qlb
         KzBJAN2JeLET2mUF3h0jpmEs0jFBX6lLdPWGnAJL//PDNnqY9gXln4Fg4QEZ4vbP+s47
         ZUHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g99l8PDbJRSNZV5R5cNDHmMYBg+Zr6LEVHFcaCRVgy4=;
        fh=cKqjYbQudL7VTBQLX5UHx1TmIiCax714sbG9kmuoYwo=;
        b=gZbCoPicZxBzdVbIkhCklytrpjdcCPrmAptqn7J7S9BkynN/GPpjEfaIVNJ4/qtMPz
         VLoG4gSmjQMDRliDY+mhJuMq7xWWeB3sbZ62HsKksFW6wFW7QqiKoVJArrS0jsvXJOql
         yfPgpgNwaIrrUFek63PlvgM5dLTrAxIm8AC2ysZeNmRJxUBq6milLEhsKxmHlSpMBA/X
         uqpOKHr72p8vLx/NkYuYepXkXAhn2rgQfuTxSqrw6jYYihpTQeqag54HXtR77KkdCSfD
         2qXuvxTD+NwgVJBWCaUCshYAt5ePWLSRmFnBJCwo6Up2xZ0MpxPF72G8VbPUFco0gltx
         G3YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780496077; x=1781100877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g99l8PDbJRSNZV5R5cNDHmMYBg+Zr6LEVHFcaCRVgy4=;
        b=ChEbDLU+Gbhog2WyQkkdBzqDo/wKb/dfJ60DPFTd/dxmv+UtYSTnxjC1TK6WeYXxuT
         aeqDQ/G3V/eHm5azlhzqxhB5KRJJv5VGm4ypxBDxICkmts6kgE7ws95F3XvG4BLRVEDw
         /01FhU4vUEc1RaPrsQObQ6vRZL2lWztlZESwdoE7tm/nbSFbEu+6XyiZ5I84Qz/a5/3Z
         dcRyzt7tRkxH/8XfeAJH9UNlWgFjcNI35MOGXDwaAW1McZqwEVmml7iL7NVOt260tnXO
         Y3+KDn4RJVpG8NUrHtY1YDHDc4T2ioyu129BycXQMjzif4GTi1ZZn69SzoX+VERMhLKe
         6/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496077; x=1781100877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g99l8PDbJRSNZV5R5cNDHmMYBg+Zr6LEVHFcaCRVgy4=;
        b=PHDP15NgXxF4oYjgm3Uv39IWqJbEy/4II2SOuEgT6BZwHo4l/FF4bL5puq0yx3zEWL
         4UG7n0KJX8Tag4fmyCJ111OPLVNNsglJm/3WvEBWOCdkIB7JkdpQq8CKvyKoGBcU0wdR
         3i2CdtC39bppUYwDMg32Ifz6XQWYbz7yyEXUi55btF0ihvp+esbpygjZpeGgvDq9nR63
         N0Ap1qVYs4FwWdeQsQzLubMdElUYVtAYON5GWLKrj3lbwLtEODeDJ49vy+gPhJ5uG713
         2/x5pd81xL7HXDuZqDgnlWI4yfAKxOzTh7j+HTRbeYSTZMF2iUwyaAj6nm58JRImRc/T
         4q0w==
X-Gm-Message-State: AOJu0Ywfizvwc5CmgXYq1ujcXTQMy+Ru4cqhktMe6l6ExvXzyU9aW7wU
	g6a3drvIqrMmio7PSQITSetFvATCPuVNnG408Uagyydxz3hU6X5I5fteHrWrPyCqzCsvtTBEZfW
	QuDfzTK6sI1D+CuH9eKZkghDEtTxgWmM=
X-Gm-Gg: Acq92OHBPU2RNBtXnuVivJ2qTnO+EDl+fPZ7bYKCPQzGAnhko24Cyf9h5G3/fVmxlFR
	Nq0yWVxWqLYjkAOm8UxNFTYxukvvdQlCiOXqmvD0AHV02sfyoux5JI3nJ5VjYkMJakFh/7qKfw5
	Dvxx7IRVTzOEK/rB7Xs5IPf9lI7JIU3NcT9A+gUrWxlS558AG3IDrd+y8Nk6JtUJrY9g286PM+D
	f+CbE/sv5oixYVltg7YLt7oF+/EKTOyA9NrXnCDWtY9hPcD+fbRmat48kuJ1iH+/QpNZ/AspVYJ
	WWgVfNKzoeW/6jcX/82MWW0t6MbtAeqnS4dW/7mr4lw4UPyeMygqlk+NR81wTBO9PhTdQtgAggJ
	2BmtJxOYLo3g2ylpxpW+ETNxBCYmFvTcXyHIIUJDU34Tv09dN
X-Received: by 2002:a05:6a00:1491:b0:835:366f:5da2 with SMTP id
 d2e1a72fcca58-84284f3f96dmr3416839b3a.37.1780496077086; Wed, 03 Jun 2026
 07:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780232930.git.lucien.xin@gmail.com> <CADvbK_fBbLCwY61HXsNeGCA8MhiBKcbvE0BvSZppohJgtXO+2g@mail.gmail.com>
 <20260602111823.0b1129d6@kernel.org>
In-Reply-To: <20260602111823.0b1129d6@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 3 Jun 2026 10:14:24 -0400
X-Gm-Features: AVHnY4LQ8snWAMk7idEx52eDDVjzE-lgA4L_Uyr30iAlUILJ8Ee2UHGsNH5YNQ4
Message-ID: <CADvbK_e7T=Yfb800TbO+BcpDEp=Sf6rbtiy2daLaskFAjeg=Ww@mail.gmail.com>
Subject: Re: [PATCH net-next v12 00/15] net: introduce QUIC infrastructure and
 core subcomponents
To: Jakub Kicinski <kuba@kernel.org>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey <tom@talpey.com>, 
	kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe" <alibuda@linux.alibaba.com>, 
	Jason Baron <jbaron@akamai.com>, illiliti <illiliti@protonmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Daniel Stenberg <daniel@haxx.se>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	mef@scarletmail.rutgers.edu, paul@jakma.org
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:quic@lists.linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:metze@samba.org,m:mbuhl@openbsd.org,m:tfanelli@redhat.com,m:hepengtao@xiaomi.com,m:dreibh@simula.no,m:linux-cifs@vger.kernel.org,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:tom@talpey.com,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:steved@redhat.com,m:hare@suse.de,m:aahringo@redhat.com,m:dhowells@redhat.com,m:matttbe@kernel.org,m:mail@johnericson.me,m:xiyou.wangcong@gmail.com,m:alibuda@linux.alibaba.com,m:jbaron@akamai.com,m:illiliti@protonmail.com,m:sd@queasysnail.net,m:marcelo.leitner@gmail.com,m:daniel@haxx.se,m:andrew.gospodarek@broadcom.com,m:mef@scarletmail.rutgers.edu,m:paul@jakma.org,m:xiyouwangcong@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294767-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,google.com,redhat.com,kernel.org,samba.org,openbsd.org,xiaomi.com,simula.no,gmail.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,scarletmail.rutgers.edu,jakma.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72843638825

On Tue, Jun 2, 2026 at 2:18=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 2 Jun 2026 09:12:30 -0400 Xin Long wrote:
> > Note: I've run Sashiko on this patchset many times locally over the pas=
t
> > month and addressed all the real issues it found. I don't see any new r=
eal
> > issues being reported on:
>
> Coccinelle had a report tho:
>
> The NIPA CI coccicheck run flagged a new Coccinelle warning introduced by
> this patch:
>
>   net/quic/crypto.c:1164:13-20: WARNING opportunity for kmemdup
>
> At line 1164 of the newly introduced net/quic/crypto.c, there is a
> kmalloc() call immediately followed by a memcpy() into the allocated
> buffer.  Coccinelle's memdup checker suggests replacing this two-step
> pattern with a single kmemdup() call, which is the preferred kernel idiom=
.
>
> The fix is straightforward - replacing:
>
>   p =3D kmalloc(len, gfp);
>   if (!p)
>       return -ENOMEM;
>   memcpy(p, src, len);
>
> with:
>
>   p =3D kmemdup(src, len, gfp);
>   if (!p)
>       return -ENOMEM;
>
> Please update the patch to use kmemdup() at that location.

Will address it in v13.

BTW, is there a public link to the Coccinelle check results?
I don't see them showing up on Patchwork.

Thanks.

