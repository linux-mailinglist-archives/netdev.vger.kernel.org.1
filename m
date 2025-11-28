Return-Path: <netdev+bounces-242618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F290BC92EC9
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 19:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91A2334A62E
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 18:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916352BDC34;
	Fri, 28 Nov 2025 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHtxhZCy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68249134AB;
	Fri, 28 Nov 2025 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764355473; cv=none; b=rr8IXp6o3vEgbX/xckeh9um+DjE+8oLlJqM0MEeGQt2n5HtinUhnqtleRS4cA42NCItuF4Q4e1Z9OVirMysMbjyGXfVnFCP4/2HQ16iKXPpyElDQRmMtemSqNjkleJ8Jz7NVDs9zj1n2jdlapr5HTFOy8u5AIc4/ucgKr1xOz0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764355473; c=relaxed/simple;
	bh=Kku4oiBmqT8HaZpKNB9V4YiWk9uu3/VqUtt5DwojzgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lz8qkJniqrtFEOIZ75Hm/d5qVl2o43YB/Qco9USMBzWogdhZILSxbtyIAhkZieM0XL5xZZtVl9YaAuu1p3xezLyMyUx9uqRDUR7RvhByDS1uQt6rhNGkulSUGBpnRz2Js1d4A2J/wYFV7Iqtz1yyOyA7S3UgRocPeR6DKHBVjAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHtxhZCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4345C4CEF1;
	Fri, 28 Nov 2025 18:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764355473;
	bh=Kku4oiBmqT8HaZpKNB9V4YiWk9uu3/VqUtt5DwojzgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iHtxhZCyIfIZmLFoKi5R/XAEhfD44WCJrOICDWP8SsEIA/EEC3M/61VcsBNvyQzpV
	 UIg9B8PjVykbtCkBz2YtLY5TceiNOsHzBZm1X+sPkoSn5BRDeUVshGy8CQieuj9RJW
	 gea09K6BaBuw9N4FkHn2KGqIvV3JEQhe6cc4cp4pRBZqlGKXXgDr+wy79/7tz11UHR
	 SZE0Iw57Detcnxo3aKXptNfpSql/EX7u507yOErsO4sECBuAKBVBbYlI0Vj9kFRLPm
	 PEEKNMM4A0WDB+MORrxzZxkddNwDBxDsKwLrA66R3AJHwYMWfJpD5BPg4LIu8l7/OI
	 MQzVDBoFFpXkg==
Date: Fri, 28 Nov 2025 10:44:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com
Subject: Re: [v3, net-next 00/12] bng_en: enhancements for link, Rx/Tx,
 LRO/TPA & stats
Message-ID: <20251128104431.70ba577b@kernel.org>
In-Reply-To: <CANXQDtYySxN6kcDh3hPAUcFBiu0vDuVX_7mdLSbkKcf562MoWg@mail.gmail.com>
References: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
	<20251127191439.2f665ca0@kernel.org>
	<CANXQDtYySxN6kcDh3hPAUcFBiu0vDuVX_7mdLSbkKcf562MoWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 20:29:47 +0530 Bhargava Chenna Marreddy wrote:
> > On Thu, 27 Nov 2025 01:19:19 +0530 Bhargava Marreddy wrote:  
> > > This series enhances the bng_en driver by adding:
> > > 1. Link query support
> > > 2. Tx support (standard + TSO)
> > > 3. Rx support (standard + LRO/TPA)
> > > 4. ethtool link set/get functionality
> > > 5. Hardware statistics reporting via ethtool S  
> >  
> > >  13 files changed, 5729 insertions(+), 50 deletions(-)  
> >
> > This should be 2 or 3 series, really.  
> 
> We would appreciate it if you could allow this current patch series to
> be accepted for review. We commit to ensuring all future patch series
> submissions will be smaller and more manageable.
> If this is not acceptable, please let us know, and we will rework the
> current series.

current as in v3? Or you'll make v4 similarly humongous?
Look, we're not trying to be difficult. If you keep posting 6kLoC
at a time it will sit in a queue for 3 days each time and probably
reach v20. It is just quicker to get code upstream with smaller
submissions.

There are some very seasoned upstream contributors within Broadcom,
please talk to them?

