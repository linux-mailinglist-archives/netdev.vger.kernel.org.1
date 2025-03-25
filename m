Return-Path: <netdev+bounces-177480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E7EA704C7
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834C01644B4
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556F225B691;
	Tue, 25 Mar 2025 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Reha0jyg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4E1DB13E
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915649; cv=none; b=YuYL+0Xm6DbFREtABTdMepWj+YoSs2LudwROOUUBB/mzUO3SsJMqhQGHiv2iwMsB8yXWcnmrLDIrqsVvGjJUvuSsDz16lwvLwcYi52VeYMs20OLv1NAdwpKSE580k6/xKpeM78t+AUFB7bTKWqEHKrRgLwEaV4t+sWoh2o3ahW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915649; c=relaxed/simple;
	bh=k5ErNtQX13FCN3Tf9yQJNS0K4ie9bcdITG/ea4TVexs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1Lwyo6Gu6AYT5bSwEoNb4hLL7BhPNgzeAwCVRmhIic9p2gEQ6HgpekhLAxTzh74ZBQQ9YNbcFPtCd8w8A0ohsUJXNeOTHmGEQVvobl909UzERil23l2GlYKqI9XoSf9W2OuJZcbInydPKT6fzwDNCtErFeqoFhBzIY8CsqMHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Reha0jyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0211C4CEE4;
	Tue, 25 Mar 2025 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742915648;
	bh=k5ErNtQX13FCN3Tf9yQJNS0K4ie9bcdITG/ea4TVexs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Reha0jyg2zFJTs2T9dDEC4BXt8eCUaVvSl1//n6CeS/O6WwdNZ2a1QNTf5U7jDOPh
	 cn34d/d1IRTYELBjbulL70Eavt7LM0+OEcAgqcG8rGjITXFstBsBoAyw+IL5rCm1H2
	 0Dzo4wNJ9oejObUfn2qV/sLUR7f5vIqDVf78AyHITatwy3QHuN0obYyy3HuTYnntOx
	 zGe+XYzXCduXRL6aOwjj2Opr3dA9Qls5o0hH37t/YgW22pewji/kEMiD6oW2CEpjCn
	 9uNZLMuwKt/6e6kHru9mD7nD6NmRHZ+pRnhvlKt31v8FIUAuAPXpRsXGXFhw9pwiFH
	 C0HjTqo4q9f5w==
Date: Tue, 25 Mar 2025 15:14:04 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Tom Herbert <tom@herbertland.com>
Subject: Re: [PATCH net-next] net: rfs: hash function change
Message-ID: <20250325151404.GR892515@horms.kernel.org>
References: <20250321171309.634100-1-edumazet@google.com>
 <20250324141619.GE892515@horms.kernel.org>
 <CANn89iKz2PfhP1qdSqaV5bG0YncDFW1s=5MiimUR2TYgKqpZ9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKz2PfhP1qdSqaV5bG0YncDFW1s=5MiimUR2TYgKqpZ9w@mail.gmail.com>

On Mon, Mar 24, 2025 at 03:35:39PM +0100, Eric Dumazet wrote:
> On Mon, Mar 24, 2025 at 3:16 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Fri, Mar 21, 2025 at 05:13:09PM +0000, Eric Dumazet wrote:
> > > RFS is using two kinds of hash tables.
> > >
> > > First one is controled by /proc/sys/net/core/rps_sock_flow_entries = 2^N
> > > and using the N low order bits of the l4 hash is good enough.
> > >
> > > Then each RX queue has its own hash table, controled by
> > > /sys/class/net/eth1/queues/rx-$q/rps_flow_cnt = 2^X
> > >
> > > Current hash function, using the X low order bits is suboptimal,
> > > because RSS is usually using Func(hash) = (hash % power_of_two);
> > >
> > > For example, with 32 RX queues, 6 low order bits have no entropy
> > > for a given queue.
> > >
> > > Switch this hash function to hash_32(hash, log) to increase
> > > chances to use all possible slots and reduce collisions.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Tom Herbert <tom@herbertland.com>
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
> >
> > ...
> >
> > > @@ -4903,13 +4908,13 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
> > >
> > >       rcu_read_lock();
> > >       flow_table = rcu_dereference(rxqueue->rps_flow_table);
> > > -     if (flow_table && flow_id <= flow_table->mask) {
> > > +     if (flow_table && flow_id < (1UL << flow_table->log)) {
> > >               rflow = &flow_table->flows[flow_id];
> > >               cpu = READ_ONCE(rflow->cpu);
> > >               if (READ_ONCE(rflow->filter) == filter_id && cpu < nr_cpu_ids &&
> > >                   ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_queue_head) -
> > >                          READ_ONCE(rflow->last_qtail)) <
> > > -                  (int)(10 * flow_table->mask)))
> > > +                  (int)(10 << flow_table->log)))
> >
> > I am assuming that we don't care that (10 * flow_table->mask) and
> > (10 << flow_table->log) are close but not exactly the same.
> >
> > e.g. mask = 0x3f => log = 6
> 
> Yes, I doubt we care.
> The 10 constant seems quite arbitrary anyway.
> 
> We also could keep both fields in flow_table : ->log and ->mask
> 
> I chose to remove ->mask mostly to detect all places needing scrutiny
> for the hash function change.

Thanks for the clarification. I agree that 10 seems arbitrary
and that it is nice to remove ->mask entirely.

