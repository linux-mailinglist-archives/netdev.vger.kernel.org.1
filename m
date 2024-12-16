Return-Path: <netdev+bounces-152268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C209F34FC
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D7E1884CA7
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E598B148FF0;
	Mon, 16 Dec 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvCiA1bj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11BC53E23
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364385; cv=none; b=rjQurcZ5xaRjGDsNSyQ7LA849T9WqwQT6jvcbtYS9ca/yMNlxwLmCMBGjfLt94sbKidciZiDqk3/tieGEi/1mRSVNmKo/kfi3g99EV2KmI5fjcs8l8cYwPWajQ+xA1g5sBA1oQnFzBSLuq+PWT28f0r+OGzGcQGbljZC8bzJ3q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364385; c=relaxed/simple;
	bh=RxQ5nfW10d9HJJNLnfBJcNktaH03+dvNMHOBKk4AhkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krJ7Oug4WotzoZ0Vg2pLCsbR92KKjo9QdMlJrFEBJWAI3/UT1b/DWwFvcsXtf3NLp2h5dlmvNZvluCIkiW0R4CAHhO7cKn48B/ZauTRVn4a9bLxSRKyVpNRnDTs9pMwOoltuUQu3KDdpXVT0i0+tsCH6SKHYjGMLNA14tzROeFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvCiA1bj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9308C4CED0;
	Mon, 16 Dec 2024 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734364385;
	bh=RxQ5nfW10d9HJJNLnfBJcNktaH03+dvNMHOBKk4AhkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GvCiA1bjVl0Kkn8m6XL3MOqUPh/5P/UOdcd1ie3DWV+Tz5WBk2uN0Hx4OdPb/YAqo
	 3MVla1rknCU6x6liFpx60F5PzgMRFqBSS9EkzWD2iMvD/fomL+MISB1acpPEN9fFON
	 eJWhKsy9a71L2XDPE+SvtiOY4quFltD87Uw97U2vbuYVgnmIzHlZKaYrxHjsbhMBn6
	 ZBUOgmHAyHhXN1rLo9EfzI7jzO1pDrDwFFPvca3/RwYsadbciaLA1BTJUl1Is8aVuu
	 /BPB36SMxhCwIhYfBTW50pikXnPfKYfOGnubAGHfJRcx3qMN4M5jbqobDMI5cG7qfN
	 XI1hBvpmvXT2g==
Date: Mon, 16 Dec 2024 07:53:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>,
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, <horms@kernel.org>,
 <jiri@resnulli.us>, <stephen@networkplumber.org>,
 <anthony.l.nguyen@intel.com>, <jacob.e.keller@intel.com>,
 <intel-wired-lan@lists.osuosl.org>
Subject: Re: [RFC 0/1] Proposal for new devlink command to enforce firmware
 security
Message-ID: <20241216075303.7667c1a1@kernel.org>
In-Reply-To: <30e3c7e7-c621-40b9-844c-d218fb3e9f2c@intel.com>
References: <20241209131450.137317-2-martyna.szapar-mudlaw@linux.intel.com>
	<20241209153600.27bd07e1@kernel.org>
	<b3b23f47-96d0-4cdc-a6fd-f7dd58a5d3c6@linux.intel.com>
	<20241211181147.09b4f8f3@kernel.org>
	<30e3c7e7-c621-40b9-844c-d218fb3e9f2c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 16:09:12 +0100 Przemek Kitszel wrote:
> > Please point me to relevant standard that supports locking in security
> > revision as an action separate from FW update, and over an insecure
> > channel.
> > 
> > If you can't find one, please let's not revisit this conversation.  
> 
> It's not standard, just the design for our e810 (e82x?) FW, but we could 
> achieve the goal in one step, while preserving the opt-out mechanism for
> those unwilling customers. I think that this will allow at least some
> customers to prevent possibility of running a known-to-be-bad FW
> (prior to opening given server to the world).
> 
> We could simply add DEVLINK_FLASH_OVERWRITE_MIN_VERSION (*) flag for the
> single-step flash update [1], and do the update AND bump our "minsrev"
> in one step.
> The worst that could happen, is that customer will get some newer
> version of the firmware (but a one released by Intel).
> We preserve the simplicity of one .bin file with that too.

Please explain to me how this will all fit into the existing standards
like SPDM. Please take security seriously.. this is not just another
knob. How will attestation of the fact that someone flipped the knob
work?

A much better workaround would be for you to build multiple FW images
and give customers an image which locks in the min version and one
which doesn't.

