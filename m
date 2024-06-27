Return-Path: <netdev+bounces-107184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8224C91A3C2
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38D41C211AB
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CCD13D8A0;
	Thu, 27 Jun 2024 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1tWa1LI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7DD13D281
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484167; cv=none; b=C/yuy1O3JYfiSoZGLvQuzJ1zZ4Civ0j93DLmmET0Ll6mxv2a59aDExseH23upi0VkEeeL+VpN9rygmMOBZp3aV8IJRPVjHd0KlKxy6Evc9r9Pb9f+M5FU8FzCNBlnVyTtyEeUILKWsje6sXn/QkGw8qYokBJ8szvTOTY+dbY91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484167; c=relaxed/simple;
	bh=B6qLxuM0d2P3IdWwCmCeueHLfRQ5hCafTkG1Z8S5GUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9aKeaogopOOQ0xiZivVQSxrUeK/nHqPOhxjgSqVjYSpRR7igOpYuzv+c8m2HmQM3dciGsHvoy4ox9vvwXIgTBrRgt9kiiAOYJ+AvSQk+o/A4LaEWQ5z2iBZK6ep5khQpOcyVJx3PxgNqvj9iE2E3w4rIy+s1RCjU8BSi2k2tbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1tWa1LI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C9AC32786;
	Thu, 27 Jun 2024 10:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719484167;
	bh=B6qLxuM0d2P3IdWwCmCeueHLfRQ5hCafTkG1Z8S5GUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S1tWa1LIsJ2whl8aNX46uMj0ohEv/5SehBNcAO10Hut537l9b+lj5RLx4o/lErS2n
	 BBFOErFdh0oP5YU+YryMquGFHk7yTHhjv6ivYVNY9pk9WIMPLWcvEzhbnS7TUTIPZK
	 wFQCX2QPgKbK8ivimn2yIwCiz6yb7DHYkH82pb6n+vpEw8TKhC3wr6ZkNm6MVq2UKX
	 EBEqzI4L/GJZQ6yiKOz9UtdUpNBjI77f77x3L1IgPKW1XFXyP309yC/JfJawzEFqoo
	 mSFeIkrDvJ7/qy1Y7hKkcTVW9LPDnpfEgUbwZJwZTt2muosc62Gjl6qSLbjlTBv/s8
	 g7jrrA/LWzHUQ==
Date: Thu, 27 Jun 2024 11:29:23 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Wojciech.Drewek@intel.com
Subject: Re: [iwl-next v1] ice: remove eswitch rebuild
Message-ID: <20240627102923.GE3104@kernel.org>
References: <20240624080510.19479-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624080510.19479-1-michal.swiatkowski@linux.intel.com>

On Mon, Jun 24, 2024 at 10:05:10AM +0200, Michal Swiatkowski wrote:
> Since the port representors are added one by one there is no need to do
> eswitch rebuild. Each port representor is detached and attached in VF
> reset path.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


