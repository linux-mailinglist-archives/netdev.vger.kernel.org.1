Return-Path: <netdev+bounces-79839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4666B87BB5E
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 11:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35AA1F217A8
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 10:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A115A0F9;
	Thu, 14 Mar 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r+HbErt/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zo7EGD0L"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D15A0F8
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412549; cv=none; b=Vz5zDBuauw2WzRt1FmiY3jkPhgwr6F+UQ5KkxR3D+ZF6HR3CDhKjV6ZXjcSfvgCedXmW7r2GhdBFXGdxpEGZ3uIzhbQjy7CZXH79WA3RT6m+AEwfqnoAjr2MADiUWz4klScMKOhPpOLp4E5AfPC7OAM/CQb+Aub/y/I4YMvVyqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412549; c=relaxed/simple;
	bh=QWKX+IhAuTZ7aiXvz7zXh6RN8U1KrMJ2pSNff8V6+Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXtDeLo/+sznTG1Oobd1Wae0oLu6OGIxBH2clZFW4NfO7FG4S2K7SSdccWCrAAEZ09GF8AegLYrBWDeTNxJH6GmbZhXBVw83H4dEY41xtDBOMYnUhhkD+MmiH5bZ73c4v0w8/IX1+qyM0oPVoYeGUtqwxIlqlfsB6yGNePwTyWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r+HbErt/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zo7EGD0L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Mar 2024 11:35:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710412546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0OL4LzRBFl80pfUqgwbmr9DML9X2re08EQDheZVyXs8=;
	b=r+HbErt/F+5Gy8G53OnnF6CbJ72Yan3ossy7LKaGnU5DkTJ1TgrXsSrb3PMb4m4N7QWmFb
	dJATEIE8EZdz1VjVVGXcb7TBEps7ycRpDFILGPtiQMd+rv4o8i8MvTEP/WL+Di913oDGIx
	RHUggNgw9XbvWQImP6fOb7ZogmGswHbaWRYwCwCHkAmru2JFsmmqTrcCiOzudfFc1acCH4
	vKC4MfZslrpTnOumkZETpKYpJBcG84U49TlG2bUdh6PpXKRZlx9pODB5FjhjJQ6OUwcKVl
	PcgVdUM+M6JwWLkxFsAVMEVz5JjuRx+PRbvE7Wy0mBD8gI9kC9buyh/9KCTn5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710412546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0OL4LzRBFl80pfUqgwbmr9DML9X2re08EQDheZVyXs8=;
	b=Zo7EGD0L2JlZp/xDGcf7aSMkWDJGphoZ5Q2pD49k2TQCix70rv5pLjW9tYtuZiCVC4+5v2
	6H8IpOplKfyWw8Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net] igc: Remove stale comment about Tx timestamping
Message-ID: <20240314103545.Ljj-g-iS@linutronix.de>
References: <20240313-igc_txts_comment-v1-1-4e8438739323@linutronix.de>
 <d87f0752-a7ea-45b6-9a79-aac0c6cac882@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d87f0752-a7ea-45b6-9a79-aac0c6cac882@intel.com>

On 2024-03-14 11:21:38 [+0100], Przemek Kitszel wrote:
> On 3/13/24 14:03, Kurt Kanzenbach wrote:
> > The initial igc Tx timestamping implementation used only one register for
> > retrieving Tx timestamps. Commit 3ed247e78911 ("igc: Add support for
> > multiple in-flight TX timestamps") added support for utilizing all four of
> > them e.g., for multiple domain support. Remove the stale comment/FIXME.
> > 
> > Fixes: 3ed247e78911 ("igc: Add support for multiple in-flight TX timestamps")
> 
> I would remove fixes tag (but keep the mention in commit msg).
> And I would also target it to iwl-next when the window will open.
> 
> Rationale: it's really not a fix.

It is a fix as it removes something that is not accurate. But it only
changes a comment so it has not outcome in the binary. I think what you
mean is that you wish that it will not be backported stable. Still
people reading the code of a v6.6 kernel might get confused.

Sebastian

