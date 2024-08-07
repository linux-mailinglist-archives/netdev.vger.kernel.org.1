Return-Path: <netdev+bounces-116527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C84694AAAC
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF879B2CE15
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD17823DF;
	Wed,  7 Aug 2024 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kGILZwEA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD717D417
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041895; cv=none; b=S9qmo2S9912uU0dTQOO1tbrwRfEcrIWDE6mgA2Xj9X7Q3QeMC830FevDE0sgGSxlsRC6uB0gVgwMJdzLYZr7/RIEFnKnZ23crYfg98HLLcGADET31KZdtGKf1psrb76jRJhETYZqTZEP88bGp8wZn5g5mu3vOVGf530J1B74ccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041895; c=relaxed/simple;
	bh=ip3ka/E3cxhxALxb2EfsYxzvi+saL9E01qAxyxt60jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QucMkWJZ8d5HUQA/yD0RehnR4hrzG2UIR/kokC+9H5WA32xFx261ROKKsI1vu3W0y0fUQZ0W0F9GmaVvEORuuCWmXF9N3Vt47k56YGFUtWfirBJm/Wp7tpPoczDdl/m5YhLAb4DCyMRZk2RoCDc5UcjayNMQSnEl8/MyxSpCf7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kGILZwEA; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WfCcp3ZLyzrtM;
	Wed,  7 Aug 2024 16:44:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723041882;
	bh=/KAAV1vnbhEgpC8ceOtXuLi1kCt4M+X9NbsJcgjWRak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGILZwEAKTm2GbuB5K86gyna7WzvjTLlL2XPA7UFU+8CNgOkkjIJf/PFFRXH1byrU
	 Y/sQGY8sQurL+2/qlVjwC3oUYOSw8ZbZPNe1L73cKWhHRmWYdA+jFZHR6JK6P9JHq8
	 60bF77Nxd0keo9EEHYUXS3ajzEtzPl6Z7NcfAh9Q=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WfCcm6YKnzh9s;
	Wed,  7 Aug 2024 16:44:40 +0200 (CEST)
Date: Wed, 7 Aug 2024 16:44:36 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, outreachy@lists.linux.dev, 
	gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 1/4] Landlock: Add abstract unix socket connect
 restriction
Message-ID: <20240807.Be5aiChaf8ie@digikod.net>
References: <cover.1722570749.git.fahimitahera@gmail.com>
 <e8da4d5311be78806515626a6bd4a16fe17ded04.1722570749.git.fahimitahera@gmail.com>
 <20240803.iefooCha4gae@digikod.net>
 <20240806.nookoChoh2Oh@digikod.net>
 <CAG48ez2ZYzB+GyDLAx7y2TobE=MLXWucQx0qjitfhPSDaaqjiA@mail.gmail.com>
 <20240807.mieloh8bi8Ae@digikod.net>
 <CAG48ez3_u5ZkVY31h4J6Shap9kEsgDiLxF+s10Aea52EkrDMJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3_u5ZkVY31h4J6Shap9kEsgDiLxF+s10Aea52EkrDMJg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Aug 07, 2024 at 03:45:18PM +0200, Jann Horn wrote:
> On Wed, Aug 7, 2024 at 9:21 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Tue, Aug 06, 2024 at 10:46:43PM +0200, Jann Horn wrote:
> > > I think adding something like this change on top of your code would
> > > make it more concise (though this is entirely untested):
> > >
> > > --- /tmp/a      2024-08-06 22:37:33.800158308 +0200
> > > +++ /tmp/b      2024-08-06 22:44:49.539314039 +0200
> > > @@ -15,25 +15,12 @@
> > >           * client_layer must be a signed integer with greater capacity than
> > >           * client->num_layers to ensure the following loop stops.
> > >           */
> > >          BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
> > >
> > > -        if (!server) {
> > > -                /*
> > > -                 * Walks client's parent domains and checks that none of these
> > > -                 * domains are scoped.
> > > -                 */
> > > -                for (; client_layer >= 0; client_layer--) {
> > > -                        if (landlock_get_scope_mask(client, client_layer) &
> > > -                            scope)
> > > -                                return true;
> > > -                }
> > > -                return false;
> > > -        }
> >
> > This loop is redundant with the following one, but it makes sure there
> > is no issue nor inconsistencies with the server or server_walker
> > pointers.  That's the only approach I found to make sure we don't go
> > through a path that could use an incorrect pointer, and makes the code
> > easy to review.
> 
> My view is that this is a duplication of logic for one particular
> special case - after all, you can also end up walking up to the same
> state (client_layer==-1, server_layer==-1, client_walker==NULL,
> server_walker==NULL) with the loop at the bottom.

Indeed

> 
> But I guess my preference for more concise code is kinda subjective -
> if you prefer the more verbose version, I'm fine with that too.
> 
> > > -
> > > -        server_layer = server->num_layers - 1;
> > > -        server_walker = server->hierarchy;
> > > +        server_layer = server ? (server->num_layers - 1) : -1;
> > > +        server_walker = server ? server->hierarchy : NULL;
> >
> > We would need to change the last loop to avoid a null pointer deref.
> 
> Why? The first loop would either exit or walk the client_walker up
> until client_layer is -1 and client_walker is NULL; the second loop
> wouldn't do anything because the walkers are at the same layer; the
> third loop's body wouldn't be executed because client_layer is -1.

Correct, I missed that client_layer would always be greater than
server_layer (-1).

Tahera, could you please take Jann's proposal?


> 
> The case where the server is not in any Landlock domain is just one
> subcase of the more general case "client and server do not have a
> common ancestor domain".
> 
> > >
> > >          /*
> > >           * Walks client's parent domains down to the same hierarchy level as
> > >           * the server's domain, and checks that none of these client's parent
> > >           * domains are scoped.
> > >
> 

