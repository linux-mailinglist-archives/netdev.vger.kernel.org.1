Return-Path: <netdev+bounces-112646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5235293A50A
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 19:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAE9283D80
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1F315886C;
	Tue, 23 Jul 2024 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeuiCvQs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263F2158869
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721756206; cv=none; b=mfX7ZWWfdHdD3irJgxedrXkLpWMBK9Mxy5CmoqpPceCUZj4sNltuqdLwWkd4mI/urrucTrGtZO1zscSbPxs65XAR2w7/XcbIcFPG6Y7uqxDkVP8K35t8prsGq46/7VX9V0uzx/mm9rJzbHamoDegpkTqqUKQbHMkkE41L0RSZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721756206; c=relaxed/simple;
	bh=H+pMoN+Pge9UnPXjUoiqgNe05Mi16Mr4ZYtXey/7ksg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1ParJSl6Yj7fxXD0guAGpRAZpzw94ir7lF+Dh2W0qEpiAq458pb7x10iufKcJ0HZLFzRYGMaRT/Raj6h4RgwdXaSPYTXARNbTXzGR4qOjZanreJto6nZFqRQ55EvNwp7s25HFBuRZ7FORDV/pxbsLajvIRficZ7YdvH/Q85jwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeuiCvQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515BEC4AF09;
	Tue, 23 Jul 2024 17:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721756205;
	bh=H+pMoN+Pge9UnPXjUoiqgNe05Mi16Mr4ZYtXey/7ksg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GeuiCvQsKETuh0LR7u9/gwhC2nDqMrQUOtGXhIqFy20w6RhNtYnTAz0cHvTYFoyGs
	 fhm5Vl2FkdEr2DxG7V27GuY/jzRd6HKHOeY20ylqxa4SlKuUCqevca3FoRhUi9KZBF
	 WHqZ6LNvqRzCnskJQUy9LqvSEMvDH3xixHng7i3jeisw+WS/dC4gb+gj7+nuDVA0mB
	 o6sbSK2X5icgSIDN/8YWjzGaBqAG1V7j62P/QI7h949v6llP4vHrBnw7lVYiv7j6uU
	 dCGohY4Nx1n6KUCqwlNOJplCEABKEZRNiDhY9gSa88nc2FWUqfx99xjdCNc5hoC1+w
	 n3YDGUHp7aDmg==
Date: Tue, 23 Jul 2024 10:36:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kamal Heib <kheib@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Ivan Vecera <ivecera@redhat.com>, "David S
 . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH iwl-next v2] i40e: Add support for fw health report
Message-ID: <20240723103644.1fea5124@kernel.org>
In-Reply-To: <20240718181319.145884-1-kheib@redhat.com>
References: <20240718181319.145884-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 14:13:19 -0400 Kamal Heib wrote:
> Add support for reporting fw status via the devlink health report.
> 
> Example:
>  # devlink health show pci/0000:02:00.0 reporter fw
>  pci/0000:02:00.0:
>    reporter fw
>      state healthy error 0 recover 0
>  # devlink health diagnose pci/0000:02:00.0 reporter fw
>  Mode: normal

I'm not sure if health reporter is the right fit, depends on what 
the recovery mode is / does. We need documentation.

