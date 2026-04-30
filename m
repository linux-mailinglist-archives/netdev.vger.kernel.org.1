Return-Path: <netdev+bounces-282759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM+XMwwr82mwxgEAu9opvQ
	(envelope-from <netdev+bounces-282759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:12:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 505344A0914
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 510BA301E9A1
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C1B3ACA42;
	Thu, 30 Apr 2026 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWH5Zasr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5CF3DCD94
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543621; cv=pass; b=qdkaY5BKbvfmkmvarXPkbsUU+zeyGnCzGNFfoXoha/6uJfWqUzWNc8Sg1I8q/8guQnjIwphNSFiIpwT6GY6kK/+THDhF65At6eGkqbZs6q0yRV2viGf8b/vlSL1z3LTwNaRN4tTgkNJJBzPqFcE3wmN/Crloc+MJdqKjnri5MTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543621; c=relaxed/simple;
	bh=Kyvgpw8dc+Zokvv11RDsVRqVEvvShTtobFoI32DJ6jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcKjzhj3d2K3tIU9/UrL0tEJxr4BIZlnNqTDUcKfopS1CCTR8aB8gVlCus5Vgis7A1xaX6bJXLiQJiTj5QItt7DLdU5WKTcPUVPfwY0oOIKM9bGaLuSQsmuJsoderZO3qtrwa3JUhkuPefckrfbnMxR7bGLpYpkLgeik+9D3xqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWH5Zasr; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483487335c2so8262015e9.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 03:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777543618; cv=none;
        d=google.com; s=arc-20240605;
        b=kGOipXWj6qYW/2asKil8crDfQbtwjNH7O4uuD5Jv0Tik+1IyldMKN5I17GGycx3Jzc
         TO+CgiYEzgfz/hqRaLiiFytavXBY0L2VqrpKkcVJmC3ic5tIEXrUgHXK2B800H3znPL4
         39gMOcvO+1YNu5O7xM4pW9kFkXx0QL3o98SkBd3B+Q5Dbct7UHxTVXzAWguLAbK6aWtr
         25B5I/JLElBEhto9k+7FX5ozlRNIXdjJnxHmJTYuzHfGYRMl6cXL4WLupNB5MNozPZDz
         00VW+teCGhKgsqmkv9ZjLg/OP1Ak1VfuscwG4sRvv+RNvA3Hku+lSGSJrg1/ITt2YiiL
         ryDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Kyvgpw8dc+Zokvv11RDsVRqVEvvShTtobFoI32DJ6jA=;
        fh=nPmLF21MbkZpg7BOZ/dovxij/vtfe8xPx2b+PxnREhQ=;
        b=PGEVNlmzu4RL9oxBj7JDaJtaJWcVFs7deT5+QDUpauzMBFxy1Nyu52+dyTQI/KxQXr
         /cogXKkAJbhS4a+imHF9LP6zzgVr8jNjcedZ6E/7kxzHCkscHrcNs1eaNOVYRNTR7eja
         ht1Ix1H7PkXli5wS2TUlEA8uZoNJ211xA02Pw31Ofwabtulhitgxp4xl7TmWOGwOiKoj
         KP6T7mOFz6LnNsplVc6n6l8ZtqcR6UtNW7jrnlshp7RznrcOMrI9W5AosANy0PRb60Ij
         GHgn+IKbdVuR3YbDnWtlrEXuHdy2AWiLzqrBT/qqVeBiFPxbvnU8AMQnh7p10xD2ZgXG
         hU5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777543618; x=1778148418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kyvgpw8dc+Zokvv11RDsVRqVEvvShTtobFoI32DJ6jA=;
        b=hWH5Zasr9qhJ764vlFS7lMMDRcKYOhbQeGl+nHGoaIKd+LMep7IBHAQT0V+ezw+II/
         AcrUtka3O1Oa83OrWRHei9M5TE/myPojJV4ndWF2nGXlFQWB1gPn5H/Bpsy/h2AcTS/t
         Y0aPnZz9ndgpcG9B0tpf3Bnq2i55rPEn7ig9Q7gCbmFG8CSFy8AfugsPqGV9JgwVwRJO
         ePwhjl4iZqXLwhPRGskY3R2d0awxtdcw2Xr7sQ7+Rb7l5LhazjhVctgNjkdTdiTEiQSP
         7LDYhr8ADn0K1vjH7qNyMZBzeoOcsn8QLv+DgVaiMHM0du5ey60CyQrmWWA+2Yx0vL91
         iQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777543618; x=1778148418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kyvgpw8dc+Zokvv11RDsVRqVEvvShTtobFoI32DJ6jA=;
        b=J+gzenbS2sD0lBqDRoIu6GCkRZZR9wsJBk8q9euxRVUxcjiIS+KnaTYZfj73wzDHyV
         YNnu/B6DpvzG/coLsfWBZHggP5qKhoL7HLQwGV/UAdtD5CXCnpkHAJNQC+RoPP2Xsnql
         i9kOnzZygtamiaSOvMWMxUnTre1GqFE7Zh00hO3MaBkPALNGPaNz9mQKWGUiH5nN2Wgj
         X2h4n27/eLtWRLHVszjCIGvdttfBfSDVv0Tl8BjLgdUN/myWv5cgQercvh3+CoWfLHTj
         FOwCNR/ClwYFPPrGXd/vhKGVV11zSu65q2+iz9NNyidbiq3JN2bVJRSHvZUahVgdajsQ
         6yqA==
X-Gm-Message-State: AOJu0YwO4SApEH9luOF4bbJ4ur5iYaf6sNg3ezdHxjRqNBu2vBk8J4L7
	woSfEAVMCA4E5X+SA4y1PFvFBiQ26ahuboKYTkpVCxq0l5yeiw+K3Xg5HzzrUTsFWmt2Iv4U0Vs
	zCAiHa4US9moMkWxsyyZ0VIjCSMBlw4QkPHzN
X-Gm-Gg: AeBDietegeMRycbQSC+GG3W9zHd2pGcl2f6Qxwf9FcjNAtXx7cqz1TuBmBgwQR3OsLi
	1uZoh0Y8V789Yo44rdhrYIcSmCR0pZY4CFQaPudMwGgh4iVkjoMIiWHW0tKSCx9rufXLKlH9hQX
	CYTRflrdayhpxj8ZLxXQ1T7s7PlgTwfaQRFiReO6VE3av/QOoZcfmBqDhrS85Wcfa114Bakjorr
	EyGzvXOR3zZzKaIOqxG2OltGvYe5+DkGuDCrMrsVbRpxVM4YKd0jiR22dSSFRDUTqjCmnuSn2Ra
	4cvqghI8Pz2xpn+/R/ckyJqPDyi+
X-Received: by 2002:a05:600d:8408:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-48a8452cd4amr28513795e9.24.1777543616751; Thu, 30 Apr 2026
 03:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110713.2550315-3-maoyixie.tju@gmail.com> <20260430011849.2345207-1-kuba@kernel.org>
In-Reply-To: <20260430011849.2345207-1-kuba@kernel.org>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Thu, 30 Apr 2026 18:06:45 +0800
X-Gm-Features: AVHnY4J_1Ckk_0_wc90cHEBhr1N2bAxmlonoBSKgk48Fyitc25vQe1jE3K00alc
Message-ID: <CAHPEe=G00_xFCx59KVRejzwJJVH0MkK4yB+7PFjHtyp+CBT8dQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ip6_gre: Use cached t->net in ip6erspan_changelink().
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, kuniyu@google.com, shaw.leon@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 505344A0914
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282759-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,gmail.com,davemloft.net,redhat.com,kernel.org,ms2.inr.ac.ru];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Kuniyuki, Xiao, Eric, Jakub,

Sorry for the delay, I had a fever yesterday.

Thanks for the reviews.

> Kuniyuki:
> nit: Please keep reverse xmas tree order, and you can reuse *t below.
> nit: Reported-by is not needed if it's same with SOB.

Both noted. v2 reuses *t and drops the Reported-by trailer.

> Xiao:
> > Fixes: 5e72ce3e3980 ...
> But why is 5e72ce3e3980 mentioned here? It neither introduced nor
> was intended to fix this bug.
> Maybe 2d665034f239 ("net: ip6_gre: Fix ip6erspan hlen calculation")
> which initially introduced ip6erspan_changelink

5e72ce3e3980 was the wrong anchor. 2d665034f239 introduced
ip6erspan_changelink with the dev_net(dev) shape. v2 uses that as the
Fixes target.

> Jakub:
> > While reviewing this area, I noticed a regression further down
> > in ip6erspan_changelink() regarding the metadata tunnel
> > unlinking.

The ip6gre_tunnel_unlink_md / ip6erspan_tunnel_unlink_md naming
asymmetry is real. Whether collect_md_tun_erspan ends up dangling and
reachable by ip6gre_tunnel_lookup() requires tracing I have not yet
done. v2 stays scoped to the dev_net conversion. The unlink_md side is
better handled in a separate patch.

v2 sent on netdev as a separate thread.

Maoyi

