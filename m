Return-Path: <netdev+bounces-289470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKOwEmRqDGo8hQUAu9opvQ
	(envelope-from <netdev+bounces-289470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:49:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E987C57FFD1
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCCA2303396C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F313348C7E;
	Tue, 19 May 2026 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXfxMHeS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E5348C5E
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198559; cv=pass; b=f8U/bHedVf4IkOv3JBgPMmmWV/rXCDxTsapupxTaD5O6b7JJuTrZ3uJuukvHA37cfdAe7wT34LYDniUmrhahvJZGCX6w2a26dgMAj65PIOTPXAxdVSBZJF3j9ZRAnNvIMjSgbetBEruyia0nogRJueGoxdpeDuQwLTNRiKVGrDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198559; c=relaxed/simple;
	bh=HFoVFgQLAdpvZLLN6NNZSQNrZkZ4IxaPxRKOQPNl7oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwEbo6HljjE2KFK5ROXBBdooqunm60TAJYxaaIJ4LFfaE4sI/XWEO6hPSdj8eZLJFoze8NAPfry2idsr9qxknBQeuvUIG0otTADDrf5wUKB3vIx3UWKJ3IsMo5MZq+DBpmQwVVYYmEciodhd5zX2UFJrLJVSMqrYuaIuPzyZl30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXfxMHeS; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bd3eb594960so453953666b.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 06:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779198556; cv=none;
        d=google.com; s=arc-20240605;
        b=k2phXwzkkjAxiWfNIv/nsj8YYS5rRyThcbVc/8osOkAIu0SPQnE5MMAGJEocn7u2Ti
         QocLY7liM54ZTRvM1UJpBXhE4kKSs3qq42UppAg1L3dONMzLegDweGUlgCiElOQ09VD6
         VCAfIqPJNaa2/mzRvUlYezzo9Ne/+CXW6RW758INaYVLrCLS0ftA+cNciEJ0M8UrcTFM
         jTDaIIyX6d2vJFyk3SEfAONb1hZK2RsZGfmfzc/VviNCnqXG6aPLwgEOtWSZR676DZAt
         ztpRMjtGDyroO80zBTAmRL46HylLVaEK9g91AJHZnqOLdOav68PJHs50ZuO+FelrNOZL
         LCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HFoVFgQLAdpvZLLN6NNZSQNrZkZ4IxaPxRKOQPNl7oA=;
        fh=Mu90KMv9PE1rWCn9Ti5Gl8Dtej/Ua1anwlUwBvepAWg=;
        b=afIBfvGhDHcj2GahOu9/poAEnZY0+7hZh8tQjDO/IMiAS0nHAqTAU+4DwwXvowxSP8
         WrGo/rGpGT0S+lUc6xqNfplZb0QIFYUYj9AaDrwBL4VjrxNLcFPvRhZka3veSuU8HmB5
         2Tx7Zac9QsxD0K7wtrVg+e/1eDJmzqtmyqG7g/zxR36ExuNMF2GqSGv/dSmt5Qeyf9Mp
         kw/vXjJmmqt4spelBwDHWOHfTyIHmPyktUzp9r4+1obhT8TRITSP7pT+Vw1UuFNQ/pgn
         S917DQmA9zxjQSrNRP1//581kBnRt+2Q+mo4PT2aHRHPkN8/uqj//MwZEdljMBhfWbos
         Ix/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779198556; x=1779803356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HFoVFgQLAdpvZLLN6NNZSQNrZkZ4IxaPxRKOQPNl7oA=;
        b=JXfxMHeSG/egb6VkzqQLBO6OXsvgB8qNv38yXWsB0fzeQLrMmnsdQOUx7IERvvPjgx
         d6OpyJ0CE/kN4jrNLXpC19wybA8b+NJtr73aXqNolzWAYefwzFr8YhqHuWgr3OFofxnW
         jLANquLG+P9VcLdVpL4xbo9sv9F/qs9OWwZ4vHzUuAsxt8VdK9LBw7ZCT/M1cGbBoRo3
         ySHYqsLFhuBZeToHfrhtbC0ygGaNSm408YyReSsUMc1g72qg8uRmehIvs5dyjJrIVYdU
         fyFc1ziagvpHe7gwuzJG4XZCyiCPbY6FTeOQDS/cm+3xd/YShV9FF2jTAPIPGTg6t7xT
         OyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198556; x=1779803356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFoVFgQLAdpvZLLN6NNZSQNrZkZ4IxaPxRKOQPNl7oA=;
        b=nY5H3G3/rZYGKRaerO06g70ATCq0fjLVgJuhJvbHcop8lCXCzGk9Rek/Gx/tpOHTrC
         h7g6UqYshbAoti0oPaUfq99sue4CgA1bDw+G7IXOBVQ/pb0eEKeL6Wrqqjnairvgzc3R
         l42x7nEiiJrf3rMI+4kSkm4gRb8mX6l+SFNCHK/Xx16h8CXwbQF3znAg6LY8U21B+9fD
         W1rQvNIKo3saXNzPCpz0P6SjSo8lwhzxUEDM09ucJXLjr9m/M5JLnnoHiz6zQSaIr87c
         SiSkIZ2xnmWhVr39tyYyo613pfU+T+eYD5mDzQG4GIFnchWa6/MjVeR8Fy4Iq6U5+kAo
         dY2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9XMY8oYKRnsJBPDYx8zSquBlcc3BhKnehBlZbWI+4DQW7NefYTLcuRvOJiEc77fIBuTBUBhhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWZmdTjwzn6eWbBsOe/8PGyYl7HCQE3I7PXz0/mqi/SdPbY18i
	wkCa2DCkDAomkOj16lDR8IpyfL1lECqBIykvxHRjfWUGRzsq9/9Kt6q3XMU6l/M6/GMZ79msAnN
	v2539VLSWF/KUWDAdyp46j/IabLZTCcU=
X-Gm-Gg: Acq92OF8CeOe8RP8wo9wpIWTb7Wlr49UB/ApwVLL3e8xjRYMcduwD5ThOsEVfvQDZLc
	ii29KDfxq+oxQb1CgKBOnIUlizooIijhVZL6TL6Ip1bmV2Dn44KndzXW5VMJU7zMQM/B72Ae3mk
	snKUVRZ28H75VrCGV0yy9MxinOLOOWxoQ7JAbX3X9iyYYhJ9o1LNyG6BempzI+g1ZQxjVUpYGS/
	bwdMZmIIeWQ/pAzSmi9ieo1PWjju7lKLopTcXLBHN+CSNoV/S5KUbHfUGkxj4ZJCZ8zPJvsbkIP
	Ub9QplVLMAgj4sMdHA==
X-Received: by 2002:a17:907:6d04:b0:b97:1d24:c004 with SMTP id
 a640c23a62f3a-bd517860e1dmr1095724766b.21.1779198556068; Tue, 19 May 2026
 06:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515130517.779406-1-dbgh9129@gmail.com> <20260518171423.2ad15470@kernel.org>
In-Reply-To: <20260518171423.2ad15470@kernel.org>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Tue, 19 May 2026 09:49:04 -0400
X-Gm-Features: AVHnY4KvXXBONArLZeiPlT9NpVhsD--fDBSGmRaxZj1zezqn8vVeAND9Cws9Pm4
Message-ID: <CACrCO_WK+gRhfCr8e8GvXJGqdHA9dO7xQ4fCynrufFmcLrYJ6g@mail.gmail.com>
Subject: Re: [PATCH v2] ipv6: route: Unregister netdevice notifier on BPF init failure
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289470-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E987C57FFD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Jakub,

Thanks for pointing out the outdated tree. I will definitely rebase
and resubmit v3 against netdev/net.git.

Regarding the goto: The reason I moved away from the goto approach in
v2 is that if CONFIG_BPF_SYSCALL and CONFIG_PROC_FS are disabled, the
goto statement is compiled out. This leaves the target label unused,
triggering an "unused-label" compiler warning.

Since guarding labels with #ifdefs can get messy, I opted for the
direct unregistration in the failure path for v2 to keep it clean.

Would you still prefer I use the goto and guard the label
appropriately in v3, or is direct unregistration acceptable given the
warning?

Best regards,
Yuho

On Mon, 18 May 2026 at 20:14, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 15 May 2026 09:05:17 -0400 Yuho Choi wrote:
> > Chages since v1:
> > - Unregister ip6_route_dev_notifier directlry in the bpf_iter_register() failure path.
>
> The goto was fine.
> You're generating the patch against an old version of the source code.
> Please use
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
>
> Or for networking fixes better still:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/
> --
> pw-bot: cr

