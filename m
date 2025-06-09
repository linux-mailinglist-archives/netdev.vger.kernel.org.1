Return-Path: <netdev+bounces-195839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD270AD26F1
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD4B7A9164
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBFC21FF3C;
	Mon,  9 Jun 2025 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LruXgb1W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF821FF2B;
	Mon,  9 Jun 2025 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749498137; cv=none; b=n/Mnd3yjFLjjfSv+fNtPGIMEeWi/Scrti8Ft/7b2PhI9ieNZYCB+ofcO6YfGwnfolDey3dSOBDmb44RE2Ff0Vi7izoxHCw43Azp2Stc7qzgqM9SYj8qWeLHxyEKoSGf1bPQTMer4Z4vDjIDO9YSCdjr0eNbGK+2uModWJwjyWsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749498137; c=relaxed/simple;
	bh=yx1luWVq/huJnpDPAMMBLuCgMt6IedpI4DKzMbLMh38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QymPOhBLjEw7njA+5enYoKrDyWQdkXU9rsUyywPEPSdYbHDOROJ+gXB1l3wPkyY9Ee16GremjbP4BGOMSsc90zbaBwzq89o2eXNugknO2VjRIF5pQqla1dbn54kOwYpo/beCX5xNVQtPulnV2U5rhfV/K+X93zBpfq0S7Yjab7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LruXgb1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6478FC4CEEB;
	Mon,  9 Jun 2025 19:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749498136;
	bh=yx1luWVq/huJnpDPAMMBLuCgMt6IedpI4DKzMbLMh38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LruXgb1W4wAzcuv0CpYDuEGWClJD9mT1GjWKJpzO8XCTcT07+5wGyValMSUJuKbPi
	 ajx42oOqBgwTwclTdLuRE/xqtg8Hj8/8Uatp5PN4eeX7/OQukWAo1L5nU27pUZgdyo
	 7OeMIcnyeWhdPKUo1XVGWc/YJnKm7MItUozAc6vWIydqyK7z1t77J9z+VpKt+B4LQB
	 oVB7qAlvwMN5HppjeIAzpM3DR+EzLPo4R8wAss9ScDqb6K0vxxeL6PM1Ii8CrAwOfn
	 fPpOdd0vLMzC1a7NCA61QaNfBK1vgJCMKtnO+YlsLytK/HdGS9jJx26/O652d+veIF
	 +DqHlB1EWKmrQ==
Date: Mon, 9 Jun 2025 12:42:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: remove unnecessary brace in ptp_clock_unregister()
Message-ID: <20250609124215.204c9c41@kernel.org>
In-Reply-To: <20250606103659.8336-1-aha310510@gmail.com>
References: <20250606103659.8336-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Jun 2025 19:36:59 +0900 Jeongjun Park wrote:
> There are unnecessary brace used in the conditional statement where
> ptp_vclock_in_use() is used in ptp_clock_unregister(). This should be
> removed.

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
pw-bot: reject

