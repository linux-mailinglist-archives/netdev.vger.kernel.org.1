Return-Path: <netdev+bounces-163759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11736A2B7F0
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC971889308
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D45208A0;
	Fri,  7 Feb 2025 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYe4qkfO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA62D2417E9;
	Fri,  7 Feb 2025 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738891947; cv=none; b=txpwPdkL9eBtrSbmdDpItCLPs5mybOXvES8+6n2Ajgss3l7uQiZY+dc+OOU/wM3aLLUyeefonu8Yg1bv51GjkOeQXxiit7LgCVMcA06AN2qgffr2GcZxMoRHmthLsyIM+SIgvjGbEobBNa0EXOqS+2jGhdZBMuW4eXe7OPLTrpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738891947; c=relaxed/simple;
	bh=T37dtycyJzG6v1jI8BCgWdahQS0XYiAjaqwLUXtcki4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFvhtu2F5VY/JYjZ3O0pzdFHDHvYcpW76ysdT2givbUHpeuzpmP/r6043OL95k/g65IKu5EBFXFVBnoMmFMXqd+ksHMdsPe0/GLUFk3+7Z+K+VpLu/DIIPQJpNmRSFtJwKOjvIVT5KOx3anYaMEUMaNR/+OU4RLecgjKA+m8bUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYe4qkfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5D1C4CEDD;
	Fri,  7 Feb 2025 01:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738891947;
	bh=T37dtycyJzG6v1jI8BCgWdahQS0XYiAjaqwLUXtcki4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LYe4qkfO6HIvZSw2DM88W1S8PZ8t1LeJ+ozVHIwaxOnHYtOHlpLBEtb81dzZqNPEU
	 7Ai+SD2nqQWwV9z93ZQl0j02OBV3NQp2SOASAIbQkICz23qHglfut+LKRPYhOYHrMW
	 vgZuXRHuIhXVARkEl1XmTbEDQXaiXfakZLxJ5vYbQteCdlrERHBY9GMi0ooRItQRSw
	 9mfNZeMALob2hn2lxy3C4F3Soxc+Ank0DPscOUq6cMQav3ysJ3QE94esYVRJ2shnJ8
	 B+l4cZo7DZFzTvDempz9j+C078fIEWY+/FlJupliAEAtmgwfdR2vSmhnGt3+cYIafI
	 thN97dQp81l3g==
Date: Thu, 6 Feb 2025 17:32:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/2] Symmetric OR-XOR RSS hash
Message-ID: <20250206173225.294954e2@kernel.org>
In-Reply-To: <20250205135341.542720-1-gal@nvidia.com>
References: <20250205135341.542720-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 15:53:39 +0200 Gal Pressman wrote:
> Add support for a new type of input_xfrm: Symmetric OR-XOR.
> Symmetric OR-XOR performs hash as follows:
> (SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)
> 
> Configuration is done through ethtool -x/X command.
> For mlx5, the default is already symmetric hash, this patch now exposes
> this to userspace and allows enabling/disabling of the feature.

Please add a selftest (hw-only is fine, netdevsim can't do flow
hashing).
-- 
pw-bot: cr

