Return-Path: <netdev+bounces-271974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C1ZFW4XxWnr6QQAu9opvQ
	(envelope-from <netdev+bounces-271974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:24:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C601E334696
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC72E3019FD6
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447973B9D81;
	Thu, 26 Mar 2026 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHLbme8M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6613BED76
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520985; cv=none; b=IpabSbidpVU3RvCbRUpI6qg+JtLnDX3TEmmocuKZsFu/R6z/3VKS92g+6yOd/m5/60ldUgHOhtEAu8VXpWJmOvI7OruL2dybu6nsAl9jyq1nNmAe0/CJkak2TRsS8zuPECRO/NNXG/0gyCz3NesSJSBLExxNs3Czxzj0lQOXAWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520985; c=relaxed/simple;
	bh=8SKg7BvNiL1KeoQwQkb8pHj0zB+UNl/CmtV0dzZHdZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWxdgcGrqdpINcKASVuSgeOe2QaiDwCxotmVNYfy1ESByxsEgWxKZ02hnZ8qS9kvAqHp02JHcO4BWx8fM7c0Gz6MBdjQt1sbAhb7hJrwuYURfy5LvzErwONaRjbmbz2doaXi/m+2WxU0VXOvZwHRE01V4jtnLGMCoulvDcueckA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHLbme8M; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82c20b9f989so424944b3a.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774520983; x=1775125783; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y7m4Xbu3vvqKNImY1R5GWOYnls5yRibXnGhjHy174Ps=;
        b=QHLbme8MspoZrg5YLvK8BCIc/qD9pZ1ThOvl8ogt7BDi2hlb+fDgV8mKTgHt+r0jyQ
         lMeZ0gv2FNSUltPjnOSio0Zu9zAxZ/E8+qItnxNbwjs7PDXjYopDdezBtYFpBXkU5w+a
         taZqudg+dwAe4avw2YB8gt8gt5YDlVjNE9K9gavFzg1/g8Yz67g/JHByOaYmFpQLYnk7
         vGk5LJM8cDpiV3o24ikUnK5x3IsJiHBkGFi2SLVpBfszeRNwk+0zE06iAaHznd40yKoH
         dAj+uFexqr5khySr3UarksE2NpNEROJtyGhOaFuKUwVuJ6n5ohHI8ZXprxbEG15oLdwG
         kHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774520983; x=1775125783;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7m4Xbu3vvqKNImY1R5GWOYnls5yRibXnGhjHy174Ps=;
        b=r9K5vZor15uDBpSfDzEoVeGxTbgBiLRcw8jF7SjUQWcKgwmfagNpsI3fYrESuCjw/W
         vq1IX55v0B7GbcetEZRrchllEouz/64t5lFq3IA77PM8LuanFIZ2yILpZMOYZWECWZt1
         ubhf9HI1pqM3n/dcvjH6LWQbH08m3FcWg1GMyfRmjJbgFoCCZBhC5HLulRzaxs5PTxHP
         d3piuiHnd//LLzpfP/KR4XWEbmToRw+rcEWCX+WpGmZtnsP6uLOpqG5kAiy6buiKlMJY
         U9+c4Igu4Z9ERFxWXdArfiBx+pXvQuF5GXr76sn1JcECc9P6NdACZSJHyQwAjM7OWO9m
         4hbA==
X-Gm-Message-State: AOJu0Yzqtvyj7GGF8JQ1Zse3KN+6LM2CEEi1nPATVXrVRneWiPIluUHb
	yF6a0i5zWpoFQlnn+bB/jlFqXnJ4zwr3AMDC3or0La9xEJl8ixVX5nWt+FJFKY3g
X-Gm-Gg: ATEYQzyeOJhMQy/Pfwoh9xdNb8AxVHZa8M1Ga3Q1/v5eIJkBWTqKchjtbXkwB6MYeSH
	8GEq+eRucBq/Xm4ysZbbmAgTfIqGXmBmWJHhoyOP8691dzebRj9ok30SA3Dymcl1A3XFQiw6rsz
	PvRUn0DaxCfXEENri3ZLK65MOqq8um2TDWr2H4ylg/9wlZ+RuEOpUG1cDxsGoRSFAMdIGaencnF
	zJ+4PryrUY2fGLbGNauwQj8eGdW+b9vaVTpBXWyV762XItd9aPhuHp82s57GLeLkEck1TyzjrlH
	uXCKuiIAR8PnLfoMfbEMJGqpweKzm/hIW40WqG//xeiNzqrU9UnjJJq7hEe5AFIL6QGuDYLD3ZH
	aQ7Q4PZeTi6KJZ4S8tQ5H+WgXwg/W7C0O8E/osqzG2GLaaBDgr606Ad3yB2yRhmDpMk4U5h5RHB
	eRp9yuue+pzplCZE3a
X-Received: by 2002:a05:6a00:a20f:b0:81e:f1c3:89d5 with SMTP id d2e1a72fcca58-82c6def3ef0mr7027759b3a.26.1774520982820;
        Thu, 26 Mar 2026 03:29:42 -0700 (PDT)
Received: from mingi ([175.125.103.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3ff085sm2184993b3a.57.2026.03.26.03.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 03:29:42 -0700 (PDT)
Date: Thu, 26 Mar 2026 03:29:38 -0700
From: Mingi Cho <mgcho.minic@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com
Subject: Re: [RFC Patch net-next 0/2] net_sched: Move GSO segmentation to
 root qdisc
Message-ID: <20260326102938.GA73145@mingi>
References: <20250701232915.377351-1-xiyou.wangcong@gmail.com>
 <20260312165757.GA3411905@mingi>
 <CAM0EoM=v6AuzmR+s4OAiKa3jXp_Hb+qgp_gh7FeeGrvMiztiQQ@mail.gmail.com>
 <20260313133810.GA3431035@mingi>
 <CAM0EoMmKnARRQxNNaEKO5Vg5vZBUgUmsximAgGfA9W-MO2iFJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmKnARRQxNNaEKO5Vg5vZBUgUmsximAgGfA9W-MO2iFJw@mail.gmail.com>
X-Spamd-Result: default: False [12.84 / 15.00];
	MW_SURBL_MULTI(7.50)[test:email];
	ABUSE_SURBL(5.00)[test:email];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	TAGGED_FROM(0.00)[bounces-271974-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	CRACKED_SURBL(0.00)[test:email];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_FROM(0.00)[gmail.com];
	CT_SURBL(0.00)[test:email];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	DM_SURBL(0.00)[test:email];
	PH_SURBL_MULTI(0.00)[test:email];
	FROM_NEQ_ENVFROM(0.00)[mgchominic@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	NEURAL_HAM(-0.00)[-0.983];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,test:email]
X-Rspamd-Queue-Id: C601E334696
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Hi,

On Fri, Mar 13, 2026 at 03:23:42PM -0400, Jamal Hadi Salim wrote:
> Hi,
> 
> On Fri, Mar 13, 2026 at 9:38 AM Mingi Cho <mgcho.minic@gmail.com> wrote:
> >
> > On Thu, Mar 12, 2026 at 04:21:07PM -0400, Jamal Hadi Salim wrote:
> > > On Thu, Mar 12, 2026 at 12:58 PM Mingi Cho <mgcho.minic@gmail.com> wrote:
> > > >
> > > > On Tue, Jul 01, 2025 at 04:29:13PM -0700, Cong Wang wrote:
> > > > > This patchset attempts to move the GSO segmentation in Qdisc layer from
> > > > > child qdisc up to root qdisc. It fixes the complex handling of GSO
> > > > > segmentation logic and unifies the code in a generic way. The end result
> > > > > is cleaner (see the patch stat) and hopefully keeps the original logic
> > > > > of handling GSO.
> > > > >
> > > > > This is an architectural change, hence I am sending it as an RFC. Please
> > > > > check each patch description for more details. Also note that although
> > > > > this patchset alone could fix the UAF reported by Mingi, the original
> > > > > UAF can also be fixed by Lion's patch [1], so this patchset is just an
> > > > > improvement for handling GSO segmentation.
> > > > >
> > > > > TODO: Add some selftests.
> > > > >
> > > > > 1. https://lore.kernel.org/netdev/d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com/
> > > > >
> > > > > ---
> > > > > Cong Wang (2):
> > > > >   net_sched: Move GSO segmentation to root qdisc
> > > > >   net_sched: Propagate per-qdisc max_segment_size for GSO segmentation
> > > > >
> > > > >  include/net/sch_generic.h |  4 +-
> > > > >  net/core/dev.c            | 52 +++++++++++++++++++---
> > > > >  net/sched/sch_api.c       | 14 ++++++
> > > > >  net/sched/sch_cake.c      | 93 +++++++++++++--------------------------
> > > > >  net/sched/sch_netem.c     | 32 +-------------
> > > > >  net/sched/sch_taprio.c    | 76 +++++++-------------------------
> > > > >  net/sched/sch_tbf.c       | 59 +++++--------------------
> > > > >  7 files changed, 123 insertions(+), 207 deletions(-)
> > > > >
> > > > > --
> > > > > 2.34.1
> > > > >
> > > >
> > > > Hi Cong,
> > > >
> > > > I tested the proposed patch and found that the reported bug was fixed. A qlen mismatch between Qdiscs can potentially cause UAF, so I believe this patch needs to be applied.
> > > >
> > > > When executing the PoC on the latest kernel without the patch applied, a warning message occurs in drr_dequeue() as shown below.
> > > >
> > > > Before applying the patch:
> > > >
> > > > root@test:~# ./poc
> > > > qdisc drr 1: dev lo root refcnt 2
> > > > qdisc tbf 2: dev lo parent 1:1 rate 1Mbit burst 1514b lat 50.0ms
> > > > qdisc choke 3: dev lo parent 2:1 limit 2p min 1p max 2p
> > > > [    7.588847] drr_dequeue: tbf qdisc 2: is non-work-conserving?
> > > >
> > > > Testing after applying the patch to the v6.17 kernel shows that the warning message has disappeared.
> > > >
> > > > After applying the patch:
> > > >
> > > > root@test:~# ./poc
> > > > qdisc drr 1: dev lo root refcnt 2
> > > > qdisc tbf 2: dev lo parent 1:1 rate 1Mbit burst 1514b lat 50.0ms
> > > > qdisc choke 3: dev lo parent 2:1 limit 2p min 1p max 2p
> > >
> > > Please test against latest net-next kernel then report back on the UAF
> > > - not a "potential" but a real one.
> > >
> > > cheers,
> > > jamal
> >
> > As seen in a recent patch (https://lore.kernel.org/netdev/20260114160243.913069-3-jhs@mojatatu.com/), it was possible to trigger a UAF using the QFQ qdisc when qlen was handled incorrectly. I don't think this is the only way to trigger a UAF. Since it is obvious that qlen is also being handled incorrectly during the GSO segment processing, I believe it would be better to remove this potential risk.
> >
> 
> I may not be remembering the sequence of events correctly, and i am
> not sure if after all this time if that potential UAF hasnt been
> resolved. Your repro was fixed by:
> https://lore.kernel.org/netdev/d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com/
> 
> Typically, a message like "is non-work-conserving?" means you have
> some bogus hierarchy. Find a way to create what you suggested is a
> potential UAF, and I will be more than happy to invest time.
> 
> cheers,
> jamal

I don't see any points in the current version of kernel that could lead to a
UAF, and I don't have time to analyze it further. A detailed analysis of this
bug is provided below.

static int tbf_segment(struct sk_buff *skb, struct Qdisc *sch,
               struct sk_buff **to_free)
{
    struct tbf_sched_data *q = qdisc_priv(sch);
    struct sk_buff *segs, *nskb;
    netdev_features_t features = netif_skb_features(skb);
    unsigned int len = 0, prev_len = qdisc_pkt_len(skb), seg_len;
    int ret, nb;

    segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);

    if (IS_ERR_OR_NULL(segs))
        return qdisc_drop(skb, sch, to_free);

    nb = 0;
    skb_list_walk_safe(segs, segs, nskb) {
        skb_mark_not_on_list(segs);
        seg_len = segs->len;
        qdisc_skb_cb(segs)->pkt_len = seg_len;
        qdisc_skb_cb(segs)->pkt_segs = 1;
        ret = qdisc_enqueue(segs, q->qdisc, to_free);   // [1]
        if (ret != NET_XMIT_SUCCESS) {
            if (net_xmit_drop_count(ret))
                qdisc_qstats_drop(sch);
        } else {
            nb++;
            len += seg_len;
        }
    }
    ...
}

When a GSO packet is enqueued into the TBF, it is processed by the tbf_segment.
GSO packets are split into GSO segments and then enqueued into the child qdiscs
of the TBF [1]. A problem occurs when the child qdisc of TBF enqueues one or
more GSO segments and returns a success, but then drops all packets from the
child qdisc while enqueuing another GSO segment.

The following shows the changes in the qlen values of each qdisc as the GSO
segment is processed when the provided PoC is executed. A total of four
segments are processed, and we can see that a mismatch in the qlen values
occurs between the parent and child segments.

       DRR    TBF    CHOKE
seg1    0      0       1
seg2    0      0       2
seg3   -1     -1       1
seg4   -2     -2       0

When seg3 is enqueued into CHOKE, the average queue length exceeds qth_min,
entering the probabilistic drop region. Since all GSO segments originate from
the same UDP socket, choke_match_random() matches seg3 against an existing
packet (seg1) in the queue. choke_drop_by_idx() then drops seg1, which calls
qdisc_tree_reduce_backlog() — decrementing both TBF and DRR qlens by 1. The
incoming seg3 is also dropped via congestion_drop. The same occurs for seg4,
which matches and drops seg2.

static int tbf_segment(struct sk_buff *skb, struct Qdisc *sch,
               struct sk_buff **to_free)
{
    ...

    sch->q.qlen += nb;                  // TBF: qlen = -2 + 2 = 0 
    sch->qstats.backlog += len;         
    if (nb > 0) {
        qdisc_tree_reduce_backlog(sch, 1 - nb, prev_len - len);
                                        // DRR: qlen = -2 - (1-2) = -1
        consume_skb(skb);
        return NET_XMIT_SUCCESS;        // [2]
    }

    kfree_skb(skb);
    return NET_XMIT_DROP;
}

As a result of the GSO processing, tbf_segment returns NET_XMIT_SUCCESS even
though qlen is 0 [2].

static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
               struct sk_buff **to_free)
{
    ...

    err = qdisc_enqueue(skb, cl->qdisc, to_free);
    if (unlikely(err != NET_XMIT_SUCCESS)) {
        if (net_xmit_drop_count(err)) {
            cl->qstats.drops++;
            qdisc_qstats_drop(sch);
        }
        return err;
    }

    if (!cl_is_active(cl)) {
        list_add_tail(&cl->alist, &q->active);  // [3] cl->qdisc->q.qlen = 0,
        cl->deficit = cl->quantum;               //     DRR: qlen = -1 
    }

    sch->qstats.backlog += len;
    sch->q.qlen++;      // DRR: qlen -1 -> 0, no actual packets exist 
    return err;
}

Since the TBF qdisc returned NET_XMIT_SUCCESS, drr_enqueue adds the class to
the active list even though cl->qdisc.qlen is 0. This is nonsensical because
the class is added to the active list even though it is not active.

static struct sk_buff *drr_dequeue(struct Qdisc *sch)
{
    struct drr_sched *q = qdisc_priv(sch);
    struct drr_class *cl;
    struct sk_buff *skb;
    unsigned int len;

    if (list_empty(&q->active))
        goto out;
    while (1) {
        cl = list_first_entry(&q->active, struct drr_class, alist);     // [4]
        skb = cl->qdisc->ops->peek(cl->qdisc);      // cl->qdisc.qlen = 0
        if (skb == NULL) {
            qdisc_warn_nonwc(__func__, cl->qdisc);
            goto out;
        }

    ...
}

Finally, in `drr_dequeue`, attempting to peek into an empty qdisc triggers a
warning message and causes unnecessary code to execute [4].

Recently, there have been many cases where incorrect handling of the qlen
value caused not only UAFs but also kernel panics; however, thanks to various
patches, it appears that even if qlen is handled incorrectly, issues such as
panics no longer occur. Nevertheless, the bug clearly exists, so I am wondering
if there are plans to patch it.

Thanks,
Mingi


