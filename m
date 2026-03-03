Return-Path: <netdev+bounces-263055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPlXHqmDpmlQQwAAu9opvQ
	(envelope-from <netdev+bounces-263055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 07:46:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2047A1E9C1B
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 07:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3793F30236A3
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 06:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7679386442;
	Tue,  3 Mar 2026 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAyAPJuC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA83386426
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772520355; cv=pass; b=OWMdp4Yr0NTnjJAJdsals9neWvfn+jlCZ2PSXVESkQsQf6RzI94yTZKZzV6W0EvSlFX9zxjWm4EBRwEh+rjD3EDk0ZVrpNX2f+qadWy9TlKYPRQuI2ENXgrUdjkqfcSJi7xoF6OPtVKwm0hCmA0JrGPNZJr6i2BgOBQkJw8WL+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772520355; c=relaxed/simple;
	bh=5lnQBvkFNhKhuISH+wQYNVN3JKSWEsxijzBAFbsBGFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBClYI7H6Jl4OimCfREbewg2dX+0aKAI1Cm8PjexPF7gJaMO4xHuRDqZUVGM/25MUEKOF1R2iB8ygS27sj+c48WUSgPOOyn2LtadoIOuPHw+FYpYEDiIvIWnpWniMuMbuWPg9UsLUnRdBWgNpNcY1NYJgN+MwkMwRAxdsrXTjUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wAyAPJuC; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1279eced0b9so2554472c88.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 22:45:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772520348; cv=none;
        d=google.com; s=arc-20240605;
        b=Ix41I5icdTW0r+2N7blwxelEFPFLBQ2SUyfM/qm2X/rfZIVyrVIjk7chVn1rbFxvhG
         rUFXKJvIrJGbgtnwlXRfcc1qE700xwRD720+mXmswKkczCwRmvWjzRbkYjEX0rsZmtwX
         3e11W/R2zYW8G964ITvfO2I+vckghe9XytAtfkET+7hD4I6rYn3Y0LfCPni+goFXVaQ7
         w/scVAprdAAFiDcWO1h7mIRkji7i/C+NVYyUyWNCztcbgj12S7eYs0WmZtipMVR16QLT
         PhbO8uXdmr6k+wTWhvHtp2RQBEDriGQPr02rCRB+wIk6g0jLMBcX9nHa4gxUtQU1/HX+
         yq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsEBUX9jUmm+hvz6sARfdjFHB6GaCMqCxJFL6MbdNb8=;
        fh=ktmI7hFceuhXePnl4dWcEZcMra6tLg/XBb6PPrxxW8Q=;
        b=cqq3UnMA5I5FOG2d9477jsrTLE8n2+o7h2/nZDXhNC0UIraxhbuGYj11Ty+zsFzb/c
         LugpVEeJm+qRfxDN+6HWIn7kYWwVgnO6qq+7QDfD51BsKRcGF5SzzYBMVxyIDfwHSvVt
         +E484d9bft//ovBrbBpKKOxc5CFvPF3SkKLZaEM6xiYB6dWns2i8VAeyBIqA5zxZIwBd
         NtPxNP2QeGtV4/BMLG5Anooa6h6JKc8ypcgrVv8frVJEW/TLXMQOBs5EwSJ4z3EvVM25
         f5kuH60Kx8VMetl7zHeHF+evm07KBmCswT/ozPowpI2a0QiDrtW8RpHKaBjcgEvEh//v
         nETQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772520348; x=1773125148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsEBUX9jUmm+hvz6sARfdjFHB6GaCMqCxJFL6MbdNb8=;
        b=wAyAPJuCFv+7FaD2LD3xH1RXdZx9/eT2/SpSh5s1QNr4ZNzEHnbMWOQeeLFTNnItoE
         xywk/AXrIMHjJVYpvA1JFhLHeTpSqDJrVLngZ29l7hM+31O1E8kuwojc0WNladKToLWk
         DB70KID8DIC2cdvVAStI0+gez4V6ZWDnA45K+MkC7QSnJ8oapthXoCeX1HX+GpZ1DdKt
         sv8bmZHmopVqB9/Tu/eXhAj+c/J9lDhPuXWTyln3M1Evx6ZxFrKq7y9RPdPT4YAQ6m+H
         mVzuMopcs95MQqHg9EsQ7VXH8XypTXeJ7MOXsH6gT4UCmoEFXGx+B7gqEUi1bRwocSq9
         yD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772520348; x=1773125148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TsEBUX9jUmm+hvz6sARfdjFHB6GaCMqCxJFL6MbdNb8=;
        b=NXAef9bY61gYK+yz+tJ3J41HOBaXMUmB8/AS0DB5e8ys0H7C7lxOfiQ6cnabBzOzQK
         excgMYgTuV56+b+LNmi5+O2VxQdVlFQGObFuv6wqfbOgaAYGkZRQDWoBgDaaRyn5I32a
         eAYaf8aha9r1XtrStbpy20gX/Mhk4k7RZSA7IOelDQWe7MRqHYGwN5AlgWmhbnNlXQ4m
         5mZp1loEPBLpFri81lHSJ+81UA2lFQPaU6268B1yuaJxqPQLszyCqYoGDGbqatG53HqY
         dG3NUmYyYfQCZ7BWR5vtpNuZUKHc3mD7Bg9EgMLmUeB+KZB8PSvXsO5wMf4J1ZTdzdye
         NoMw==
X-Gm-Message-State: AOJu0YxBKDZjBZ8SONHoWlO58byUktJvsXTkVRuOOoJVbZ2eW30s3srS
	MKMl7Ku5p/3Ani6J8LjWXo3I1iKAv5dVAJz2HIOs9KtNxU4LBVSVIbQPXTDqsbvVQeHnZhpFiZQ
	IXv3VwLQ+muyBzgYKWa7SgwY6RfyIn56am5soLq+2
X-Gm-Gg: ATEYQzz4K5u6sIHLd979YAHvSq1zm0HyjuZINertAV4R1BvCLUoTbQEPJd8H0EsQIMK
	ouLl0NXpKd9Yz1d+jYC3q9j3uZsCOnbWnBcpOJJXdNCW5Fw9+cj4gUuV/kl/pCLYpps1MWVTYOk
	LE/szojZUT1Iwk8NNYKYWeBxIJC30GEfU2prI+hZ3LMYjW63N8yFlGGWfX6lEJbTa0/h+23G0q4
	mu7Nwepfotwkt3u+Fja51mniJaQWVVJxWyHCT1+I3Onceamn/9G6pg6xXcVwxLpYD77E+ogA/HB
	d2cuaM1MGU72Riek0tvqRVpxav5Cpzos2KuT8S/hwTSIiL1R7aUo7qnr95BgMYskKmO3JCI=
X-Received: by 2002:a05:7022:51e:b0:127:5cda:aaf2 with SMTP id
 a92af1059eb24-1278fb77ea5mr7086828c88.10.1772520347238; Mon, 02 Mar 2026
 22:45:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302125303.4553-1-fmancera@suse.de>
In-Reply-To: <20260302125303.4553-1-fmancera@suse.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 2 Mar 2026 22:45:35 -0800
X-Gm-Features: AaiRm51nAuIEygVGylZzQ0WedDgL1vPIQRHPDN_kcGsZpN7XCkqegB5B76PvFnk
Message-ID: <CAAVpQUDBvBqdFZq-0Z0n+PcwxG1jFbR-YO7zeTTBurGty+T1rA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] inet: add ip_local_port_step_width sysctl to
 improve port usage distribution
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chia-yu.chang@nokia-bell-labs.com, 
	idosch@nvidia.com, willemb@google.com, dsahern@kernel.org, 
	ncardwell@google.com, skhan@linuxfoundation.org, corbet@lwn.net, 
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, 
	davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2047A1E9C1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263055-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,suse.de:email]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 4:53=E2=80=AFAM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> With the current port selection algorithm, ports after a reserved port
> range or long time used port are used more often than others [1]. This
> causes an uneven port usage distribution. This combines with cloud
> environments blocking connections between the application server and the
> database server if there was a previous connection with the same source
> port, leading to connectivity problems between applications on cloud
> environments.
>
> The real issue here is that these firewalls cannot cope with
> standards-compliant port reuse. This is a workaround for such situations
> and an improvement on the distribution of ports selected.
>
> The proposed solution is to implement a variant of RFC 6056 Algorithm 5.
> The step size is selected randomly on every connect() call ensuring it
> is a coprime with respect to the size of the range of ports we want to
> scan. This way, we can ensure that all ports within the range are
> scanned before returning an error. To enable this algorithm, the user
> must configure the new sysctl option "net.ipv4.ip_local_port_step_width".
>
> In addition, on graphs generated we can observe that the distribution of
> source ports is more even with the proposed approach. [2]
>
> [1] https://0xffsoftware.com/port_graph_current_alg.html
>
> [2] https://0xffsoftware.com/port_graph_random_step_alg.html
>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: used step to calculate remaining as (remaining / step) and avoid
> calculating gcd when scan_step and range are both even
> ---
>  Documentation/networking/ip-sysctl.rst        |  9 +++++++
>  .../net_cachelines/netns_ipv4_sysctl.rst      |  1 +
>  include/net/netns/ipv4.h                      |  1 +
>  net/ipv4/inet_hashtables.c                    | 25 ++++++++++++++++---
>  net/ipv4/sysctl_net_ipv4.c                    |  7 ++++++
>  5 files changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index 265158534cda..da29806700e9 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -1630,6 +1630,15 @@ ip_local_reserved_ports - list of comma separated =
ranges
>
>         Default: Empty
>
> +ip_local_port_step_width - INTEGER
> +        Defines the numerical maximum increment between successive port
> +        allocations within the ephemeral port range when an unavailable =
port is
> +        reached. This can be used to mitigate accumulated nodes in port
> +        distribution when reserved ports have been configured. Please no=
te that
> +        port collisions may be more frequent in a system with a very hig=
h load.
> +
> +        Default: 0 (disabled)
> +
>  ip_unprivileged_port_start - INTEGER
>         This is a per-namespace sysctl.  It defines the first
>         unprivileged port in the network namespace.  Privileged ports
> diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rs=
t b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> index beaf1880a19b..c0e194a6e4ee 100644
> --- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> +++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> @@ -47,6 +47,7 @@ u8                              sysctl_tcp_ecn
>  u8                              sysctl_tcp_ecn_fallback
>  u8                              sysctl_ip_default_ttl                   =
                                             ip4_dst_hoplimit/ip_select_ttl
>  u8                              sysctl_ip_no_pmtu_disc
> +u32                             sysctl_ip_local_port_step_width
>  u8                              sysctl_ip_fwd_use_pmtu                  =
     read_mostly                             ip_dst_mtu_maybe_forward/ip_sk=
b_dst_mtu
>  u8                              sysctl_ip_fwd_update_priority           =
                                             ip_forward
>  u8                              sysctl_ip_nonlocal_bind
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index 8e971c7bf164..fb7c2235af21 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -166,6 +166,7 @@ struct netns_ipv4 {
>         u8 sysctl_ip_autobind_reuse;
>         /* Shall we try to damage output packets if routing dev changes? =
*/
>         u8 sysctl_ip_dynaddr;
> +       u32 sysctl_ip_local_port_step_width;
>  #ifdef CONFIG_NET_L3_MASTER_DEV
>         u8 sysctl_raw_l3mdev_accept;
>  #endif
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index fca980772c81..27f29a9376ad 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -16,6 +16,7 @@
>  #include <linux/wait.h>
>  #include <linux/vmalloc.h>
>  #include <linux/memblock.h>
> +#include <linux/gcd.h>
>
>  #include <net/addrconf.h>
>  #include <net/inet_connection_sock.h>
> @@ -1046,12 +1047,12 @@ int __inet_hash_connect(struct inet_timewait_deat=
h_row *death_row,
>         struct net *net =3D sock_net(sk);
>         struct inet_bind2_bucket *tb2;
>         struct inet_bind_bucket *tb;
> +       int step, scan_step, l3mdev;
> +       u32 index, max_rand_step;
>         bool tb_created =3D false;
>         u32 remaining, offset;
>         int ret, i, low, high;
>         bool local_ports;
> -       int step, l3mdev;
> -       u32 index;
>
>         if (port) {
>                 local_bh_disable();
> @@ -1065,6 +1066,8 @@ int __inet_hash_connect(struct inet_timewait_death_=
row *death_row,
>
>         local_ports =3D inet_sk_get_local_port_range(sk, &low, &high);
>         step =3D local_ports ? 1 : 2;
> +       scan_step =3D step;
> +       max_rand_step =3D READ_ONCE(net->ipv4.sysctl_ip_local_port_step_w=
idth);
>
>         high++; /* [32768, 60999] -> [32768, 61000[ */
>         remaining =3D high - low;
> @@ -1083,9 +1086,25 @@ int __inet_hash_connect(struct inet_timewait_death=
_row *death_row,
>          */
>         if (!local_ports)
>                 offset &=3D ~1U;
> +
> +       if (max_rand_step && remaining > 1) {
> +               u32 range =3D remaining / step;
> +               u32 upper_bound =3D min(range, max_rand_step);

nit: reverse xmas order

> +
> +               scan_step =3D get_random_u32_inclusive(1, upper_bound);
> +               while (gcd(scan_step, range) !=3D 1) {
> +                       scan_step++;
> +                       /* if both scan_step and range are even gcd won't=
 be 1 */
> +                       if (!(scan_step & 1) && !(range & 1))
> +                               scan_step++;
> +                       if (unlikely(scan_step > upper_bound))
> +                               scan_step =3D 1;

gcd(1, r) is unnecessary, so we can just break here.



> +               }
> +               scan_step *=3D step;
> +       }
>  other_parity_scan:
>         port =3D low + offset;
> -       for (i =3D 0; i < remaining; i +=3D step, port +=3D step) {
> +       for (i =3D 0; i < remaining; i +=3D step, port +=3D scan_step) {
>                 if (unlikely(port >=3D high))
>                         port -=3D remaining;
>                 if (inet_is_local_reserved_port(net, port))
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 643763bc2142..c533374f656c 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -822,6 +822,13 @@ static struct ctl_table ipv4_net_table[] =3D {
>                 .mode           =3D 0644,
>                 .proc_handler   =3D ipv4_local_port_range,
>         },
> +       {
> +               .procname       =3D "ip_local_port_step_width",
> +               .maxlen         =3D sizeof(u32),
> +               .data           =3D &init_net.ipv4.sysctl_ip_local_port_s=
tep_width,
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_douintvec,
> +       },
>         {
>                 .procname       =3D "ip_local_reserved_ports",
>                 .data           =3D &init_net.ipv4.sysctl_local_reserved_=
ports,
> --
> 2.53.0
>

