Return-Path: <netdev+bounces-180771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739DDA826C5
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375BF19E5225
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129F5264A9C;
	Wed,  9 Apr 2025 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs4mV/lE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6E264A85
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206758; cv=none; b=h/nG32QRqqcgCEtDTBaNcldHe6HCPYa8OtQRx5SE5lLkuqWgBIVjIgSqI7MVLgLr0uG6lSC34Jzh2BSm7NDXu6NUb6O6K6wbIGG4udFoqtKF4pCSE/ddHgEuH7Atuj79dSu3FEkjaUZ+j5joEsR2VS3zZogZPxop8i5c27TTry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206758; c=relaxed/simple;
	bh=FhwEdM65NQi4HIHvUoFIUqD0MC/HRJGQgoVlHaelsXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7juLR0enM8BS9szOhsG28aqmP9VogaH+z9I1ZjGzU9MmbTKF85XrSqVVGaOTVB3C9SemORfSLL18E7yG+Ouyt0Kr2Mp9HXOPi4vUsu4e6WgcevAFwAgWAWYVc5/AFmqL2CeE63cKEnE31DoTevIuHQFRyqdBdlVPqP0DF6xNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs4mV/lE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522EFC4CEE2;
	Wed,  9 Apr 2025 13:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744206757;
	bh=FhwEdM65NQi4HIHvUoFIUqD0MC/HRJGQgoVlHaelsXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rs4mV/lE+o/KRQY3EzAiSwA4d4cxxeKDRPqZQRxUxwky+QV5QULQGcwvqu98oJ/ow
	 BhOhhmt3yl1+CWtQXq6p91g0iTG3lSXVA8Kc53qxA8ikAh4zKaRHKRLUzT6JizoEOI
	 M8l7I4XRJcdaTGGEv5yaEoZ/k4w9bfz6FY384lA2gNy5TgSNeEox+I9Vlj/EeAYMz/
	 +T3YPfxxDIiBjT2lU2t5GQ/J03wNVMUPDAXAtrf72FxjIiKLBt9Orbrha0ztmWO6At
	 Z9jEe14hJF9P6h2waoed+9rGIMlehn55HOp1jl6Nw41WE2slxsbT12isVeLveUU9tO
	 Y4+mra4WJlbhw==
Date: Wed, 9 Apr 2025 06:52:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jacob.e.keller@intel.com, yuyanghuang@google.com, sdf@fomichev.me,
 gnault@redhat.com, nicolas.dichtel@6wind.com, petrm@nvidia.com
Subject: Re: [PATCH net-next 10/13] tools: ynl-gen: consider dump ops
 without a do "type-consistent"
Message-ID: <20250409065236.4f6426cc@kernel.org>
In-Reply-To: <m27c3t33yu.fsf@gmail.com>
References: <20250409000400.492371-1-kuba@kernel.org>
	<20250409000400.492371-11-kuba@kernel.org>
	<m27c3t33yu.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Apr 2025 13:38:01 +0100 Donald Hunter wrote:
> >          # 'do' and 'dump' response parsing is identical
> >          self.type_consistent = True
> > +        self.type_onside = False  
> 
> I'm not understanding what type_onside is meant to mean.

Damn, I have fallen into the IDE auto-completion trap.
It was supposed to say "oneside".
Not that the solution is super clean either way :(
-- 
pw-bot: cr

