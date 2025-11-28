Return-Path: <netdev+bounces-242619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D42B5C92ED8
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 19:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60A92349895
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 18:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0322B27AC31;
	Fri, 28 Nov 2025 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxNNPPIq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1E327587E;
	Fri, 28 Nov 2025 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764355634; cv=none; b=U+/MmodZdsBB8lQnwkTZ2PgP2AvwRx7y+I2TK36uySHlSlS7DPNJUJ+PY236lMCVuMBzFv8EhIpjyGwUUzi9EO0nI163zQ9DbZ94HO0MeAnnyTVZBq/uiobtPnU/MDqvN3hjDO95aA0t0Bo3DhnLsUepIpTFVW/C9ik2+tw1at4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764355634; c=relaxed/simple;
	bh=MfzdGm+izl0otYqBg5n0RwxvG7F8zrm8QyXRenmp5Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlBqRP1d0l78HejkHUPL+CYaZO7FUZMdgfsevB6lrQTbsQwv2GbsFiMZjrnLDdN3ABcxjB3JV8XzfXtwhmwnKWb8fsVLt08gJG/l+HhIapO7WV30tKYeDAOeVMwM15ZgPN/wtT1sgI8HfS515AjASCE20LDZhVxoxDP3die3+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxNNPPIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA10EC4CEF1;
	Fri, 28 Nov 2025 18:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764355634;
	bh=MfzdGm+izl0otYqBg5n0RwxvG7F8zrm8QyXRenmp5Cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rxNNPPIqBuz3fR6wy+YRfyHo7pHNPdX6LTAyW9UghMxzX7Erm+th8T+gKu2rtynUR
	 wFOSEriw9NBwY0bA5utMOwTrHx8hruhDGg/lmAZKPOYQZAWFo4OR8WpSF64MPO4kj4
	 dZ5z+UPGomKG3myJZXTFC3Eg9cCfLOG4tX0rmINIcpZJI6K2x9P0+SmhHbOOx4LQcX
	 hwptag5hHLI95vRNb6dbgeCOpJrw1rB5vFJCZP57j/fbPqrsgMhT7AZrARzMVLIbz0
	 xvRUoX8Pnd/XVq6xtrveESdYrOCgH/gZexTAGxUu9rOH6EGONzgqh2M7js++uwF+5d
	 Y40HyZ4T21wZA==
Date: Fri, 28 Nov 2025 10:47:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Clara Engler <cve@cve.cx>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH] ipv4: Fix log message for martian source
Message-ID: <20251128104712.28f8fa7c@kernel.org>
In-Reply-To: <aSnSJZpC8ddH7ZN0@c83cfd0f4f41d48a>
References: <aSd4Xj8rHrh-krjy@4944566b5c925f79>
	<20251127181743.2bdf214b@kernel.org>
	<aSnSJZpC8ddH7ZN0@c83cfd0f4f41d48a>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 17:47:33 +0100 Clara Engler wrote:
> > People may be grepping logs for this exact format..  
> 
> I agree with you partially.  For such a trivial change, it is probably
> not worth to pursue this any further, but I don't think "log stability"
> is something to aim for/guarantee.

Could you explain how you discovered the issue?  (it should ideally be
part of the commit msg TBH)

