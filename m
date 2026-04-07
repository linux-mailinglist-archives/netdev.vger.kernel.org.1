Return-Path: <netdev+bounces-275932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEtaMO/Y1GlxyAcAu9opvQ
	(envelope-from <netdev+bounces-275932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:14:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F278A3AC9E5
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 392003067CBD
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 10:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1565E3A785C;
	Tue,  7 Apr 2026 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwoKSoNV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B753A75A0
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775556596; cv=pass; b=iH05n3cj/fBJcGVGxQa055NLTzidTEL2MCBi9PvBZwLiJUxiQUdSWJF57lkkUbuca81SrwYw18AblXIXhQq5fpGkP1qoq6WIgYdXrXMEIJiQ0PBmYYA+MRmEjtfMLRdpzWDmIoc6BKJ+oJvVmpedM1LQxKJ4xxjxCvke/g4u1J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775556596; c=relaxed/simple;
	bh=yTe0ZsWQUcqnSTenPfmBFO2lcdAP7LdXzRWRguKXHnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiPM/3XSsWl0Uk7j6w5bFtaKh5xh6hyr4N6hMDUWswkXsKVQ6Eucjcn3qLRWLTxb00NfBZhWx90EyRA7+pvaqT4CciZVOaXhF7TwItgKpDRjldG5wJzg1iUOIN1iQ0cChFJqJPBrrH64jzv5pUGSYuqOZR1HMpicVbWwTMY87jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PwoKSoNV; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a05c388b27so96374576d6.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 03:09:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775556593; cv=none;
        d=google.com; s=arc-20240605;
        b=gtVYXXFu4DLtqvDMSdYjK4VtEi8h3k+j0P9YhPy0u59ochIPOHS/i2dHMfHtN12AYj
         UfxqKby6kDNw9vfjrkQnMqPDJIeUHzQq50e11HQE8iHb0+GTXicfRaGH97FICneasvW9
         SnwkVIXnr2DBNXIt/asLECuAjQca9bRcoRheeH2kQsSwbYSUMXYqW5omOGIrRLgDvHrI
         fJ9MFtMR6+o4sXbpB+IVdsNz10INneDrD6Ry+FX3MmfhGR2d50ZrirLgsag3ODoYytTS
         p97tNNEUdjQ8a/CrMIiUzSah7KgGYh0nGnkvopEDQ13oTZMUWfUZA4E2UwjlUWG/Mkht
         QhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F7TRvlsMeTACDUDeOChc+A/fLcBTuW+qY6F4I5vEPik=;
        fh=SrajrCg3JAbtvKVj2SCiMxeQkc0OEnwzNexWipp4BZg=;
        b=hhfsLWv0qQfZ4EvZf/PSLGZAtOsoqCPqvURdp4GNTkgk3YdCCGT7Aiwp6iFzOuIxRq
         C3oRbrshCJJ1zo1lxhExyf2k4zxGwTu4ahoNmk4KZfT6bwvNlACcKfWE4SG1bQw5tdEl
         bdZS1OfM0Kx8lNhzQCXcqq9YXnResYkwIHDTXHm0VbjYf9Dao8tJHwOJHR0YhtekFLEI
         wNueuoC4pk96gzZPxZH6MdpVHNOnBj4Saa2LK4tdk3X895RZ59lj1QtGL6IwZPTilkZO
         igUfrQEfuhVjW7XZI7qySZJQGBLeBdoYraMSoA2lM96DnLYjovniJ7rZcriWGIbjre19
         Tibg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775556593; x=1776161393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7TRvlsMeTACDUDeOChc+A/fLcBTuW+qY6F4I5vEPik=;
        b=PwoKSoNVMAMnQILrujR5x1S9WehMTJasDF5dJ30vEYrAVMdjsFVnm8+cFozVEo5k/c
         No0v9ca1Ft8AOLSMYgbq8+KlgpoMxateKu/OrvDLtxkd6uGR9K5uqQcwxz4Jg04lNq81
         cIw2tgJgMyWh7DVTtBR/QbFzlDiLCmCIXPNwLbqGiJz8t2TxYnB82U3+NUmN9yYbzvp5
         3mIBZ/TcEUc5LwEUkNSWZ/7zeTLVdOCfTPrSbY+BODu1nZSny9Y1MJgYIUCEqYaYx3w5
         xsTwNykfmfecIlVSCHRJ+ieUEH+UstPtLwJv6SBoqDD6FKIiM4Tc2FewueVyE28CuNig
         0o9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775556593; x=1776161393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F7TRvlsMeTACDUDeOChc+A/fLcBTuW+qY6F4I5vEPik=;
        b=c2ZQHzwT0sq6WjjULX5XyKUPKTFsx/2PlWpk088410344VNUe4NmzQ9Alc7aAkelFm
         E911E2V4Ua/szMwShlnZ/o59/WFRe/0ThYB3sUGbRuFKGBZKvGJSUy44eUd6SufKFhV4
         VQ9OIMDlRRiOtw4CNuu3oBWo3W+ag6f/s4h5rsatFGwi57/H5dPe/K02KE9rg3Z11q1m
         w1+L7txavLxpU/F7orMr3bh75uEqIXyMmTgOlNFVRQf2WTOO2dNuMcuaI/f0giS3tGcM
         IBbFUBqYTBGXYd+y3QirMxH0J0lM4GDzFBaUCC36sC8Xy5/PjRucDlmQESA8cZAs2RTz
         6LTA==
X-Forwarded-Encrypted: i=1; AJvYcCWZWg3sBqPGr/PC1nXj+a8QaNNqYwkTvyrocg8VA9eqJuZBAKvji3erbMQEhXye0yiPNnMbeH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjKVQ8pZ9dvAFn8V5vGx362pwVLhvvHit/3xw4xcYh25puvb4l
	rG+9uLXuuTriWNMWuqu3cu3MqC7+5FUIeIsBQCdJvsZxue0+pBHJuKUnWH/7xZv3ewl3vSLn3/k
	dfGV1dkWlUR+7/SZw4O47Pc1Ubspo8DxPSyPV+HAN
X-Gm-Gg: AeBDievmG5J3gE00pXCE1AAxPglW37d/+l3c9rvMEBavV3eTMcCGz6m8aRaXwb/Kps+
	4ppnhZZ4ry2PjnD9ftWUmu122xGE6Xv+jEiYKhNld6ZqfwpauBOOV4JrAq98v4KNPJVRYFzSaIr
	F/LNmwXV6EssC9uE+TSMv7a/vvfKAwCjxswRIHH3segpDLegDFRpq6ohtf1UA6pXBGNwdYH3VL3
	t5sCEt+sXWMqF3bgYfT4pwK9hxQeepvD9EXI4X59GpmPQlTYUZexP/sX4VdCpQDCvDcm6paaQ94
	r/QTcHh5JS5lU7w=
X-Received: by 2002:a05:6214:d09:b0:89c:dfa2:b348 with SMTP id
 6a1803df08f44-8a7042f67bcmr291885316d6.39.1775556593023; Tue, 07 Apr 2026
 03:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403022443.3480770-1-edumazet@google.com> <20260406180254.5221a267@kernel.org>
In-Reply-To: <20260406180254.5221a267@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Apr 2026 03:09:41 -0700
X-Gm-Features: AQROBzB2RHsuwhIKwzCygCKER6t6XTnCO169XYCFmOMmILCvHkBE7ZqUdzqJA2U
Message-ID: <CANn89iJeijaiWZUeGfXUBBN-JjWRfB=afrPXP9=PH_vPSU2s6w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dropreason: add SKB_DROP_REASON_{BROAD,MULTI}CAST_BACKLOG
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,lunn.ch,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-275932-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F278A3AC9E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 6:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri,  3 Apr 2026 02:24:43 +0000 Eric Dumazet wrote:
> > ipvlan and macvlan use queues to process broadcast or multicast packets
> > from a work queue.
> >
> > Under attack these queues can drop packets.
> >
> > Add BROADCAST_BACKLOG drop_reason for macvlan broadcast queue.
> >
> > Add MULTICAST_BACKLOG drop_reason for ipvlan multicast queue.
>
> What distinction are you trying to communicate by using BROADCAST
> vs MULTICAST? Funny naming of the functions aside I believe that
> in both cases we're basically dealing with multicast traffic.
> Reading the code it seems like macvlan has some optimization where
> it delivers the frame inline if the multicast group is not very
> popular. And if it is popular it schedules a work (and calls that
> broadcast). ipvlan doesn't have the inline filter and calls the
> deliver via work multicast.
>
> tl;dr I think the drivers do the same thing just call their functions
> broadcast vs multicast. Having two drop reasons here is actively
> misleading?

My intent was to differentiate ipvlan and macvlan reasons, some
deployments use both.

I can rename the reasons if you think this is better.

IPVLAN_MULTICAST_BACKLOG

MACVLAN_BROADCAST_BACKLOG

