Return-Path: <netdev+bounces-255373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JunI4ahfWneSwIAu9opvQ
	(envelope-from <netdev+bounces-255373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:30:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A91BBC0F53
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EF7E3003704
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3D427A461;
	Sat, 31 Jan 2026 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CU1ONAQo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400762DECC5
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769841024; cv=pass; b=FX6MmrY6lGxnel9dt50ETGwLkcKrsI9btAE9gzamC1dwQccNK7d6qBbjQrPlnF2xgphqD1Ug9V679vFRxavicRuSTfcq6CmN8IErwwINfOBs7UgfuLmWpewOO9yUeNR1pQwLBlT3q3Ws/wDTSol1F76yA5d/z+P8EngMsC17OQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769841024; c=relaxed/simple;
	bh=IB/d1bpFBtjorTlV7sSEGNcRfYmhNWPbg3jBoWLczlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkOolPhMatIpy/um0N0LFDO5/iMKATFDN1jPMHJ4awgS6s5dimRUdGN9f8tDCPmbLV4fFT3moEqyMLUFscOu0ug0YpU5Mble83VgITHSK/GJ4CH66apPxCRCB9Uck8tFNQxddUo7yQ/1w3wiWqIB/ra3kSTr1gFdaBgvp4mHpBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CU1ONAQo; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12460a7caa2so4446361c88.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 22:30:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769841022; cv=none;
        d=google.com; s=arc-20240605;
        b=hNpNiE5KtTI9xNAt4hJl4BQigP9SBDBidPCIDmJs+JOLUW4Lqn1G6VYy/D3QPrGC2P
         DtWvTJpWQN+XlDFFjMlO/C1qwrV2Wo0jm3UBBsA1+BGXj+M6Qr8CKOewbk4s2Bf92bix
         Hqx0ZN3m1JTSR0gPfNPmZK917n6vWRbNhvLRk3CtY+ArA5e+NiyfjpMZlstyJe4470kh
         e0hAIYI6mzp3bEf/lOEypWYLtch9UuX0M+8oM3PE1MZag/rUCmEKhAHjnkJF8CMH0/N2
         Gdvdl8l/DMMIFW1WvPQYyyG0BLc52gPKt1N2R2IKpuhYwFotbe9n2okhxESEifKn8YMb
         nd1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lm83Oof6F9m5KEzmYsGqRF9zhIFkCrdUCJ/Is9jiD+c=;
        fh=PxvN4NcYbJDz3CkZbOrKNXVs/q+wOPHByev/ikr187Y=;
        b=hQlbvoMr7fuK7I/fE0vonzICU2xD2ZNNakwXM3swi5QMzs/ah/LvIXfAw+B4rTl/3k
         7C+sY9OkMcv/iTI1UF5mGizqcQYvo2vkC+NvDHNmQ0f62vvicqVOkHT+niWkQSIHxEWA
         cLKV8ZNHjrU+3m7vUNphacLlR6NB+Bq3l5ePIOE/VvsOgBOnWtftpBM/swbUqPMHDvEu
         6JjbYDVL7L4Yqf3stGq+dxLnEoRsqEFlRb82kIOf4Ypjy6l/WuLJNHO2XTmsDzrlcXX+
         LZB7LLkxe64Yr7oHtxJAe5ERi5tJVPVALrqH0mPyhmBshmYHQZxMgePjKHwkCfSp3wnH
         cy/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769841022; x=1770445822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lm83Oof6F9m5KEzmYsGqRF9zhIFkCrdUCJ/Is9jiD+c=;
        b=CU1ONAQo1PG0VHxtm0bPUc1I36aR9iy2uQlvy6uMzoQQgvly6wa7hU4cWIXo6H4oqI
         pd1q5ZPv17iTY/6+4dkwbrRE9AL89CgVpq38CKhAK1ydeEaVGf/HZ9YsDCrRNF6qgHbC
         mLEb3IcTwuW3Is3pDyCK6ldfXJNSUdCOw/LnOPYa3LiQqKpwqzw1ROWuHG1nAt7z5+p9
         gNAXiqasGfhMiKIBNJgO1kjyR1rx4YgWE2Rj1E+eKHEGFzNptoJlA0SKAgpURe8gO7fm
         D0G2xb0FOWFJg6hHrbFjwjEx+FzZkU8tauPs3YykTDD0AUrRdMjkAqnYTQAPC9jWMlgG
         TNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769841022; x=1770445822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lm83Oof6F9m5KEzmYsGqRF9zhIFkCrdUCJ/Is9jiD+c=;
        b=VjTHTa5PHcR4DKahAFJrOhSeI6lwCN/+CD8mB0dy1HcoVhsgtNjnupwZr/23ojvnOh
         MxYUzrg7GqpzyKHEDnZGEmKj5CWcgStj9zqqYjbHZbmD/tfLDPftjNnRZbcRTuxJ9j4M
         O5fSJn1Au8cdLIv0eFxFJPlQsunAtnruQyP1atyOw/sRlYtNTm7fvnd87YDhCIuhImyX
         DsKNNnrTgeU+MDrqUPNRd2fkClAK+Q9JoTiDjrq40DMoAEtQtuSp0bbjqT21PYnrtrQA
         PNN4iocLnTZzgz9n4AOdMWkjFde4ltsG8k+NolwqcPUePkveDTdr/w9fp7WupwHMMObt
         p8XA==
X-Forwarded-Encrypted: i=1; AJvYcCVkzM7mmerXKhM/uRxfm5V7PXpE8Ae3iZIErKTaORItTiY7uZKTD0CD3AU025Q3RTp5QssaqM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYIkeRz+E08/trvX0p9WZH73K0ltjFHxb/bjB9xqs+vlDjlBSu
	L6AnUEJx06ZaL8L5N6ANDg1e11jHBQcjIszbIznhMkC1UeFlP8/sDPgs7QdvJTI1GiOnyPOIf8p
	AZzaKzwzXeX3EQ2y5mflwmxeN3AzXJCrmHo2eayYH
X-Gm-Gg: AZuq6aJjOFm7qGk2GZR0yGKDT71I3SjoC4i4RQ0hm89HQW4hYP+OOcaTgzZwDX0PuTU
	DrCuBK/W+s8xuRT0CeWLTZPk5rfUyI31xntBSQVgSy6qxhOQjsavY1lYZBadtM1FwIyBj6y09Xd
	GDQaN/upVD3oDI8VGlk6pk1zgW3k2C0/N5V/SK5mHOx2s7D1/khYMbj7q70KNmMdykWMAsgCM0p
	3mGoWwsQWYGoKz2R5nfmnISLe695KhBCnWVqSgOOr190l5tDKH0fYyRj4DIe1+LYN+pq1+wYwFU
	OWPVQOCH6GKnCpYns3Ognqvz2Qlj2i59r3mCp4P+ptrVv++ZST1xNJrJWbwu
X-Received: by 2002:a05:7022:660b:b0:11a:2f10:fa46 with SMTP id
 a92af1059eb24-125c0f1cb17mr2323688c88.0.1769841022025; Fri, 30 Jan 2026
 22:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130210303.3888261-1-edumazet@google.com> <20260130210303.3888261-3-edumazet@google.com>
In-Reply-To: <20260130210303.3888261-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 30 Jan 2026 22:30:10 -0800
X-Gm-Features: AZwV_Qh1moXy-rl8ebugxNimhwYieWcn_2ro-h9K3tcAy6hI9qbgbH591RnIqOs
Message-ID: <CAAVpQUDxd5EzMNz1_=3mgBirMj8RERNgP57bK1uhxB+_tgp4aQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/8] ipv6: add some unlikely()/likely() clauses
 in ip6_output.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-255373-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A91BBC0F53
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> 1) daddr is unlikely a multicast in ip6_finish_output2().
>
> 2) ip6_finish_output_gso_slowpath_drop() should not be called often.
>
> 3) ip6_fragment() should not be called often.
>
> 4) opt is unlikely to be set.
>
> 5) ip6_xmit() and ip6_forward() mostly sends not too big packets.
>
> 6) Most __ip6_make_skb() calls are for UDP packets,
>    not ICMPV6 ones.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

