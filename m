Return-Path: <netdev+bounces-137947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 308C49AB3C6
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4672281C07
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1065F1A3BDA;
	Tue, 22 Oct 2024 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjfciD7r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF061A38E4
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614202; cv=none; b=oQvzGFmv0lkxu9HiUUCoSYpaNyFJiKc5Be5+d7F4z2YRpRde5YkDZenvRbRrwHMofamkdkhek5R754h4bqrrU33Axe1GQTuHyfxgDTTZDxeCB7cGoc4ojGd3aj5rapJJnDhBqj6K/k0QuSRiAKjGBdNDRc0UW2CHn4fvLY1V8bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614202; c=relaxed/simple;
	bh=JJgCo88tGuMhAFJmSBRIceTat7BejVXhrhhQ0PBogrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xbg1a50zC5LTymr8afJ/NdeOskkr2GxcqgV65n12WuKkRW6sBSjc1xxEVZZsP8cZcaxycO2uX1enaFxEdD+tLgiPh1BVVsUIvwhNSnKM1Sy+7Ay+pqNpdeRk6kgbkAxYwlDbWntNVqnxp0FIXUTyLo+kZF6nTSTQ08BOenxxlA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjfciD7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E48C4CEC3;
	Tue, 22 Oct 2024 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729614201;
	bh=JJgCo88tGuMhAFJmSBRIceTat7BejVXhrhhQ0PBogrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjfciD7rSl1rXhgzkbzRIHsA31/lwyKKanB2OkiX7jq+RtwD1a8qdxfVesmmvoJ+8
	 S/y/9j3Te2nNubKEmB275gcSY0qRaxtb1C/xMdVnK7uUnwwDp6m9cfqv78wxIGF3nt
	 zGBBgtQ2ZZs4IjJVcaCfb7bA8esGuCR+l0Yz2/zEeN+pAV86LlPlh1msYNeoARreBe
	 IS32xIv4xJ6m0tnHQNxeYHMqiJxWXlYTLQO+t/WhCFrZ9Rh9RrhvTOEfxFKz0QytVl
	 KbvDMcj75+oUOUreHmgbby0AwfDg1asfaSDZnT3WK+wbKB2rbPIanr8T1/1mjYECtT
	 5iVRPBQm5c+QA==
Date: Tue, 22 Oct 2024 17:23:18 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2 2/2] ixgbevf: Add support for Intel(R) E610
 device
Message-ID: <20241022162318.GC402847@kernel.org>
References: <20241021144841.5476-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021144841.5476-1-piotr.kwapulinski@intel.com>

On Mon, Oct 21, 2024 at 04:48:41PM +0200, Piotr Kwapulinski wrote:
> Add support for Intel(R) E610 Series of network devices. The E610
> is based on X550 but adds firmware managed link, enhanced security
> capabilities and support for updated server manageability
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


