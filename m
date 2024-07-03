Return-Path: <netdev+bounces-109011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15CD9267FF
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3D41C23DD0
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1CA186280;
	Wed,  3 Jul 2024 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fof1Voig"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AA3185094
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030865; cv=none; b=jBfqE8uWbTOlklskC3Rjrat7gjHQjbpJfyUttEEfkWoYUWXEJfqYC0Cg+jayQQu11eGxa+agtTCQbtjo1aT5JjYWYxeAR7W+7T6yUWbne9Ko71H6kLiH2kTUm9DHmH4xWviFfujsz0nuEB8bxTSjS6ALXfMg4kBYebwRRY4VONA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030865; c=relaxed/simple;
	bh=3GiRg29ujFKE1CNfe0zyxkAbK+5xSflcOI0SqIJVCjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdrQDncdMzom52HgcezSTsNyG01OixxIjCsd9lAF4WSw1qB4CQlExdPK9FKab7owxFrD1Yl9nsfm7D95aPqhBS5WTbORADnpDFk6E+z7pGMK3d0zGrz47XC3+IFrwLdD3a7AFXz5xtN8vEMNSde/L0eGUKiaL0mv9ZAdU1ZHp2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fof1Voig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D89C2BD10;
	Wed,  3 Jul 2024 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720030865;
	bh=3GiRg29ujFKE1CNfe0zyxkAbK+5xSflcOI0SqIJVCjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fof1Voigq/oBCaxud6rX+sCivRgt0gkoKbE306aJJNGNnbzdZap1HMLLAnCX8Qe2s
	 9eqSb6nIBHYiHSGJAcVYzA7L8Fk+//GPtRvkHL4XFK9Ze1iqf/cjditL4ARjx3JgSa
	 lUQu5FKhDc3VSJx2usfZ0sbCxJdVLJiPZKaPZ/yFC6FlW7MGrKw1Y5yT+c7xD2hLCa
	 koS7npGgMSclgGA7sdjjPf6y7rOhohEWjf56SPfxDowZB7KVImpHLoQWHFhBnti+wM
	 TN1brjMW7OJu1Wmu7KdsMpyho0xpNw3BLEADBADxpo3rpCw9eT/82Eku1Gnjy8lDvd
	 lIX112NI0CThQ==
Date: Wed, 3 Jul 2024 19:21:01 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Yochai Hagvi <yochai.hagvi@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH v2 iwl-next 6/7] ice: Read SDP section from NVM for pin
 definitions
Message-ID: <20240703182101.GO598357@kernel.org>
References: <20240702134448.132374-9-karol.kolacinski@intel.com>
 <20240702134448.132374-15-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702134448.132374-15-karol.kolacinski@intel.com>

On Tue, Jul 02, 2024 at 03:41:35PM +0200, Karol Kolacinski wrote:
> From: Yochai Hagvi <yochai.hagvi@intel.com>
> 
> PTP pins assignment and their related SDPs (Software Definable Pins) are
> currently hardcoded.
> Fix that by reading NVM section instead on products supporting this,
> which are E810 products.
> If SDP section is not defined in NVM, the driver continues to use the
> hardcoded table.
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Yochai Hagvi <yochai.hagvi@intel.com>
> Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


