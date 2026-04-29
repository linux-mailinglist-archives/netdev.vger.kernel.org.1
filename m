Return-Path: <netdev+bounces-282424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGwiMyIi8mm/oAEAu9opvQ
	(envelope-from <netdev+bounces-282424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:22:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 716F1496BFA
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5726300DA5E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA43378D63;
	Wed, 29 Apr 2026 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYWQiTRH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F182B376BE2;
	Wed, 29 Apr 2026 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475800; cv=none; b=RsirD2dqcDGbCGKQjFLsPmVYASliv1TqHY7izRmOAAtpgBm8FgZkoc2bVPjkyIWbdDaVkp+SidndqBj3LZ6NH/G7/JKtFw8AYbf7ItdKFEHQJ/MusejEZ9bxoN7801wyyiF52LNSH3WBQ4X1pasYzCn1n/OrbdXW1dXGIK2Zb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475800; c=relaxed/simple;
	bh=5xHRAC94+P2FlfCmO8sY+uPPWD1+bm11gzoQ7Z9zDec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyE9ZybVi44Nr6QRWcOfxFOq/PRyAUXZ0mdHDLYAiFq4WtRzy6kPG++whBesjN8XIShhKVHq6brnHJ6k8kgDfUL5HrUbkd0DQ05n3yD3IK6KWO/O4/cJ9lDesnxYKASKgE5CUgxNR+5yUQA5AyNC66mQV7rHmOaUkS1I9MICWL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYWQiTRH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777475795; x=1809011795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5xHRAC94+P2FlfCmO8sY+uPPWD1+bm11gzoQ7Z9zDec=;
  b=QYWQiTRHPv5Feg2AgKshN8N1p2tRFxazNKeoIJxtKP2TxQA3NN2etfJp
   ZUHX7zezAFJPYaBomkTEnuJXr9kSNEOjf4rNxwwIHpcskJPgdtqX6+4gn
   DkoXqEz52LC2R92meI/OUMstTt49icBG1V+JEn9NFVNH571OaN38ocEIH
   4A5oGgNPNjFflkAPKdbzqisn/zjWlNPC9TNncCgvIQMUeQmXP7loXo9f3
   js1OMNUR/GSZgQJy1jh+g7EWWVX5tm0MNHef27Da/DL0Kxgoek7f8vpDG
   N0imMuizpN1DbcnVA22A1zZjii/B405egV8Paf7JVXg+/s7RHjKxHRV91
   A==;
X-CSE-ConnectionGUID: 6/5RaoH+RPSZ5+j82Gh9cA==
X-CSE-MsgGUID: 148AMzi5TLu+iEMpTpphTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78393128"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78393128"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 08:16:34 -0700
X-CSE-ConnectionGUID: FMbyXfRQT2ygut5Wlbp8Qg==
X-CSE-MsgGUID: XWYlYyjzRpiVEDWT3HOE5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229699672"
Received: from arjan-box.jf.intel.com ([10.88.27.153])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 08:16:33 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
To: netdev@vger.kernel.org
Cc: syzbot+ca9d5686d06994c6547c@syzkaller.appspotmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in lane_ioctl (3)
Date: Wed, 29 Apr 2026 08:17:41 -0700
Message-ID: <20260429151741.660828-1-arjan@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <69f16c26.170a0220.34e5b8.0013.GAE@google.com>
References: <69f16c26.170a0220.34e5b8.0013.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 716F1496BFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[arjan@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282424-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.997];
	SUBJECT_HAS_QUESTION(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,ca9d5686d06994c6547c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fenrus.org:url,linux.intel.com:mid]

This email is created by automation to help kernel developers deal with
a large volume of bug reports by decoding oopses into more actionable
information.


Decoded Backtrace

1. __debug_object_init -- crash site (lib/debugobjects.c:632)

The WARN fires inside debug_print_object (inlined into
__debug_object_init). The object at 0xffff888077a60f78 (a timer_list) is
in the ACTIVE state when debug_object_init is called on it a second time.

  611 static void debug_print_object(struct debug_obj *obj, char *msg)
  612 {
  613     const struct debug_obj_descr *descr = obj->descr;
  614     static int limit;
  622     if (!debug_objects_enabled)
  623         return;
  625     if (limit < 5 && descr != descr_test) {
  626         void *hint = descr->debug_hint ?
  627             descr->debug_hint(obj->object) : NULL;
  628         limit++;
-> 629         WARN(1, KERN_ERR "ODEBUG: %s %s (active state %u) "
  630                 "object: %p object type: %s hint: %pS\n",
  631                 msg, obj_states[obj->state], obj->astate,
  632                 obj->object, descr->name, hint);
  633     }
  634     debug_objects_warnings++;
  635 }

  747 static void
  748 __debug_object_init(void *addr, const struct debug_obj_descr *descr,
  749                     int onstack)
  750 {
  751     struct debug_obj *obj, o;
  752     struct debug_bucket *db;
  753     unsigned long flags;
  755     debug_objects_fill_pool();
  757     db = get_bucket((unsigned long) addr);
  759     raw_spin_lock_irqsave(&db->lock, flags);
  761     obj = lookup_object_or_alloc(addr, db, descr, onstack, false);
  762     if (unlikely(!obj)) {
  763         raw_spin_unlock_irqrestore(&db->lock, flags);
  764         debug_objects_oom();
  765         return;
  766     }
  768     switch (obj->state) {
  769     case ODEBUG_STATE_NONE:
  770     case ODEBUG_STATE_INIT:
  771     case ODEBUG_STATE_INACTIVE:
  772         obj->state = ODEBUG_STATE_INIT;
  773         raw_spin_unlock_irqrestore(&db->lock, flags);
  774         return;
  775     default:
  776         break;
  777     }
  779     o = *obj;
  780     raw_spin_unlock_irqrestore(&db->lock, flags);
-> 780     debug_print_object(&o, "init");
  783     if (o.state == ODEBUG_STATE_ACTIVE)
  784         debug_object_fixup(descr->fixup_init, addr, o.state);
  785 }


2. timer_init_key -- kernel/time/timer.c:880

  786 static inline void debug_timer_init(struct timer_list *timer)
  787 {
-> 788     debug_object_init(timer, &timer_debug_descr);
  789 }

  834 static inline void debug_init(struct timer_list *timer)
  835 {
-> 836     debug_timer_init(timer);
  837     trace_timer_init(timer);
  838 }

  876 void timer_init_key(struct timer_list *timer,
  877         void (*func)(struct timer_list *), unsigned int flags,
  878         const char *name, struct lock_class_key *key)
  879 {
-> 880     debug_init(timer);
  881     do_init_timer(timer, func, flags, name, key);
  882 }


3. lane_ioctl / lecd_attach / lec_arp_init (net/atm/lec.c:1037)

  1264 static void lec_arp_init(struct lec_priv *priv)
  1265 {
  1266     unsigned short i;
  1268     for (i = 0; i < LEC_ARP_TABLE_SIZE; i++)
  1269         INIT_HLIST_HEAD(&priv->lec_arp_tables[i]);
  1270     INIT_HLIST_HEAD(&priv->lec_arp_empty_ones);
  1271     INIT_HLIST_HEAD(&priv->lec_no_forward);
  1272     INIT_HLIST_HEAD(&priv->mcast_fwds);
  1273     spin_lock_init(&priv->lec_arp_lock);
->1274     INIT_DELAYED_WORK(&priv->lec_arp_work, lec_arp_check_expire);
  1275     schedule_delayed_work(&priv->lec_arp_work, LEC_ARP_REFRESH_INTERVAL);
  1276 }

  748 static int lecd_attach(struct atm_vcc *vcc, int arg)
  749 {
  750     int i;
  751     struct lec_priv *priv;
  753     lockdep_assert_held(&lec_mutex);
  754     if (arg < 0)
  755         arg = 0;
  756     if (arg >= MAX_LEC_ITF)
  757         return -EINVAL;
  758     i = array_index_nospec(arg, MAX_LEC_ITF);
  759     if (!dev_lec[i]) {
  763         dev_lec[i] = alloc_etherdev(size);
  775         priv = netdev_priv(dev_lec[i]);
  776     } else {
  776         priv = netdev_priv(dev_lec[i]);
  777         if (rcu_access_pointer(priv->lecd))
  778             return -EADDRINUSE;
  779     }
->781     lec_arp_init(priv);   // called unconditionally for both new and
                                // existing priv -- no work cancellation

  1018 static int lane_ioctl(struct socket *sock, unsigned int cmd,
  1019                       unsigned long arg)
  1020 {
  1034     mutex_lock(&lec_mutex);
  1035     switch (cmd) {
  1036     case ATMLEC_CTRL:
->1037         err = lecd_attach(vcc, (int)arg);
  1038         if (err >= 0)
  1039             sock->state = SS_CONNECTED;
  1040         break;
  1049     mutex_unlock(&lec_mutex);
  1050     return err;
  1051 }


4. do_vcc_ioctl (net/atm/ioctl.c:159)

  153     error = -ENOIOCTLCMD;
  155     mutex_lock(&ioctl_mutex);
  156     list_for_each(pos, &ioctl_list) {
  157         struct atm_ioctl *ic = list_entry(pos, struct atm_ioctl, list);
  158         if (try_module_get(ic->owner)) {
->159             error = ic->ioctl(sock, cmd, arg);  // dispatches to lane_ioctl
  160             module_put(ic->owner);
  161             if (error != -ENOIOCTLCMD)
  162                 break;
  163         }
  164     }
  165     mutex_unlock(&ioctl_mutex);


Tentative Analysis

The ODEBUG WARNING fires when INIT_DELAYED_WORK() is called on a
timer_list (lec_priv.lec_arp_work) that is already in the ACTIVE state.

lec_arp_init() always calls INIT_DELAYED_WORK(&priv->lec_arp_work, ...)
followed by schedule_delayed_work(). lecd_attach() calls lec_arp_init()
unconditionally -- both for a brand-new device and for an existing one
in the else-branch. The only guard for the existing-device path is that
priv->lecd is NULL (no daemon currently attached).

The race is opened by lec_atm_close(), the ATM VCC close handler:

    Thread A (lec_atm_close):        Thread B (lecd_attach via lane_ioctl):
      rcu_assign_pointer(lecd, NULL)
      synchronize_rcu()                mutex_lock(&lec_mutex)
      [window open]                    sees priv->lecd == NULL -- passes guard
                                       lec_arp_init(priv)
                                         INIT_DELAYED_WORK on active timer
                                         --> ODEBUG WARN
      lec_arp_destroy(priv)            [too late: work already re-initialized]

lec_atm_close() clears priv->lecd to NULL *before* calling
lec_arp_destroy() (which contains cancel_delayed_work_sync). Because
lec_atm_close() does not hold lec_mutex, Thread B can observe
priv->lecd == NULL while lec_arp_work is still active, pass the guard
in lecd_attach(), and call lec_arp_init() on a live timer.

The lec_mutex protecting dev_lec[] was introduced by commit d13a3824bfd2
("net: atm: add lec_mutex"), which serialised lecd_attach() and friends
but did not update lec_atm_close() to also acquire the mutex. The
unconditional lec_arp_init() call for existing devices predates that
commit and has always been present.


Potential Solution

Add cancel_delayed_work_sync(&priv->lec_arp_work) in the else-branch of
lecd_attach(), immediately before the call to lec_arp_init(). This
ensures any in-flight work is drained before the timer is re-initialized,
regardless of whether lec_atm_close() has already cancelled it.
cancel_delayed_work_sync() is safe to call from a lec_mutex-held context
because lec_arp_check_expire() only acquires priv->lec_arp_lock (a
spinlock) and never tries to take lec_mutex.

    } else {
        priv = netdev_priv(dev_lec[i]);
        if (rcu_access_pointer(priv->lecd))
            return -EADDRINUSE;
+       cancel_delayed_work_sync(&priv->lec_arp_work);
    }
    lec_arp_init(priv);


More information

Oops-Analysis: http://oops.fenrus.org/reports/lkml/69f16c26.170a0220.34e5b8.0013.GAE@google.com/
Assisted-by: GitHub-Copilot linux-kernel-oops.

