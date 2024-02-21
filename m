Return-Path: <netdev+bounces-73845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6312385ED18
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 00:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63FF283BFB
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 23:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0D8128824;
	Wed, 21 Feb 2024 23:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWJviSid"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F64126F00
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 23:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558687; cv=none; b=Mck3QYOF5YojDnF8FsLPtmXNCrNsDw2LE1L5TsoOaVOOre/+rnYwXVrEaN/g7iTOwfA9UD0SxQslFkeDJoK9w/8ykP6JydAjlnR2nbkmbXWQ04Iqiz7bEchE5o1pe4mPAcmYuR1GaVyZo8HZM7qQBPTU67CR0gM11fWJzVpz22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558687; c=relaxed/simple;
	bh=2QrUFdv9xHtNdIxwF2NAF1ID/1pi4TfXta05K36OQos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFcfw/IyoG0U9KNmA0uH9TV/N2aXCMexr3z0z1ET09ca7h41srnE+hQ7qjC/DQTsVWX5X+6SjNgZK7OEXBdKoKM+Tv5VpBDZWN8QHdCNb+vBGipA1zPi6by5lokPvapNBATIFJfirCK9d1YVHKNOF5PeEOsqKOEotapZcmav9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWJviSid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D42C433F1;
	Wed, 21 Feb 2024 23:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708558687;
	bh=2QrUFdv9xHtNdIxwF2NAF1ID/1pi4TfXta05K36OQos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BWJviSidnR8R0G4NLdwmejlYiJ998b7XbMOBADJz8ac/lXte32lHpVylJ26wrKgbZ
	 r+xH/ocxJ+S2B1CgzEWhGlJvAjJTBQlD4eXvjLDyL84y6IrEdHl7zJhoVqFRZyn6y0
	 SVleTCFFDDBlT7VyatPkhFCMoQ06MU2w9oRclrjnBqOrmXudWNGtOMqHMiXhy6zUZy
	 UxeiKbhxMKmI9olSsf3xXzp1cVr0vlCzw2mDZp305g7exKdojPnOk9/18ETiCdMUYg
	 BVD9QSHV0+5Lvc5AG9JbyuPeflqoX9MBmdMWqlpjF4wyJc7oAU0YMuFWyienWLxlEe
	 bCZ2FKoeoTedQ==
Date: Wed, 21 Feb 2024 15:38:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, horms@kernel.org,
 przemyslaw.kitszel@intel.com, Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Add
 tx_scheduling_layers devlink param
Message-ID: <20240221153805.20fbaf47@kernel.org>
In-Reply-To: <ZdNLkJm2qr1kZCis@nanopsycho>
References: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
	<20240219100555.7220-5-mateusz.polchlopek@intel.com>
	<ZdNLkJm2qr1kZCis@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 13:37:36 +0100 Jiri Pirko wrote:
> >devlink dev param show pci/0000:4b:00.0 name tx_scheduling_layers
> >pci/0000:4b:00.0:
> >  name tx_scheduling_layers type driver-specific
> >    values:
> >      cmode permanent value 9
> >
> >Set:
> >devlink dev param set pci/0000:4b:00.0 name tx_scheduling_layers value 5
> >cmode permanent  

It's been almost a year since v1 was posted, could you iterate quicker? :( 

> This is kind of proprietary param similar to number of which were shot
> down for mlx5 in past. Jakub?

I remain somewhat confused about what this does.
Specifically IIUC the problem is that the radix of each node is
limited, so we need to start creating multi-layer hierarchies 
if we want a higher radix. Or in the "5-layer mode" the radix 
is automatically higher?

