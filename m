Return-Path: <netdev+bounces-284526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mQ72KIwo+mngKQMAu9opvQ
	(envelope-from <netdev+bounces-284526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:27:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E7B4D2001
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41636303C4C7
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 17:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC83492190;
	Tue,  5 May 2026 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgV4WG+j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E9148B396
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002056; cv=pass; b=DGlw2dVJ9E4URcv5gaT1zaUZId0YLKlFuCqyrEV7MItMCsPim28gQaRlO+07cEkfNKpU0y/jozatzq4XuiGkBH2JlLTzSwb7PpE8cQra8KE+jDDnWDD9BMvWlVjaY3NUXT0CG3YoOvcvSMNIKrATS24YrJjYuoS6+B4KqH6+GT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002056; c=relaxed/simple;
	bh=f+efIPeUKdfIiWlgNNEiH37rQtUF/aq9z44dtIoJzNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoC0stU9jw1ksm/7D+X+VOrzC0gmYltZfOuJaMUlWk2IecZqoVhClT9YYUg3Uh0O2s0HMirWuUyjeibR4mKE/gWCDh5AEEe04+gg1lqycc+vBIVot3JHB1GE9xKr47+V8iIBo1XcCult5ungBNP0rmpAJW2c5avPM3SsAfB5S38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgV4WG+j; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6967080e6c0so3091276eaf.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 10:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778002054; cv=none;
        d=google.com; s=arc-20240605;
        b=jJMn3YSjkkBU+QmqSVZtLov6yCW7+TyF6pOJ/hLIb9FA90jKtfPAA2bFpbPK2LnpMq
         XjfLDGlmy8ggcobQ7MaDeS+wkMF8DGAIo03HWbkh6KUn/0RKzj3Pelb56EQFIYU7vPAh
         iT8TlEkEEGmR6vfr2PwBspr4vEUqhZnf+/Jh03aQyhG9LlUOMBRYMAQKPEihwvTTz/2T
         i27yb8CCLUjbevEUJwALs8Xy+cdy2fQjALDcWw4f/IdJ6qk8FVJi9OoXkrI3j+ojbvzB
         Y/asIuZvQ10xZN9Jy8a9BO7SozyFlzaFlI5oo+QNDJdsXVPbHSIvHsq65YCwW/wmonk2
         Nosg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f+efIPeUKdfIiWlgNNEiH37rQtUF/aq9z44dtIoJzNs=;
        fh=vLqzn5PRRqwKdT1uYA6AeltjeG1FBDYPbflhG5vFoLI=;
        b=LNdw8pSlOiKLpNGq+kYXNeeT4udD4wtRMG2MqPZh3FS9T/c0xxGLieIJcxdbR9eigF
         Je1Pvq7JKRQXb2LTWwDaMudFWOoKCOHi49kHnnMRPx/aP0bPJltMsIdysG2LTcm9gLfA
         tAFNTknX57dxSgZ/CkAlwdI3+q2PGasUoDs/J1T80RCGBHfJK5V9Deg7Vs5jO2bJbLqQ
         ZApWlUn5wPMBkvJ56UD6P3pKSmdKEL43P+WWouiKOx8MH5dJyXkkoWLUvih+sK8JdacD
         3jLwHFugfXYoKD6aQFHjHA7Y04gGTEKMEO2HxXupTRciZx49Uyi5fqLcRQq18UCIP6dw
         W1pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778002054; x=1778606854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f+efIPeUKdfIiWlgNNEiH37rQtUF/aq9z44dtIoJzNs=;
        b=FgV4WG+jHuGVyacpzeDgRYbslkgo/ercjb3DtDAxF/CrXsjQAD1z1z9tvfKbLyYPdP
         3Xsn111K06gNsT6wP/MRjz2E37e9bRSVWJLfCeT1tLU666wZAs41ZynOwyAceO7owJl9
         x/vEWRRrJ+wCdjKdAvOcjD0fdCvPvlgwM2vomFT9o0DevXXhxFiKKz2ljZkpK5qv6B8P
         xBINm0y1gQbHK2K9p91/pC9azZKDnakdyYlx7CCF7mgDrTmZBzLndjk8p7Y51/xcmafs
         ftO5BAKKAmp11w3wiUMZZysA9F9ij2PdBn3PEcRcs/uFuIvqpVkeFFhv6raCxdXIbcGU
         1cIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002054; x=1778606854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+efIPeUKdfIiWlgNNEiH37rQtUF/aq9z44dtIoJzNs=;
        b=c35LDnlbExCkmkiZLuz+vYzzZZA2CA8IcLkYpjjqCtojJphRHCL5tXKv1uSN/edfLP
         Rsgqrk0n4Zw84OoxouIaYErYNtPi/YyRjybkELjX/VsFERO1imiScdnEMTIsatDUFlNI
         Ofv/JWt/NadY4wMGoMtoJw8KWaSNZRb9fDwxNuEqsLe/qSbctBF8ot6cWNqCoDpsZrjY
         41u07ijJB1PO8lFTacOpfxNF0qnYgWxpRc1xD9zqMgPCDcu4XkQr9iNFsI4MHJm9vhZR
         QpoqJ/dirgeubB5P5QsWQeEB/K6gd3cNl+r7kytmO8dblNuIDZuFG268KB/sofrsTQC1
         4QOw==
X-Forwarded-Encrypted: i=1; AFNElJ93ZRSoXJ1SQa8dWCDJNJkxJUGThU3d1t8HWlRV64SkuAtFi56MlNitMnA32rEk5ia1L6RIyIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0m/yeOxnpNAZ6D9f8Qr7i2YUIirmVMBSZ2IfVED48yU4gHhzM
	RTBYYJA1VqpZW7OeHXOBuF4OuwKLv70e0dp5BY//z45+YE8+QnmoGnQovVw9j3XI60c9MRXGtfo
	xS6LMAJlRmGdwCE33mFPmFI/+OFo+le2xuruWofk=
X-Gm-Gg: AeBDiesHD6RI/wuzzaeOf2yHItSSJKpk772E+naIgBpmQPCLUMZ/wNl/jW9jnh3oXop
	sG3+xkIgrMYS5neu5uwJm5mbxZQzx2w7pVSViCDsSD9YM/SIJ1AnVFm2ULjqJhn1xFqIwYpo3BZ
	nFCbpBRun0qUN2x6512CUjo7Ar3uJDL8hwexSQY8azoqUV8Y8K+Lem7CcygGU+51OjUoKogdfFo
	aKdPKuhHXxuldgB3HQMg/tBu93hjUv89ZwFiR+qP09IvbCCHPBPMax986rYD1vm0FMT6aci1mRu
	3ZkHOV5ozwpWS89wvLI=
X-Received: by 2002:a05:6820:4b85:b0:696:806e:fd6 with SMTP id
 006d021491bc7-699981880c5mr254882eaf.40.1778002054192; Tue, 05 May 2026
 10:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504152712.76305-1-h3xrabbit@gmail.com> <afje62FxYMuTUpSb@v4bel>
 <afjpqNXYFVfZjQl5@secunet.com> <afjrqlBPSv0X9kaY@v4bel> <CAF3ZFefQM5Ud8iWDoKV9FPdZ=8V0KD56Bvkdcku1fmm6aaD_Cg@mail.gmail.com>
 <afmDOrObXxUC7eDt@secunet.com>
In-Reply-To: <afmDOrObXxUC7eDt@secunet.com>
From: Hex Rabbit <h3xrabbit@gmail.com>
Date: Wed, 6 May 2026 01:26:58 +0800
X-Gm-Features: AVHnY4JLdwPiv3lDlp0M3vJV6vzBspcUR0T_3JRY7QGHulQsg67KIUk5MKHjve4
Message-ID: <CAF3ZFefJ5bzfBpE94kc5nsY6Ngf13YXv-9jXjOrS-GJFz6WJGQ@mail.gmail.com>
Subject: Re: [PATCH net v2] xfrm: esp: avoid in-place decrypt on shared skb frags
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, netdev@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Simon Horman <horms@kernel.org>, "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 00E7B4D2001
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284526-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linuxfoundation.org,gondor.apana.org.au,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[h3xrabbit@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

> You reported it, so you can have the tag.
>
> This is now applied to the ipsec tree, thanks a lot everybody!

Thanks for applying it, and thanks everyone for the review and testing.

Best regards,
Kuan-Ting

