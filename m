Return-Path: <netdev+bounces-274126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BzWIM8qzWn7aQYAu9opvQ
	(envelope-from <netdev+bounces-274126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:25:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3F237C1A6
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01A2430055E9
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63A92BDC28;
	Wed,  1 Apr 2026 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2jnq48Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8002D9ECA
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052631; cv=pass; b=unrzqpkwPqVcaknTmjc0chobOzX1tFC9zf04C7226XpDyvmZMwhpnbp4utJppTR1K4A4/mk9luVDrxo5zGY1VmLyfqyonu6wsursS8doCuMebTALCEdomPL7gWTiOpBdSdvv5afTidZ1GYc5IPmcygvSRQp2v//AbF/ZHpuP5hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052631; c=relaxed/simple;
	bh=x9z81w/tFtm3f1YjX89gbUOe4TlKQ61MvFlLdEguHsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdWON4O2Rw4dHjtLeGDVtcC1ryJnm3Rbo2YonCR2YMT55lrWZyQqWpKRQVK4Zq0Y+hQU00EOq4I00bYv2rUwNj7ychtL+pepXgGtxq8c9bNXRZiZEOs1KAXy3vPdFqdm0Tp8Ne/YMohs16I/L+YL0H0ObZOsaxr3adctzsk6O6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n2jnq48Q; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5091d71aa11so12296541cf.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 07:10:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775052629; cv=none;
        d=google.com; s=arc-20240605;
        b=Om2vMsC0wyFIvCstCvHNvSSh1Q3/scf/5MPawCa3PRg/miMWgF9CO93/xlAxDNh2z2
         N8dET5Hc6PEhuVAiIF7f+5ownQY3oD5sNd5VWOeHv5AYhE3C6vUe/aMjS3gs+MO/XyvH
         9mYo69vygrvn1UYRm0fy5duZslFTbN+caypG5L4BWXzaGPqtpipegwWqbAbIKDPAWjP8
         DLjl0m47f71u51YHrfZrAkloqLTcOQqBw0Voqf56nJC24mIywevpApL1qzLPBgcLiaIn
         SZYlHgdPqm8+iJuac6HF7ZpbGyCZ88F9zDSWTUVC09GBeUiCT4Y6IP/44SvqdC5IdJoh
         EhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iTKfrxsuRx5nfB5GG1gigCr8A3IWKjMK0AMjeSzjJWc=;
        fh=J8LnwPcPQZmBrqG0NwLOy+VD10FbOUKe98/dgC1Gf84=;
        b=HlwLO88y9EaP6zl/7J0SkJU0ZwbSnJW4AhvhAV233niaGQDGphcWTk5vYekQ8cGg4/
         JTPETqguSf8+8lXyaXOcajXB5J4HkpSbfPLX/WFe01xs99IUevCYIwLxBZACic6OPVoK
         B6ZUjbE6g0R2SV/jEJVbbeH7kptm/Ti5+gcpotDWSiylJ6G4Kz2TabEs1qXYWDAA1HDV
         qoMpBsVb2VwuauNok+HkJ0TvCD7u6m/Rnk9AofcrL8XR78D2Ahc9Z3l2BcE8qiF1LmiP
         yBrNTXAk+X7tKe3HlpX9bFPQ4IgVGaggWpnbAWfg/avQ6VKKIRNkZ5ZLfX3ZLWYIghHR
         2nmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775052629; x=1775657429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTKfrxsuRx5nfB5GG1gigCr8A3IWKjMK0AMjeSzjJWc=;
        b=n2jnq48QRsV5N7wUCdDEzrgKlMou3uOBvV30L+R3Ys8Y0CD94Wo8nBIpmKL/16wIRZ
         iLOaCs3uBUgyKnWX5PU/x+SZesXokFfnL9V7W02sPV/wy13oaVLSeBbP0+fWXH3LwsgW
         JjqPMvTNV8IJHn+sW+JO/qTUw1/OrSogm0chxh/xDymgy+iQqU1cwnCFSsojnOs8vVkw
         bopzLo0P3hdRvP4gO/H6Odab02ORGRgRGolgCKJCtUUC64CjJL+pbTtzZ4W9vHYrz5JI
         NbdZPmfNTO6KMWC6jLYVmmdd1df3nRfG+qJpeqAxX7VyVTtNSGsHEOUtoPFvlCJTGDoA
         xQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775052629; x=1775657429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTKfrxsuRx5nfB5GG1gigCr8A3IWKjMK0AMjeSzjJWc=;
        b=hqJTqv/QN+VL277rTTOyN8NANHyRtG4zcjyd7sCNIRKwkhkURDqkvPbaLb74AvC4ER
         HjomQttEyPEN20UAcmruCbx+4E4IieLpOwh001OtretEMKoU8PvMo0iTo6au4RVWX2mV
         Qzi6EZeegIrC0bQzIE7G7/3kqN8PsPuk2Gq001BMGmAbXl2ZjHbVEgSUDUmYWSBbJBHS
         a+G7jSa9uK+XF/aWXKSMfLP4YGt/5XHDYCHHvA/U9euTkPzw7IC22k5DWsvXz5SMTwqY
         9/h73HXXcuAFJXt4bObvx7s+ok6aZGYO0WpH7bNgyHDmcwZc/C8FxVzBENTcX7loJG93
         /srA==
X-Forwarded-Encrypted: i=1; AJvYcCVkROCNy+/NzhwDQmnRbEIaHfwMAPM11ro/n+F0CXPgQmm/KEYmzO5cPCiysofHpBV+HitpPxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNQCleqg7MBfUagG9dcfFB3uzYz1TUOUWjrZpsi+0aInXuH2p
	DmEa3/afgROOyCEvVpYSY83ywi6sug/389WDdiZ/tZT3mfySmkI94xX3Ypky1en0iKJC97SLbKe
	3+kKvbpSse0Bbn56PubZHIW3afvmH3jCMsFbWLEpMax6rH2BJlz6JgnxYwrE=
X-Gm-Gg: ATEYQzxFkdgf03rhIiTV/VxQoBarP2uetSN489vfKGMdy2fEcug6AmUxwhEGV5PpE4H
	M1WWOLhAz1vOSK/EsQjobvQK65Ci7jCU69RfAMlQWCL/nFDvNE1zdG+bNfg2Cy65c3R+rwHuEEr
	zXddJnKWift7a8YUytz7vjDzKZQdvREBEEBq5yNubCo9OT4CoMloWGqw01Ok62UVgjEtVPPfSlm
	QtEwtYip105Iq3Y+bE6t9ASGXONMfiAdiILXRz1WLMc2XEKo6h88FzG1ujPeZtZBM68kNcRmi4H
	pysPEfm7
X-Received: by 2002:a05:622a:1899:b0:4ff:b32b:cdf9 with SMTP id
 d75a77b69052e-50d3c175f45mr45132991cf.14.1775052628438; Wed, 01 Apr 2026
 07:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL_bE8JNzawgr5OX5m+3jnQDHry2XxhQT5=jThW1zDPtUikRYA@mail.gmail.com>
In-Reply-To: <CAL_bE8JNzawgr5OX5m+3jnQDHry2XxhQT5=jThW1zDPtUikRYA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 07:10:16 -0700
X-Gm-Features: AQROBzAi-Kl06a028fAsMdPvUm5JE9hApZW5QCAtmnNz6zFxEs8HxY3uwypPb6g
Message-ID: <CANn89iK57oiF0T0Z=t7okBuZbCpn+Bt746nxL2+iaQgXPyBb7Q@mail.gmail.com>
Subject: Re: [BUG][SECURITY?] ipv6: opt_flen wrap via repeated IPV6_DSTOPTS
 cmsgs triggers skb_under_panic (local DoS)
To: =?UTF-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>
Cc: security@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274126-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 7A3F237C1A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 6:19=E2=80=AFAM =E9=92=B1=E4=B8=80=E9=93=AD <yimingq=
ian591@gmail.com> wrote:
>
> Hi,
>
> I believe I found a locally triggerable kernel bug in the IPv6 sendmsg
> ancillary-data path that can panic the kernel via `skb_under_panic()`
> (local DoS).
>
> The core issue is a mismatch between:
>
> - a 16-bit length accumulator (`struct ipv6_txoptions::opt_flen`, type
> `__u16`) and
> - a pointer to the *last* provided destination-options header (`opt->dst1=
opt`)
>
> when multiple `IPV6_DSTOPTS` control messages (cmsgs) are provided.
>
> ## Affected Area
>
> - `include/net/ipv6.h`:
>   - `struct ipv6_txoptions::opt_flen` is `__u16` (wrap possible).
> (lines 291-307, especially 298)
> - `net/ipv6/datagram.c:ip6_datagram_send_ctl()`:
>   - Accepts repeated `IPV6_DSTOPTS` and accumulates into `opt_flen`
> without rejecting duplicates. (lines 909-933)
> - `net/ipv6/ip6_output.c:__ip6_append_data()`:
>   - Uses `opt->opt_flen + opt->opt_nflen` to compute header
> sizes/headroom decisions. (lines 1448-1466, especially 1463-1465)
> - `net/ipv6/ip6_output.c:__ip6_make_skb()`:
>   - Calls `ipv6_push_frag_opts()` if `opt->opt_flen` is non-zero.
> (lines 1930-1934)
> - `net/ipv6/exthdrs.c:ipv6_push_frag_opts()` / `ipv6_push_exthdr()`:
>   - Push size comes from `ipv6_optlen(opt->dst1opt)` (based on the
> pointed-to header). (lines 1179-1185 and 1206-1211)
>
> ## Root Cause (Detailed)
>
> 1. `opt_flen` is a 16-bit accumulator:
>
> - `include/net/ipv6.h:298` defines `__u16 opt_flen; /* after fragment hdr=
 */`.
>
> 2. `ip6_datagram_send_ctl()` accepts *repeated* `IPV6_DSTOPTS` cmsgs
> and increments `opt_flen` each time:
>
> - In `net/ipv6/datagram.c:909-933`, for `IPV6_DSTOPTS`:
>   - It computes `len =3D ((hdr->hdrlen + 1) << 3);`
>   - It checks `CAP_NET_RAW` using `ns_capable(net->user_ns,
> CAP_NET_RAW)`. (line 922)
>   - Then it does:
>     - `opt->opt_flen +=3D len;` (line 927)
>     - `opt->dst1opt =3D hdr;` (line 928)
>
> There is no duplicate rejection here (unlike the legacy
> `IPV6_2292DSTOPTS` path which rejects duplicates at
> `net/ipv6/datagram.c:901-904`).
>
> If enough large `IPV6_DSTOPTS` cmsgs are provided, `opt_flen` wraps
> while `dst1opt` still points to a large (2048-byte)
> destination-options header.
>
> In the attached PoC (`poc.c`):
>
> - 32 cmsgs with `hdrlen=3D255` =3D> `len =3D (255+1)*8 =3D 2048`
> - 1 cmsg with `hdrlen=3D0` =3D> `len =3D 8`
> - Total increment: `32*2048 + 8 =3D 65544`, so `(__u16)opt_flen =3D=3D 8`
> - The last cmsg is 2048 bytes, so `dst1opt` points to a 2048-byte header.
>
> 3. The transmit path sizes headers using the wrapped `opt_flen`:
>
> - In `net/ipv6/ip6_output.c:1463-1465`:
>   - `headersize =3D sizeof(struct ipv6hdr) + (opt ? opt->opt_flen +
> opt->opt_nflen : 0) + ...;`
>
> With wrapped `opt_flen`, `headersize`/headroom decisions underestimate
> what will be pushed later.
>
> 4. When building the final skb, the actual push length comes from
> `dst1opt` and is not limited by wrapped `opt_flen`:
>
> - In `net/ipv6/ip6_output.c:1930-1934`:
>   - `if (opt->opt_flen) proto =3D ipv6_push_frag_opts(skb, opt, proto);`
> - In `net/ipv6/exthdrs.c:1206-1211`, `ipv6_push_frag_opts()` pushes
> `dst1opt` via `ipv6_push_exthdr()`.
> - In `net/ipv6/exthdrs.c:1179-1184`, `ipv6_push_exthdr()` does:
>   - `skb_push(skb, ipv6_optlen(opt));`
>   - `memcpy(h, opt, ipv6_optlen(opt));`
>
> With insufficient headroom, `skb_push()` underflows and triggers
> `skb_under_panic()` -> `BUG()`:
>
> - `net/core/skbuff.c:2669-2675` (`skb_push()` calls `skb_under_panic()`)
> - `net/core/skbuff.c:207-214` (`skb_panic()` ends in `BUG()`)
>
> ## Trigger Conditions / Privileges
>
> - The `IPV6_DSTOPTS` cmsg path requires `CAP_NET_RAW` in the target
> netns user namespace (`ns_capable(net->user_ns, CAP_NET_RAW)`).
> - Root (or any task with `CAP_NET_RAW`) can trigger this without user
> namespaces.
> - An unprivileged `uid=3D1000` user can trigger this if unprivileged
> user namespaces are enabled and it can create a userns+netns to obtain
> namespaced `CAP_NET_RAW` (the attached PoC does this).
>
> ## Impact
>
> - Local denial of service: kernel BUG/panic (system crash).
> - Reproducible with a small userspace PoC.
>
> ## Crash Proof (KASAN Kernel Log Excerpt)
>
> This excerpt is from the attached QEMU console log
> (`qemu_upstream_20260401.log`) captured on a KASAN-enabled kernel (see
> `kernel.config`, boot args in `kasan_env.txt`):
>
> ```text
> [+] sending IPv6 UDP sendmsg with 33 IPV6_DSTOPTS cmsgs (len=3D2048 x32, =
len=3D8 x1)
> [*] expect a kernel panic (skb_under_panic) on a vulnerable kernel
> [   51.243668] skbuff: skb_under_panic: ... put:2048 ...
> [   51.245216] kernel BUG at net/core/skbuff.c:214!
> [   51.247204] CPU: 0 UID: 1000 PID: 106 Comm: test ... 7.0.0-rc6+ #1 PRE=
EMPT
> [   51.252080]  ipv6_push_frag_opts+0x84/0x130
> [   51.252349]  __ip6_make_skb+0x1773/0x2300
> [   51.253728]  udpv6_sendmsg+0x1a36/0x2760
> ...
> [   51.267528] Kernel panic - not syncing: Fatal exception
> ```
>
> ## Affected Kernel / Reproduction
>
> I reproduced this on Linux upstream commit:
>
> - `9147566d801602c9e7fc7f85e989735735bf38ba` (reports as `7.0.0-rc6+`
> in my build)
>
> Reproduction steps (VM recommended; this PoC panics the kernel):
>
> 1. Build a kernel with KASAN enabled using the attached `kernel.config`.
> 2. Boot with the command line in `kasan_env.txt`.
> 3. Compile and run `poc.c` inside the guest:
>
> ```sh
> gcc -O0 -g -static -fno-stack-protector -o poc poc.c
> ./poc
> ```
>
> ## Fix Suggestions
>
> I think at least one of these should be done; doing (1) and (2)
> together is most robust:
>
> 1. Reject duplicate `IPV6_DSTOPTS` cmsgs, similar to how
> `IPV6_2292DSTOPTS` rejects duplicates:
>    - If `opt->dst1opt` already set and `cmsg_type =3D=3D IPV6_DSTOPTS`,
> return `-EINVAL`.
>
> 2. Prevent 16-bit wrap:
>    - Use a wider temporary and reject additions that would
> overflow/wrap `opt_flen` (e.g., `if (opt->opt_flen > U16_MAX - len)
> return -EINVAL;` or `check_add_overflow()` with a wide type).
>
> 3. Consider widening `opt_flen` / `opt_nflen` to `u32` and validate
> against sane upper bounds before use.

widening opt_flen would trigger other issues I think because sk_buff
use u16 offsets.

I will test :

diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index c564b68a056268c7cbc81b5f29f60289ea9e09eb..68b7b97a464b00c490c450c2f31=
b00570b716365
100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -766,6 +766,7 @@ int ip6_datagram_send_ctl(struct net *net, struct sock =
*sk,
        struct ipv6_rt_hdr *rthdr;
        struct ipv6_opt_hdr *hdr;
        struct ipv6_txoptions *opt =3D ipc6->opt;
+       u32 opt_flen =3D opt->opt_flen;
        int len;
        int err =3D 0;

@@ -902,7 +903,7 @@ int ip6_datagram_send_ctl(struct net *net, struct sock =
*sk,
                                err =3D -EINVAL;
                                goto exit_f;
                        }
-                       opt->opt_flen +=3D len;
+                       opt_flen +=3D len;
                        opt->dst1opt =3D hdr;
                        break;

@@ -924,7 +925,7 @@ int ip6_datagram_send_ctl(struct net *net, struct sock =
*sk,
                                goto exit_f;
                        }
                        if (cmsg->cmsg_type =3D=3D IPV6_DSTOPTS) {
-                               opt->opt_flen +=3D len;
+                               opt_flen +=3D len;
                                opt->dst1opt =3D hdr;
                        } else {
                                opt->opt_nflen +=3D len;
@@ -978,7 +979,7 @@ int ip6_datagram_send_ctl(struct net *net, struct sock =
*sk,
                                opt->opt_nflen +=3D dsthdrlen;
                                opt->dst0opt =3D opt->dst1opt;
                                opt->dst1opt =3D NULL;
-                               opt->opt_flen -=3D dsthdrlen;
+                               opt_flen -=3D dsthdrlen;
                        }

                        break;
@@ -1040,6 +1041,9 @@ int ip6_datagram_send_ctl(struct net *net,
struct sock *sk,
                        goto exit_f;
                }
        }
+       opt->opt_flen =3D opt_flen;
+       if (opt->opt_flen !=3D opt_flen)
+               err =3D -EINVAL;

 exit_f:
        return err;

