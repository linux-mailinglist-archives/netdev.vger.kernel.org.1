Return-Path: <netdev+bounces-282431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCXnNhwp8mkxogEAu9opvQ
	(envelope-from <netdev+bounces-282431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:51:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE044974D0
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4713D304F5A3
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089D237F726;
	Wed, 29 Apr 2026 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WmYQbl/B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D737F727
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777477199; cv=pass; b=Ds9ondUqlH3ez8o09zqfpSsN6qE9qHs0KoauVfpa6ObS1/xqfeD7qt3HHySJ2s8L/zhbV9hCe9+V3YWzFs4Zc+kC0TqFHYFDUsBv9vGWQ8g9BVnRKK9O+xJNfWe02Nzqw4fAVeOEQsaLQB9r/8FLR68MLxYo+i1YRMXOFfOlDiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777477199; c=relaxed/simple;
	bh=EVKc7zLQMpq6dfWt3ywse9S+zDw1iKyJCMd8a+sxKJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ugj8cgiO4ASnIgywGJ1a61OgtxtOWq+7szRW80nblvLncXooaQUesO4rELwfwMDBBTY0NdKJOfrLqf8PSEysY+cbQ0EzrLK51413uPimBc1cyyktthPDu0secPu6OmHN5lu+eiVK+ORkHMU4Q5/1DMoYznfLDhweeE6GTcypt5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WmYQbl/B; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50faf8ed9c5so54832391cf.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777477197; cv=none;
        d=google.com; s=arc-20240605;
        b=Wj4dtgZFMC9vHYk3bohbfRy8NWYYOQQV4xRsW4LVeF/o73LMZIluwUy1LF21ip+joO
         vPVN72uH+/lw/7/NfGwZYDWFo9+/gaKycOx0LSF5B2Qug1o8RUuam8zGuoT+FiMMwlgl
         BbX+UN8Fb/4X86abxpuHgcQ06ZyiOpinULYMdQ7ZE5yktoO2OtAkZKwA445BpGLDZTFs
         M0MpKWzQANG92F6MfQo/owq1OyZp9cjeH64+R8lINo66qz9Hec2em9UTdtkXgWc+PcGO
         Y952w73dIM6RH9xBfEmFkpbfhSeJMeRmx3Vy8atR+KN0PiCIvbpMZuz11NRIw70tc/q1
         ooaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ig1XLxGY3Xafqp4qk78IPH+3w0asuDcKACpf4xqkT4M=;
        fh=IAcpd72Ttj2pfMW+qiL5QzxX7jufa9/t5LG9E4z6UWU=;
        b=jqeyeYi8xSG+xsit9OniHqCsRk7awmRTCi4dk9+R9cenDwU6A2VmjaD9dcNIws6x+3
         4k4zBopjPluO+mcPgqYFvFHWXJU8V8l7Uj4uRp2uNxUEzI94XYZBa3QbNSpdbmfo/g0p
         qRoVQjgqxJcDAfm72NCcPtoHvis1OcD6auPqHShx7WPFHDFaQe10RkZOPrnCPtP8TDzq
         AS/cE8okbV0w0sB5Fd5p2MeoRcknz67YUHb6aO/e8qnEDtkT7uRCQodKME+3CfNrv/sQ
         wAGOYVNCZViTvQVdTuo12TQHUyunxL26iPbdZ8XGcEbro/YJA8J0zf2NYQlCVDaCe/6L
         kriw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777477197; x=1778081997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig1XLxGY3Xafqp4qk78IPH+3w0asuDcKACpf4xqkT4M=;
        b=WmYQbl/BrhE3sPBLs3P35e8F/etoP1xqq12Tra6+Ixhu4p4qja3LdGo+1hYwW9OwLG
         k+P4dLYPGEOIEPzgGiPdWk4NO3P9YPdeo34A/1eSOjFo9RGlN7yJYhH5boT07v5yTRAu
         BqNbFEHPfWDGw3AXvyGVYZ0OEB9JzrwHeTi6Zs8xkrkVK9w6DeidWgHsl+Bh2FKM3PNW
         XfuYbcx6EHZXt3eeelzUOuPQdvfGdg9INg6iz58K5WYmt5YblFI2Z/RBlHaVI4l9e33+
         PrADYcMaqs5T3KJxbsLHlWalJPPkNe+QnkjFZ4d3Z3Um6996NpczYyKZBjv3w729qbIm
         i0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777477197; x=1778081997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ig1XLxGY3Xafqp4qk78IPH+3w0asuDcKACpf4xqkT4M=;
        b=iP+Uo7LT19Mcl1su7oSCAHpcSk4hIAbkYbsn0YWu3tvVzgZ8oLeSZVC9WoMU6d+NQl
         eZMCGNSfDaE3KXANESoQsxd97oXAAsWK5Ky0mCzegLELYHOieUua7D7ANERJAI3MamQQ
         0+M2pB0H+IOBBlF5Ssz/VxW4+umqUQn96i3jGZuVMJzArWICyaf2FcqW4mz7/HAmFQon
         ux/+uwJL8GB9FCVA+lhES0AGM9CCLxlJBm8T4oHji+opAFJXx/UjhNof8UWxlE+CPjP5
         YCL4sbeX4baGXa5h7DwNd2WVSksNOKLM2gZ7c3wQpArh+YEUlDbEmf5n1jdhQSk/HLUi
         Yarg==
X-Forwarded-Encrypted: i=1; AFNElJ80l/k6i+mtvQ18NIWGMG3QEdIYKSmgY0qMsNGiSeHKa6sH8S+Mgkqw/lW4izQLmjSGWNbk/Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGo8vIVcL/B39KlVwTVlJyz1ljNDCLuP7BzdLviIzt0XgAByIL
	N/8ygJDWlyRHhrxyZu9k1wwZIB/0g4CLrXipcZyQ8JTb/CFAB2Iw2wjNNd28p6PF7WIJGiNBe6n
	VAv+HBj+HOUA+MutyDtIMypsC8x58S6jjwfdGUGDO
X-Gm-Gg: AeBDiesCJ5zzRmbkuuGcgRmvEj3usLFWEyqYdy3w6L9MLPdaBDFFJex8Fi2S63E9Tg+
	ugpGCSyWSjjhmde56V6KoMJ6N2zqdLtGGPGIWpfO1Tyzkr0QNpQa/lJAstyiN3o96W7kTICO+1Q
	i0J/XGixYOEMBo2FPxuV74V5uv+7U0nnUiMSkctBOvLJZxG2qKWgXOZcsUHyBfwfUIIdr+tBxCg
	6+A7g96DP8/gd/uDAJO0vIhV9eMQZ3sKqjj6DIRKok21Knm2BE25r8uMrNeT/zHch3gPu0QxGIx
	XpBMKBRP8WOSAXRZ+FW6yHBPsOi7vrBTjWZxKJSYMZv9HIUhYqhdpOXPQvmxJ+J0WZg8T1UuC/y
	7eZR5if249L+z/d7qHMM=
X-Received: by 2002:a05:622a:296:b0:50d:83a4:2995 with SMTP id
 d75a77b69052e-5101897c5b7mr64106531cf.21.1777477195677; Wed, 29 Apr 2026
 08:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429080036.1528533-1-edumazet@google.com> <CADVnQynDD_6B894PqVuSqqz24hmYhyQKov7zDvnYJoKZU0TXZw@mail.gmail.com>
In-Reply-To: <CADVnQynDD_6B894PqVuSqqz24hmYhyQKov7zDvnYJoKZU0TXZw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Apr 2026 08:39:43 -0700
X-Gm-Features: AVHnY4Jlx5MMsQs1Bo0SqezT3teGJuHOeSBeETXIBMYlRyzFhKBFYPpRkYqwumk
Message-ID: <CANn89i+3R1yH_kTNg8=DLqfHY0hR6uOkOG3CZvcUxz41Xt2LXQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests/net: packetdrill: add tcp_syncookies_ip6_9k
To: Neal Cardwell <ncardwell@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DCE044974D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282431-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 7:15=E2=80=AFAM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Wed, Apr 29, 2026 at 4:00=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > This test checks syncookie mode is able to reconstruct some
> > client options when TCP TS are used:
> >
> > - wscale option.
> > - sackOK.
> > - MSS (in a limited way).
> > - ECN (not tested, because of limited value).
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  .../net/packetdrill/tcp_syncookies_ip6_9k.pkt | 30 +++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syncook=
ies_ip6_9k.pkt
> >
> > diff --git a/tools/testing/selftests/net/packetdrill/tcp_syncookies_ip6=
_9k.pkt b/tools/testing/selftests/net/packetdrill/tcp_syncookies_ip6_9k.pkt
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..15d03992a99140ecc4241ed=
ae58693dc5098fece
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/packetdrill/tcp_syncookies_ip6_9k.pkt
> > @@ -0,0 +1,30 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Check syncookies.
> > +//
> > +// Check we are able to rebuild client sack, wscale and mss options.
> > +// IPv6 msstab[4] =3D { 1280 - 60, 1480 - 60, 1500 - 60, 9000 - 60 }
> > +
> > +--ip_version=3Dipv6
> > +
> > +`./defaults.sh
> > +sysctl -q net.ipv4.tcp_syncookies=3D2
> > +ip link set dev tun0 mtu 9000
> > +`
> > +
> > +    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> > +   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > +   +0 bind(3, ..., ...) =3D 0
> > +   +0 listen(3, 10) =3D 0
> > +
> > +   +0 < S 0:0(0) win 32792 <mss 8940,sackOK,TS val 100 ecr 0,nop,wscal=
e 10>
> > +   +0 > S. 0:0(0) ack 1 <mss 8940,sackOK,TS val 4000 ecr 100,nop,wscal=
e 8>
> > + +.01 < . 1:1(0) ack 1 win 1024 <nop,nop,TS val 110 ecr 4000>
> > +
> > +   +0 accept(3, ..., ...) =3D 4
> > +
> > +// Check we properly infer from the final packet the other peer wanted=
 8940 mss, wscale 10 and sackOK
> > +   +0 %{ assert tcpi_snd_mss =3D=3D 8928, tcpi_snd_mss }%
> > +   +0 %{ assert tcpi_snd_wscale =3D 10, tcpi_snd_wscale }%
> > +   +0 %{ assert (tcpi_options & TCPI_OPT_WSCALE) !=3D 0, tcpi_options =
}%
>
> The comment mentions checking sackOK but the script does not seem to
> do that? Probably want to check the TCPI_OPT_SACK bit as well? Maybe
> TCPI_OPT_TIMESTAMPS as well, for completeness?


Oh right, last minute typo, I was testing (tcpi_options & 2) !=3D 0,
then wanted to replace with the symbolic version, which should have
been TCPI_OPT_SACK.

