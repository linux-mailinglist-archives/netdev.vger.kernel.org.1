Return-Path: <netdev+bounces-212697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 895D0B219F5
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6884646074B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72632D77EC;
	Tue, 12 Aug 2025 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZL5ZkKr0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0800229B21;
	Tue, 12 Aug 2025 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754960217; cv=none; b=Cryy6QG08zjVwjawCxlH+1LP5L9U2CesLnyzW9ePVSl4QBuNXj9Z+k2SFn7vZK9/uOf4EkrZqaS+MkkJkesfZezMkw1hJbBmWDRxQ14BuUU5QycGUcMGmIbZJWN5Wcm6gjPOY9JDmaVSgQrucSLVS73Qca6Ccwqm3olkG+OJgjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754960217; c=relaxed/simple;
	bh=w6RoAic6vmLc6hitiMVy67ml85p5T/2lzJYTlNxsFf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tstkjC8+R/cLCmN1BFKR2hufLRl4O9GevRbJ+XIuZ6GfTayWKyPX3DL89wlpvTpoGPMdHVO3XnAIkA0mDsv1s1yV44b5HiorjpViHLttC1huG4/ZEV/XMMzrPnp93gC2vkCfRV+MgEWXdViwyjkmx6v+/oZAnFTbNe+q7mOH/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZL5ZkKr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573D7C4CEED;
	Tue, 12 Aug 2025 00:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754960217;
	bh=w6RoAic6vmLc6hitiMVy67ml85p5T/2lzJYTlNxsFf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZL5ZkKr0Oy9ZMeRuwLucq3F8Ej8wzuDfCQfSDU1GkBrDqLAed1wyDLkBIW98IYCIV
	 zJmN9yUnzOo5tRhfwKKRiB5ZYgnZJjdRXSiXbMYtnkshSQ2wf3V6AGplesrinHrSXv
	 3jpoFWcDpBHMgAO4JqvBpiZD+Scx21C1kObewD4/1zeQrenvwH8h+CCUQHid2UJ3Jp
	 MWSIzb9ITMMttgqFStJcMvXAYM7pljobcED1a7kOU3mTek72dyBZaPwfrPoe1UocdT
	 x/Z3DWXqbISsDflw6bRrTzzant1FIbjZgUMJzjHGKT7P2FinAGFfCBaYrjmg+L6iAl
	 3PbixuRh5CrpQ==
Date: Mon, 11 Aug 2025 17:56:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Akira
 Yokosawa <akiyks@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Ignacio Encinas Rubio <ignacio@iencinas.com>, Marco Elver
 <elver@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, Jan Stancek
 <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters
 <rubenru09@aol.com>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, lkmm@lists.linux.dev,
 netdev@vger.kernel.org, peterz@infradead.org, stern@rowland.harvard.edu,
 Breno Leitao <leitao@debian.org>, Randy Dunlap <rdunlap@infradead.org>,
 Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v10 00/14] Don't generate netlink .rst files inside
 $(srctree)
Message-ID: <20250811175648.04ccd9de@kernel.org>
In-Reply-To: <87ms85daya.fsf@trenco.lwn.net>
References: <cover.1753718185.git.mchehab+huawei@kernel.org>
	<87ms85daya.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 11:28:45 -0600 Jonathan Corbet wrote:
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> > That's the v10 version of the parser-yaml series, addressing a couple of
> > issues raised by Donald.
> >
> > It should apply cleanly on the top of docs-next, as I just rebased on
> > the top of docs/docs-next.
> >
> > Please merge it via your tree, as I have another patch series that will
> > depend on this one.  
> 
> I intend to do that shortly unless I hear objections; are the netdev
> folks OK with this work going through docs-next?

No objections.

Would you be willing to apply these on top of -rc1, and create a merge
commit? YNL is fairly active, if there's a conflict we may be testing
our luck if Linus has to resolve Python conflicts.

Happy to do that on our end (we have a script:)), or perhaps Mauro could
apply and send us both a PR?

