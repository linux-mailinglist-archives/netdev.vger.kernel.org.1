Return-Path: <netdev+bounces-162739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 685D2A27C82
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A34160CA3
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 20:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822CA217660;
	Tue,  4 Feb 2025 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxMYra2H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1571E0087
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699872; cv=none; b=OT196VPB9ciUrwoyXjnDtQ5X0Ni/VpJXAzulY64E7wqgMb4N2iq5PjCPxjkkFehFNo4BFQodY0pd+BWAPQJ0idCVfzbcnrIsG4E6DB7ggsqUrVE/ZP8Jo/TiqFvwovT7Bt9BJRnNt7ZuiHj+rl7OwHq19AzLTV3mO9G72jPjnXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699872; c=relaxed/simple;
	bh=fn7KECgeaEFokVrniGp68GeakWgPDRa7VOMu32zpqRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7Vtk3UU1er7ztAfYpeL8Yf0s87DPuy8i+rK/NMzphXn4HmeZXlAt6R3/vykiVyDj4xzTHr6pBikFlNCVECu9GFpw2GvFGSoB/lyJFi2eEgy4HjbrqaShGVSrTBm/h7rg3PKeREjcxSEHidDnBt+JOl7EvMcGZbrVbc1CL2IOVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxMYra2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F362C4CEDF;
	Tue,  4 Feb 2025 20:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699870;
	bh=fn7KECgeaEFokVrniGp68GeakWgPDRa7VOMu32zpqRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IxMYra2HBjrkqod/mKwUkhu1n3hwnf2vL9SsegCIXmTmidaQG4bS5XKbITgmIGWlN
	 jpL5Balj1q04TVaZvhQic0yIrVnDm1rv08T0/Ck23hLCnMY95j9bTDmqcFGZE+dvYS
	 N7VNyvzp+iAee0B+GcpLJqgY0tmqf19tW1X/etzrVK6ujp7EIcJ+1k2U2Kwm7BVfsh
	 /y1YFAfE7gGtjhW1IxKxkcES58c5VMw1jOG/3XmMdggkMz6dqDTiG6SC0DWoy7rtch
	 46To/7tNs+vihC0J49Vb42xgLZVx8eAcezKn197WkJNiyOguU1b0zrAaDrDrSgsBl1
	 RgdSJA8TveuFQ==
Date: Tue, 4 Feb 2025 20:11:07 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, pmenzel@molgen.mpg.de,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2] ixgbe: add support for thermal sensor event
 reception
Message-ID: <20250204201107.GP234677@kernel.org>
References: <20250204071700.8028-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204071700.8028-1-jedrzej.jagielski@intel.com>

On Tue, Feb 04, 2025 at 08:17:00AM +0100, Jedrzej Jagielski wrote:
> E610 NICs unlike the previous devices utilising ixgbe driver
> are notified in the case of overheatning by the FW ACI event.
> 
> In event of overheat when treshold is exceeded, FW suspends all

A nit flagged by checkpatch.pl --codespell.
In case there is a v3 for some other reason you may want to correct the
spelling of threshold.

> traffic and sends overtemp event to the driver. Then driver
> logs appropriate message and closes the adapter instance.
> The card remains in that state until the platform is rebooted.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

...

