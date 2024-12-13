Return-Path: <netdev+bounces-151604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C38439F02E1
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 04:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB4B168823
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 03:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205D141A84;
	Fri, 13 Dec 2024 03:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMuLxnBA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF88C374FF
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 03:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734058883; cv=none; b=bZGrx97Z1iGrHBm6p37YX+Jazxgo4UzFZMySJRvGlMvXPPTQhUUxtpNf7QTFqHcWuIiEypqOAFDLpGA41k2QpfmR6kVvYCwM5fY4MsFmRUBvcaL2k7i9w0h5ZMxo52BnUe1yJvDt0g5m+ZPa5D7ogqnUsFRJ01V4qG5Ok4r7R2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734058883; c=relaxed/simple;
	bh=MRm60W4ryT5no9UD4xnbl7Y/FHEeR6z/yMt1/6+E5U8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/E9x0R83wIHv2Ih1iPFUiDZU9rmfa1hTEXxD+r6HyII+STzTTkkvc3fGZJiyDa8+DCVRqAxDDL56zaHMvX7u+YrHTfWaPD2xeB3C1BicAG5KJWrt4qYipQdnnblYVZdtCg5ZiT32NyzrFAbhu9lNhTJhty2LmQqllWGhI4QkhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMuLxnBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A26C4CECE;
	Fri, 13 Dec 2024 03:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734058882;
	bh=MRm60W4ryT5no9UD4xnbl7Y/FHEeR6z/yMt1/6+E5U8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lMuLxnBArQbNgaIRlm8oUR8aCYRMYnJTURYOmCLahIJUCPP0bK5lUF7hceupxZ//l
	 erocnWgSJz2pVQFMFnTZ2NrHAhWTsF7PLrbRfWw+G4zer6/7g2KHMQA2NDBQ7UmUS2
	 WffpvTZ05vTN6rP/lFWcUg1WkhDlyekMFQ5pGlKMos9D4CGjA/YcnrY6b9p2vXb5HC
	 7mzYSDxuFpXotg8VG55jbb155Q0zkAjtIe/BnZe9AOoO1BKWkmZJuK6oAsvLgyz9NI
	 cxEz1M89MFiywTrUYHYr3y8MEy7mrXsmwHt90rquVAK2VlAnApaUjp/09Vd4C0z6Q7
	 p3Gm71cHqxtFA==
Date: Thu, 12 Dec 2024 19:01:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, wojciech.drewek@intel.com,
 mateusz.polchlopek@intel.com, joe@perches.com, horms@kernel.org,
 jiri@resnulli.us, apw@canonical.com, lukas.bulwahn@gmail.com,
 dwaipayanray1@gmail.com
Subject: Re: [PATCH net-next 1/7] checkpatch: don't complain on _Generic()
 use
Message-ID: <20241212190120.0b53569e@kernel.org>
In-Reply-To: <20241211223231.397203-2-anthony.l.nguyen@intel.com>
References: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
	<20241211223231.397203-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 14:32:09 -0800 Tony Nguyen wrote:
> Improve CamelCase recognition logic to avoid reporting on
>  _Generic() use.
> 
> Other C keywords, such as _Bool, are intentionally omitted, as those
> should be rather avoided in new source code.

You're probably better off separating this out, we can't apply without
Joe's Ack. I'm not sure what the latency for that will be.

