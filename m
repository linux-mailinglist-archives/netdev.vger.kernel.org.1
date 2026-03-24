Return-Path: <netdev+bounces-270885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN1sJ94twml5ZwQAu9opvQ
	(envelope-from <netdev+bounces-270885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:23:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDE1302CA0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84B1A3050405
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B043AC0C9;
	Tue, 24 Mar 2026 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5vBTiwh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2F3AF66B
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333017; cv=pass; b=OLqa/umPU3k9XErj68UUtgmbc4x/PsgKxuj4E7GMlhy085Uj24HJO9bzyfzPfeosDga4UOKuY/GGNQKE8l5iiy9uUyCUMv/1VVdSC+AU4i2glg6INtksFHxe2KmYr5ykM788Ae+q9nIlYGvLTz0jG08/vC1yiE1glkCWodvCOJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333017; c=relaxed/simple;
	bh=ZcbX+5mJfGFHcWFhOYfFiN8hHaXsM3DySpqgTEdyijc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IG3kCJ7KZWBCeCmcM/P+NOqqQtsHunmbBLo+1V/DzWtpP2nduC5G7enKQfpePepDaRgtvOg+m7N+mm14GgIHUdiaGuNxkqSjjOvZ4jnjktAhorPWqAXFfHKVkM9Ft6iIvgMuRf2lgJt4CIv8R67aDp318NLuZiIiLmi3uKVsK1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5vBTiwh; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so163631166b.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 23:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774333012; cv=none;
        d=google.com; s=arc-20240605;
        b=UN3Mh12mowJ0NlFTIgV0IbypXqgSb4E8kHi/+9FRNNq0FCKdXNvD7HeBh8sbAl8pkt
         UOYgAuNvpJt6mUrkU4BVdnFTN0SM5ffjhcHgG3QC6hn6Z3XtViJ8bMdDPAC7x9bmO4EJ
         o54oirjs950eILdBX5tzHzfF+EaquynNpW0w+9lTSSa1Z3FE9+SUdL8QZFe4FEuhLwO9
         8AVUXjG/Oa2mDX3YF8ZMSPv+OzUnV3tgzlHFaDNJF72F4ofoxKkFQfDrK1qdxQ/BCUMu
         Hk1ilLZEhu4+AE7qjo41n0cRTlUTKFiMCxsNorWxWJmThp/BBi1yTiXJHXJlQpwk42CK
         o85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+cvaC0YcLoRbJfn1y+y3/naIIgMA8OuvZpHsk5edtbU=;
        fh=jGyeWrHpacyHgvxAWtYGDQtiSBtmzs4hxMYUbT8a2L4=;
        b=Kv06g4XseMIAzKV1Zeu+8XaoM099d87F0YRwW65uoBYgSlBdu4J4Ohhjhl7xlGGE6I
         AG4vXlVcV1EZqXegeWqispNA4B4+v7X1SyDdroVEoWcLRuxGndeJt27IvIOM6uIwm0WO
         rTqGfL3H2t+tOFGiTs+kl0LOzp+ZUVtZ6NiTdWNgKK4g7RnhfkIwflBiloa6REZ88cVU
         c+QkQ4NskEIfn/LxzyAq3eCExEnwzG1wf1/f9Q4lQKt/yWk/kbSgaTlcnLyFmxq5ejPX
         kRTgFrDIv6m+2x88Z7MjwPXEiQZlJVtygZ0VYS+4WwGlD+YYDQklXh94kE+z5zZoSgFH
         USPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774333012; x=1774937812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cvaC0YcLoRbJfn1y+y3/naIIgMA8OuvZpHsk5edtbU=;
        b=P5vBTiwhKr/mXWFR2ceG3bY4QU5IR7t2lhSZvd4/Ht3Wyv8U3yYpE/04EAqaWYRaWY
         ZKtm7GH/YM/3dkYcK8AimAcQI3hstMd2SB6P5+1pWhT0A0cb7qmV3R6kHIyp9yj3o/6v
         Z80i6vWnW08h+tOmeHlzA1iRncoEPvBz3B9jrxkepDWMYZb6Nf6ajyejmts8rWZJqXny
         A2JIYJ/r2llAyQsk6gwDN3KPLnuDK8ZrKijR7NahAPWhA9ZEPCWKyTqIlx9WjWMYocew
         IOIcwqRYkpIXCLgc8rd/IQjNzWW01MaCpmapXLTCTRLRpuhgF9QSLDpMV02qQsWQCxrv
         j7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774333012; x=1774937812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cvaC0YcLoRbJfn1y+y3/naIIgMA8OuvZpHsk5edtbU=;
        b=HCfwNl4BiLhDEbks9sQM/IHtUoryqCq4K7MMnmaSfcAnB9hP6wqOCtUX4thmy/nFty
         1tKNJGogTg7tKac3XuJk/vaePBg04++6CKly/5NAfImh6q5qa08FNKgeaENQ0GFVTnDJ
         qKxkbghnaguBaQyuZ19g14bQFMEFY1YU0u1jVSxhsFNMuDFQ9NLKnlfSZMAMBml6sIr0
         0Q8I5EmpDlO1YQ8FoXQqec4viK1LvKjxqdgpUsd+Zz16bDxWYmaLXw1RIAhyYk35Cujr
         HGjRPcu04fZ9a7/g6K31yRH1ydQJS8BSWtVWz5J6d0oSTtVbMgqB5TQwqH9KGuUM6lHE
         hlxg==
X-Gm-Message-State: AOJu0YydVSZB7tv4Dzn0mL0CBjFkHfzXYxDYZwKiZhaKINXzNDwWVVlP
	upN7l3/ETMCF8lRCARL7kcgWJk9RLPkpVD8zl0flTf2URQz+WPUITwPKMgQ5Mu193q/CPZ35fdd
	nNAsx27ImRATB+l9HTqv7RRUIdVPHmrM=
X-Gm-Gg: ATEYQzz25p3SblGaDrsF09Tfv2pNaBuSwu9RCtiTuGDkr0IzAmNnA69dylXztZ7C07R
	q1YGQ/73Ho13ZgJq8xHZHA+qXkdiggn2Dt4JTma/vhJY/rrxIMxcTq+CilB+Q/e7ldBv9L5jIxb
	mdMVPPdbQ0EiN7+pxz1BhXFOfS6nXW8NU6/FNcf2MdfU6xe2blXNZ3Y/rfEn4KvLWe8y7us7WGc
	A8wxza4eBuXiP55Yst3NkEVyFBLTL03phEGdn3YeToNoNag6mm7rxyHAbbbMnlwk68GNDDCJged
	LohGh7M=
X-Received: by 2002:a17:907:da7:b0:b98:4c2a:d503 with SMTP id
 a640c23a62f3a-b984c2ada90mr763599666b.38.1774333011445; Mon, 23 Mar 2026
 23:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321035439.900644-1-LivelyCarpet87@gmail.com> <20260323144535.GB85922@horms.kernel.org>
In-Reply-To: <20260323144535.GB85922@horms.kernel.org>
From: Tyllis Xu <livelycarpet87@gmail.com>
Date: Tue, 24 Mar 2026 01:16:39 -0500
X-Gm-Features: AQROBzBBCv2w0ZOtVdMmuKvgHj7C9SgIeMjOabKYcsILKAH01H0D6sFogiiH00U
Message-ID: <CAJsYhQJm4mW1FHu2d=Pf8PfFyBWZA43QHpQ2esc0Cfuqqehh4w@mail.gmail.com>
Subject: Re: [PATCH] ibmvnic: fix OOB array access in ibmvnic_xmit on queue
 count reduction
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@linux.ibm.com, 
	nnac123@linux.ibm.com, sukadev@linux.ibm.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	danisjiang@gmail.com, ychen@northwestern.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270885-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,northwestern.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[livelycarpet87@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FDE1302CA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'll try out the suggested changes and use more
of the existing handling to create a new patch.
I'll also remove the unlikely(). Thank you for
your feedback!


On Mon, Mar 23, 2026 at 9:45=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Mar 20, 2026 at 10:54:39PM -0500, Tyllis Xu wrote:
> > When the number of TX queues is reduced (e.g., via ethtool -L), the
> > Qdisc layer retains previously enqueued skbs with queue mappings from
> > before the reduction. After the reset completes and tx_queues_active is
> > set to true, netif_tx_start_all_queues() drains these stale skbs throug=
h
> > ibmvnic_xmit(). The queue index from skb_get_queue_mapping() may exceed
> > the newly allocated array bounds, causing out-of-bounds reads on
> > tx_scrq[] and tx_pool[]/tso_pool[], and out-of-bounds writes on
> > tx_stats_buffers[] in the function's exit path.
> >
> > The existing tx_queues_active guard does not help here: it is set to
> > true by __ibmvnic_open() before netif_tx_start_all_queues() restarts
> > queue draining, so stale skbs pass the check with an invalid queue inde=
x.
> >
> > Add a bounds check against num_active_tx_scrqs immediately after the
> > tx_queues_active guard. Use a dedicated out_unlock label to skip the
> > per-queue stats updates (which also index tx_stats_buffers[queue_num])
> > when the queue index is invalid.
> >
> > Fixes: 4219196d1f66 ("ibmvnic: fix race between xmit and reset")
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
> > ---
> >  drivers/net/ethernet/ibm/ibmvnic.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/=
ibm/ibmvnic.c
> > index 5a510eed335e..c939391474cb 100644
> > --- a/drivers/net/ethernet/ibm/ibmvnic.c
> > +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> > @@ -2453,6 +2453,11 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *=
skb, struct net_device *netdev)
> >               goto out;
> >       }
> >
> > +     if (unlikely(queue_num >=3D adapter->num_active_tx_scrqs)) {
> > +             dev_kfree_skb_any(skb);
> > +             goto out_unlock;
> > +     }
> > +
>
> This doesn't seem quite right. Shouldn't it be as per other
> blocks in this function that drop packets. In which case
> it could re-use the existing handling in the conditional immediately abov=
e
> this hunk.
>
> Also, I don't think unlikely() seems in keeping with the existing
> implementation of this function.
>
> I'm suggesting something like (completely untested):
>
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ib=
m/ibmvnic.c
> index 5a510eed335e..67e1e62631e3 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -2457,7 +2457,8 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb=
, struct net_device *netdev)
>         txq =3D netdev_get_tx_queue(netdev, queue_num);
>         ind_bufp =3D &tx_scrq->ind_buf;
>
> -       if (ibmvnic_xmit_workarounds(skb, netdev)) {
> +       if (ibmvnic_xmit_workarounds(skb, netdev) ||
> +           queue_num >=3D adapter->num_active_tx_scrqs) {
>                 tx_dropped++;
>                 tx_send_failed++;
>                 ret =3D NETDEV_TX_OK;
>
> Where the next line is:
>
>                 goto out;
>
> ...
>
> > @@ -2672,6 +2677,9 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *s=
kb, struct net_device *netdev)
> >       adapter->tx_stats_buffers[queue_num].bytes +=3D tx_bytes;
> >       adapter->tx_stats_buffers[queue_num].dropped_packets +=3D tx_drop=
ped;
> >
> > +     return ret;
> > +out_unlock:
> > +     rcu_read_unlock();
> >       return ret;
> >  }
>
> My previous comment not, withstanding:
>
> The RCU read side critical section is already enormous.
> So perhaps making it slightly better doesn't make a difference.
>
> If so, can we go for this slightly flow here (completely untested).
>
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ib=
m/ibmvnic.c
> index 5a510eed335e..1e1cd8c11cf9 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -2664,14 +2664,14 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *s=
kb, struct net_device *netdev)
>                 netif_carrier_off(netdev);
>         }
>  out:
> -       rcu_read_unlock();
>         adapter->tx_send_failed +=3D tx_send_failed;
>         adapter->tx_map_failed +=3D tx_map_failed;
>         adapter->tx_stats_buffers[queue_num].batched_packets +=3D tx_bpac=
kets;
>         adapter->tx_stats_buffers[queue_num].direct_packets +=3D tx_dpack=
ets;
>         adapter->tx_stats_buffers[queue_num].bytes +=3D tx_bytes;
>         adapter->tx_stats_buffers[queue_num].dropped_packets +=3D tx_drop=
ped;
> -
> +out_unlock:
> +       rcu_read_unlock();
>         return ret;
>  }
>
>
> --
> pw-bot: changes-requested

