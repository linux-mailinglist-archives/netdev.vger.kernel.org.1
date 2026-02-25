Return-Path: <netdev+bounces-260773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA/VCZSWnmnXWQQAu9opvQ
	(envelope-from <netdev+bounces-260773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 07:28:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 927A81925BE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 07:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6D2A30B68DE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 06:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2D02F7478;
	Wed, 25 Feb 2026 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwV2+aeZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C752D6E74
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772000896; cv=pass; b=KeBJC/YtAnc4qWnheo2TYIwpGzyEMNJYvpWEZPRSlAQdGc8N+m6kXAyZ1boVuT0svyn6+8HjD2Lose49dpHh1exjfeYHbohTf2elc+KvppPw4HvEH/5Vo1jHPgaN9x78pSkGz/F0lkHlLfEld8kYFiU7o57JK8geo4++TO6dJfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772000896; c=relaxed/simple;
	bh=S8ghA9XwulJojWuvFLQnVkVgHS2xZ2z+rkXk1G2Oej8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saxXCPr0Y7C4RSfxz/LLLd0xXs3KjDLcnhO5iogAP/L1198iEqJH2pig0dl6BTRXj3L67YbJD9X72vOHcuvn51R2XiTsw5BFGOUh/0N6KCjqDmeDr5u1bV8+VUQN21LiO1N9aNGlUIXEiZfIeMpiZmmiAjA8TvuWBR4ozzu8zq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uwV2+aeZ; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12758ce1e8dso2483459c88.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 22:28:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772000893; cv=none;
        d=google.com; s=arc-20240605;
        b=ftN5CKp6ryRN7FpTUelMY693Kk8QX3I1ZaPXcmmywYpmmgZCjeg+CtrURKWlxgmJS/
         9KMZnfwZViX5fS0WKppLHY7xzsWh8BykgYjRD+U7rfSpXqBZOsXFtZBupKEKCjRs3ht8
         wEB17HVUxdp1MpwQ1Hv6neOI9UQ+QijDYCcZP78RqBVlC9pyfXHkSEa3StQDQO14drQt
         A5WgdRi+1HNN+r3+VbyqTYq6Sb/C0YeMl2nPrgvay+dHR6DKvuyr4YmIS/7Ohv/Xw6Fm
         SCnr2vFA9/3u1QrQ+lcaKt26FmyOBi3nI8GbUpoQokSkrNosjAbox7ZEATui58YwmgzY
         ks4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YXe2uqlVVjdJBRpke7lTXWPdQOl+Dt+uU2mjZiKMSv4=;
        fh=FLlHnHuUKeJvZfGYSa3RhP9R22p19WrHxHnhwzbhyc8=;
        b=SpV7Zg6QSX4lm6EYoVP7366g5LYGmHG235gXPtYo/d0sUH7HqvrY2xR8xqkvhPkT24
         3Pi0ndcZyAirBVhn5lRFXAe2Bq/eB5NgqpMI0ONpw5vpzX/I8+zZUwkAT+esPvdf12HQ
         8KfOkEjvq8574+L1MnACFrX5q/dPvbdsQHK9TMerzZ5Dn/2vnYNBR2d36nXmBHy1LGYM
         hQ4KKjlEpMWEgSq1whWVqKqeYZ7AVkBIkKQXlSjCB7W2OBrIxkfQTPWK2Zuj+Is+jMb3
         fZODdabY7bs1oSeg9OHsvJgyeaYECDNCWajo/O/9LJBi8eEv23Y1NE+q6HDBFfXPsWmi
         /cGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772000893; x=1772605693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXe2uqlVVjdJBRpke7lTXWPdQOl+Dt+uU2mjZiKMSv4=;
        b=uwV2+aeZTqOJhIy2LwZikrUDdcyGUErxQ0RlZNZ8ydXU1p47MSHIOxneJ7GEcg5aqg
         YPxEQ7ObTOV7Lif+npIk+5Ws23Nt95UOd/sNUbC4aG3KEvCdQmQnef/NFvCBtFimP+B3
         tm6lu6KXb1q5qavJ0oMN/T1LOpUuJk7sgQm3WjSUK/j/y2nOeGFQD4VEvlfc/gczwrjt
         Z/U1DGqnD7A8znGCI/jwPI4DyH56h7wh32rfJUO4SQ+MpmsCRElBqHYRnT7IqSZv7plj
         xqAzlCQRH9tyKuR/Nx9T5lGi25uWGEwwUd9q7L/k7BslRaEWkcLUEOSQdBx/bM9kDdK6
         427Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772000893; x=1772605693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YXe2uqlVVjdJBRpke7lTXWPdQOl+Dt+uU2mjZiKMSv4=;
        b=pX9Fwn9x1Mc+aRJostnu8ffEBhtMooNR1Zq8a+D+asmG7Kz03phLG+c7Lwz2wjh5yf
         mUDnGbfOtsLQcCZR1a+PCUq1a5VFD96D+NJEnTg5L4y1Myj+sa8MoRpf/GJKcKDU0s8/
         pO5UIOW9mESsmpoQN/utGAHkMtBPNQ370jl5OOlxicMGzYANINc4s5JHH2KPN4ZWX7SQ
         ABEIskKziB4Nc9xhQ/mQrq/OmumSaiIPW3T73McQcRkWvi6T7vkSE8hiGNyzcBqX4mb/
         b9hnk/MxvheOZo3hyIHI9J3GHiJVrJdHVW2rsvF0aYPLb28wTV2HPBlxKPCUqt01kl7y
         B0Ng==
X-Gm-Message-State: AOJu0YwXxjexA4oA05vLnoTjDIuVV7a+E1TjEh+Y4cnf845M3jRauJiu
	tJLaB4upLo03i/MnMjA0jsBtp4zWvof1GPqKTnUBQJESdjo0cDF8vP4qixMLZIDLgqFJLC9kgVn
	SCFGrkjupAS7Hqp39eLxU2kz+WrheKp0L3Rb6+frI
X-Gm-Gg: ATEYQzxzD+nZUzDm9ytSmlRX5aofTdreILHXViagxFBIq4BSMHHcO7QKkDFKW+Fd4j7
	1tuY9yJeoxbvHmGFz/qYHqXhQH9R9GaSXekAEKNbD6jeSlirTcBcLfItrPrbUAio5Kb52DeBdht
	XZ+7iDA8rXzG+Hkyzu8WJ1/PjM3wn9ORTgZtWb+3qjo8L0yyfgiE5G94pIMHTt4682afwZRWi2F
	ATibiw6emJdIKgPeXqKWlLq8HPvTXfEFXudWOVlHGm6pMsa+zCKJZrv/jx8GGRBm5XColhfoN8U
	0oWj2AT+lwxow1nplv2nNnyr8i/BJLmq2LDL90ts4j3tD7ErNwOby3Lh+3+dvGmvWqE/ONwshHB
	1nkauurs=
X-Received: by 2002:a05:7022:e19:b0:125:be41:db5b with SMTP id
 a92af1059eb24-1276ad8c051mr7235944c88.42.1772000892762; Tue, 24 Feb 2026
 22:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224150537.3800-1-fmancera@suse.de>
In-Reply-To: <20260224150537.3800-1-fmancera@suse.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 24 Feb 2026 22:28:01 -0800
X-Gm-Features: AaiRm53irC5e8YCCwuMSV4MJ8fEnzE8wiqEDwQOfrjK2rHTLhV4qw9ewwnD1fZo
Message-ID: <CAAVpQUAiCu3dJ56Le3_SSR2qg-+kKP3-HC09BRuVwbswEH=5kw@mail.gmail.com>
Subject: Re: [PATCH net-next] inet: add ip_local_port_step_width sysctl to
 improve port usage distribution
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ij@kernel.org, 
	chia-yu.chang@nokia-bell-labs.com, idosch@nvidia.com, willemb@google.com, 
	dsahern@kernel.org, ncardwell@google.com, corbet@lwn.net, horms@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260773-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,suse.de:email]
X-Rspamd-Queue-Id: 927A81925BE
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 7:05=E2=80=AFAM Fernando Fernandez Mancera
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
>  Documentation/networking/ip-sysctl.rst        |  9 ++++++++
>  .../net_cachelines/netns_ipv4_sysctl.rst      |  1 +
>  include/net/netns/ipv4.h                      |  1 +
>  net/ipv4/inet_hashtables.c                    | 22 ++++++++++++++++---
>  net/ipv4/sysctl_net_ipv4.c                    |  7 ++++++
>  5 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index 6921d8594b84..9e2625ee778c 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -1612,6 +1612,15 @@ ip_local_reserved_ports - list of comma separated =
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
> index f5826ec4bcaa..1992dc21818f 100644
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
> @@ -1083,9 +1086,22 @@ int __inet_hash_connect(struct inet_timewait_death=
_row *death_row,
>          */
>         if (!local_ports)
>                 offset &=3D ~1U;
> +
> +       if (max_rand_step && remaining > 1) {
> +               u32 range =3D (step =3D=3D 1) ? remaining : (remaining / =
2);
> +               u32 upper_bound =3D min(range, max_rand_step);
> +
> +               scan_step =3D get_random_u32_inclusive(1, upper_bound);
> +               while (gcd(scan_step, range) !=3D 1) {
> +                       scan_step++;

If both scan_step and range are even, an extra
increment here saves 1/2 calls of gcd().


> +                       if (unlikely(scan_step > upper_bound))
> +                               scan_step =3D 1;
> +               }
> +               scan_step *=3D step;
> +       }
>  other_parity_scan:

Doing "other_parity_scan" will be just redundant
unless scan_step is 2 ?


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

