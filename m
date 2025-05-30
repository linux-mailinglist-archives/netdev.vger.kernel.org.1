Return-Path: <netdev+bounces-194284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B7CAC85B2
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 02:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EAD97B14FC
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 00:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41C7AD5E;
	Fri, 30 May 2025 00:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+n7t5zf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC979D2;
	Fri, 30 May 2025 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748565195; cv=none; b=IK/QdTWvLtvaBpVaPEwgl3ePN0Wq3LSFZefGE5Y081+UeNusnh1oS3/BGlRhv9ETT1kAHUOXBWMw553OdafnhmPIfNaD4m1ChmxImVqRSvv3e2GuKMXDUSJAzzo/65R14JPjc3nKOTRpJbj1k7y6s3T7P0qvNey1bXZ3VtLBx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748565195; c=relaxed/simple;
	bh=NQvdTxmbBmPADvv5Bbcr1DYjCqG9xYmrWl2KDuQ7cd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpUqtY5ZZj5unTwLG0cavv383IsYldTxd8MZSYKLP6wG2Btc5Kv9CnHqenaka3cNfVgDzOED9jVxelv8oZL4EU7ec9ZoRjiZvsKdlXYdZrGM0llF9/bBE5TNWzgMngQ+eBa6rUxSKtgG+7Isy4bPDGFn/BJqQcE6/oGnJmHO2Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+n7t5zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC2BC4CEE7;
	Fri, 30 May 2025 00:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748565194;
	bh=NQvdTxmbBmPADvv5Bbcr1DYjCqG9xYmrWl2KDuQ7cd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E+n7t5zfIFrF1CjovLBdfycoxonkpvmWIN0L7aYqj25oaLSpUpaYTviCLiAh2pE/6
	 S4h8xcxxOf95sbBmUGh5dJzDId6h3o4t9EalM9eCBCqV7q7nf/Jh+SqJNhUXHoleEc
	 L6wmVYboycw+cVdrv94ihOoltdFrMRaMSoEiA7CXZ2Ydsnu2+ARz4eSIs7aRs1jvVP
	 OD4ndEQ3ryL/7KldvqM3YFgyvFbZpmvEuRHRXDULSm8gdPI7igggoLKyCObYmylMaa
	 CryyCHOL1DdOUdU0GZmWjkniRReeDHu3cMn7KszmDGwxF1JVZc6Cxtbb6NV9wbhy3d
	 hzLAAfCVfMwbw==
Date: Thu, 29 May 2025 17:33:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 jiri@resnulli.us, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, aleksandr.loktionov@intel.com,
 milena.olech@intel.com, corbet@lwn.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/3] dpll: add phase-offset-monitor feature
 to netlink spec
Message-ID: <20250529173311.15fcff9b@kernel.org>
In-Reply-To: <20250523154224.1510987-2-arkadiusz.kubalewski@intel.com>
References: <20250523154224.1510987-1-arkadiusz.kubalewski@intel.com>
	<20250523154224.1510987-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 17:42:22 +0200 Arkadiusz Kubalewski wrote:
> +Phase offset measurement is typically performed against the current active
> +source. However, some DPLL (Digital Phase-Locked Loop) devices may offer
> +the capability to monitor phase offsets across all available inputs.
> +The attribute and current feature state shall be included in the response
> +message of the ``DPLL_CMD_DEVICE_GET`` command for supported DPLL devices.
> +In such cases, users can also control the feature using the
> +``DPLL_CMD_DEVICE_SET`` command by setting the ``enum dpll_feature_state``
> +values for the attribute.

Since we're waiting for the merge window to be over - could you mention
the attribute the PHASE_OFFSET comes out as? DPLL_A_PIN_PHASE_OFFSET ?

BTW I noticed that in the YAML spec, in a comment we say
DPLL_A_PHASE_OFFSET a couple of times, missing the _PIN.

