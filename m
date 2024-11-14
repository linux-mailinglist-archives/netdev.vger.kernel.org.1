Return-Path: <netdev+bounces-145014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EC59C917F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA1F283B97
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 18:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C02B18CC00;
	Thu, 14 Nov 2024 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFKqyVqJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E8262A3;
	Thu, 14 Nov 2024 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731608135; cv=none; b=ETt2qAtqtog2+iqFM0H/CJ4RvPifZVL+MH0iuCgPfdsRPjKoCCPAO3TS2M9fqtVNhFfn5h+n4CAYxB8UhJHNzK4b0uz3IwWlAJ3eu/LxiVI+MdNacJi3+k8hJVa88Sik4VO7dSTZf/YfVAG9mWj6bZpoeyNavYs08+uYbv2gdEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731608135; c=relaxed/simple;
	bh=ky9GRSA4B17uNIVqN1zYU/4rMsEZjj1mdwL6LGqXTEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rdu8w3LSBEzfJm+KKPE1VU44Y6mcDrJmsASWLTnt+iTlHVRrvoUaR0QTCsNSEk0VFKy481Hka9EHD1zciUlfuIoexdR4tVwdOMJOocSQqytOTJ+JQLJMQDPllENvB70k/WuuO6yaS8Aso4IzSBluYAUHs5hrpVT2v/xUDmYqn9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFKqyVqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37190C4CECD;
	Thu, 14 Nov 2024 18:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731608135;
	bh=ky9GRSA4B17uNIVqN1zYU/4rMsEZjj1mdwL6LGqXTEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFKqyVqJXc/+yDtuK58mwaDxE4CTKzW0WPUCGHLHFKXaQLwWhvNH8LhFGyLEojU7t
	 SYjjyDD2RO/G9CXp1xqEQr1y9NqUMZ8H2AdV+sEbR0FrxsCJ6Arn5i/wRKZQqgWcUJ
	 tJEEPldKUjoil6AdqFtG6wL5Ko+vcpu6qzY+QEsp6P+Sw7u5m2QAGAKFd1Bmlv5e00
	 wJt9OIf0TylE3+s0xREyipB/oFNrqGsNMU1m4DOUQNr+swfhiTlgKRUKtKZ3ySYDyN
	 ejECHIRHsgRiCSGt1Ukj3PHLVOgC2exvBHMUKAS1JhzDHa1xbblKJGglqR+PTRo1ac
	 zr6fB0yeIvUeQ==
Date: Thu, 14 Nov 2024 18:15:31 +0000
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next 1/2] rtase: Modify the name of the goto label
Message-ID: <20241114181531.GC1062410@kernel.org>
References: <20241114112549.376101-1-justinlai0215@realtek.com>
 <20241114112549.376101-2-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114112549.376101-2-justinlai0215@realtek.com>

On Thu, Nov 14, 2024 at 07:25:48PM +0800, Justin Lai wrote:
> Modify the name of the goto label in rtase_init_one().
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

As this is in the context of other work to improve this driver
I think cleanup should be considered for inclusion upstream.

Reviewed-by: Simon Horman <horms@kernel.org>

...

