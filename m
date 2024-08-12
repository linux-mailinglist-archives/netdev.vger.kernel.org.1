Return-Path: <netdev+bounces-117757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2360494F194
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F6C1F23202
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6590917C9FC;
	Mon, 12 Aug 2024 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KI12RGlA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4043B15C127
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476346; cv=none; b=NeYJYR6/Lu4KqgxZNamVuBefSGpUUmoxnYFP/7+wwAuvS2ryEQ+wnyt7xhAFf+E4V17A7/WZNii+G/vs0thI83RWMK8XXP5vxHy0TCh9w+kanHCnvRa4i22McM++kqcvq3TEEofzkB73eaw1Y47gOdtbvbataxwjY7Orwx583Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476346; c=relaxed/simple;
	bh=QTLOqwjlUXHaIjP+oJmo6GXNTYbHhRoNyD+IL98ppGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PAvElOmBaQKRRJYBJM0qEfhOmzVsjZgr4B4rLpOU3QUm/lO56MK8tglBil+elU57zzwDJ+h0gOILBi2o1gtj7Ol+ghEKAt0ge+RlhlVjAeUdbtr1rggQoOmQoFnRrQa8LIvlmt++rEc8WpcnTEg3VIB8qtgT+td146i4api0EWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KI12RGlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3AAC32782;
	Mon, 12 Aug 2024 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476345;
	bh=QTLOqwjlUXHaIjP+oJmo6GXNTYbHhRoNyD+IL98ppGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KI12RGlAanNah0XG7DNPHuCRIyigV2xwGMHbnQg30welJwUj3wQsus+nb61/iQAxT
	 I/2vX4HxkHC38qfuriW//TiizZBmTJCkja8EFazsBobcm9gEa9Ys1AFEeeM7a4EfZp
	 5CxjWzZApNT5Dxgi+cDcvRJ+SB7mPcSOwE0FBcnmw1rzameYFvfvZmNgZit3P+Euz1
	 Z/JN4Ge+ZPD5hdC+q6ZNOrPMTKO5a5tbg4it29MpafZsEJGRzjlh2/ULwk+EQuTvL3
	 uoJSSEK9eTKfY0R7wv4HgWgB1W0IlJ6di1p05eFfxXYJJKG8MxqcDY0aIdSUvGoFhu
	 EVzi5Lj4as9Pw==
Date: Mon, 12 Aug 2024 08:25:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Donald Hunter <donald.hunter@gmail.com>,
 netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>, Simon Horman <horms@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Sunil Kovvuri Goutham
 <sgoutham@marvell.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
Message-ID: <20240812082544.277b594d@kernel.org>
In-Reply-To: <f2e82924-a105-4d82-a2ad-46259be587df@redhat.com>
References: <cover.1722357745.git.pabeni@redhat.com>
	<13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
	<ZquJWp8GxSCmuipW@nanopsycho.orion>
	<8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>
	<Zqy5zhZ-Q9mPv2sZ@nanopsycho.orion>
	<74a14ded-298f-4ccc-aa15-54070d3a35b7@redhat.com>
	<ZrHLj0e4_FaNjzPL@nanopsycho.orion>
	<f2e82924-a105-4d82-a2ad-46259be587df@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 16:58:33 +0200 Paolo Abeni wrote:
> > It's a tree, so perhaps just stick with tree terminology, everyone is
> > used to that. Makes sense? One way or another, this needs to be
> > properly described in docs, all terminology. That would make things more
> > clear, I believe.  
> 
> @Jakub, would you be ok with:
> 
> 'inputs' ->  'leaves'
> 'output' -> 'node'
> ?

I think the confusion is primarily about the parent / child.
input and output should be very clear, IMO.

> Also while at it, I think renaming the 'group()' operation as 
> 'node_set()' could be clearer (or at least less unclear), WDYT?

No idea how we arrived at node_set(), and how it can possibly 
represent a grouping operation.
The operations is grouping inputs and creating a scheduler node.

> Note: I think it's would be more user-friendly to keep a single 
> delete/get/dump operation for 'nodes' and leaves.

Are you implying that nodes and leaves are different types of objects?
Aren't leaves nodes without any inputs?

