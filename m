Return-Path: <netdev+bounces-263613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACYzLgLap2kRkQAAu9opvQ
	(envelope-from <netdev+bounces-263613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:06:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 550AC1FB5EB
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2032F30751B4
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0BD37EFFA;
	Wed,  4 Mar 2026 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgGXYhJp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A189C370D73
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772607971; cv=pass; b=d+EkiGR6qwdMEXmq4wQI2PxESGEE7s3nObVzwleMOP9IiXYdG4lOs12vEQEVuSBT/4mU66lA2THubMtCbAZfvS6Jyttj+zUjUwCGcFg7ry5Dk9hXA5rpKN7OJ2HXmlLh8NtxADekRszYx0WovAbOfj8nPQpt7DSNOAH6c3CDZnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772607971; c=relaxed/simple;
	bh=5FMa/KTakjsB2RpAU5JFI/6InFaYGKgA6rSgGqMbG0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePAQAS074nNCNGTV4afMWFErCjN8aOIaqhE4yoJHdbgbXCbbSpMi4xj/N/4NfbWY0wHcpso92x0ZQq1XYIjGwYd1ZLUndSCInw9HV5ccr49PzLz/peyTJwOG7SonFxZ3WhsTagrYOSfYt8tdoOtzEJS8qIYjl1EBS5zqZ6gQWLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fgGXYhJp; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7927261a3acso56989257b3.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 23:06:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772607969; cv=none;
        d=google.com; s=arc-20240605;
        b=R/F73JaWwlOpgwlhSxuIWOnTD6c6TyR+3hT6UWd3FdPeSJS91zogtJJG2K+KQMM8M2
         rWDR9rlIDofRnAaGOAFixH0rMVRHMYeq2VtHcNUeGwnfImdQ9X4MOi3+T2FdZCJBo78f
         YrEQ7akOneQYFmOSNPt0n/aRAoNI3aeklBWTfzKvRvJp2kJK1mLDN19p5nHVNzmZE6Nj
         J0zjJnfX1yGIZUloNJu2ZDSSxQFM0EtjXya+F2nclc8Kxi7WTW4PLTRvALq9x5sk9M9b
         SfsRvOU1HVFG3sq1m3tMzIrC8KYhW0M/Gdi69bxaFzvGeO+1BKlCLqfB7gnphKFZG7Qt
         7iCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AZiJ0P6FeuXfkf1uICr5BAvwgdVgvq6hWrZTwzE0OBM=;
        fh=cPGHXiYpXYEBw2Kkuyvs5mR54tnTG5+sdC/EpubVwy8=;
        b=JvyoYbo2u1Kpu2DjcmyBOCBoFtvhsMVsvF2VWSXZr0K6kJOyhTZALQrN1qr8g/m0gk
         8+usgyIUNaq4xhtBmY6TUQMtltfel7f6vrevFCv5Lm8tjF46t3+F2aLCsPdy1YBUb1fo
         nH/2uNdHwBkShuKA54MWQI1BvdKdwou7EPMFMvHPYaIru7PoiTwvPGnJ2oml/Bdhw32U
         pwpf5GDR+McKTawT6OAvYkfodntBGzlmPXO0IGGCmZvXJHmnf/5Laz4Mf3YK3NdN2c5h
         42JgfAQ6P19cB5jzg0M6R7nSv2xNeY2FeempiRVflqP4wG4SyH2Ytx6HamfWWKAZoj53
         UAtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772607969; x=1773212769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZiJ0P6FeuXfkf1uICr5BAvwgdVgvq6hWrZTwzE0OBM=;
        b=fgGXYhJp6yuRgSzT+30Bf4yGNKadTNZrK5KOoMiTTjtRABXAN1Hc6+DFdllLZVhUcq
         vfIHqwuEYAiq/6oJUgiPLhxs8SIDZ7uYT7gZVVI3VezKWmczWMypL1O4Utc2A57zU16w
         P6wulT8l4+r3APO6vJdNSWtMI+4Mtqb0axYzzKmV6ltHDe7dumA4wqPREouTE1X5AFBx
         fF18EQWUUKtJwiEi50LwhWRh9aQrVSZmQCu0dckT16pbD0f8BXpsaLXmRTIp7Y/MA0wQ
         npN3ZIJjtY6C33S8Us/YrDVuUiUkUhtfQ5ECX1/uSyKKMuZePh+Gk8EbgjkK0KoMDZsu
         X7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772607969; x=1773212769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AZiJ0P6FeuXfkf1uICr5BAvwgdVgvq6hWrZTwzE0OBM=;
        b=IAbPCVqUlFM2GQePPObn2BOQcl4kDO0FZAYGoMUREia2HtftmQ8IpmX6dxVb3F6tm3
         lZAS4Yhieka6kqXzwOcpTnBnvZoyXV2yINigA+exABPAVtKQwpUxJM5J+I0Zx0PEfP3D
         cnQe6ltdPwxggzWt1RSgKKbyUE2ckTbt35MehKCm364hmtg5IQr/24NWu27bvsXIHtIN
         zsJQDouv+gpA+QTKdtxMmj31k9cNXpwgWY4Srtqlt0yYZR7ioovX2QDaFJv01vCDE2ql
         OeYkUMwj0dRMLx39i/0ug0wP0NaZ80Bbf6GeTMG6SESJi8GAhOK3UtndHMvqvz2HEuf+
         XQLw==
X-Gm-Message-State: AOJu0YxxdYHSQg55wo5JgTlA2Et9n9nWCoVAtaXII6nH/8/8/4xQ9QqG
	RCekqI4sPh+ma8cVXfTsCI+yGt4S1G1Uw8ED6kvxNEkaeJTk7uU4l90dXsVb7npVF/65gE1Wdz2
	k3QZcKHp/2asRLuKtgzf9xIiGkEJECwMsYEFUeojI
X-Gm-Gg: ATEYQzy/oBBZHIV7qYAt5N3Tit+uyzPIr044bog83Y4N8SgePquN2JAxNH6e5UD7Xdz
	OSgdCUg/sza3jXfvL1RiGFcD7m2FahTdWjxl4JALyMKW0DXtB9MJZrGiivyHNONxtisvAsbZnSz
	1l1xsUVkS4LPM06lF1A8rjNsdZnMLUj2Vum8hx/TQxf2xXMv+sFffyTNMigkRadpNaj+VSd/WOw
	KPXT62yzTPZ+UZArPhn9VHFq+h7PqWi+WuI3htP55aoxB/H7tIqO79w2oCFQ23hl2tvLoIcc3iJ
	3AqUf9+myGOYr5WsdJs=
X-Received: by 2002:a05:690c:18:b0:78f:9801:7606 with SMTP id
 00721157ae682-798c6ca0062mr7711847b3.34.1772607968270; Tue, 03 Mar 2026
 23:06:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303172949.4741-1-fmancera@suse.de>
In-Reply-To: <20260303172949.4741-1-fmancera@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Mar 2026 08:05:56 +0100
X-Gm-Features: AaiRm51uqRKZdNzq2YMUx8iG_-hKGXVeQSw95FSgMQdqYsgot7vSFbE39PqPeb0
Message-ID: <CANn89i+ntGv0gGYvRq8yziGTE01ozBJ_Mn_RDPXLgs+yU5whrg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] inet: add ip_local_port_step_width sysctl to
 improve port usage distribution
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chia-yu.chang@nokia-bell-labs.com, 
	idosch@nvidia.com, willemb@google.com, dsahern@kernel.org, kuniyu@google.com, 
	ncardwell@google.com, skhan@linuxfoundation.org, corbet@lwn.net, 
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 550AC1FB5EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263613-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,suse.de:email,0xffsoftware.com:url]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 6:30=E2=80=AFPM Fernando Fernandez Mancera
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
> v3: xmas tree formatting and break the gdc() loop once scan_step is 1
> ---
>  Documentation/networking/ip-sysctl.rst        |  9 ++++++
>  .../net_cachelines/netns_ipv4_sysctl.rst      |  1 +
>  include/net/netns/ipv4.h                      |  1 +
>  net/ipv4/inet_hashtables.c                    | 28 +++++++++++++++++--
>  net/ipv4/sysctl_net_ipv4.c                    |  7 +++++
>  5 files changed, 43 insertions(+), 3 deletions(-)
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

Patch SGTM, but I find this documentation obscure.

Some guidance would be nice. What values have you tested/tried ?

Reviewed-by: Eric Dumazet <edumazet@google.com>

