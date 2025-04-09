Return-Path: <netdev+bounces-180723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7751A8243A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B25F18887E3
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE51725E465;
	Wed,  9 Apr 2025 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kQ3VdiaC"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D29725DAF1
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200391; cv=none; b=iBkrNDTLlyhkazCyRNQ3/8X2FSpsIwp++GG7RUsIKISnvWF7f4W1uza2tUHNeGytP/+TCrsxOexR2U5oEjEULHyFkGXv/m+U3n2UIxSKGI86ud/5QTE+lMs91LrgzxIXYp9uue7aay7N1DpqPAmTQQf6IJ+B+bVtv6Jzfb+tQ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200391; c=relaxed/simple;
	bh=o9KXGK3PvYc3GeFSutCjFzzOu06dct2QMCXeJ5li4IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ig4pNp+lpBs17oqBs56FPPgkoGAwTyQpC74ffRBoxZSNPNy8GqseBEJXzHBsnY92GOln+zTcWsmWqVAg7oYZJWY22IV5IcSCkvqgshxN2K2iX16FBGS15pyekstX8TPIk2fZ3G0WOuwzWsRHPePRH6HF934/eH3Zqcqrop2iKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kQ3VdiaC; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E89D1380163;
	Wed,  9 Apr 2025 08:06:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 09 Apr 2025 08:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744200388; x=1744286788; bh=s/+XScN+DX/hI6ZdffBa6gflMtgoXQ6VeTH
	cwMIEqqk=; b=kQ3VdiaCcWaSzeMTAmaAXP+IzHhY4VC7rdP1UtrXwe5zZ4Gk4PC
	aAmyMVrrn0U7U9wUKVhsL8VKBT9e71SAhBzS3UOW5TxzQT0iNUsiwHM3kstErAUB
	QiYKIquOt+r2mh1yf4IoYv5TsX0021Ge84f0lGftF6hMYmsv6bmTsPeXCZwGA3B1
	mC+NVOErppxChvlI1fog2NyY7zov9k0xQ/hqMqY8Ic7hK8i1Og2zLLt4maWkKD25
	zp6sfrysIKJ5oMKnKy/sLMeTOcYyNKRsp0cQu22fHoAAUNMQt7qIDDaPbsYmgbXS
	WLkAdUW4UKnMX5qQX89K2oM2kI12ZfmKmAQ==
X-ME-Sender: <xms:w2L2Zz9p9K_CFb4UmG-rCRInMZ87KjqXs1XsKdx_KYEuWbnfH5ewWA>
    <xme:w2L2Z_uFqXFK6p5-UvfGuFQX613mnQG7JesCQQmaqslXc-acfbPEemriikN07Gz7a
    2NsppgNFxr_jHc>
X-ME-Received: <xmr:w2L2ZxDmUdiXg8tnZF0E7yB702SF5BuD7p0kHv7zFqptYGYVnX0SjLYD2pMp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdehleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifedu
    ieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhthihnrgdrsh
    iirghprghrqdhmuhgulhgrfieslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthho
    pehinhhtvghlqdifihhrvgguqdhlrghnsehlihhsthhsrdhoshhuohhslhdrohhrghdprh
    gtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmihgthhgrlhdrkhhusghirghksehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:w2L2Z_fANOu9qd9HL46WJ86i3MLZ2FK-Uqdl9XzwMYiEyQwBHiGecw>
    <xmx:w2L2Z4PXy9yhE-L9K4px5nzk7jWw_NeZPyuAOeJZ27ab5u2TMfN-Bg>
    <xmx:w2L2ZxkRFe47LzyavREWgo7025jId4KxjNIZQJSahK9SKOFLtrvxxQ>
    <xmx:w2L2ZytP_i_22DYY1Z4UMujCE1PyNiKhQagX1qBEV2w6BIkQ8TFndg>
    <xmx:xGL2Z8aw1HFviLpTJWr6BRM3ZixbN-RZ14AYqtUgIhIVq-WGzSlDoyeV>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 08:06:26 -0400 (EDT)
Date: Wed, 9 Apr 2025 15:06:24 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: Re: [PATCH iwl-next 1/2] ice: add link_down_events statistic
Message-ID: <Z_ZiwNUJy7xGeT8m@shredder>
References: <20250409113622.161379-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250409113622.161379-4-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409113622.161379-4-martyna.szapar-mudlaw@linux.intel.com>

On Wed, Apr 09, 2025 at 01:36:23PM +0200, Martyna Szapar-Mudlaw wrote:
> Introduce a new ethtool statistic to ice driver, `link_down_events`,
> to track the number of times the link transitions from up to down.
> This counter can help diagnose issues related to link stability,
> such as port flapping or unexpected link drops.
> 
> The counter increments when a link-down event occurs and is exposed
> via ethtool stats as `link_down_events.nic`.

Are you aware of commit 9a0f830f8026 ("ethtool: linkstate: add a
statistic for PHY down events")?

Better to report this via the generic counter than a driver-specific
one.

