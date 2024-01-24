Return-Path: <netdev+bounces-65634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7104183B398
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 22:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297B9283F55
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 21:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6065C1350D1;
	Wed, 24 Jan 2024 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8UhNJRz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92112BE96
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130541; cv=none; b=JbkL7BcCN9oxWl+82zJB2qJMeYaBs509D59HhUE6uXzDij8nNNbXvqVYa2rsAjCHvtveN4oVoyG3o1bGBz1wXatV8knTt2Gd4JCPwXCr1aUeGNRw+0UuT/UU3EtN+Ball8qSK+e8b3hSO7CnfdPfgk5/7UW7Eo/+o9JFqm1tN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130541; c=relaxed/simple;
	bh=OwqhiirMXNXI3ECk46Nz8ZChmmdmevlnfCw/AuOJ2Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9ZKJNfmWMFBsyacxEcfk7+Fo3wrMOj50wAniJbfL1HTVdcsFAl9iQYiBe1U3m28CDDUj0n0XVybfXC45BALsVRbGzOVPQteJCZMM5v6KaDpFz4LGa7J+WF2yvP0JVzjB1sJhjPjX0ouBYuI56lSvkcQOeFT37Lhb+lPEpqkPAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8UhNJRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90652C433C7;
	Wed, 24 Jan 2024 21:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706130541;
	bh=OwqhiirMXNXI3ECk46Nz8ZChmmdmevlnfCw/AuOJ2Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8UhNJRz0hfEcmfLtHLEYE4SKXgEMhIQDPe/he45noNkcGPAK8iEcOLvmb4O/mcw8
	 uBp+Aop5NdoC0a6TTtMoLHUrp4v7t/61OfQoVL1kAVctzrua0FKMPt3MGEaQaugRHm
	 V/qNjoIV7ujuYYMdHrEw35JIVmAhQEADBwVdDq7r+IA/qm7OR7w4Jd4librmz8m898
	 9SKkkH8eq/6n0iUnfJlIgzGFrsiwRa+nnWl1P4oChya7GSdw7RtUad+6Clxk0yI7SB
	 Id6bZvKu4JiTO/QAjHz2P8FqWzMtDaunJQpOTLxCxKkGvddlYFv1+t9zFzt/HJ21FD
	 JON5+jjwyEJJg==
Date: Wed, 24 Jan 2024 21:08:55 +0000
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
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v1 iwl-next] igc: Add support for LEDs on i225/i226
Message-ID: <20240124210855.GC217708@kernel.org>
References: <20240124082408.49138-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124082408.49138-1-kurt@linutronix.de>

On Wed, Jan 24, 2024 at 09:24:08AM +0100, Kurt Kanzenbach wrote:

...

> +static int igc_led_hw_control_set(struct led_classdev *led_cdev,
> +				  unsigned long flags)
> +{
> +	struct igc_led_classdev *ldev = lcdev_to_igc_ldev(led_cdev);
> +	struct igc_adapter *adapter = netdev_priv(ldev->netdev);
> +	bool blink = false;
> +	u32 mode;
> +
> +	if (flags & BIT(TRIGGER_NETDEV_LINK_10))
> +		mode = IGC_LEDCTL_MODE_LINK_10;
> +	if (flags & BIT(TRIGGER_NETDEV_LINK_100))
> +		mode = IGC_LEDCTL_MODE_LINK_100;
> +	if (flags & BIT(TRIGGER_NETDEV_LINK_1000))
> +		mode = IGC_LEDCTL_MODE_LINK_1000;
> +	if (flags & BIT(TRIGGER_NETDEV_LINK_2500))
> +		mode = IGC_LEDCTL_MODE_LINK_2500;
> +	if ((flags & BIT(TRIGGER_NETDEV_TX)) ||
> +	    (flags & BIT(TRIGGER_NETDEV_RX)))
> +		mode = IGC_LEDCTL_MODE_ACTIVITY;

Hi Kurt,

I guess this can't happen in practice,
but if none of the conditions above are met,
then mode is used uninitialised below.

Flagged by Smatch.

> +
> +	/* blink is recommended for activity */
> +	if (mode == IGC_LEDCTL_MODE_ACTIVITY)
> +		blink = true;
> +
> +	igc_led_set(adapter, ldev->index, mode, blink);
> +
> +	return 0;
> +}

...

