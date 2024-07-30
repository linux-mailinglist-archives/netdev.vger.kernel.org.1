Return-Path: <netdev+bounces-114169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F289413BF
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C40B2201A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566E11A08B5;
	Tue, 30 Jul 2024 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpL2Vvft"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330CF1A08A2
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347917; cv=none; b=EuqejSTJp489lH6xCG+Amacrdty818vTcgTzdCZi7hfYWAruwpHQ9GoNkAM9z1T7OvGVXMEdfvnbU2A1PduskHzgyOdqbb4J1u7Azl8m1qCDyTUIJr91c8t8e1CUe3vdeT3YS59bpgH6/6FtGXyZYsCl88xvhmDNlT0SlPDh1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347917; c=relaxed/simple;
	bh=KjkXYneYVqJAd9l6x7SXO4ya6waBJhS/04FBwQX66G0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJhtzO5xckWyeEmiSt5leQB4Jm+8/M5jZAWkFiTluRddrDw4pxyjMnY1jSeCburgTlWy0k52+xdi97bPuDX7QP0peRsaWljY2e0naO4TXxdA0cE4iZpsbjPZJffaE+LB+eMaJWLEzkZYfuHY8+NElyiiAvtvHIugEExYTScXjSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpL2Vvft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F790C4AF0C;
	Tue, 30 Jul 2024 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722347916;
	bh=KjkXYneYVqJAd9l6x7SXO4ya6waBJhS/04FBwQX66G0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QpL2VvftFHuabJeI5M8ltW6gSJPSls5CwIilVGrGlBzz4Aqq30Rwpn5rIQiBfXLKg
	 +PvNEjv3E3tVJOYoeI/hwFJBeJyZcIhAd0c/LzK4Pg2xlXheGDJ3NrWglp+qtgOBGj
	 LsTJCbP+DSr/YElIyJvgQ8Ao/1JS+JKmQtOUC3qLC0bu787+JMX1BCuzoAx3idzc/u
	 GrSn0OCPGZ0QfZDcEFF8aut4d29yxEu8JNNtoD5k0rQ3GanqoR4Cuy/uai/B+8XO9p
	 tiRSmwW5IRaKLMkjaKIxmfdrtdA4wme4LSYtz9JH4LfYFJ9mxivWD4iD55eTkE7cqs
	 8iOSVQ7SGb0Tw==
Date: Tue, 30 Jul 2024 06:58:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 simon.horman@corigine.com, anthony.l.nguyen@intel.com, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH iwl-next] ice: Implement ethtool reset support
Message-ID: <20240730065835.191bd1de@kernel.org>
In-Reply-To: <20240730105121.78985-1-wojciech.drewek@intel.com>
References: <20240730105121.78985-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 12:51:21 +0200 Wojciech Drewek wrote:
> ETH_RESET_MAC - ICE_RESET_CORER

Core doesn't really sound like MAC, what is it?
And does PF reset reset mostly PCIe side or more?
My knee jerk mapping would be to map Core to dedicated
and PF to DMA.

