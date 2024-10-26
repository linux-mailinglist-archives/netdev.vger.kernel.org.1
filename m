Return-Path: <netdev+bounces-139342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB019B18F2
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 17:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D896D1C20D2B
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F287E224CC;
	Sat, 26 Oct 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bo63wzwn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C696122075;
	Sat, 26 Oct 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729955225; cv=none; b=dB5Mgby0q6RoFqXnYi0rRfcNRzRccLu9tzCR5seS1UHV6FOW16QHtaRAi7H9dRLhwue7LBkDtC6HAmp0YvQG4soJSmdIFNM/aoNHnLlYngFUksRrk30WKGeFgyD3bdHWYs1ffPZA8MxShJjkXN8sEtfylbOSuv9wJaIofOaL7YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729955225; c=relaxed/simple;
	bh=nyrEPnPVL6CfiOximMToOwsXo5hX9hDKi37RpbH3KDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S76fiuD17Vy18g/0FBCGYOUKK26La4HaNjoi9Jc4SngMHlDqHS9yxc1YVebUtqltehYUBh9fSauRYy3v0YZMfjVz8JXL0qOQGzVlKkOQutCZxIGGeE9sfeAp3F2MV5L/wukqd8SNHU5ChhnEodi/E3PzJXhgS/qoZJNhDR4v8Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bo63wzwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8BEC4CEC6;
	Sat, 26 Oct 2024 15:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729955225;
	bh=nyrEPnPVL6CfiOximMToOwsXo5hX9hDKi37RpbH3KDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bo63wzwn4LbzEfNYwEJKtpL/2DlkYa9XTRF9HYO32eIMsd879HBZ3n7oyvJJam347
	 hc1cfPOK+FmOUk88Pcs+RTXwLFTi8hB2tdUewbI6QVGYFWugr8e9lsDf+voB27VlK/
	 2kZyT2Ue+khHEDfdL7L2oKl+ZIpZLwHtxiM0LC6PvUOA06pi/blWSlD1lvO5rspohf
	 ZPqDVBNrcB5p4bNf8pIwTQAXItXhWp15oBTIXbdv7Zg66vOwhNRAYX3R2ocixb5s5r
	 1znwOcMjeeufsfWcnbyYWjwLeue4+yIZxxtPzFHPlWLfCY+MXhQsCQkdrVccG/ZhdH
	 DAWEuI8VF+kQA==
Date: Sat, 26 Oct 2024 16:07:00 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH net-next] net: freescale: use ethtool string helpers
Message-ID: <20241026150700.GF1507976@kernel.org>
References: <20241024205257.574836-1-rosenp@gmail.com>
 <20241025125704.GT1202098@kernel.org>
 <CAKxU2N98hnVAE9WF72HhxzVEfhnRAgMykVgBErL9b3gupqqrxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N98hnVAE9WF72HhxzVEfhnRAgMykVgBErL9b3gupqqrxQ@mail.gmail.com>

On Fri, Oct 25, 2024 at 12:32:27PM -0700, Rosen Penev wrote:
> On Fri, Oct 25, 2024 at 5:57 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Thu, Oct 24, 2024 at 01:52:57PM -0700, Rosen Penev wrote:
> > > The latter is the preferred way to copy ethtool strings.
> > >
> > > Avoids manually incrementing the pointer. Cleans up the code quite well.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >
> > ...
> >
> > > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> > > index b0060cf96090..10c5fa4d23d2 100644
> > > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> > > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
> > > @@ -243,38 +243,24 @@ static void dpaa_get_ethtool_stats(struct net_device *net_dev,
> > >  static void dpaa_get_strings(struct net_device *net_dev, u32 stringset,
> > >                            u8 *data)
> > >  {
> > > -     unsigned int i, j, num_cpus, size;
> > > -     char string_cpu[ETH_GSTRING_LEN];
> > > -     u8 *strings;
> > > +     unsigned int i, j, num_cpus;
> > >
> > > -     memset(string_cpu, 0, sizeof(string_cpu));
> > > -     strings   = data;
> > > -     num_cpus  = num_online_cpus();
> > > -     size      = DPAA_STATS_GLOBAL_LEN * ETH_GSTRING_LEN;
> > > +     num_cpus = num_online_cpus();
> > >
> > >       for (i = 0; i < DPAA_STATS_PERCPU_LEN; i++) {
> > > -             for (j = 0; j < num_cpus; j++) {
> > > -                     snprintf(string_cpu, ETH_GSTRING_LEN, "%s [CPU %d]",
> > > -                              dpaa_stats_percpu[i], j);
> > > -                     memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> > > -                     strings += ETH_GSTRING_LEN;
> > > -             }
> > > -             snprintf(string_cpu, ETH_GSTRING_LEN, "%s [TOTAL]",
> > > -                      dpaa_stats_percpu[i]);
> > > -             memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> > > -             strings += ETH_GSTRING_LEN;
> > > -     }
> > > -     for (j = 0; j < num_cpus; j++) {
> > > -             snprintf(string_cpu, ETH_GSTRING_LEN,
> > > -                      "bpool [CPU %d]", j);
> > > -             memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> > > -             strings += ETH_GSTRING_LEN;
> > > +             for (j = 0; j < num_cpus; j++)
> > > +                     ethtool_sprintf(&data, "%s [CPU %d]",
> > > +                                     dpaa_stats_percpu[i], j);
> > > +
> > > +             ethtool_sprintf(&data, "%s [TOTAL]", dpaa_stats_percpu[i]);
> > >       }
> > > -     snprintf(string_cpu, ETH_GSTRING_LEN, "bpool [TOTAL]");
> > > -     memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> > > -     strings += ETH_GSTRING_LEN;
> > > +     for (i = 0; j < num_cpus; i++)
> >
> > Perhaps this should consistently use i, rather than i and j:
> >
> >         for (i = 0; i < num_cpus; i++)
> >
> > Flagged by W=1 builds with clang-18.
> I really need to compile test this on a PPC system.

Depending on your aims and hardware availability,
cross compiling may be easier.

But in any case, I don't think this problem relates to PPC.

> >
> > > +             ethtool_sprintf(&data, "bpool [CPU %d]", i);
> > > +
> > > +     ethtool_puts(&data, "bpool [TOTAL]");
> > >
> > > -     memcpy(strings, dpaa_stats_global, size);
> > > +     for (i = 0; i < DPAA_STATS_GLOBAL_LEN; i++)
> > > +             ethtool_puts(&data, dpaa_stats_global[i]);
> > >  }
> > >
> > >  static int dpaa_get_hash_opts(struct net_device *dev,
> >
> > ...
> 

