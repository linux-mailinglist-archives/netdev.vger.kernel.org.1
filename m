Return-Path: <netdev+bounces-256770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BglDTl6g2nyngMAu9opvQ
	(envelope-from <netdev+bounces-256770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:56:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EA0EA9DC
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 723FE300D465
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDF433B966;
	Wed,  4 Feb 2026 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="azWpJzhZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED80313531
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223796; cv=pass; b=t9cDSv9YT8OgwODHm1EpOPvUQJbdMoSraPbvmkqR6JUoYnirE13H6KFKc3Wv/Ut/zncuhSxnbnfF4Z+4zAggao6NUjTrzIgu/uqcY3N17oh8TkZY2/aNf7CExpCPgLZBOekbfOqDVFFs+m919N+JZr4fRHyK1jH0LtBLs+sLOK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223796; c=relaxed/simple;
	bh=eZXiOYa+YgIWyQo8nyeElJuGHQ+T9jb0HyxCBdh7xOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqsTu6YgDX2Dy8HY27e5DRvrpKW7CA0Gihv13LypRO/sUjIgPTYl2lfnSVumrI06SHBN8IgHCnN/yDVTJzxNFyTCPBmFGNEJeskY7eohCart8iLSJW0pMEwZtpw+01zUp/Th0X7/ls5cZwk9Br9N9WAD5FTJjcOry16sFx7l3H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=azWpJzhZ; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50145d27b4cso347021cf.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 08:49:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770223795; cv=none;
        d=google.com; s=arc-20240605;
        b=A9YEJfcjiN8BJT0tFCBGbn08yAPk6KHgM+g5qeTpljYDAQwE94CB5WUupIWamNrfIQ
         Pfj/oDN++HxhMS9KCExIA2277y3dRcbKxC8MKIrQfU72mLHikMDdwpYtoBfLL17Qwn4g
         3yjznmaRe3gPj88bi6dOMyqsFhpbY8SSzKWuK2oOANVgSfgYA7iSls3mstbbgPPAOvzi
         QrdXonPra1tHlqLEuiYJvg+rC09avb1k7BRFokEL/q8e+cUuMMwEbTyByDH4ppA3eJ2j
         TzClH7EHoEJEyEZ1UAb2cXuMiZCigw9DHZAwvDKarGRIfrjORzD20aNdZUWppJ/vyhW3
         Rk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aRe0x1M46EJ4CWG3+IrlJG0CiJmZlofy/BFJHcRR0q8=;
        fh=w1m+jv64GJ3CE5zjizhh9RIjBpVp/wflsDWguyBPUuM=;
        b=UY+tjcXh4kx49biem+LyV9uDjGh+3sTl3D00c8hcKl7JPMZM3O4KNCFoqV0nlMjaE9
         a9o6dmrHV7UtI5vf8s/SpsXXG7/PtztvtDDdYViRSPWPaQN+GgwvTdAH7cyL0cALuaVW
         TsGDEAKB0oxooXOjyioLdVbUImA+809aoJVj+yiMfemy6TWpVTN/UT/y4g0M0ck4U65P
         CoJK9mwW9NyLBEi1WqwU5MyskctxywhhLfDEULqnvtg14kV5kwe7iWRX5vIPqpZXQs9E
         JDmfoRvZGUxavt10phFSrczbaaTZH2gHgz66YLcC5ajcG7TXiQT3Td23V1EercZvxxYA
         mpLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770223795; x=1770828595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRe0x1M46EJ4CWG3+IrlJG0CiJmZlofy/BFJHcRR0q8=;
        b=azWpJzhZTGWMPhDaAQfiQaRGDmGOWhVUfFRIZQPBKZjvgcTdnECA555WolpQdCpc+f
         LtigsJMIsMq61dQ55wVLxeYLRiEVbS/PF71fymilpR5ghoo6ZaCC0rSd6c60QQfGGSmq
         059VWPX/f8u6nHmrj8Woy+NIy8exe7XxaX2E0NqEd8Y3Ep8gNOBH4YmxtYBAhs/Kqsga
         U66cgi+Atmwpa7mME9MUTr2Ejapr88KbM2Z0j6eDxSXlas/2gKmzB2GmrEzQAePofMIn
         BenxbXJyb8Gx0y5RW1F6lvV4v/cAiDemPQ1Mj3dLi1BVaIfsv5dt3fHlEDEEUxQR69SK
         4GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770223795; x=1770828595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aRe0x1M46EJ4CWG3+IrlJG0CiJmZlofy/BFJHcRR0q8=;
        b=o/2zxBbzuZBOIZpft4VyL7NvtsqrLYdfZkyDkuRR6pbaCDJ7c+0kyzA8KXvFw2oUNc
         aFy0zgH/ml8WoR88k7grGMgn+Mm2kY//eFcpCihBaRy/iM1howbU+7l2TiBO982cMCr5
         eKUiGpbl7zSTVPwpKyYE7qv0wYubuoQ5OFszO0wOXTCowf7+BBPqqITbs68u7NX/qUuH
         YtP1MEKCjGkxLegbRq2cpS76vS13WS3SQ19sY1RfoXvnLqdTfanBQnnaOJFmpI9iOlwM
         MC/sfejoU3p5Se+dW2zWwGYobvcW+JvEDptNscv8JmBY7Cbt5ED5nDmnzUA2FvhvOBVq
         1q1g==
X-Gm-Message-State: AOJu0Yw6Q19i+YDSajhWdNDi5A0va0623h9E5UZrO1fpj6i0qSFmxMAE
	GMfSF8I/JdgUZsPiFRhGik1vPENjafi0GeBorpp8KUz+QAvQjtfIargvtYiAHdSUzHpF6FdGnAH
	kXvCUEa6hVm0zeKS3kUzfqR+VAi5FinQyVUcKfshk
X-Gm-Gg: AZuq6aJHsDbn/MFLDyGURcQYTqplkUt86SUduSCnBY6wxu2SdSyfOxptSkTdbyg3Xr8
	TuVa0NdoLCzYWdNGrqkILTqjT3RdFubPx2emU6W+xUg8oEffD7wmS1p0iSVNFOH8dYaBiO2/FEn
	ZdnpsEfiJFuvNYJMATIFV147H9WA8j3XZZcezlp7m7192O1OR+fhAzQOhbqup4ZgbmyBJtbp4Na
	K3xyR4QwLMqbdyUS/HnEHjFriKPuXlCHL6cy5u+KsKMKaxV6Luq0a8UAkKag99d1jOWI6+6AI/d
	aFoV
X-Received: by 2002:ac8:738d:0:b0:506:2041:13d6 with SMTP id
 d75a77b69052e-50620411977mr19815381cf.50.1770223795133; Wed, 04 Feb 2026
 08:49:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203175422.4620-1-fmancera@suse.de>
In-Reply-To: <20260203175422.4620-1-fmancera@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Feb 2026 17:49:43 +0100
X-Gm-Features: AZwV_Qj44cJ2ota2FAwO0HxsFEHXk2i5sKfOjlzY5l8m1_UEPSbTa3YebqEmj5Y
Message-ID: <CANn89i+UUWx5OhPnJnDhiCfr53BPTAGedBucgqYwyfqkidf_Cg@mail.gmail.com>
Subject: Re: [PATCH RFC net-next] inet: add ip_retry_random_port sysctl to
 reduce sequential port retries
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, ncardwell@google.com, 
	kuniyu@google.com, dsahern@kernel.org, idosch@nvidia.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thorsten Toepper <thorsten.toepper@sap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256770-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sap.com:email,suse.de:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 95EA0EA9DC
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 6:54=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> With the current port selection algorithm, ports after a reserved port
> or long time used port are used more often than others. This combines
> with cloud environments blocking connections between the application
> server and the database server if there was a previous connection with
> the same source port. This leads to connectivity problems between
> applications on cloud environments.
>
> The situation is that a source tuple is usable again after being closed
> for a maximum lifetime segment of two minutes while in the firewall it's
> still noted as existing for 60 minutes or longer. So in case that the
> port is reused for the same target tuple before the firewall cleans up,
> the connection will fail due to firewall interference which itself will
> reset the activity timeout in its own table. We understand the real
> issue here is that these firewalls cannot cope with standards-compliant
> port reuse. But this is a workaround for such situations and an
> improvement on the distribution of ports selected.
>
> The proposed solution is instead of incrementing the port number,
> performing a re-selection of a new random port within the remaining
> range. This solution is configured via sysctl new option
> "net.ipv4.ip_retry_random_port".
>
> The test run consists of two processes, a client and a server, and loops
> connect to the server sending some bytes back. The results we got are
> promising:
>
> Executed test: Current algorithm
> ephemeral port range: 9000-65499
> simulated selections: 10000000
> retries during simulation: 14197718
> longest retry sequence: 5202
>
> Executed test: Proposed modified algorithm
> ephemeral port range: 9000-65499
> simulated selections: 10000000
> retries during simulation: 3976671
> longest retry sequence: 12
>
> In addition, on graphs generated we can observe that the distribution of
> source ports is more even with the proposed patch.
>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Tested-by: Thorsten Toepper <thorsten.toepper@sap.com>
> ---
>  .../networking/net_cachelines/netns_ipv4_sysctl.rst        | 1 +
>  include/net/netns/ipv4.h                                   | 1 +
>  net/ipv4/inet_hashtables.c                                 | 7 ++++++-
>  net/ipv4/sysctl_net_ipv4.c                                 | 7 +++++++
>  4 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rs=
t b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> index beaf1880a19b..c4041fdca01e 100644
> --- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> +++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
> @@ -47,6 +47,7 @@ u8                              sysctl_tcp_ecn
>  u8                              sysctl_tcp_ecn_fallback
>  u8                              sysctl_ip_default_ttl                   =
                                             ip4_dst_hoplimit/ip_select_ttl
>  u8                              sysctl_ip_no_pmtu_disc
> +u8                              sysctl_ip_retry_random_port
>  u8                              sysctl_ip_fwd_use_pmtu                  =
     read_mostly                             ip_dst_mtu_maybe_forward/ip_sk=
b_dst_mtu
>  u8                              sysctl_ip_fwd_update_priority           =
                                             ip_forward
>  u8                              sysctl_ip_nonlocal_bind
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index 2dbd46fc4734..d04b07e7c935 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -156,6 +156,7 @@ struct netns_ipv4 {
>
>         u8 sysctl_ip_default_ttl;
>         u8 sysctl_ip_no_pmtu_disc;
> +       u8 sysctl_ip_retry_random_port;
>         u8 sysctl_ip_fwd_update_priority;
>         u8 sysctl_ip_nonlocal_bind;
>         u8 sysctl_ip_autobind_reuse;
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index f5826ec4bcaa..f1c79a7d3fd3 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -1088,8 +1088,13 @@ int __inet_hash_connect(struct inet_timewait_death=
_row *death_row,
>         for (i =3D 0; i < remaining; i +=3D step, port +=3D step) {
>                 if (unlikely(port >=3D high))
>                         port -=3D remaining;
> -               if (inet_is_local_reserved_port(net, port))
> +               if (inet_is_local_reserved_port(net, port)) {
> +                       if (net->ipv4.sysctl_ip_retry_random_port) {
> +                               port =3D low + get_random_u32_below(remai=
ning);
> +                               port =3D ((port & 1) =3D=3D step) ? port =
: (port - 1);
> +                       }

What happens when almost  all ephemeral ports are in use, and
hundreds of ports are reserved ?

Choosing a random value each time we meet a reserved port is going to
be quite expensive,
and we might return an error from this function even if there are many
available ports.

Perhaps randomly select @step one time at the beginning of this
function so that  @step/2 and @remaining/2
are relatively prime numbers.

