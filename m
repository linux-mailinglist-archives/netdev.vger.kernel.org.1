Return-Path: <netdev+bounces-256873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMDrBFTUg2kHuwMAu9opvQ
	(envelope-from <netdev+bounces-256873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 00:20:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 608EAED33B
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 00:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 102EC3010521
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 23:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A6B2ED848;
	Wed,  4 Feb 2026 23:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMgOt/kV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0898019D092
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 23:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770247249; cv=pass; b=TSk/J289L8NIngFmseporJYR4Ff4q4kirBlT+MNr5REX3wxXGJGim63R60bRpu9w/M8qjkOvetUCnQbRsrucSW727eq6VD6taTuFDcaWNmQLj5vSzJUVH4V5KzdfOk4hFF7TEdfy4sQIqGD+uUXZJgHfR5pxqSY9vfIsYKv6i/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770247249; c=relaxed/simple;
	bh=e6LZsTryfTcQy4Pz2/ojX1r0/E/G96EAYLEP3PKS+bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPo/jk35BsEbLc5kU5LMCfTNby80cw1PlidapTRMvlJl23HT98LrKP1cxJTtEs/SyeSq0RHqr3vnz91MinhomOq+Rg4tXasyVntWVk29H3nY+qhODlUYFjWYFqVJCBwd+Oq9DPflCtbyToPCksjefBEGKrsTToiUHO3fXcstcBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMgOt/kV; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-649c070ef3bso263841d50.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 15:20:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770247248; cv=none;
        d=google.com; s=arc-20240605;
        b=EWaiEtV921WJ2PLDcgKr/Yh0loPc3TXW6bTNKRicwZxk88E1K1QPUM5zp3unvUErFm
         VKB/7WkWtl1WDCboBICb1zombQNJfkzNEacwVdNVfnGaHJJFuO02JoewTQU97BS0WolR
         cQ/aqMAou+r5ABRKBchS0x+bsOKX9am/k2A11Bx/+f5YEXhb20HFe+MhzrtKgJEEZoIe
         rE2hMBdmRTehqYf+MCOwQrC42hmHXE6jQYB935XdnQY+w6AF1Xy531i42wxzuFvJOnA/
         gwqjRCLy7SXKWM9fRXkP4DPy3tjBUIKZ2+1DMgv/mwEBFZ7H60Zu9GiCaBF+g6knppSc
         tqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L4X2xVfl2Jh8yzFiNlhxikZ/cYLtkiWqxKndPZWci6E=;
        fh=c2JLyuRIEYNS5X/e+EGfXHD5vzK+saxKeQV2G1m639o=;
        b=CQ0eoTvJDyNRXvohbazepa3XGiGIgqKDREGBZ5hCvqr8oygwGusr/oaC5MPUPk3g6w
         k5WDII1TWmiRcLSeo9xm6Nm/BUHX6N8Zt9/mKVSF1pOUafg40+YD7gDFrQhZviziXJ3k
         DaKs1YoWc3StCWRohdXpJvS6wDe70kVyjEy1TOFs8b6zZOJnnjJqKljSJ3GP2bdgXv/p
         TKTcTTES9HLylxjNPI9HoYTXKy3AlkP2ZbrNH94NsqVagYNy4vIdjyTIvPn/OQ24xerp
         6SmVsVuVFZdFeO9jlCIFp20iOYwcfAZYkVI2R5r6ISboFrUP0uZePsZ+KLcLW6RPnnp6
         Bciw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770247248; x=1770852048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4X2xVfl2Jh8yzFiNlhxikZ/cYLtkiWqxKndPZWci6E=;
        b=lMgOt/kVc3i3AEg/46EsXCrNfR9wbhJHaXGFwZ5Vhy/g1f7xHPGaKiG+V9JjpSIYqz
         j4MoiBWQWw4wpXwcfB9NdEHFTQH9IRfwCPmFXrg8KD8UA2KruRhfXLXCrM+egwc3H0nX
         rq2anFugrI6FbrTf0es4FpZN9eghenMLQdMhm77RT6DCdcF29iiAgHRdjO8MCfgGDwiZ
         xpbzq2NCKTFscocrMK3woTcbny/F1dTZ8NN0F1fz/724mFo5gGkp0O+t79hwZ86hpFX/
         w+VnTPU8DoIY4JW9hluDPUzJnFlvk1b+OCeyhsENv4nlAbVuvWgpYFWODw6JRt7wLgpR
         x7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770247248; x=1770852048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L4X2xVfl2Jh8yzFiNlhxikZ/cYLtkiWqxKndPZWci6E=;
        b=BJ/ChmsDCpx6fnqifHawtvckYb9oRRdrhflMMHgjaoKXkOS6l9kMlmS40Ehh+CnKlN
         vGih9YJgQBsq+ZJlkWkR9w/60wnk2BKSkeslkRKewYD+NdRF+IQLHuK5Q3xUfDcfR0dK
         Nb3DehTy6AaxUTyJfVux/9MJKeaTbZHmTigLtsx0OOeEwPCywsg7fFiPW4FxOkiRzvqi
         g7/o6Yj3j/uhntd1RZmoE5nZKW6nqURJH8Oq5a3eNIR5a7YWH2kf+PYueOWE0VcLnXuw
         uBEbcVP3gBVlhPzzPSVP0rfi/N/u/+Hfo+xEJqXbG+mdw5eZ7+dAaFKlLBow9a4wx+8S
         kTkw==
X-Gm-Message-State: AOJu0YxR1NBWUazyjyLJDGPpghQ58JKlkvm2gAR4YiWyl7/QbxXGSg+3
	rTOIS1nRjxK30EPidVgEEKKDJHz9voM0XrPDcZBJ1C0XIaVFsU+ZbzInq0gfkHxe9UnSle3Cicb
	PLMTk6NCOrHDu7d4vpA8wyJvqVC+9Kd4=
X-Gm-Gg: AZuq6aKsMRK4HhATvjr00s8rFEzWIMJDIwyxaP9gsjRfSK+eZWzN6SpqBuVjzKk//4n
	gb/BenI7YVNi4i2pSTrtpP8pzJx0LXN85EkgVj/4lQBdCpQZuK+iC4+HqO4Llz8feag97aFTL8r
	Rc3ptAfQqeRX/IYcr/PLoVQ7NV0nPJmw7PpenxHD4VhCx18hSGG6REDlKWDn8MHrBxgZHuvB7AR
	0IIy/CLCtSC5Wj04ZwJGiRL4vkA8IE43lY1UIX/Qf8hTi3r4ktGlPeivSbXPql/bYLSeim8tPJk
	Ot3ojogIhUQ=
X-Received: by 2002:a05:690e:d4e:b0:649:da7e:9969 with SMTP id
 956f58d0204a3-649db32cabamr4437701d50.15.1770247247883; Wed, 04 Feb 2026
 15:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201175050.468601-1-ameryhung@gmail.com> <20260201175050.468601-12-ameryhung@gmail.com>
 <42d51b94-f8de-41df-98ba-b074e02e5d00@linux.dev>
In-Reply-To: <42d51b94-f8de-41df-98ba-b074e02e5d00@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 4 Feb 2026 15:20:37 -0800
X-Gm-Features: AZwV_QhkIMDqisvvqSDRhsndBLl2GRneG5vks0ICP-wc8Wj-b_qncAFBUn6-tJA
Message-ID: <CAMB2axPnw42gJ6XJjbhQy63Vzi2LsCnFbHauEeEqw9-A4pjrxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 11/16] bpf: Switch to bpf_selem_unlink_nofail
 in bpf_local_storage_{map_free, destroy}
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	haoluo@google.com, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256873-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 608EAED33B
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 5:52=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 2/1/26 9:50 AM, Amery Hung wrote:
> > Take care of rqspinlock error in bpf_local_storage_{map_free, destroy}(=
)
> > properly by switching to bpf_selem_unlink_nofail().
> >
> > Both functions iterate their own RCU-protected list of selems and call
> > bpf_selem_unlink_nofail(). In map_free(), to prevent infinite loop when
> > both map_free() and destroy() fail to remove a selem from b->list
> > (extremely unlikely), switch to hlist_for_each_entry_rcu(). In destroy(=
),
> > also switch to hlist_for_each_entry_rcu() since we no longer iterate
> > local_storage->list under local_storage->lock. In addition, defer it to
> > workqueue as sleep may not always be possible in destroy().
> >
> > Since selem, SDATA(selem)->smap and selem->local_storage may be seen by
> > map_free() and destroy() at the same time, protect them with RCU. This
> > means passing reuse_now =3D=3D false to bpf_selem_free() and
>
> Amery and I discussed some details offline. Summarize here to sync up
> the mailing list.
>
> If only map_free/destroy is using the selem/local_storage, reuse_now
> should be true. reuse_now =3D=3D true will go through the regular rcu gp.
> The current map_free/destroy should be under rcu_read_lock().
>
> fwiw, some history, iirc it used to always go through rcu gp only.
> Sleepable support was added later, so rcu_tasks_trace gp was added.
> After a regression report, reuse_now (the name may have been changed
> once) was added to signal that no bpf prog is using the selem and to
> avoid waiting for the rcu_tasks_trace gp.
>
> > bpf_local_storage_free(). The local storage map is already protected as
> > bpf_local_storage_map_free() waits for an RCU grace period after
> > iterating b->list and before freeing itself.
> >
> > bpf_selem_unlink() now becomes dedicated to helpers and syscalls paths
> > so reuse_now should always be false. Remove it from the argument and
> > hardcode it.
> >
> > Co-developed-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >   include/linux/bpf_local_storage.h |  5 +-
> >   kernel/bpf/bpf_cgrp_storage.c     |  3 +-
> >   kernel/bpf/bpf_inode_storage.c    |  3 +-
> >   kernel/bpf/bpf_local_storage.c    | 96 +++++++++++++++++-------------=
-
> >   kernel/bpf/bpf_task_storage.c     |  3 +-
> >   net/core/bpf_sk_storage.c         |  9 ++-
> >   6 files changed, 69 insertions(+), 50 deletions(-)
> >
> > diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_loca=
l_storage.h
> > index cfa301ccc700..0d04f6babb2e 100644
> > --- a/include/linux/bpf_local_storage.h
> > +++ b/include/linux/bpf_local_storage.h
> > @@ -101,6 +101,7 @@ struct bpf_local_storage {
> >       rqspinlock_t lock;      /* Protect adding/removing from the "list=
" */
> >       u64 selems_size;        /* Total selem size. Protected by "lock" =
*/
> >       refcount_t owner_refcnt;
> > +     struct work_struct work;
> >       bool use_kmalloc_nolock;
> >   };
> >
> > @@ -168,7 +169,7 @@ bpf_local_storage_lookup(struct bpf_local_storage *=
local_storage,
> >       return SDATA(selem);
> >   }
> >
> > -void bpf_local_storage_destroy(struct bpf_local_storage *local_storage=
);
> > +u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage)=
;
> >
> >   void bpf_local_storage_map_free(struct bpf_map *map,
> >                               struct bpf_local_storage_cache *cache);
> > @@ -181,7 +182,7 @@ int bpf_local_storage_map_check_btf(const struct bp=
f_map *map,
> >   void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_st=
orage,
> >                                  struct bpf_local_storage_elem *selem);
> >
> > -int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_=
now);
> > +int bpf_selem_unlink(struct bpf_local_storage_elem *selem);
> >
> >   int bpf_selem_link_map(struct bpf_local_storage_map *smap,
> >                      struct bpf_local_storage *local_storage,
> > diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storag=
e.c
> > index 853183eead2c..0bc3ab19c7b4 100644
> > --- a/kernel/bpf/bpf_cgrp_storage.c
> > +++ b/kernel/bpf/bpf_cgrp_storage.c
> > @@ -27,6 +27,7 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
> >       if (!local_storage)
> >               goto out;
> >
> > +     RCU_INIT_POINTER(cgroup->bpf_cgrp_storage, NULL);
> >       bpf_local_storage_destroy(local_storage);
> >   out:
> >       rcu_read_unlock();
> > @@ -89,7 +90,7 @@ static int cgroup_storage_delete(struct cgroup *cgrou=
p, struct bpf_map *map)
> >       if (!sdata)
> >               return -ENOENT;
> >
> > -     return bpf_selem_unlink(SELEM(sdata), false);
> > +     return bpf_selem_unlink(SELEM(sdata));
> >   }
> >
> >   static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *k=
ey)
> > diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_stor=
age.c
> > index 470f4b02c79e..eb607156ba35 100644
> > --- a/kernel/bpf/bpf_inode_storage.c
> > +++ b/kernel/bpf/bpf_inode_storage.c
> > @@ -68,6 +68,7 @@ void bpf_inode_storage_free(struct inode *inode)
> >       if (!local_storage)
> >               goto out;
> >
> > +     RCU_INIT_POINTER(bsb->storage, NULL);
> >       bpf_local_storage_destroy(local_storage);
> >   out:
> >       rcu_read_unlock_migrate();
> > @@ -110,7 +111,7 @@ static int inode_storage_delete(struct inode *inode=
, struct bpf_map *map)
> >       if (!sdata)
> >               return -ENOENT;
> >
> > -     return bpf_selem_unlink(SELEM(sdata), false);
> > +     return bpf_selem_unlink(SELEM(sdata));
> >   }
> >
> >   static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, voi=
d *key)
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_stor=
age.c
> > index 1846067e6e7e..d02ad9052bd6 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
> > @@ -381,7 +381,11 @@ static void bpf_selem_link_map_nolock(struct bpf_l=
ocal_storage_map_bucket *b,
> >       hlist_add_head_rcu(&selem->map_node, &b->list);
> >   }
> >
> > -int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_=
now)
> > +/*
> > + * Unlink an selem from map and local storage with lock held.
> > + * This is the common path used by local storages to delete an selem.
> > + */
> > +int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
> >   {
> >       struct bpf_local_storage *local_storage;
> >       bool free_local_storage =3D false;
> > @@ -415,10 +419,10 @@ int bpf_selem_unlink(struct bpf_local_storage_ele=
m *selem, bool reuse_now)
> >   out:
> >       raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
> >
> > -     bpf_selem_free_list(&selem_free_list, reuse_now);
> > +     bpf_selem_free_list(&selem_free_list, false);
> >
> >       if (free_local_storage)
> > -             bpf_local_storage_free(local_storage, reuse_now);
> > +             bpf_local_storage_free(local_storage, false);
>
> The false here is correct because bpf_selem_unlink is called by the bpf
> prog.
>
> This is related to the next change. The bpf_selem_unlink (called by bpf
> prog, so a normal path) can free the local_storage after unlinking the
> last selem...

You are right. I misread the semantics of reuse_now. Will fix.

>
> >
> >       return err;
> >   }
> > @@ -648,7 +652,7 @@ bpf_local_storage_update(void *owner, struct bpf_lo=
cal_storage_map *smap,
> >
> >       local_storage =3D rcu_dereference_check(*owner_storage(smap, owne=
r),
> >                                             bpf_rcu_lock_held());
> > -     if (!local_storage || hlist_empty(&local_storage->list)) {
> > +     if (!local_storage) {
> >               /* Very first elem for the owner */
> >               err =3D check_flags(NULL, map_flags);
> >               if (err)
> > @@ -696,17 +700,6 @@ bpf_local_storage_update(void *owner, struct bpf_l=
ocal_storage_map *smap,
> >       if (err)
> >               goto free_selem;
> >
> > -     /* Recheck local_storage->list under local_storage->lock */
> > -     if (unlikely(hlist_empty(&local_storage->list))) {
> > -             /* A parallel del is happening and local_storage is going
> > -              * away.  It has just been checked before, so very
> > -              * unlikely.  Return instead of retry to keep things
> > -              * simple.
> > -              */
> > -             err =3D -EAGAIN;
> > -             goto unlock;
> > -     }
> > -
>
> ... so skip checking hlist_empty(&local_storage->list) here before
> linking new selem could be UAF. The local_storage could have been freed
> in bpf_selem_unlink. If I am reading it correctly, this needs to be
> addressed.

I will try to make free_local_storage also work in map_free() and drop
the change in bpf_local_storage_update().

>
> >       old_sdata =3D bpf_local_storage_lookup(local_storage, smap, false=
);
> >       err =3D check_flags(old_sdata, map_flags);
> >       if (err)
> > @@ -810,13 +803,16 @@ int bpf_local_storage_map_check_btf(const struct =
bpf_map *map,
> >       return 0;
> >   }
> >
> > -void bpf_local_storage_destroy(struct bpf_local_storage *local_storage=
)
> > +/*
> > + * Deferred looping local_storage->list to workqueue since sleeping ma=
y not be
> > + * allowed in bpf_local_storage_destroy()
> > + */
> > +static void bpf_local_storage_free_deferred(struct work_struct *work)
> >   {
> > +     struct bpf_local_storage *local_storage;
> >       struct bpf_local_storage_elem *selem;
> > -     bool free_storage =3D false;
> > -     HLIST_HEAD(free_selem_list);
> > -     struct hlist_node *n;
> > -     unsigned long flags;
> > +
> > +     local_storage =3D container_of(work, struct bpf_local_storage, wo=
rk);
> >
> >       /* Neither the bpf_prog nor the bpf_map's syscall
> >        * could be modifying the local_storage->list now.
> > @@ -827,33 +823,44 @@ void bpf_local_storage_destroy(struct bpf_local_s=
torage *local_storage)
> >        * when unlinking elem from the local_storage->list and
> >        * the map's bucket->list.
> >        */
> > -     raw_res_spin_lock_irqsave(&local_storage->lock, flags);
> > -     hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) =
{
> > -             /* Always unlink from map before unlinking from
> > -              * local_storage.
> > -              */
> > -             bpf_selem_unlink_map(selem);
> > -             /* If local_storage list has only one element, the
> > -              * bpf_selem_unlink_storage_nolock() will return true.
> > -              * Otherwise, it will return false. The current loop iter=
ation
> > -              * intends to remove all local storage. So the last itera=
tion
> > -              * of the loop will set the free_cgroup_storage to true.
> > -              */
> > -             free_storage =3D bpf_selem_unlink_storage_nolock(
> > -                     local_storage, selem, &free_selem_list);
> > +     rcu_read_lock();
> > +restart:
> > +     hlist_for_each_entry_rcu(selem, &local_storage->list, snode) {
> > +             bpf_selem_unlink_nofail(selem, NULL);
> > +
> > +             if (need_resched()) {
> > +                     cond_resched_rcu();
>
> Unlike b->list, the local_storage->list should not be long. The current
> local_storage->list is also iterated under rcu_read_lock(). Can this
> iteration stay in bpf_local_storage_destroy and skip deferring to wq?

Make sense. Will move the deferred work back to destroy and remove
rcu_read_lock as this is already the assumption.

>
> > +                     goto restart;
> > +             }
> >       }
> > -     raw_res_spin_unlock_irqrestore(&local_storage->lock, flags)
> > +     rcu_read_unlock();
> >
> > -     bpf_selem_free_list(&free_selem_list, true);
> > +     bpf_local_storage_free(local_storage, false);
>
> I think this can be bpf_local_storage_free(..., true)

Ack.

>
> > +}
> > +
> > +/*
> > + * Destroy local storage when the owner is going away. Caller must cle=
ar owner->storage
> > + * and uncharge memory if memory charging is used.
> > + *
> > + * Since smaps associated with selems may already be gone, mem_uncharg=
e() or
> > + * owner_storage() cannot be called in this function. Let the owner (i=
.e., the caller)
> > + * do it instead.
> > + */
> > +u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
> > +{
> > +     INIT_WORK(&local_storage->work, bpf_local_storage_free_deferred);
> >
> > -     if (free_storage)
> > -             bpf_local_storage_free(local_storage, true);
> > +     queue_work(system_dfl_wq, &local_storage->work);
> >
> >       if (!refcount_dec_and_test(&local_storage->owner_refcnt)) {
> >               while (refcount_read(&local_storage->owner_refcnt))
> >                       cpu_relax();
> >               smp_mb();  /* pair with refcount_dec in bpf_selem_unlink_=
nofail */
>
> This puzzled me a bit when reading patch 10 alone without the following
> lines on local_storage->owner and local_storage->selems_size. :)
>
> A nit. It will be useful to have more details here in patch 11. My
> understanding is to ensure the map_free() see the local_storage->owner
> and the destroy() here sees the correct local_storage->selems_size?

Right. Will add a comment explaining it.

>
>  > +
>  > +    local_storage->owner =3D NULL;
>  > +
>  > +    return sizeof(*local_storage) + local_storage->selems_size;

