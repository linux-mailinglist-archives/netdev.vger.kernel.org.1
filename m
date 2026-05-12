Return-Path: <netdev+bounces-287233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G/aLA5XA2qh4wEAu9opvQ
	(envelope-from <netdev+bounces-287233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:36:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 397C2524D5C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BBE030793A1
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E753CF942;
	Tue, 12 May 2026 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+SMxoBQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1343CC7CC
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603468; cv=pass; b=n/vNLTlcgA8MVr9fFSUG+Q4MHTzd5O+/cnG/2VQ4bWfvf2ppliC+YaYfeJY0v6f74grfKnNnXRl8gS5voaGiB1faC/YRpLAoik1JHUBxxXz37jCIpRbHvsWcVyvvhibqI7/+QBWwZx98BOGdU0cdoPIIIInwEB73M+ZXhry9d18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603468; c=relaxed/simple;
	bh=KxbNz6KofZwplC6xddwMYtDl8wBQ5ksp1r4oiCLjhbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0UP5xRBntQF/vLPhjvWIZoS4oE0uodo1u3RMZi+DjaLPl+JgryFZ7qNCyMa1QsrX/k3ChWkW3gwwf0FpboeiTDpfLHQkZBG52L5+wwQwVDms8Nk+BXkkjc3LPOfspzuLo+RJFUuxupNCZVyeNsEqWl4XVSjbIWth2LJMy6ypIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+SMxoBQ; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bf0b1a47b1so57884527b3.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:31:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778603466; cv=none;
        d=google.com; s=arc-20240605;
        b=PGcdfDIN/5uO9MHtKZDhZHESvc3QSawF8NgZqNmXIJRJwUp1Afy5RVLaE+ioszuHiZ
         lm3uxLTEnaCD/6SqEvztRZ9pHoKVLuhrZfXhxO6Ir3f2cKJDGwO14nHxaDTXTbjd/k0d
         cRqsXyjxWyeu3ULN8LdRomfS0/11ErE3IRksgmpaJopXii7D4AB/22yVYosi5VHcyPHU
         ildYCQrRxNI09xNYN8hSCToxkbkdGhN2JO2IBIS1WdYE2ubkXq/7Lc3Rbyjx6Kv24/x6
         JvllJXWAuHAkNmsOCbZAYLJIMttYi2YeCWeYz15FjfU6ct6Hf3XNjIXuQ2LGrrYps5xX
         nDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C1AfrbvRUgp18Ab7cnHdWQ5A8b69jjesb+Ro7fndglo=;
        fh=28NkI4KDqQZk1lxc3U+PHZC5uHUBAPv+h8jMHfbSWU4=;
        b=eBCMld4BYX483B4szlnVq+LKhsEqFoCrY5Kh91saQhdMzDhDHmd4NPAyoRZxG81a0q
         R88XYCfo0TmLZT1yWpu+ZFbe1ZfF4eJ79Z0ASpngwU6rcQkM4WqwpdvD/fFy66oj42Fq
         u/KELT9wEf/CDxJke7Mc+86hGhorc/2fClxqurcZSJ4FbjG1yKeaqiHlSgnjigilwRBS
         7uS2DkizPVcGepiVeKUSPIX7LXusQjCpgC7OJRdQqDnclRUXK9a7fJJNonXWA7nYXsS0
         XmDHZ9spaw1ah2B83lUz9cyTFSjN/bByQQwXOjKs3kgoRgxYFSl8icFPClYa/kQVESI2
         T5lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778603466; x=1779208266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C1AfrbvRUgp18Ab7cnHdWQ5A8b69jjesb+Ro7fndglo=;
        b=s+SMxoBQ7C6qorzVf0W/cd6zZA+gpTtkBVRLCQ25q3kM+cFokeWSS7Jab7Kwc6yjjv
         Lzb6drpGvmAsTPJ5nDvVmGIh3zylZuWtW5pEC6ncVNzqTp3PCCD36AGzJqFFHE7rAvV/
         tFBE6wqU+4J+/1gnnXer0KjddGKc6clyKuvWxAgpCk17iu+wWypnZwNWDWVa3CphOskN
         2hra9tj5fL4q1v4iCaIfF5hHfuxI4F7Pu8ghY7ExgVL9J3GqGfvzER0J+gOchJaAl09p
         XbHefecYfVUB2d6PHwMSt0GcCG46IlcCyF7N1Y89I6KsvgeCsNNZVFmAWgPJ+Z1OxNMP
         Z7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778603466; x=1779208266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1AfrbvRUgp18Ab7cnHdWQ5A8b69jjesb+Ro7fndglo=;
        b=Lm7/SmwUHrOiw+2m6NfOI+2zPsw4CgQDtcxQ3wlfOb6DZKfD6F1u8UjK5J2UzFhchV
         D9gg4uvIYB4XlG7YFsrIjIDaD36TyNUgp3suCG9dfKVw5fTnqPNehDOSFyPyOd0W8pf/
         925eUH9xsa1LOUpdGdvO7Zi/RgQp9ev2SF6wWrizSLn6FfGRHbQbMFfmMIPvHMvcv0rK
         4295AtgKHkv0ZCZEkaSy/kD7cDZBRjiFajb106rSYmReJUaW9Ar+3SILePCRQJ3XwzBn
         a+WfFQ5dVrTO3uMlQPvp+v/tJL1TWWR1T+tE2wgswtqJkaLmBrtitiCGzp71fFG+yi/D
         YwkA==
X-Forwarded-Encrypted: i=1; AFNElJ+2lmidvnL1wJaARiBBZKrzwlkavWJveeBvGV1akILoD65hklfw/Z3RKdBKz7HQBYcWH/XvTXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfmfVENzeiuXXUUqmLzCAhI/oB5iOjccRUkq+Q58NTqd07fZFB
	Vdl0Ptw4RWL/c8Ml05iKwosF9Xvq/M85+LG6gSDQf7X3/7w/8osSIZrcEdA88/F2sp6elLTn2kM
	r6sRyDz+fvRniHv1ZJeyBNWp1VzLWH3U=
X-Gm-Gg: Acq92OEaqVwowBt6zoOGRXVYonZO9D0c5vJfzcq2DSBN39enLbn0fMjFtxQGsuBIoCJ
	o3pnaR2Zei4AlFWaYUdy/mhLNQrEymHDGPuPdKekCCmHDCEl8K6cQqzIGT+t3bhYwwcJAowOqJI
	N+0iF7+2lFEQuMJ7dhvWngQjBkrFpr5Cimvu0ucNa0nuRYpOmwDR10HGVt9/r7Tr4lYRuXkZkZS
	iC0YojzriNahOIjT3P12JzX7G7CvPmc2UpNVR1KwhRJF9Q9FpGETRH05pPNLlZOhGfca03lH/wm
	fAjGfDcy
X-Received: by 2002:a05:690c:c4d3:b0:7bd:6114:4002 with SMTP id
 00721157ae682-7bdf5efc9a4mr317364907b3.40.1778603465678; Tue, 12 May 2026
 09:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507095330.318892-1-tariqt@nvidia.com> <20260507095330.318892-3-tariqt@nvidia.com>
 <CAMB2axOFQN2f=veYgeJs+4tbZmb9PuNHk03TH_bmE8UL_REd7w@mail.gmail.com>
 <b1d3f9bc-a5d7-4236-8bda-49e6327ee533@nvidia.com> <CAMB2axPNhveQaDPs-ttu4uFcpvAfJCdzJ3d05HWQf4+p7uVUsg@mail.gmail.com>
 <70d0b319-178f-4233-b0da-9618489a1dd6@nvidia.com> <CAMB2axPdqBUORn7Qy35Xccqbn+8aArZ-weegZyz=j0STh+iPNA@mail.gmail.com>
 <6b7998e7-b2c1-4650-9564-679d647146cf@nvidia.com> <ef926d49-81d6-4d26-8d74-440d4a6bb8b1@nvidia.com>
 <CAMB2axN6USwsGaUQWkL52G=9V=kSe2La_gE-ppOFLWbPCnaVKQ@mail.gmail.com> <47630ed4-3028-4716-816e-d4f803423b37@nvidia.com>
In-Reply-To: <47630ed4-3028-4716-816e-d4f803423b37@nvidia.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 12 May 2026 18:30:54 +0200
X-Gm-Features: AVHnY4Iek3R7CeWvC2rdxFfQ-Vfu4nQJysvyR2_rH_vMG7nCcg0y19mJ0XmkmAg
Message-ID: <CAMB2axMOWSsYGyuXOnCQUrpCTGJa_Yy5mKOxErX7N2x3BTLKbg@mail.gmail.com>
Subject: Re: [PATCH net-next V6 2/3] net/mlx5e: Avoid copying payload to the
 skb's linear part
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Christoph Paasch <cpaasch@openai.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 397C2524D5C
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
	TAGGED_FROM(0.00)[bounces-287233-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[nvidia.com,openai.com,google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> That would work, but maybe with one less conditional:
>
> if (!len)
>         __pskb_pull_tail(skb, min(headlen, skb->data_len);
> else if (len < ETH_HLEN)
>         __pskb_pull_tail(skb, min(ETH_LEN - len, skb->data_len));
>
> Tariq suggested to make sure that we have an xdp selftest for this.
> Will take it as a follow-up after this series.
>

Sounds good. Make sense.

Thanks,
Amery

> Thanks,
> Dragos
>

