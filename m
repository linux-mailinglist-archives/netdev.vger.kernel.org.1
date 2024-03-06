Return-Path: <netdev+bounces-77731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721F8872CCA
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 03:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 991D5B21BE3
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 02:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14721635;
	Wed,  6 Mar 2024 02:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daaYGYv2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C7D173
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709692251; cv=none; b=N4F7YWjkSd+QDJef6tLBoCchEd2W3MClfzygW6Xd0jGnBja4OnK+/vK8lusdhfxkwvuwhee1wEuS8yTf53e3LeIk6hA3dKXImq9ubc6SQfKMiqH2Zw6Q49HmKU7X7YqTrWN8m8WSU7Oe6AWPMJylO4k0F5O/z0fKK5Ohs0TIzqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709692251; c=relaxed/simple;
	bh=R+uL8e+mJVmN5pFIMXNgq5buQ772ZpGqW/x7kVkjtl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eX1NWkWE4T3UCg+Zm6REh/orcpgbse9EKhL3x7u2EU8sRjeR0HgaL6N5ZsqM33DJD7gHNrognvsWCBhVaa1ZCJAnvpPFQRycCro2la96d4tCA/2pD8rvOkhVoNwPlxqnyrHKlVT10UhqvEawS/hmxuZtWneyo5Qp3WFsiB1UlXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daaYGYv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25890C433C7;
	Wed,  6 Mar 2024 02:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709692250;
	bh=R+uL8e+mJVmN5pFIMXNgq5buQ772ZpGqW/x7kVkjtl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=daaYGYv2uVLAtrRPBfJthUUtRMwABl4HhBzNCpbBI3HK8HUValZ+NOOrFVKRQoptK
	 bFTSfGFeFWbyxFEEw9IebYbBLPWnf7OvWSVFt8ma0rx4qaSmDQWpGPYbWw6hVFwr7f
	 kqxd+pP3BaUwMEQyVMxQyVz7X6MJ1y7zfdgvm4zb1Ek8hocKuKVnRmOT9nA/QsCqcG
	 x1wg4NW+8TesVsNaDO3KexQRaMWh/m6vg+j4GA7Qc9YO+XR2AcUk8wO+FOyMEswRI+
	 HzczbN6RIU6hUCGYQkD6fkMkBlkAA06drBffO8CZt7cSsiinl8nqgiMUxHa2GiEnlg
	 gA/sdRLo2wgYw==
Date: Tue, 5 Mar 2024 18:30:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: William Tu <witu@nvidia.com>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com,
 tariqt@nvidia.com, yossiku@nvidia.com
Subject: Re: [PATCH RFC v2 net-next 1/2] devlink: Add shared descriptor
 eswitch attr
Message-ID: <20240305183049.2f2b8490@kernel.org>
In-Reply-To: <49a53cb9-e04d-4afa-86e8-15b975741e4d@nvidia.com>
References: <20240301011119.3267-1-witu@nvidia.com>
	<20240304203758.2fd0f6be@kernel.org>
	<49a53cb9-e04d-4afa-86e8-15b975741e4d@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Mar 2024 16:27:50 -0800 William Tu wrote:
> > Can we use bytes as the unit? Like the page pool. Descriptors don't
> > mean much to the user.  
> But how about the unit size? do we assume unit size = 1 page?
> so page pool has
> order: 2^order pages on allocation
> pool_size: size of ptr_ring
> 
> How about we assume that order is 0, and let user set pool_size (number 
> of page-size entries).

Do you mean because the user doesn't know the granularity,
e.g. we can't allocate 12345 bytes most likely?

For shared buffer (the switch buffer configuration API)
we report cell size IIRC. In ethtool a lot of drivers just
round up to whatever they support. We could also treat 
the user-configured value as "upper bound" and effectively
round down but keep what the user configured exactly, when
they read back. I like the last one the most, if it makes sense.

> > Do we need this knob?
> > Can we not assume that shared-pool-count == 0 means disabled?  
> do you mean assume or not assume?

Sorry for the double negation (:

> I guess you mean assume, so use "shared-pool-count == 0" to indicate 
> disable?
> That will also work so we only need to introduce 1 attribute.

SG!

