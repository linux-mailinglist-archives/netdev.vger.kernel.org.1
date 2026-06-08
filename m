Return-Path: <netdev+bounces-296428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HP7hLs+EJmrTXwIAu9opvQ
	(envelope-from <netdev+bounces-296428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:01:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5AB654520
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:01:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=P4qHLfO1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296428-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296428-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCCD8303DD30
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 08:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EE23B27D4;
	Mon,  8 Jun 2026 08:54:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B943B0AE5
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:54:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908853; cv=pass; b=gsQnBTUWrHJkLR/q1a8mPLNTvu0MZ3cEDKAj8ZqViWPCtuEx2SYabS1x4YVSWgNZ+007nRftH+yS2WnedLqJV9QcOM2sIEXMjlAkbsHeuaLsxQ0SWCVYfjcldjNZcX9iyv1zKkihNAsfmWAL0b2UTVZs3uBSOz2JC2egf0HB9HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908853; c=relaxed/simple;
	bh=8QVx45y6QyTBCVh+SAc+yQjvfe4xgdcmAH4VAii4y3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egyQ6eMrkzJQxtMKIkL2lf1mmi5t3Yftau60CrOqZtmGPCGRGr5/HJ9+mnZG+j8IO1+6Tm3w8S8BOT/dV2K9BWDXqKLZHLoyM1VMCZUepCPt+zgtH/rk5aS+nOqp17c//iNVUcirJpnIMGoGXoK5nVx1gShEsVD4O/Ih+bD75kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4qHLfO1; arc=pass smtp.client-ip=209.85.167.179
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-48677c167b7so1865915b6e.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 01:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780908851; cv=none;
        d=google.com; s=arc-20240605;
        b=balT8NcPmyS7Ol2bBasTYc8cVQFgLMINNiAh1mu9OAY45x3z+sLu0nNT+5WDrFrfxR
         wRLLh+c5nNHCBUUC6pCZqaB/FYVflZxKtagCXNNXbIhJTKQ+inckhSyvan1Z2gLjV5/y
         BQxIfJyArQNz+y7RmIH9ckAFHcLBWmKNMn7aiMpCtelwUGxJHX3eU1H9mwBWttWHQUll
         aFElSKlre436CmRYudexFIyZ79mNnSrMNL3W5lZmK1OlGC4uvjrRYIOIl+ZHbJrxmfW4
         djEiMQsclZqlewNJNz4AqR9gnT6tLTQC5WdnIixnmWrT6o3a/sFdL2jacE9AMyTCh9aV
         Br6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8QVx45y6QyTBCVh+SAc+yQjvfe4xgdcmAH4VAii4y3Y=;
        fh=IcWYDka7rrmpAhAVsmjvgloSxgcR/EOYzwzsm49aslI=;
        b=d1OC1leHI3xvvyymsFl9Om8AWQD1IaBpI1Hb1aVi5fB8LGgBdfB1hL6ou9BcvdCj0W
         V+Bt7Ff7fWt2rTcqsJ99U+PgCH8IBrzTQqlvYRQuwy/ITCGUyJcxV/+oH9oYICJ42UHd
         NGEK196vX7rMt0PBDXGzQpHTFjpjFuLnh6yNxyQpLXkM/s+azuOW1ChYl/N9QtVI+iq3
         0EIjqWDShVwLsIGatRfqvT5uwcEt0a1Xu3PSwZ1QbTDnz94j+s1Rw9c41aEMcwYdBTE+
         +VcUcmvUI6qKdpCDIookxP8VWuZzevftDtdwPTg+lJ9i2YdJR6TxHcBrFgYrm8/jEeEF
         LMyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780908851; x=1781513651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8QVx45y6QyTBCVh+SAc+yQjvfe4xgdcmAH4VAii4y3Y=;
        b=P4qHLfO1HlEEsX7Ms501MxKfRPgys3qGOUtyBBzsbPsXu5pf86+Eoyed+i4tl8ZXEK
         C2R1mqz8FSjKM4ZHILanVO+OOyeToo1d2V4QgJWhc0t+XkudN0cpa/rVTINTeuHD5a3p
         FTiVMcCMMLI6zUuO2wLoYE4FtmSWO5+ceQNHUfyolqtTnusrQXAKxPajK5hekItxmNHE
         fbrNDE1ybzc0NxmjTKF0E0Ac4SMPhUa26wAzH8Fj8avwjkM80zTyQYVU5eKZPrBFyG/X
         CK011MHZGZievnLgNaW93geAN9GhvcRQAnbIoLSTFwVb++/+R8oSnvbpLY7CFP/76cEi
         QvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780908851; x=1781513651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QVx45y6QyTBCVh+SAc+yQjvfe4xgdcmAH4VAii4y3Y=;
        b=B5huYyrf042aXiVn1dTIEAdtVqHKMjXG49pbPYk4CwAYh0NsQzGhWX3ZK6DjmdAfKo
         CTEkwAzcuIX0dMkD5NGEJfcDgF+YDKOqKTids7OjcbYxHcYIb7NZBMxMtpjOsB3d+pv8
         nQT/qdwh3Ji7LGVm6N53Tn96m4R/9PA20p8Xw76TgcjOWrtYsAnp/g5nLfeqt+ld2HAt
         pG2NUuLJYgAIk43XE3cv4Pcl/WSXHaWSrMseOHj02CGfiDRjb8JRRqgie/c648gc5usk
         iq5uVD5aGDQLwo1PAKdyJsl5qRZvJFhJZ1F0nUT2Bp7Iul7n0QmduI8Jdm6G1I5jYOlH
         ReFA==
X-Forwarded-Encrypted: i=1; AFNElJ/7Sjq6Z+svX7lyj+hQigy75P7n41P2rtHyw1d4qhzkdHoVoYB4rgSuKuFynCQYiv2p5n9Iwd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXO6OapVjfE7SHjjqC82kaxucu1hJqR81NIjjF9YQ1FbtL724t
	HByujSREaFUoR7HbxHxuuiCOykOfbJJiFRvhvlA1YW4rmrAKY90bl3UV7j8sqnProdksqosfKxc
	nzkGNC/tmswD+ar5zgXoDY5c4Sj1J7WE=
X-Gm-Gg: Acq92OG1ZFPpCtjjVXqaMEvfXnkd7fgpe2Oefw2yjGOtSxoGiyGy8ofzwdXwrqvJRJg
	1bwBYSDwLMURzZLuM0ZudqlsU66ALfInUlfv2yvYjrZueaXNmUNMARe1buiqSkF1ne2xAI4Fjpl
	Rcf2V0bWqrgNSxrxFW2DvmZ33S0UPQhIzD1ZQ3z5ZFGfNMMotuAp1zgb8EwPQ9olK95W/regcA+
	WejpqSemM8b/bo9xprOxWIYdJvs7ayrGkA0VnDZf3zrLQ81Syj/OrsaXgicM6VhXephhTpx243c
	BbXw4V+ULTXHx3fRhg==
X-Received: by 2002:a05:6808:10cc:b0:46e:c1cd:866a with SMTP id
 5614622812f47-4868deb1172mr8209073b6e.27.1780908851103; Mon, 08 Jun 2026
 01:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528204020.7ae744ab@pumpkin> <20260528223412.27311-1-kacper.kokot.44@gmail.com>
 <ahjHRB0Ohn7fpd-o@chamomile>
In-Reply-To: <ahjHRB0Ohn7fpd-o@chamomile>
From: Kacper Kokot <kacper.kokot.44@gmail.com>
Date: Mon, 8 Jun 2026 09:53:59 +0100
X-Gm-Features: AVVi8Cep8npgLg1pwln0GCs-DeX3qq7kqMO_6D31-1M9IkFc4dDZxjHiY93gBbQ
Message-ID: <CAG-Fur4ro0ktPiG7mD1YBkvuDmtCubAhPwHfKN7LrQBaJq5vKg@mail.gmail.com>
Subject: Re: [PATCH v2] netfilter: TCPMSS: fix dropped packets when MSS option
 is unaligned
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, kadlec@netfilter.org, fmancera@suse.de, 
	fw@strlen.de, david.laight.linux@gmail.com, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,m:kadlec@netfilter.org,m:fmancera@suse.de,m:fw@strlen.de,m:david.laight.linux@gmail.com,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296428-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kacperkokot44@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kacperkokot44@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,suse.de,strlen.de,gmail.com,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE5AB654520

> > Padding TCP options with NOPs is optional, so it is legal to send an
> > MSS option that is not aligned to a word boundary [...]
>
> Yes, but how many stacks do this?

None that I'm aware of. Mainstream stacks pad everything to a word
boundary and put MSS as the first option. The motivation is RFC 9293
(MUST-64) spec conformance rather than a bug seen in the wild.

> > This has not been observed in any real environment.
>
> ... then why is this a fix?
> [...]
> To me, this qualifies as an enhancement, if anything.

I'll drop the "fix" and reframe this as an enhancement including your
suggested subject line.

> This is questionably a "clean packet".

Fair point, I shouldn't have framed it as legitimate/clean traffic
being dropped.

> And "the kernel is not silently dropping anything, it is policy that
> would drop it" [...]

I'll reword the commit message to say the mangled packet ends up with
an invalid checksum and could then be dropped by policy, rather than
implying the kernel itself drops it.

Thanks for the review.

