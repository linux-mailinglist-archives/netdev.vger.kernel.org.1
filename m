Return-Path: <netdev+bounces-256872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHNaAd7Sg2niugMAu9opvQ
	(envelope-from <netdev+bounces-256872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 00:14:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65328ED2E5
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 00:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A4A73011C73
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 23:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B5139A7EA;
	Wed,  4 Feb 2026 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpKuW2wk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC533395D92
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770246873; cv=pass; b=B/ggtcaxZwtnjfN3LFgWErOZ64VDdLeg112ZOhgbr0mukgn0GuNZ3Me+N5xTDRRIMIHB4XNZu9bwf/4Np4/cCdW/6fYAT5iMM9k15THd7eYBY/FHQTzikNWGNSbxb6u6slQAFZLY/kBzUGgjXdHdvApfhjd6m1EcRrI07gzMSkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770246873; c=relaxed/simple;
	bh=IiqA/rFNO1vQW2J9cQnDinMh4QaNx9n6QAdKHhGHXEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzcw9DBf3pz1uVteJxoe832FFMQnle0VBzCGgoc0MiXHH0S94URy/FDz+PuKOe8F8J0347HuOrJiXwfZkwwcB96nEOB0+bkDKTdcIG2VyOZtkc5V4XXTHMjIey0zez22I5ENDw8Ihivehjv+MqKjQoZ9HMqGAUX56XJZUT86Uiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpKuW2wk; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64937edbc9eso442659d50.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 15:14:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770246872; cv=none;
        d=google.com; s=arc-20240605;
        b=jEDVBw6YfLro8n24U7zoETkMMVEDTyv2zD1xCZe5vsbPaAv1vX14qy7ksgviBaFIgr
         VidGHwoG8mLRTvz7ycN/Tpy2pXgDrZfflsHPRkiKBR+A1EmK4IPLmf612J6EyDqJgwap
         aOV8Qno0SKpwOScW2xxj+2FJv43nestXNXxynW2zPq/Q7HLyhItTx0WUK89G/FTbq80z
         fPoFsZHmhvKlMQdjurtt+a0M+XEkzPB8F5pD98fiBZhGTghrD90BD7UeMUL3Bxt5zpOE
         /qlwGtLEvyDIl7bdXU53atky/Te1iMcEMsuoq5xOzMS0nFs6CxZvECFlYGnBGFEQz/im
         gpyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L7rT1lNMjBmrODx3tmMucvb/RArP0arp17qoTkgB6X0=;
        fh=lEhSTDYuJXGpjAVPBs44Is78gwfvfw9J8h8jogDOq2g=;
        b=dN+47J9JbvBWl51+1YC2azZojc+pJnV0eosRmo0ZMw2Rd2PZtjcb1AiOBoZyjIdoyn
         x62CAGBGF7Cs4WI5nwCfx/AIFO/+0tqGRo22TgF9ru+6qcMDkaN24FyNWgg+2IW2Hh/5
         EKR7Tq9IaOiImPAVTBEELrKEVcrvwNgKLokNhGhNO1XdmpvnV9/TfatNEGJ/sMRD3G/D
         EloP+ldbLuWGFyGfo3SboW9j4a/2PZXd8uP1tq7OY0NfXLnmkbpjf1GexuqIdXcgqmOo
         sHPl9nF4v7E8MhPUCIko0OLq4abxukr/ldtBzv1yXqd5kL4/2fvvpx+C84642EzWTwHy
         r9Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770246872; x=1770851672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7rT1lNMjBmrODx3tmMucvb/RArP0arp17qoTkgB6X0=;
        b=SpKuW2wk0dE/nZ7GrhfkIEcO8ybVlRiON31Key8DgGusql9SaKZ9D3315T7YVVha9L
         5l02LfU/huAjaLmJS7Pf3zZ4SYbNN00FdXsXjdTK/dovatGsSj7uUpUfqjXn0ZXFIPyE
         6QnRrLXZu25YOxAkp9zEO/HVSWK9mWYTSARL/JupglaY+IulJR3dfnOGf61Oc2fa/aKl
         SbKljaDxeGX9ytdzP6zRa59+t0NzmjFr8SvwLxNDlvoLlI25szIh0/5G41G+FfZ7SFfr
         xafpZfBLJeZtW4diVDTK9hlqaFONJEGuUtHYu69KdSyuKnJozUZMmHdeNzbiskRJPI5S
         /NJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770246872; x=1770851672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L7rT1lNMjBmrODx3tmMucvb/RArP0arp17qoTkgB6X0=;
        b=Q4PJsfy6sQYJkMOAafcCqoESijD8XZojUyH8PXoyPhdv8S+oXTse8+SqOoHa+9mjUX
         r9Yr6YgEnJ7c4IjMjUwk+gc10bN7zSrx0Ww9ggv5DZwwVIlza7wx7r6WvhVRP31sCCji
         oYcbDURfQXijs+y2Py2CyWmvbUhQe3o6awLVRQ9AELDeWDI/UejMJyzKpKz7xkaTakXc
         +3LgI+1LK12aSJMc1Kh83NeOAuh6wQECFQBD/MuYl/jpRJzjgQwGN9nsXme7BbpFX7uq
         1OVt9MsCyDt9eKap72D4TmFzjUIiuIbYJtAlO3LJCA1iwD2vCSxpbVCkhyLhCbyirOq3
         Y/5g==
X-Gm-Message-State: AOJu0YyyNieZe7qYFCYWIpxJwLvq7sYRun57IU78qlvS0DKrHO/dRm5J
	T6gv/9vUF/oOCySeVE5uwp/R3XE/b/356mi6CFPEXPlToCbaOBNikPSQvyLnHFvVg+BGro29lbv
	Pse3iqdTsW3OP+hkwGagtitfQsi7aJEI=
X-Gm-Gg: AZuq6aIEdBdJlNhHbp0DgWxtCrNJma1NRIk2FLpPRBSkdGuZuYuZWspicx1/enBj34V
	H+LgCBRzG8o5MRSw3X2/27MfPJrKd+1nM4557adENYuu1jfz9LwMYqHCtLn4uXNIQjaieTlrB5w
	k46Ge3U8QDbJH/UEHE0bZguSfNzVKc3ldwrd2YjX7lFrER9DTGI/Zl1pWq0qYQ4DsC2ZfNmEQVh
	gBgfIluDVIDdV6LKPUEk+C2fFhsz1lVrjfQ+mCZpsK8mBMfqf+87aWwQ/hunRBPMVulbziyZfeX
	sBBE/HSa59A=
X-Received: by 2002:a53:d7c6:0:b0:646:7a21:f03c with SMTP id
 956f58d0204a3-649db4be747mr2931371d50.81.1770246871745; Wed, 04 Feb 2026
 15:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201175050.468601-1-ameryhung@gmail.com> <20260201175050.468601-11-ameryhung@gmail.com>
 <d512e9fd-eb04-4194-ab75-b1d2e775461a@linux.dev>
In-Reply-To: <d512e9fd-eb04-4194-ab75-b1d2e775461a@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 4 Feb 2026 15:14:21 -0800
X-Gm-Features: AZwV_QhmrPJGhmmgnk-sHczAamINAc3SuRZriRPTwBx2UAj2CNnp1HOLOF_gmDc
Message-ID: <CAMB2axPMJe6hGeyaAXvzHKyap+9uoH=q66dtCTD-C4zioJa5DA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 10/16] bpf: Support lockless unlink when
 freeing map or local storage
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	haoluo@google.com, kernel-team@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256872-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65328ED2E5
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 9:39=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 2/1/26 9:50 AM, Amery Hung wrote:
> > +/*
> > + * Unlink an selem from map and local storage with lockless fallback i=
f callers
> > + * are racing or rqspinlock returns error. It should only be called by
> > + * bpf_local_storage_destroy() or bpf_local_storage_map_free().
> > + */
> > +static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *sel=
em,
> > +                                 struct bpf_local_storage_map_bucket *=
b)
> > +{
> > +     struct bpf_local_storage *local_storage;
> > +     struct bpf_local_storage_map *smap;
> > +     bool in_map_free =3D !!b;
> > +     unsigned long flags;
> > +     int err, unlink =3D 0;
> > +
> > +     local_storage =3D rcu_dereference_check(selem->local_storage, bpf=
_rcu_lock_held());
> > +     smap =3D rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_h=
eld());
> > +
> > +     /*
> > +      * Prevent being called twice from the same caller on the same se=
lem.
> > +      * map_free() and destroy() each holds a link_cnt on an selem.
> > +      */
> > +     if ((!smap && in_map_free) || (!local_storage && !in_map_free))
>
> There is chance that map_free() can see "!smap" in the very first call
> of bpf_selem_unlink_nofail(). For example, the destroy() may grab the
> b->lock and do the hlist_del_init_rcu(&selem->map_node). In the unlikely
> case, the destroy() cannot grab the local_storage->lock, so it does
> atomic_dec_and_test(&selem->link_cnt). If map_free() hits the !smap in
> the very first time, it cannot move on to do
> atomic_dec_and_test(&selem->link_cnt), and the selem will be leaked. It
> is unlikely if we can assume destroy() should be able to hold its own
> local_storage->lock (no bpf prog should be holding it and no ETIMEDOUT).
>
> I think the same goes for the "!local_storage" check calling from destroy=
().
>

Will fix it by changing to use bits to track whether map_free() or
destroy() has seen this selem or not.

>
> > +             return;
> > +
> > +     if (smap) {
> > +             b =3D b ? : select_bucket(smap, local_storage);
> > +             err =3D raw_res_spin_lock_irqsave(&b->lock, flags);
> > +             if (!err) {
> > +                     /*
> > +                      * Call bpf_obj_free_fields() under b->lock to ma=
ke sure it is done
> > +                      * exactly once for an selem. Safe to free specia=
l fields immediately
> > +                      * as no BPF program should be referencing the se=
lem.
> > +                      */
> > +                     if (likely(selem_linked_to_map(selem))) {
> > +                             hlist_del_init_rcu(&selem->map_node);
> > +                             bpf_obj_free_fields(smap->map.record, SDA=
TA(selem)->data);
> > +                             unlink++;
> > +                     }
> > +                     raw_res_spin_unlock_irqrestore(&b->lock, flags);
> > +             }
> > +             /*
> > +              * Highly unlikely scenario: resource leak
> > +              *
> > +              * When map_free(selem1), destroy(selem1) and destroy(sel=
em2) are racing
> > +              * and both selem belong to the same bucket, if destroy(s=
elem2) acquired
> > +              * b->lock and block for too long, neither map_free(selem=
1) and
> > +              * destroy(selem1) will be able to free the special field=
 associated
> > +              * with selem1 as raw_res_spin_lock_irqsave() returns -ET=
IMEDOUT.
> > +              */
> > +             WARN_ON_ONCE(err && in_map_free);
> > +             if (!err || in_map_free)
> > +                     RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
> > +     }
> > +
> > +     if (local_storage) {
> > +             err =3D raw_res_spin_lock_irqsave(&local_storage->lock, f=
lags);
> > +             if (!err) {
> > +                     /*
> > +                      * Normally, map_free() can call mem_uncharge() i=
f destroy() is
> > +                      * not about to return to the owner, which can th=
en go away
> > +                      * immediately. Otherwise, the charge of the sele=
m will stay
> > +                      * accounted in local_storage->selems_size and un=
charged during
> > +                      * destroy().
> > +                      */
> > +                     if (likely(selem_linked_to_storage(selem))) {
> > +                             hlist_del_init_rcu(&selem->snode);
> > +                             if (smap && in_map_free &&
>
> I think the smap non-null check is not needed.

While smap is still valid in map_free(), SDATA(selem)->smap could have
been init to NULL, and then mem_uncharge() will dereference a null
pointer.

>
> > +                                 refcount_inc_not_zero(&local_storage-=
>owner_refcnt)) {
> > +                                     mem_uncharge(smap, local_storage-=
>owner, smap->elem_size);
> > +                                     local_storage->selems_size -=3D s=
map->elem_size;
> > +                                     refcount_dec(&local_storage->owne=
r_refcnt);
> > +                             }
> > +                             unlink++;
> > +                     }
> > +                     raw_res_spin_unlock_irqrestore(&local_storage->lo=
ck, flags);
> > +             }
> > +             if (!err || !in_map_free)
> > +                     RCU_INIT_POINTER(selem->local_storage, NULL);
> > +     }
> > +
> > +     /*
> > +      * Normally, an selem can be unlinked under local_storage->lock a=
nd b->lock, and
> > +      * then freed after an RCU grace period. However, if destroy() an=
d map_free() are
> > +      * racing or rqspinlock returns errors in unlikely situations (un=
link !=3D 2), free
> > +      * the selem only after both map_free() and destroy() drop their =
link_cnt.
> > +      */
> > +     if (unlink =3D=3D 2 || atomic_dec_and_test(&selem->link_cnt))
> > +             bpf_selem_free(selem, false);
>
> This can be bpf_selem_free(..., true) here.

Ack.

>
>

