Return-Path: <netdev+bounces-163912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26632A2C027
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D58F188BD93
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFA41DDC20;
	Fri,  7 Feb 2025 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvKJgKhB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88941A5BA8
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738922629; cv=none; b=CAWdd65faDSTyqpwql29bV7H/4dgcjm7I5hm9Ctxk7AE0ls4vkcbxU4bechv0gOsgxIANegg+iwD3Y8nDjn1b7B/emkytGuctmMWys1VMMlQM9Dn8obHJ7GYcezgfTwfnmBKrGRYwdeOxE3oO8mwvNGEv/bJc+8FLLUYhT+Q1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738922629; c=relaxed/simple;
	bh=irkuJsf+eKqHKECMsoVCgPUQWSyE2A9Ww3r9L75BeqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hy115m8PgS66lQ8R4RcmFhJNrHOSnA8HIxPUz71uJcZ8VVvVnDlEeeUteM2SKmsiUXrfvpSmvVT0Jl/yWxq2bFhctNXGpGLCrJg4GWxCN5TYErUnPivU+bCSfrdUVq5J6KGRpJqDWAoFe/O6n4oejkgHSkkdllQwqqORvdWpII0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvKJgKhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AC2C4CED1;
	Fri,  7 Feb 2025 10:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738922629;
	bh=irkuJsf+eKqHKECMsoVCgPUQWSyE2A9Ww3r9L75BeqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvKJgKhBLx/fqH7+y1BUGDOcedZRe1uiclCtCKU6D+nYlBC4Mw8A1B4j82wrbv+SF
	 3yqY3QYLdfe2zW1Qv7Qp6kKmsl/P3vA32OudWGSzlNC5MJoyJAli2KoLT23NkOOhsE
	 kG5Q4YtKQyGu/kIo/avOjWji07MLsv9T6AeIqavMv4MW1H00tYbeQqirifnBydK0Hx
	 O81h+wcvuSBP3E8vTOiWgFdLYJ3h3bXeFtFH7C8r6GhLbpVqOk2Fxnodhj4paF18Nh
	 +9ENAKM44c9hMpr7/jj3GLrFhrW9srI5HeuyuqwxmlAuE5mh3yifSy8r5wz+0bFGCG
	 004gV5GTracSA==
Date: Fri, 7 Feb 2025 10:03:45 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: Re: [PATCH iwl-next v1 2/3] ice: Refactor E825C PHY registers info
 struct
Message-ID: <20250207100345.GK554665@kernel.org>
References: <20250206083655.3005151-1-grzegorz.nitka@intel.com>
 <20250206083655.3005151-3-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206083655.3005151-3-grzegorz.nitka@intel.com>

On Thu, Feb 06, 2025 at 09:36:54AM +0100, Grzegorz Nitka wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> Simplify ice_phy_reg_info_eth56g struct definition to include base
> address for the very first quad. Use base address info and 'step'
> value to determine address for specific PHY quad.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


