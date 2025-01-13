Return-Path: <netdev+bounces-157867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57109A0C1B8
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E5C3A3E90
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F312F1CB9E2;
	Mon, 13 Jan 2025 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkF4cznU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22951CB501;
	Mon, 13 Jan 2025 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797447; cv=none; b=LzQpv4aiKHSzg78/rECkFm+XHSmEMcnjCQYWOv51MjmPpPli3XfYPjdSB+7tueawubrNUDpRMZRnasLftShQLRkrbPPmOSjXGRMid8NzJLe3hOsKoDMgajxCDltZtb9DtKjOHoef84CSPyuppLxv0rhh04vBxhtyRQDXgOY0Oqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797447; c=relaxed/simple;
	bh=aZ6VTZZnl5f5+nC+JvKNEt+js4k/i3riCEY5Red1vxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIWky6c6tQJTeyLEUTCyhCx5AwmFESAaqC6jxu1BGpE4B9Nqckqibqyrq8EFAnUUPzDJBBP8XG8qEOOHWJsONZkcOM3qQAgkAB7WK9ob2q2wQvB10Y/JmHVpw9e5fX6Vxs8bXNmqYdLqAIlxS13WI1IgQrCHEpraztASpcCrHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkF4cznU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FADC4CED6;
	Mon, 13 Jan 2025 19:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736797447;
	bh=aZ6VTZZnl5f5+nC+JvKNEt+js4k/i3riCEY5Red1vxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nkF4cznUEE0f/skENN2CRbb08Xj9hLNA6vKAlRpd4/WHjK+HQDvMbzi9fUTb9XWoM
	 bVSciNNuFPpH2nK/JMHP5aZXXqn11zG7dKFpssjGg8sj+CXQcHXxtODY5FhULbrhEK
	 FPsYPRgVQowVGoOpUehjs9hARnx1wqOfjs60XNIiUKYwIlTcJ5twhtiob6Ou/4LIWy
	 tSaK3J462218xiP2wttYwnqEzJGfekSAMUOJgzgCySP3FBSJjLnBoBoRazNd7Tb9Dl
	 YdqNob/IvjDUAPlH+XmxGsnLB//LSzYTRotSvAfDR+7M9YIfWuYJE8e70MV6i+rOuq
	 EBOvVaaBQra6g==
Date: Mon, 13 Jan 2025 11:44:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [TEST] mptcp-connect
Message-ID: <20250113114406.566f1072@kernel.org>
In-Reply-To: <22a1d42b-3015-47cf-b3d9-46d0ceb63ebc@kernel.org>
References: <20250107131845.5e5de3c5@kernel.org>
	<1ac62b6e-ee3d-499a-8817-f7cdfd2f2db5@kernel.org>
	<22a1d42b-3015-47cf-b3d9-46d0ceb63ebc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 17:08:02 +0100 Matthieu Baerts wrote:
> It was not easy to reproduce it, but Paolo managed to find a fix for it [1]!
> 
> Out of curiosity, is the netdev CI not too overloaded? To reproduce this
> issue on my side, the host had to be quite busy: not dying with
> stress-ng using all resources, but still competing with many other
> processes, e.g. a kernel compilation running in parallel. I'm not
> complaining here, because this situation helped finding this important
> issue, but just curious about what to expect, especially for more
> "sensitive" tests :)

The tests my overlap with other workers still building their kernel.
ccache is enabled.

> On the MPTCP CI, some unessarry KConfig are disabled and ccache is used
> to reduce the build time. Also, RETPOLINE is disabled (+ vng --append
> mitigations=off) to save some CPU cycles during the tests.

Could help. Let's put it on the list of things to do once we migrate
the CI to a public set of hosts :)

