Return-Path: <netdev+bounces-187821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24230AA9C27
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 21:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B107A3B0219
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8121B4F0F;
	Mon,  5 May 2025 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig2cPnz4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B3D19CC22
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471729; cv=none; b=ZxBGmZHt3YG2ez7uoD8sFMJ9IH/5JVGjoguWncGXxu1SGL5n5/1puelHL7x3Ef5D7CIjqweMmg4o1tpNvYDUEqz+vtP8Hsys3PJjOjXCKQxYNlIu0JoHO8xh+DltVeOWC+0AiXbu7ReuzFDDLZ5SpdbYrilHiTyuRp+OKHGIGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471729; c=relaxed/simple;
	bh=AmrH7VJqWFOCDVUlzd957pxfPstnGaBqIJz/aHznwKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiTUYsnVNPGaODUYinVfBklYGPh9MFtLksPT5yAgbAAzCHv2JWJ9SM1a+E4emOwLmtkCwaU4Tra3Y4y+0wQQ8ie0UR3vtRDKHEnqCNKwelaHJX/7vwHRcLKSw0/cG+dRSYfY7UDqjyfeIZaEI4xR03F0TeeQVQYUAZXl2ZHSEDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig2cPnz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895C5C4CEE4;
	Mon,  5 May 2025 19:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746471728;
	bh=AmrH7VJqWFOCDVUlzd957pxfPstnGaBqIJz/aHznwKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ig2cPnz4nor/2WwSFFgvWMdkpFWhQWLkQf182jqqtwC1mODApUIrxKzzwt/AFS/xm
	 tGtldfqd1F/1j0aA+duGNMj4zwyxh6BCYYncyX5V1G73i8/lxvA5A8Q7/SOKAXAJB+
	 djJSfloX3BC9dwgCIP3EugzZ0rEGjT/x+73T/T/hO1iiDlzR6FjYjHJ5wlaQejsduv
	 TPYRFzCFnnO3gzt+fgEI5D/1qNqjv8YvNaqB80Cvy1bFQQOHHS7VnG8BOX/rBYb8A9
	 fJeRpjO4KRjBSYc/qpglnUhLsyhiAgLDO4AmKdXxd9fjLdyC6Nh9sw62Xv2J3Zt/Bc
	 ZLFJOzSSIcrUA==
Date: Mon, 5 May 2025 12:02:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Olech, Milena" <milena.olech@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Keller, Jacob E"
 <jacob.e.keller@intel.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v2 00/11][pull request] idpf: add initial PTP
 support
Message-ID: <20250505120207.704c945f@kernel.org>
In-Reply-To: <MW4PR11MB588916A3C03165E0D21B73528E8E2@MW4PR11MB5889.namprd11.prod.outlook.com>
References: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
	<20250428173906.37441022@kernel.org>
	<17fe4f5a-d9ad-41bc-b43a-71cbdab53eea@intel.com>
	<20250429145229.67ee90ea@kernel.org>
	<MW4PR11MB588916A3C03165E0D21B73528E8E2@MW4PR11MB5889.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 May 2025 17:20:11 +0000 Olech, Milena wrote:
> >Right, nothing too obvious, maybe cross timestmaping. But it takes 
> >me 30min to just read the code, before I start finding bugs I have 
> >to switch to doing something else:(
> >
> >It's not a deal breaker, but I keep trickling in review comments 2 
> >at a time, please don't blame me, I'm doing my best :)
> >  
> 
> To have fully-functional PTP support we'd need clock configuration +
> Tx/Rx timestamping, so it will be challenging to remove something
> logically :<
> 
> The only ideas that come to my mind are:

No strong preference, but

> - Remove tstamp statistics and create a separate patch for that

yes

> - Split PTP clock configuration (1) and Tx/Rx timestamping (2)

no

