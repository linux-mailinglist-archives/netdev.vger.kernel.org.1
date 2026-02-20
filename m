Return-Path: <netdev+bounces-259671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IQoIy4imGlNBgMAu9opvQ
	(envelope-from <netdev+bounces-259671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:58:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB02165F80
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0604302BE07
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 08:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B433115A2;
	Fri, 20 Feb 2026 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2yjdCw5w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2CC3112D5
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771577896; cv=pass; b=cElJfEl2l7s5cADH7FrOdPm8PYBlOhJ7jUTpBuY+Vlzd2dU5s5O8LVmmpjMv8P0xk3M8yR8Ac5Shp336AUoFX2pnj2+aGaSLlLBHu6dC1pHOiR5e2VnVHQjSoIVdR1cJPl8nUkpuNM10pM8VabWI/BDJDgfY+JEiXjkz3exdhY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771577896; c=relaxed/simple;
	bh=AEujbFKlh5JFD3bI6CQBE5KWHB6cC0DGmBfxGY4HZZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCswpPdCFs7ywyFE01fnpCNafcwtrpoU3ahj470hjqedvFe0Y3Y/HE2AObUk90F6bGPuNiuTL1+XL7korz2tcubhezGj46wM9XXRTmvKw15Njb2z5ASB38yWn4USv8yGLKyyUV0UEBQRG96Cr5kZJq8VDZMBqVQZCtlYJUgGTxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2yjdCw5w; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506c02ec1b3so21301471cf.0
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:58:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771577893; cv=none;
        d=google.com; s=arc-20240605;
        b=EsRG1KcO4p2p1o+6kd+IScx3IiEgHKDGq50cg1gaede1OS5mQVPZsMVSBsv30Wp6SJ
         +KCacviXmTAime44D+I7SB9sNztVCC8xgdyccp60Q2EtjZWshiwyaETa92xa6C3LUqlU
         LIh7JgVxGwcGEip7+Nhu70R7gvChCDxh6a1sjJkxLnluKgef39TK8waHQeQ0LEV+en88
         cbXgm2mbrjHYmlEK6a0gqq7nzDFW/Yhc/AKG9W3TmIzNsNdBBx7n89e3HpKi/TF4bJ8v
         B5tT1hEy1cT45PAZlPLo1dlB5Lh4nKUzvtPgg6GtMopljsQ4oubievf8KhlWbygB5QPH
         oULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YyFN0Kson+AYNlRNbkY4e10Iy1AdaN1ujO4FPzKIE34=;
        fh=d5RxiYp8qwROd6pFxEYBHsxOCJWgk7WXQSVci0ulGqk=;
        b=EJ8axIDrBFxru3YZIhuTSVn+w9fui0e6sEesX84z0jxMTwjUXXDaP5bSxq2IUaLrfa
         C+WCAQ3kF2X3mcVMYiGnNz5fwiJ0/95cPnzqA9NWs3xvBZNwxHAyQQiZ+zWu1GY+61Ar
         dag892pSxoQoOiAOYuB2jHJZkKAIUXhz/YQ146GJp9U5NOldiSICwbOxdYMqO8kYqKMQ
         EWlXbzw0vRjfpNMqoWa4szL3un/sbnZB9CjPoWRnhqJaJW/XLrihxBKF8F98oO4qPj2q
         IFOvSXPWsW0qQRszDvxQgPrsv3T+zLfHKUirRoLcbHurm9qjtUlQ/OSqfCr1u7kPR8tz
         cKVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771577893; x=1772182693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyFN0Kson+AYNlRNbkY4e10Iy1AdaN1ujO4FPzKIE34=;
        b=2yjdCw5woH1kQa/4t8QQasjpBpkrkO0nh2t0avKUumsWB65E0P4K5askFl3cTTm6Ch
         AZFzvJr9I2wzS8IJbULFOzOmZZ6ngGYLVL8xZYc42yUdqTItetbOZXqXSnCI6nyP+vBd
         Dtq+Eg8s7wo5AdGfzAIPHSqFuskTrHa6wCNXzpzzrPQiYsKfKwH/qotLJZBEyPV0vaou
         4Fx8g6FG0iA3i4CwRe1Cpu3/Qk8p4QihtjBA8+r9E6Y9+g3i/L8uJscmKqWFRJdks4OA
         R6XG6KETxtNWTNSSqC7YnHo+DVX0jp7fdFZO5D2L9XPGcdhNO1x4zFDgEEqyY4NIYxUa
         7/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771577893; x=1772182693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YyFN0Kson+AYNlRNbkY4e10Iy1AdaN1ujO4FPzKIE34=;
        b=ibtc0AQJkpG/Ve4ERa/AbUMxeA45wN79ZpPcxV5IOAUA8Ye+C3h6tr4DbcppVaGoZT
         sQRSE1TWMXusJANt4ZrDuaS4ZujISXSOx0/sr1v+E3fP2YQt7I27rGfCrG4xvSA4R1W/
         ojDUpropphmLV6hUNdLiol1XKAXxtqR1elMO4xEp2MZu/xRIkjMx92rS2G5MS8DtGnE+
         ltKMfP8M8FTHC8h1vo+0inshirNrmoW0TuSzd5InCPfcMbQ9mtcs4TrquECOHZSCoE/K
         3zGX+yCp+W9dKt5OLjBVCsVOH9/1V4tjAatt16R8kDfRShEkbPa0K4X4zjZKmF2v7vbE
         gCJg==
X-Forwarded-Encrypted: i=1; AJvYcCVpB4lWEKHQBRXlwuUWoyX5iRTz56vimbo/b7gtj5dg+pOieh57AVIaIde2jSGBGm7oY7JGRvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYzf/mIR7srh5GRpUyswTLmgbs2jrjsdQwauKovCG97zMssQUN
	p2zBKqKGk+seDV9HLUeumPRLEv0aq7sxxJk3yCn3ie4Kjfj9ILQODvf+zOPcQgY1aaculAEQqe3
	oFTqyysZi1sPHkQ/yZiMXiHp6nawpiUswRO4J6smK
X-Gm-Gg: AZuq6aK63lfCql6m6gvIB3brqyQojgXbda4roMmOBsUS9j+R3MgWVN0wxoTTj2T2el/
	oJjOdlF2EfjErnN6dXqZfx5GuIifXnMmAieZezCmBwnVQfMefZ3wOhXcO0YIcc90ifecTacEs39
	D3udYIV+55fimrEDeSm1s1UjvsU07i/0jCbEB2XxUX0wbcZmVNf4b6t4vkMJUXkLL8gBD4yZ1tf
	2DBa7jQdWW3XajGaB0LXS3ODjO53vKc32ho7jcUSFfhTRBmoJe7X6Hoz+zVopR4tSam8Xwee/1d
	VTvl5w==
X-Received: by 2002:ac8:5acc:0:b0:506:a394:ca77 with SMTP id
 d75a77b69052e-5070034506cmr7771591cf.13.1771577892700; Fri, 20 Feb 2026
 00:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-tcp_rfc7323_retract_wnd_rfc-v1-0-904942561479@gmail.com>
In-Reply-To: <20260220-tcp_rfc7323_retract_wnd_rfc-v1-0-904942561479@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 20 Feb 2026 09:58:00 +0100
X-Gm-Features: AaiRm53-S4oAp4GvF5WoYf1aBo1ioPswOgMfvyIgUiOruJtUswhbFk9_n4l6ygY
Message-ID: <CANn89iLd=P2nftdMReVkc+d-8+0PGi1ACxhrhnVCxFVxNOhvJg@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 0/4] tcp: RFC 7323-compliant window
 retraction handling
To: gmbnomis@gmail.com
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>, 
	Stefano Brivio <sbrivio@redhat.com>, Jon Maloy <jmaloy@redhat.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
	Shuah Khan <shuah@kernel.org>, Christian Ebner <c.ebner@proxmox.com>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259671-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,proxmox.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DBB02165F80
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 12:56=E2=80=AFAM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> Hi,
>
> this series implements the receiver-side requirements for TCP window
> retraction as specified in RFC 7323 and adds packetdrill tests to
> cover the new behavior.
>
> It addresses a regression with somewhat complex causes; see my message
> "Re: [regression] [PATCH net-next 7/8] tcp: stronger sk_rcvbuf checks"
> (https://lkml.kernel.org/netdev/aXaHEk_eRJyhYfyM@gandalf.schnuecks.de/).
>
> Please see the first patch for background and implementation details.
>
> This is an RFC because a few open questions remain:
>
> - Placement of the new rcv_mwnd_seq field in tcp_sock:
>
>   rcv_mwnd_seq is updated together with rcv_wup and rcv_wnd in
>   tcp_select_window. However, rcv_wup is documented as RX read_write
>   only (even though it is updated in tcp_select_window), and rcv_wnd
>   is TX read_write / RX read_mostly.
>
>   rcv_mwnd_seq is only updated in tcp_select_window and, as far as I
>   can tell, is not used on the RX fast path.
>
>   If I understand the placement rules correctly, this means that
>   rcv_mwnd_seq, rcv_wup, and rcv_wnd end up in different cacheline
>   groups, which feels odd. Guidance on where rcv_mwnd_seq should live
>   would be appreciated.
>
> - In tcp_minisocks.c, it is not clear to me whether we should change
>   "tcptw->tw_rcv_wnd =3D tcp_receive_window(tp)" to
>   "tcptw->tw_rcv_wnd =3D tcp_max_receive_window(tp)". I could not find a
>   case where this makes a practical difference and have left the
>   existing behavior unchanged.
>
> - Packetdrill tests: Some of these seem rather brittle to me; I
>   included them mostly to document what I have tested. Suggestions
>   for making them more robust are welcome.
>
> - MPTCP seems to modify tp->rcv_wnd of subflows. I haven't looked at
>   this, since I wanted to get feedback on the overall approach first.
>
> - Although this series addresses a regression triggered by commit
>   d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks") the underlying
>   problem is shrinking the window. Thus I added "Fixes" headers for
>   the commits that introduced window shrinking.
>
> I would appreciate feedback on the overall approach and on these
> questions.
>

Hi Simon, thanks for the clean series.

I would guess you use some AI ? This is fine, just curious.

Can you add more tests, in memory stress situations ?

Like :

A receiver grew the RWIN over time up to 8 MB.

Then the application (or the kernel under stress) used SO_RCVBUF to 16K.

I want to make sure the socket wont accept packets to fill the prior
window and consume 8MB

8MB seems fine, unless the host has 100,000 sockets in the same situation.

Thanks

> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---
> Simon Baatz (4):
>       tcp: implement RFC 7323 window retraction receiver requirements
>       selftests/net: packetdrill: add tcp_rcv_wnd_shrink_nomem.pkt
>       selftests/net: packetdrill: add tcp_rcv_wnd_shrink_allowed.pkt
>       selftests/net: packetdrill: add tcp_rcv_toobig_back_to_back.pkt
>
>  .../networking/net_cachelines/tcp_sock.rst         |   1 +
>  include/linux/tcp.h                                |   1 +
>  include/net/tcp.h                                  |  14 +++
>  net/ipv4/tcp_fastopen.c                            |   1 +
>  net/ipv4/tcp_input.c                               |   6 +-
>  net/ipv4/tcp_minisocks.c                           |   1 +
>  net/ipv4/tcp_output.c                              |  12 +++
>  .../net/packetdrill/tcp_rcv_big_endseq.pkt         |   2 +-
>  .../packetdrill/tcp_rcv_toobig_back_to_back.pkt    |  27 +++++
>  .../net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt |  35 +++++++
>  .../net/packetdrill/tcp_rcv_wnd_shrink_nomem.pkt   | 109 +++++++++++++++=
++++++
>  11 files changed, 206 insertions(+), 3 deletions(-)
> ---
> base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
> change-id: 20260220-tcp_rfc7323_retract_wnd_rfc-c8a2d2baebde
>
> Best regards,
> --
> Simon Baatz <gmbnomis@gmail.com>
>
>

