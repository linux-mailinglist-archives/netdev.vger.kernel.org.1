Return-Path: <netdev+bounces-267667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4WUsNffctGnAtgAAu9opvQ
	(envelope-from <netdev+bounces-267667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 04:58:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C8528B7F6
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 04:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2811230172D3
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 03:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC10320CB1;
	Sat, 14 Mar 2026 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JTgqP31w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFA3317164
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 03:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773460723; cv=pass; b=KtoTFF5tXJilSFHqCEbXrDL1sLdTw8J4ssIutdvqw6RNDsoLNiDF1MOEsCFMzs1PoLEkPeGMyyLSykSdr3ErFPNIl+ilsgcqhqsZ92W5LgrKuQ0lUHwXXa1F3Q95+58p3TP72mCq2drTMGap1kToD141yUulhVnoCd+VRybrUps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773460723; c=relaxed/simple;
	bh=GcSrDIphKrI2//HgDsteTWBHlxHzmnPMjkm0w3xQYSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeT56epdPdyvSgrbDhpydxLQ8Bi6t+HeRi8SU9ci0BYtLdqGhYsGlJgM4nmBdPOZD6VjVybTEWCwwab89UqM+ARblbvtmoUpfYN8PjDBFreCEZ6wZ9JyG8FYk5754wj4H//MrY9XH8GQEPeYrKvHSoePGHHN9DoBJU7Y+/H8a8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JTgqP31w; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506a747448dso24934441cf.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773460720; cv=none;
        d=google.com; s=arc-20240605;
        b=SkSTKGImpv6BhYQQQZ/YzMhALsNARzR0m39ndmryTYL03pFTgcpFrtpSqLVtpt1Qkv
         NmURQI7fyhZVuHK8cUiz35AQSmZXbuXKDG/qHZptWYtlaUr/KIZivUh3JOkaVXoBDHty
         Ha9jKwnFKXSBihAoTn8AfKedRA8nCcqQ4uXUA41KjVCN+nnfLfoPK0b0nN0aJo+c8I7D
         AdDRlgz8ka2KY1A5eG3rPyp8gR3I8eTfaZ96Pp/6f8eaRNB8RZohtwKu4ySMvbYJCHWe
         lrfZrmtOsG4UP4d/20oIm8gSqSJKPjFKzmIDo3zR+cUvUEw9LxYtsMsO8UXyIdFkZ0j0
         KtLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OUQRi5vl7ger1FCyv6fx+Ok5M5QQpxd6KNaAJfpodDo=;
        fh=CthJ4a86oUa6QoQzzNQB3u4TeW1ks45MH6nLKaLOVFE=;
        b=eQL5HYG93ZSaBmA6Thet6QsitkB6bPIDfEFCua+/O8UMSECdDASmsU+Wu5k8VnvIlO
         VePHf1p694gXhH5K5mQuLBrsGYAGWyZ1Xn0mhW6/i9dn4uQqUhi5n7Lo7sjBnut7xENW
         mipPU9Ex//Sb23W2t3mM0E+yZSEL525ZGLLPnmwefvMxfwpOz8zMUtwCfseJLpkjFhc/
         tlAY1Rv6AN63GrKIi/LUzW0K3H4TDgspsEcge/VjSwk2lwVxzSnX3vBvot9qWUTqwxiO
         TCyDQOhwnQ4E0bGSRahk2SG7faYwhKCY/4YzFXL1a1PmyauaGSHI7rlYNXpjJ00902DV
         4qoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773460720; x=1774065520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUQRi5vl7ger1FCyv6fx+Ok5M5QQpxd6KNaAJfpodDo=;
        b=JTgqP31wUjvJW6J0fs1XR8UDn/WHbk6yG/ugdEzIIaBtN6qVCOZt5ZlJkVL4ze4py7
         vdoUVii8IYXkGuHIJRJP3zprLeUjJom3ZiwoCW2qE9xAh1LW2zI4rLVFNYqFNONbCtm8
         Lbd1gzNK6JkyNFRW5BGgC5FaiCtCyGVmIGG5tayTBrZaFNcIj8sZsPza7i0ZUMTK1Oa5
         Wkn5cZWexZf2YXMryIyu+zoVJ99k/2oE4CGLyaHENCYN+3N1YOq+enZ830YT1Q5529dr
         UMCw/NccyvFo9IDZvLPNfrqa8UYIyd9T8DUfVWpPoYNSEH6GkaZdB0IvHOQjyKCxAWR+
         rxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773460720; x=1774065520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OUQRi5vl7ger1FCyv6fx+Ok5M5QQpxd6KNaAJfpodDo=;
        b=EnMcAq3YgT9pD1YGhV1og4FA5alcblS0xKcu+hHfpsWcAK9WNnYvTDMNy+HymJpbNx
         1DMbEO+H8EAo/9oQqhYSPp9xOWIjwbZPgiY8wMayftwMqvx5RYg3+Yplwa9PUGgHvFqU
         NsDaS/zMvOF+ybW196rJKvZuFENbv7ANHmAQNOw9AO7AAv7whdAozTX7GmPTB+biP1dT
         eQNTfeEKC706yd0DjPHXVQnFZvwD0CYfDmOZEbiFFfAlF5GElJKQhjfhQvv1eXq3fx49
         XRAyrmKnVDzg4c8SFjOYfQSKqVPWUc55LGBw56rpYny1BOBwoQmpkh7udlSG88CveNXu
         YcQg==
X-Forwarded-Encrypted: i=1; AJvYcCWMtd16lrXCex28NRginpY7j8ktme7HsEPhXYjF0qESyl8JguvwwaAGFYPXN72ojoRiYWCpIz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvkPMVrsD/dhr26TOVne6Z+wyfgI26GnNO8qZ4fDaoEspW2lF6
	Xql8+IdF6DqKUVri+0ijO9E5zuwhQn1CcNTj8Bg2GmoRIA/kwyf8ivezkIIme2hyRbQFL3tJX9x
	McPbDI+BfiqK+9pVUNT5d6A1znOC3aYBo47OGQkhx
X-Gm-Gg: ATEYQzxMxWgc6QD64PnWlvE89tZBgM45KXIkXLBDPI+LNiSqzj0I0BHh+feA7LzJY5G
	iIvFghJrx/9R9MzRCCl6fgoUtLIQ7U11CxQ+Z/sy/Z2Og2aIijvx5JJsQdKOjybla9ppRgkry7L
	DJsvwGyvblzYUQZKji0X9Yp2HbW34d540nRnxrVy/rx1g/inFh9Enc4smdhi/6lMowAm6/xdBZJ
	rrgZtM3zJ8lNkHGaSfNo98NYNGM13uCYUVDWQQUUiayFd9mBLp0DPsiZx0J+zoNHD6CbN7RQ//7
	uctwdw==
X-Received: by 2002:a05:622a:190c:b0:509:1a72:e332 with SMTP id
 d75a77b69052e-50957cb6dffmr75230961cf.16.1773460719740; Fri, 13 Mar 2026
 20:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-6-4c7f96b1ec69@gmail.com>
 <CANn89i+PypF1cK4mnp8L_eCG_z+3Aj6uxJoohm_=DwGfR1=4FA@mail.gmail.com> <abCkmiCSPkmxzECa@gandalf.schnuecks.de>
In-Reply-To: <abCkmiCSPkmxzECa@gandalf.schnuecks.de>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 04:58:28 +0100
X-Gm-Features: AaiRm523CLjVQFOb0ZjB_qB2iBvlpRhw-o_SCZwCK7X6f1nBivXOPbA_-nmtd5w
Message-ID: <CANn89iKYxs644ardFFSKo8d0EXL_2A5eUQjWZ3yp9-Q4tVLKzQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/6] selftests/net: packetdrill: add tcp_rcv_neg_window.pkt
To: Simon Baatz <gmbnomis@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>, 
	Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267667-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 43C8528B7F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 12:09=E2=80=AFAM Simon Baatz <gmbnomis@gmail.com> w=
rote:
>
> Hi Eric,
>
> On Tue, Mar 10, 2026 at 09:54:58AM +0100, Eric Dumazet wrote:
> > On Mon, Mar 9, 2026 at 9:03???AM Simon Baatz via B4 Relay
> > <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> > >
> > > From: Simon Baatz <gmbnomis@gmail.com>
> > >
> > > The test ensures we correctly apply the maximum advertised window lim=
it
> > > when rcv_nxt advances past rcv_mwnd_seq, so that the "usable window"
> > > is properly clamped to zero rather than becoming negative.
> > >
> > > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > > ---
> > >  .../net/packetdrill/tcp_rcv_neg_window.pkt         | 26 ++++++++++++=
++++++++++
> > >  1 file changed, 26 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_wind=
ow.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..15a9b4938f16d175ac54f=
3fd192ed2b59b0a4399
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> > > @@ -0,0 +1,26 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +--mss=3D1000
> > > +
> > > +`./defaults.sh`
> > > +
> > > +// Establish a connection.
> > > +   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> > > +   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > > +   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [20000], 4) =3D 0
> > > +   +0 bind(3, ..., ...) =3D 0
> > > +   +0 listen(3, 1) =3D 0
> > > +
> > > +   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
> > > +   +0 > S. 0:0(0) ack 1 win 18980 <mss 1460,nop,wscale 0>
> > > +  +.1 < . 1:1(0) ack 1 win 257
> > > +
> > > +   +0 accept(3, ..., ...) =3D 4
> > > +
> > > +// A too big packet is accepted if the receive queue is empty
> > > +   +0 < P. 1:20001(20000) ack 1 win 257
> >
> > We do not see the answer, it seems this test is not complete ?
>
> Actually we do not want to see an answer.  The packet won't trigger
> an immediate ACK (it is larger than the advertised window, but does
> not cause immediate memory pressure).
>
> When we then send a RST before the delayed ACK would be generated:
>
> > > +// Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq u=
pdate yet
> > > +   +0 < R. 20001:20001(0) ack 1 win 257
>
> We are in a state where rcv_wup, rcv_wnd, and rcv_mwnd_seq have not
> been updated yet, but we must still accept the RST
> (rcv_nxt =3D=3D 20001 > rcv_mwnd_seq, tcp_max_receive_window() =3D=3D 0)
>
> > > +
> > > +  +.1 %{ assert tcpi_state =3D=3D TCP_CLOSE, tcpi_state }%
>
> And we verify that we accepted the RST here.
>
> Given how subtle this sequence is, and considering the limited value
> of this test, I am also fine with dropping it if it is too fragile or
> confusing.

Sorry I missed your answer.

Ok then please use :

// A too big packet is accepted if the receive queue is empty
   +0 < P. 1:20001(20000) ack 1 win 257
   +0 %{ assert tcpi_bytes_received =3D=3D 20000, tcpi_bytes_received;
assert tcpi_bytes_acked =3D=3D 0, tcpi_bytes_acked }%

// Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq update y=
et
   +0 < R. 20001:20001(0) ack 1 win 257

  +.1 %{ assert tcpi_state =3D=3D TCP_CLOSE, tcpi_state }%



Then add my
Reviewed-by: Eric Dumazet <edumazet@google.com>

