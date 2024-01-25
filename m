Return-Path: <netdev+bounces-65869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26E483C17E
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 13:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8611C1F267B8
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 12:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F58446A0;
	Thu, 25 Jan 2024 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/rv7L1A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE24C4EB24
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183954; cv=none; b=Rzn7qbdAByPPG6cST+d497tEiEuBX3IBFL5Yddq3ozu4hq5y9wZjgTy32H3QayU5qNoGvTfEA9NbK+nbbKkjk+L0C8mEodkUlKLPwGKBHjib2gUbVJa769ivaMut93SisQSKFquRj42SYoQLzjlvEIb/Y61fR8yUMChE8gnyQhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183954; c=relaxed/simple;
	bh=sy9jnTnu4ekf4cfjw+OBOmGCKjYTwRsNcuaX3R73FmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfE9hUSLfqunYZ1+91IF4eiOQ6srYTbtSWAkKi1p4vKOGdtqE8Uskj0vUpCJZSPj4dTd/V7mrK899N8zAY+UG7tUoQDZcwNg1bSavF9O40HUZXRL3aDY+1aYVsgGnD6+CVLhBG+IIvVR2PN1rlVKTjgkK8c9P6+gHPnyUavYQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/rv7L1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01821C433F1;
	Thu, 25 Jan 2024 11:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706183954;
	bh=sy9jnTnu4ekf4cfjw+OBOmGCKjYTwRsNcuaX3R73FmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/rv7L1Apr8g+uThWhZEKLyRt2GAuF/PcPSkIfAGWW2iBBScM51/2blHe7ofrnDuf
	 MGLwfH4SSvWcjaczDA833/I/kzmiO7XD1TjlJDK6uHTX0Y6GDDILW5qOCRe05FaJXe
	 JPjM2DjXBWtAsgSqkrZnJ3QD38ga732MLPVUSdOXlWi5id6aNapzgR8SSIlC+bFiWj
	 JYOET5vYHIedEP/RED6XhcTRlicUowSNaBTkN3Rx3PfzcxXrisBtcCOWRfWG3Zbt2r
	 nfzwbhSuFRcsYOLeSPHP9bYc4uIqfG/4FTin4Aae+DjaDgEvBWy5aNMn1FladJ5bHO
	 Kr4M6MrIDnvdA==
Date: Thu, 25 Jan 2024 11:59:09 +0000
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 iwl-next 2/3] igc: Use netdev printing functions for
 flex filters
Message-ID: <20240125115909.GK217708@kernel.org>
References: <20240124085532.58841-1-kurt@linutronix.de>
 <20240124085532.58841-3-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124085532.58841-3-kurt@linutronix.de>

On Wed, Jan 24, 2024 at 09:55:31AM +0100, Kurt Kanzenbach wrote:
> All igc filter implementations use netdev_*() printing functions except for
> the flex filters. Unify it.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


