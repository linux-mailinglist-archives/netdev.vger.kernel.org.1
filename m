Return-Path: <netdev+bounces-68609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5481E847628
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C33D1C27421
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBA414AD03;
	Fri,  2 Feb 2024 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvkJqrkj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477E014A4F4;
	Fri,  2 Feb 2024 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895110; cv=none; b=nTwBUVlhw1IGnOYFFokBd0EWbhDlJKNGzqxeuZdKdD+pp07BEgK2XEogxNyhc19wYEwrFEqDQQsTwKBIQP/uEj/rbULMHvgJBOPVsGshRcs2R3mAGuQJc/CotonNR6FHGKYNbmBjah7wc4DO4zH8daBBzGqoe9iywtXjWaDpyMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895110; c=relaxed/simple;
	bh=D9GwYo9QbExMDVG3vXR0/CMgxJCe2TQAJGzQUUAC+n0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Y/IOSAxkBENpWZ071iwdl1wdelBnOu0YNOfjmWYsBCQGZfraX/CjJHeHydeGwlbvUQCdp/SQNPtgl2wc9XupgZKrkglXjrmzcPEpu7hUKCOVVsmkUyYFr0RKumZPWGzdyzDgXVpDImH3A9xPfD3VLBRO3RXcYu6i/GLwbHy9kwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvkJqrkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C6DC433F1;
	Fri,  2 Feb 2024 17:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706895109;
	bh=D9GwYo9QbExMDVG3vXR0/CMgxJCe2TQAJGzQUUAC+n0=;
	h=Date:From:To:Subject:From;
	b=XvkJqrkjDQCyNf1EauE9zwr5xJ7xmqOKcncLPkjIrnD5QdQMZ8klggZSmY46cFVbt
	 64rNCxw2HqRlWFPdpev56ExPQQK+yea9nDUT7EPO3C7MQJpzfJMxF6aYw8kZaXQ807
	 yuJoeAnMV58QQKeBtNstc2EaH7hDKhRZb5Er+nPMQP8/YDqxHsx4tslhGUMy1+tpfL
	 W02FTREzYR5MJlPS879uu2NfPc35EWwhvWMnhgck3E26O1AAFYO3gXak1OCQ9si1f3
	 A8MfIVtY1ii4jYPDIPPigX1EVlBuJB56bqCjXZyHBvEuNbJYw+8Fs9rYq435yWzCTg
	 W/1yKeQdg0ZbQ==
Date: Fri, 2 Feb 2024 09:31:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: [TEST] Wiki / instructions
Message-ID: <20240202093148.33bd2b14@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi folks!

We added a wiki page to the nipa repo on how to run the tests locally:

https://github.com/linux-netdev/nipa/wiki/How-to-test-netdev-selftests

Also feel free to request membership in the linux-netdev org to be able
to edit!

