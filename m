Return-Path: <netdev+bounces-192216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8971AABEF6A
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AE61BA1E78
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AB923C4F0;
	Wed, 21 May 2025 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RasJfhxj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFCF239E7A
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819142; cv=none; b=po5JTfVBx0irPTfrudVRzTpxwqadcggQPap+711N2c1sewZsr8Fsn7gOgslKiMwvPnPqr/C+ZNXymkbppDZ/62yJx2LCvVKWmQjCR2EGZGCuSW9sS11GeITNAP/Kuj3lw1yMxMNCFAMr90YNuefYbT0w4i1hf5tApzVkW4hnKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819142; c=relaxed/simple;
	bh=pdGfPptOeh5Xj8jJgLkfi6Ne2epxn+CBrY1SbELAW24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDp7lESXaAmKAxyHlxs2W32eLTtr8ZH6nEM674IA3InQSqQ0Xz+Oy/HmvH/01RrI09Ry7rauRf5usCfiNe7NXPeOXYilyA4VDWvrp9m+i+o5L1IEqee9Vl1hK15379sz6blIwOnB2BRbx+tocq2C1D1ZM2m6KoeVzi4KlYN7LQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RasJfhxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348F7C4CEE4;
	Wed, 21 May 2025 09:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747819142;
	bh=pdGfPptOeh5Xj8jJgLkfi6Ne2epxn+CBrY1SbELAW24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RasJfhxjAbdMnQIr+vpv7gYRlr0shpyIOYuhjlAGPLUBSqEYi2RlCPlJ9HfLkchDF
	 nBUZpd8CXBKgfjU+dNz1vEejm65p2oV3pULY9Vzbp1qoI50sEE15BLb9xlehfVkLZJ
	 Qn4cjgM6tWGV2BEW5Z4+vPh7BH6ydHP5ini25qQak6V9v/bqGEDKS6QL8JumYTNQsF
	 yk70hEkZU1Hu24NjUggp7iw4EotcopXzgv/BeOkwrdJJgByC6Chz3od/9yzO0s6OXH
	 F0uPXkFvJiUoNbCPdjqkMYTSk6Pgt492FOi+eF+EdaGm/my1OEAJ71HDuLGWp4OyAb
	 /T7dKwzwrRjnQ==
Date: Wed, 21 May 2025 10:18:59 +0100
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, jhs@mojatatu.com,
	Mingi Cho <mincho@theori.io>
Subject: Re: [Patch net 2/2] selftests/tc-testing: Add an HFSC qlen
 accounting test
Message-ID: <20250521091859.GV365796@horms.kernel.org>
References: <20250518222038.58538-1-xiyou.wangcong@gmail.com>
 <20250518222038.58538-3-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518222038.58538-3-xiyou.wangcong@gmail.com>

On Sun, May 18, 2025 at 03:20:38PM -0700, Cong Wang wrote:
> This test reproduces a scenario where HFSC queue length and backlog accounting
> can become inconsistent when a peek operation triggers a dequeue and possible
> drop before the parent qdisc updates its counters. The test sets up a DRR root
> qdisc with an HFSC class, netem, and blackhole children, and uses Scapy to
> inject a packet. It helps to verify that HFSC correctly tracks qlen and backlog
> even when packets are dropped during peek-induced dequeue.
> 
> Cc: Mingi Cho <mincho@theori.io>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


