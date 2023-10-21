Return-Path: <netdev+bounces-43174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B41697D1A46
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 03:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7FB28270C
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 01:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8B37EA;
	Sat, 21 Oct 2023 01:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RelBBUph"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C655865B
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 01:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0545DC433C8;
	Sat, 21 Oct 2023 01:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697851550;
	bh=J5knPylNZVcOWwOF3WNuXa/tJmc5l8OmbqkJIu/ovCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RelBBUphakMLBKqg9JaTAjNL3zpEUpIJcBoMpWmihGEdiVyBo4EvWckGnug/CDG9T
	 dJdo0PcComq8TNsORDwy6poWSWvh3TZaQiONzCCfu77Osef+8YnfHZ2I6r+mtBXkaf
	 fTcR4yWWd0zvxoQq0gjzlGQ0lIW6K2DCwz7L9VGGrwzJ1sNX/KkLgB3uOPrJeyJSb9
	 F0zKhzPa5QiiGguXEqudfTxmI9u/4Gdmct3zNqRB0VFCdBlwaYRqjNs3uiystOSfYh
	 kPA9ME/zEHvVbAQXvNz+7Ci9H29z54oX6zzAtWSEeDtgCXHKUc/1m6P0VAZKpL3hbV
	 wkNjMEQdsvqeg==
Date: Fri, 20 Oct 2023 18:25:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, johannes@sipsolutions.net
Subject: Re: [patch net-next v2 05/10] netlink: specs: devlink: make
 dont-validate single line
Message-ID: <20231020182549.06a7dc8d@kernel.org>
In-Reply-To: <20231020092117.622431-6-jiri@resnulli.us>
References: <20231020092117.622431-1-jiri@resnulli.us>
	<20231020092117.622431-6-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 11:21:12 +0200 Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Make dont-validate field more compact and push it into a single line.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

