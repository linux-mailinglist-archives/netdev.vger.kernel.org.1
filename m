Return-Path: <netdev+bounces-296429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RxcBDu2FJmoyYAIAu9opvQ
	(envelope-from <netdev+bounces-296429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:05:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB386545F1
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:05:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pc1lVOFh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296429-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296429-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF9C83060C8D
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511CF3B3890;
	Mon,  8 Jun 2026 08:56:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0641E3B2FD9
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 08:56:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909018; cv=pass; b=hLGGKgaEWm8uclQy2GSLLu/O+Xq7gj1M2LFbwc7L1XVbrb/2ovLBaZdRCPVIScDIm1vIiORa6GWimi3mtXoD6jbkXFk6fxTIiJiYYIz9BktX1yOF4RZ5xr84ML82q0MLLGxhav6PplrX4c+cae3QwN39Pwizu7iCOGbkNi+j4/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909018; c=relaxed/simple;
	bh=LwxIwW/8sD+a8dH7BmKDVm760AW1Qz08Sjhbp52fqyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEQF6dDA5DEBTS8JXddP0/eQgean0Ar7Jlf14h/co9fxewYIF2AEaEb0LOP2ETpoUJTHqBk4maVflkDwzz6h3chYFkrOCv8s0k+h6+RRZ167AZn9bdZ71ew9zSxzorx3xuKFz3wfFSvarXJN3rlb2X/RQ+W33HxtxF8YrXJGeNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pc1lVOFh; arc=pass smtp.client-ip=209.85.167.182
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-48650c78e09so1556731b6e.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 01:56:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780909016; cv=none;
        d=google.com; s=arc-20240605;
        b=TPO1fCm6EgKUJ3bWMOo1wKc6W+gWhW1uX1VbeDa/+hCQVzi74E/OOJAWrgW6re7cCm
         41K1yHvSuRdt8v+FHH5zNrdMUT5YVpsKKiYguZRk7r8mdEhR8YB/9aZNBvfJ0GlJDsRY
         gAxjiqfeVHl+pQeOd+pxmUZfmM3BgaCB2GBy4yQyA+iTWZwn7kwXCDnp8nkzXy+znrA6
         BLn15zDgQsCbxlWCo9UeOkKaATWchOTLKdNNFga1J5NAlTT1LvdDibXCONAjU9gl5kcZ
         UaVQ2GZwrLi7D/JZLa2MrtnL1Wg6BND5PjW1I8ivXdQVsIujKGuarwdiDCua79B7o9DG
         e3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LwxIwW/8sD+a8dH7BmKDVm760AW1Qz08Sjhbp52fqyU=;
        fh=VMCgeUP1QQDp4YbsFcItQVndbujB54h5iD2pYcRm1is=;
        b=enTgt1rT6oCN3biVXrfNoQx8Ek1puUuBMbTRkDjY/XnCHKRs6sGxgq9c3w/rxUZXy6
         h41otGFO4ZTO0T3yBvPLHFbATPiLL7bhsHHP0/0o+PhYy7ko5wrnEM1HlICTK6qDj4d5
         7lzzACxZxZwXyth1KMoeFkafz5gSGIiSzbXsva5yQvJ1dSNBHsaDmBAJaJzFjohS/3E/
         USUXMlAYMglQRHPlorSqZbu2W5qejhGM49uAlOxEYbWp/IUneG8c/DQda7SrN35Z7VbV
         MMiX4hS7EzUDAV4gm7e1mIaBs7QxI2kaNhtp8D0Xm1sh21uV5hMk6VscBh7FQzYP1aHf
         b+3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780909016; x=1781513816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LwxIwW/8sD+a8dH7BmKDVm760AW1Qz08Sjhbp52fqyU=;
        b=pc1lVOFhIA2nPuoSZWIczW+AJ5h4gwx6pvVWOjpY9jTYJ2x0YEOtTLe8FPKLkw7hW3
         B396OyIr3pS+LLP6t0aFtZtr6OuOgGyLeYoFVkoIU86ZmO7y8+qq3UKRydtyUqCP5Zur
         386tGBCVlMtLIFCtxZmV2N76+eQzB6bxvszzQEg7TOR3CD+nlOcW6pKKZ+IU7j2qRJpf
         WeRpbuLngiHA2Uq+bBODc/QHJCOielz/MmaIjrLKHlGFwB/OWy4Gnl0iojwPsm7r96BP
         iJsHnfvYZdaVbzeCH86qhhyTiCKjzN8fUySsLx9c2L7MlkqmRvJfKm4bvff9B1qxEXV3
         nayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780909016; x=1781513816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwxIwW/8sD+a8dH7BmKDVm760AW1Qz08Sjhbp52fqyU=;
        b=O6dle1UdSNW8tTRnb/Soqgdw6+rdzGjNbwwQXhivYQt0Evlk1yeEO/oUbntR77WT6x
         wzzrNV3+Dut96O+BWEwmLjbWG24Uza4DXEhrlpa1lK52v0yIZNN6ZZL3Q7G6VZybthWX
         1vLchKGAyihTB7Tphe03JVbvEp3UcZzGjTyq407LPW6bjILweuq7J/5nuyDA8jg6FvQE
         5RsqepQvkE2xFvzL32c2EUIbuSEwvM0QRt0BTlYj409knbNBxKe7QHJQy5yWVdvIn9eg
         c1lbZumBYu8/2tSGiDbC6q9wz/o5W60GY04umFBphA6GgfSGRYyevgOWI7tQSiJ5xHPI
         7cpA==
X-Forwarded-Encrypted: i=1; AFNElJ8co46Sqd0xL+qJ5bjj4bIemqmXD1bvWcbCf17TMWt2J1nejD09H2qUijafOgfdUlwixxrFMDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpATGN/P/HAhIzNYGTDRyZyB6F5uR8lS4B2NHfOMDhNoDHxI9u
	zrS9mKaiSxNO/jJhU4MRjX5HTvi/8cExW65e4/mhSiOnGlUhogPRooMY8cr8Ul3kN1NjtA/H1vZ
	d9Ihx1LjZjQ0mNYpEQxFd8lyrQEe+9AU=
X-Gm-Gg: Acq92OHSzwov0higaLplBDf5g+z4nxx7A6cm29IccMW/Z+r2kQ+kMx9R+qdeWRnqY1i
	DWhc90BeY4dn+aJjLzVy4QYCZH6MiEvekO4ASqX/8NUX8HaILkUOEQ0+5FrxsoWoZGzgcY6YwdV
	CpPlzHdvlmp1pr1oqZpqwdtO2CO6EFovX6PymitzVM9yEZK/5sx9lLDmoGuutYolNRFiWHAy69B
	ibkt+gYP/eJm5CPWwn+mId8QglmwQSSwgv9c9ZywkrlZPBJFVbq2tW0Rf6Wml8ut+4CWs7VNQKv
	6z+dEvmzTRXoKa6IJA==
X-Received: by 2002:a05:6808:c227:b0:479:d25e:9065 with SMTP id
 5614622812f47-4868dbf286dmr8670340b6e.2.1780909016021; Mon, 08 Jun 2026
 01:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528204020.7ae744ab@pumpkin> <20260528223412.27311-1-kacper.kokot.44@gmail.com>
 <381e22d3-fa30-4dde-bd53-705b4a868a90@suse.de>
In-Reply-To: <381e22d3-fa30-4dde-bd53-705b4a868a90@suse.de>
From: Kacper Kokot <kacper.kokot.44@gmail.com>
Date: Mon, 8 Jun 2026 09:56:45 +0100
X-Gm-Features: AVVi8Ce6zhPUP8TY7cm-36Laz2FamQqIli7a22X0jjY8iIAtnrJlrSLepV15u-o
Message-ID: <CAG-Fur7jEQQByhZQsEBVGi+TUdoh-Lrx_LZaSvaTs_Y7VGRBsw@mail.gmail.com>
Subject: Re: [PATCH v2] netfilter: TCPMSS: fix dropped packets when MSS option
 is unaligned
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org, 
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
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:kadlec@netfilter.org,m:fw@strlen.de,m:david.laight.linux@gmail.com,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296429-lists,netdev=lfdr.de];
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
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,strlen.de,gmail.com,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DB386545F1

Will target nf-next and switch the variable declaration order in v3.

Thanks for the review.

