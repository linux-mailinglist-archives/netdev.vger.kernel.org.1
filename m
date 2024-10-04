Return-Path: <netdev+bounces-132313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E109991326
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704501C22D42
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B62154C08;
	Fri,  4 Oct 2024 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9XuBD9c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32DA153BF8;
	Fri,  4 Oct 2024 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085019; cv=none; b=TqIcBRgC9Acc1F4bE2JNd6MJ0g4pCdWWSd+y5f0BKmDGouq6yEjOrCzY9alrqFII/d2jiGsQVHZDDEXc1FHk+eCTN5koZqmqlyVDy00zwEwYwaL0AtoBcFjmlBO5u/ZM2ulUpBC1GYjAPu8U7QbQrzkaFic5uWCSSIjQVo8NZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085019; c=relaxed/simple;
	bh=ysLbMEVtVO8K0fTjpdq/X4P2gOy5MXHhCx9GjGHGOgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbomjIEMB4PJWfeuDUsqGIC/A+Te0GfmkvXxuy98KzKy2KADEcgQmWmsf4ciqCyDelxNjg78YMuCGqQW8zt/47tWqVABDkWg6GdmmxzJyp3TF6sO79XptXkrjAduoCgaibou9HQsB0qBEx/YvG0TWXiDbo00G8pmNRoIUY3rWtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9XuBD9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDAEC4CEC6;
	Fri,  4 Oct 2024 23:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728085019;
	bh=ysLbMEVtVO8K0fTjpdq/X4P2gOy5MXHhCx9GjGHGOgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G9XuBD9cZdiCbGmLxm8FVYgQFIT6mWUe04VvugQp1uotqJ4F7kSb6QncMbnkxk/yr
	 I+8izOaiHWfznmniEzYnFQCagExIi/DAczV7QyiZLOvrnWdKBGFqRPXjGdnRAxd2lM
	 MzgMf4qg2WnvFaBhYPk9bA0jTvkDv2HL9wLDRcqM3caWff0nhe2d5cpsUgjew9GZzx
	 q+w331z6VHPxLu0n+CfnnspcL/KAVHD1RSLQ56CumsnB9yGTVjOh/0IR/RxaRCO1Bj
	 Z/PX69fAEOjmuDv3/CweGVWLF2INKWJTgSlDiUy2epBO0JhRJmQhys7rFi7Wf4oqMT
	 m5MPNZ+f4TtIg==
Date: Fri, 4 Oct 2024 16:36:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
 chunkeey@gmail.com
Subject: Re: [PATCH net-next v3 00/17] ibm: emac: more cleanups
Message-ID: <20241004163657.385d064e@kernel.org>
In-Reply-To: <20241003021135.1952928-1-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 19:11:18 -0700 Rosen Penev wrote:
> Rosen Penev (17):

17 is too many, I see no reason why these have to all be posted at once.

