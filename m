Return-Path: <netdev+bounces-235337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0455AC2EBE2
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5E6E34C7DE
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D2E2116E9;
	Tue,  4 Nov 2025 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nElUHxAg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8259F189BB0;
	Tue,  4 Nov 2025 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219599; cv=none; b=K3iiFPx/vb5mDGUAwyh2CNEwW0PpwIlhwR5HZmUIdE13p/mysi+pNzLyCOwn9087ZYksVjlN6/ZxtCvWlJfH6pJ3AZ1Lot4/bnwzSMhyKRBOW8VAtiEFwrHhNhC+tfYi7rDPZDU1l/agsOo6GyT0iE1ymFFrRiUBO2nPU1zwISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219599; c=relaxed/simple;
	bh=2+HX2QP6NtpWbihyY3tkazP8r6QTwd6BtyggIUK7Vcc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SI3Y2nj4dAnCMHFCyGnwsjvSZJwdfzAdsziHhZ0s342Vx47GKUY/v0U21FbV+l7ob6eTisQKHg6TO5/ntazz+awLHAQt2QjKonb7WNI60uGYJwDavwTdPUrMVx4QNlhidZCAqJDgCgI2ffkL4onVa3XAm0Y5uWbyabzKjg8piJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nElUHxAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FD7C113D0;
	Tue,  4 Nov 2025 01:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762219599;
	bh=2+HX2QP6NtpWbihyY3tkazP8r6QTwd6BtyggIUK7Vcc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nElUHxAgfsGTl79pQtr18wyWqp/8mmvW10pRAHKU/TnPV8N3vKetn0wTRdOr5abUj
	 XNVckT3oTDA+0z+SIB/5CC8DRfuKc+lRkFSUxpXMVWeys/JOs0HJrvzG4WG+Ss/Iti
	 nwlrBMqlAfalfZI/0o8n1SKR1XOmsb0ZyayoeKWJPiQo2moMlwBdVhl1PgCE0q5uKc
	 X90fd54fBQB9FNheEgzzUsc3y0as3UyDvAQ8D+FVb4nh3lVvdvsuuWKYXcYxZUVkxZ
	 qbgIbJvscT5jrrKSk20+Iup9G56/jD3jiFzYLCvO6igDEuNHZSCjUE1vDceeuNdKkS
	 i8klS2o2dC/Ng==
Date: Mon, 3 Nov 2025 17:26:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: XueBing Chen <chenxb_99091@126.com>
Cc: edumazet@google.com, kuniyu@google.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/core/sock: fix coding style issues Fix multiple
 coding style issues in net/core/sock.c:
Message-ID: <20251103172637.58cbd532@kernel.org>
In-Reply-To: <20251103023653.3843-1-chenxb_99091@126.com>
References: <20251103023653.3843-1-chenxb_99091@126.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Nov 2025 10:36:53 +0800 XueBing Chen wrote:
> - Remove spaces before commas in _sock_locks macro definition
> - Use tabs instead of spaces for macro line continuation indentation
> - Separate assignment from if condition in __sk_receive_skb function
> - Fix pointer declaration format in timer functions
> - Add spaces around == operator in preprocessor directive
> 
> These changes improve code style compliance with kernel coding standards
> without affecting functionality.

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
-- 
pw-bot: reject

