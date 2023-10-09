Return-Path: <netdev+bounces-39114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0267BE205
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB551C208F0
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6CE347C2;
	Mon,  9 Oct 2023 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="RYUbBQiq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64473347BA
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 14:02:26 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C392E94
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:02:24 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9191f0d94cso4676393276.3
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 07:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696860144; x=1697464944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr1KrnbRKYhIlUJMB/5uJH8ttam2WYmXtqA/TkqjB8A=;
        b=RYUbBQiqgrskJ70DQAgMoyIiA4G3AWBMIwjXRgbtk0d6/ZEay3UZv25+P0KtrgiXcI
         6FgAzLsZVmdkWpfB9XsYXXBV/yySnLWOqSm9aJQ1vxfeX4L1RnAxep2e6J3oUhoqU01k
         HmBqp6jftVIHEHbMwfrqWiyBB8g3ZPc3F/MjK1PXXuefl3Uj5bX0mKG09t1pOiws6Z9r
         7zS8p6LoyOajgHdNru6Fxlw3uUdAJXvvH/Rcx5IxfX8wAXHwCsqNZSgD9/wTa5FtGxkT
         QC48VqGB5ztlvybJnz0q6BbgcwDdFhRIVjg2gQA1h8jLvp13KHSng69qPWqtLmXNiy+q
         Vdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696860144; x=1697464944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jr1KrnbRKYhIlUJMB/5uJH8ttam2WYmXtqA/TkqjB8A=;
        b=EgiAfzCLjVpQKPf+mO+QfkJA616NYfxavqxRfmMFXRwiFItf5APanrJjPcNaQRqvT3
         4XBZqihwQDC9nIXmzNOxFqwpbyF+uauj4TsLQ5nMzb8KVx2lQJVjjgQ97e8T+qFXquF4
         eNa1grIkcW+Qd7Ev56GoOQf7e2XPpoJCCjf5yW1pN8BViW43fTfyeLQgnGChbaBN6r39
         /KLNRbTQv6owITzGUMoS0b58PCxJzmkBoqUrXOcoNE99K5pcm2whYIZzaV7DgDoRLirz
         FydizPZ8/KisHdyD2WZgE0IltRIyb3TCRFYvQLh1mhYXJTfrTr6nsb9tZNK82wFqR0zy
         os7g==
X-Gm-Message-State: AOJu0YzDurQIxmSN0ulWlf938TI+G7995C0/Q/DU4dSjginh8BTjToE7
	HXdRUFF5hdoQeNFqRHiw0nZvCDCt49ho7T8QQ2dzAA==
X-Google-Smtp-Source: AGHT+IG+eXJKUNy4GlFNJnDi2SX3oAKLhi8qwgpNLb45K/KPphyDt8USQgt/C3M6O2X6ohBGa1xMPJdOffVeeKiGluI=
X-Received: by 2002:a25:c341:0:b0:d86:52d8:bf40 with SMTP id
 t62-20020a25c341000000b00d8652d8bf40mr13333401ybf.17.1696860143942; Mon, 09
 Oct 2023 07:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230930143542.101000-1-jhs@mojatatu.com> <20230930143542.101000-14-jhs@mojatatu.com>
 <87edi5ysun.fsf@nvidia.com>
In-Reply-To: <87edi5ysun.fsf@nvidia.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 9 Oct 2023 10:02:11 -0400
Message-ID: <CAM0EoM=2ObA1yrasNWRFoSzB+JZ0su2TKrXH-D0k+Pth=aOUxg@mail.gmail.com>
Subject: Re: [PATCH RFC v6 net-next 13/17] p4tc: add table entry create,
 update, get, delete, flush and dump
To: Vlad Buslov <vladbu@nvidia.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kernel@mojatatu.com, 
	khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Vlad,

On Sun, Oct 8, 2023 at 12:36=E2=80=AFPM Vlad Buslov <vladbu@nvidia.com> wro=
te:
>
> On Sat 30 Sep 2023 at 10:35, Jamal Hadi Salim <jhs@mojatatu.com> wrote:

[..trimmed...]

> > +/* Invoked from both control and data path  */
> > +static int __p4tc_table_entry_update(struct p4tc_pipeline *pipeline,
> > +                                  struct p4tc_table *table,
> > +                                  struct p4tc_table_entry *entry,
> > +                                  struct p4tc_table_entry_mask *mask,
> > +                                  u16 whodunnit, bool from_control)
> > +__must_hold(RCU)
> > +{
> > +     struct p4tc_table_entry_mask *mask_found =3D NULL;
> > +     struct p4tc_table_entry_work *entry_work;
> > +     struct p4tc_table_entry_value *value_old;
> > +     struct p4tc_table_entry_value *value;
> > +     struct p4tc_table_entry *entry_old;
> > +     struct p4tc_table_entry_tm *tm_old;
> > +     struct p4tc_table_entry_tm *tm;
> > +     int ret;
> > +
> > +     value =3D p4tc_table_entry_value(entry);
> > +     /* We set it to zero on create an update to avoid having entry
> > +      * deletion in parallel before we report to user space.
> > +      */
> > +     refcount_set(&value->entries_ref, 0);
>
> TBH I already commented on one of the previous versions of this series
> that it is very hard to understand and review tons of different atomic
> reference counters, especially when they are modified with functions
> like refcount_dec_not_one() or unconditional set like in this place.
>
> I chose specifically this function because __must_hold(RCU) makes it
> look like it can be accessed concurrently from datapath, which is not
> obvious on multiple previous usages of reference counters in the series.

True, tables can be manipulated from control plane/user space,
datapath as well as timers (mostly for delete).
Would using wrappers around these incr/decr help? i mean meaningful
inlines that will provide clarity as to what an incr/decr is?

> So what happens here if entries_ref was 0 to begin with? Or is possible
> for this function to be executed concurrently by multiple tasks, in
> which case all of them set entries_ref to 0, but first one that finishes
> resets the counter back to 1 at which point I assume it can be deleted
> in parallel by control path while some concurrent
> __p4tc_table_entry_update() are still running (at least that is what the
> comment here indicates)?

It's rtnl-lockless, so you can imagine what would happen there ;->
Multiple concurent user space, kernel, timers all contending for this.
Exactly what you said: its zero in this case because some entity could
delete it in parallel.
See comment further down which says "In case of parallel update, the
thread that arrives here first will..."
Consider it a poor man's lock. Does that help? Perhaps we could have
more discussion at the monthly tc meetup..
We have been testing this code a lot for concurrency and wrote some
user space tooling to catch such issues.

>
> > +
> > +     if (table->tbl_type !=3D P4TC_TABLE_TYPE_EXACT) {
> > +             mask_found =3D p4tc_table_entry_mask_add(table, entry, ma=
sk);
> > +             if (IS_ERR(mask_found)) {
> > +                     ret =3D PTR_ERR(mask_found);
> > +                     goto out;
> > +             }
> > +     }
> > +
> > +     p4tc_table_entry_build_key(table, &entry->key, mask_found);
> > +
> > +     entry_old =3D p4tc_entry_lookup(table, &entry->key, value->prio);
> > +     if (!entry_old) {
> > +             ret =3D -ENOENT;
> > +             goto rm_masks_idr;
> > +     }
> > +
> > +     /* In case of parallel update, the thread that arrives here first=
 will
> > +      * get the right to update.
> > +      *
> > +      * In case of a parallel get/update, whoever is second will fail =
appropriately
> > +      */
> > +     value_old =3D p4tc_table_entry_value(entry_old);
> > +     if (!p4tc_tbl_entry_put(value_old)) {
> > +             ret =3D -EAGAIN;
> > +             goto rm_masks_idr;
> > +     }
> > +
> > +     if (from_control) {
> > +             if (!p4tc_ctrl_update_ok(value_old->permissions)) {
> > +                     ret =3D -EPERM;
> > +                     goto set_entries_refcount;
> > +             }
> > +     } else {
> > +             if (!p4tc_data_update_ok(value_old->permissions)) {
> > +                     ret =3D -EPERM;
> > +                     goto set_entries_refcount;
> > +             }
> > +     }
> > +
> > +     tm =3D kzalloc(sizeof(*tm), GFP_ATOMIC);
> > +     if (unlikely(!tm)) {
> > +             ret =3D -ENOMEM;
> > +             goto set_entries_refcount;
> > +     }
> > +
> > +     tm_old =3D rcu_dereference_protected(value_old->tm, 1);
> > +     *tm =3D *tm_old;
> > +
> > +     tm->lastused =3D jiffies;
> > +     tm->who_updated =3D whodunnit;
> > +
> > +     if (value->permissions =3D=3D P4TC_PERMISSIONS_UNINIT)
> > +             value->permissions =3D value_old->permissions;
> > +
> > +     rcu_assign_pointer(value->tm, tm);
> > +
> > +     entry_work =3D kzalloc(sizeof(*(entry_work)), GFP_ATOMIC);
> > +     if (unlikely(!entry_work)) {
> > +             ret =3D -ENOMEM;
> > +             goto free_tm;
> > +     }
> > +
> > +     entry_work->pipeline =3D pipeline;
> > +     entry_work->table =3D table;
> > +     entry_work->entry =3D entry;
> > +     value->entry_work =3D entry_work;
> > +     if (!value->is_dyn)
> > +             value->is_dyn =3D value_old->is_dyn;
> > +
> > +     if (value->is_dyn) {
> > +             /* Only use old entry value if user didn't specify new on=
e */
> > +             value->aging_ms =3D value->aging_ms ?: value_old->aging_m=
s;
> > +
> > +             hrtimer_init(&value->entry_timer, CLOCK_MONOTONIC,
> > +                          HRTIMER_MODE_REL);
> > +             value->entry_timer.function =3D &entry_timer_handle;
> > +
> > +             hrtimer_start(&value->entry_timer, ms_to_ktime(value->agi=
ng_ms),
> > +                           HRTIMER_MODE_REL);
> > +     }
> > +
> > +     INIT_WORK(&entry_work->work, p4tc_table_entry_del_work);
> > +
> > +     if (rhltable_insert(&table->tbl_entries, &entry->ht_node,
> > +                         entry_hlt_params) < 0) {
> > +             ret =3D -EEXIST;
> > +             goto free_entry_work;
> > +     }
> > +
> > +     p4tc_table_entry_destroy_noida(table, entry_old);
> > +
> > +     if (!from_control)
> > +             p4tc_tbl_entry_emit_event(entry_work, RTM_P4TC_UPDATE,
> > +                                       GFP_ATOMIC);
> > +
> > +     return 0;
> > +
> > +free_entry_work:
> > +     kfree(entry_work);
> > +
> > +free_tm:
> > +     kfree(tm);
> > +
> > +set_entries_refcount:
> > +     refcount_set(&value_old->entries_ref, 1);
> > +
> > +rm_masks_idr:
> > +     if (table->tbl_type !=3D P4TC_TABLE_TYPE_EXACT)
> > +             p4tc_table_entry_mask_del(table, entry);
> > +
> > +out:
> > +     return ret;
> > +}
> > +

[..trimmed..]

 cheers,
jamal

