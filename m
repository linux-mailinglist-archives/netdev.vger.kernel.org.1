Return-Path: <netdev+bounces-46035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78DC7E0FA0
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 14:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7EFF1C2098A
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17389199C3;
	Sat,  4 Nov 2023 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEcfw75c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC3E14F69
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 13:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7F0C433C8;
	Sat,  4 Nov 2023 13:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699105602;
	bh=QMqFcBbEpNpMb7yuFpbeOw27rQyg0/rxF6KLW+yR+Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEcfw75c1l0aeXIx6FK5Zge+EUzuAdjovHzAl6bn7sARQ/RKL5SYw4qNnfiu5CkSW
	 OgFI1FYCsz9/oxdlCQTqKkmOTTaRxcSuDw2vOGpkN3M66b7gLUukgfBiFahJuZb0//
	 eyaRWZ1LwKBnjg0HIewqgSdyv0h0iJPq9jLPMvRzt9Sn1S8JCZBq9Z+3nECHxqkBHf
	 GgFvSBTaxlumrxkILv5dtH5uEz8NLFKqDJJ2uaNX4DIeDDE147h0SNu1dwehUWQQ2E
	 /Ib6toqQFYzLcEZC2beVuG67rnKX9P+9CbIzqfKUA63nrM22rDGDJQC8SG3zl25QeO
	 QGMmB7Lda7qng==
Date: Sat, 4 Nov 2023 09:46:29 -0400
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-net] ice: Fix VF-VF direction matching in drop rule
 in switchdev
Message-ID: <20231104134629.GE891380@kernel.org>
References: <20231025144724.234304-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025144724.234304-1-marcin.szycik@linux.intel.com>

On Wed, Oct 25, 2023 at 04:47:24PM +0200, Marcin Szycik wrote:
> When adding a drop rule on a VF, rule direction is not being set, which
> results in it always being set to ingress (ICE_ESWITCH_FLTR_INGRESS
> equals 0). Because of this, drop rules added on port representors don't
> match any packets.
> 
> To fix it, set rule direction in drop action to egress when netdev is a
> port representor, otherwise set it to ingress.
> 
> Fixes: 0960a27bd479 ("ice: Add direction metadata")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


