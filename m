Return-Path: <netdev+bounces-269992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJoJA5+CvWk4+gIAu9opvQ
	(envelope-from <netdev+bounces-269992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:23:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 684682DE8C5
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E47830AB6FC
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332B73CD8A7;
	Fri, 20 Mar 2026 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="IdTcDIs5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5243CF66D
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026837; cv=none; b=lX7e7+01/9Cit7s3J7b/QCR3z5UrFDfbZWCJcf/EYokWfkj1izhA4eSVwE48KIAkssAyqhNB5hONlH1bwgqVoUcGug5qLnWL27JlZGaA0UlMutd+yqXlkL+eb6dA/kjo3lQ0Vp7+kyNd9Rknwvr5xHCitITgoOHXX3LQvsDUnXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026837; c=relaxed/simple;
	bh=5Uj+KXuA4h+e7HKCCizTs1oDVRsmKF+bEb03MJ30x8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6qk1oKyWB/Vi+CzbXa963CvGDSufcML37o7E1zPyhjylAZ7SjwFQxAmsH0NvMaMV/Y/qMeFSeYKrsLIeOwVRU51sDXagi1irdl4gzCl2RRMWrw0km40JUdz+ByLqr/KdXfPA863K5w0mquHy9jDp41rmyLaMqVUyDdgeWGzlDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=IdTcDIs5; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TYDd+JfGztIwECCe2UCUJrvR4/jSkQnEdQZs/d1BlCw=; t=1774026835; x=1774890835; 
	b=IdTcDIs5ftUzrKLR4um2zX2wEIwaI85jsWrBAlNs6cfIUvJlpSfG67KwZK55RIPG+r7HYuls+8W
	5DQOLgzwCzAVLLvMOjk+oAke4OMvIYtgJ438GM3ks/GY19t8213rfHApEc4hl6BZPgqAAtwRJRiEk
	X5+rvf0HvtWY76NAu3kMsVPsgZLpkTepGAbkRlvBZyHhEuUugFvBXFQT1tJZuk1qsrVA0xywPPcty
	NCN2cgCMPl3lvv/D16/BJz9sYocATgOycX9vGjU6N4I6By6hd95iyR4PcWM/Ml5Rvj6FwjFa8igRJ
	KC3KOLKvEpiLBU/4v7Jeub33/fHG2TsZuqnA==;
Received: from mail-yx1-f51.google.com ([74.125.224.51]:53478)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1w3dQ0-00014N-FJ
	for netdev@vger.kernel.org; Fri, 20 Mar 2026 10:13:54 -0700
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64c9707fc11so557066d50.2
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:13:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUM0gDrS2M8RUl7EGvaBNwXKobmBPiTjOYBCSg0Kyd9eezt1DItbD53F0kuqkpA2+adVe7XBAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAQnbTqypVibOuiU/BM6TZ3umwu11+sWuGy4bo3k8quP+uMej4
	LqgfYNmrO/ZDDPUGCRDoHV0pWHAJ3LwD9KcGwwEBwrP/DEy3uQMwBOtDp0x7S6tT7f98t6ifUrm
	x0+yp6qexPMoTiERg0qEOM+8n6Ig9hFQ=
X-Received: by 2002:a53:a58a:0:b0:64c:9ec3:d71a with SMTP id
 956f58d0204a3-64eaa7debd7mr2880619d50.48.1774026831643; Fri, 20 Mar 2026
 10:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316223228.2611-6-ouster@cs.stanford.edu> <20260318072119.268920-1-pabeni@redhat.com>
In-Reply-To: <20260318072119.268920-1-pabeni@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 20 Mar 2026 10:13:15 -0700
X-Gmail-Original-Message-ID: <CAGXJAmyDuz11NSwGnOopqBiOHeBPh2EFaegDJ6p=2O6-tHvNyA@mail.gmail.com>
X-Gm-Features: AaiRm531l3TMtcZSCmvxtAor6K3Ti9igIVKzRLl-UTv0Ubb4Z2aJ5WTuPRTsWGE
Message-ID: <CAGXJAmyDuz11NSwGnOopqBiOHeBPh2EFaegDJ6p=2O6-tHvNyA@mail.gmail.com>
Subject: Re: [net-next,v17,05/14] net: homa: create homa_peer.h and homa_peer.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org, netdev@vger.kernel.org, kuba@kernel.org, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 4cb9aaa4101379bd7eb31f2d6aed6f07
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269992-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.096];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 684682DE8C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 12:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> > +/**
> > + * homa_peer_free_net() - Garbage collect all of the peer information
> > + * associated with a particular network namespace.
> > + * @hnet:    Network namespace whose peers should be freed. There must=
 not
> > + *           be any active sockets or RPCs for this namespace.
> > + */
> > +void homa_peer_free_net(struct homa_net *hnet)
> > +{
> > +     struct homa_peertab *peertab =3D hnet->homa->peertab;
> > +     struct rhashtable_iter iter;
> > +     struct homa_peer *peer;
> > +
> > +     spin_lock_bh(&peertab->lock);
> > +     peertab->gc_stop_count++;
> > +     spin_unlock_bh(&peertab->lock);
> > +
> > +     rhashtable_walk_enter(&peertab->ht, &iter);
> > +     rhashtable_walk_start(&iter);
> > +     while (1) {
> > +             peer =3D rhashtable_walk_next(&iter);
> > +             if (!peer)
> > +                     break;
> > +             if (IS_ERR(peer))
> > +                     continue;
> > +             if (peer->ht_key.hnet !=3D hnet)
> > +                     continue;
> > +             if (rhashtable_remove_fast(&peertab->ht, &peer->ht_linkag=
e,
> > +                                        ht_params) =3D=3D 0) {
> > +                     homa_peer_release(peer);
> > +                     hnet->num_peers--;
> > +                     peertab->num_peers--;
> > +             }
> > +     }
> > +     rhashtable_walk_stop(&iter);
> > +     rhashtable_walk_exit(&iter);
>
> Does this code correctly protect peertab->num_peers updates? Looking at
> homa_peer_gc():
>
> net/homa/homa_peer.c:homa_peer_gc() {
>     spin_lock_bh(&peertab->lock);
>     ...
>     if (rhashtable_remove_fast(&peertab->ht, &peer->ht_linkage,
>                                ht_params) =3D=3D 0) {
>         homa_peer_release(peer);
>         peertab->num_peers--;
>         peer->ht_key.hnet->num_peers--;
>     }
>     ...
>     spin_unlock_bh(&peertab->lock);
> }
>
> and homa_peer_get():
>
> net/homa/homa_peer.c:homa_peer_get() {
>     ...
>     spin_lock_bh(&peertab->lock);
>     other =3D rhashtable_lookup_get_insert_fast(&peertab->ht,
>                                               &peer->ht_linkage, ht_param=
s);
>     ...
>     peertab->num_peers++;
>     key.hnet->num_peers++;
>     ...
>     spin_unlock_bh(&peertab->lock);
> }
>
> Both those functions hold peertab->lock while updating peertab->num_peers=
.
>
> But homa_peer_free_net() drops peertab->lock before the rhashtable walk a=
nd
> doesn't reacquire it before decrementing peertab->num_peers. Can a concur=
rent
> homa_peer_get() call (for any namespace) produce lost updates to
> peertab->num_peers? The gc_stop_count mechanism prevents concurrent GC bu=
t
> doesn't prevent concurrent homa_peer_get().
>
> Corrupted num_peers affects GC threshold decisions in the peertab->num_pe=
ers <
> peertab->gc_threshold check in homa_peer_gc().

Yep, this was a bug. I've changed the synchronization structure to
hold the lock continuously in homa_peer_free_net. This also eliminates
the need for gc_stop_count, so the code is now simpler.

> > +/**
> > + * homa_peer_prefer_evict() - Given two peers, determine which one is
> > + * a better candidate for eviction.
> > + * @peertab:    Overall information used to manage peers.
> > + * @peer1:      First peer.
> > + * @peer2:      Second peer.
> > + * Return:      True if @peer1 is a better candidate for eviction than=
 @peer2.
> > + */
> > +int homa_peer_prefer_evict(struct homa_peertab *peertab,
> > +                        struct homa_peer *peer1,
> > +                        struct homa_peer *peer2)
> > +{
> > +     /* Prefer a peer whose homa-net is over its limit; if both are ei=
ther
> > +      * over or under, then prefer the peer with the shortest idle tim=
e.
> > +      */
>                                                       ^^^^^^^^
>
> This isn't a bug, but the comment says "shortest idle time" while the cod=
e
> returns peer1->access_jiffies < peer2->access_jiffies, which prefers the =
peer
> accessed earlier (longest idle time). Since eviction should prefer stale =
peers,
> the code is correct but the comment should say "longest idle time".

Fixed.

> > +/**
> > + * homa_peer_free() - Release any resources in a peer and free the hom=
a_peer
> > + * struct. Invoked by the RCU mechanism via homa_peer_release.
> > + * @head:   Pointer to the rcu_head field of the peer to free.
> > + */
> > +void homa_peer_free(struct rcu_head *head)
> > +{
> > +     struct homa_peer *peer;
> > +
> > +     peer =3D container_of(head, struct homa_peer, rcu_head);
> > +     dst_release(rcu_dereference(peer->dst));
> > +     kfree(peer);
> > +}
>
> Is the RCU API correct here? homa_peer_free() is an RCU callback invoked =
via
> call_rcu from homa_peer_release():
>
> net/homa/homa_peer.h:homa_peer_release() {
>     if (refcount_dec_and_test(&peer->refs))
>         call_rcu(&peer->rcu_head, homa_peer_free);
> }
>
> RCU callbacks run after the grace period, outside any RCU read-side criti=
cal
> section. Using rcu_dereference() without holding rcu_read_lock() triggers
> lockdep 'suspicious rcu_dereference_check() usage' warnings at runtime.
>
> The peer is exclusively owned at this point (refcount was zero, grace per=
iod
> has passed). The same codebase uses the correct pattern in
> homa_peer_reset_dst():
>
> net/homa/homa_peer.c:homa_peer_reset_dst() {
>     ...
>     dst_release(rcu_replace_pointer(peer->dst, dst, true));
>     ...
> }
>
> Should this use rcu_dereference_protected(peer->dst, 1) instead of
> rcu_dereference(peer->dst)?

I have switched to rcu_dereference_protected.

> > +/**
> > + * homa_peer_get() - Returns the peer associated with a given host; cr=
eates
> > + * a new homa_peer if one doesn't already exist.
> > + * @hsk:        Socket where the peer will be used.
> > + * @addr:       Address of the desired host: IPv4 addresses are repres=
ented
> > + *              as IPv4-mapped IPv6 addresses.
> > + *
> > + * Return:      The peer associated with @addr, or a negative errno if=
 an
> > + *              error occurred. On a successful return the reference c=
ount
> > + *              will be incremented for the returned peer. The caller =
must
> > + *              eventually call homa_peer_release to release the refer=
ence.
> > + */
> > +struct homa_peer *homa_peer_get(struct homa_sock *hsk,
> > +                             const struct in6_addr *addr)
> > +{
> > +     struct homa_peertab *peertab =3D hsk->homa->peertab;
> > +     struct homa_peer *peer, *other;
> > +     struct homa_peer_key key;
> > +
> > +     key.addr =3D *addr;
> > +     key.hnet =3D hsk->hnet;
> > +     rcu_read_lock();
> > +     peer =3D rhashtable_lookup(&peertab->ht, &key, ht_params);
> > +     if (peer) {
> > +             homa_peer_hold(peer);
> > +             peer->access_jiffies =3D jiffies;
> > +             rcu_read_unlock();
> > +             return peer;
> > +     }
>
> Can this sequence race with homa_peer_gc()? The lookup uses
> rhashtable_lookup() under rcu_read_lock() but without peertab->lock. Then=
 it
> calls homa_peer_hold() which uses refcount_inc():
>
> net/homa/homa_peer.h:homa_peer_hold() {
>     refcount_inc(&peer->refs);
> }
>
> Concurrently, homa_peer_gc() can:
>
> net/homa/homa_peer.c:homa_peer_gc() {
>     spin_lock_bh(&peertab->lock);
>     ...
>     if (rhashtable_remove_fast(&peertab->ht, &peer->ht_linkage,
>                                ht_params) =3D=3D 0) {
>         homa_peer_release(peer);
>         ...
>     }
>     ...
>     spin_unlock_bh(&peertab->lock);
> }
>
> net/homa/homa_peer.h:homa_peer_release() {
>     if (refcount_dec_and_test(&peer->refs))
>         call_rcu(&peer->rcu_head, homa_peer_free);
> }
>
> If homa_peer_gc() removes the peer from the rhashtable and calls
> homa_peer_release() (dropping refcount to 0 and scheduling call_rcu) betw=
een
> the lookup and the hold, then refcount_inc() on a zero refcount triggers
> REFCOUNT_WARN and refuses the increment. This leaves the caller with an
> unref'd peer that will be freed after the RCU grace period.
>
> The standard kernel pattern for RCU + rhashtable lookups is
> refcount_inc_not_zero() with retry or fallback if it returns false. The R=
CU
> read lock keeps the memory valid but doesn't prevent the refcount from
> reaching zero.

Yep, there was a race. I switched to refcount_inc_not_zero as suggested.

> > +/**
> > + * homa_peer_add_ack() - Add a given RPC to the list of unacked
> > + * RPCs for its server. Once this method has been invoked, it's safe
> > + * to delete the RPC, since it will eventually be acked to the server.
> > + * @rpc:    Client RPC that has now completed.
> > + */
> > +void homa_peer_add_ack(struct homa_rpc *rpc)
> > +{
> > +     struct homa_peer *peer =3D rpc->peer;
> > +     struct homa_ack_hdr ack;
> > +
> > +     homa_peer_lock(peer);
> > +     if (peer->num_acks < HOMA_MAX_ACKS_PER_PKT) {
> > +             peer->acks[peer->num_acks].client_id =3D cpu_to_be64(rpc-=
>id);
> > +             peer->acks[peer->num_acks].server_port =3D htons(rpc->dpo=
rt);
> > +             peer->num_acks++;
> > +             homa_peer_unlock(peer);
> > +             return;
> > +     }
> > +
> > +     /* The peer has filled up; send an ACK message to empty it. The
> > +      * RPC in the message header will also be considered ACKed.
> > +      */
> > +     memcpy(ack.acks, peer->acks, sizeof(peer->acks));
> > +     ack.num_acks =3D htons(peer->num_acks);
> > +     peer->num_acks =3D 0;
> > +     homa_peer_unlock(peer);
> > +     homa_xmit_control(ACK, &ack, sizeof(ack), rpc);
> > +}
>
> Does this code leak kernel stack memory?

Yes, it does. I have fixed this everywhere, so there are no
uninitialized fields in control packets.

I'm pretty impressed at the ability of AI tools to find subtle bugs.

