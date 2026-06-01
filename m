Return-Path: <netdev+bounces-293854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLY7Hw/FHWq9dgkAu9opvQ
	(envelope-from <netdev+bounces-293854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:44:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E99FB623678
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E634E3045CB1
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2703F3DFC80;
	Mon,  1 Jun 2026 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="myHciPDg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AAB29CE1
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335854; cv=pass; b=JVxdu8FV832lrMFIqMOHr81UNIAAfShO4RiGjZfW/uk5mDZcMvY1RYQJEOW2WhMbq6KZkzPzmd0WwG03jmRhO559B63WBk7cB6JchmYmqe0ta0sMetwX6pxxQP5j+BisnLPwZWCkpsZ5wV/Fy2/vsNkqJoBEz7cBoeezFPx1ERQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335854; c=relaxed/simple;
	bh=twruprh43XLoMZkNw8GcKyuX+yx1pog9tQFXq3Gz3+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ac5B48tVyc5+O/102D1dRE1MkUTXhDX78vxun+eds5yly0uaPO97KPFMSo53K84By3Agdk2ClJ8G+Sp6NM0gyFTQpzt3m2dCFQIV9bl5mMgbiXGKRAsQfkGGx6BfoIbRAzY5LkV723O67McCp5d2novFqJj+IUHbO4HqVRWbcLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=myHciPDg; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7e2cb01a974so20018617b3.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 10:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780335851; cv=none;
        d=google.com; s=arc-20240605;
        b=GkiWGulIirat/1Oz+GwwIkqjQlrcG9lYiaDfSMGQA3vGLWNC7oEeMPc+JvMt7OlNw/
         GyuERg8F2TvBhSDRFqxwnHrAKHKEP+htkTwlRaLalYJbi+BUcOpQej6+OyYwImsbQqEE
         WOxSIT21tUeFtUYYjSsu3QoDZ0UcAXxc1IsKrjf5hqvQY7QY0QTg7sqVFwcinRHXiqme
         xQuF8i57DwxsqoOrlWMFd8XM3rc9uqa2P4Ct/QYz0ja/L3DtyiR9zFpFmEiOSU9kuHC/
         a5J13lesidlZtnG5VBmuoZ35mInHQpv9BS7b8zKRa+5/yarbFqLfy3aHh/ULUL5UQmq4
         TlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pqXRFVeeL93aTE5ejiuC4gnumOaUy10wmrQoHsegqwM=;
        fh=OyW4y0yd6lpGGsJN+qhpayszT5oubUk+IoTQ+QHpRjU=;
        b=Fm9WJXcKTuiulLvtl3u3fign+Yc14a5D/mr24n60PjGcGV74H3HX+Bqsay49yqymfp
         TXbFFcmxKvdJHYhhCgoKzi1eL0Yxgk6LrYuRSog4cad5KEjpveYjrB3+iI/EB0iniYsc
         ABJ8ZqwNSUugCbo2XnLUskzi/iXu/L03b1aC8/ita4fhuXUnqGxNwTq5++mnMnFvm6LO
         ooUuD1pVXL11m+vukpMkLtAFnb3PjHr2/767KIqv/qco8/6JqlU8xiUm2QJIn1nVqal+
         alt4fxKIinIc2stCi+PeBoalFOkEcuCdYyakM0gLUZPA93v/Y7yVkpNTHyN2iaWUboUr
         ehTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780335851; x=1780940651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqXRFVeeL93aTE5ejiuC4gnumOaUy10wmrQoHsegqwM=;
        b=myHciPDgEzcTl4wxKU0j6YgnSp9Z7GI6NQCQOKp6t0ks3/65+GN04g5dKj3fXxcjPq
         IV8VVQUn0eJKNDxRycWjXgR+qgi9MeMJ9zQsUgIg5npxT0acCLwV6cAgRlrZqVkE1G7Z
         ClJKROUv9ZauHGHYyHwFJIeeMyytFP6DFdY+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780335851; x=1780940651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pqXRFVeeL93aTE5ejiuC4gnumOaUy10wmrQoHsegqwM=;
        b=MzunrZ4TBqAkICM6pKVv5CgCyTo4CSiThllxzsVUa0O/G+XQN+pj0c4oM43Y/CUOAr
         7W/Huro/boB8XLuSL+t7EfGNTtgHgbqtGTd6hy9qMfITp7ZYjr3kNHuDmBZ8jRe4aD6q
         1Xn8brQZjbHEK03lkL1IZzHBLSVckVzyughwDZCKg6EEY05lyNldu3/7VOhaNAt3sVci
         rfeVZQgkKJYM4asELGvGHQEcM5uMz7hHmo1nRJhrIYclPtoOa1ZVCelvmTBiaSx1aEcb
         ApiMFHHR5RGfGi0KOM97pqw1G+oUQG78lZvOTyV87fysPIfqCKsHAc7s7VMvnAQzaHTi
         jfpA==
X-Gm-Message-State: AOJu0Yy/smW1SAbjwHi5kFoSMsDnoS3vJppA+aLxn/m8MYs3XIp8OSqV
	DMZ6FepWEatiHRk+Cciv6YfvPUCb06g7Zp79Kh78NnDUXNoVOZ9PynqdnUcpuCaRH0Y9hWoLWa/
	rXLCPnCeneMDRO16e9wbBGgUf6ECrjJUMdoFA6Q0o
X-Gm-Gg: Acq92OG4yO8M3+oC6MxTjdUnUx1TrREidthJmXfnwAFQJ9cf9U62/2gDi33iACsZsxo
	RcIYsPoswgF+q8lVN+/w2WVC6oZX3Ske5gZusyQa9Q3unbND5vRdg/ueMvBu6AW6KNqSfWNMFv8
	BGGT5GwHSIKEW+rJGxGjJCpJ3MZPhA+MFGp7ooqO0kLBgtDwePwKVAKJs/YHZrS/3nhK6wjjNWd
	Y0GpCFUeMsH9PU83xhNNxXJnp45HMxW83QEd2SMHyZsZAFs1ghNgdRByWabXJk+zMc7Hqs+buc6
	03ZD8GV0M026pGrxR443sjpTY3iNTyTQuZlOSy0ACqfyfN51
X-Received: by 2002:a05:690c:4b02:b0:7dc:f078:c7cd with SMTP id
 00721157ae682-7e05e94eab6mr115484107b3.33.1780335851140; Mon, 01 Jun 2026
 10:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531160812.68020-1-jhs@mojatatu.com>
In-Reply-To: <20260531160812.68020-1-jhs@mojatatu.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Mon, 1 Jun 2026 14:43:59 -0300
X-Gm-Features: AVHnY4JmeuwdKwo5pO9j9diNjrJn8AOUXvIbKHptYiHu918CFg_wgqC8tO64jpc
Message-ID: <CA+NMeC-BOhnSw336X8DTBa+b01Uqm03omPE4j4xtqEszO_8n0A@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net/sched: act_api: use RCU with deferred
 freeing for action lifecycle
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kylebot@openai.com, 
	jiri@resnulli.us, vladbu@nvidia.com, linux-kernel@vger.kernel.org, 
	security@kernel.org, stable@kernel.org, syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293854-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[mojatatu.com:+]
X-Rspamd-Queue-Id: E99FB623678
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 1:08=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> When NEWTFILTER and DELFILTER are run concurrently it is possible to crea=
te a
> race with an associated action.
>
> Let's illustrate with CPU0 running NEWTFILTER and CPU1 running DELFILTER:
>
>  0: mutex_lock() <-- holds the idr lock
>  0: rcu_read_lock()
>  0: p =3D idr_find(idr, index) <-- action p is valid (RCU protects IDR)
>  0: mutex_unlock() <-- releases the idr lock
>  1: refcount_dec_and_mutex_lock() <-- refcnt 1->0, mutex held
>  1: idr_remove(idr, index) <-- Action removed from IDR
>  1: mutex_unlock() <-- mutex released allowing us to delete the action
>  1: tcf_action_cleanup(p); kfree(p) <-- Kfrees p immediately, no deferral
>  0: refcount_inc_not_zero(&p->tcfa_refcnt) <-- ouch, UAF p points to free=
d memory
>
> This patch fixes the race condition between NEWTFILTER and DELFILTER by
> adding struct rcu_head to tc_action used in the deferral and introducing =
a
> call_rcu() in the delete path to defer the final kfree().
>
> Note: this is a revert of commit d7fb60b9cafb ("net_sched: get rid of tcf=
a_rcu")
> but also modernization/simplification to directly use kfree_rcu().
>
> Let's illustrate the new restored code path:
>
>  0: rcu_read_lock()
>  1: refcount_dec_and_mutex_lock() <-- refcnt 1->0, mutex held
>  1: idr_remove(idr, index)
>  1: mutex_unlock()
>  1: call_rcu(&p->tcfa_rcu, tcf_action_rcu_free) <-- defer kfree after gra=
ce period
>  0: p =3D idr_find(idr, index)
>  0: refcount_inc_not_zero(&p->tcfa_refcnt) <-- fails, refcnt already 0
>  1: rcu_read_unlock() <-- release so freeing can run after grace period
>
> After CPU1 calls idr_remove(), the object is no longer reachable through =
the IDR.
> CPU0's subsequent idr_find() will return NULL, and even if it still held =
a
> stale pointer, the immediate kfree() is now deferred until after the RCU =
grace
> period, so no UAF can occur.
>
> Fixes: d7fb60b9cafb ("net_sched: get rid of tcfa_rcu")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Tested-by: syzbot@syzkaller.appspotmail.com
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by:  Victor Nogueira <victor@mojatatu.com>

