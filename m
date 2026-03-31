Return-Path: <netdev+bounces-273604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD5qL167y2kpKAYAu9opvQ
	(envelope-from <netdev+bounces-273604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:17:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4483695C9
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8857B3009B39
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135D13DE45B;
	Tue, 31 Mar 2026 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mMNRg9KJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6083C5555
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959213; cv=pass; b=HxT74HZSYmld31I4ZPoq3QXBxR5VYrz6ggJxyAxVQLCNUpQ2DfKHUili9TFRIim+6grYT+dlLoGXdMKiWz2d8RhvDN5cLIKmLb1HfYGu2lB3klf/S3JnXcpXbjbSw8/CLdZOYIp2TYsLUdJq3eWMUwUMywHC60uEY8IdXYNbD4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959213; c=relaxed/simple;
	bh=YmrpdzSROzGpNBnFyZAF9wgy9aZFmk5AJtW52VlehP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrcgKfDC7wt/kWcaIB7SWZrkfxJhHYLrOh7ByvInmpMW3LnUPlV19ee7lPx2aIxA0LeNVueYQyxrdtZ9TS0hYmZaWFwHs69tre/KxrtmjLt2YiPJvhRE08i/oW4tu2QbpRzGOSGeckJQMKeY9wNOlx8bQqoWH/2W1p0BOKrG8fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mMNRg9KJ; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50b2d6f9d00so50437811cf.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 05:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774959211; cv=none;
        d=google.com; s=arc-20240605;
        b=OK6gYZVAGBTXfWPzmGrJqDShVnrKdv/MD5M4mGnDRcXlFmmoWA13OAZraPpSWsaNs0
         wmzvP2Tjmkv+BWDnYVNRvOkPKNYlt0iladoqdx3Wg1W4VHPm1vxO8XG06qsR1SNLf9Xe
         bXmY/5PKMxSdwgznWs3mBqt+IvsbCZScfSjbKoK9/CGIS+W1/f92SCsVPjvKjuu+4UgD
         8wj4RoJDvAJT44skJZ9n5BPZuXHCQQgiBY7NYC+G3mczevGM/Kw/SCm1oloVrd/wyGp4
         RyOtgIOSHqn0XmYjn7M79pEHGWdMYiLXQoIuakdglcWjEJrkQvZQxqLx62qJWYP1cN0X
         fSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AG/5C8KySZbINB7b4tdPFgB+HxSdIUn6l+zgzxqrvUA=;
        fh=NdUYpX7ns3jMl7AO9OWRlZvePaUy/mQS/f9qhvkDDs8=;
        b=U/EXgRcIfgg2dIkKt3165UBV//sVFsMZdgslwPjne5WwIgXoJRZoUJhwbrfi/MzlFw
         SBn7UhMsEkxoWrwZVEEvMi3C9mOMz2IppmUzljyrWHYWVDdWfKcQjMVJLqmgAxZfxRNC
         B8mhJr+srUiN28pUrmFYyfPBj1mnUposzHxpkNSHMSosI1MQZo37rJAn+K3wYgjf7mkD
         HZVjJ5JNSqL439x2lnnfJQwvaSKYX8A4FmhGimrq4DB/P+WR1x7jEnj0TeHPKSU/Kyzg
         rs/Y4u2WNTAwWFmbOU7Hk2qKao9zHf2a829tZYroDB81C3wXeD2mbQrruAC40NrFX69F
         Z0aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774959211; x=1775564011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG/5C8KySZbINB7b4tdPFgB+HxSdIUn6l+zgzxqrvUA=;
        b=mMNRg9KJi/gqclp0Jj0vEm+jQ4gZPXX8pr2hb5ndAn0ChawJRXOhNGhwKdSooqlmzW
         xESqQTeplax6rieBaYbnUJYRFQAeJiDon4jVyuWt1XMqop0n8cFHcoiA/+yKhNKl+6Cc
         TIMC176wdPWdBytnoK2Yf/634sjvLi73wD4YYtfTNDpIDRDcra0qJtlq6XcaFexJSKzo
         stWyhGd38D8e3jCuSSBSCrLAp3CPcfH33cz0h9zOOUnkyoa+1m8tcG2tnFGGn/T2u1GF
         YoYvJ7US4UUAbZfxf0fOvkSXc3aoadlsC2GLF66bG7LlJRWeeh+xazh9gPe3c3W9vIuG
         kWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774959211; x=1775564011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AG/5C8KySZbINB7b4tdPFgB+HxSdIUn6l+zgzxqrvUA=;
        b=LuJQ8McgeGnJj8DqTZ7l/P2x6bDh9y11EYaqESF51zPQRbnQko2nXQjQ60TDiZb5de
         rxfucs25Gl6bZhV5mzHBwlqpS4OX+N/FdWFvPwn6vj3nSv4B6G8Ff2ijZHLMuXOFmQaU
         r0znUYNP3xxTEYVkZ4l/ogTn4PS27cnPuQF+0ciekNB6JEv2AC5o9tXf8/9S5EKzb8K1
         ITFWGp+tpe44hrlbOhfgCqVvhZK3/nE5u4zCWDsZuqU2SJ8oizplPw7Vu5e5UjUBCLeA
         UzNXCGWM5vA+4Pgt1Wzziz2/oNOLT7OAUDCyyO+9WDm6LfVo4FWpqrOTcWPjmqFwh/CV
         74NA==
X-Gm-Message-State: AOJu0YzOZmU4MRpjIpBtS1lw+5c+X3GXgSUW3hMRQf6kmcJnl4jtga19
	L992Kg+yzDz+aGq2RqEDne2cTMnocl4slTlheSMacvp6TxpFIzPSYL9MIgHr3bparLc3YOoU/MN
	JTRQnnvBWc27OOnwMPHQYAr4md7xIUiNtBAeL3VtF
X-Gm-Gg: ATEYQzxi8QL2SojEY9swffp+/p2CL5oqgH7rVd6IrF3mkXl5EuCd0sy08pNB5qP24aI
	XP+MBnRzRNYg2jUbpHRaJTqrMSQtRaxrw0zkVNYMVA4I65lsJY0fuSR4yGBT3WP65TUS+jpI5Wb
	pB+X70DI07ASdQygOmel/GxomqB6ufAl5x92opAPxgGSAeJuTZeCSLyfqlDTKldb85gSRjvvU3S
	Za0kU4ZOvv+U5+ebnOCZiK4CgY9/aB5pVPU4IbrLNQOSYhq/Kt2CBJWvvVSdFEgmCnSL5J4ItZY
	njg/XA==
X-Received: by 2002:a05:622a:64b:b0:50b:49c0:b6f0 with SMTP id
 d75a77b69052e-50ba39aaf73mr219059701cf.61.1774959210124; Tue, 31 Mar 2026
 05:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331115943.10404-1-fmancera@suse.de>
In-Reply-To: <20260331115943.10404-1-fmancera@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 31 Mar 2026 05:13:19 -0700
X-Gm-Features: AQROBzAbfQCnPPh4UGGIDWfU9qbzNnpcfMTLvhcve4ATFXRYzOTYAruNR-dv288
Message-ID: <CANn89iLJUi+cA4fFr7XQESkT+5ckY6+MGg7QEM-G123RzuD5RQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: nexthop: allocate skb dynamically in rtm_get_nexthop()
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	Yiming Qian <yimingqian591@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-273604-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,suse.de:email]
X-Rspamd-Queue-Id: 1D4483695C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 5:00=E2=80=AFAM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> When querying a nexthop object via RTM_GETNEXTHOP, the kernel currently
> allocates a fixed-size skb using NLMSG_GOODSIZE. While sufficient for
> single nexthops and small Equal-Cost Multi-Path groups, this fixed
> allocation fails for large nexthop groups like 512+ nexthops.
>
> This results in the following warning splat:
>
>  WARNING: net/ipv4/nexthop.c:3395 at rtm_get_nexthop+0x176/0x1c0, CPU#19:=
 rep/9282
>  [...]
>  RIP: 0010:rtm_get_nexthop+0x176/0x1c0
>  [...]
>  Call Trace:
>   <TASK>
>   rtnetlink_rcv_msg+0x168/0x670
>   netlink_rcv_skb+0x5c/0x110
>   netlink_unicast+0x203/0x2e0
>   netlink_sendmsg+0x222/0x460
>   ____sys_sendmsg+0x35a/0x380
>   ___sys_sendmsg+0x99/0xe0
>   __sys_sendmsg+0x8a/0xf0
>   do_syscall_64+0x12f/0x1590
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>

I find these stack traces without symbols not very useful.

Any reason you have not used scripts/decode_stacktrace.sh ?

