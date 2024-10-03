Return-Path: <netdev+bounces-131412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E2F98E78B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A61AB20A33
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348F438B;
	Thu,  3 Oct 2024 00:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTBp6pVQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47E8F49;
	Thu,  3 Oct 2024 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914096; cv=none; b=pHCGPw144ltdcDrByLoEjjNeTbk283On1ZP0hjTg8gAPD8UEaXW60xyAWESR2sR9idRaHBHqk9VH49fMOh/XLtCYOelE+XGLCi7Ini0erqbf6fyEm0BeDqCtevGORXnf8FKyoDgiQHriKJtB3EuUBV7h3z/P6leXvuVuSoITnqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914096; c=relaxed/simple;
	bh=c8NRpcoWHJwGjTJoEzawu+ePFiv1Mf3k3RLZQqyah7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZiIyDmciwDrMusggqwWxINnYiEEPQAKCKvhi+u4vLajw26X2Wk7cEITlYreOSmLUWZLE9Zchn2qsE9OoIOJkWAR6X61bTDVEWIkspJMooCX3hdCTbsrNVhyFd10THmX94b48NgHlNnZ5BBloiL7633L91B8K7eClCI3P4VAuxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTBp6pVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5B5C4CEC2;
	Thu,  3 Oct 2024 00:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727914095;
	bh=c8NRpcoWHJwGjTJoEzawu+ePFiv1Mf3k3RLZQqyah7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LTBp6pVQovtdnLiST1OOlGGuJqudQBt3PIfAAsSnupBzm8WDvfiBVf9mFqix3p2k6
	 icCkhqW+Y3VJdyLAAaeKKs0OXPhs3UzYqmv/wawXKZYDFMQ44KfpjG6vmBixG/ldYD
	 VAa8mixwmHDWhHT/0AcapGjcrJgw6mVEmtVPyUkAJX9ChoyQxYVthL6dvbY4K2HMSk
	 S66O1fV6slsM5fViWDbFKSXfmohsOa6ELuMlkEJLGWiAFystkk3eT6mC8U4J3xcbqu
	 aM5/e2FryFG8XOAXy2uzbuFmm7WI9tk4PoLf/pDgykBJ6gDVf59i5kocRgIoNOan6J
	 Y/t6wW78q7Hqg==
Date: Wed, 2 Oct 2024 17:08:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: davem@davemloft.net, pabeni@redhat.com, linux-wpan@vger.kernel.org,
 alex.aring@gmail.com, miquel.raynal@bootlin.com, netdev@vger.kernel.org
Subject: Re: pull-request: ieee802154 for net 2024-09-27
Message-ID: <20241002170814.0951e6be@kernel.org>
In-Reply-To: <20240927094351.3865511-1-stefan@datenfreihafen.org>
References: <20240927094351.3865511-1-stefan@datenfreihafen.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Sep 2024 11:43:50 +0200 Stefan Schmidt wrote:
> Jinjie Ruan added the use of IRQF_NO_AUTOEN in the mcr20a driver and fixed and
> addiotinal build dependency problem while doing so.
> 
> Jiawei Ye, ensured a correct RCU handling in mac802154_scan_worker.

Sorry for the delay, conferences and travel..

