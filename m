Return-Path: <netdev+bounces-40050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8877C5901
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED811C20ADC
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9E432C93;
	Wed, 11 Oct 2023 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtOlTZuS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E930F88
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168B9C433C7;
	Wed, 11 Oct 2023 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697041200;
	bh=pDTAJVGHavfQ67VUhwWXW0cMR4HQ7pEiXLr3viT1UXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZtOlTZuSuGbLi1NwDc5StOXMpomx7qnjtGwJR7Fp/v+KE+e5hn3cCIa6Bvm0skU2d
	 5U+LYPnHRPFY6w4fBwQ+FeZM6lTRaB5F9BADCxuCpXKLOMa/eaFeLcaSLbyD+6pyaH
	 xG9dFCJVH9fgQr4LPjSPpRlmenlS7VGJbGe+x0oTwIadSIVG75XnNJGzC1zNT0wrUt
	 efS9PmG3y+KW6auGfrOw27GS2gQRNjC9/WaDe1GbS6yYZVOuRNQ9sxb+VZb74TFV+e
	 PdtVzFFFHslyWBMgjKalN3OXbeSbD++oX2+xxkyT/KsxmyyR3acSlRT3MfhKpsOL+m
	 4X8A+bJ9bxZDg==
Date: Wed, 11 Oct 2023 09:19:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com, fw@strlen.de,
 pablo@netfilter.org, jiri@resnulli.us, mkubecek@suse.cz,
 aleksander.lobakin@intel.com, Thomas Haller <thaller@redhat.com>
Subject: Re: [RFC] netlink: add variable-length / auto integers
Message-ID: <20231011091959.48010d43@kernel.org>
In-Reply-To: <9c70c71cecf19a50c56ed57c0f99660a3176d11d.camel@sipsolutions.net>
References: <20231011003313.105315-1-kuba@kernel.org>
	<f75851720c356fe43771a5c452d113ca25d43f0f.camel@sipsolutions.net>
	<20231011090859.3fc30812@kernel.org>
	<9c70c71cecf19a50c56ed57c0f99660a3176d11d.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 18:16:42 +0200 Johannes Berg wrote:
> > I was planning to add the docs to Documentation/userspace-api/netlink/
> > Is that too YNL-specific?  
> 
> Oh. I guess I keep expecting that header files at least have some hints,
> but whatever ... experience tells me anyway that nobody bothers reading
> the comments and people just copy stuff from elsewhere, so we just have
> to get this right first in one place ;-)

I'll try to add something in the header, in that case.
The netlink.h headers are particularly non-conducive
to finding stuff since we have 3 of them :(

