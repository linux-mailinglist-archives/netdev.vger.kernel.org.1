Return-Path: <netdev+bounces-109007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0772E9267F7
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D3A1C22D29
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3428185094;
	Wed,  3 Jul 2024 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGwlQJyb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68817B4E8
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030803; cv=none; b=Kn/R2U5X4Yyg3U7eS7KAMiASKhN8Bn/IEiXHhXK2zvP+6eIRFDd8PSkYgbHfWcFQkUoLTNAe+UXHJmf2b4Xuh2tji9oOoECbywO5yVcFqOJD/b9PAGrzsqf5BghUkIFJXb1aFZZKYRqwc/p1MERgeofATBWb22tivJhaIRzsY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030803; c=relaxed/simple;
	bh=OARh+v8zMM5nB/eLwibX50fiVKzoI2wXnMGExKoFIEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJeOdnhJZjGM3nbyP1m0p9BUSbtqHCx8Lh5QmRLlGn3ck7W8wwDP2kAinDOe4nqA/W6o8KtuTZmqh/PbEBBbARM7/or+NaXS5sx4JcM+7cqP43/hajEJ6t1T7Cdil1vKYZT95POK/U/lG6X+bB7mrRMS/MrwWYnf4lFpVyDzACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGwlQJyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F46C2BD10;
	Wed,  3 Jul 2024 18:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720030803;
	bh=OARh+v8zMM5nB/eLwibX50fiVKzoI2wXnMGExKoFIEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGwlQJybUv3u/FbEUpTCCzrFphs7ieZJtuID/AKRMA7DtnUc5RMTL7y26hLWj8mqM
	 2/54oiJpR3r0azlMeszO243NwTQ83zfN+lhy0j1+8vM4J/JFGNcc18M1Yr5wjda4Ar
	 Tq+FFb2wBhHWmeacApAGjm5N1azreOX8rBk7iW7RbabQnHQp3SNKTwsmgJ9D4ixZW6
	 nA/nTPvong4wFKgX3AEyqL2w0M7rLDYGd0LgBs7eNNY/QKfqGJ/z7inYOruBSNklQj
	 PxZ4r4eP9dRppED7duecRY6d3ElOw7tJlPSNibe/sK/ziKQWKVLJ1ILxzlkrF6sbYh
	 TFWYb/lCemvHg==
Date: Wed, 3 Jul 2024 19:19:59 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH v2 iwl-next 3/7] ice: Align E810T GPIO to other products
Message-ID: <20240703181959.GK598357@kernel.org>
References: <20240702134448.132374-9-karol.kolacinski@intel.com>
 <20240702134448.132374-12-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702134448.132374-12-karol.kolacinski@intel.com>

On Tue, Jul 02, 2024 at 03:41:32PM +0200, Karol Kolacinski wrote:
> Instead of having separate PTP GPIO implementation for E810T, use
> existing one from all other products.
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V1 -> V2: restored blank line and moved enable and verify assignment

Reviewed-by: Simon Horman <horms@kernel.org>


