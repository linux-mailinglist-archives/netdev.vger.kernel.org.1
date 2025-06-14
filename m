Return-Path: <netdev+bounces-197798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EAFAD9E8C
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 19:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D363AE323
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 17:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8D32E338E;
	Sat, 14 Jun 2025 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RupatiqN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2411C54AF;
	Sat, 14 Jun 2025 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749922622; cv=none; b=geXOOY7lGYSSpEqVimtgvaQ4XC6vN7HAB+Y5HgNoAD7kPqU9uLKQCR1AoB1vaOYk3vWzDQIbjjt0uEXFxNyuGWuIOU+2uoGtorSLiP0juc869987KQpiBFaPjHIuTbcal1WqhRglugIHmXwYSLXpcmXLzUokMyuxzdXkrhXaz3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749922622; c=relaxed/simple;
	bh=giWEbQVGPDAUjjSTlftLxeH1yHeLxWW9myogm0Xe15s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLx9ISpNZm6B5Q4xGMj/bPsouk9bDZYoGgG2t+/N1vbeyhaXGRo2+Zrtr7XgB6kfbIjESPX56jckuUwb7aoOlY619WFxrsIRayd5qh6Pag4QkFrlpjSG9HKpHEQ2QvLX++n1Nopd+SeML+ALMn/jcCncxgfXtrKCV/L6revuZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RupatiqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0D8C4CEEB;
	Sat, 14 Jun 2025 17:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749922622;
	bh=giWEbQVGPDAUjjSTlftLxeH1yHeLxWW9myogm0Xe15s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RupatiqNGmEi2ttyLukWxybZN5O3W1zwp6BtLXJErrSUf/aF+OwYPT+DmBkH2WNGY
	 Lckjf/Mi90RsO60JeKaj6VH/N25cSKoKwpOSNWNJgrt0ClDjk0o/FppvRnFY8MtaC5
	 4uFiDGcwKekZ7Izxs7rgw1fRUzMFunNs8olLbSVCDGKyKILtdfgZsbnLTPiMh38ABR
	 Fl5yy0ssRFatLI7JqqekkHJc49wIy7RkElzhhf6U6Xke90wfuzUvUV/OAVLwZmnSHC
	 yHyNRiHsDRNXT9AtQLcDmHVGznYmFgI6cQyj0GkblAvE2iSq+Xwq3YYAd1IfHb4nHT
	 BNmnvdce2DDEA==
Date: Sat, 14 Jun 2025 10:37:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Akira
 Yokosawa <akiyks@gmail.com>, Breno Leitao <leitao@debian.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Ignacio
 Encinas Rubio <ignacio@iencinas.com>, Jan Stancek <jstancek@redhat.com>,
 Marco Elver <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Ruben
 Wauters <rubenru09@aol.com>, Shuah Khan <skhan@linuxfoundation.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v4 12/14] MAINTAINERS: add maintainers for
 netlink_yml_parser.py
Message-ID: <20250614103700.0be60115@kernel.org>
In-Reply-To: <20250614173235.7374027a@foz.lan>
References: <cover.1749891128.git.mchehab+huawei@kernel.org>
	<ba75692b90bf7aa512772ca775fde4c4688d7e03.1749891128.git.mchehab+huawei@kernel.org>
	<CAD4GDZzA5Dj84vobSdxqXdPjskBjuFm7imFkZoSmgjidbCtSYQ@mail.gmail.com>
	<20250614173235.7374027a@foz.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Jun 2025 17:32:35 +0200 Mauro Carvalho Chehab wrote:
> > > @@ -27314,6 +27315,7 @@ M:      Jakub Kicinski <kuba@kernel.org>
> > >  F:     Documentation/netlink/
> > >  F:     Documentation/userspace-api/netlink/intro-specs.rst
> > >  F:     Documentation/userspace-api/netlink/specs.rst
> > > +F:     scripts/lib/netlink_yml_parser.py
> > >  F:     tools/net/ynl/  
> 
> With regards to the location itself, as I said earlier, it is up to
> Jon and you to decide.
> 
> My preference is to have all Python libraries at the entire Kernel
> inside scripts/lib (or at some other common location), no matter where
> the caller Python command or in-kernel Sphinx extensions are located.

I understand that from the PoV of ease of maintenance of the docs.
Is it fair to say there is a trade off here between ease of maintenance
for docs maintainers and encouraging people to integrate with kernel
docs in novel ways?

