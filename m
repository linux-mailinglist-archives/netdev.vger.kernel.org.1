Return-Path: <netdev+bounces-21017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BA37622AF
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B016E1C20F80
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD2A26B0D;
	Tue, 25 Jul 2023 19:52:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49806263DB
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97292C433C8;
	Tue, 25 Jul 2023 19:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690314728;
	bh=XZgxjbZNq0MP0RMfcV+VzYH+0OZv78FM95RXeuhNOVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jj8w92J12bzFsLv3jWv83HRB/fCuEMaNmYEaPRdFaq4ifCPReOftNb+uLH8XjuBxJ
	 /hL8zDqM6rXcmZgd094Lwdo2uNWwN5OGimgI+kwskQD/PAPlDUrOpP8IjwpEOBTpQz
	 Lx2sjvI7aRbI2EmL8/u2BwwRtI+hsqfZcnEveRDwor2UTLJJ8Gjyl/PiNQlYWa/CrB
	 wfiI7kjplfF2dbFjyE/jHlMApUUTCoZUOA66DjjJe2RtuSxzndbkqFESmt0bDgtYCX
	 PYI+jo//FJx5lgkAplvJ9AZZov31DsSbfy+YxJfbBRrTMjU2MeJnYB+FUaCoCijTYW
	 GMS+KCujos7hw==
Date: Tue, 25 Jul 2023 12:52:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: krzk@kernel.org, joe@perches.com, geert@linux-m68k.org,
 netdev@vger.kernel.org, workflows@vger.kernel.org,
 mario.limonciello@amd.com
Subject: Re: [PATCH] scripts: checkpatch: steer people away from using file
 paths
Message-ID: <20230725125207.73387bfc@kernel.org>
In-Reply-To: <2023072507-smugness-landslide-bd42@gregkh>
References: <b6ab3c25-eab8-5573-f6e5-8415222439cd@kernel.org>
	<20230725155926.2775416-1-kuba@kernel.org>
	<2023072555-stamina-hurray-b95c@gregkh>
	<20230725101051.7287d7cf@kernel.org>
	<2023072507-smugness-landslide-bd42@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 19:25:09 +0200 Greg KH wrote:
> I do:
> 	- git format-patch to generate the patch series.
> 	- run the generate_cc_list script which creates XXXX.info files
> 	  (the XXXX being the patch number) that contain the
> 	  people/lists to cc: on the patch
> 	- git rebase -i on the patch series and edit the changelog
> 	  description and paste in the XXXX.info file for that specific
> 	  patch.
> 
> Yeah, it's a lot of manual steps, I should use b4 for it, one of these
> days...

Oh, neat! I do a similar thing. Modulo the number of steps:

  git rebase --exec './ccer.py --inline'

I was wondering if I was the only one who pastes the Cc: person
into the patch, because I'd love to teach get_maintainer to do
the --inline thing, instead of carrying my own wrapper...

