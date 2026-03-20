Return-Path: <netdev+bounces-270064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMdZJnqzvWlBAgMAu9opvQ
	(envelope-from <netdev+bounces-270064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:52:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 978E32E1071
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51726302205F
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7267318EFA;
	Fri, 20 Mar 2026 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="H0cuRQ4j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA252FDC27
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039927; cv=none; b=b9gcjl5Erx97GBto+m16LaDG4dYqXsi/9ARrtAZsNRLHxJUg7Nfhx8/hS07jPrRzJmi6zjQYW/tL17PcdzIlLvkepKVN3cI8vnx5vGhJEQWMYIEnmQr/A4DeuuyDmAbsK0sie3VFqlf5OwFRHWeG5ZW4LQ0CAa2vGsgJ/cPVfOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039927; c=relaxed/simple;
	bh=u8T8rthZ9wOE9SwTOxKopy/sOuj+f1oXATyf1CvVc6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SX8ct+64zNBgp3lC1uH58wJJ7J9rnCkDp3QySMC4ImxQNGOhCEczHkEFaeJCguO5+WNx2TQSYlLj5dpdOU7x5EyuT6aw0hSYBuWxqy0a3kQPX014z09iO88bILeOyG5YnZWdF47QzlsopTnH63lN9JwcwcCc2jJIx6NMXQxyGVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=H0cuRQ4j; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5rER4OI3t7zOkcu0XLPb5o+6T/en3j2/stdXSEWZSJo=; t=1774039926; x=1774903926; 
	b=H0cuRQ4j5jBzFGeu70PhudpQZ0pk3Hjg9wBGtpYz+3/hTMIrEFZmF1iqVbPM2vADRur/Q+nxKf6
	VRIUOacSHicZyTz7MZYV57wPnZVeEXATkKTHnfHsaUYJKcdKRD9BB3dmUCGTBv5rIzdIpyWo3HPxw
	NUkfTHf74W41m5QhYzdepla+TcBjLWdn84GixqUsTXN29oXLZ37qF6sI7Gh/FOS292fJG5R5myKNq
	yF1ddlDtQWzBywRPHlAsjKUebco7QR5dg7ef4KYpLtcJrt5ISzscaAlxB3Dtar8XftRN0D3Q4i5FF
	b8WG7XD9ot8TAaO5knPHMxcAuMRhjWrPrXXw==;
Received: from mail-yx1-f42.google.com ([74.125.224.42]:60683)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1w3gp2-0006UI-VI
	for netdev@vger.kernel.org; Fri, 20 Mar 2026 13:51:59 -0700
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so2692015d50.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 13:51:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSdLUue68nD3fD2jhOFboFNE+ZvR6+NoySWq/KFBlZIonufnfIl6WrqE6T6YO4WJtMqP2xrV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz19NozSDxGLON4862jLXjd8ijl4oEI4qUpyAFTwWo0Ykzv7swb
	nkzo55vdmHrk65oX+BZyJGWlyS6pvaDE4ikU+R0DAhIXaKK4kjQ4EWqhZRlSRnB0zqnvvLoI1I5
	D1R3B5IwN2MPE0QEtLMlGXAoK98bu7HI=
X-Received: by 2002:a05:690e:1289:b0:64e:b234:97cf with SMTP id
 956f58d0204a3-64eb2349a86mr2617598d50.71.1774039916221; Fri, 20 Mar 2026
 13:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316223228.2611-12-ouster@cs.stanford.edu> <20260318072144.269088-1-pabeni@redhat.com>
In-Reply-To: <20260318072144.269088-1-pabeni@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 20 Mar 2026 13:51:21 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzV93hdx0+NGSkdD44+oaonP4zJXw3qbmEvMui8=9Nfwg@mail.gmail.com>
X-Gm-Features: AaiRm52fKlLnOqdTSSlhWwtpqmo56XsW02Zf-GIqT8wnp0I3-txOk9yndnPCyek
Message-ID: <CAGXJAmzV93hdx0+NGSkdD44+oaonP4zJXw3qbmEvMui8=9Nfwg@mail.gmail.com>
Subject: Re: [net-next,v17,11/14] net: homa: create homa_incoming.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org, netdev@vger.kernel.org, kuba@kernel.org, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 53142c4f680bfafda0ac758f095099ea
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270064-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 978E32E1071
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 12:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> net: homa: create homa_incoming.c
>
> This file contains most of the code for handling incoming packets,
> including top-level dispatching code plus specific handlers for each
> pack type. It also contains code for dispatching fully-received
> messages to waiting application threads.
>
> > diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
> > index 4726762b688f..779abd7bb1b7 100644
> > --- a/net/homa/homa_impl.h
> > +++ b/net/homa/homa_impl.h
>
> [ ... ]
>
> > diff --git a/net/homa/homa_incoming.c b/net/homa/homa_incoming.c
> > new file mode 100644
> > index 000000000000..f083784921f4
> > --- /dev/null
> > +++ b/net/homa/homa_incoming.c
>
> [ ... ]
>
> > @@ -0,0 +1,887 @@
>
> [ ... ]
>
> > +/**
> > + * homa_add_packet() - Add an incoming packet to the contents of a
> > + * partially received message.
> > + * @rpc:   Add the packet to the msgin for this RPC.
> > + * @skb:   The new packet. This function takes ownership of the packet
> > + *         (the packet will either be freed or added to rpc->msgin.pac=
kets).
> > + */
> > +void homa_add_packet(struct homa_rpc *rpc, struct sk_buff *skb)
> > +     __must_hold(rpc->bucket->lock)
> > +{
> > +     struct homa_data_hdr *h =3D (struct homa_data_hdr *)skb->data;
> > +     struct homa_gap *gap, *dummy, *gap2;
> > +     int start =3D ntohl(h->seg.offset);
> > +     int length =3D homa_data_len(skb);
> > +     enum skb_drop_reason reason;
> > +     int end =3D start + length;
> > +
> > +     if ((start + length) > rpc->msgin.length) {
> > +             reason =3D SKB_DROP_REASON_PKT_TOO_BIG;
> > +             goto discard;
> > +     }
> > +
> > +     if (start =3D=3D rpc->msgin.recv_end) {
> > +             /* Common case: packet is sequential. */
> > +             rpc->msgin.recv_end +=3D length;
> > +             goto keep;
> > +     }
> > +
> > +     if (start > rpc->msgin.recv_end) {
> > +             /* Packet creates a new gap. */
> > +             if (!homa_gap_alloc(&rpc->msgin.gaps,
> > +                                 rpc->msgin.recv_end, start)) {
> > +                     reason =3D SKB_DROP_REASON_NOMEM;
> > +                     goto discard;
> > +             }
> > +             rpc->msgin.recv_end =3D end;
> > +             goto keep;
> > +     }
> > +
> > +     /* Must now check to see if the packet fills in part or all of
> > +      * an existing gap.
> > +      */
> > +     list_for_each_entry_safe(gap, dummy, &rpc->msgin.gaps, links) {
> > +             /* Is packet at the start of this gap? */
> > +             if (start <=3D gap->start) {
> > +                     if (end <=3D gap->start)
> > +                             continue;
> > +                     if (start < gap->start) {
> > +                             reason =3D SKB_DROP_REASON_DUP_FRAG;
> > +                             goto discard;
> > +                     }
> > +                     if (end > gap->end) {
> > +                             reason =3D SKB_DROP_REASON_DUP_FRAG;
> > +                             goto discard;
> > +                     }
> > +                     gap->start =3D end;
> > +                     if (gap->start >=3D gap->end) {
> > +                             list_del(&gap->links);
> > +                             kfree(gap);
> > +                     }
> > +                     goto keep;
> > +             }
> > +
> > +             /* Is packet at the end of this gap? BTW, at this point w=
e know
> > +              * the packet can't cover the entire gap.
> > +              */
> > +             if (end >=3D gap->end) {
> > +                     if (start >=3D gap->end)
> > +                             continue;
> > +                     if (end > gap->end) {
> > +                             reason =3D SKB_DROP_REASON_DUP_FRAG;
> > +                             goto discard;
> > +                     }
> > +                     gap->end =3D start;
> > +                     goto keep;
> > +             }
> > +
> > +             /* Packet is in the middle of the gap; must split the gap=
. */
> > +             gap2 =3D homa_gap_alloc(&gap->links, gap->start, start);
> > +             if (!gap2) {
> > +                     reason =3D SKB_DROP_REASON_NOMEM;
> > +                     goto discard;
> > +             }
> > +             gap2->time =3D gap->time;
> > +             gap->start =3D end;
> > +             goto keep;
> > +     }
> > +
> > +discard:
> > +     kfree_skb_reason(skb, reason);
>                            ^^^^^^
>
> Can the 'reason' variable be used uninitialized here? When data has been
> received sequentially (no gaps), a retransmitted duplicate packet with an
> offset below recv_end won't match any of the early conditions (it doesn't
> equal recv_end, it isn't greater than recv_end), so it falls through to t=
he
> gap traversal loop. With an empty gap list, the loop body never executes =
and
> execution continues to the discard label where kfree_skb_reason() is call=
ed
> with an uninitialized reason.

Fixed.

>
> [ ... ]
>
> > +/**
> > + * homa_copy_to_user() - Copy as much data as possible from incoming
> > + * packet buffers to buffers in user space.
> > + * @rpc:     RPC for which data should be copied. Must be locked by ca=
ller.
> > + * Return:   Zero for success or a negative errno if there is an error=
.
> > + *           It is possible for the RPC to be freed while this functio=
n
> > + *           executes (it releases and reacquires the RPC lock). If th=
at
> > + *           happens, -EINVAL will be returned and the state of @rpc
> > + *           will be RPC_DEAD. Clears the RPC_PKTS_READY bit in @rpc->=
flags
> > + *           if all available packets have been copied out.
> > + */
> > +int homa_copy_to_user(struct homa_rpc *rpc)
> > +     __must_hold(rpc->bucket->lock)
> > +{
>
> [ ... ]
>
> > +/**
> > + * homa_dispatch_pkts() - Top-level function that processes a batch of=
 packets,
> > + * all related to the same RPC.
> > + * @skb:       First packet in the batch, linked through skb->next.
> > + */
> > +void homa_dispatch_pkts(struct sk_buff *skb)
> > +{
>
> [ ... ]
>
> > +             switch (h->common.type) {
> > +             case DATA:
> > +                     homa_data_pkt(skb, rpc);
> > +                     break;
> > +             case RESEND:
> > +                     homa_resend_pkt(skb, rpc, hsk);
> > +                     break;
> > +             case RPC_UNKNOWN:
> > +                     homa_rpc_unknown_pkt(skb, rpc);
> > +                     break;
> > +             case BUSY:
> > +                     /* Nothing to do for these packets except reset
> > +                      * silent_ticks, which happened above.
> > +                      */
> > +                     goto discard;
> > +             case NEED_ACK:
> > +                     homa_need_ack_pkt(skb, hsk, rpc);
> > +                     break;
> > +             case ACK:
> > +                     homa_ack_pkt(skb, hsk, rpc);
> > +                     break;
> > +                     goto discard;
>                     ^^^^^^^^^^^^
>
> This goto is unreachable because it follows the break statement above.
> More critically, the switch has no default case. Looking at the validatio=
n
> in homa_softirq (which checks 'h->type >=3D DATA && h->type <=3D MAX_OP')=
,
> the header_lengths array (defined in homa_plumbing.c) has zero entries
> for types 0x11, 0x15, and 0x16. Packets with these type values pass
> validation since 'skb->len < 0' is always false.
>
> When such a packet reaches homa_dispatch_pkts, no case matches, execution
> falls through to 'continue', and the SKB is never freed. Can this leak
> memory?

Fixed (this was a bug in the script that strips out Homa features not
in the current patch series).

>
> [ ... ]
>
> > +/**
> > + * homa_ack_pkt() - Handler for incoming ACK packets
> > + * @skb:     Incoming packet; size already verified large enough for h=
eader.
> > + *           This function now owns the packet.
> > + * @hsk:     Socket on which the packet was received.
> > + * @rpc:     The RPC named in the packet header, or NULL if no such
> > + *           RPC exists. The RPC lock will be dead on return.
> > + */
> > +void homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
> > +               struct homa_rpc *rpc)
> > +     __must_hold(rpc->bucket->lock)
> > +{
> > +     const struct in6_addr saddr =3D skb_canonical_ipv6_saddr(skb);
> > +     struct homa_ack_hdr *h =3D (struct homa_ack_hdr *)skb->data;
> > +     int i, count;
> > +
> > +     if (rpc)
> > +             homa_rpc_end(rpc);
> > +
> > +     count =3D ntohs(h->num_acks);
> > +     if (count > 0) {
> > +             if (rpc) {
> > +                     /* Must temporarily release rpc's lock because
> > +                      * homa_rpc_acked needs to acquire RPC locks.
> > +                      */
> > +                     homa_rpc_unlock(rpc);
> > +                     for (i =3D 0; i < count; i++)
> > +                             homa_rpc_acked(hsk, &saddr, &h->acks[i]);
>                                                                ^^^^^^^^^^=
^
>
> Is 'count' validated before accessing h->acks[i] in this loop? The
> num_acks field comes from the network via ntohs() and can be any value
> from 0 to 65535. The acks array in struct homa_ack_hdr is declared as
> 'struct homa_ack acks[HOMA_MAX_ACKS_PER_PKT]' where HOMA_MAX_ACKS_PER_PKT
> is 5 in net/homa/homa_wire.h.
>
> If a peer sends an ACK packet with num_acks > 5, this code reads beyond
> the acks[] array boundary in the skb data. The out-of-bounds data is
> passed to homa_rpc_acked() which dereferences it (reading ack->server_por=
t
> and ack->client_id). Can this cause protocol state corruption or a kernel
> crash if the read extends beyond the skb's allocated linear data region?

Fixed.

