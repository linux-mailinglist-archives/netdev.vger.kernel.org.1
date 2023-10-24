Return-Path: <netdev+bounces-43999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F20C7D5C9D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DE71F21EC8
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 20:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A012AB3A;
	Tue, 24 Oct 2023 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnZxLEWu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF2A79D6
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 20:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D617EC433C7;
	Tue, 24 Oct 2023 20:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698180730;
	bh=aQp1F2otzR+yr4CFoWGp/MeWGiQzu/fU52OX8xAthKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hnZxLEWu1oSLQz0KEFizxiMmvFMiBdppyMayB+hI+LOjq5lHB2UW7DWUnVdJFuTZv
	 NsqcAKhY6xzMdmWgQkkphc2TObmzSzyUtnzDWrwkjjFue/kNzanH+bqmIUx4JZsPiE
	 VrRlmhgBzRKQdcQf3g5CiXnRAt3F19LtoldB7WWiIWBNkeUBNvFok3rRIcr8cw7iOd
	 d90yB/AUWHEJcVhcw/s0wD+J4OCdzcVxzlpHR057Eb0OxVH1ZiGyNwTeliBxbK9ECL
	 SJ7mnBJQHikFoC6Qw0mrKO1Q7mJrPsDriKQLQ2Hti8yJ6tK/DphXC7Auv6wCIXIVBM
	 EztVvyAKGJXqA==
Date: Tue, 24 Oct 2023 13:52:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-2023-10-24
Message-ID: <20231024135208.3e40b69a@kernel.org>
In-Reply-To: <1020bbec6fd85d55f0862b1aa147afbd25de3e74.camel@sipsolutions.net>
References: <20231024103540.19198-2-johannes@sipsolutions.net>
	<169817882433.2839.2840092877928784369.git-patchwork-notify@kernel.org>
	<1020bbec6fd85d55f0862b1aa147afbd25de3e74.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 22:25:18 +0200 Johannes Berg wrote:
> Are you planning to merge net into net-next really soon for some reason?

Submitting on Wed did cross my mind, but there's no solid plan.
Unless that changes, Paolo will submit net on Thursday, EU time.
And we'll cross-merge once Linux pulls. 

> If not, I can resolve this conflict and we'll include it in the next
> (and last) wireless-next pull request, which will be going out Thursday
> morning (Europe time.)

Sounds good! But do you need to do the resolution to put something 
on top? Otherwise we can deal with the conflict when pulling.

