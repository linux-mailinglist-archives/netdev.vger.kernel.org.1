Return-Path: <netdev+bounces-212984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9E7B22BB2
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F88426A43
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62272F547D;
	Tue, 12 Aug 2025 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaGUZzbS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF9F2F547A;
	Tue, 12 Aug 2025 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012561; cv=none; b=FJBPJcIw1/wzOmIckrEG0y4EtmkR9850EGYWAJmNurB5sZp9KyxG+o37FfHkBbucI2zgfYPjj3BRU0Ic0qK7+K0RD9b93lgSfi6LTDs/HGhHOozOPYCUKcAE6fJGVehtDFcSvn/Z0zURKDznADJl/c9JuXZTcO0M3+X7BIZsEOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012561; c=relaxed/simple;
	bh=5Tgg2deGlI4eNZsCF2xfyA6lLLh27CGrAGwMXyk9fLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsDoIga0JcuwSPoY/tNiPaGUuZbrMH6Ir97R1OQtLcJzrti0pceZ/J6Po8KStRbUdhkxuOMWWDbcN2rI3dNs098pT7h8ePXF1Fi1rZ9Pw0opdPRE7zJLeQdASo2TqZZW8YcmRZycSnU2/yy3tuMkREi72Lnrkl9AIvMLqKvs0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaGUZzbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382CEC4CEF6;
	Tue, 12 Aug 2025 15:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755012561;
	bh=5Tgg2deGlI4eNZsCF2xfyA6lLLh27CGrAGwMXyk9fLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IaGUZzbS3GyjzQvrFVimzLAperIyo5RXnjWkZ4UtnnpCb1DZdHQlQDNwon2bXycgb
	 G/twx3kbsHLIFhS7CjG2Y9K0RPPC41GztcYn9ev4hcV/Xkg3DmiigkGA6xTxZYwDZ0
	 CJLfyqT9oct+TceZXBeMOzfpEGW9WXmrF+eRHjbZ2Yvyyyvg5jfrT5IAMVxY5nVHV3
	 Ssnk3NcZMqzxciMrD9++vx6kBMnelf8mHBRUhQtPU8UziqmgG98qBkqUc3PMVsXfi7
	 ijqq4+Qdg0Nj22K6wMsTQm/32d0sYCMJlggJkM1FUSztEg87hQxyOfcDlQn31ijL5u
	 tabJLwA8GDpUw==
Date: Tue, 12 Aug 2025 08:29:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev-driver-reviewers@vger.kernel.org, netdev@vger.kernel.org, Sean
 Anderson <sean.anderson@linux.dev>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Russell King <linux@armlinux.org.uk>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [ANN] netdev call - Aug 12th
Message-ID: <20250812082920.26bae903@kernel.org>
In-Reply-To: <aJta5YNhKM9OqEmg@pidgin.makrotopia.org>
References: <20250812075510.3eacb700@kernel.org>
	<aJta5YNhKM9OqEmg@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 16:16:53 +0100 Daniel Golle wrote:
> On Tue, Aug 12, 2025 at 07:55:10AM -0700, Jakub Kicinski wrote:
> > The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> > 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
> > 
> > Sorry for the late announcement, I got out of the habit of sending
> > these. Luckily Daniel pinged.
> > 
> > Daniel do you think it still makes sense to talk about the PCS driver,
> > or did folks assume the that call is not happning?  
> 
> It could make sense to talk about it, but maybe we talk about other
> topics first to Sean can join us as well. However, I think mostly we
> depend on Russell or someone else to make a decision in terms of how the
> three of us (Christian, Sean and I) should continue.

Well, then I'm not sure if a meeting is the right approach in the first
place. Perhaps it's just my feeling but in corporate world managers call
meetings to force a decision (conclave-style). Upstream we force
decisions by having patches ready to be merged on the list.

I would like to avoid anyone ever feeling obligated to join a meeting
as part of their upstream work.

