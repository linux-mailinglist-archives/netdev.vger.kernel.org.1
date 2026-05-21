Return-Path: <netdev+bounces-290415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJkQAVgDD2oaEQYAu9opvQ
	(envelope-from <netdev+bounces-290415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:06:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE3F5A55DE
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1B7032E9F24
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072603D890C;
	Thu, 21 May 2026 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqvbAhCF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B53D7D91
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367926; cv=pass; b=u3Fc2ABze9ulmP6Dpkw2gOFWcKEGLQRH8bLpIWPADTJKQDZcal6y7Zz0WV9UUlSg6czSk7zfAhC8YSMrJTD6ZZq115cLUE8GBdbBKlWl2jgQgqdCCje2lbDb6NhGYR+L6PMGGZnIpc+3s+2GF/+XFYGFrJMYOr4nU6ELJI+4Nfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367926; c=relaxed/simple;
	bh=p8cc2wnGLfAwakGTNQQ7vxQ2eQ9vVWHXg2L1htWQBTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOmLjimDTRyyjRSajHGb7nf3GYw1rBElYZQfRYgljCoeOdmnlD9Rsi65OWFSWXL1Htcor+fnxYc88/WnTdlzhG7Hd3D2QMFgOgn6d+mE9kWMVDS9G6eAhjlEz/NTyEAAjkilQhPeDJM+CnHftZNA/G6qDpj2U1yLQVz18d02NbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqvbAhCF; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65c7492a2ceso5300802d50.3
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 05:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779367924; cv=none;
        d=google.com; s=arc-20240605;
        b=j1GV0Xouc9npYx1BEzSwz8N+QgZk8IbkY7oDFwYEeS694L2pkKB0wHGXrvp2eg6ht9
         mzJRiee9HfvcBwd18nm65eB8tdd9Y6pGEmizxrNZ8lF1Qi+htzVhdmOwxfEConxzpiRz
         6h8RGpNLuSqCr+QtZNhPaGKq2XrOkgzQaOH5ju2GqtZeTS6o+gRABvd0543V/AR2WBo8
         IOsoSDqtvLUsTgMX2of95sJ1IHotuE1zpF8j3mtIHhsbGh4wk/z3lLFXRd7MxaEbH7OV
         LXFxuoE0mYK7fsfDPl/v50Dsuf+v9bHqshuPmTrxdTQp/pbsNWeuIjgEOqS9tx8vq75S
         fzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sGwmbLN2Vtyo/TdGf+EWGxjeBtLgP+QUzHLYLGWhusg=;
        fh=7rwzjUMsLhxx4zUw9offnAgDUoBXeKFrKR4mhdHT/Y8=;
        b=PqSannJxoXTVhLJVHX44zt8zzG8knobrL+DxiZoC91IaDav8FdTz/vbywZuk39b+WY
         gtN/+nX/ThMy2jy3j0j3OVTIN/mNBl0DXT1oo9ALZzteagIGapnMmYYUljUv8rNiHq2V
         AvggKsD+w0VyvBb+3uDWsQZ0G/rW00nz0OPhAuKFdVS22eg0pPnKDil5Z2fVCYKZNzVb
         1AB9CaeZhD2YTgIqHUfVUMyFlx/Q9gpl2AlDU3aRraa3WXSfkDN+F1DGXnKEpAd+ZZuU
         A4Gtz0NHiOFjG41AyE8hm04l300Kfvmd8QTM0YLFgh2Y42t1pMXcFCoQZut7EOVhXvdT
         GVtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779367924; x=1779972724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGwmbLN2Vtyo/TdGf+EWGxjeBtLgP+QUzHLYLGWhusg=;
        b=DqvbAhCF1tsPURcyVihwoBPllgzam5ckaJ9KRihwjHXpXCnzKMPWxX2/wb9tEXgrae
         0sGQysGTSmlO+u+MiECZfq94UCxy0gzAj5ReaYlUH20Qv6JLBikN4IFB/l9H+7PZap83
         SEox5fbNZZu4UKzTmnxX3D7PMLX+U0uECatzJ2m2WNMBzLfZgwPzDd1YXKBlCyd/0USR
         GpB+2j0uWkXmTSOdDcjweGysj0wJdSb5tETfYjrYjzgv2B6M7fCt6/ttgu4WtxCEnuK+
         +9vl4kuJ3kXQNkYpfa/bQYJMDGXToeVah+ViebHcqk9wd6tJBQ47CTD9WaHq2qPQWbyT
         t/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367924; x=1779972724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sGwmbLN2Vtyo/TdGf+EWGxjeBtLgP+QUzHLYLGWhusg=;
        b=PjTYafV1OMZ2xdagUmiGmosI004Dh8Cpa0ijX74v7KFx3aANLoXfhhzawIJjRA+Mlr
         riGUaGomRGabO07OwmpjSb79Ix31mQpti9G1sSafMj0B4ruQYmATjE8fQ+oYgnJuo0h9
         LQkKktSvpNtkZnvMjovsyC46xmx6hliepoiPlu2ypVVq/iefqBLi0aKg4z23hSUhmvxD
         L3fVXiisyOx4sMKi7TnIAfLIEzDKyfzwy+Tj3n8xRUkuKRZO9TWsDtA0QPDvF4MiJ/Zi
         TAulb3TgDoLrGec+5pRdCpwxI3/36n2zc2OgCEfzUujBXjDuaU90s+Rf2rgE0y3vpT8y
         GHnA==
X-Forwarded-Encrypted: i=1; AFNElJ8o5yf0/awrzaqb4XCo9HTIn7pT3GhSlprhUil4Y8pwhbADmKD0R2sxK1hN53mb+8UjZfBjlFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiVGEmRxVHHsEdgL0NTvcoIO1zk8xMe1x2HIugdOmwoBz/uD83
	ai7IHU7qxTyj8m/YjhrzINJ9jSHBJcUyI5KiGA0Enr88Bhk/aBBzdnRd126qowfZPxfM6Hq96yR
	PIK0ep4jo2vCpIprDNiI6UHaS0H7WGio=
X-Gm-Gg: Acq92OG1wD4utdAubSwneoCcV7+SdZA5Af1OIewZuo9rVhnMANJ1tdq1AEkoaQU3Zq7
	ucgg2Sxn/+QR7thTAMOJTgVxi4TVPo+LEtodNpx8dJWfgjCoqQTcLbdCf/7+gRd+FGCOoby8ifF
	IUobz0C/FC2MIlfqO0AIUaIkWQkH45PmV/b2peVA4RZqnEt27f3FIC/vSVFqzqQWSQB3FZP+R4J
	7VsGmCsNSaMp5dMY+A4WjA9ILfOJfHhOqFT76chU850SvEaiGwoU7sWFFvRlgjwtwNDJU465AF8
	R6FRsE8PiT7uUJ+/V0CuRWdIQBW/3usZGlOH0yBETBm2WVXxW7O8REd0in8OrMv9BPYXLg==
X-Received: by 2002:a05:690e:dc8:b0:65e:4729:75d2 with SMTP id
 956f58d0204a3-65eae282cc9mr2274633d50.63.1779367923784; Thu, 21 May 2026
 05:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com> <20260521000555.3712030-1-michael.bommarito@gmail.com>
In-Reply-To: <20260521000555.3712030-1-michael.bommarito@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 21 May 2026 08:51:52 -0400
X-Gm-Features: AVHnY4KCmgUUIg2J6RNcRb1EIZ4whCdQkwBUhY9eLR2VCwJJEU5jgOwxCGLGYyk
Message-ID: <CABBYNZJtN0+OkNEBh-y0y3pLQZwK=0r9Cy5Tyg7Hd-AVWdOJEQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290415-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6DE3F5A55DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

On Wed, May 20, 2026 at 8:06=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> net/bluetooth/l2cap_core.c:l2cap_sig_channel() accepts BR/EDR
> signaling packets up to the channel MTU and dispatches each command
> without enforcing the signaling MTU (MTUsig). A Bluetooth BR/EDR peer
> within radio range can send a fixed-channel CID 0x0001 packet that is
> larger than MTUsig and contains many L2CAP_ECHO_REQ commands before
> pairing. In a real-radio stock-kernel run, one 681-byte signaling
> packet containing 168 zero-length ECHO_REQ commands made the target
> transmit 168 ECHO_RSP frames over about 220 ms.
>
> Impact: a Bluetooth BR/EDR peer within radio range, before pairing, can
> force 168 ECHO_RSP frames from one 681-byte fixed-channel signaling
> packet containing packed ECHO_REQ commands.
>
> Define Linux's BR/EDR signaling MTU as the spec minimum of 48 bytes and
> reject any larger signaling packet with one L2CAP_COMMAND_REJECT_RSP
> carrying L2CAP_REJ_MTU_EXCEEDED before any command is dispatched.
>
> The Bluetooth Core spec wording for MTUExceeded says the reject
> identifier shall match the first request command in the packet, and
> that packets containing only responses shall be silently discarded.
> Linux intentionally deviates from that prescription: silently
> discarding desynchronizes the peer because the remote stack never
> learns its responses were dropped, and locating the first request
> command requires walking command headers past MTUsig, i.e. processing
> bytes from a packet we have already decided is too large to process.
> We therefore always emit one reject and use the identifier from the
> first command header (a single fixed-offset byte read), falling back
> to zero when the packet is too short to carry a header at all.
>
> The unrestricted BR/EDR signaling parser and ECHO_REQ response path both
> trace to the initial git import; no later introducing commit is
> available for a Fixes tag.
>
> Cc: stable@vger.kernel.org
> Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Link: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarit=
o@gmail.com
> Link: https://lore.kernel.org/r/20260520135034.1060859-1-michael.bommarit=
o@gmail.com
> Assisted-by: Claude:claude-opus-4-7
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> I reproduced the stock behavior with a real-radio BR/EDR ACL link and a
> harness that sends a single fixed-channel signaling packet containing
> packed zero-length ECHO_REQ commands, and confirmed on a patched kernel
> that the same packet now produces one L2CAP_REJ_MTU_EXCEEDED command
> reject and zero ECHO_RSP frames. The patched code builds for
> net/bluetooth/l2cap_core.o on x86_64 defconfig with W=3D1. There are no
> in-tree Bluetooth selftests that reference l2cap_sig_channel(),
> L2CAP_SIG_MTU, or L2CAP_ECHO_REQ.
>
> Changes in v3:
> - Drop l2cap_sig_cmd_is_req() and l2cap_sig_first_req_ident(); the
>   reject is now unconditional and uses only the first command
>   header's identifier byte at a fixed offset. Per Luiz, the spec's
>   "match the first request command identifier" rule would require
>   parsing past MTUsig, and the spec's "silently discard if only
>   responses" rule desynchronizes the peer.
> - Replace the v2 walk with a verbose comment quoting the relevant
>   Bluetooth Core section and documenting why Linux deviates.
>
> Changes in v2:
> - Replace the per-PDU echo-count cap with the MTUsig direction from
>   review.
> - Reject the whole over-MTUsig signaling packet with one
>   L2CAP_REJ_MTU_EXCEEDED command reject.
> - Add L2CAP_SIG_MTU and drop over-MTUsig packets when no valid request
>   command identifier is found.
>
> v1: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@=
gmail.com
> v2: https://lore.kernel.org/r/20260520135034.1060859-1-michael.bommarito@=
gmail.com
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 47 +++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index 5172afee54943..e0a1f2293679a 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -33,6 +33,7 @@
>  /* L2CAP defaults */
>  #define L2CAP_DEFAULT_MTU              672
>  #define L2CAP_DEFAULT_MIN_MTU          48
> +#define L2CAP_SIG_MTU                  48      /* BR/EDR signaling MTU *=
/
>  #define L2CAP_DEFAULT_FLUSH_TO         0xFFFF
>  #define L2CAP_EFS_DEFAULT_FLUSH_TO     0xFFFFFFFF
>  #define L2CAP_DEFAULT_TX_WINDOW                63
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 7701528f11677..0b1e062057695 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5618,6 +5618,15 @@ static inline void l2cap_sig_send_rej(struct l2cap=
_conn *conn, u16 ident)
>         l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej)=
;
>  }
>
> +static inline void l2cap_sig_send_mtu_rej(struct l2cap_conn *conn, u8 id=
ent)
> +{
> +       struct l2cap_cmd_rej_mtu rej;
> +
> +       rej.reason =3D cpu_to_le16(L2CAP_REJ_MTU_EXCEEDED);
> +       rej.max_mtu =3D cpu_to_le16(L2CAP_SIG_MTU);
> +       l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej)=
;
> +}
> +
>  static inline void l2cap_sig_channel(struct l2cap_conn *conn,
>                                      struct sk_buff *skb)
>  {
> @@ -5630,6 +5639,44 @@ static inline void l2cap_sig_channel(struct l2cap_=
conn *conn,
>         if (hcon->type !=3D ACL_LINK)
>                 goto drop;
>
> +       /*
> +        * Bluetooth Core v5.4, Vol 3, Part A, Section 4: the BR/EDR
> +        * signaling channel has a fixed signaling MTU (MTUsig) whose
> +        * minimum and default is 48 octets.  Section 4.1 says that on
> +        * an MTUExceeded command reject the identifier "shall match
> +        * the first request command in the L2CAP packet" and that
> +        * packets containing only response commands "shall be
> +        * silently discarded".
> +        *
> +        * Linux intentionally deviates from that prescription:
> +        *
> +        *   1. Silently discarding desynchronizes the peer.  The
> +        *      remote stack never learns its responses were dropped,
> +        *      so any state machine waiting on a paired response
> +        *      stalls until its own timer fires.
> +        *
> +        *   2. Locating "the first request command" requires walking
> +        *      command headers past MTUsig, i.e. processing bytes
> +        *      from a packet we have already decided is too large to
> +        *      process.
> +        *
> +        * Reject every over-MTUsig signaling packet with one
> +        * L2CAP_REJ_MTU_EXCEEDED command reject.  The reject's
> +        * reason field is what tells the peer that the whole packet
> +        * was discarded; the identifier value is informational, so
> +        * we use the identifier from the first command header (a
> +        * single fixed-offset byte read) or zero when the packet is
> +        * too short to carry even one header.
> +        */
> +       if (skb->len > L2CAP_SIG_MTU) {
> +               u8 ident =3D (skb->len >=3D L2CAP_CMD_HDR_SIZE) ?
> +                          skb->data[1] : 0;

Checking L2CAP_CMD_HDR_SIZE after L2CAP_SIG_MTU seems unnecessary, the
latter should always be large enough to accommodate a header.

> +
> +               BT_DBG("signaling packet exceeds MTU");

I'd make it print skb->len and L2CAP_SIG_MTU e.g. %u > %u, skb->len,
L2CAP_SIG_MTU.

> +               l2cap_sig_send_mtu_rej(conn, ident);
> +               goto drop;
> +       }
> +
>         while (skb->len >=3D L2CAP_CMD_HDR_SIZE) {
>                 u16 len;
>
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz

