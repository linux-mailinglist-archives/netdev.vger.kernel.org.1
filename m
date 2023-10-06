Return-Path: <netdev+bounces-38665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1A97BBFC2
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 21:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FA7281EAD
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 19:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8089F3FB22;
	Fri,  6 Oct 2023 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DsV4Lx0z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327F38FBC
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 19:36:44 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C41D83
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2ezhxm1kcxenxfzavuYHDLHIlQoD1n9cj4C+y1iKrmc=; b=DsV4Lx0zXhUAulytJxLJ2r4As3
	oetouneF10FN+Ja/JObQ5wg7bUddSmj25HLSztD9+TojaM6b37jV8FZ15ChSQyYqXv6lE3VkJz1Eo
	/gyFPHOzRibLl1RKBUA5UUk9WiWQM8Pe8AuB30bAr9Jzuu6G8eXIuPKGsWa7XbcajwxU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qoqcm-0005gh-FK; Fri, 06 Oct 2023 21:36:36 +0200
Date: Fri, 6 Oct 2023 21:36:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, jesse.brandeburg@intel.com, sd@queasysnail.net,
	horms@verge.net.au
Subject: Re: [RFC] docs: netdev: encourage reviewers
Message-ID: <f821dab9-5706-4d91-a213-4e362b907583@lunn.ch>
References: <20231006163007.3383971-1-kuba@kernel.org>
 <8270f9b2-ec07-4f07-86cf-425d25829453@lunn.ch>
 <20231006115715.4f718fd7@kernel.org>
 <20231006121047.1690b43b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006121047.1690b43b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> So moved most of the paragraphs to the common docs, what I kept in
> netdev is this:
> 
> 
> Reviewer guidance
> -----------------
> 
> Reviewing other people's patches on the list is highly encouraged,
> regardless of the level of expertise. For general guidance and
> helpful tips please see :ref:`development_advancedtopics_reviews`.
> 
> It's safe to assume that netdev maintainers know the community and the level
> of expertise of the reviewers. The reviewers should not be concerned about
> their comments impeding or derailing the patch flow.
> 
> Less experienced reviewers should avoid commenting exclusively on more
> trivial / subjective matters like code formatting and process aspects
> (e.g. missing subject tags).
> 
> 
> Sounds reasonable?

Yes, that is reasonable. And i agree that i get the feeling some
subsystems don't know their community members too well, enough to
establish a good idea of trust or not.

Thanks
	Andrew

