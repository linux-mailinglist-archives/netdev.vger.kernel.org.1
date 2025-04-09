Return-Path: <netdev+bounces-180779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44253A82782
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B681E3B13B3
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B9D18C937;
	Wed,  9 Apr 2025 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAt6kWOJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02A156F5E
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208151; cv=none; b=g0vOKulcgPO/cDMeDpNGAcoRkQg8V9KeVB1viF/C9mZNPvVCrC3Xla0CrUUaq5Y02ZOeTNRn6CFsr2vXl5qbOYanQAYVAQZC0zMt0Zk5DO7yRSajh149Y6EzRHlnJZB3B/F0nCJBiW4bE4naHf3LWUP0VTpMnRCoa+jZ9V6MpVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208151; c=relaxed/simple;
	bh=TqGaa8r+fkf01KqqGn+ym+zvH7YgBPYBl8By/jReYMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWoHz84ZJubS/EH9w3wt447J617CFTIrdIloq1JOiFQsPr7G4AfuISYvEnK/iPIfP64ecGLrhaL7Eguu/c6HlKSNGxsay1uLkrahF2IOIli32cCvfiw2W3VUDfNZsQ198LeoYtYJ4HKqpEbnN0HkvwnjabnJj2SIAoRcFm2UPH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAt6kWOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84867C4CEE2;
	Wed,  9 Apr 2025 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744208151;
	bh=TqGaa8r+fkf01KqqGn+ym+zvH7YgBPYBl8By/jReYMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QAt6kWOJNuwaC2RdmNE1qWnL2RXQdYGsJHLx9FhAOMttRI2vz+d0N5nYoXYsotel1
	 5AgXpzENSkL5qjzpJ9gys/+3qCbjxcwLhdVOHU/NgC2BHeZMAS5NTW5p3dyZm8Ek00
	 ZVbQmk+QIf9iLNpp4U7JsVwGf5khfmBdGN0caVk9AKai3R99XNzM8vIJTteFnUEzpT
	 jgmg8cusSmfxEOau2oF96pZNub5wQDEvjMzPuGQXU1sJUdztdxPI4UCuJMR7lKuADH
	 HMWxdqr79CRJ/tK2o91RIugJSh0QhjbRbhbZ2ISNzfN9LQ4HFid8LfdrJ1644sodTA
	 q4v/VK9lq0QBg==
Date: Wed, 9 Apr 2025 07:15:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, <davem@davemloft.net>,
 <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <yuyanghuang@google.com>,
 <sdf@fomichev.me>, <gnault@redhat.com>, <nicolas.dichtel@6wind.com>,
 <petrm@nvidia.com>
Subject: Re: [PATCH net-next 01/13] netlink: specs: rename rtnetlink specs
 in accordance with family name
Message-ID: <20250409071549.6e1934ab@kernel.org>
In-Reply-To: <m25xjd4jkh.fsf@gmail.com>
References: <20250409000400.492371-1-kuba@kernel.org>
	<20250409000400.492371-2-kuba@kernel.org>
	<92cc7b8f-6f9c-4f7a-99f0-5ea4f7e3d288@intel.com>
	<m25xjd4jkh.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I thought about it some more.

On Wed, 09 Apr 2025 13:15:42 +0100 Donald Hunter wrote:
> I'll just note that the genl convention is underscores in family names,
> if you wanted consistency across all families.

I wasn't clear on whether it's a convention or just how we did things
historically. We recommend the use of dashes in the spec itself so it
stands to reason to also use dashes in the family name.
But replacing dashes with underscores is a "C thing", and family name
string is used by all languages, so we shouldn't s/-/_/ when we output
the family name for the kernel's code struct genl_family.

IOW I think that either we 
- accept the slight inconsistency with old families using _, or 
- accept the slight annoyance with all languages having to do s/-/_/
  when looking up family ID, or 
- accept the inconsistency with all name properties in new YAML spec
  being separated with - and just the family name always using _.

:( I picked the first option, assuming the genl family names don't have
much of a convention. Admittedly I don't know of any with dashes but
some of them use capital letters :S

LMK if you think we should pick differently. In my mind picking option
1 is prioritizing consistency of the spec language over the consistency
of user experience. We can alleviate the annoyance of typing --family ..
with bash completions?

