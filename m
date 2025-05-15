Return-Path: <netdev+bounces-190730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9C5AB8846
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9FC31887E04
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B03113AA2A;
	Thu, 15 May 2025 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m68xT7Yk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D5153363
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316450; cv=none; b=kTzgTtcx9y0cXIwxLWaFwJhV3d/e9UnV46wksFAHmf4gYDxnHNYiq4WTnoGj82/WA8jp+hsg5Y5gIB8V5vDXYaw99zFvGGtA+IvRfK0KEN/mMq+HCXYyyodgt6ZgCVmMxvw1fznVBrBxcHMeHX7ek0Q2SGfmxK/S8zJIHnUqXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316450; c=relaxed/simple;
	bh=w3lM2kUfx2oAoiZXZ4zQumg+qZt/qmFgjR/EyNrjXLc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QA2y1Cr6JVsVjnfq6K6Pryj0qy3VJXF5p3q9bxbo0bD2pxh2EJ8o1ns/LtspQLRoX4D+eSA5+MyTIeysRyExFrNpmozp5dvp1SFzimSieqtLNbi1eDHTc6/wOsU+WrtTOOyZD4KjjibJD2FEwbkHKPsROJU+Rz1V67wrwOYGWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m68xT7Yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5615FC4CEE7;
	Thu, 15 May 2025 13:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747316449;
	bh=w3lM2kUfx2oAoiZXZ4zQumg+qZt/qmFgjR/EyNrjXLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m68xT7YkUs4wlTh/QcBkH5wrX5s/zhhcuhkEsWdGJ6y3YxTpbk4khtJmAwNcp+fLf
	 EpXdWSCZ5NpOKs7fjrE7KFQ/9rxjCZ813yPmeXWAU1BhTTcBBnc3rRI81eHPlAU5/8
	 qnz/P7J2lXAZpYjKC82V+05i90X7R0aeZl2KXFzlJ/zOBMylbPxGEAj4sv4Hz3MrgF
	 kdptMmR3c/6QfVTtdZ1N4qvj5SdqmS4QpufYk+ZCjlSvCo1hHDVD6AET3LvExEuvTa
	 D+n/9XPZVozEhM4MoesiKHxUi8QQtnB4jt2t9+s8/5UYn5LaHr0FeuzWYhSRAvraBb
	 CDNe6ZPamtd8g==
Date: Thu, 15 May 2025 06:40:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojtek Wasko <wwasko@nvidia.com>
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org
Subject: Re: [PATCH] ptp: Add sysfs attribute to show clock is safe to open
 RO
Message-ID: <20250515064048.43b70b87@kernel.org>
In-Reply-To: <20250514143622.4104588-1-wwasko@nvidia.com>
References: <20250514143622.4104588-1-wwasko@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 17:36:21 +0300 Wojtek Wasko wrote:
> Recent patches introduced in 6.15 implement permissions checks for PTP
> clocks. Prior to those, a process with readonly access could modify the
> state of PTP devices, in particular the generation and consumption of
> PPS signals.
> 
> Userspace (e.g. udev) managing the ownership and permissions of device
> nodes lacks information as to whether kernel implements the necessary
> security checks and whether it is safe to expose readonly access to
> PTP devices to unprivileged users. Kernel version checks are cumbersome
> and prone to failure, especially if backports are considered [1].
> 
> Add a readonly sysfs attribute to PTP clocks, "ro_safe", backed by a
> static string.

Please CC Greg on v2, maybe we're missing a trick.
Also remember to add a signoff.

