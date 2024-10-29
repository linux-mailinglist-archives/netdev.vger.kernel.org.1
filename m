Return-Path: <netdev+bounces-139934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F769B4B52
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17D11F24282
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FF3206051;
	Tue, 29 Oct 2024 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf3ZIlS6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FE3205ADA
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209891; cv=none; b=AAUVTVCBOVlQD73CoSXDyGhG9NxiuKwxZa3ZSfuX+6lU3BMgJJYBMvr5SjJRA2CZEpgPTHPyk2P1tpt3cdVM1mMeXpRSkVnWGv2XL0eBPpMNq3DCCKaa6q75cxpdubR/trY3hg2KseV7kXbkHat9VIYKeXDv74MW/lpe5dlDgAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209891; c=relaxed/simple;
	bh=6BSlgiXv1N2zCZBJU0HEg+laUPY+B7fCTNkKl6VjbKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsxEX+qo1e664Y2nZn49CvjieU/CIAPiDhSyTW/rw3iSYRXNOr03MCChE4L+8KmJNrt/0WS+2CAk4f9Zl7u9F9ouNE9TUqWvOu4A85TVsUECgwPNgyNmiVW69G5VmuujGZ7UHjU394PjP2E+bdE6mFAk7wnDdhpPA4I2Oh6sbdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf3ZIlS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068A8C4CEE3;
	Tue, 29 Oct 2024 13:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730209890;
	bh=6BSlgiXv1N2zCZBJU0HEg+laUPY+B7fCTNkKl6VjbKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vf3ZIlS6Jjwh7eii8DO8Cq1m5AM2i+wgTj0kYrBpOKVImBqxR/wfGMuCwtkSCldI2
	 pVmOC8XNPAuvU2gsKaRIT6NdgN3cax+45PwwnHil76ifsz+HL0IeXpspKxgZ3mFtYw
	 vzw2b7KG61sIdbfhPmnj5cUeBC9s4hWEySWmHt+RuxZuMBsG2ItVXqA0hBpKx0W4lP
	 hDa7Y6mxPtrinYrk9sgFXtdkaINMEkDBviBkwJwk7FMdCmoN40uECl0BrMtpManoZn
	 8FENAsPOJrw0ZaFYg4zknpvdObLzbeAEsttFfc8J++kWBqEZeaJj0RVLUvt4idZ5HB
	 HLy03aAAtQoLg==
Date: Tue, 29 Oct 2024 06:51:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, maciejm@nvidia.com
Subject: Re: [PATCH net-next v3 1/2] dpll: add clock quality level attribute
 and op
Message-ID: <20241029065129.503f51cb@kernel.org>
In-Reply-To: <ZyDafILiX4bFEfBI@nanopsycho.orion>
References: <20241014081133.15366-1-jiri@resnulli.us>
	<20241014081133.15366-2-jiri@resnulli.us>
	<20241015072638.764fb0da@kernel.org>
	<Zw5-fNY2_vqWFSJp@nanopsycho.orion>
	<20241015080108.7ea119a6@kernel.org>
	<Zw93LS5X5PXXgb8-@nanopsycho.orion>
	<20241028101403.67577dd9@kernel.org>
	<ZyDafILiX4bFEfBI@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 13:52:12 +0100 Jiri Pirko wrote:
> >I thought clock-id is basically clockid_t, IOW a reference.
> >I wish that the information about timekeepers was exposed 
> >by the time subsystem rather than DPLL. Something like clock_getres().  
> 
> Hmm. From what I understand, the quality of the clock as it is defined
> by the ITU standard is an attribute of the DPLL device. DPLL device
> in our model is basically a board, which might combine oscillator,
> synchronizer and possibly other devices. The clock quality is determined
> by this combination and I understand that the ITU certification is also
> applied to this device.
> 
> That's why it makes sense to have the clock quality as the DPLL
> attribute. Makes sense?

Hm, reading more carefully sounds like it's the quality of the holdover
clock. Can we say that in the documentation? "This mainly applies when
the dpll lock-status is not DPLL_LOCK_STATUS_LOCKED" is a bit of a mouthful.
I think I missed the "not" first time reading it.

Is it marked as multi-attr in case non-ITU clock quality is defined
later? Or is it legit to set to ITU bits at once?

