Return-Path: <netdev+bounces-296812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x/SmOu5jJ2oSvwIAu9opvQ
	(envelope-from <netdev+bounces-296812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:53:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B93665B729
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:53:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=eJhQeshH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296812-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296812-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC43D3068924
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A40E1DF980;
	Tue,  9 Jun 2026 00:45:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A58F49
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:45:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965945; cv=pass; b=Cu7fPfpH9zY0bMj5oghYIhUoLJtKZDFkcg1QGRqi7l5+eq/hLK2pxz5YqM1tRSnPaAhw73IQRckb2fofC0XwXF2n48aJJXwIuWQOAJPaiwT8aepRXStfH8MZG2HQV8oi74qU1qhrBXz5Z3LsoOjQcVl4sUmbaZ8nmmg0660c86k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965945; c=relaxed/simple;
	bh=PNqF859dbVfa0Fuz2RohA7Um6vu/6Ciby2ILmWv72n0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYKnrhtLM+O3Y8MAd9X+HDZYLYYjO+gyUaC6OSnSnz3IQBHT5SduMXoeloJf4wZolGUK5xK6dY2CaaTucxMgVmRXRM/ySdjeWwqq+v/utpndOLX7kbjkpjScCk5HRrDIQI9FZr3yZUmiilDzkL9Zrvn6fhb3c+KpACvEDbTObY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eJhQeshH; arc=pass smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-517863a2edfso39559821cf.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:45:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780965943; cv=none;
        d=google.com; s=arc-20240605;
        b=Vvok0EFInUBEK2UeNw5FO41OF/bkqnBHLIs5LTMkQlWg9/arONHfVSyIYkI3DfnsJm
         hrOD82JG2DC7kwhSjh23ZOq4/JDKmAeyTlVtB/m+yFU7UmbDr9jJMps749tEZtUSZ41n
         YFoQq6giZBjSg+qtjw/RBCCwWRHF/dSREvTUHoRlDDU9viyp+7aCOVz5SmLcl8LwZroh
         Q4387VutiCFeEjpZN2cIY8ICEJzMceoWkIhVp9i19ozZ/WJV4RR8y1WDvJD9m50MdTVN
         DbNSRLj5NhjcV84H83QYzCCLl0q1xxgLoY9m1D0b8ASRAqQeGWsApvoZQYGW6TaEu9o3
         9c7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FJ+42FNOQlLGP72/WCCwSH69VqWPR0+k8FAdurNbVLo=;
        fh=Jc27+3+OsHhTzes6d8A+TQNwMqqzaMrc+3ni12uvMwA=;
        b=J2jRufUg5TyUuBsv2yi3yhKWIdRiQFGx/8sdsuDafHKYnXE/vet+JIFATvoixSaDix
         a2GFoTP6yYKM3ssxDDfKxkviikfGhHUbEL8O7ZOvzf7EyNA+7NRevDFXIk2AJm972RFx
         i8a8xtqtqKxLr06wCCaI1HQr6rKFDRpWSNjdOFqtsNKH0JNwO6shJIZYnKXLz420EODC
         +RYkXSd2NojH3E7zPYBfzkmVXypQe4hLBqOSLghccQaEe9VoRhSd0wcwU6vxqbudxXd+
         CMeNNBc0o/exrKRlAubC8DfRmgqZzgb79vQfcin0r9b0QMjxL9qW0PgSYwDKmfaEr5DF
         LWNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780965943; x=1781570743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJ+42FNOQlLGP72/WCCwSH69VqWPR0+k8FAdurNbVLo=;
        b=eJhQeshHaeHyVz1wwEdYWxTNyzOcNjd/bNbpxc5J+jL7VE1TxffBBJtyf+jlzI18vi
         VbyiekLkaP6TDGiT6zAZN6ACi09vsTZn8Rp9uL01KGwKjoOlA2N5yuGCq5JVc/65u3Ah
         aPgxgDpJ9PmHg4dcqI1fUPEaZQsN6VagmYmvbgs+JrB88YxicfxGMhkSGMjku+LAu7T0
         juMtbePM1+KEpJJPbf4bXKideO7Q8UW5s2gHpSdhqbZTiPkOk6Mz9KbhjYLLmukPb2bv
         ejrw0TXNsqSBbfQiB3fKu2flbknedaQ/LNg7om8QidZ/knjvfHKscfOqSzBT0f2dP/tT
         jDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780965943; x=1781570743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FJ+42FNOQlLGP72/WCCwSH69VqWPR0+k8FAdurNbVLo=;
        b=fwcrgiG2mNyeNyhSAs2mAkCbhKA8m4fagvrwivBYH5F5ItwaNSmzNWrG3rqqyNtwp+
         +syhmEoWjQciw5u4AaCJvO8Q2K2ngPlMzG2Wv6mzc0Vfbv+qMZ0G/pY9M1LbFFGzIofx
         pPpCxvYUMmzmcYtZiVMBOgZNMWvhDif8yZs7MbCCm06xeBoUXO0hoh0ZyswiTqq3PLdY
         g5nvpU3wYDlQFXmaR+SyteoluHHYStZO8CRVyxoUdGZAM5seKHOiLfJKDcdYdOIjDyGu
         jYgVBetxPCuYQnFnfSkV2HmWem1DDMTPN0aQ87OsfYVrRrLgT/TcSe5M+/6BBHzQKcB3
         LLpw==
X-Forwarded-Encrypted: i=1; AFNElJ8Xodi3Ru9iMyAZwjlWOUaylVkPtd1Bg50kigutQAEndzEySVhRNWhYaWeenrpXUie2VhAEbKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMcE3ShimZgT4pw74EdgfI+LF8FeoF0i+gf9KCO8hp6xJKcy9K
	5lvxxbP+PdmCOAnp59qNAxYwgwyyXo08DKiTjOGiEYV5m0BgxEEv5N/Oxk3Egph5BwwINwS00vo
	YdwqG/GReI7PequcTTBiQUhNAwxrmdzCYdJ7NedQV
X-Gm-Gg: Acq92OGt/2rm0f3wxC3Ib/uehtj1QC5D0aSTNOqvOaEb4aMytyoHzrRtT945kGKMMqZ
	dnAuh7/DDUcc78+oQX8SW8oI3Q/s3SQOp927wlwlBxx1AVf00UPbU8p1FkBS1mDNtmsPcmbt6f+
	abUp0ncFFYgTL3qvPeeAN7ewU2eiZ8FarDJSLrM4zXN23t05XFjuBW6Z8ZIFfXqcUs7Kxc6Gdpw
	Fx9yMoCzb8iq7xD5C0q6tvHtMKI0ZwTXPSA2kSNgbtNNiUCP3yPNSATu2LrrNjw5VkLOdy3uY4O
	eRpSDveVlO/h6KDY8DOA46iZkUzZLEq6F8/NBmtxdJc4cUt/X4QtEdABBbrZ9LV8u9ptjHAxWuF
	IJXOeG6rW3QuMKSGckShgwlPt8sXN
X-Received: by 2002:ac8:5a96:0:b0:517:8353:3492 with SMTP id
 d75a77b69052e-517ca5cd26dmr8751491cf.27.1780965942127; Mon, 08 Jun 2026
 17:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608151452.706822-1-edumazet@google.com> <aic-SfHAIsYCswa7@gandalf.schnuecks.de>
In-Reply-To: <aic-SfHAIsYCswa7@gandalf.schnuecks.de>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 17:45:30 -0700
X-Gm-Features: AVVi8CeNXuAYjtVyamRf1EmwTKQeDWkwJZ4Ot7uCCseDPWRS3O7sOXBF1eZnb4E
Message-ID: <CANn89iKybuU_JmTtt2U3JZJZp62oU-0ZXDdWb3vROZLhu+fzSQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: refine tcp_sequence() for the FIN exception
To: Simon Baatz <gmbnomis@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296812-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gmbnomis@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B93665B729

On Mon, Jun 8, 2026 at 3:12=E2=80=AFPM Simon Baatz <gmbnomis@gmail.com> wro=
te:
>
> Hi Eric,
>
> On Mon, Jun 08, 2026 at 03:14:52PM +0000, Eric Dumazet wrote:
> > Commit 0e24d17bd966 ("tcp: implement RFC 7323 window retraction
> > receiver requirements") removed the special FIN case that
> > was added in commit 1e3bb184e941 ("tcp: re-enable acceptance of
> > FIN packets when RWIN is 0").
>
> Commit 0e24d17bd966 did not remove the special handling; it is still
> present and covered by the test "tcp_rcv_zero_wnd_fin.pkt".
>
> > If a peer sends a segment containing data and a FIN flag before
> > it learns about our window retraction and has a buggy TCP stack,
> > it might place the FIN one byte beyond what it thinks is the
> > right edge of the window (i.e., max_window_edge + 1).
>
> The FIN exception in tcp_data_queue() is not a generic allowance for
> incorrect FIN handling.  It is much more specific and only applies
> when:
>
> 1. the packet is in-sequence
> 2. RWIN =3D=3D 0
> 3. the packet is a bare FIN
>
> > The data portion (end_seq - th->fin) will end exactly at max_window_edg=
e.
> > In this case, we will drop the packet if our receive queue is not empty=
,
> > even though the data was sent within the window we previously allowed.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Simon Baatz <gmbnomis@gmail.com>
> > ---
> >  net/ipv4/tcp_input.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index ab7a4e5435a8a2cbb532d42c54af76d8541c903b..8560a9c6d38207c098d6734=
97caf2c7652c36f5c 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -4812,18 +4812,20 @@ static enum skb_drop_reason tcp_sequence(const =
struct sock *sk,
> >                                        const struct tcphdr *th)
> >  {
> >       const struct tcp_sock *tp =3D tcp_sk(sk);
> > +     u32 seq_limit;
> >
> >       if (before(end_seq, tp->rcv_wup))
> >               return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
> >
> > -     if (unlikely(after(end_seq, tp->rcv_nxt + tcp_max_receive_window(=
tp)))) {
> > +     seq_limit =3D tp->rcv_nxt + tcp_max_receive_window(tp);
> > +     if (unlikely(after(end_seq, seq_limit))) {
> >               /* Some stacks are known to handle FIN incorrectly; allow=
 the
> >                * FIN to extend beyond the window and check it in detail=
 later.
> >                */
> > -             if (!after(end_seq - th->fin, tp->rcv_nxt + tcp_receive_w=
indow(tp)))
> > +             if (!after(end_seq - th->fin, seq_limit))
> >                       return SKB_NOT_DROPPED_YET;
>
> It is not clear which additional case this change is intended to
> allow.  Are you sure such a packet would not be rejected by later
> checks in the data path?
>
> (For the existing FIN exception, the previous condition also seems
> broader than necessary. Actually, it should be sufficient to use
> "!after(end_seq - th->fin, tp->rcv_nxt)")

It is possible our internal sashiko instance got this wrong.

<quote>
If tcp_max_receive_window() is greater than tcp_receive_window()
(i.e. the window was shrunk), and end_seq is after tcp_max_receive_window()=
,
 then end_seq - th->fin will always be after tcp_receive_window().
Does this mean the FIN workaround is disabled when the window has been shru=
nk?
 Should this use tcp_max_receive_window() instead?
</quote>

Can you suggest an alternative? Why using two confusing variants of
what should be the same stuff?

Other points from sashilko:

> @@ -7185,6 +7183,7 @@ static int tcp_rcv_synsent_state_process(struct soc=
k *sk, struct sk_buff *skb,
>  */
>  WRITE_ONCE(tp->rcv_nxt, TCP_SKB_CB(skb)->seq + 1);
>  tp->rcv_wup =3D TCP_SKB_CB(skb)->seq + 1;
> + tp->rcv_mwnd_seq =3D tp->rcv_wup + tp->rcv_wnd;
>
>  /* RFC1323: The window in SYN & SYN/ACK segments is
>  * never scaled.

Since the SYN packet only advertises min(tp->rcv_wnd, 65535U), does setting
rcv_mwnd_seq to tp->rcv_wup + tp->rcv_wnd here track a much larger window t=
han
was actually advertised if tp->rcv_wnd is greater than 65535? If window sca=
ling
is not negotiated, this maximum window sequence number will remain inflated=
.
Should this be clamped to 65535?

[ ... ]

> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -612,6 +612,7 @@ struct sock *tcp_create_openreq_child(const struct so=
ck *sk,
>  newtp->window_clamp =3D req->rsk_window_clamp;
>  newtp->rcv_ssthresh =3D req->rsk_rcv_wnd;
>  newtp->rcv_wnd =3D req->rsk_rcv_wnd;
> + newtp->rcv_mwnd_seq =3D newtp->rcv_wup + req->rsk_rcv_wnd;
>  newtp->rx_opt.wscale_ok =3D ireq->wscale_ok;

Similarly here, the SYNACK only advertises min(req->rsk_rcv_wnd, 65535U). D=
oes
setting rcv_mwnd_seq using the unclamped req->rsk_rcv_wnd track a larger wi=
ndow
than was ever advertised?


Neal, what do you think?

