Return-Path: <netdev+bounces-305229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kIESLGgfTGplggEAu9opvQ
	(envelope-from <netdev+bounces-305229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 23:34:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2292F715BED
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 23:34:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=X+S4ghXu;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305229-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305229-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFF2E302173D
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 21:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED7F414A35;
	Mon,  6 Jul 2026 21:33:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FA334F24C
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 21:33:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373637; cv=pass; b=fr9Tn3+gpHmgzsC3o0Qud/LT3pKsgPMdRsnJglju8lOKJHGJSHYqmgs0FdFdwkXBMiDq9b2/6jhGwOKZIqkg33DPdqBNTeFq4n9r8guiBKg4LVsxNwriSIFRD+t0BVZHXGMqGqDdrWrLAiznmaGreTFBWG3cCJFCZQX6r2/3Cj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373637; c=relaxed/simple;
	bh=moNOGOlJcbI90/EQtkIpGZAhMSCiqRJsKy/WZQAGqTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYKX18AdNMrvAFJ3tcSOMBng4PYhu824eqR6v1MsOUQTDf37NTLi9EU4mEjInqeIzyZsu/cw6FOew2LXZj0XDGmUySv0mP2zKieMrOCMKIc9Ieovy64/8BeVH+M5Km1jpDMX7S+Zicb8ytcqf/xw0d1e57yQAJHW9arnG6YFxSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+S4ghXu; arc=pass smtp.client-ip=74.125.224.46
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6647bc8f900so4735063d50.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 14:33:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783373635; cv=none;
        d=google.com; s=arc-20260327;
        b=hy341vyOVZgxQosYvKRDL9Jvr5z/mUBwGhgG2zFZZYkDZlIbDqnRX25Gg2pvqEb2lv
         5DUCmppnJnjJJ9pafP25GnDBljOYSasMYtjyATCnVYFO5rLXmQ5+P4/vqOfaJhnJkYTz
         xS4piAcrPTpfBvrkx4b02LhKaIloHV7x4hdVr3zyAMnMNdcKURIQ8tpk/cRKlV1tOaFT
         tdxMTP/nSrGXWS/KTEtUKPycuEYnNK4J12lwPlNzcoV6O+cwinF/yRKwAHt6fLN/iyvW
         JRPMRX/hO3xDxGg3wI/FPE9sv21oUoIkQ/pnpThocDLK0N7kF3oBzX+9Ar1Ts1F3+gRO
         a7IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=127Th4R22HSLh0WHzneNHRzNlno28LSW/vzllXDEhJs=;
        fh=YF2Kb0Uh3/ZmI0LA6GvgqCJmlBOxpGlpK0hd/smSHtE=;
        b=bPbpy2ClFMgoJnUWbxTmTcjw0+etF516M1N5y5W+OT5sFMQ1DnpCmQly+1+JipCvIC
         Iy88kalIRydsIjKIcGsJJh4teJzokTzV8RYlls48rzHHjsoiPeP+S8pUnFJVGa9jeSRb
         lu/r4N7PXX2c1TwMg0bmvxnHQnW7OzT9njoufAp0HmQcHUrWkKVtudy+1TOMpCFW1wr4
         DSTsetdTKVdxpNgWB02kmApUHxHu5+QjwWnwgVADlsbhM2suRQZBvgggG0dIABBVGBrt
         mZPkw6ctQYwF1C5lOoDbpApIVnfpzDbAGUWtjzW8GlCpDl02kT20kim1lFL3ysg9e3u3
         ua0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783373635; x=1783978435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=127Th4R22HSLh0WHzneNHRzNlno28LSW/vzllXDEhJs=;
        b=X+S4ghXuiytZ5MdIBgunryQWWrCT7O6qgYMRLv4cDIXdJ4XEnaSzUZMRERDCp7ZoF3
         qDLjrAGF1pOW+NvgOlLUHFEi5YLlUJ7pVNtNjxuvlHv5ZXAT3odMGtWJl3G7q1V9r1sd
         DygcUHDC0O0OamG9Z39AtvcpILPaOSy7hj7cE/A14YbR0pifJ9NOWSgu4HZYfIPeyg+w
         77SxtwK1Hqe9E0DzqzLsBdXqRnoBnX0lmvwHVv5H+gqi53oumUSciFe76EoHvHBMX0+W
         uT+6jWw3V95mNLbtk9Y0+ymDdfeh8nZh6AgKF7HKh6BGz/rP5wLru3HFo1p9g1VMveRO
         Lc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783373635; x=1783978435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=127Th4R22HSLh0WHzneNHRzNlno28LSW/vzllXDEhJs=;
        b=j2XqR3AQB8wZmDJ9Avyboabm8pxMskEf1+wohtCi/dSrRHvvlisVUM0fSxtJI4P0ts
         b4d7C2rMP3AqUWL+OAfXjFzofpuzOG8q2TEw6YMlHs4A1vXMqqI8kzeKZUT8OTW1JPNc
         uy8nR+QJBpuTy3EpGxTp/oEmPuO/reNaHWI+I6Yko7z19RpkSLJNnkaaWuOQP7VDsCSX
         2A9F6mXV2gXoea8G4VoxNFv0csOz/6xRujR93g5l22UbbFOcDTjGBeOR9EV9IBrVbkuX
         jj1rxd6VuH6pz7vpADhsE/liUH/IECYi3elmVlYP6RR36QLrVkPM7MUqak2We6Agqvxc
         7/8g==
X-Forwarded-Encrypted: i=1; AHgh+RpCQscUj79r/p1MyjY1L5a0TG1WgbRrEO9RpQKHyeCQr40/1f1ewzdqoH5kIpGVKPZReMCmPmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXJ256mMLAsK4JfTpHOhUlkciiorGX411L1XfWSE1/8ErsacJi
	F5xeTTFps3WGLEun+vNBUfLzPrT5h81uNAHkB6YoEBpq0ehnrieL+IGbTap1aKvRIe9c/oVdY82
	mrXXPdik+uUOm3c7RqwOrEuc/vQRHjis=
X-Gm-Gg: AfdE7clUKDWkkBNJmYOpUkWnFf2sdEQ6jE0cEUx5Ib0TUW5ZVnYAGqy6To8TwyTj2/+
	eOJozVYZaRL98OC4vThvCpZA6iiWBnFQaUo3Gg00clypf+/vELt5Ve9uR/m5u5pdeyS0kDGw5l9
	uA10asUA7oY/EfkO2zhy9F2Bz61J0XKMz5+vXZdBF8oZRP8gW9aHyG8XnKPhjEN7Jq6TrGVGoMf
	yg/JNlNLweVwMqGsRWJB8Oqe2ApED1ykvEa9FVRZMj5dETM8nAj3+mYWu+m5o48AnwHgyws
X-Received: by 2002:a53:ac91:0:b0:664:caf6:c041 with SMTP id
 956f58d0204a3-6677fa96514mr1814449d50.19.1783373634411; Mon, 06 Jul 2026
 14:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706093525.13030-1-mahe.tardy@gmail.com> <20260706093525.13030-3-mahe.tardy@gmail.com>
In-Reply-To: <20260706093525.13030-3-mahe.tardy@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 6 Jul 2026 14:33:43 -0700
X-Gm-Features: AVVi8CfJY66MTWXoDxP3HjUyvtpUJxVoX7QxJtsP5XkK1f43vTzqxDS50ybHN3k
Message-ID: <CAMB2axO2cHcKRZzrQyY8Zd2aO56MZd8=bf5po+59qnGj=bXrkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, 
	liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com, 
	song@kernel.org, netdev@vger.kernel.org
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
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:andrew+netdev@lunn.ch,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:liamwisehart@meta.com,m:martin.lau@linux.dev,m:pabeni@redhat.com,m:song@kernel.org,m:netdev@vger.kernel.org,m:mahetardy@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305229-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,kernel.org,iogearbox.net,davemloft.net,gmail.com,google.com,meta.com,linux.dev,redhat.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,opts_copy.family:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2292F715BED

On Mon, Jul 6, 2026 at 3:26=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> wr=
ote:
>
> Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> sending data. This provides a mechanism for BPF programs to emit
> telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> socket types with IPPROTO_UDP protocol but could be easily extended to
> SOCK_STREAM and IPPROTO_TCP in the future.
>
> The API consists of six kfuncs:
>
>   bpf_ksock_create()   - Create a socket (sleepable)
>   bpf_ksock_bind()     - Bind socket to local address (sleepable)
>   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
>   bpf_ksock_send()     - Send data through the socket (sleepable)
>   bpf_ksock_acquire()  - Acquire a reference to a socket context
>   bpf_ksock_release()  - Release a reference (cleanup via
>                          queue_rcu_work since sock_release sleeps)
>
> The setup kfuncs bpf_ksock_create, bpf_ksock_bind, bpf_ksock_connect,
> can be called from SYSCALL programs only. While bpf_ksock_acquire,
> bpf_ksock_release and bpf_ksock_send can be called from SYSCALL and LSM
> programs.
>
> The implementation follows the established kfunc lifecycle pattern
> (create/acquire/release with refcounting, kptr map storage, dtor
> registration). The kernel socket is wrapped in a refcounted bpf_ksock
> struct. Cleanup is deferred via queue_rcu_work() because sock_release()
> may sleep.
>
> The kfuncs are only compiled when CONFIG_INET is enabled, as they
> specifically support AF_INET and AF_INET6 sockets.
>
> The socket operations go through the expected LSM hooks instead of
> by-passing them like many kernel sockets since those are created by BPF
> programs and thus system users. Thus bpf_ksock_send() kfunc, which is
> exposed to LSM progs, has a re-entering protection to avoid recursion.
> Also, because of the LSM checks, we prevent the use of the kfuncs from
> asynchronous workqueue as the current value would then be invalid.

Are these the first BPF kfuncs that invoke (attachable) security
hooks? Some fs kfuncs seem to deliberately skip them. Can we avoid the
limiting recursion check by skipping the security hook in
bpf_ksock_send()? There is still security_socket_connect() in
bpf_ksock_connect() to prevent undesired send.

>
> A bpf_ksock_max sysctl is added to limit the maximum number of BPF
> kernel sockets that may exist in each network namespace. Out of
> simplicity for now, the settings is host wide but the counters are per
> network namespace.
>
> In bpf_ksock_create(), we copy the arg values to avoid TOCTOU races
> since the kfunc can sleep and the arg values could be stored in a map
> that could be re-written by BPF progs or even userspace programs if the
> map is mmaped.
>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  Documentation/admin-guide/sysctl/net.rst |  12 +
>  include/linux/bpf_ksock.h                |  50 +++
>  kernel/bpf/verifier.c                    |   3 +
>  net/core/Makefile                        |   3 +
>  net/core/bpf_ksock.c                     | 516 +++++++++++++++++++++++
>  net/core/sysctl_net_core.c               |  11 +
>  6 files changed, 595 insertions(+)
>  create mode 100644 include/linux/bpf_ksock.h
>  create mode 100644 net/core/bpf_ksock.c
>
> diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/adm=
in-guide/sysctl/net.rst
> index e586e17fc7a5..8bcdc1bfd711 100644
> --- a/Documentation/admin-guide/sysctl/net.rst
> +++ b/Documentation/admin-guide/sysctl/net.rst
> @@ -128,6 +128,18 @@ compiler in order to reject unprivileged JIT request=
s once it has
>  been surpassed. bpf_jit_limit contains the value of the global limit
>  in bytes.
>
> +bpf_ksock_max
> +-------------
> +
> +Maximum number of BPF kernel sockets that may exist in each network name=
space.
> +This host-wide setting is exposed in the initial network namespace and a=
pplies
> +the same limit independently to every network namespace. Sockets awaitin=
g
> +deferred RCU and workqueue cleanup remain counted until the underlying s=
ocket
> +has been released. A value of 0 disables creation of BPF kernel sockets =
in
> +every network namespace.
> +
> +Default: 1024
> +
>  dev_weight
>  ----------
>
> diff --git a/include/linux/bpf_ksock.h b/include/linux/bpf_ksock.h
> new file mode 100644
> index 000000000000..0485b8eddc1f
> --- /dev/null
> +++ b/include/linux/bpf_ksock.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2026 Isovalent */
> +
> +#ifndef _BPF_KSOCK_H
> +#define _BPF_KSOCK_H
> +
> +#include <linux/types.h>
> +
> +#define BPF_KSOCK_MAX_DEFAULT 1024
> +
> +extern int sysctl_bpf_ksock_max;
> +
> +/**
> + * struct bpf_ksock_create_opts - BPF kernel socket creation parameters
> + * @family:    Address family: AF_INET or AF_INET6.
> + * @type:      Socket type: only SOCK_DGRAM supported for now.
> + * @protocol:  Protocol number (e.g. IPPROTO_UDP), or 0 for the default =
protocol
> + *             of the given type.
> + * @reserved:  Must be zero. Reserved for future use.
> + */
> +struct bpf_ksock_create_opts {
> +       __u8 family;
> +       __u8 type;
> +       __u8 protocol;
> +       __u8 reserved;
> +};
> +
> +/**
> + * struct bpf_ksock_addr_opts - BPF kernel socket address parameters
> + * @family:    Address family: AF_INET or AF_INET6.
> + * @reserved:  Must be zero. Reserved for future use.
> + * @port:      Port in host byte order.
> + * @scope_id:  IPv6 scope ID for scoped AF_INET6 addresses, or zero.
> + *             Must be zero when family=3DAF_INET.
> + * @ipv4_addr: IPv4 address in network byte order. Used when family=3DAF=
_INET.
> + * @ipv6_addr: IPv6 address (16 bytes, network byte order). Used when fa=
mily=3DAF_INET6.
> + */
> +struct bpf_ksock_addr_opts {
> +       __u8 family;
> +       __u8 reserved;
> +       __u16 port;
> +       __u32 scope_id;
> +
> +       union {
> +               __be32 ipv4_addr;
> +               __u32 ipv6_addr[4]; /* in6_addr; network order */
> +       };
> +};
> +
> +#endif /* _BPF_KSOCK_H */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 25aea4271cd0..52f6a89546e4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4424,6 +4424,9 @@ BTF_ID(struct, task_struct)
>  #ifdef CONFIG_CRYPTO
>  BTF_ID(struct, bpf_crypto_ctx)
>  #endif
> +#ifdef CONFIG_INET
> +BTF_ID(struct, bpf_ksock)
> +#endif
>  BTF_SET_END(rcu_protected_types)
>
>  static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
> diff --git a/net/core/Makefile b/net/core/Makefile
> index b3fdcb4e355f..a9295b785901 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -44,6 +44,9 @@ obj-$(CONFIG_FAILOVER) +=3D failover.o
>  obj-$(CONFIG_NET_SOCK_MSG) +=3D skmsg.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D sock_map.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_sk_storage.o
> +ifneq ($(CONFIG_INET),)
> +obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_ksock.o
> +endif
>  obj-$(CONFIG_OF)       +=3D of_net.o
>  obj-$(CONFIG_NET_TEST) +=3D net_test.o
>  obj-$(CONFIG_NET_DEVMEM) +=3D devmem.o
> diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> new file mode 100644
> index 000000000000..8bde734bc917
> --- /dev/null
> +++ b/net/core/bpf_ksock.c
> @@ -0,0 +1,516 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 Isovalent */
> +
> +#include <linux/bpf.h>
> +#include <linux/bpf_ksock.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/cache.h>
> +#include <linux/hash.h>
> +#include <linux/in.h>
> +#include <linux/in6.h>
> +#include <linux/list_bl.h>
> +#include <linux/net.h>
> +#include <linux/refcount.h>
> +#include <linux/rcupdate.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/socket.h>
> +#include <linux/unaligned.h>
> +#include <linux/workqueue.h>
> +#include <linux/ip.h>
> +#include <net/ipv6.h>
> +#include <net/net_namespace.h>
> +#include <net/netns/generic.h>
> +#include <net/sock.h>
> +
> +/**
> + * struct bpf_ksock - refcounted BPF kernel socket context
> + * @sock:      The underlying kernel socket.
> + * @usage:     Reference counter.
> + * @rwork:     RCU work for deferred cleanup (sock_release may sleep).
> + */
> +struct bpf_ksock {
> +       struct socket *sock;
> +       refcount_t usage;
> +       struct rcu_work rwork;
> +};
> +
> +struct bpf_ksock_send_guard {
> +       struct hlist_bl_node node;
> +       struct task_struct *task;
> +};
> +
> +#define BPF_KSOCK_SEND_GUARD_HASH_BITS 6
> +
> +struct bpf_ksock_send_bucket {
> +       struct hlist_bl_head head;
> +} ____cacheline_aligned_in_smp;
> +
> +static struct bpf_ksock_send_bucket
> +       bpf_ksock_send_buckets[1 << BPF_KSOCK_SEND_GUARD_HASH_BITS];
> +
> +static struct bpf_ksock_send_bucket *
> +bpf_ksock_send_bucket(const struct task_struct *task)
> +{
> +       u32 bucket_idx =3D hash_ptr(task, BPF_KSOCK_SEND_GUARD_HASH_BITS)=
;
> +
> +       return &bpf_ksock_send_buckets[bucket_idx];
> +}
> +
> +static bool bpf_ksock_send_enter(struct bpf_ksock_send_guard *guard)
> +{
> +       struct bpf_ksock_send_guard *entry;
> +       struct hlist_bl_node *pos;
> +       struct bpf_ksock_send_bucket *bucket;
> +
> +       bucket =3D bpf_ksock_send_bucket(current);
> +       hlist_bl_lock(&bucket->head);
> +       hlist_bl_for_each_entry(entry, pos, &bucket->head, node) {
> +               if (entry->task =3D=3D current) {
> +                       hlist_bl_unlock(&bucket->head);
> +                       return false;
> +               }
> +       }
> +
> +       guard->task =3D current;
> +       INIT_HLIST_BL_NODE(&guard->node);
> +       hlist_bl_add_head(&guard->node, &bucket->head);
> +       hlist_bl_unlock(&bucket->head);
> +       return true;
> +}
> +
> +static void bpf_ksock_send_exit(struct bpf_ksock_send_guard *guard)
> +{
> +       struct bpf_ksock_send_bucket *bucket;
> +
> +       bucket =3D bpf_ksock_send_bucket(guard->task);
> +       hlist_bl_lock(&bucket->head);
> +       hlist_bl_del(&guard->node);
> +       hlist_bl_unlock(&bucket->head);
> +}
> +
> +struct bpf_ksock_net {
> +       atomic_t count;
> +};
> +
> +static unsigned int bpf_ksock_net_id;
> +int sysctl_bpf_ksock_max __read_mostly =3D BPF_KSOCK_MAX_DEFAULT;
> +
> +static struct bpf_ksock_net *bpf_ksock_pernet(const struct net *net)
> +{
> +       return net_generic(net, bpf_ksock_net_id);
> +}
> +
> +static struct pernet_operations bpf_ksock_net_ops =3D {
> +       .id =3D &bpf_ksock_net_id,
> +       .size =3D sizeof(struct bpf_ksock_net),
> +};
> +
> +static bool bpf_ksock_net_try_charge(struct net *net)
> +{
> +       struct bpf_ksock_net *kn =3D bpf_ksock_pernet(net);
> +       int count =3D atomic_read(&kn->count);
> +       int max;
> +
> +       do {
> +               max =3D READ_ONCE(sysctl_bpf_ksock_max);
> +               if (count >=3D max)
> +                       return false;
> +       } while (!atomic_try_cmpxchg(&kn->count, &count, count + 1));
> +
> +       return true;
> +}
> +
> +static void bpf_ksock_net_uncharge(struct net *net)
> +{
> +       struct bpf_ksock_net *kn =3D bpf_ksock_pernet(net);
> +
> +       WARN_ON_ONCE(atomic_dec_return(&kn->count) < 0);
> +}
> +
> +static void ksock_release_work_fn(struct work_struct *work)
> +{
> +       struct bpf_ksock *ks =3D
> +               container_of(to_rcu_work(work), struct bpf_ksock, rwork);
> +       struct net *net =3D get_net(sock_net(ks->sock->sk));
> +
> +       sock_release(ks->sock);
> +       bpf_ksock_net_uncharge(net);
> +       put_net(net);
> +       kfree(ks);
> +}
> +
> +static int bpf_ksock_get_addr(const struct bpf_ksock_addr_opts *opts,
> +                             u32 opts__sz, struct sockaddr_storage *addr=
)
> +{
> +       struct bpf_ksock_addr_opts opts_copy;
> +
> +       if (!opts || opts__sz !=3D sizeof(*opts))
> +               return -EINVAL;
> +
> +       /* Kfunc memory arguments are not guaranteed to be naturally alig=
ned. */
> +       memcpy(&opts_copy, opts, sizeof(opts_copy));
> +
> +       if (opts_copy.reserved)
> +               return -EINVAL;
> +
> +       switch (opts_copy.family) {
> +       case AF_INET: {
> +               struct sockaddr_in *addr4 =3D (struct sockaddr_in *)addr;
> +
> +               if (opts_copy.scope_id)
> +                       return -EINVAL;
> +
> +               *addr4 =3D (struct sockaddr_in){
> +                       .sin_family =3D AF_INET,
> +                       .sin_port =3D htons(opts_copy.port),
> +                       .sin_addr.s_addr =3D opts_copy.ipv4_addr,
> +               };
> +               return sizeof(*addr4);
> +       }
> +#if IS_ENABLED(CONFIG_IPV6)
> +       case AF_INET6: {
> +               struct sockaddr_in6 *addr6 =3D (struct sockaddr_in6 *)add=
r;
> +
> +               *addr6 =3D (struct sockaddr_in6){
> +                       .sin6_family =3D AF_INET6,
> +                       .sin6_port =3D htons(opts_copy.port),
> +                       .sin6_scope_id =3D opts_copy.scope_id,
> +               };
> +               memcpy(&addr6->sin6_addr, opts_copy.ipv6_addr,
> +                      sizeof(struct in6_addr));
> +               return sizeof(*addr6);
> +       }
> +#endif
> +       default:
> +               return -EAFNOSUPPORT;
> +       }
> +}
> +
> +static bool bpf_ksock_has_user_task_context(void)
> +{
> +       /*
> +        * Task work can run from do_exit() after exit_nsproxy_namespaces=
()
> +        * cleared current->nsproxy, while current is still not a kthread=
.
> +        */
> +       return !(current->flags & PF_KTHREAD) && current->nsproxy;
> +}
> +
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * bpf_ksock_create() - Create a BPF kernel socket.
> + *
> + * Allocates and creates a kernel socket.
> + * The socket is charged against the active network namespace's BPF kern=
el
> + * socket quota.
> + *
> + * The returned context must either be stored in a map as a kptr, or
> + * freed with bpf_ksock_release().
> + *
> + * This function may sleep (sock_create), so it can only be used
> + * in sleepable BPF programs (SYSCALL).
> + * It cannot be called from a BPF workqueue callback because that callba=
ck
> + * does not retain the invoking task's namespace or security context.
> + *
> + * @opts:      Pointer to struct bpf_ksock_create_opts with socket param=
eters.
> + * @opts__sz:  Size of the opts struct.
> + * @err__uninit:       Integer to store error code when NULL is returned=
.
> + */
> +__bpf_kfunc struct bpf_ksock *
> +bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
> +                int *err__uninit)
> +{
> +       struct bpf_ksock_create_opts opts_copy;
> +       struct bpf_ksock *ks;
> +       struct net *net;
> +       int err;
> +
> +       /*
> +        * sock_create() derives the network namespace, credentials, and =
cgroup
> +        * from current. Kernel threads, including BPF workqueue callback=
s, do
> +        * not carry the context of the task that invoked the BPF program=
.
> +        */
> +       if (!bpf_ksock_has_user_task_context()) {
> +               err =3D -EOPNOTSUPP;
> +               goto err_out;
> +       }
> +
> +       if (!opts || opts__sz !=3D sizeof(struct bpf_ksock_create_opts)) =
{
> +               err =3D -EINVAL;
> +               goto err_out;
> +       }
> +
> +       opts_copy =3D (struct bpf_ksock_create_opts){
> +               .family =3D READ_ONCE(opts->family),
> +               .type =3D READ_ONCE(opts->type),
> +               .protocol =3D READ_ONCE(opts->protocol),
> +               .reserved =3D READ_ONCE(opts->reserved),
> +       };
> +
> +       if (opts_copy.reserved) {
> +               err =3D -EINVAL;
> +               goto err_out;
> +       }
> +
> +       if (opts_copy.family !=3D AF_INET && opts_copy.family !=3D AF_INE=
T6) {
> +               err =3D -EAFNOSUPPORT;
> +               goto err_out;
> +       }
> +
> +       if (opts_copy.type !=3D SOCK_DGRAM) {
> +               err =3D -EPROTONOSUPPORT;
> +               goto err_out;
> +       }
> +
> +       if (opts_copy.protocol !=3D IPPROTO_UDP && opts_copy.protocol !=
=3D 0) {
> +               err =3D -EPROTONOSUPPORT;
> +               goto err_out;
> +       }
> +
> +       ks =3D kzalloc_obj(*ks);
> +       if (!ks) {
> +               err =3D -ENOMEM;
> +               goto err_out;
> +       }
> +
> +       net =3D current->nsproxy->net_ns;
> +       if (!bpf_ksock_net_try_charge(net)) {
> +               err =3D -ENOSPC;
> +               goto err_free;
> +       }
> +
> +       /*
> +        * Use the normal current-task socket path so LSM/cgroup policy,
> +        * socket labels, and the active netns reference match a socket(2=
)
> +        * created by the BPF program's caller.
> +        */
> +       err =3D sock_create(opts_copy.family, opts_copy.type, opts_copy.p=
rotocol,
> +                         &ks->sock);
> +       if (err)
> +               goto err_uncharge;
> +
> +       ks->sock->sk->sk_rcvbuf =3D SOCK_MIN_RCVBUF;
> +       ks->sock->sk->sk_userlocks |=3D SOCK_RCVBUF_LOCK;
> +
> +       refcount_set(&ks->usage, 1);
> +       put_unaligned(0, err__uninit);
> +       return ks;
> +
> +err_uncharge:
> +       bpf_ksock_net_uncharge(net);
> +err_free:
> +       kfree(ks);
> +err_out:
> +       put_unaligned(err, err__uninit);
> +       return NULL;
> +}
> +
> +/**
> + * bpf_ksock_bind() - Bind a BPF kernel socket to a local address.
> + * @ks:                The BPF kernel socket context.
> + * @opts:      Pointer to struct bpf_ksock_addr_opts with local address.
> + * @opts__sz:  Size of the opts struct.
> + *
> + * Binds the socket to the specified local address and port.
> + * This is optional; if not called, the kernel will auto-assign.
> + *
> + * This function may sleep while binding the socket, so it can only be u=
sed in
> + * sleepable BPF programs (SYSCALL).
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +__bpf_kfunc int bpf_ksock_bind(struct bpf_ksock *ks,
> +                              const struct bpf_ksock_addr_opts *opts,
> +                              u32 opts__sz)
> +{
> +       struct sockaddr_storage addr =3D {};
> +       int addrlen;
> +
> +       if (!bpf_ksock_has_user_task_context())
> +               return -EOPNOTSUPP;
> +
> +       addrlen =3D bpf_ksock_get_addr(opts, opts__sz, &addr);
> +       if (addrlen < 0)
> +               return addrlen;
> +
> +       return __sys_bind_socket(ks->sock, &addr, addrlen);
> +}
> +
> +/**
> + * bpf_ksock_connect() - Connect a BPF kernel socket to a remote address=
.
> + * @ks:                The BPF kernel socket context.
> + * @opts:      Pointer to struct bpf_ksock_addr_opts with remote address=
.
> + * @opts__sz:  Size of the opts struct.
> + *
> + * Connects the socket to the specified remote address and port.
> + *
> + * This function may sleep while connecting the socket, so it can only b=
e used
> + * in sleepable BPF programs (SYSCALL).
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +__bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
> +                                 const struct bpf_ksock_addr_opts *opts,
> +                                 u32 opts__sz)
> +{
> +       struct sockaddr_storage addr =3D {};
> +       int addrlen;
> +
> +       if (!bpf_ksock_has_user_task_context())
> +               return -EOPNOTSUPP;
> +
> +       addrlen =3D bpf_ksock_get_addr(opts, opts__sz, &addr);
> +       if (addrlen < 0)
> +               return addrlen;
> +
> +       return __sys_connect_socket(ks->sock, &addr, addrlen, 0);
> +}
> +
> +/**
> + * bpf_ksock_acquire() - Acquire a reference to a BPF kernel socket.
> + * @ks:        The BPF kernel socket context to acquire. Must be a
> + *     trusted pointer (e.g. RCU-protected kptr from a map).
> + *
> + * The acquired context must either be stored in a map as a kptr, or
> + * freed with bpf_ksock_release().
> + */
> +__bpf_kfunc struct bpf_ksock *bpf_ksock_acquire(struct bpf_ksock *ks)
> +{
> +       if (!refcount_inc_not_zero(&ks->usage))
> +               return NULL;
> +       return ks;
> +}
> +
> +/**
> + * bpf_ksock_release() - Release a BPF kernel socket.
> + * @ks:        The BPF kernel socket context to release.
> + *
> + * When the final reference is released, the socket is cleaned up via
> + * queue_rcu_work() (since sock_release may sleep).
> + */
> +__bpf_kfunc void bpf_ksock_release(struct bpf_ksock *ks)
> +{
> +       if (refcount_dec_and_test(&ks->usage)) {
> +               INIT_RCU_WORK(&ks->rwork, ksock_release_work_fn);
> +               queue_rcu_work(system_dfl_wq, &ks->rwork);
> +       }
> +}
> +
> +__bpf_kfunc void bpf_ksock_release_dtor(void *ks)
> +{
> +       bpf_ksock_release(ks);
> +}
> +CFI_NOSEAL(bpf_ksock_release_dtor);
> +
> +/**
> + * bpf_ksock_send() - Send data through a BPF kernel socket.
> + * @ks:                The BPF kernel socket context. Must be an acquire=
d reference.
> + * @data:      Pointer to the data to send.
> + * @data__sz:  Size of the data to send (max 65535 bytes).
> + *
> + * Sends data on a connected socket, best-effort and nonblocking. This m=
ay sleep
> + * (kernel_sendmsg), so it can only be called from sleepable BPF program=
s.
> + *
> + * Return: Number of bytes sent on success, negative errno on error.
> + */
> +__bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
> +                              u32 data__sz)
> +{
> +       struct bpf_ksock_send_guard guard;
> +       struct msghdr msg =3D {
> +               .msg_flags =3D MSG_DONTWAIT,
> +       };
> +       struct kvec iov =3D {
> +               .iov_base =3D (void *)data,
> +               .iov_len =3D data__sz,
> +       };
> +       int ret;
> +
> +       if (!bpf_ksock_has_user_task_context())
> +               return -EOPNOTSUPP;
> +
> +       /* Early check for UDP. Exact limits enforced by kernel_sendmsg()=
. */
> +       if (data__sz > IP_MAX_MTU)
> +               return -EMSGSIZE;
> +
> +       if (!bpf_ksock_send_enter(&guard))
> +               return -EBUSY;
> +
> +       ret =3D kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
> +       bpf_ksock_send_exit(&guard);
> +
> +       return ret;
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(ksock_init_kfunc_btf_ids)
> +BTF_ID_FLAGS(func, bpf_ksock_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEP=
ABLE)
> +BTF_ID_FLAGS(func, bpf_ksock_bind, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_ksock_connect, KF_SLEEPABLE)
> +BTF_KFUNCS_END(ksock_init_kfunc_btf_ids)
> +
> +static const struct btf_kfunc_id_set ksock_init_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set =3D &ksock_init_kfunc_btf_ids,
> +};
> +
> +BTF_KFUNCS_START(ksock_kfunc_btf_ids)
> +BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
> +BTF_KFUNCS_END(ksock_kfunc_btf_ids)
> +
> +static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc=
_id)
> +{
> +       if (!btf_id_set8_contains(&ksock_kfunc_btf_ids, kfunc_id) ||
> +           prog->type =3D=3D BPF_PROG_TYPE_SYSCALL ||
> +           prog->type =3D=3D BPF_PROG_TYPE_LSM)
> +               return 0;
> +
> +       return -EACCES;
> +}
> +
> +static const struct btf_kfunc_id_set ksock_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set =3D &ksock_kfunc_btf_ids,
> +       .filter =3D bpf_ksock_kfunc_filter,
> +};
> +
> +BTF_ID_LIST(bpf_ksock_dtor_ids)
> +BTF_ID(struct, bpf_ksock)
> +BTF_ID(func, bpf_ksock_release_dtor)
> +
> +static int __init bpf_ksock_kfunc_init(void)
> +{
> +       int ret;
> +       const struct btf_id_dtor_kfunc bpf_ksock_dtors[] =3D {
> +               {
> +                       .btf_id =3D bpf_ksock_dtor_ids[0],
> +                       .kfunc_btf_id =3D bpf_ksock_dtor_ids[1],
> +               },
> +       };
> +
> +       ret =3D register_pernet_subsys(&bpf_ksock_net_ops);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> +                                       &ksock_init_kfunc_set);
> +       if (ret) {
> +               unregister_pernet_subsys(&bpf_ksock_net_ops);
> +               return ret;
> +       }
> +
> +       ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> +                                       &ksock_kfunc_set);
> +       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
> +                                              &ksock_kfunc_set);
> +       return ret =3D ret ?: register_btf_id_dtor_kfuncs(bpf_ksock_dtors=
,
> +                                                ARRAY_SIZE(bpf_ksock_dto=
rs),
> +                                                THIS_MODULE);
> +}
> +
> +late_initcall(bpf_ksock_kfunc_init);
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index b508618bfc12..d221a180c877 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/filter.h>
> +#include <linux/bpf_ksock.h>
>  #include <linux/mm.h>
>  #include <linux/sysctl.h>
>  #include <linux/module.h>
> @@ -525,6 +526,16 @@ static struct ctl_table net_core_table[] =3D {
>                 .extra1         =3D SYSCTL_LONG_ONE,
>                 .extra2         =3D &bpf_jit_limit_max,
>         },
> +#endif
> +#if IS_ENABLED(CONFIG_BPF_SYSCALL) && IS_ENABLED(CONFIG_INET)
> +       {
> +               .procname       =3D "bpf_ksock_max",
> +               .data           =3D &sysctl_bpf_ksock_max,
> +               .maxlen         =3D sizeof(int),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dointvec_minmax,
> +               .extra1         =3D SYSCTL_ZERO,
> +       },
>  #endif
>         {
>                 .procname       =3D "netdev_tstamp_prequeue",
> --
> 2.34.1
>
>

