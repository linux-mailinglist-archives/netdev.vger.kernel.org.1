Return-Path: <netdev+bounces-184630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E13BA968EB
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1CC188C8AA
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF3727816A;
	Tue, 22 Apr 2025 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGODZIcz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F971F09B3;
	Tue, 22 Apr 2025 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324317; cv=none; b=LkCbsOuauH8didBqVbWvE8vgAanqE5dkmx5z7FeL5crrMTwupm5H/0xxz3HY2JrNorMRNpVrNIFSELAVD7rKNPXUAHEgyPGr02zVsrw62ulQdsY3x69iH0EmLKIT9cUd/OD67el1CQIe+ORv21a1L4VrdZf+tqszVoyXYDsmSBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324317; c=relaxed/simple;
	bh=tEuNRHqHvWHy2XWR+rCu87Po2dg2wwcFXYGxopVqASc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4GYjN+lQPZyyScY9zT7CrL4MZWVhChNWO76aOjDTriMcKRhuppcScYp+coyJ21JkW+bSG28kAasNKslkObC33zlI0uTLPP9tf2TQ5T/AtYRt1c8+e8SOF0jaGry6OJJfx1vmmDuCSidMKw+OS/zjgUHtaOXoT7cWWIMYTVwld8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGODZIcz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750DAC4CEE9;
	Tue, 22 Apr 2025 12:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745324317;
	bh=tEuNRHqHvWHy2XWR+rCu87Po2dg2wwcFXYGxopVqASc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGODZIczry+GsYYKDsP5EiK+DDj2DlcRwry7L3UmWdxun3H5WqCheqiUSRM6y/wol
	 ToOLuHehXOFTY5g38DcD8YYXzaDSVy7i5b1jJJ3k4YKJ9MauKf+xz6reIYSurkikTk
	 iAgk7T7lsOxTRvactkLfhSAs7Fz9cnFwf99uInvYKtSZFBep7Z9Jtp2FmwAnnqsMCM
	 JINSDLtX5jdMw7Spo/bTsvz8v30u1bOo1ab853W1xhdN504fhVFAnwH+uN4PJS7NGg
	 AysDzpZJEIhNJ7blv0O/1VfFDsD46mK7m5FrSGF514ibxrh1kwzl1jb+CVGCTrwAWH
	 sXfjINMIc4VEw==
Date: Tue, 22 Apr 2025 13:18:33 +0100
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: Do not enable by default during compile testing
Message-ID: <20250422121833.GA2843373@horms.kernel.org>
References: <20250417074643.81448-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417074643.81448-1-krzysztof.kozlowski@linaro.org>

On Thu, Apr 17, 2025 at 09:46:42AM +0200, Krzysztof Kozlowski wrote:
> Enabling the compile test should not cause automatic enabling of all
> drivers, but only allow to choose to compile them.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> For longer rationale:
> https://lore.kernel.org/all/191543a8-2e2e-4ac4-9b2b-d253820a0c9f@app.fastmail.com/

Reviewed-by: Simon Horman <horms@kernel.org>


