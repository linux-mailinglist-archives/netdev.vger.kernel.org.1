Return-Path: <netdev+bounces-65864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0879283C154
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 12:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EF328956C
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 11:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C0A2C69A;
	Thu, 25 Jan 2024 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC1vINH1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718CD1CABA
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183604; cv=none; b=c6IRmNUff7dYa6yexUal+NjnhJk0N7ZQNZEFvhepM4igimg9iRuTicj4E4SAF8GXaBjrRQnx1Ch/kYJqkw12VuHRbtwCp2RcWyAUFsR00dbPYCdhjsfPwMhKAS5GDVWvDl/a2DSlQuEii7i0UqMJXtqdDGf/VlAD9vDrRSnHzxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183604; c=relaxed/simple;
	bh=h9mu/SRtva+3sHA+94qVBfMLNZBqZZ5vSWU3hU8vWQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktwJTtw1p4TKZwI9ZFN6duNGU6BLr+cr8ozl8TqNV8k3soKTf6JIqfAyx+aGRgFsvNeaD0Y8t7rAQ/d6oSKK75o4bPnKVCX0Lg5KttXt85Uf0b8v48szcY5jMWPGQhIMOgGC8nqInHEbHTMpHuZii2TbbQvfmwb7X8avcB/UznQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC1vINH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813B1C433F1;
	Thu, 25 Jan 2024 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706183604;
	bh=h9mu/SRtva+3sHA+94qVBfMLNZBqZZ5vSWU3hU8vWQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WC1vINH1bPG/0VkODv4Qx6BCl4vyaABchLnpyZoPEfAbbadwzZCeJv0R9wJlzfxrr
	 G7AS20fAqh7l2RO6KjehNwNuyRNo4mlxwZcl8/UigMlT9lIG+pxbW3KxUmNJaF2TR6
	 p/5l67kTbt/0YzvBNxXTiiY8NODH7R47y5kdjjeI812pOY1+I+GDfOvoufDKslxCsQ
	 r9E44R2b++GzsOnL3AONqoO9sufnobiqxbJw+Zu3E8Y/oNMkM3d1uGAKp9elGLRzGB
	 Br9UbStPiKPfLKFiX61xPEqqlXdgGC4uC+9HF7f6TjIWaEXiaGDTgP9oSwyetKXKpw
	 4IXvXi2N+eIsw==
Date: Thu, 25 Jan 2024 11:53:18 +0000
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>, Dan Carpenter <carpenter@linaro.org>
Subject: Re: [PATCH v1 iwl-next] igc: Add support for LEDs on i225/i226
Message-ID: <20240125115318.GI217708@kernel.org>
References: <20240124082408.49138-1-kurt@linutronix.de>
 <20240124210855.GC217708@kernel.org>
 <87h6j1ev5j.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6j1ev5j.fsf@kurt.kurt.home>

+ Dan Carpenter <carpenter@linaro.org>

On Thu, Jan 25, 2024 at 08:20:40AM +0100, Kurt Kanzenbach wrote:
> On Wed Jan 24 2024, Simon Horman wrote:
> > On Wed, Jan 24, 2024 at 09:24:08AM +0100, Kurt Kanzenbach wrote:
> >
> > ...
> >
> >> +static int igc_led_hw_control_set(struct led_classdev *led_cdev,
> >> +				  unsigned long flags)
> >> +{
> >> +	struct igc_led_classdev *ldev = lcdev_to_igc_ldev(led_cdev);
> >> +	struct igc_adapter *adapter = netdev_priv(ldev->netdev);
> >> +	bool blink = false;
> >> +	u32 mode;
> >> +
> >> +	if (flags & BIT(TRIGGER_NETDEV_LINK_10))
> >> +		mode = IGC_LEDCTL_MODE_LINK_10;
> >> +	if (flags & BIT(TRIGGER_NETDEV_LINK_100))
> >> +		mode = IGC_LEDCTL_MODE_LINK_100;
> >> +	if (flags & BIT(TRIGGER_NETDEV_LINK_1000))
> >> +		mode = IGC_LEDCTL_MODE_LINK_1000;
> >> +	if (flags & BIT(TRIGGER_NETDEV_LINK_2500))
> >> +		mode = IGC_LEDCTL_MODE_LINK_2500;
> >> +	if ((flags & BIT(TRIGGER_NETDEV_TX)) ||
> >> +	    (flags & BIT(TRIGGER_NETDEV_RX)))
> >> +		mode = IGC_LEDCTL_MODE_ACTIVITY;
> >
> > Hi Kurt,
> >
> > I guess this can't happen in practice,
> > but if none of the conditions above are met,
> > then mode is used uninitialised below.
> 
> Yes, it shouldn't happen, because the supported modes are
> checked. However, mode can be initialized to off to avoid the warning.

Thanks.

> > Flagged by Smatch.
> 
> Out of curiosity how did you get the warning? I usually run `make W=1 C=1
> M=...` before sending patches.

Probably there is a better way, but I run Smatch like this:

 .../smatch/smatch_scripts/kchecker a.c

Smatch can be found here:

  https://github.com/error27/smatch




