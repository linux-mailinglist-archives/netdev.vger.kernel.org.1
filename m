Return-Path: <netdev+bounces-148436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CF59E1A5E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98318B32545
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363AC1E0B73;
	Tue,  3 Dec 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck5YN/Wq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125CC15B12F
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220320; cv=none; b=KN6gVxDzfG25mUGwrHh01b7f4G3g0Pec0eTY54VYiHBxefumXc7CojBj15ZirJKZOiUoCeas8kLlfXQcgBsv+HZNvIiT4EpYlP5roqaZ93FcUn1HNEymZZrudemjz1UE+MC/f1YVCZ2M62JpVznVgc0oc2q3bZEOtoSeNz+yV4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220320; c=relaxed/simple;
	bh=0dyAFi3mgH37ToqffYxIhXQZMaqsvfnhFo8NhpPxFTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNW87gqHxlPwOfIce8x2KyIbrIPgwkzO57t/elf6nwx3n5FB4C1mfYxiX6uHzAek6bpdBbV3v1EuNEeactCpwPEorD3t3hUmSnZM7TI+ax7smH9dusIZjAuk5hhyF9RWfZwId/fL8vBbgtsEzq/O+VHzoSy/s+MG7bS9ClVl840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck5YN/Wq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E48C4CECF;
	Tue,  3 Dec 2024 10:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733220318;
	bh=0dyAFi3mgH37ToqffYxIhXQZMaqsvfnhFo8NhpPxFTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ck5YN/WqQdVO6zL80YUzgSdv6CxCAAhxn0MB0RySr3lWO6O2ho/MDJkdJOLj4R4FM
	 20Qclz6EH2DnesIdRQmaAVyJlhAtuj+VneXnt8cN9jOjSDnU3avU6AnrQIfR5u94zb
	 vTZIcZOYInJNRTxerimHqMufcdLFRug3v+GIuaCeA3spmEnzv1gBD9xMd6oPg1/3uJ
	 vdLt+yYJl6R20ILeZKh9FMnPAiek2tSR9DBskVkJx3JqUYvBHjApFmwZGllgMnsuop
	 jqQwjaSecQTbRkpE+FG5Lwt4J28etY9aUi9pKRcBk2+2vSOzPOgQB9UdFFrtQFPeDo
	 9tFqT2MbOdsRg==
Date: Tue, 3 Dec 2024 10:05:15 +0000
From: Simon Horman <horms@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix max values for dpll pin phase adjust
Message-ID: <20241203100515.GB9361@kernel.org>
References: <20241120075112.1662138-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120075112.1662138-1-arkadiusz.kubalewski@intel.com>

On Wed, Nov 20, 2024 at 08:51:12AM +0100, Arkadiusz Kubalewski wrote:
> Mask admin command returned max phase adjust value for both input and
> output pins. Only 31 bits are relevant, last released data sheet wrongly
> points that 32 bits are valid - see [1] 3.2.6.4.1 Get CCU Capabilities
> Command for reference. Fix of the datasheet itself is in progress.
> 
> Fix the min/max assignment logic, previously the value was wrongly
> considered as negative value due to most significant bit being set.

Thanks Arkadiusz,

I understand the most-significant-bit issue and see that is addressed
through the use of ICE_AQC_GET_CGU_MAX_PHASE_ADJ. I also agree that this is
a fix.

But, although I like simplification afforded ice_dpll_phase_range_set()
I'm not convinced it is a part of the fix. Does the code behave correctly
without those changes? If so, I'm wondering if that part should be broken
out into a separate follow-up patch for iwl.

> 
> Example of previous broken behavior:
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
> --do pin-get --json '{"id":1}'| grep phase-adjust
>  'phase-adjust': 0,
>  'phase-adjust-max': 16723,
>  'phase-adjust-min': -16723,

I'm curious to know if the values for max and min above are inverted.
I.e. if, sude to the most-significant-bit issue they are:

  'phase-adjust-max': -16723,
  'phase-adjust-min': 16723,

> 
> Correct behavior with the fix:
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
> --do pin-get --json '{"id":1}'| grep phase-adjust
>  'phase-adjust': 0,
>  'phase-adjust-max': 2147466925,
>  'phase-adjust-min': -2147466925,
> 
> [1] https://cdrdv2.intel.com/v1/dl/getContent/613875?explicitVersion=true
> 
> Fixes: 90e1c90750d7 ("ice: dpll: implement phase related callbacks")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

...

