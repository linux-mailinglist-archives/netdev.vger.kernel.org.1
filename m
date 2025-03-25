Return-Path: <netdev+bounces-177529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEA7A7075C
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FDFB7A1BEF
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A66254B09;
	Tue, 25 Mar 2025 16:50:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B43184FAD;
	Tue, 25 Mar 2025 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921428; cv=none; b=ibzaOQODBAzj+8DhftOY0iaU4gm88JpTmBPRfmvGtMX+M/DPKINvIm9zPt7cr7YArjH/kJ/AXBpJ0lB8luhN1+yltowtU2bYER2jjvNnLRThSz+3V4rlru7s56FG3VOWsf17UXa3mYcOHGFcYcpRq1mt1YrxeixAmmCDep1kE0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921428; c=relaxed/simple;
	bh=Du7Gw+6+rVXQKsTd2sGK2ovTpxCazXX01HGzbwT39UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB9DWIww9w19VJ1aL3Zqw1ZRsfn9I55ThsHuRX+hJ7RnjE7UbcSQvE8T8sQh8d4jrzZT/+vH700I9te5v7Z+MD099RXZsIc/EeqTRgDgjV9wVlLrnBQmOU6zJzJ84KgLp6UoccRArV/8YhnYur+xv/KF92HlcVlPMQpWG9r+n/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abbd96bef64so58232166b.3;
        Tue, 25 Mar 2025 09:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742921424; x=1743526224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/ZytM1hc+zRsKNx9HKVSbc8n2BtaBHbt7AbiHmZb6E=;
        b=gTM5wWvgrHq47kc9dkQY22gFkaxXO1vtwVdO9otsg5sTjgBnBHcPJq0iiIlL92tAtw
         k+eLGFGWIW9yxV93iYxSOdMWRkXScYhMiGeQKZnoJJ+HMHiKDSnqX34uESIDW2mVgzKc
         Y8Ay4ZlyKKb9vcCuvWV2eaGD67j1jMW6HhfdTjBzfWcnDraY4oJE5OG6JAW00qsPrxBj
         EufrElXanZ6+pAvFfvNCQP41hgredufZ6xm0XXR99JYlBhwxTi91qRmKY6xdp/4d1NpT
         vfFxpVIaCvwR9kB7OEpPOgLKXHWTZCOIY5wiYIlIkxht9lQm9C37ObfVsjV5Db6YdpXK
         vgkA==
X-Forwarded-Encrypted: i=1; AJvYcCUqTBGCszJ1saYio5NU/DqtapJlSv+s/8xBEkJjtilB9VzLvlduVeqxpd3Cfhrie+aZy5PzRjF5KK4q4mg=@vger.kernel.org, AJvYcCWj6zYZmLSzF+7uEhMiNNSJ7yn17qWy0/JovSGANUtOruCHyL5fywbz+KkqjPArBBez9vuW6Ptt@vger.kernel.org
X-Gm-Message-State: AOJu0YyN40mliQmd0srPixwB0CIuqbVUTtarSiF3gaVYiwOgB00t8hY7
	RyLf+ESM14TCUT+uSgfBElZz2cVAz6GNA41ze5TQz/TTgLuETMzR
X-Gm-Gg: ASbGncvezP3fp/COancj1vrVIonpq+dNmuVS7XBQq7R/9sET4udjBTzFGQnKngmtP+W
	ftXnUumwnjzIZOiBjCw6AhLqx4YJ1JPy+vXJZ+a7HPvFTgYyKXmvgLD8et30AsEcht3tkxpZwar
	CBrEu1/itEbJ8YaojomceSJXjV299IACiVpuyBRzVbJIgjkboVRdrKyel5Tvw1Pd+NnKCblIBbT
	w9ZumVC1XdOLjXtUPOjxI0Fpg/aQHs4FFt6sKYo1IYId0fYW2Tkc4zx3YbMDLXZL//2UUlRO1qQ
	Fl/h+divNDEz2XvgcyKQjvdackLDJY+yJ/A=
X-Google-Smtp-Source: AGHT+IEdKEMAJgYD7a82jaxkDjPukvtfh/ZBxyz6IAzNhdDPO6JAvF/NkFvoclgaWsCm5bDXiG/DIw==
X-Received: by 2002:a17:907:60ca:b0:ac6:d9fe:a254 with SMTP id a640c23a62f3a-ac6d9fec4aamr92166866b.29.1742921424078;
        Tue, 25 Mar 2025 09:50:24 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd3aa21sm896009066b.158.2025.03.25.09.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 09:50:23 -0700 (PDT)
Date: Tue, 25 Mar 2025 09:50:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] netpoll: optimize struct layout for cache
 efficiency
Message-ID: <20250325-just-sloth-of-examination-7cd2df@leitao>
References: <20250324-netpoll_structstruct-v1-1-ff78f8a88dbb@debian.org>
 <20250325084838.5b2fdd1c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325084838.5b2fdd1c@kernel.org>

On Tue, Mar 25, 2025 at 08:48:38AM -0700, Jakub Kicinski wrote:
> On Mon, 24 Mar 2025 05:29:13 -0700 Breno Leitao wrote:
> > The struct netpoll serves two distinct purposes: it contains
> > configuration data needed only during setup (in netpoll_setup()), and
> > runtime data that's accessed on every packet transmission (in
> > netpoll_send_udp()).
> > 
> > Currently, this structure spans three cache lines with suboptimal
> > organization, where frequently accessed fields are mixed with rarely
> > accessed ones.
> > 
> > This commit reorganizes the structure to place all runtime fields used
> > during packet transmission together in the first cache line, while
> > moving the setup-only configuration fields to subsequent cache lines.
> > This approach follows the principle of placing hot fields together for
> > better cache locality during the performance-critical path.
> > 
> > The restructuring also eliminates structural inefficiencies, reducing
> > the number of holes. This provides a more compact memory layout while
> > maintaining the same functionality, resulting in better cache
> > utilization and potentially improves performance during packet
> > transmission operations.
> 
> Netpoll shouldn't send too many packets, "not too many" for networking
> means >100kpps. So I don't think the hot / close split matters?

I see your point. The gain is going to be marginal given the frequency
this netpoll is supposed to be called, for sure.

On the other side, I think this is still better than the current state,
given: 

 * it has no adverse effect
 * potential marginal performance win
 * structure packing, potentially saving 2 bytes.

> >   -   /* sum members: 137, holes: 3, sum holes: 7 */
> >   +   /* sum members: 137, holes: 1, sum holes: 3 */
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  include/linux/netpoll.h | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
> > index 0477208ed9ffa..a8de41d84be52 100644
> > --- a/include/linux/netpoll.h
> > +++ b/include/linux/netpoll.h
> > @@ -24,7 +24,16 @@ union inet_addr {
> >  
> >  struct netpoll {
> >  	struct net_device *dev;
> > +	u16 local_port, remote_port;
> >  	netdevice_tracker dev_tracker;
> 
> It's a little odd to leave the tracker in hot data, if you do it
> should at least be adjacent to the pointer it tracks?

Double-checking this better, netdevice_tracker is NOT on the hot path.
It is only used on the setup functions.

If you think this is not a total waste of time, I will send a v2 moving
it to the bottom.

Thanks for your review,
--breno

