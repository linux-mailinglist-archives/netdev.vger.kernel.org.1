Return-Path: <netdev+bounces-54024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F29A805A1C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B29B211AA
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F5F634;
	Tue,  5 Dec 2023 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UvBsFx+8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416E1197
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 08:41:02 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54c79cca895so16302a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701794461; x=1702399261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KYuKDd43mihty8rCENfkyLSyPMUXOf0NuMsF2cC2c1Q=;
        b=UvBsFx+8TxLRN0RT7keZP3llVew5qsUEKO2IcxTrmbBGHgPazqOgPYZ73lWjpNLbDM
         GdA0ZlV2LC1uJEECClukfXOhvPzeKE+XUaE5fqQw18NWPiWozyy9mHDVNHq1R+T4IE2+
         8+XMTjqvdZaPTB6CSxLPH67A2zZwOlAi90kU/Dj3VGPBa+xMfK0M+UIplPlZrRlAJrd6
         6BvDfus8SZ6t5wSPhVOtPrREELiRmmf0vBAqheH7V61ezEtAMv2fxiZ+KP/rZ8HqzSxs
         yPMSseIl8qeXVurlUGX+RkSy8YTEhAjdvwXrqQug4rSdd8kQ/OAHTy6y8j8pt1nR1eSl
         aepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701794461; x=1702399261;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYuKDd43mihty8rCENfkyLSyPMUXOf0NuMsF2cC2c1Q=;
        b=EUYxUYdD7s5BdaLZMg45AFt4qfX5QIFkSQx53AuxFr3fqnarhWP1u5nxr4pDPntgDO
         MaTOAPNL8eEhGcauNhFShF3Wx+chxjwrhFMiGKxOEynmxh4V+YxnzXycOxloq8JghRV6
         qmdDnDWx+j5tIR7KUOdIkI0WflNIS1JWAnoC0qV63ZzFKJ45q2LWsiIieM7FABZho3LK
         WFKeptiNFKWnj6grtUy93GkmNrQzB1c1vHt6FyzHdEWNJ02//7uu8BhZb8OokC+gz6bi
         xxOTrLMn/sMP8ltWNRXRtrJTx/eQDodESJAcoAD++lHwBDNJOu7C84essxdvlmxJGIZ7
         C1hg==
X-Gm-Message-State: AOJu0Yw7pKdMx1wfvJ+7xsu26OHVEh5r76B521xtq7u9zbbrsabJ8Tdh
	q2/yNUEOHkw5xc/uSSUbTy2AAfvZVIwQkmQmk1YXIQ==
X-Google-Smtp-Source: AGHT+IHCjAZiAv17BXpDTX78OHWhWz6GbTngg3BDsw35myKX6WSmaekm/BpBH09gIC1zDSuc5zcO9cjzbIx7QMQwxOQ=
X-Received: by 2002:a05:6402:22c4:b0:54c:f4fd:3427 with SMTP id
 dm4-20020a05640222c400b0054cf4fd3427mr207622edb.7.1701794460589; Tue, 05 Dec
 2023 08:41:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Tue, 5 Dec 2023 17:40:24 +0100
Message-ID: <CAG48ez0TfTAkaRWFCTb44x=TWP_sDZVx-5U2hvfQSFOhghNrCA@mail.gmail.com>
Subject: Is xt_owner's owner_mt() racy with sock_orphan()? [worse with new
 TYPESAFE_BY_RCU file lifetime?]
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, netfilter-devel <netfilter-devel@vger.kernel.org>, coreteam@netfilter.org
Cc: Christian Brauner <brauner@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Network Development <netdev@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi!

I think this code is racy, but testing that seems like a pain...

owner_mt() in xt_owner runs in context of a NF_INET_LOCAL_OUT or
NF_INET_POST_ROUTING hook. It first checks that sk->sk_socket is
non-NULL, then checks that sk->sk_socket->file is non-NULL, then
accesses the ->f_cred of that file.

I don't see anything that protects this against a concurrent
sock_orphan(), which NULLs out the sk->sk_socket pointer, if we're in
the context of a TCP retransmit or something like that. So I think we
can theoretically have a NULL deref, though the compiler will probably
optimize it away by merging the two loads of sk->sk_socket:

static bool
owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
{
        [...]
        const struct file *filp;
        struct sock *sk = skb_to_full_sk(skb);
        [...]

        if (!sk || !sk->sk_socket || !net_eq(net, sock_net(sk)))
                return (info->match ^ info->invert) == 0;
        else if (info->match & info->invert & XT_OWNER_SOCKET)
                [...]

        // concurrent sock_orphan() while we're here

        // null deref on second access to sk->sk_socket
        filp = sk->sk_socket->file;
        if (filp == NULL)
                [...]
        [...]
}

(Sidenote: I guess this also means xt_owner will treat a sock as
having no owner as soon as it is orphaned? Which probably means that
when a TCP socket enters linger state because it is close()d with data
remaining in the output buffer, the remaining packets will be treated
differently by netfilter?)

I also think we have no guarantee here that the socket's ->file won't
go away due to a concurrent __sock_release(), which could cause us to
continue reading file credentials out of a file whose refcount has
already dropped to zero?

That was probably working sorta okay-ish in practice until now because
files had RCU lifetime, "struct cred" also normally has RCU lifetime,
and nf_hook() runs in an RCU read-side critical section; but now that
"struct file" uses SLAB_TYPESAFE_BY_RCU, I think we can theoretically
race such that the "struct file" could have been freed and reallocated
in the meantime, causing us to see an entirely unrelated "struct file"
and look at creds that are unrelated to the context from which the
packet was sent.

But again, I haven't actually tested this yet, I might be getting it wrong.

