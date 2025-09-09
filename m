Return-Path: <netdev+bounces-221378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC916B50596
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E6C168461
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDD52FE058;
	Tue,  9 Sep 2025 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4dUlsZ+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A456146A66
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443889; cv=none; b=kdjiH1IRhPDcqlG4IIlHw1GuPbDgpG/YZAz2/q822bzlXfkn34CEx5wZ4p2OWKseW8kBSF6RbpexUlPCpDDrPhz+VlMdfXz8NcAXmSWBo47YEotwcI+gl1NV6wejfz2fk/05zIljtrB9By9wLKy3SlmgNngSlDuCNRLY/64aeSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443889; c=relaxed/simple;
	bh=rL0GhuYStDM+W7s5meNosmoaEWfpiILntiP13BA37KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bADl/0gCOBjnG1cfR8XNwJYiV/BZgACgur8Q/TGTifRf5Ox9Z1PgIKkJLUOhPxRVF3GrZJFYBBFtsGZkN+XDI2sslOR6SZ8iXM1Q+BuPhFBMKIGQYutkzpX+Nv3gN88FkTUPQErwex2k0H1nN0DCmv88bYlo7odLLArnhJa4+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4dUlsZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB91C4CEF4;
	Tue,  9 Sep 2025 18:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757443888;
	bh=rL0GhuYStDM+W7s5meNosmoaEWfpiILntiP13BA37KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4dUlsZ+CNJj+BeqNzbPbSE8zoaotOs5cRCCYdmVOYTP88/PtNGx7BTINq25g6CMY
	 Gd+B4T13c2/nPRlVL1NcTXKwpOzSEKIi08IVFLgqsapHBdKJqmdGhAH/MGJ7Jt4iOT
	 8rdzIwMdK2PeA1Jh4GxJLQSFg4m/2s2bmzVjt4T1QpcybhcVadqXF6YMOy/KSkOtVM
	 QCALrL935fn7Ix6mkAYoioht5z2n6Z/AgUBIRQdTUtD/SEwcnVFO3icOhwLiluBJfx
	 wnw7rUlPZPxoRCfuK2J5YNKpUBG1ONze/o+QLAvtt6CEc91DdrvN16bn/nAOUvB6R3
	 yCej+JothJbgw==
Date: Tue, 9 Sep 2025 19:51:24 +0100
From: Simon Horman <horms@kernel.org>
To: Kamal Heib <kheib@redhat.com>
Cc: netdev@vger.kernel.org, Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH net v2] octeon_ep: Validate the VF ID
Message-ID: <20250909185124.GD20205@horms.kernel.org>
References: <20250909131020.1397422-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909131020.1397422-1-kheib@redhat.com>

On Tue, Sep 09, 2025 at 09:10:20AM -0400, Kamal Heib wrote:
> Add a helper to validate the VF ID and use it in the VF ndo ops to
> prevent accessing out-of-range entries.
> 
> Without this check, users can run commands such as:
> 
>  # ip link show dev enp135s0
>  2: enp135s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
>     link/ether 00:00:00:01:01:00 brd ff:ff:ff:ff:ff:ff
>     vf 0     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state enable, trust off
>     vf 1     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state enable, trust off
>  # ip link set dev enp135s0 vf 4 mac 00:00:00:00:00:14
>  # echo $?
>  0
> 
> even though VF 4 does not exist, which results in silent success instead
> of returning an error.
> 
> Fixes: 8a241ef9b9b8 ("octeon_ep: add ndo ops for VFs in PF driver")
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
> v2: Address the comments from Michal.

Thanks Kamal,

This looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

For future reference: please allow 24h to elapse between patch revisions.

