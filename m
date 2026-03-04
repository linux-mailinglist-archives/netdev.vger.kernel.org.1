Return-Path: <netdev+bounces-263557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lefDGciZp2ksigAAu9opvQ
	(envelope-from <netdev+bounces-263557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:32:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B32BF1F9E4D
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9204F30ADBAE
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 02:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04769231A21;
	Wed,  4 Mar 2026 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdDErDu9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF888156CA
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772591546; cv=pass; b=LiGQqO5+fD9R58LytK1AoB1zuQNJ090/cGE1RtOENtpL6YU3fic8oaj8SblHnZu1JvxQop7kcrrPVM/mAPzFIEK/Hw6aRXJ1UPkYq6LiNBHLaZnCJWtVx+eVBrT49SIxCajhHnOy0Ynkm9czWanBdcXoaap51AccY8yXfiJ5cAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772591546; c=relaxed/simple;
	bh=385i/kPB+XlIWUAVHsdZSyb/MjGFpDiy9NBCsT3hWAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+eYYgHhMFIcs2kBnJq41y4TXjW9a2zO6cm0MCah3PiFaP/R3PdV5pzd+OYQfAmutq55ixyMkFqRtO2P8OhADCLPfYyH+1XuikUnco8rLhn/K8YVpex1sp++uHKLFVY3qMn0hIQe7w12kz3S6Bvw8z+bktBwLGdFltk8rgCE2vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QdDErDu9; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7985d11da10so63952467b3.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 18:32:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772591545; cv=none;
        d=google.com; s=arc-20240605;
        b=RG1Djli18j9eZJOSLELS31Ov+WY1qCCBNVMtYxdeRY6SitXFaK304J8CJVJTerkq5w
         dR6CKlqlIpx61S+wGA1IS8rAaKCVnBFAzu5vIZl4mrwchFcXqqojyT6YyiLfCUmuUKM3
         0ouTHNLvyZG3GQcM4ubmD+0XLmxqJjXPXSuKf6hf2R/qIWtczo8d5uDERt3gWRiAciPv
         cSarlfOI5BrG82nJEg47ggW7yo5wX3FCMwc8t2vzv2AFmWxdoPtx8xyF2hc+DozheNLX
         rGxnJt5GKaFUsyBsDboKqiyhDjmrxS8WYZ80wX6KpHwCkSyZv36nQZ9TpIVvRhJwB/Kv
         eywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aVFKngS4QsksNCfquBokL9Dtn1zpW7vmmFSQXbqv5T8=;
        fh=hOQ9fWDnZFlNdxRZPnd2B13vybdgq7J4FnrSR25e7qM=;
        b=GzwGlObiMD/e+mUB9xlzOv4aYTMqHuEb2PmaOSM1AM+iea1QCpVpqD+r+mamBJsPhr
         lRpMLALo1E9oafE98dNyPWwitbJCG9mPr1HLkrJpSSdJRMOEjJzuAglDJuRVhjescPk3
         2U0z/DeyQtJiqmBsPd9kDwcB0Jo00Vf52lmrlaNjj9xHHIGFEk5dGc4dbuvBHPyRniUI
         zAMEZ/Kd9JBosR8rX13QzCNubozG8kRV0Jd8weD1eEoQL8sEeCJipWZh7uJiOo/7pRNF
         UBvqsrqs5SCCYC6pKqCHJH5tFZ1faGplJBbH2skDvdVUTa9OQHpgv7lHZ/X54v66cl+f
         67lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772591545; x=1773196345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVFKngS4QsksNCfquBokL9Dtn1zpW7vmmFSQXbqv5T8=;
        b=QdDErDu9PeXnanhNEa+0wNb1Sy7IR0XpJD2o9tR9+V0QkFhn2a9G4JLxHtV5JAS9RY
         8Tq2xezqb5aOj3dwRY5hNajzG6JwJCy04I5ZvOCAQQQc5U7+qu3+lTySZK2/xkdX4jiG
         r1Xqbc/080jZj2Ub8uST4oqWW8EE+DGmOPWzr35MEOIvOQz9dhb4OmuoJcZxqYqSbS+w
         UNE/tA3ajjwH3dq4wiQUt/pWuVuGIz8T+doyBpXXF0DNctrQWfimHxCQg0C2vptBVpbX
         jDBRwX6CVAvAmz3MChK8MYTSyXy9/oaXWoeFRHUlBe5lyx9S/49LHCOWISU502Jsz5dv
         GVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772591545; x=1773196345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aVFKngS4QsksNCfquBokL9Dtn1zpW7vmmFSQXbqv5T8=;
        b=llMSY2eTSRtPvqCdGhOV0ApYcGtyOnxtFsS7VEeKSX000NeeifQC0zIkPoFx5ZM5MR
         Ok4gOdLju1g4CtDHKj+1achUCJls4peKpAUlALIyIH1TWjCp8rLas4OgDdNtuDgAnwVa
         2kfRSbM57HmHQfX76PnO64AE6gAlcZ/VrIGLnqV5BumZu48kkEhuv3i5XT/Md/geSiPX
         hfxEBkDPqGXTBDjpySq4VOF3RJC/K6mQh0+KgeWEmR0T3OzJmqWXRsZtL21PUK1MVMHo
         7fgxOeDYscFzXx1B+uhEir71QK4B/efPstuTKJ4OBaeIe+HhIpXj0w1FngQRRVW72RMl
         LQ3A==
X-Forwarded-Encrypted: i=1; AJvYcCXQOH6DLHv9JScGibyKwjfYAlWCWzYmLQX+XbPBSDoFdyPF/mVGInWVqm64nyuTeWayZwFfpUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyORCwq3cFsCgY6X9DyF1mtQElCDoTEmhfVl+l+tsXJe70LIG0G
	gdAOF3mYu9cg3CdJrBdbNKS/dWs0+NdM8FLLPAcvtrDUvqolJAUIVKsyEEJbds3Q58p1WyOpIab
	7SIzl6h3yKxGgSJRN1qcBQTTEynzXiAYf8sIDYUEc
X-Gm-Gg: ATEYQzyrQZ0KDvajvycDD4IGiclzLHWMSMn8jL6ERFkeATyxyDrvSPnSQJ4Pmi1ffj0
	oxQakWhZXoo77zL9GmvfvMAVwSb7bxvfDgBEo0dHKT8QeHpifqAflFmhGC8sE6VO3nN0GMTAhu6
	eg0KFOKHAE1ZurY2l7Yyn0TPwbX5lGsPgvassa0dh7RAxsqwRLUoj8bZOOJ0h1UcmvCPJqTi86/
	WTZawYlMP9D3xQaCWIpkqNVfA9VLRNglscHG4sUcp6XdWf+ljUCH8fcWmV9HAzyjLwtFbFpLwn6
	SGKCT+7a
X-Received: by 2002:a05:690c:7402:b0:798:715a:c9c1 with SMTP id
 00721157ae682-798c6b8a551mr4786277b3.10.1772591544296; Tue, 03 Mar 2026
 18:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302154201.1621117-1-edumazet@google.com> <20260303170841.218b0816@kernel.org>
 <CANn89iKBDxAqT4MGGuQ8xxXjbNRo7HadXoYYq5QpyP0S_4rfTA@mail.gmail.com> <20260303182429.49645ce8@kernel.org>
In-Reply-To: <20260303182429.49645ce8@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Mar 2026 03:32:12 +0100
X-Gm-Features: AaiRm52UdMXAN-b1XkIGxqo6KBoWF4IqgmAdj6Bw-n6Wq7BPzm_hYGK3s-LErHU
Message-ID: <CANn89iLox=oWvU6VZKSKKtt36zstfJ6Lp5TgQvfmOz1g_-rMnQ@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: add IPV6_CALL() helper
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B32BF1F9E4D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-263557-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 3:24=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 4 Mar 2026 03:13:40 +0100 Eric Dumazet wrote:
> > On Wed, Mar 4, 2026 at 2:08=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Mon,  2 Mar 2026 15:42:01 +0000 Eric Dumazet wrote:
> > > > ipv6_stub use is racy, we should add READ_ONCE() and WRITE_ONCE(),
> > > > even if this pointer can only change once.
> > > >
> > > > Add IPV6_CALL() macro to factorize the READ_ONCE(), and perform
> > > > direct calls when CONFIG_IPV6=3Dy.
> > >
> > > Does not apply to net-next.
> > > It sounds like we're going to remove IPV6=3Dm, however, perhaps trans=
form
> > > this patch into that removal?
> >
> > This seems orthogonal, unless the plan is to force IPV6=3Dy ?
>
> I thought if we remove IPV6=3Dm we would delete ipv6_stub completely?

So we will add #ifdef around helpers ?

Lets take :

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.=
c
index 866746695712aeae425100eefb231e44d52d52d4..5de8fd283ac9b0dbc07d5851f05=
d15e84c3645e3
100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -411,7 +411,7 @@ static int addr6_resolve(struct sockaddr *src_sock,
        fl6.saddr =3D src_in->sin6_addr;
        fl6.flowi6_oif =3D addr->bound_dev_if;

-       dst =3D ipv6_stub->ipv6_dst_lookup_flow(addr->net, NULL, &fl6, NULL=
);
+       dst =3D ip6_dst_lookup_flow(addr->net, NULL, &fl6, NULL);
        if (IS_ERR(dst))
                return PTR_ERR(dst);


Is the plan to define ipv6_dst_lookup_flow() differently for IPV6=3Dy and I=
PV6=3Dn ?

