Return-Path: <netdev+bounces-215653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F21EB2FCC1
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7BEAA33D2
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E1328467F;
	Thu, 21 Aug 2025 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUqq7hjO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F41279781
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786152; cv=none; b=TVBg0oIMJnQIUREcgnhobNwLykYF48NqGoo0xddqqJQjiEsVuJTEFjSNl3ZCDXrSUKTrnkeSePC9Y039GMtiYaDZ+21oHdWXsfFJACshZYJ1TnAF4eTMhtMyLQ/onU6ShXGE/wizI0zmuT4+6u537Wby41+JsNlsL4Nsf4Qz4A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786152; c=relaxed/simple;
	bh=6ivghUCtqeqRMFXTlyccoMhQuF2WEbhWLmGX/4MQUFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRzk4O4e5/m/gso8wkM1HjG1HdAZjPfnh32cXeSi+DJtMIwp0C/05kBOy1GlUVuJ4t4nDpD9NpPU+5ZLtSc8x4V+ykmzGpedAEQ4j+O6b9WRmdni2uAVhd2rxeCl5MLR6CWLCsP88f7ESvdSCEA08TesqOXiyBMSgcavnKnPBeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUqq7hjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20233C4CEEB;
	Thu, 21 Aug 2025 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786152;
	bh=6ivghUCtqeqRMFXTlyccoMhQuF2WEbhWLmGX/4MQUFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hUqq7hjOX0PQQqnAkGC92EVVH3zyFXt781ehRUMMrxMI0xF4juxwBG5MouxB2cgrZ
	 ipKDUj9maxfTAPKPWXRBZoy7SBRt47dZCPWwVIb8uNz9OQIKRuQ9lbRm1QENNN6LQB
	 7GQ7ZWPjiO+Z8NzDJawSNzNYQWcaJoGpM0jnLqEFmiwQThKKBf+6/8nZ7QAyVGAI4/
	 4TE+F9ZcXSzfVU8mEHj0z0yMLrGcSWHGJmzdvNegkXaBtp8Bdv4lENclQ9G2v5kw5/
	 hYlNYkx49O6VAAer2JZXG+h2onVcp7ebU8rJt12FHTGXsiWM+SJGcouPb11MCt9vIF
	 E97wUupTrFetg==
Date: Thu, 21 Aug 2025 07:22:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2 0/5][pull request] Intel Wired LAN Driver Updates
 2025-08-15 (ice, ixgbe, igc)
Message-ID: <20250821072231.5b4ade31@kernel.org>
In-Reply-To: <60e5f92f-009a-4ce7-a489-224e54342542@intel.com>
References: <20250819222000.3504873-1-anthony.l.nguyen@intel.com>
	<20250820184550.48d126b8@kernel.org>
	<60e5f92f-009a-4ce7-a489-224e54342542@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 10:31:59 +0200 Przemek Kitszel wrote:
> On 8/21/25 03:45, Jakub Kicinski wrote:
> > On Tue, 19 Aug 2025 15:19:54 -0700 Tony Nguyen wrote:  
> >> For ice:
> >> Emil adds a check to ensure auxiliary device was created before
> >> tear down to prevent NULL a pointer dereference and adds an unroll error
> >> path on auxiliary device creation to stop a possible memory leak.  
> > 
> > I'll apply the non-ice patches from the list, hope that's okay.
> 
> the first ice one fixes real problem, reproducible by various reset
> scenarios

Ack, just felt cleaner cutting the PR up by driver ;)

