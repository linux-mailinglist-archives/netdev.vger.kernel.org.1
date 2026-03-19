Return-Path: <netdev+bounces-269473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J24F9IMvGkArgIAu9opvQ
	(envelope-from <netdev+bounces-269473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:48:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFA92CD232
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3CD93055116
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797923DB645;
	Thu, 19 Mar 2026 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="ULRriVD6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AC93DB62D
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931625; cv=pass; b=fZ5niZUU4mBEFSDKu81ADsBm/4BZ+cCqEg5T5/FonQrGJU8uh7O5kKvmsqtVksYP5V7lokOH7Ql2FyRWJgHrUVroNaZ/LXzAJKW75AOI0SWKyi9NY8EUE5DKQTH+3jmyaDX9F4BJb2AToYSW8jUMVm+fTYYu/5dmCc5nyVVLJck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931625; c=relaxed/simple;
	bh=6C56hFSy7MSAtTfADI2U6E1TXW4zjREFlyaDALAZGps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gs9nL1S0zhEggB5BAM3Rn66aszcZRpshESP1xKP25oPZolM2s7CPH9X8q7LRvbsWJ4dkG27SMkOTAw0Uz5/4W9YlCFsRNX/w+Ct5O7GjgY6eip9NVudzOkGYACqFjF2V3v2Uhljx+FZ9DbPrGstrO4ytyy3aJ9g1qmbOvJNCcfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=ULRriVD6; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5674d8be45eso349842e0c.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 07:47:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773931621; cv=none;
        d=google.com; s=arc-20240605;
        b=J6gtyCsA/jJrTNtf3YAb3AbxgKwQRW7G14kAh0AtAPiKUhgTk2mC2Hm9fN66IsZiqD
         wD1/ilYZrDm6DvkDyLCQf2ozvDk3o2eqQvc5E3eSfKqRiL4MYtDn+1nIxcdWuoKuPEam
         nGpKgmum6scU7zrA58Zi2tN4Mnp78bRmwaVPe6bXcsDRPr0f55OVnRhSDLskcYH+byOj
         wympfIuS44Z6wX3dNg/r5TsPzgvoD/IaWk9jh8F7h8EJLm0a4rxsyscnykb2qI7lpUlg
         IQFUbt76uagOZ5BAZdgXl6pGda6my53cCR3D9DEfkmCMpO8P4SgTArkOK/MiA+E5tJkW
         MHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yNqdpR2c+svbUSnxpgB80U/rsisbq5oL2upr7b+1OVo=;
        fh=2airP/rMwVqkF9e+jQtto7zJPaHdVVdDS/1DPXuTAP4=;
        b=R3Y1gd1mZxPFVDD9YaJa/fqoe8AKrU81TMa/9WUGjQPeGRAWrV95K97ZwhVHnnXje6
         zUqXe68bqRBd7jKaIRdl2juKLVRRz33F26rXlPZ+4PJ7qZmi4Qw9zziqmsXyK1qLAtOL
         Vu5E35ftdy8Ixpw84NQJZWHVXbEjASVxv1CIHmWMX/5y1aYqwQYd9AvGcg83jo+3XGdd
         s3te6ZfJsk210PQrdAIUes2eKtWQM7Et1VcOOrW7bu/7Ex/RBhhOJN1noBjKJRJFikEO
         sPDzHjpMyrrGzYxRlMk+Q4Vo+0Ce5wS5loJk+6QLtYky5Fox2dihWmebric0pPLrRYAc
         Ljfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1773931621; x=1774536421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNqdpR2c+svbUSnxpgB80U/rsisbq5oL2upr7b+1OVo=;
        b=ULRriVD6+kt2pEd4OMmjzsVLx9w4t5J3Q80Ea+r1b9S7mL9i4IdrrMda+ZpK6Tt/oI
         moUaamx5mbaPF+THluHwCBeXTRmLviYGPppnG6wrETghKpbrSsGt9SbD8CoQAgBvvfIN
         HI0zE7+ub2ZLNalz/a6KmcFyS5nV4aYtmH4Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773931621; x=1774536421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yNqdpR2c+svbUSnxpgB80U/rsisbq5oL2upr7b+1OVo=;
        b=UWJWUx5wNjOBpYJ3w0po5gLp4BctZ814DgVCVS3T7sKVZ08IARupNLF5RXXST1PSmL
         xA36es3hBB2VyzGTa9o6RtCFmHQVaOcqQM7U3L8genlRg1dPt1jHzFyZ3oBw3joIXsGi
         vgSA8EN+kBeNTYJO5MU+VuZbg7Q0QZEKm+0G5geMDU9eMU8mRPBq2ZclnPa4VeGPSzQn
         TYoWmROcbq+bbOFxy91CRgb0cN9qnZIgwgttHm8pUUdq4isg1x2iA3Y8yIfQmWxcxpT1
         WB24B6eJQ6OGflabggmuH7VTvZ5HqSEkv4l1ISB/fAQZ9UmeTmCPqWIDWa3gXM2YnU6o
         02ug==
X-Forwarded-Encrypted: i=1; AJvYcCVpcueyNCyqpdjbGk1vA6qzyqsSxIljG0z2TK+cr2F17GQ7p9PxPjLWDPCTfjJa3OEzqxZt3m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFSZmx++NfpgNH27s37ZylxvXjLD7RuFJPAcBXjrnBDmAMEnWY
	hTfgqAttYCD5zVXZ4QPjXU78XhMz7vIK05DeqYFQdpja4Nwe0Sl9NQNgSKMJkZfsZEHk3Cc7qPd
	R1SByJBvNY6wkX6MUrTMIJyMTbW5H3HDiztmlRrC82A==
X-Gm-Gg: ATEYQzwaecR9jc6Mq2LZy5dnoOIY4DwuEcah97tELZXGYa2gwV9gFOmhbEvlRICSiId
	KlxnF0ULM7en8hfITQF2ilZG8S8eRIp0GFQwns+5WPMUyiBLDBOajKds0dTR0pZXCuqEOLgxEdJ
	XBnOxfL/yN/SQPzjGHyJ/HZjUaIbVt21rv2YJ54hfNr6xSYx8YDpvsWkfKnGUICp9B6mFY2JRGL
	CNTWr4uJU0Mj58fuiYXNNobgHbm+/9wDLemBNUt6aZ76O5b0ZEnOLlcxk997FAmSxXZP3Z6s29Q
	JYpNbiBw
X-Received: by 2002:a05:6122:d97:b0:56b:1042:a24a with SMTP id
 71dfb90a1353d-56ba71c0f66mr4309092e0c.13.1773931621340; Thu, 19 Mar 2026
 07:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313132327.409785-1-anderson@allelesecurity.com>
 <20260313132327.409785-3-anderson@allelesecurity.com> <3926716.1773872414@warthog.procyon.org.uk>
In-Reply-To: <3926716.1773872414@warthog.procyon.org.uk>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Thu, 19 Mar 2026 11:46:50 -0300
X-Gm-Features: AaiRm52hzEUn_TTKKooQtlYY-yLHSnEum2PZoGEv0Xw7wPqa0z6ZDCYD3rP6H7s
Message-ID: <CAPhRvky2eqK9+LS=30_4TjLDwf44TuEUaLWd-k1WJWMn9wnFfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rxrpc: Fix key reference count leak in rxrpc_alloc_client_call()
To: David Howells <dhowells@redhat.com>
Cc: marc.dionne@auristor.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-afs@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[allelesecurity.com,reject];
	R_DKIM_ALLOW(-0.20)[allelesecurity.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269473-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[allelesecurity.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anderson@allelesecurity.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.212.49:email];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,davemloft.net:email,auristor.com:email]
X-Rspamd-Queue-Id: 8CFA92CD232
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 7:20=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Anderson,
>
> I think the patch can be done better as the attached - and this takes car=
e of
> another leak also.  Can you recheck your test?

It fixes the issue. You can proceed with the patch. Thank you.

>
> Thanks,
> David
> ---
> commit 8e931ee13f267b814c0b668e9f52867b5239fed6
> Author: Anderson Nascimento <anderson@allelesecurity.com>
> Date:   Fri Mar 13 10:23:27 2026 -0300
>
>     rxrpc: Fix key reference count leak from call->key
>
>     When creating a client call in rxrpc_alloc_client_call(), the code ob=
tains
>     a reference to the key.  This is never cleaned up and gets leaked whe=
n the
>     call is destroyed.
>
>     Fix this by freeing call->key in rxrpc_destroy_call().
>
>     Before the patch, it shows the key reference counter elevated:
>
>     $ cat /proc/keys | grep afs@54321
>     1bffe9cd I--Q--i 8053480 4169w 3b010000  1000  1000 rxrpc     afs@543=
21: ka
>     $
>
>     After the patch, the invalidated key is removed when the code exits:
>
>     $ cat /proc/keys | grep afs@54321
>     $
>
>     Fixes: f3441d4125fc ("rxrpc: Copy client call parameters into rxrpc_c=
all earlier")
>     Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
>     Co-developed-by: David Howells <dhowells@redhat.com>
>     Signed-off-by: David Howells <dhowells@redhat.com>
>     cc: Marc Dionne <marc.dionne@auristor.com>
>     cc: Eric Dumazet <edumazet@google.com>
>     cc: "David S. Miller" <davem@davemloft.net>
>     cc: Jakub Kicinski <kuba@kernel.org>
>     cc: Paolo Abeni <pabeni@redhat.com>
>     cc: Simon Horman <horms@kernel.org>
>     cc: linux-afs@lists.infradead.org
>     cc: netdev@vger.kernel.org
>     cc: stable@kernel.org
>
> diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
> index 918f41d97a2f..8d874ea428ff 100644
> --- a/net/rxrpc/call_object.c
> +++ b/net/rxrpc/call_object.c
> @@ -694,6 +694,7 @@ static void rxrpc_destroy_call(struct work_struct *wo=
rk)
>         rxrpc_put_bundle(call->bundle, rxrpc_bundle_put_call);
>         rxrpc_put_peer(call->peer, rxrpc_peer_put_call);
>         rxrpc_put_local(call->local, rxrpc_local_put_call);
> +       key_put(call->key);
>         call_rcu(&call->rcu, rxrpc_rcu_free_call);
>  }
>
>


--
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

