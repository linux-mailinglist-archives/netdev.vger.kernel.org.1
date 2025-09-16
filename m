Return-Path: <netdev+bounces-223779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A158B7D62F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0583AD3A1
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3982EFD91;
	Tue, 16 Sep 2025 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6OIWjQd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CAC2EF665;
	Tue, 16 Sep 2025 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065259; cv=none; b=DMEE8054GIiQ4UxsU4hIeiCxWd/er6a0G4JPoExGVkASVi5RgBXx2p3qIsVKagaIlUZMYLBGEyJZuHaiDmSNtZTOMjLAuPeZlKtHwre7vijN9sqww1aQAMxAclMT4F9KGJAoPJuBa3mnPhufNxrNSUaHfuL4UOmdYC4C+AvOx2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065259; c=relaxed/simple;
	bh=ELWq64zgyhroZprLsvqen+xFM42iZb/dgoJ9Ru9b5+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkHY0yyRTSNh810CVNLQR6qFPRzV5F0EjXg4Mll+pjuoWEfZLr07gAyNQDBMt7AYppCwLft65ZoS2A4ySfn9ezDM/2xx2k6hILw41Ds2GHbtClySHqg7urSzIgaB8tZsziLrHdTMOQI6VYO2rTYUUNRQMVk94J7Mi19NrqED9u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6OIWjQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598D7C4CEEB;
	Tue, 16 Sep 2025 23:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758065258;
	bh=ELWq64zgyhroZprLsvqen+xFM42iZb/dgoJ9Ru9b5+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a6OIWjQdqewdbeTrxolfKQuwS0chH1QIgwSMNRJZ/sXKOtdB683wnJmSJmavf1ejv
	 YWjjVE50303w+OQlsqXOay+fRgF3Sht/PT1qwYlBh3GbNKj7TF9frhx0JHSNXGhnWJ
	 F97gr9dPr3dwmzUuAxXIFqTM78sGDHkWW/8uRAKu3B7LEm1I79Rqd0RgyvtRvy7UdV
	 nfmJjLB6Nld3eZmU/VnQsg4QNlesjXU19fG+oo0VkRuiSiR1luyPEQFYRV/KpwtP2Y
	 wygBboteyRh6CJdC+1uGdYTuhkZZ+OY6TEwDoBoEXRpZVniEKV5TnC+3zqFC6mB9xD
	 9Z+Zk6o2cbTVA==
Date: Tue, 16 Sep 2025 16:27:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 cezary.rojewski@intel.com, sebastian.basierski@intel.com, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v3 0/2] net: stmmac: misc fixes
Message-ID: <20250916162737.7c95d01f@kernel.org>
In-Reply-To: <20250916092507.216613-1-konrad.leszczynski@intel.com>
References: <20250916092507.216613-1-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 11:25:05 +0200 Konrad Leszczynski wrote:
> This series adds two fixes addressing KASAN panic on ethtool usage and
> flow stop on TC block setup when interface down.
> 
> Patchset has been created as a result of discussion at [1].

Please make sure you wait 24h between repostings, per:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pv-bot: 24h

