Return-Path: <netdev+bounces-201321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F06AE9006
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 23:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDA35A0784
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 21:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B00210198;
	Wed, 25 Jun 2025 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olE7ytQa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2951FBCB2;
	Wed, 25 Jun 2025 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750886031; cv=none; b=WS/KHKxyRfP2el2KHqSK63XcoGT1BVQbt+WyXsDdREMxJayEZOyHdg/qSVXyljxU/n9d0Jq4G5Zr1d9ZEuAnHmFPUXRA+ew/uRiAhx/BFu4WngGipvmarwZpvuMbp/CfzoWBcRu7QKbBpPNSwCqV/nkbi+3FQ1rqxkA3qjRHhPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750886031; c=relaxed/simple;
	bh=2CYyWrDgfXhaIB5HAqkg5pcw/ljnzjLZcEO2sgGT5Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1/Fpu7LCSyyF1ctXj6iHTaBqIZAtbQPilzOwpBvIe6iOaen4bL8tGLa7m39hcBo5PRdPJ8PpHwNpJGap2+sT01JbwnHjnuiybVds2ID+5sWM6MArTGbLKoBI/hvaU8YKPIdJi2smuW1z47YbKEuXmJ19nowE7jwx6HsiJCKEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olE7ytQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50799C4CEEA;
	Wed, 25 Jun 2025 21:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750886030;
	bh=2CYyWrDgfXhaIB5HAqkg5pcw/ljnzjLZcEO2sgGT5Mg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=olE7ytQaRAfnd6Xerm2dTjD7So72cUL+IMTcJrzT7HaNWbjk2+6QnnrpDjzC3AhCe
	 m/4aR7B3E08apSdIHEnYpRlosAbxXK6pG8a0JKpFzFn/NjAQw/Li4qQER8HVHNsmd6
	 rW5P5CdnYpVl/YsC6cBzz+O0CU2pxm4YhHgAlx/n3F35nKea5llmcN8KTdrkGVfKHQ
	 wzyT8M32iFcTo8l9awdpJcDgVb8f/v67jS/g/5BbswiQe0ssCWYdS6rfVqkF3XO0ls
	 jcM5ZqkZUT2zGVuAIMmbb73vjwyP9PW71H0NPjjyooMAtgB2fZwLJSIiG9Ki7JdIJW
	 /jqXKnDND/XEQ==
Date: Wed, 25 Jun 2025 14:13:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Deli Zhang <deli.zhang21th@gmail.com>
Cc: michael.chan@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bnxt_en: Add parameter disable_vf_bind
Message-ID: <20250625141349.5315d6cc@kernel.org>
In-Reply-To: <20250625053005.79845-1-deli.zhang21th@gmail.com>
References: <20250625053005.79845-1-deli.zhang21th@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 13:30:05 +0800 Deli Zhang wrote:
> In virtualization, VF is usually not bound by native drivers, instead
> should be passthrough to VM. Most PF and VF drivers provide separate
> names, e.g. "igb" and "igbvf", so that the hypervisor can control
> whether to use VF devices locally. The "bnxt_en" driver is a special
> case, it can drive both PF and VF devices, so here add a parameter
> "disable_vf_bind" to allow users to control.

sriov_drivers_autoprobe

