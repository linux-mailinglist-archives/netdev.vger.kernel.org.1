Return-Path: <netdev+bounces-115016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D31944E38
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EB8287C46
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBBA1A57EB;
	Thu,  1 Aug 2024 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmK5Zf4T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D391A57D5
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523216; cv=none; b=mB8HZWEiH8/jbPqsVhrSGZ8kgsR4NWZS599xp/ijSpqHh/RgFihZfyDAFLVwF0wgawskXRwBQ+qeaRdedmtXd3hFAPam6KBOsmTcR0DRZQsuyi6AGoRsLDixgRZWgEeRH4PNfcHxdQQsboAihxcdyUSRykYK2XWj0qWRxl3CCGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523216; c=relaxed/simple;
	bh=9Ll92XEHCpR8I2GTHapzORlA7yy/V+Uiyt1EAj/Z1ek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfY7aUxnetl5YbFpPrMDqvTRtAskrHfi5lFOayzNqcb4lgBjYPxqv8VzkYAwvMytQnwPfQA2ELlvU+sdlay+yCjzzp8ebljoLdafhp7C+1/2zIGkg/NwxQp4ikJZIqqjyctc0ho2biMEFr+Ns24p5T5xhNUEqHQ4q/Vu9MUlSxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmK5Zf4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F14C4AF0B;
	Thu,  1 Aug 2024 14:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722523216;
	bh=9Ll92XEHCpR8I2GTHapzORlA7yy/V+Uiyt1EAj/Z1ek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TmK5Zf4T9HYkqKikzJhlIPuygMfMAW+dYdPa31kFEIatY1Tc2aFx4Q4Y8U5lKLARU
	 VraTbbU4kK5/u8+eo9DerQFmDRAs7s+9XxMSfvH40OMfJQhq1MNZfZJ9pg1Dfsjrhq
	 jwFI+QFRExiiAVqic4OeRMtPhZRr3S2F2ej27FUQogQ1EqPe11GIeYknkCGv5UPkLX
	 FSrHhtjahhjEN/yhpl83InvuKnDGmphSeOAPVZXy74YA5r6cMQGFYuD50iZYSL9bi7
	 F7S/ZXfGZG+rDgHD6TQHzbUAFNDDvK7x7dP7Qt5qw2caHfXOZZf9M2M0goIU2AL8M3
	 Kh+oyQ1y3smYA==
Date: Thu, 1 Aug 2024 07:40:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
Message-ID: <20240801074015.33c7fdef@kernel.org>
In-Reply-To: <ZquJWp8GxSCmuipW@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
	<13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
	<ZquJWp8GxSCmuipW@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Aug 2024 15:10:50 +0200 Jiri Pirko wrote:
> >+      -
> >+        name: netdev
> >+        doc: The main shaper for the given network device.
> >+      -
> >+        name: queue
> >+        doc: The shaper is attached to the given device queue.
> >+      -
> >+        name: detached
> >+        doc: |
> >+             The shaper is not attached to any user-visible network
> >+             device component and allows nesting and grouping of
> >+             queues or others detached shapers.  
> 
> What is the purpose of the "detached" thing?

FWIW I also find the proposed model and naming confusing, but didn't
want to object too hard in case it was just me. The model conflates
attachment points with shapers themselves, and (which perhaps is more
subjective) shapers with mux nodes.

This is already visible in the first example of the cover letter:

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
	--do set --json '{"ifindex":'$IFINDEX',
			"shaper": {"handle":
				{"scope": "queue", "id":'$QUEUEID' },
			"bw-max": 2000000 }}'

We are "set"ting a shaper on a queue, not "add"ing it, because
all attachment points implicitly have shapers(?) In my mind attachment
points is where traffic comes from or goes to, shapers must be created
to exist. And _every_ shaper has an ingress and egress, not just the
ones in the middle (i.e. which aren't directly next to an attachment
point) :(

