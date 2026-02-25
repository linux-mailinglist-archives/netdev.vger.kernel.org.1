Return-Path: <netdev+bounces-261036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLH6FWUyn2lXZQQAu9opvQ
	(envelope-from <netdev+bounces-261036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:33:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB8D19B999
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D6A23009F0E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4012D7DDC;
	Wed, 25 Feb 2026 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLJt3HM4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE82701B8
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040798; cv=pass; b=S4aoaYx4kvxcXuP5C3qRZllMZhm9kWtFu9f9DPQyVlnZLxM1TcXAM/VLEhgp0FE+3pba/26Syd8/xhKa7xZ7Zzjpg0yyVhTtdKGyCAOaxGd/OgB3ZqTkLCPHs+0mqP71r6kd/cGH9YnjhRkqs3/H5pvpn1g3hBEicRi8gOD+Vf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040798; c=relaxed/simple;
	bh=w02IPIF7J2gn5Rn+gftwuxa/HLDzgliPF7CUxMuwjzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ew6OD1aLFYcMo+1tnWztOd2snzK/Nqq2HikG/vo2X7HA4gOLv3iM79JvGr8ohAxlzaIMPp83XuGAod5sZNrgcTeomqiXte1vcEA2ztx6L3YuIjQTAk+VRBvHFKiw8bppMcZgXmkGENTpgj9MuTfZjjsblIpCgx6XfrRAHE2OvKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sLJt3HM4; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-124a635476fso6595177c88.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:33:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772040797; cv=none;
        d=google.com; s=arc-20240605;
        b=PqdgxczRli0QFgcfvy4RdyoPrBsL95fjck2WIJ+8dUXDH0V95274o/E16pfDOs2QzQ
         e9WjccMQp/AipHcnzh2BV6hqUaIVY+gHKsROTGolqzPfhAVDZQSmAsn9FMyfmZ4htrXC
         xNIYTxfir9DE0djEMAtA3A1aWamLbym7EnDIqX4xM+r4421B0fQ8x8mH5ESznLPxy+eJ
         +XtLWrlQqx08i9TJFgZbfmYarVGsQ2V2aYbIKrdxiARDQbdMWyG3q35/BBCzKOITZwji
         z0m+D9WXSkfhnCN74D/ne0EIkboTMRmpbA0I/IRTKET2cLiqmqjmQGd5PnsBnMZVpgQj
         g2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JiEF6rPe3vFGJQgN14rsqemsi/IS49dF85VU/kixOJM=;
        fh=FLlHnHuUKeJvZfGYSa3RhP9R22p19WrHxHnhwzbhyc8=;
        b=SZm4LKXyvojyHQ4z3emB42Y2xUdWkWQ6e53eq0BLpOVEhbv3OvD9xIcO570YzF2OTl
         HG7S3+bEHRi54KsM4hCQnGHJ+3tqF2MegW258mybLSEeqGJP20v+e4nq237aG2Nz9Zix
         Ku7Y5NzgfxsNrtoYAxsum1MwLX496Fl9Tyc+Brc3/J3oqwIAGdHZ8z638iYOLeJF192m
         FDsNtSJ8I1PHMSNZLWrMgRl6jtyK7cGW+yDSAdZtszRML58NHOKFQbw8u91ZEp6Oc0Rq
         WyiJNMpX0ww+Ke+A6cYR09n3eKqdqnkXuXSBedK8Gap2qvmi16HWtDw5reRZN6MJ86jI
         JUcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772040797; x=1772645597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiEF6rPe3vFGJQgN14rsqemsi/IS49dF85VU/kixOJM=;
        b=sLJt3HM4i2UA8qR7ZEzUzdu3L1QPGFUQPPjRQaCzjcPVqCmja6J5A8He0cWLM0nZV0
         s/7R1T3RHMGaVBSMqkV/jiRiXz30ccezUp1EyiunkF622TYff5uuQ+VTlaOGVuaEoUn8
         o/DCxeNtUDyj7Qyv1Wx2D6YcBQDDZJ8k3HeP35dtzlCmbC4drWkRcSrl4R1dX1e9HXCt
         Fi25wnbVgPWi4z8bKBGpWvk7h3dTE4bq729U2JDAhsofoe4buLIIXRLtyJIq5B1hTB0E
         D9H/D8ClWlSj2tUgaFTteSe1KzGynHE0qUI2RAI+x54WMmlpqsOSOGHFyq9R44bhjw1z
         1bbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772040797; x=1772645597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JiEF6rPe3vFGJQgN14rsqemsi/IS49dF85VU/kixOJM=;
        b=eYu0X7GVcWcazxQIqRbaJvvk0uNIR7Em9oHperHEKtVc72L3jatO2UGS9SZ2ouOiqw
         jQZO1ymqxKSySzMFYd7e6tcYyjcBsnB65B6nZA+fxdkXg9QJc+b1qYwWwKDAln5KKpkE
         FsbqamrjUP1r+8bFIoUma4W0wx//xLZx862lkAUfyJyf3/TfPWDMDQd9IcaI+6B5BY2n
         ZxunzE7+D6xs5JBeCOiMKj5Rngy6EM5RUL5IKEltrsSXs+9beNS8YVbOO18LFRFGz6Gj
         3ZSqicAjASST07AxQGQIMJtdb5WEJeIkHCzeRl5gLZ/qDAksSM4keaBjlwjipXsX5eBE
         mI+A==
X-Gm-Message-State: AOJu0Yyiyh8+6ZzG/6LbpaxxReTb1o4blxlBVX2fgU0gEJ/j5M52AsM3
	Zjr3Yb0+6qa38nlKYGyt9umnWGiwsNStS0SeNtfDDmUee8VuVsi1jbdWLERj4YkjjcHTZatX6qA
	nCyH80NRzVb8kovpcOPUnMFgFO4n1AjtZ4gez2sANt+pvof8Rm9KV7K6C
X-Gm-Gg: ATEYQzzXkEcJ071YmAxpcZ4h8ECIq6Uii/1TkVWol6bUu+P1iVjqp9TRjdPPB/cXj/I
	vflTtL7WGgMhO53YFo7gmQcfFBVeYGSERDd73U6zfgsXtQXmh/5uZspwaaeHqJpY1MPE53Ci7lB
	At7ypVvCzAadWQ4T7dWjnBk/Z153axqUXvMZ9hzIkB/7etLER40z5dR1Jn4fOlA8g61Ibmqsc8t
	/Ef0YP4oKto2zFLRXCJ56fWrURyVNEcLfDilGUgYvX8NMywbYv7vXwN5+o8dBMbcWu04yGQuD+B
	H82oNnuiHVF0MTWgu1aCgyThErS54DUipx4nDxCtDeZt6t5loygs8BlkM/CTlhUzuWBFhuBM
X-Received: by 2002:a05:7022:403:b0:127:1b8f:aa02 with SMTP id
 a92af1059eb24-1276ad11b97mr7732010c88.28.1772040795985; Wed, 25 Feb 2026
 09:33:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224150537.3800-1-fmancera@suse.de> <CAAVpQUAiCu3dJ56Le3_SSR2qg-+kKP3-HC09BRuVwbswEH=5kw@mail.gmail.com>
 <0e4c862e-cde4-4fa6-b9fa-3667429abf29@suse.de>
In-Reply-To: <0e4c862e-cde4-4fa6-b9fa-3667429abf29@suse.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 25 Feb 2026 09:33:04 -0800
X-Gm-Features: AaiRm53U9htNCkCVhsp-ezCGLM2CELp4sNu7rsR2hgkADdF-rhyLzHpbMjJ8mVw
Message-ID: <CAAVpQUBMPoUj57LGEyr9m4E54CTLeabSH2aZca+EcYzYRNBfXA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261036-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,0xffsoftware.com:url]
X-Rspamd-Queue-Id: CBB8D19B999
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 2:03=E2=80=AFAM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> On 2/25/26 7:28 AM, Kuniyuki Iwashima wrote:
> > On Tue, Feb 24, 2026 at 7:05=E2=80=AFAM Fernando Fernandez Mancera
> > <fmancera@suse.de> wrote:
> >>
> >> With the current port selection algorithm, ports after a reserved port
> >> range or long time used port are used more often than others [1]. This
> >> causes an uneven port usage distribution. This combines with cloud
> >> environments blocking connections between the application server and t=
he
> >> database server if there was a previous connection with the same sourc=
e
> >> port, leading to connectivity problems between applications on cloud
> >> environments.
> >>
> >> The real issue here is that these firewalls cannot cope with
> >> standards-compliant port reuse. This is a workaround for such situatio=
ns
> >> and an improvement on the distribution of ports selected.
> >>
> >> The proposed solution is to implement a variant of RFC 6056 Algorithm =
5.
> >> The step size is selected randomly on every connect() call ensuring it
> >> is a coprime with respect to the size of the range of ports we want to
> >> scan. This way, we can ensure that all ports within the range are
> >> scanned before returning an error. To enable this algorithm, the user
> >> must configure the new sysctl option "net.ipv4.ip_local_port_step_widt=
h".
> >>
> >> In addition, on graphs generated we can observe that the distribution =
of
> >> source ports is more even with the proposed approach. [2]
> >>
> >> [1] https://0xffsoftware.com/port_graph_current_alg.html
> >>
> >> [2] https://0xffsoftware.com/port_graph_random_step_alg.html
> >>
> >> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> >> ---
> >>   Documentation/networking/ip-sysctl.rst        |  9 ++++++++
> >>   .../net_cachelines/netns_ipv4_sysctl.rst      |  1 +
> >>   include/net/netns/ipv4.h                      |  1 +
> >>   net/ipv4/inet_hashtables.c                    | 22 ++++++++++++++++-=
--
> >>   net/ipv4/sysctl_net_ipv4.c                    |  7 ++++++
> >>   5 files changed, 37 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/ne=
tworking/ip-sysctl.rst
> >> index 6921d8594b84..9e2625ee778c 100644
> >> --- a/Documentation/networking/ip-sysctl.rst
> >> +++ b/Documentation/networking/ip-sysctl.rst
> >> @@ -1612,6 +1612,15 @@ ip_local_reserved_ports - list of comma separat=
ed ranges
> >>
> >>          Default: Empty
> >>
> >> +ip_local_port_step_width - INTEGER
> >> +        Defines the numerical maximum increment between successive po=
rt
> >> +        allocations within the ephemeral port range when an unavailab=
le port is
> >> +        reached. This can be used to mitigate accumulated nodes in po=
rt
> >> +        distribution when reserved ports have been configured. Please=
 note that
> >> +        port collisions may be more frequent in a system with a very =
high load.
> >> +
> >> +        Default: 0 (disabled)
> >> +
> >>   ip_unprivileged_port_start - INTEGER
> >>          This is a per-namespace sysctl.  It defines the first
> >>          unprivileged port in the network namespace.  Privileged ports
> >> diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl=
.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> >> index beaf1880a19b..c0e194a6e4ee 100644
> >> --- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> >> +++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> >> @@ -47,6 +47,7 @@ u8                              sysctl_tcp_ecn
> >>   u8                              sysctl_tcp_ecn_fallback
> >>   u8                              sysctl_ip_default_ttl               =
                                                 ip4_dst_hoplimit/ip_select=
_ttl
> >>   u8                              sysctl_ip_no_pmtu_disc
> >> +u32                             sysctl_ip_local_port_step_width
> >>   u8                              sysctl_ip_fwd_use_pmtu              =
         read_mostly                             ip_dst_mtu_maybe_forward/i=
p_skb_dst_mtu
> >>   u8                              sysctl_ip_fwd_update_priority       =
                                                 ip_forward
> >>   u8                              sysctl_ip_nonlocal_bind
> >> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> >> index 8e971c7bf164..fb7c2235af21 100644
> >> --- a/include/net/netns/ipv4.h
> >> +++ b/include/net/netns/ipv4.h
> >> @@ -166,6 +166,7 @@ struct netns_ipv4 {
> >>          u8 sysctl_ip_autobind_reuse;
> >>          /* Shall we try to damage output packets if routing dev chang=
es? */
> >>          u8 sysctl_ip_dynaddr;
> >> +       u32 sysctl_ip_local_port_step_width;
> >>   #ifdef CONFIG_NET_L3_MASTER_DEV
> >>          u8 sysctl_raw_l3mdev_accept;
> >>   #endif
> >> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> >> index f5826ec4bcaa..1992dc21818f 100644
> >> --- a/net/ipv4/inet_hashtables.c
> >> +++ b/net/ipv4/inet_hashtables.c
> >> @@ -16,6 +16,7 @@
> >>   #include <linux/wait.h>
> >>   #include <linux/vmalloc.h>
> >>   #include <linux/memblock.h>
> >> +#include <linux/gcd.h>
> >>
> >>   #include <net/addrconf.h>
> >>   #include <net/inet_connection_sock.h>
> >> @@ -1046,12 +1047,12 @@ int __inet_hash_connect(struct inet_timewait_d=
eath_row *death_row,
> >>          struct net *net =3D sock_net(sk);
> >>          struct inet_bind2_bucket *tb2;
> >>          struct inet_bind_bucket *tb;
> >> +       int step, scan_step, l3mdev;
> >> +       u32 index, max_rand_step;
> >>          bool tb_created =3D false;
> >>          u32 remaining, offset;
> >>          int ret, i, low, high;
> >>          bool local_ports;
> >> -       int step, l3mdev;
> >> -       u32 index;
> >>
> >>          if (port) {
> >>                  local_bh_disable();
> >> @@ -1065,6 +1066,8 @@ int __inet_hash_connect(struct inet_timewait_dea=
th_row *death_row,
> >>
> >>          local_ports =3D inet_sk_get_local_port_range(sk, &low, &high)=
;
> >>          step =3D local_ports ? 1 : 2;
> >> +       scan_step =3D step;
> >> +       max_rand_step =3D READ_ONCE(net->ipv4.sysctl_ip_local_port_ste=
p_width);
> >>
> >>          high++; /* [32768, 60999] -> [32768, 61000[ */
> >>          remaining =3D high - low;
> >> @@ -1083,9 +1086,22 @@ int __inet_hash_connect(struct inet_timewait_de=
ath_row *death_row,
> >>           */
> >>          if (!local_ports)
> >>                  offset &=3D ~1U;
> >> +
> >> +       if (max_rand_step && remaining > 1) {
> >> +               u32 range =3D (step =3D=3D 1) ? remaining : (remaining=
 / 2);
> >> +               u32 upper_bound =3D min(range, max_rand_step);
> >> +
> >> +               scan_step =3D get_random_u32_inclusive(1, upper_bound)=
;
> >> +               while (gcd(scan_step, range) !=3D 1) {
> >> +                       scan_step++;
> >
> > If both scan_step and range are even, an extra
> > increment here saves 1/2 calls of gcd().
> >
>
> Ah right, thanks!
>
> >
> >> +                       if (unlikely(scan_step > upper_bound))
> >> +                               scan_step =3D 1;
> >> +               }
> >> +               scan_step *=3D step;
> >> +       }
> >>   other_parity_scan:
> >
> > Doing "other_parity_scan" will be just redundant
> > unless scan_step is 2 ?
> >
>
> I have tried to preserve the parity behavior. Maybe I missed something,
> let me explain why it isn't redundant in my opinion.
>
> In essence, when calculating the range we first look at "step". If step
> =3D=3D 1 we use all the remaining ports as range, otherwise we use remain=
ing/2.
>
> If step =3D=3D 1 we do not care about parity so let's look at step =3D=3D=
 2.
>
> If step =3D=3D 2, we calculate a step_scan that is coprime with remaining=
/2.
> Once we have it, we multiply it by 2 so we make sure scan_step is even.

Ah, I missed scan_step *=3D step.  Then looks good.
Maybe we can set range =3D remaining / step similarly.

Thanks !

>
> Then it works exactly like with the current algorithm, we look for the
> even ports first, everytime we reach the high we subtract the size of
> the range (remaining is actually a bad name IMHO) and continue. When i
>  >=3D remaining (keep on mind that i is incresed by step, that is by 2 on
> each iteration), we start again for the odd numbers.
>
> They key piece is that step_scan/2 is coprime with remaining/2. As long
> as that holds, we should visit first all the even numbers and then the
> odd ones.
>
> Thanks,
> Fernando.
>
> >
> >>          port =3D low + offset;
> >> -       for (i =3D 0; i < remaining; i +=3D step, port +=3D step) {
> >> +       for (i =3D 0; i < remaining; i +=3D step, port +=3D scan_step)=
 {
> >>                  if (unlikely(port >=3D high))
> >>                          port -=3D remaining;
> >>                  if (inet_is_local_reserved_port(net, port))
> >> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> >> index 643763bc2142..c533374f656c 100644
> >> --- a/net/ipv4/sysctl_net_ipv4.c
> >> +++ b/net/ipv4/sysctl_net_ipv4.c
> >> @@ -822,6 +822,13 @@ static struct ctl_table ipv4_net_table[] =3D {
> >>                  .mode           =3D 0644,
> >>                  .proc_handler   =3D ipv4_local_port_range,
> >>          },
> >> +       {
> >> +               .procname       =3D "ip_local_port_step_width",
> >> +               .maxlen         =3D sizeof(u32),
> >> +               .data           =3D &init_net.ipv4.sysctl_ip_local_por=
t_step_width,
> >> +               .mode           =3D 0644,
> >> +               .proc_handler   =3D proc_douintvec,
> >> +       },
> >>          {
> >>                  .procname       =3D "ip_local_reserved_ports",
> >>                  .data           =3D &init_net.ipv4.sysctl_local_reser=
ved_ports,
> >> --
> >> 2.53.0
> >>
>

