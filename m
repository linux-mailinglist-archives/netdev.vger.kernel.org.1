Return-Path: <netdev+bounces-178852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 901D1A79353
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041C61886E26
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9FF18B484;
	Wed,  2 Apr 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujsYrf83"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C6215575B
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611853; cv=none; b=ETBOreoGUrSJkoHgFrHM+oXrh+KRpkrwygp067Qh57OwtLcEbFQOaXRFIR8cSN6YmIxOsLgbSnZvEx/DOhj7Hh/bn672MZs5VLov2AhCfoxlKURrZ9nFOXf2dO9Gz0o/KMmPWp2v/Us0xUbaJVY5qUxuCCoBA7KA3nUMHHBQByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611853; c=relaxed/simple;
	bh=FeJQZ6x/C6rNa6jX7GODmmr4tL7W5sikvccp2xr9j/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5qPzrdq2mHY8fj8jXHOMM2CtZNSZ8nXCIq+vq+eQKT0/KlzeM8mmtU9qNlraYOyXC2h8cQanIT3mqA6l3+5VHF+QtrMQ9N0ThPXSfeWcFh26ecKg7nQZ/R8vMhlH8B/mRef1MpzTHm8qbfErDBwdUoM7AAMyZ3DfvhXv1Td72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujsYrf83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33CFC4CEDD;
	Wed,  2 Apr 2025 16:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743611853;
	bh=FeJQZ6x/C6rNa6jX7GODmmr4tL7W5sikvccp2xr9j/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ujsYrf83hmPYBDY+Sv0MYiAHPJeXwMYq6PIif506rY1KUZhgz6sBWqGhQaRLJqxvT
	 cpUXpAOpprQrIwBiqSk98graUPXPblEo5uxyFhz9X5Y7cjNXjPPwh0XEdFe9fwKCx/
	 jwmGRFC3ef8yPaq1IyISivQ8xrBjnM8FChbIDOKdGr3JhJ7SP03XBW8f0za7X0UZMi
	 EnpNkaDKK2Pl1DsDYHh0bEHCoCnyGsxkukZG8ONDA/a1IWoyfM4Et9ZlgV8c+CQaui
	 1LPjzSXXe0zHmDgnDHBgf4WiCdMwDnEtzjCmPiNNeSqV/w/AkmGsH0G+Ji2HjR4rSW
	 Lv+bZYug8/LCA==
Date: Wed, 2 Apr 2025 09:37:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Olech, Milena" <milena.olech@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>, "Dumazet,
 Eric" <edumazet@google.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Kolacinski, Karol"
 <karol.kolacinski@intel.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>,
 "Mina Almasry" <almasrymina@google.com>, "Salin, Samuel"
 <samuel.salin@intel.com>
Subject: Re: [PATCH net-next 04/10] idpf: negotiate PTP capabilities and get
 PTP clock
Message-ID: <20250402093731.1230cff9@kernel.org>
In-Reply-To: <MW4PR11MB588909DAED47807C491FE7C38EAF2@MW4PR11MB5889.namprd11.prod.outlook.com>
References: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
	<20250318161327.2532891-5-anthony.l.nguyen@intel.com>
	<20250325054956.3f62eef8@kernel.org>
	<MW4PR11MB588909DAED47807C491FE7C38EAF2@MW4PR11MB5889.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 15:23:53 +0000 Olech, Milena wrote:
> >So hi is latched when lo is read? Or the timer may wrap between 
> >the reads? Can reads happen in parallel (re-latching hi)?  
> 
> Actually we have HW support to latch both values simultaneously.
> 
> Hi and Lo are latched in idpf_ptp_enable_shtime function, so I will move
> lo right after ptp_read_system_postts.

You may need a lock, too, with two concurrent readers one can "re-latch"
the value for the other?

