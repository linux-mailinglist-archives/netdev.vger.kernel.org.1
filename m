Return-Path: <netdev+bounces-166632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C0AA36A88
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 02:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E7A3B241A
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 01:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25068158D8B;
	Sat, 15 Feb 2025 01:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj+dSu/L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE320FC0A;
	Sat, 15 Feb 2025 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739581342; cv=none; b=QkDoqFdO6MRcatnYXNSSV0azN0onR49fzDZVwV8gSIUtC2f91UWoenWHhsEXRBQ96+UZlqtYzTtkpZb0kMsko8sARWQKQ4RzJ6yVvw6+++VeeJnyb4jELLrdJEyVgsAVI29ma58F9UmZMzgwW0peZjSYFR/r/N/rI/aSvR/o0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739581342; c=relaxed/simple;
	bh=jD3vIxzSn+E0GmRd+AprFuB8a1MmVN+5PvIZoSzEfLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhX7VfNz36x0KlFcDZICFsK0lZIS9JgdL+jwQ4BbVbTbyBK1FHEB9zfWjepOXKQUJ4aRv44NPPq+J22wpjFGiz7DLX/tisy4z24g+c6jgDdqJDm4lWlJEcHsz5zobljnRCxAvlKeDCjfGCZdEyVFyEzCWYL9pi/c0Sl6HKlAxFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj+dSu/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4BAC4CED1;
	Sat, 15 Feb 2025 01:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739581341;
	bh=jD3vIxzSn+E0GmRd+AprFuB8a1MmVN+5PvIZoSzEfLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oj+dSu/LHsTOrcdYE0u2sUF91jmDKv3gaxWBll+AXbZQIueh9QuhVeoEZqnvJ1AuC
	 t4nc4o4grG2t98aXp5NnXh4GwVKxowATLKe9OF5gF0nXvMtq8kJazoUGn2O9SRoogU
	 fd5jcNAJRuQoh1BuzqnfpatXzglUMRpWnLCMJewUpS54fhUt4uRK3kKge7NxY6t1LB
	 7xw44hHdyh9ejbdafHeNbjIq6kLv7Ei5LbZpn6OzX2DnLVir0MZRemRgeWh1mbRETs
	 KP1tZyDKFsMiDluUZ3TKA4gdDV6ycFLqM+wf6DtePN8xPYzyY/jc+krFTumbf+OxpT
	 vT/I4U6879chw==
Date: Fri, 14 Feb 2025 17:02:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: parvathi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
 ssantosh@kernel.org, richardcochran@gmail.com, basharath@couthit.com,
 schnelle@linux.ibm.com, diogo.ivo@siemens.com, m-karicheri2@ti.com,
 horms@kernel.org, jacob.e.keller@intel.com, m-malladi@ti.com,
 javier.carrasco.cruz@gmail.com, afd@ti.com, s-anna@ti.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, pratheesh@ti.com,
 prajith@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
 rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next v3 00/10] PRU-ICSSM Ethernet Driver
Message-ID: <20250214170219.22730c3b@kernel.org>
In-Reply-To: <20250214054702.1073139-1-parvathi@couthit.com>
References: <20250214054702.1073139-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 11:16:52 +0530 parvathi wrote:
> The Programmable Real-Time Unit Industrial Communication Sub-system (PRU-ICSS)
> is available on the TI SOCs in two flavors: Gigabit ICSS (ICSSG) and the older
> Megabit ICSS (ICSSM).

Every individual patch must build cleanly with W=1.
Otherwise doing git bisections is a miserable experience.
-- 
pw-bot: cr

