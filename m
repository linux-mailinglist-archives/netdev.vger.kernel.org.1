Return-Path: <netdev+bounces-107868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2EE91CA78
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 04:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384991C21117
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 02:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EE8566A;
	Sat, 29 Jun 2024 02:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMTl1eKw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B653AC
	for <netdev@vger.kernel.org>; Sat, 29 Jun 2024 02:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719627152; cv=none; b=tH9UjJGP/8i3LYTGLFPsD/28PCoXyD3flvBYM4HRyaD6hKVtaBrj1vCDDOOZ4ILgrCSTjKB7uGgJnEjS/N80v+4nZ+CupJQ0zsSDtP/+ePkqWx4Q9g57ydxwlka1TrQJiMPbI4ZaVhi/50OMiIXq8kq0PKwIQUahlDAVnq0JZok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719627152; c=relaxed/simple;
	bh=yEj7N+tnmMny40LWV6gkqFbmSb5bXGSMGKRSHeGi7/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=miZMOfahCkFabtI4kMUy8iHOsOjWOHZBXmNfWXzzXqZHobgmCtPIKU+z0XurWUMILK5KtZU90l/qAN1MEA2ZQHOIJ+f3ciBamEbMVJZ4L/fGBEzPN3rCWQhbVEMNz/4LTJCLR2b7wOqVTYAem5tSS4aJLoJkTrcOeFWDgFrxQ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMTl1eKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4079C116B1;
	Sat, 29 Jun 2024 02:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719627152;
	bh=yEj7N+tnmMny40LWV6gkqFbmSb5bXGSMGKRSHeGi7/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jMTl1eKwcGegN/WAyon9wFQvKl7XyzItxKG3rCn5n0SRCcVNBa+KyLP3RgyPdtt2d
	 QIOUmKMGQYOFi5T1eaQrjoLsHdPaHKprzIsGW7wnHxw7GZKZ46omJ9zHy1K1QXQ8s7
	 +ObhbkbHPYa2BozAHTeu+KvIK6kiiguH0ZLz32CXggCMIofGAZPiz1U8/AzsVP6QoA
	 Z0v/cJU6/DiAlM8FEU7h0OwnFNwHe/pzC83g4lRnlvCcW+Y/DWP/hmcWNcOSJGFxgQ
	 84acTRoxae53z6EMY9BDj+lm26LJock+b4v57Fnf0clumyNcNYsiEMeqbXuEB74MrU
	 cn3TY67LE4gjg==
Date: Fri, 28 Jun 2024 19:12:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH net-next 1/5] netlink: spec: add shaper YAML spec
Message-ID: <20240628191230.138c66d7@kernel.org>
In-Reply-To: <75cb77aa91040829e55c5cae73e79349f3988e06.1719518113.git.pabeni@redhat.com>
References: <cover.1719518113.git.pabeni@redhat.com>
	<75cb77aa91040829e55c5cae73e79349f3988e06.1719518113.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 22:17:18 +0200 Paolo Abeni wrote:
> +      -
> +        name: port
> +        doc: The root shaper for the whole H/W.
> +      -
> +        name: netdev
> +        doc: The main shaper for the given network device.
> +      -
> +        name: queue
> +        doc: The shaper is attached to the given device queue.
> +      -
> +        name: detached
> +        doc: |
> +             The shaper can be attached to port, netdev or other
> +             detached shapers, allowing nesting and grouping of
> +             netdev or queues.
> +    render-max: true

nit: move other properties before the list

> +attribute-sets:
> +  -
> +    name: net_shaper

s/_/-/ on all names

> +    attributes:
> +      -
> +        name: ifindex
> +        type: u32
> +      -
> +        name: parent
> +        type: nest
> +        nested-attributes: handle
> +      -
> +        name: handle
> +        type: nest
> +        nested-attributes: handle
> +      -
> +        name: metric
> +        type: u32
> +        enum: metric
> +      -
> +        name: bw-min
> +        type: u64

s/u64/uint/

> +      -
> +         name: handles
> +         type: nest
> +         multi-attr: true
> +         nested-attributes: handle

oh both handle and handles...
it'd be good to have more doc: for the attributes, all these things get
auto-rendered on docs.kernel.org

> +      -
> +        name: shapers
> +        type: nest
> +        multi-attr: true
> +        nested-attributes: ns-info

How do shapers differ from shaping attrs in this scope? :S

> +      -
> +        name: modified
> +        type: u32
> +      -
> +        name: pad
> +        type: pad

after using uint this can go

> +operations:
> +  list:
> +    -
> +      name: get
> +      doc: |
> +        Get / Dump information about a/all the shaper for a given device
> +      attribute-set: net_shaper
> +      flags: [ admin-perm ]

Any reason why get is admin-perm ?


