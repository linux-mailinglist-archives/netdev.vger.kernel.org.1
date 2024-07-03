Return-Path: <netdev+bounces-108980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969829266B3
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC661F218F4
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B9D1836EE;
	Wed,  3 Jul 2024 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5V4K8ru"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCAB181BA8;
	Wed,  3 Jul 2024 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026315; cv=none; b=M+DO7KDtM8QJPxKEJxmIG1ZAlJA8xPSTD8JJG/IU6NLoo6vailz0F6AJA0pRLslml6kwWfWb9wbJID2NelOCyE5p1wWc+eDPv3x+nTwGZYtM6Nq46sfaVeb7T/LrqW/U4yF+Y1db3L0kal8z8YWEH0SaBUDYHn/AIO/cesbmZx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026315; c=relaxed/simple;
	bh=yJ93+dCFq/4j10dTn5kcHmVS7uht33yvrrfIJiaf3f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xedck1zQlT6vETbqJGAaQPQbW0FxpK00P4uLZTXlRLHK3BT2BAki1WGocWu3a1+S6p0D09v+qjlI+XbX7zQ3hQIYFebIY49WqE4hUTrtDKHdRjGoWYbF+RBfGY43ze82lCZlTvsFtgsFqAGJlReF5PAmuvhZx6iUOHZUU9bbgBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5V4K8ru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4181C2BD10;
	Wed,  3 Jul 2024 17:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720026315;
	bh=yJ93+dCFq/4j10dTn5kcHmVS7uht33yvrrfIJiaf3f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5V4K8ruPIxLfmKnZoUjyEb7QAcb8DCoyeJdn9B0fVV2N5RLyFNduXWB62L5io5Oo
	 C/h3hE88/BFNtgMKflhuBOKdkRg9gwb8PbLFfg7Bp45YQ/D/7wtd2K9GvL93HxVJb5
	 wvbXOP7T72p//IA85Cvdd3XFMEqwNLezJyJaXfKIzfPjK8Efl7fWO8465YTKdHYXIV
	 k0PMPNy6AL1AfGt6HkdWs4CqpJzeOhcBe+3ltjd3x8xI9g4VF/sVOefILhePVDG+Oj
	 9OFFJOpLCw9F/c+IBhNEmUOwYQafBoTaNzGdIx6YbBYbfllCMF+2X2ytQ56RiRxNr5
	 JJR3NGumcVp5A==
Date: Wed, 3 Jul 2024 18:05:10 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v22 10/13] rtase: Implement ethtool function
Message-ID: <20240703170510.GD598357@kernel.org>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
 <20240701115403.7087-11-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701115403.7087-11-justinlai0215@realtek.com>

On Mon, Jul 01, 2024 at 07:54:00PM +0800, Justin Lai wrote:
> Implement the ethtool function to support users to obtain network card
> information, including obtaining various device settings, Report whether
> physical link is up, Report pause parameters, Set pause parameters,
> Return extended statistics about the device.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Simon Horman <horms@kernel.org>


