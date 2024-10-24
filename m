Return-Path: <netdev+bounces-138635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFADD9AE6D9
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14091C20E9A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D031D9A72;
	Thu, 24 Oct 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4nAz+Hd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A31AF0D0
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729777105; cv=none; b=n7S1yWC8VgYz+6Am4EG/r8H7ZlwZMkSSy+vN0AaJ4eSAZWYoTCqoia4mIcPBnzmxHZbL+KIJRx0uI/DBHCU951f2tjQ/X+zG0s8jJPTCrxNozUqz/PydPSHP0j61pCw9tlTYNv7nkKfc0a1H6QymQYBLIL7Bm7AG5A4ydISu1yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729777105; c=relaxed/simple;
	bh=QBnpfM/L4EpNpMjEeHv+tPD8iPYMSO7qUuIwaT2n3sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/fmlZO/FB4wkYXTHusg5AR09V9J4wQyM3pqFZoOK3kauMi7Igs6QE0yXsf8DmfcxALXbCpl4nQ8sVmYY3xGev+gToGzN3vGwpSZG+DDPGFTCVRcK6w9RVv2si3/tQ7vyLjD98IGODDh35x5SXoBVejumBReRVAhMDZQQ9zgQQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4nAz+Hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E34C4CEC7;
	Thu, 24 Oct 2024 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729777105;
	bh=QBnpfM/L4EpNpMjEeHv+tPD8iPYMSO7qUuIwaT2n3sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i4nAz+HdQMjZJmtPnFVh56xP17NvoZSIXD/+Qz906hIle8kEytwwmpQtt0SoYcRiM
	 gr9Btvi5LHrdN3QWIE9LUEQ/jAL4eXs1coBoK2gu+DIAKMye8bsdoDPy9kptYbSfjS
	 +R1+EsuvgoczqzxMU8ki06tDJLs4LW+MY3LtZceH7vQdbqrV0xrnAGM7kL6krrw8Bo
	 3Ez8RolGo+AwEr6R+sOCZC76yVWyhrK9yhaXSIdvGwQXU5TuNHcc51P65uisvDmfGF
	 TI4we6gztEIbX8WcVSxWww/wLfntyeC9xserlHfkdzT8KgWCpY0Djs1sqLtVhSuEBJ
	 CN6eBdhT3O8wg==
Date: Thu, 24 Oct 2024 14:38:21 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jan Sokolowski <jan.sokolowski@intel.com>
Subject: Re: [PATCH iwl-next v10 2/7] ixgbe: Add support for E610 device
 capabilities detection
Message-ID: <20241024133821.GO1202098@kernel.org>
References: <20241023124358.6967-1-piotr.kwapulinski@intel.com>
 <20241023124358.6967-3-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023124358.6967-3-piotr.kwapulinski@intel.com>

On Wed, Oct 23, 2024 at 02:43:53PM +0200, Piotr Kwapulinski wrote:
> Add low level support for E610 device capabilities detection. The
> capabilities are discovered via the Admin Command Interface. Discover the
> following capabilities:
> - function caps: vmdq, dcb, rss, rx/tx qs, msix, nvm, orom, reset
> - device caps: vsi, fdir, 1588
> - phy caps
> 
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


