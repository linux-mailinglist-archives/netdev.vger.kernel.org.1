Return-Path: <netdev+bounces-301788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2drWFypTPGqimggAu9opvQ
	(envelope-from <netdev+bounces-301788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:59:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 594C46C1A58
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:59:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="gbCTZXP/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301788-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301788-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E812B30011A3
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FFD28C5CB;
	Wed, 24 Jun 2026 21:58:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF5E27603C
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 21:58:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338337; cv=none; b=gOWkZfKNjb1pqs6SgHd7o5tV0ZK4d5LIt+H/xSzZDFyECsGlpQAUowC/iHtLOXzAyqV+bkVaoH8Urx5Od77bmokAQmAV4QmKg6z6NX0yQ4P1P0cyh+/XqEADn8EH8rbmZOj9yc/XadBctNX2ui2Qcy4rgDtYBfBXisk9r/6Buxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338337; c=relaxed/simple;
	bh=u6KB/aQRjtRyaDPBAhCjbndKCOsNWyShdAA5uAsRHNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkXbFU6K6Tkone+/FlPxZ7+Rp2uNGCCsstkrOanfO/Dnv6nnA3J4GWdyr0LbUETjFilvD7j+jjWVTkobkI/wRycTCGopmuOIruQaIvK4mm79iN5J4rwVvsNm9AkbG9JaI/vIYgHEPsFiljDn+YV5K07Gm0SP+j0wnBeribMV69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbCTZXP/; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4922244f7c7so14021475e9.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 14:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338334; x=1782943134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZBTGaYLCBIBUPlxKggwg9gC0pqSaTNynGlDCKqwrYI=;
        b=gbCTZXP/V8yXX1oaWoENgHYVJ9Ahq2ZZFPUfPXn+FKMKG3FaFidP34s4PCIi1mhWcc
         BNqMnCvxyzxTpQW9Ro/I+2d7huBQWIAKbS+ios6HpzCkl7VQV7SIzVD8aLNdw2qPAFmV
         Lo7B4BxSooDzP2rF7U6u2/hI1qElZulcWRWIKHwGTSA20cY11tWnNGVxCvcXhPtN7zKh
         5BBebvjdS8E7TZt/Ghb+H+pWqQlAT3QXlHL4U4Og3HUVZ+dd1ZIV21fjj0GvdicIqzEk
         ipMGsP5oKdUykcCrDNbgxOHe27AdQONvg6tAXA1wF7zxa1fz9e72u6O5Qxfc+g/rYlBD
         1NPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338334; x=1782943134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZBTGaYLCBIBUPlxKggwg9gC0pqSaTNynGlDCKqwrYI=;
        b=oVfPbcOUeNjaSGAo2VHHqIKue7zEdnfj3G9s2LzWtIgSyvqG8PUNxhsWz6ZypCLT5C
         ynlfZfgMRYSpv9NBjy7Ar/Q7cZ8ZWyQZm+gyAJ6bvktUzmpsdVA4bBMjy9ui88XPF7uu
         rqRrKUw+6FwNPTunksRmoZYXGkfwmMD8s5hk3PfLKoli6a0vGN161sST2rNB6aCT+Nqu
         YEcYBf9TXxnnwTePlXkIyZ2VstYUZKvY4LkWUO6G1jNMonsfab+vkPcQqwcKbiTujwTe
         8Rj6Ni4GI0somh+9trhc55JnYBP9VSnwf6CfaOTAozud6RrLJBMsM+H4vxi8wNKno0WR
         zZUA==
X-Forwarded-Encrypted: i=1; AFNElJ/MI0jS3PSho+YE4y0rtD+1dGt6uKWG/E3PulKYbce7ucgtl6CAPOHSiuDIQLpK0e2/E17YLWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxweZHDxv3zUSQkkwhgTy6oe9R/V49IpcCUIfOtalYgwWic2cuY
	vjPz+Zp4hfMiQNvSMVqNWWaXJS0cM0GYsiLvtL2DmTC6juMh8Djd7NNt
X-Gm-Gg: AfdE7ckXobaLO/PB7N82XYdloAlAPRuHUg9oopKvxayujp47S/9O1hC0ad/U2I2YyE7
	CP8/AFP+2V2SL4u1C/kEGsbqbIabp55WWhYRj7MtBKbeDJYEwFc6Bdr8RATMlciy2fCZcxpKJnC
	C8Jvfb8EM9cAn2lBUCEERQxwLnbgO5NmlFApjkR0UT2usIMpfEaXvbmEObLCNbMdTgB0QU4Y1m0
	gphOA061wYrsLSUYa2aPTBldh4oVT/iyynnb5356QD1GYoV8M1EZfA8W5ec+QyUil9Z/kyo6hWO
	N64KRpMkGFGcBBaKIGJ168T1kiUHGKXLGO4aNl8zTStFLsuzB/XRWAYBr/KjXi7MeTnSNq8IsHQ
	QRf71AjDkIDdSw8Zc4RZudRXM6Ks2UvJEbocD5dQNRKfKCVGUGS7wV8TadMQXYO102r7L0zBWIK
	j0YzYilbqgbv29PYmOkWvw+nC2gD6cGCUF4zt65TjE7Ffx/nRx7y2KlkZrLp1OFWcsDh4X2O5+U
	j/b0rempOV0rTMXT5k/3WiXH6VrAun2VO2bjwxZyev7KLkpNwyzMj8vXHmd5WasDvLVtuwsrm6+
	kIUuyeIQ3qojL1qOLs14g6b3Fqc2LWdH
X-Received: by 2002:a05:600c:1906:b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-4926084aa9fmr73761465e9.3.1782338334090;
        Wed, 24 Jun 2026 14:58:54 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0046ffccb749d01d87.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:46ff:ccb7:49d0:1d87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee018e8sm10741158f8f.11.2026.06.24.14.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:58:53 -0700 (PDT)
Date: Wed, 24 Jun 2026 23:58:51 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Support BPF_F_EGRESS with
 bpf_redirect_peer
Message-ID: <ajxTGwDo3VLnehWG@mail.gmail.com>
References: <20260618182035.43811-1-jordan@jrife.io>
 <20260618182035.43811-2-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618182035.43811-2-jordan@jrife.io>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301788-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jordan@jrife.io,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:jiayuan.chen@linux.dev,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,jrife.io:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 594C46C1A58

On Thu, Jun 18, 2026 at 11:20:32AM -0700, Jordan Rife wrote:
> We have several use cases where a pod injects traffic into the datapath
> of another so that the traffic appears to have originated from that
> pod. One such use case is a synthetic flow generator which injects
> synthetic traffic into a pod's datapath to enable dynamic probing and
> debugging. Another is a transparent proxy where connections originating
> from one pod are redirected towards another which proxies that
> connection. The new connection is bound to the IP of the original pod
> using IP_TRANSPARENT and its traffic is injected into that pod's
> datapath and handled as if it had originated there. This can be used for
> mTLS, etc.
> 
> We use bpf_redirect(BPF_F_INGRESS) to direct traffic leaving the proxy,
> flow generator, etc. towards the target pod, ensuring that eBPF programs
> that are meant to intercept traffic leaving that pod are executed.
> However, this doesn't work with netkit.
> 
> With netkit, an ingress redirection from proxy to workload skips eBPF
> programs that are meant to intercept traffic leaving the pod, since they
> reside on the netkit peer device. One workaround is to attach the
> same program to both the netkit peer device and the TCX ingress hook for
> the netkit pair's primary interface, but
> 
> a) This seems hacky and we need to be careful not to run the same
>    program twice for the same skb in cases where we want to pass that
>    traffic to the host stack.
> b) We're trying to keep the proxy redirection / traffic injection
>    systems as modular and separated from Cilium as possible, the system
>    that manages netkit setup and core eBPF programming.
> 
> It would be handy if instead we could redirect traffic directly from
> one netkit peer device to another. This patch proposes an extension
> to bpf_redirect_peer to allow us to do just that.
> 
> With this patch, the BPF_F_EGRESS flag tells bpf_redirect_peer to emit
> the skb in the egress direction of the target interface's peer device
> While the main use case is netkit, I suppose you could also use this
> mode with veth as well if, e.g., there were some eBPF programs attached
> to that side of the veth pair that needed to intercept traffic.
> 
>  +---------------------------------------------------------------------+
>  | +-------------------------+         6. bpf_redirect_neigh(eth0)     |
>  | | pod (10.244.0.10)       |           ------------------------      |
>  | |                         |          |                        |     |
>  | |              +--------+ |          |      +---------+       |     |
>  | | 1. packet -->|        | |          |      |         |       |     |
>  | |    leaves ^  | netkit |<===========|======| netkit  |       |     |
>  | |           |  | peer   |=======(eBPF)=====>| primary |       |     |
>  | |           |  |        | |          |      |         |       |     |
>  | |           |  +--------+ |          |      +---------+       |     |
>  | |           |             |          | 2. bpf_redirect        v     |
>  | +-----------|-------------+          |___________________   +-------|
>  |             |                                            |  | eth0  |
>  |             | 5. bpf_redirect_peer(BPF_F_EGRESS)         |  +-------|
>  |             |________________________                    |          |
>  | +-------------------------+          |                   |          |
>  | | proxy (10.244.0.11)     |          |                   |          |
>  | | IP_TRANSPARENT          |          |                   |          |
>  | |              +--------+ |          |      +---------+  |          |
>  | | 3. packet <--|        | |          |      |         |<--          |
>  | |    enters    | netkit |<===========|======| netkit  |             |
>  | |    [proxy]   | peer   |=======(eBPF)=====>| primary |             |
>  | | 4. packet -->|        | |                 |         |             |
>  | |    leaves    +--------+ |                 +---------+             |
>  | |    sip=10.244.0.10      |                                         |
>  | +-------------------------+                                         |
>  +---------------------------------------------------------------------+
> 
> Using the proxy use case as an example, in step 5 we would redirect
> traffic leaving the proxy towards the pod's peer device using
> bpf_redirect_peer(BPF_F_EGRESS).
> 
> As a bonus, since the skb doesn't have to go through the backlog queue
> it can take full advantage of netkit's performance benefits. I set up a
> test where outgoing iperf3 traffic is injected into the datapath of
> another pod using either bpf_redirect_peer(BPF_F_EGRESS) or
> bpf_redirect(BPF_F_INGRESS). I used Cilium's eBPF host routing mode
> which skips the host stack and uses BPF redirect helpers to do all the
> routing.
> 
>   (net.ipv4.tcp_congestion_control=cubic,mtu=1500,100GiB link,Cilium
>    eBPF host routing mode)
> 
> BASELINE [bpf_redirect(BPF_F_INGRESS)]
>   1. [iperf pod] ==bpf_redirect([pod b], BPF_F_INGRESS)==> [pod b]
>   2. [pod b]     ==bpf_redirect_neigh([eth0])==>           eth0
>   3. eth0        ==over network==>                         [host b]
> 
>   [ ID] Interval           Transfer     Bitrate         Retr
>   [  5]   0.00-60.00  sec   231 GBytes  33.0 Gbits/sec  12060     sender
>   [  5]   0.00-60.00  sec   230 GBytes  33.0 Gbits/sec            receiver
> 
> TEST [bpf_redirect_peer(BPF_F_EGRESS)]
>   1. [iperf pod] ==bpf_redirect_peer([pod b], BPF_F_EGRESS)==> [pod b]
>   2. [pod b]     ==bpf_redirect_neigh([eth0])==>               eth0
>   3. eth0        ==over network==>                             [host b]
> 
>   [ ID] Interval           Transfer     Bitrate         Retr
>   [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec    0       sender
>   [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec            receiver
> 
> In this test, using bpf_redirect_peer(BPF_F_EGRESS) for the hop from
> [iperf pod] to [pod b] led to ~18% more throughput compared to
> bpf_redirect(BPF_F_INGRESS).
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>


