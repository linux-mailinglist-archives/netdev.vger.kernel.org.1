Return-Path: <netdev+bounces-286462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGcdLtV9AWrFbAEAu9opvQ
	(envelope-from <netdev+bounces-286462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:57:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 184F7508BC1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 602B63014C17
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 06:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016502FD69E;
	Mon, 11 May 2026 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdL+ouEI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537B62F90C9
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 06:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482489; cv=pass; b=dfdxwRrp+jZwk8+U/22mF4HT387NhOEdCPhFN3EYoamRzHihHnPn9mF9N7K/K9w3YwnuUQ6deWWrDQYDA85gG6ZeTjqXT/PwvxWhj+W8paf8a0GSdon/9W2Z0yiEi/oTnn/ZNPF7DM37wvv4f5edrdkAkXjrr2kh9NdYb/rgjvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482489; c=relaxed/simple;
	bh=m9ggfBeGwWwf4Ny30oM6cEV7a/Kn+7pJ2p6ePJp+XO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGFPJhywVVyW7vLdBgM7G3jXsKABCGO8AvCZpKX7U5BTh97H8NM22htvCOtos43G8D1GKonU1dLf7eL7Pf5J6T/5R+WusyhBgWFKfelfQ3PZ8pEN0q1NkTN87coV/dxYO/WxqreuKP7YteMsUlk/hqQYzchSatTw9EdyPGNX3oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WdL+ouEI; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50fb8e9a4edso44781691cf.1
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 23:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778482487; cv=none;
        d=google.com; s=arc-20240605;
        b=U1wyu/eeSFmn4QKofV8136zcOE6qZzUITashX/elBZRYOMLdzXihIKG+jirOH6HJkU
         g8LI6iAz/ggGkMzMUlkv2gLuO//ZFUUhmHOH+U6kzfZ00jesfXN1BaFYBrUV05Izn7di
         6gxNF1fvoazALuxNS1xo5xBTPMSl21cW/14T1ZSf8IrDlBQvDQfttPMLBGGj3if2itiA
         4UJBxcl4Ii4uFx9QkNJZtX8tGhzoHnbit01ZUMtxJzcVYF40bR21rF3EoWwjLboQhM2f
         5OnDNt/F+z4QmQdFOh+JVEGJW4QuxKMkSBUIf2m7MwKnhrCieEYc/K/fVlDCP6s0DNWP
         32uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AyhRRlnK2R9IgaNjTQof4ske+M21SjbRc9ikQCLlfwc=;
        fh=/Yl41URI+hDAGH8cC8P6rzIOWHabI6OjqSTDD+qpuHw=;
        b=QQ35RciYNC0ibLzl31bR40eemqpjChhXZEH7f439QO3YF6hKRwUtxGXupVNTW/fjef
         SRn+ymzsyqX44cTgcAiaZK3H+Gqye1WunzwrHerrk3CsLY5OZre3OlUxrcqT9rW4p8c5
         NuHLwM/Ig4kVqVkT75Broh6BFYLKlbipLdvrxOigaKYvOtIqe0XG9LdIFDjCviltmsjZ
         /IkMs+cFbFDu9ypYSKdWZGPsWx4mTBU9J8hdu+apP5Ipy/N5GTPZHLfK8xaBFszqvxhe
         OLVU8SGAq8WUEG1QYoasZTKB1ixcB/iQJtKYQq9TBUvM1kXTbV3S5nALPVoc+GmlaNnz
         S8xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778482487; x=1779087287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyhRRlnK2R9IgaNjTQof4ske+M21SjbRc9ikQCLlfwc=;
        b=WdL+ouEIc2+zBkmyR6ajxhIbi1Sswlz1WEnQwgZkeFuuQFM3tj9czp6jQMNzRu7RKj
         vFS7dUq8scyC4dKYoXkAQK26JQP1Rg5b5/dODIexzIw2uVorMbvvwjU6Tf8XWqV8srG0
         gKv63OD3Kiz5fpxmqJcRj+uSWx9r+R5pitWCdG4ooN3xKTKxUw0tfF/Ojf3F8fV4+pRv
         VohrJVwZQw28s1fqgrq8b4KwnWJNTZm4abVnjs4W5P+KIJ0eMQi9XlmqawfYBSMvCYt4
         MPl7fsUE7kyQyRcx8vVHD0CVuYkCHes+GikL3KJOVfGL7M7rd+5ONCgjtY0MRdzE7KUd
         vKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778482487; x=1779087287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AyhRRlnK2R9IgaNjTQof4ske+M21SjbRc9ikQCLlfwc=;
        b=UCGLfT+WAuzhl0nS10U6LeYWyRv9bkKOAkoJ3JK0TmFN8yAcP7flWu6XECoOX/AaB2
         SiVIXuuqWQRjuZQC1bBgPoT5bDurwx7Rczauk9dPSgxf8yzqS5T4BWsEV+WWQFcBWU+2
         at+imfLCSAKWSnhY4HXboonnHxbHU4rKIcqU1T2q6XR8WGhij0N5XBBCSGGpL1iIbQNE
         sT2MXFs6COGLJ2yVIMnh6XUtmEb3LCakq2w6th/dwIvAOzKsFPQoADHBSNQvx3PX94P3
         C1feNdvK3ZpmHjXna5sCkaT253XcCuDYpVr+/jdyuwygosHcaH+0hYKpfecqnCqcr0Qm
         ErHg==
X-Gm-Message-State: AOJu0YzNN8lXp4XhOk1kvjMEosjwQtIBHn2b3KIiDMHmTeK8tSAFCn6q
	uDlc+ZmS4m0GPT1NYKW0oOEAECdEROww+5SChBEcgXBmR958eonYp3hrcbhPW0KmyB8+zsr9sof
	ddIqoK6tXYEHuFYXjz9h2x2m+uowJB2pWrZMw03Ut
X-Gm-Gg: Acq92OGNVePC5etftKO8lPVxAPRNToWqIsAUMgaPQBigaTIUO7S2w8kuXjGeT/A490T
	WY7UhbGZkM4b9MKIpCu70IFh4Ohcok8lhn6ZtNqYytU8a6Gy+AjRO4OXU/s7SVDelc/DP6NzRR8
	wTIwuqX/I5F7vk7ntYyJQCSNx9pfFY7XY1j3n/xMYMcH5aYzQGAm/WPha/dCe6U1KodI7wR1JDe
	Lphby/ue4Bn5b8Q+csDIGpjabO7OsHXt9ghtpElVAveUo8I+EALxUU1XY/W+UvS4atSu7flCwVt
	BItvaeP3EsEbAJ4Lox4FIYGeeCRL0ZUTMvzTqDr7JKtkkaVDQA+hYAiB+hVHWFvh8orpvc+x09f
	Qrp3rprmSa1ibLOh+v3NIMESt4EY7
X-Received: by 2002:a05:622a:114c:b0:50b:41bf:4ee5 with SMTP id
 d75a77b69052e-514621f338cmr353965191cf.57.1778482486865; Sun, 10 May 2026
 23:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511063005.38134-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260511063005.38134-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 10 May 2026 23:54:35 -0700
X-Gm-Features: AVHnY4Ic4M7f6SXQlN9sMIgnbx4Uj6isQ8OzNi8GIl2ydTasZYrS_kxOfsNW04Q
Message-ID: <CANn89i+wKfikSrBJ+eatERFx+kC+vQV4WDTe9aCERiv9HtncDA@mail.gmail.com>
Subject: Re: [PATCH net] net: core: dev: add reprocess depth limit for
 another_round in __netif_receive_skb_core
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Krishna Kumar <krikku@gmail.com>, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, 
	Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 184F7508BC1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286462-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,gmail.com,google.com,mails.tsinghua.edu.cn,126.com,tsinghua.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tsinghua.edu.cn:email,z.ai:url]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 11:30=E2=80=AFPM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> In __netif_receive_skb_core(), the another_round label can be reached
> via a TC ingress redirect (bpf_redirect_peer returning -EAGAIN).
>
> Across network namespaces, two BPF programs on peer devices can redirect
> packets back and forth indefinitely, creating an unbounded loop that
> monopolizes a CPU core in softirq context. This leads to RCU stalls,
> soft lockups, and system-wide denial of service.
>
> We reproduced it by creating a pair of TC BPF programs across two
> network namespaces that redirect packets to each other, and the RCU
> subsystem detects a stall:
>
> ```
> [   24.835219] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [   24.835837] rcu:     (detected by 0, t=3D21002 jiffies, g=3D-627, q=3D=
2 ncpus=3D1)
> [   24.835959] rcu: All QSes seen, last rcu_preempt kthread activity 2100=
2 (4294691810-4294670808), jiffies_till_next_fqs=3D3, root ->qsmask 0x0
> [   24.836239] rcu: rcu_preempt kthread starved for 21002 jiffies! g-627 =
f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
> [   24.836362] rcu:     Unless rcu_preempt kthread gets sufficient CPU ti=
me, OOM is now expected behavior.
> [   24.836460] rcu: RCU grace-period kthread stack dump:
> [   24.836601] task:rcu_preempt     state:R  running task     stack:15448=
 pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00080000
> [   24.837139] Call Trace:
> [   24.837568]  <TASK>
> [   24.838008]  __schedule+0x4ed/0xea0
> [   24.838934]  schedule+0x22/0xd0
> [   24.839023]  schedule_timeout+0x81/0x100
> [   24.839095]  ? __pfx_process_timeout+0x10/0x10
> [   24.839165]  rcu_gp_fqs_loop+0x11b/0x650
> [   24.839226]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [   24.839282]  rcu_gp_kthread+0x17e/0x210
> [   24.839333]  ? __pfx_rcu_gp_kthread+0x10/0x10
> [   24.839383]  kthread+0xdd/0x110
> [   24.839433]  ? __pfx_kthread+0x10/0x10
> [   24.839481]  ret_from_fork+0x1aa/0x260
> [   24.839538]  ? __pfx_kthread+0x10/0x10
> [   24.839585]  ret_from_fork_asm+0x1a/0x30
> [   24.839686]  </TASK>
> ......
> ```
>
> Fix this by adding a depth counter at the another_round label. When the
> counter exceeds XMIT_RECURSION_LIMIT (8), the packet is dropped. This
> follows the same pattern as dev_xmit_recursion() which protects the TX
> redirect path with the same limit.
>
> Add SKB_DROP_REASON_RECEIVE_REPROCESS_LOOP for observability.
>
> This issue was found and reproduced with the assistance of GLM 5.1 from
> Z.ai, affecting stable versions from v5.10.
>
> Fixes: 9aa1206e8f482 ("bpf: Add redirect_peer helper")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Reported-by: GLM 5.1 from Z.ai
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> ---
>  include/net/dropreason-core.h | 6 ++++++
>  net/core/dev.c                | 8 ++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.=
h
> index a7b7abd66..f0f420f39 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -130,6 +130,7 @@
>         FN(DUALPI2_STEP_DROP)           \
>         FN(PSP_INPUT)                   \
>         FN(PSP_OUTPUT)                  \
> +       FN(RECEIVE_REPROCESS_LOOP)      \

I do not think we need a specific drop reason.

>         FNe(MAX)
>
>  /**
> @@ -622,6 +623,11 @@ enum skb_drop_reason {
>         SKB_DROP_REASON_PSP_INPUT,
>         /** @SKB_DROP_REASON_PSP_OUTPUT: PSP output checks failed */
>         SKB_DROP_REASON_PSP_OUTPUT,
> +       /**
> +        * @SKB_DROP_REASON_RECEIVE_REPROCESS_LOOP: __netif_receive_skb_c=
ore
> +        * exceeded max reprocess loop iterations (another_round).
> +        */
> +       SKB_DROP_REASON_RECEIVE_REPROCESS_LOOP,
>         /**
>          * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>          * shouldn't be used as a real 'reason' - only for tracing code g=
en
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 831129f2a..376b595b3 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5958,6 +5958,7 @@ static int __netif_receive_skb_core(struct sk_buff =
**pskb, bool pfmemalloc,
>         struct net_device *orig_dev;
>         bool deliver_exact =3D false;
>         int ret =3D NET_RX_DROP;
> +       int reprocess_depth =3D 0;
>         __be16 type;
>
>         net_timestamp_check(!READ_ONCE(net_hotdata.tstamp_prequeue), skb)=
;
> @@ -5980,6 +5981,13 @@ static int __netif_receive_skb_core(struct sk_buff=
 **pskb, bool pfmemalloc,
>         pt_prev =3D NULL;
>
>  another_round:
> +       if (unlikely(++reprocess_depth > XMIT_RECURSION_LIMIT)) {
> +               net_warn_ratelimited(
> +                       "%s: reprocess loop limit reached, dropping (dev=
=3D%s)\n",
> +                       __func__, skb->dev->name);
> +               drop_reason =3D SKB_DROP_REASON_RECEIVE_REPROCESS_LOOP;
> +               goto drop;
> +       }
>         skb->skb_iif =3D skb->dev->ifindex;
>
>         __this_cpu_inc(softnet_data.processed);

Can we please try to fix this issue without adding yet another cost in
the fast path.

Presumably this could be done before one specific "goto another_round"

