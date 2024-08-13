Return-Path: <netdev+bounces-118104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5451295084B
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F751C2259F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0310C19EEB7;
	Tue, 13 Aug 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tj0OA9/I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D040419EEA4
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561109; cv=none; b=MlPWlWDjCQhJLq4BI59neiudG8z/hYBCxhbN9r9vsJDZqlsgbdOH02J5MWuEMCD+mXWFeT7p/QZYqOnN1PVwv4e0lJJ8O/MhjUV4UgSLVme0ZrTJX3EVVS3siVinkzZoYgEud+D2ECx9YSC4d8gAMhZJP6LShIuCOjHhHRRZg1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561109; c=relaxed/simple;
	bh=evrNuqFMPeQnnqxD9Q7pnyiac9OQpyHKNWla5vGz1mA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIo8bKDQ5LCehwIY4OGI5V170TvKzeT4D+tBqA6E8onyZxHNosjzCpT2/WtWrl7K7FhRdzXq3eI9XvsxURIsfrxHa99pjv2W0j5dNuj0SE5lf/2GkC+HneAzYPIavIAKNNYJTpfmxBcOkjoaKZvjKiQXLFM/59bfjEHpqOrhUD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tj0OA9/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E614EC4AF09;
	Tue, 13 Aug 2024 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723561109;
	bh=evrNuqFMPeQnnqxD9Q7pnyiac9OQpyHKNWla5vGz1mA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tj0OA9/IMrtMlbf8CrPGAeaa1RwUnk/eL+OnxtL90PJP/S6cL4TS9NFAKiCFuBA5F
	 7FJtPhkxDW0oHVBLEg2RHs1WVUSqk9PYxnkVKkU7aaImqCaLM5zWYCiPaAOojPoZ+v
	 aKnARtMmFz6WJSh+aQOLzlF/fxNR3BtHm6tvE6mjm4qwljuqHPZLDrrXWyhfo3fqVW
	 ikJmyTX4NfpgVazPsCG+kAv5LO5E0FgV7ZzSKhFeO2ZcUh3J5G/oGZbugf0A2E7qwU
	 XZptiFcfDyptYf5J4P9aUHYK2RfZuUsl1cr7ckAZEigW5uyHKtpdzKyfm/TpX19Yji
	 VCElrtmJ9kM+A==
Date: Tue, 13 Aug 2024 07:58:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Donald Hunter <donald.hunter@gmail.com>,
 netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>, Simon Horman <horms@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Sunil Kovvuri Goutham
 <sgoutham@marvell.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
Message-ID: <20240813075828.4ead43d4@kernel.org>
In-Reply-To: <eb027f6b-83aa-4524-8956-266808a1f919@redhat.com>
References: <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
	<ZquJWp8GxSCmuipW@nanopsycho.orion>
	<8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>
	<Zqy5zhZ-Q9mPv2sZ@nanopsycho.orion>
	<74a14ded-298f-4ccc-aa15-54070d3a35b7@redhat.com>
	<ZrHLj0e4_FaNjzPL@nanopsycho.orion>
	<f2e82924-a105-4d82-a2ad-46259be587df@redhat.com>
	<20240812082544.277b594d@kernel.org>
	<Zro9PhW7SmveJ2mv@nanopsycho.orion>
	<20240812104221.22bc0cca@kernel.org>
	<ZrrxZnsTRw2WPEsU@nanopsycho.orion>
	<20240813071214.5724e81b@kernel.org>
	<eb027f6b-83aa-4524-8956-266808a1f919@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 16:47:34 +0200 Paolo Abeni wrote:
> >> Creating a node inside a tree, isn't it? Therefore subtree.  
> > 
> > All nodes are inside the tree.
> >   
> >> But it could be unified to node_set() as Paolo suggested. That would
> >> work for any node, including leaf, tree, non-existent internal node.  
> > 
> > A "set" operation which creates a node.  
> 
> Here the outcome is unclear to me. My understanding is that group() does 
> not fit Jiri nor Donald and and node_set() or subtree_set() do not fit 
> Jakub.
> 
> Did I misread something? As a trade-off, what about, group_set()?

"set" is not a sensible verb for creating something. "group" in 
the original was the verb.
Why are both saying "set" and not "create"? What am I missing?

