Return-Path: <netdev+bounces-273265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LIsGmykymmx+gUAu9opvQ
	(envelope-from <netdev+bounces-273265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:27:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B40C35EC23
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB32A302140B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE973603FB;
	Mon, 30 Mar 2026 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezXjleGN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4A7372EE1
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774887803; cv=none; b=nbvOmRXCzjH+u/Xt1cD+pZqYkUHhStSrbNsVzg6TrQRbo0y3PvWMeodT3GPOC9gaWkUR8e46W033lCawaAPe5PcV36/kIXOmgSZpcvYqLFoYHAkfFP2CN5AXuWbHGcF5BvPqRuoZnl8WXcKG8/znlT01Pxjbkt8RgPmj4pMFd5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774887803; c=relaxed/simple;
	bh=XMqIP9bl8qOmjtIwA5oVCuCgVYqKXdpZ8xq8ZPsSjvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1XjGGYHeLxxzDcg9FNGrG/iS5qJmpA7DP7UlFmv/NDIZ2BKrNYQkwrN3R8h9TSBa//m6zn5ekDh1Herq8jsKB9quymFCHE3pG4EfL+VVNL/BGqB0+ztCpmXQych9iTR+KweBYgudddRYFdmNfk4CGkx+hXV8Z3WgCS1ZZMncR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezXjleGN; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d9749c26dso1614657a91.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774887802; x=1775492602; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DHifDfI/rQ1eajM97PvNN3DJXglkdLkXQgSSv9YETF8=;
        b=ezXjleGNCKK5L7Vn/OqVqGMmmE6YIBAUWCn7VdPjPyseoyW1nZVfiniWhBNCXl7on8
         gW1XQBPxlDh3ecTX3Cqcha/6dPkplHT+927LaFaBMUGbTXi7Pb68aW75VBXf0wFnMIgo
         7uJkXEHavYwHl+DyemxvoT1N8LAFdY725hHFqRtXky5HZCBxgI/mIWAfeqlt6zqhU1MI
         tXS2w4CnZUZkNKCeJYum3Gk5+qpatqMgea1I2FCmfffGgFURz5BOBM//8Jjuav1PMPdW
         HuFWrG3KDEXF+f03pmmypyyjrVJhV18vEE5/QQCi3HZsC8WMSbtExeQabYXGiXHN421R
         lh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774887802; x=1775492602;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHifDfI/rQ1eajM97PvNN3DJXglkdLkXQgSSv9YETF8=;
        b=BYBPgKJ9E5q/NU6M8XC+SJ1lumw8++T2/OXgFKlIHStDyL/0xYaRKI9dD0mnL8LAS3
         zTnzytIdc1LCpYZEnbA+7aGWiXNC8JFqAt2G9kFGGPMBY7fcZY2ffhBEP3ee4BenkfbF
         gUwDMR5uiPoHUozq70tRFRFS7JrR+8yZwWO7J6oVBhdP+iXqJh5X1HGh4LmMGl4o5xTs
         BIMq1CrtDTUZJwgb1IUyByYAiiUpjOMb76bLUmz/8e0Sx6E1HSc1l2e3M53axJlYSS2M
         MFlRMwutUDiTvw+SMEnX7zxhsrWSqOLf/ipeqer0SY4Tj4cIbO9XiF95e3kvVcy+Jciq
         QWUw==
X-Forwarded-Encrypted: i=1; AJvYcCVkSweZK0zM+7WP72psMSyLrlC0TRIelr/i8bO00OD37Hn3qEzMFWsot9cFUlrYak6with7QfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJtJuM1wnFVTdXIn3ymLyhXvXYJuwjTpPVh25o+yZ1kufrxXZ
	jyuDuwOCdzHX6ykX44Ddrfh5sfo/YZTKA/sqyPUVIldBhhw+IK0xZBJk
X-Gm-Gg: ATEYQzxdDCFzu+PrU2ZeegExebYfPMwylN5cYEk7+ZbK+wEVGAsTnXMw9hu4ev3REqq
	lU/8cHPOBRrCwVdm+MB751W+WAbnVrDRgvpnv1bdnzvNObsUt8xxVmNhwgzwaQp7/t1f/lDE0hC
	l4A0LhM9JtxwVF5eRu7Ga/cMbbLC9n9XLSNBe1R0QnQ7bO6buruU0bATkIW9K0msXfFWwmL00kU
	YtDzXZnoeE+HW5lvS6VyABMm+7Ze3D8LXLBoYHkRIgbO0at4ZgSdlRsr2slD4k2p43JJ6xRcX0Z
	FC9kX5IPRUx9eyizV63FuE0fZ+wb+QDk3NJ4oQaYmIbQi16AhOKoQ9oyGcu+7Rnunt595WsCYf1
	MjOCqY6OMpUt3bEIqfiYUnDaPUrEKjnbPxc9bql+9e5cTRfC2OoefHnXzZ7LsJOTJVzmDdk0iwr
	BpYY5Y8+PcRRrP8YP8TG2LTKI0Ql46SRYrSW0bCpnbV132xJTm0zbbNRJPrwfRTtRU0NRDvRg=
X-Received: by 2002:a17:90b:164a:b0:35b:8d89:7199 with SMTP id 98e67ed59e1d1-35c2ffb5174mr11386080a91.15.1774887801634;
        Mon, 30 Mar 2026 09:23:21 -0700 (PDT)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c2db8036dsm4711946a91.6.2026.03.30.09.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 09:23:21 -0700 (PDT)
Date: Tue, 31 Mar 2026 00:23:16 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kyernel.org>, netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net] net/sched: taprio: fix NULL pointer dereference in
 class dump
Message-ID: <acqjdNynzuzH6Egr@SLSGDTSWING002>
References: <20260330102904.2677818-5-bestswngs@gmail.com>
 <CAM0EoMkFVKfcQ=PN1J_4JL3Cvqiz2Zfaismp79hGiYouD+yZ7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkFVKfcQ=PN1J_4JL3Cvqiz2Zfaismp79hGiYouD+yZ7w@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273265-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: 1B40C35EC23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-03-30 12:04, Jamal Hadi Salim wrote:
> On Mon, Mar 30, 2026 at 6:43 AM Weiming Shi <bestswngs@gmail.com> wrote:
> >
> > When a TAPRIO child qdisc is deleted via RTM_DELQDISC, taprio_graft()
> > is called with new == NULL and stores NULL into q->qdiscs[cl - 1].
> > Subsequent RTM_GETTCLASS dump operations walk all classes via
> > taprio_walk() and call taprio_dump_class(), which calls taprio_leaf()
> > returning the NULL pointer, then dereferences it to read child->handle,
> > causing a kernel NULL pointer dereference.
> >
> > The bug is reachable with namespace-scoped CAP_NET_ADMIN on any kernel
> > with CONFIG_NET_SCH_TAPRIO enabled. On systems with unprivileged user
> > namespaces enabled, an unprivileged local user can trigger a kernel
> > panic by creating a taprio qdisc inside a new network namespace,
> > grafting an explicit child qdisc, deleting it, and requesting a class
> > dump. The RTM_GETTCLASS dump itself requires no capability.
> >
> >  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
> >  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
> >  RIP: 0010:taprio_dump_class (net/sched/sch_taprio.c:2475)
> >  Call Trace:
> >   <TASK>
> >   tc_fill_tclass (net/sched/sch_api.c:1966)
> >   qdisc_class_dump (net/sched/sch_api.c:2329)
> >   taprio_walk (net/sched/sch_taprio.c:2510)
> >   tc_dump_tclass_qdisc (net/sched/sch_api.c:2353)
> >   tc_dump_tclass_root (net/sched/sch_api.c:2370)
> >   tc_dump_tclass (net/sched/sch_api.c:2431)
> >   rtnl_dumpit (net/core/rtnetlink.c:6827)
> >   netlink_dump (net/netlink/af_netlink.c:2325)
> >   rtnetlink_rcv_msg (net/core/rtnetlink.c:6927)
> >   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
> >   </TASK>
> >
> > Fix this by substituting &noop_qdisc when new is NULL in
> > taprio_graft(), following the same pattern used by multiq_graft() and
> > prio_graft(). This ensures q->qdiscs[] slots are never NULL, making
> > all consumer paths (dump, enqueue, dequeue) safe. The noop_qdisc is a
> > kernel-global builtin qdisc that drops all packets, which is
> > functionally equivalent to a NULL child for data path purposes. The
> > refcount increment and flag modification are guarded with
> > != &noop_qdisc to avoid modifying the global singleton.
> >
> > Fixes: 665338b2a7a0 ("net/sched: taprio: dump class stats for the actual q->qdiscs[]")
> > Cc: stable@vger.kernel.org
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> 
> You forgot to Cc the author of the commit (Vladimir) now on Cc.
> I have also removed @stable from the list; it is not your
> responsibility to decide what goes to stable, lets leave that to the
> netdev maintainers.
> 
> cheers,
> jamal
Hi Jamal,

Thanks for the review and for adding Vladimir to Cc. Noted on
the stable Cc — will keep that in mind for future submissions.

Weiming Shi
> 
> > ---
> >  net/sched/sch_taprio.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > index f721c03514f60..cecaef16c0dd1 100644
> > --- a/net/sched/sch_taprio.c
> > +++ b/net/sched/sch_taprio.c
> > @@ -2183,6 +2183,9 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
> >         if (!dev_queue)
> >                 return -EINVAL;
> >
> > +       if (!new)
> > +               new = &noop_qdisc;
> > +
> >         if (dev->flags & IFF_UP)
> >                 dev_deactivate(dev);
> >
> > @@ -2196,14 +2199,14 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
> >         *old = q->qdiscs[cl - 1];
> >         if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
> >                 WARN_ON_ONCE(dev_graft_qdisc(dev_queue, new) != *old);
> > -               if (new)
> > +               if (new != &noop_qdisc)
> >                         qdisc_refcount_inc(new);
> >                 if (*old)
> >                         qdisc_put(*old);
> >         }
> >
> >         q->qdiscs[cl - 1] = new;
> > -       if (new)
> > +       if (new != &noop_qdisc)
> >                 new->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
> >
> >         if (dev->flags & IFF_UP)
> > --
> > 2.43.0
> >

