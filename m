Return-Path: <netdev+bounces-117800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D1C94F5FB
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 19:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D961F2404C
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46A1189518;
	Mon, 12 Aug 2024 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlG+iLLF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008D188007
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484542; cv=none; b=V6HcJ2In9CMU8N5drElN2bbCa1gipSCZaBjHQ98nDT4ir13J/15q9daVJIAeH6/ZtRkMN6H2hoLx4jfoa/fePJkZKNHqJnB+ayjlpiBsemzTnLH+0smqXeENWX1EVe5BtTp6o/+uzYlBlq1eN4nI1N5hRgr99r6kUrRU4lL3Re4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484542; c=relaxed/simple;
	bh=DfjxRaqUINLWMk54QnInZ9UsrUeex24CEmA7Sq0AVJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRTIZOyYKC3sjzfU5tN+T78Qi++TCTGWiEzkUh7Wo8w9eGGCm+2hBKv5Ujj7g+yw1GkURVuMZNPLaLgHQvq+dwtxTF6pa8XHqRIHQ3rklF2dD37DHjhakT4StRA1Y3DqV5xyV7GwcKMPJB0YnR8pmbzKG2x08yfQgazRUcJ5z7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlG+iLLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3595C32782;
	Mon, 12 Aug 2024 17:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723484542;
	bh=DfjxRaqUINLWMk54QnInZ9UsrUeex24CEmA7Sq0AVJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hlG+iLLFXw2QIHUXhn+otfnB74IJqi9k7KkOvuhWpxoib5CS/m1LkTDRMBwX9hKjR
	 BXMmYioPoJ2Puywn/Q9bqwUb6REe0jjp30V30EJBlI3o41DxzcIsBlaPF+0El+gprH
	 kN+TPDGvy0UIYELGZLpAnzlEeo+fKHoFDKBX2Q1GIKO19bN9+EBpZB+mlicWt1e5CT
	 m1nSopX6ZriW24VX//zYRR7/i98irbcTx2FlwxVBX8e6EvMYQmEDTcSPcJ/nEWztYO
	 dZbUE/9OUjI3nTWd6aP4iKzfP1M/VNgxuzYvc2jCGcllRk6nfZNaIxu/d0D0n3KaDm
	 r7HPyaDBgqyRg==
Date: Mon, 12 Aug 2024 10:42:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, netdev@vger.kernel.org, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
Message-ID: <20240812104221.22bc0cca@kernel.org>
In-Reply-To: <Zro9PhW7SmveJ2mv@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
	<13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
	<ZquJWp8GxSCmuipW@nanopsycho.orion>
	<8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>
	<Zqy5zhZ-Q9mPv2sZ@nanopsycho.orion>
	<74a14ded-298f-4ccc-aa15-54070d3a35b7@redhat.com>
	<ZrHLj0e4_FaNjzPL@nanopsycho.orion>
	<f2e82924-a105-4d82-a2ad-46259be587df@redhat.com>
	<20240812082544.277b594d@kernel.org>
	<Zro9PhW7SmveJ2mv@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 18:50:06 +0200 Jiri Pirko wrote:
> Mon, Aug 12, 2024 at 05:25:44PM CEST, kuba@kernel.org wrote:
> >I think the confusion is primarily about the parent / child.
> >input and output should be very clear, IMO.  
> 
> For me, "inputs" and "output" in this context sounds very odd. It should
> be children and parent, isn't it. Confused...

Parent / child is completely confusing. Let's not.

User will classify traffic based on 'leaf' attributes.
Therefore in my mind traffic enters the tree at the "leaves", 
and travels towards the root (whether or not that's how HW 
evaluates the hierarchy).

This is opposite to how trees as an data structure are normally
traversed. Hence I find the tree analogy to be imperfect.
But yes, root and leaf are definitely better than parent / child.

> >> Also while at it, I think renaming the 'group()' operation as 
> >> 'node_set()' could be clearer (or at least less unclear), WDYT?  
> >
> >No idea how we arrived at node_set(), and how it can possibly   
> 
> subtree_set() ?

The operation is grouping inputs and creating a scheduler node.

> >represent a grouping operation.
> >The operations is grouping inputs and creating a scheduler node.
> >  
> >> Note: I think it's would be more user-friendly to keep a single 
> >> delete/get/dump operation for 'nodes' and leaves.  
> >
> >Are you implying that nodes and leaves are different types of objects?
> >Aren't leaves nodes without any inputs?  
> 
> Agree. Same op would be nice for both.

