Return-Path: <netdev+bounces-302345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W4jnJ9oJQGp5bQkAu9opvQ
	(envelope-from <netdev+bounces-302345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 19:35:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4D36D26A1
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 19:35:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rHMA200h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302345-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302345-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DC213028833
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEAD33F38A;
	Sat, 27 Jun 2026 17:35:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747AB30BB94
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 17:35:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581703; cv=pass; b=MpiWoDbFErAFhQMWLG5wX7yXlAZf5Z8j3AdEf9GvzLZGStlFaDktbnzBwl51mGwEoGOba4GOftjgeE03ELPM2FJVeY0aSvJoo/imGoV6BJSN2RSIvrxpllnnz+Pbrueu7rHSZvn2RCS4hHG/0uojdKZkO15ppPpfbdhKN5lpSCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581703; c=relaxed/simple;
	bh=EtSa3a4s7pUIWy8W5ASP2Hk6Xhg7fEmw0EI/tsx6ptI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBy1OPahqpOoboC4Flo9JAjaU/bS+PrH/RJgxMn3CEWO7EV3FA25e/3JqNQxFnvDJYH/mvBuxWQkLlmNmV7/Iw1LfOBg4KE0jjbl/wTUJquIZyQXN/NR1QCyAKFTKJEBvXgCjctYdX8XEs5S8YdMmw4iAGB1Bs2RguUOyPZEKi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rHMA200h; arc=pass smtp.client-ip=209.85.128.175
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-806449d108aso27705137b3.2
        for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 10:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782581699; cv=none;
        d=google.com; s=arc-20260327;
        b=aGuqSPPHGWaYx+ki10sP5086KI/qi4X9JuUUtOkWs66lCfgU4fSDewt5x6MPJkpsRo
         R/OM72EyEVzMPDjdHxMgPJA1LkNv+xkBOF+iX+84WX8S3sUcMmgxW300ykq4OSNCRl+M
         NYHmr+cw3Ehh8Q0nBQGH9Z0utPqXAQO07dZMAntpT8WHFUL/xhz3m2ncuIaBMyajiP1y
         PRgs80p46HGN5ijbB3gcEelQCg9y6M/VZcFx048W7aABvOxEyvKB7461bhnpwvVkLEZp
         PY5VXKuownblBOogibX1Pw4UnVrp2lv0OB8Y1jKnIjkynouqEe/KWN48cyUKIN6rc0vN
         xxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dgu34QrpNJdt6cwZYfvIh4PfqfTJtLR90pHZigkhqr8=;
        fh=JHfeGowkdcsOHDjoOAyhM/8+wnn54TtIfe/zFsd/7uQ=;
        b=pGpnh8UtFiOEvVtP7zhCvvkVy7sAiMtle9h3U6/sbCgAbRA2q9oXu88TKmLH+u6GUf
         PtpTGSEABzkdL7ykzDVxESyXtLkl0hMQjhtzQdhY9DMFfANf1y4Dt7jpzhGjpiAd3tfq
         ImXMkRR9jSZ52WLwoorR9zzze2Fpvxxve3Apvrt/IQ4kQhaqI77ZeMQpbD9XKJF8aYh6
         uG8dL2WIoijuTHKoIqSYIgQZXCifcQ3Zzknm4zWWV3PB0KZK/jG1aK4rZ7JY5b9QTR16
         ep+sZj5oLi63dYJ2OHBwWhKcH3G+4WDGcRVGOpfVdlxBTFKc4V975QzLP2nu4OwyHZqz
         RBlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782581699; x=1783186499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dgu34QrpNJdt6cwZYfvIh4PfqfTJtLR90pHZigkhqr8=;
        b=rHMA200h85kj5cgUDkXotqTcF9w2HC9z0SaL/mGqx7SI6VLThAmZXDrzzTQPc5hlK0
         y53Wz1YwaZT0FqhF7aVKBGu0UGUu3B8i0hQuXd6Bi5qgoSCQ6e/NawDcvdKaL9DeyV7W
         xNCd9PE3wRPCU3q5BophlCLtea/GkhQ3Ir5/XkBn7Rx6i/raJtK/rgmoFYfXRC2M6Y85
         JFERMRi4gagYs/2mrf71a1yYqiRdwkRul66mFIdZXJnDO65wavzoAXkG90rgp2bpaZ36
         PK8ehOMdTZtJ+xNqT4P02gv36vQAngW5JZsXpZBThPnFMw4G4dnk5MPUPD8SOKKmsVyz
         LpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782581699; x=1783186499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dgu34QrpNJdt6cwZYfvIh4PfqfTJtLR90pHZigkhqr8=;
        b=mc6cZYVV1aKkeqh4+b9gB9zQxnpgy2Nye7JQQ4MfLgbwH3xOGbleVhEORXR99ZCPkg
         RMH4HpCWEt2UVB17ZlBxF4/t9vb35doNvkcRdJyeRAF8SjPNE8FkiMl3B+AoXz0S9AlP
         l4bDUdcYwgV7+qkwQC/ugercdWy0nmJd2M0dUUkdmI3Q7UAjL/Yp9R1HneBr0MbkqoI4
         Fp20q4VYa3/nFrWYRk0xU3+Vk4GykP0tEIrhfJKmwzwjKIaCsfX5MEy0GHcOHY4zrR8+
         hv16zwAZ9Jv/jhidzwPqhcTyEYaeAGl8Ur4AJdvjLrLSeJgaFlqbPyVDq7Y1JOMWEh4E
         VoQg==
X-Forwarded-Encrypted: i=1; AHgh+RpqfxxPA/qkq76UN5f4GWxespUK/GPT3UQt9c8oTYdxnBST/aCGvyrvYit20P03tipNpuQo8r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpK0rqad6iH3qTONw7rO8NjxtdL1YE1HYTwvLqrCCxwIW5HdSm
	mj2fMK2bBQKNwq7mOltBuOfMeSaW9LoPsaeuOYsxwhXsDoLGeGMvZ06feFSoGa5qw+fQ3m0bDsB
	JN6k5M+ygipvrS5RdduM0o/ZjNcX4E1M=
X-Gm-Gg: AfdE7ckf/aMEnwcszoM3pOGz7cYTgk+F5dhYih76bAi7A31z1TOMu6ssNNY12LjaM+B
	+aMcKHJA/NhIAwT3KNzojB9KN6XaNbQecP/UYbkC3bvNXEMpCVHGe+WTvIS4xQ1gTPF/16xvEK7
	3s+xiTKz84YCBhQ/i1bOkX8Gkdw67NvY2uuNegKbWxZQhS3op4xg2pxCIgLhfAJBVc55/X9i3w2
	5QLTLAzCcSQlUvG4fyfvrfn24pDnXb1NQRhYlitmlFlTbRYaXw6wH2k5WY3Ph8LTVRJyh39MEDZ
	Pq4UAEAgOTirX1kJ0goh/BKh/dE2CCRskyUcFsFAtJBegAE5
X-Received: by 2002:a05:690c:e370:b0:7dc:1609:53ae with SMTP id
 00721157ae682-80a6a09b112mr118115867b3.25.1782581699520; Sat, 27 Jun 2026
 10:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Sun, 28 Jun 2026 01:34:48 +0800
X-Gm-Features: AVVi8CdMPlgvdtTlopQ1G7HcBFTuPVL00FJZpDP6g1ISEPYbsnwP6Z4y-kISnc0
Message-ID: <CABFUUZGg1B0vaw9DFX3uTHxpRyyGtvn04Ae=Ob-VmnuVJB4KLg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 0/4] bpf, sockmap: Fix sockmap leaking UDP socks
To: Michal Luczaj <mhal@rbox.co>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Cong Wang <cong.wang@bytedance.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	FORGED_RECIPIENTS(0.00)[m:mhal@rbox.co,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-302345-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,redhat.com,gmail.com,cloudflare.com,linux.dev,davemloft.net,kernel.org,bytedance.com,iogearbox.net,etsalapatis.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,rbox.co:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F4D36D26A1

On Sat, Jun 27, 2026 at 4:37=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> Fix for UDP sockets getting leaked during sockmap lookup/release.
> Accompanied by selftests updates.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Changes in v2:
> - selftest: drop the original, adapt old tests
> - fix: change approach to rejecting unbound UDP [Kuniyuki]
> - Link to v1: https://patch.msgid.link/20260623-sockmap-lookup-udp-leak-v=
1-0-05804f9308e4@rbox.co
>
> ---
> Michal Luczaj (4):
>       bpf, sockmap: Reject unhashed UDP sockets on sockmap update
>       selftests/bpf: Ensure UDP sockets are bound
>       selftests/bpf: Adapt sockmap update error handling
>       selftests/bpf: Fail unbound UDP on sockmap update
>
>  net/core/sock_map.c                                     |  2 ++
>  tools/testing/selftests/bpf/prog_tests/sockmap_basic.c  |  6 +++---
>  tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 17 +++++++++--=
------
>  tools/testing/selftests/bpf/test_maps.c                 |  6 +++---
>  4 files changed, 17 insertions(+), 14 deletions(-)
> ---
> base-commit: 26490a375cb9be9bac96b5171610fd85ca6c2305
> change-id: 20260617-sockmap-lookup-udp-leak-bc4e5c5481d7
>
> Best regards,
> --
> Michal Luczaj <mhal@rbox.co>
>
>

Hi Michal,

I tested this series on bpf.git base commit:
  26490a375cb9be9bac96b5171610fd85ca6c2305
The test environment was virtme-ng x86_64.

Before, with only patches 2/4-4/4 applied:
  sockmap_basic:  PASS
  sockmap_listen: FAIL as expected
    - UDP test_insert_opened failed on sockmap/sockhash,
      both IPv4 and IPv6
  test_maps:      FAIL as expected
    - failed at the new unbound SOCK_DGRAM update check

After applying the full series:
  sockmap_basic:  PASS
  sockmap_listen: PASS
  test_maps:      no longer failed at the unbound
                  SOCK_DGRAM update check
test_maps still later reported:
  Failed sockmap unexpected timeout

However, I can reproduce the same timeout in three consecutive
runs on the unmodified base commit, so this looks pre-existing or
environmental in my virtme-ng setup rather than a regression from
this series.

I am not adding a Tested-by tag for now because test_maps does not
fully pass in my setup. The targeted before/after behavior behaved as
expected.

Thanks,
Sun Jian

