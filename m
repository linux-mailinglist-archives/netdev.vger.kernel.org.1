Return-Path: <netdev+bounces-217813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5985B39E80
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4EC3A8103
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E1631062E;
	Thu, 28 Aug 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHkST33g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E326D30DEB2;
	Thu, 28 Aug 2025 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387078; cv=none; b=dWBbkDyJjvUwqLWsmfc4Ro4gHcOUcX8rpnmfkPYjBHrHMiu0FqTl0O6mf0SeL6qnEdyRvkLHVYCG7jtErTlgMTF9aaEfUtn6m2r+q718W3975rgcVIT2l/w1rwyfqK+qWf8a7ni/+FbagqiNzm+f9P7HXRTLIomPefvepHCATT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387078; c=relaxed/simple;
	bh=svudxpdnzKQ88XtfGZXPB3AYpLG5ShGj0Z/VL0y74a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnf7sc9oYFp3158zGT3V8HR7sxa+Of39DUGnstn40W2c+Q1R4z8l0Hct2fEpWY42jdN8/M2Zd6DzBLAeAuLLCDaEULi+WD9SQVSqzpDafpzff3Qa3GoSqsbfbBd6SyvOOxmuMyexL2PuBZaT+iBME4qfGu4Mdlz3VPFvDmBFQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHkST33g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B08C4CEEB;
	Thu, 28 Aug 2025 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756387077;
	bh=svudxpdnzKQ88XtfGZXPB3AYpLG5ShGj0Z/VL0y74a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IHkST33gX7K7oytJfnvebKr9Ugh302nI548TLn4926Kic23UpICiZmaGaVf/IGEih
	 rbtPB2NNay8YqdkKnti/ISgvbsJnAgmo/4piJeCXX9qIUTfyr1CCOepyystcvjrxAP
	 46h8FaULfCelrEA9WwtUWgLZGwvSuOknjmsygausX1gJjS3VhhLDSR3+VDIUh2LTqy
	 KK3RGxjI+tmN2PY2U7fIvgsxn/e9wrtVSQX49TMw6m6w4q6BoIhyuqekQthTLSYFu4
	 /amHEVDK9IDOqWTuEgPV8sbMC+RlR3mKB5zUJzgCHUBfe/lKR4U5wdLDxC1I5Oyy9j
	 GCuCDhWLWeZ5A==
Date: Thu, 28 Aug 2025 14:17:53 +0100
From: Simon Horman <horms@kernel.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	"maintainer:BROCADE BNA 10 GIGABIT ETHERNET DRIVER" <GR-Linux-NIC-Dev@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:BROCADE BNA 10 GIGABIT ETHERNET DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bna: Remove redundant ternary operators
Message-ID: <20250828131753.GJ10519@horms.kernel.org>
References: <20250827101403.443522-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827101403.443522-1-liaoyuanhong@vivo.com>

On Wed, Aug 27, 2025 at 06:14:03PM +0800, Liao Yuanhong wrote:
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~

  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:

  * Addressing ``checkpatch.pl`` warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)

  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.

  Conversely, spelling and grammar fixes are not discouraged.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
--
pw-bot: cr

