Return-Path: <netdev+bounces-208739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A28B0CECD
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 02:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994765440DC
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 00:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E6A487BE;
	Tue, 22 Jul 2025 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWgJKxD0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4E31754B
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753144855; cv=none; b=j/jVxCOWIK6JUZ95rg7yUA8JFWPqIGGGPiEAFxbDWZsEf1PYfNw5hde1n+Tigzs8AfLmAivteBuU8gbtI9pFdl43z9xaF5CfIh+NuRzNSK9up4qC426UyFPCn9Z15Mv6VRcy6ASutJNq1365EYOawcOoetNkldikuhuT1FBpHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753144855; c=relaxed/simple;
	bh=GRHn55+CU1BItczv4bYVVkRA/dy4kQArU89e11+PYuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqJsnFVdxk6f8sqWC+hGynRqG99iC8x5SAcVlRBY8fRbjMPrh7PGFRERLicRbNU/xAxCVRtWKaIG2Zo05bMRBMRZiAad0+qgMNUSX/FGOnlSdKUgVCWqwDlV9EfZtiiQLdxXJdws1RC39gHp8IgiEIjv7RoG4XaU4i/QINNl6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWgJKxD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD9CC4CEED;
	Tue, 22 Jul 2025 00:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753144854;
	bh=GRHn55+CU1BItczv4bYVVkRA/dy4kQArU89e11+PYuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LWgJKxD0/81LXB5KFjqbPt4k3TpIhqNLsPbHHJnszut9NXposO0nIhtbAEtA3bgvG
	 poxDtsfMI3Qn8HFRpVCGziGgeER4oOqdfwcvWdJ+iQP8cF2jvKyx22m1Uu+IjlB0MT
	 7rhdpYr23rm4rKx7uSTX0jXzRDOq4wDU/jQ2m9METcSwDivG2VlDFEsLvYHGY4Uzid
	 hEiDOU3fvHx0cLrkGDh83tmUp8CXuDHyWkQv0+FbT3lNfUfPi7bz5WWeP+YQ/Mjixb
	 ek50WfgTuU05LVy28AQfgB/kAfw/2Ztu3cKMOC5rnvYKY0aa3fiUWi36NRmtxqn779
	 gWoPCJiK/WF5Q==
Date: Mon, 21 Jul 2025 17:40:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <gakula@marvell.com>,
 <hkelam@marvell.com>, <bbhushan2@marvell.com>, <jerinj@marvell.com>,
 <lcherian@marvell.com>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>
Subject: Re: [net-next PATCH v3 07/11] octeontx2-pf: Initialize cn20k
 specific aura and pool contexts
Message-ID: <20250721174053.1e39307f@kernel.org>
In-Reply-To: <1752772063-6160-8-git-send-email-sbhatta@marvell.com>
References: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
	<1752772063-6160-8-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 22:37:39 +0530 Subbaraya Sundeep wrote:
> +	sz = ALIGN(ALIGN(SKB_DATA_ALIGN(buf_size), OTX2_ALIGN), PAGE_SIZE);
> +	pp_params.order = (sz / PAGE_SIZE) - 1;

This doesn't look right - order means log2(), not page count
-- 
pw-bot: cr

