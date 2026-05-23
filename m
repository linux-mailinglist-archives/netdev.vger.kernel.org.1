Return-Path: <netdev+bounces-291025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6rNwFGsjEWrDhgYAu9opvQ
	(envelope-from <netdev+bounces-291025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 05:47:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FA45BD046
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 05:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 135533008690
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F09B2F3600;
	Sat, 23 May 2026 03:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="siKxcUfr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0EE2BEC34
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 03:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779508067; cv=pass; b=X0o6C86PSDEkc3Y5Y48cWolsnmnz7S+zme3pFC89Vw99I2qCP2As46K2pxz1F52dIiKyjPxnfiZ1qyKCC/UCt8Ui2Lf350KTVFmkgW0yNitwm7fkaJDWsVwn4zxmNeX/CKRBj8bNaX6Zrf7GDBnQaN/5IHF2dpkVCV1/7UB5A48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779508067; c=relaxed/simple;
	bh=ki8+VA+1WGYppVcrmqZEhoCQnpgoNkRJOK+8bQJYxWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPiA6V5CgQp1BcP8Ul7pibNHNgJ9Tfa2oWe1ZpwIQTGh6jBmblDZgFWRbHzjB2E5XDIGwNqLW8OWhfB1+FToo3uHbOsM/j3z9m5Khod+PmAigZp+nqntVRKeXbezMFMRI2IjdHIyKHODh0AEk34k3q2R2qWfwGXpPMQCL2cxVSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=siKxcUfr; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-132c338a537so5208350c88.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 20:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779508065; cv=none;
        d=google.com; s=arc-20240605;
        b=jU95zKRn8Gg3a/34wcmmiCfV0qfUNnkNxVMoruRs5AVFDHN68mS38tMH9e1UzaFuE5
         +n10aodgKd8TEvY1I7+0mbeg2nvnPMF1ImS7mVZvuv/REgmoeP6BIikqoRN4e8ZOAdjH
         N9kQ4z8YPvblfLNAAaFIeWsivZGdrdbkRzBC7ocHYIDspolUhws5ABr0OfmwaSW5YJNw
         jw6CLP2n0uieQoqtcXXESTn7AY2kU+vGV0bXgsr8qvAx2VV7yGAc7+EChvDsUgsetDeT
         viCqx1m0YZiChmTXDY+8mJhC7jvRzwRP4JXX2HXAVgWvPsZnhOISjSv5k49YlN2mmYIG
         CMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IPulaD313dwBv7H8/WqubG2lSDiF9avGjFmbR49K3Lc=;
        fh=C36CKMKBtEJ8SFFIZT58gVVADZlnq9FPST3F4FWmw9s=;
        b=ZPn3MTusx70h0B/uKfGqe2WD9i1xP4aJRPDyMKFebq+aC96T2CRy4s/U3KPXcb2S+C
         QaAKoqEPWB4tSgkb5K6zBmXnECdE2MHrXObOl+H0b9kFheZRpV4cWQ8an/gM3BJtYHjV
         lujACAEkYAZLyaqheTqWRYdFM6f6554dbA/7+R23sFSWemxwHIJjUMulAthqBO2s0+8k
         PPZAPATqU5fzKY/s4VVhAiW58UPrMye9Pc6l9Cs2BvQp+1OI2QuxBYDtxsY3sjHj6tPn
         FEJWommY51YygNkLuR3guVi9GSB0exc26a05+wH//AxU8ouCcDv+vO2OGL5KxplZY31Z
         iA2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779508065; x=1780112865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPulaD313dwBv7H8/WqubG2lSDiF9avGjFmbR49K3Lc=;
        b=siKxcUfr0FEOgUmamvFVtzeSYup9CZgHHw3ZidAkaOKxPHeKNqJVXpRAF4m/nS3gl2
         jy2wY8oBXDmsdbK9ZAa7sd50o61AP38bNeEFSQkP1HzzAF+mxTh7R61qbOyCgyeUNeC5
         ZKnO1EALg6m81LULrVdwGwllc091RhlvyM5IENeK0osHPIWVuRYaQ+pIp9Nb2we2Ygv1
         pVJiguDxXVEhGZWNV3bTAxifeZ+oHZgvJySRdvH7zaSylTnhd7eW6Vcmx+0Gt1bhaw8A
         ouOL/6QggJIM4wc7K/TXikyMnAE8WYnj8YNrZ2KlR0AES4HlSZWW4CcIux63iECp9XmY
         V4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779508065; x=1780112865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IPulaD313dwBv7H8/WqubG2lSDiF9avGjFmbR49K3Lc=;
        b=DC9TpETmNEh1L6DCm/vv9Z8q0mpja3F5Hl4FqjM0+pnw4U/6wlMXQxCLhfCzPnDc1X
         n4w9KOH3Ui6UCvb0MDjMERtv0mt9hUjB/ImXG8zik/FcyVRtTnQbx5kcz5hDsqQ0A0sG
         iv2SVNreK7sr9wESJDhOcmTCZg9aMXQyxVSRznt0xXx6kXVH9rp/0kZ4Nehd6ufNupxu
         LnmYLtWEUQ5K0gNyrsLYFNFaitsp40vD2dTfLfPYahG12jtAahyWhJOYOzy/Fjanpprk
         SOVvMJrjcR/uVPSxD3pVHY3KM0HTgplkTwiMRrcTfqr0n57zInuLGTB8OTgUxYnPEqiG
         cXQw==
X-Forwarded-Encrypted: i=1; AFNElJ+Z7/DAfYjGg2B1R35VZoBp5HZ1Lts4uIHg7z7rA2eTvhXhFII5SddqloBhx/l3WSdf3RJCLQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+SlSH9XyXdtu+w7PTO4ME8hC2rYLsgKAqjtSYYHZqGvjNF7eD
	98tZsKA2gjXnK2S2AuF81Z9J0eXEkiBGIVGY5SW+2C8fSg5/30t9tTUecgaOU48At4Era3g10NC
	NCQWVdSj1YAUiiExwuhHbv/YFXIHi3xnyK+ZfIxaP
X-Gm-Gg: Acq92OFj+9qg8HBZjzO9PRu1aJUAvccTrVDPeM2pJtaygw27qPhC/0UHb6zBSt3++qW
	vcxQ9tiInV0gOa95NeFHSWE/rU3EMZgl+psmVMKtWYRI5YzMtyDj3f13lw66i6l9yIsyBVk/cpB
	HPWCcpszRLWOa5U00lWF5MEtzCfO4RaKWBKO5kIgWUEoVIPWT1hEHbgCYuoNhP8rJyzQ/wedUdN
	5uiGyDO8Clon7LEZVlvn6NNpoAGMEy/6VqgwhM1qlgnKkkacYZ8qqZ7HBhJJRK9Mkq2ocpbV1gl
	uOglPUgz4cLABugcZRoMBAWGD1uJs+B64D+ToYfKg8iL1yi4wKBiq5jODvZHkdE7oXI7yNRQRkg
	s68xue8c/zIx6DIeyZSsuBJ9ssprk5I0Oryj78L86rROafIlKF67IAhx3Pq6b+55sU1iXQxAekA
	==
X-Received: by 2002:a05:7022:2509:b0:130:5606:94d with SMTP id
 a92af1059eb24-136334df1d4mr3469572c88.0.1779508064508; Fri, 22 May 2026
 20:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521135244.40869-1-kerneljasonxing@gmail.com>
In-Reply-To: <20260521135244.40869-1-kerneljasonxing@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 22 May 2026 20:47:33 -0700
X-Gm-Features: AVHnY4Lk6EpaCtz0pvldpZ9MC_C1CNLCV2ey7ROr9zO-XDps0InrqN0Dk2Tqd6E
Message-ID: <CAAVpQUDu_UXZSqGNhKKyrtR6VF53vRcM+vLvE4OV-HnrJ4Wzdw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/6] bpf-timestamp: support rx side
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291025-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,vger.kernel.org,tencent.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tencent.com:email]
X-Rspamd-Queue-Id: 39FA45BD046
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> [PATCH net-next v2 0/6] bpf-timestamp: support rx side

nit: This should target to bpf-next.


On Thu, May 21, 2026 at 6:53=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Previously the series[1] has already supported tx side for BPF
> timestamping, now it's time to support rx side.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/=
commit/?id=3D68b92ac494eb
>
> ---
> v2
> Link: https://lore.kernel.org/all/20260518082344.96647-1-kerneljasonxing@=
gmail.com/
> 1. support tcp rx zc case (Stan)
> 2. add if-statements for ASSERT_TRUE (sashiko)
>
>
> Jason Xing (6):
>   bpf: Add bpf_ktime_get_real_ns() kfunc
>   net: export sock_disable_timestamp() declaration
>   bpf: support bpf_setsockopt for bpf timestamping rx feature
>   bpf: add BPF_SOCK_OPS_TSTAMP_RCV_CB callback
>   bpf: enable bpf timestamping rx in TCP layer
>   selftests/bpf: Add RX latency tests for bpf timestamping
>
>  include/net/sock.h                            | 12 +++-
>  include/uapi/linux/bpf.h                      | 10 ++-
>  kernel/bpf/helpers.c                          |  6 ++
>  net/core/filter.c                             |  8 +++
>  net/core/sock.c                               | 20 +++++-
>  net/ipv4/tcp.c                                | 10 +++
>  tools/include/uapi/linux/bpf.h                |  5 ++
>  .../bpf/prog_tests/net_timestamping.c         | 71 ++++++++++++++++++-
>  .../selftests/bpf/progs/net_timestamping.c    | 35 +++++++++
>  9 files changed, 172 insertions(+), 5 deletions(-)
>
> --
> 2.43.7
>

