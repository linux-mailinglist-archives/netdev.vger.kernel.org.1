Return-Path: <netdev+bounces-269206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDCIGvYnu2kcfwIAu9opvQ
	(envelope-from <netdev+bounces-269206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:32:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D26FD2C36D5
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30CEC3008D6B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3649A37DE9C;
	Wed, 18 Mar 2026 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="BSKyRRlx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A67F25F99F
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873074; cv=pass; b=m5UFSijfpFJPuawXPEun769pG+EoOM6xeQe3eGJ9LVR+bL1IM33ZBvlsRGv14o0yfCRCJ2OWHIWd715uLf+/tJbpb7wZuxkHMkYhPRR5ginDcKDTrDd1wcN33XRlJ5+hCWjMUXlBFmklx5UyqK0aaqNKodwbYJQDwe0aPFH/CfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873074; c=relaxed/simple;
	bh=VrftDIFab7sCUT9/iPfd+5q0s64yCVTiv/EOY6E8i/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ye0/U++5ess4vuFgWDFbL7HOyVUxU2GL8wSv3yGBAdpgXSZZ3pMv8DQhv0XMkoC60uS5Qje49v3Am+1OaEBogVra/GilFQrKbMwS+bLXoi+/TZFBUhR7EY5ytnGmyVXP1FtS70akw8Srsd69eeJ9wZUZoTLOTEgXmkutYVI1bsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=BSKyRRlx; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56b65ffbda3so49956e0c.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 15:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773873070; cv=none;
        d=google.com; s=arc-20240605;
        b=bV8TFsc0wZwoaRSzSfjnU+0rEWPLSlCERXc4nTrUYvgilenrbJiyQ0n6amH2+IuouG
         qjvdtDXNiH/TwyQbsYtsMZSYaMy9DgnhO6tbUDHQ6oUiI5yYv5gj4nVKGbt/j04i2Ypd
         MQ5nQKI9+DPge6ajKmhOBkMsgYD0IVWDRVbQqO2pKigq9QAKhleHgrvHtc/4SFYBvL6k
         C/D63xR2lDb0GAZF3B4GKOsx+dK7JBFYVVWwfKnrrTowMBmgbrOH86APKhauCBJv7MEf
         FYLz+vxxS2GVYDpI/2yT2a4NP2NLxacYjvUs2GDTzQt/ppf2eZTj4wDrUNazGRfgTzZv
         goqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vruYd0V+Oi1jf8DUsp243E5lP1TRHYTfIaGB1CoHpVg=;
        fh=QyBP2AVpWy7VgiWlc/zt9HJ3vU/comdjvfxJF18leHI=;
        b=XsSp9uPjbPYs3qsrAObnfV57Jud4j9caNKpx1OI99rNYIqIXH29RrwdX69AUjXFQwQ
         J9EDUtx2xDDqUGn+7utwbiqTspNgGTnFpwSzFXM3zgFqoYx2+YbCsiK0Y6ZJEoChUB8w
         wJN/f5TMuNedM2ZvGUGbs91L3uLvXJ4q3jJfcHeMc9Ctqea3p5M0TF9mCynJlV0MNMOb
         0obATBcBklXU6UF6MaeV8FEcVxHOaY1y1jdBxrOULi9SRNV5je/9FiFORCgcKiBYM8iX
         ZZwC0CrFECDnme/dXJngdv4NIrtM5ko1iN/bLag/hnsWENO/EdcmgeEozcNYG4vzBqMC
         mUDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1773873070; x=1774477870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vruYd0V+Oi1jf8DUsp243E5lP1TRHYTfIaGB1CoHpVg=;
        b=BSKyRRlxL7T4zzT1yGImA2lAyMus7iFk2ox+JYqhU1TnfBrJHbDWfpsmCqO+qhcXap
         O7PomyrLvkug7C7MTcO0Imv6hr3UJhsIWO85aPKQX76ixEbNpkUY6/S8oZHWn13AhL7d
         K5HOkJMixYKhaUzpAF1XDG2R0awjMia9jyBsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873070; x=1774477870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vruYd0V+Oi1jf8DUsp243E5lP1TRHYTfIaGB1CoHpVg=;
        b=Rkpnbuo4Hrg4q/wU4LUEQW2n2ke4dw9/kfuH3dLzA11Bz9k0352adkS//PUTdY3AsZ
         ugjV342jwZGFtmZXPEUpjtgqwlOZy1mOS2mSKXeBthobAjs2EvZildSy/ruHsEere3q/
         pXJP97Y0EFws0q/xFpTRVyuTj/jk/OLgjELXIbzMz5ZKLqPbuxAt3U97dAd5BpGaSt8M
         fW1iCSgr/YzrP4VdmrmYAJW5TG2q51eXjVkXkQrnXxJ/ipqaTAXD3fKgBuAwNFx2Wq+i
         eC2aVjzhlyqDwXQUnnqIzeylP6LuC7jN6am+Q+X+0y7IprDYxnpxchm/PqFyXFH2RFrX
         Cnhw==
X-Forwarded-Encrypted: i=1; AJvYcCV7GuPg6j+dBr6j8IiUuppXDrhHJDIPHOI8iu1v7UWywvlRMVs2mXerNv7Hx4NIqIogMSXON+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YydGzX6HFm9zlUiub6xNkJHKAMSAcIDKLkxZUQlVThwWeDhL0OA
	nr4sweKwo+ol9E9UxpIXYZpqkNhht4QGVsckfzMHh7kgQEmJ5hWTj2X+ISiZg80P+ID6YW8PMXW
	fMwyrrKW+D4YqIMZrLp8bsQTpZG3l9AfExa4xbzHLzQ==
X-Gm-Gg: ATEYQzx4CTqgQx7RzFFwjWMRxOb+mN8qhd1K2JQTzQtfl050Kd2D0ZiGmyUm5D8xd0J
	n6uFFQ5EakXs4Y26gNmGAyKk8LjJJyENrSq7WDnrmiwd4V/HC2d9MOd1YjrPiJ8encrHkRm9B7i
	UvVXao2M2gR7AR1CFVMDpjmiJivenDfcqTKWNShJyASDjf0xzGuoU8Dw8+U+aQ9WCARl7CQp4Rk
	57tdkNp9rtVvGkn7bAN52it2sQMFa5q0gHmgsvLs2cAWuG2XOwdU4y0WnuwdCz2vAvtDYxQ7CFl
	kWa1KG4j
X-Received: by 2002:a05:6122:660a:b0:56c:c71a:e0aa with SMTP id
 71dfb90a1353d-56cc71ae487mr1835609e0c.17.1773873070539; Wed, 18 Mar 2026
 15:31:10 -0700 (PDT)
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
Date: Wed, 18 Mar 2026 19:30:59 -0300
X-Gm-Features: AaiRm53BB0McmU9duyeOy4jNLaqUEgQmnN7deUMZLHNQ_ENfdKrkhnKQzqCIywA
Message-ID: <CAPhRvkzpU=DeSLvzR2eLHmvX0z4f-gY8OfKq5N_pJcDq3fgOuA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[allelesecurity.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269206-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[allelesecurity.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anderson@allelesecurity.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.212.49:email,mail.gmail.com:mid,infradead.org:email,auristor.com:email,davemloft.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D26FD2C36D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

That sounds better. I will test it and let you know. Thanks.

On Wed, Mar 18, 2026 at 7:20=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Anderson,
>
> I think the patch can be done better as the attached - and this takes car=
e of
> another leak also.  Can you recheck your test?
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


--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

