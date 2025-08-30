Return-Path: <netdev+bounces-218432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEC6B3C745
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999803B0415
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E85A2080C0;
	Sat, 30 Aug 2025 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7sz5onI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2718B1F3BA4;
	Sat, 30 Aug 2025 02:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756519367; cv=none; b=SzQH1RSNjahS5V94+vSYUaC5dEbkVA97m8g78l7bs7RX0aLiXvP4eS5KJBAxwK9BBmI7PEXs1OXQ/W53BcLC89Po3TWlyzMl44ONO9XP9Oz1BkCCcnrxVlU8ktCzaQbHFNhmv5gMsduXTxvX2kZALq+HSWePA7u+HujjnBrPiVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756519367; c=relaxed/simple;
	bh=lRySVHJ445g8/J6nGWxlARMTZRZWmSDZGYPLohj7LoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIPRktRZdHLTJ75kDtBYdoCCGCVQ9dvjzlowQaNqfE9Bqf+tPi4t6cJtSAmo/rA+oCVVB5rrvMrwGgww/mUH1TPQYL9D4nJVpSijU9N5UO2JF1Mu/69D2+lU7ZNuJEcaoAP2NRKM+AxvdrCOtKv5WF9qRZg0I62cR7sD35pzQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7sz5onI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C079C4CEF0;
	Sat, 30 Aug 2025 02:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756519365;
	bh=lRySVHJ445g8/J6nGWxlARMTZRZWmSDZGYPLohj7LoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o7sz5onIiFfELGQceZYcSXO6K5KEWeINKXr/9LRWjUyA9U5Tn/PxHnRC9rMmuI6I7
	 msrA6FK3GuS8fIfPPrQYOZfB7+huZ3r8XdaJZ3vXKXqu5JJEwNcHs6IbV3TRJQkU9k
	 RzItEZVEcW6B+80CGXdXaO7L52a7yrE9yAGErceWItECOVfdQYqcJzHufYNvncCMAp
	 uvSBJSlBEdQ+A7YQ/cwu78x8W5Di2Z9dXdhypCQGmQaIKRrJqZtJmozf76J1ZHD2ID
	 xEQyXUjNR7tDn3sa/sD97gArwxOzhdGqabHz8nIwcfNOQj1VaYAo7VO95U+KMB0KCc
	 pEAgNpCsJdOgQ==
Date: Fri, 29 Aug 2025 19:02:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: qianjiaru77@gmail.com
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] VF Resource State Inconsistency Vulnerability in
 Linux bnxt_en Driver
Message-ID: <20250829190244.348ce433@kernel.org>
In-Reply-To: <20250827135102.5923-1-qianjiaru77@gmail.com>
References: <20250827135102.5923-1-qianjiaru77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 21:51:02 +0800 qianjiaru77@gmail.com wrote:
> Subject: [PATCH v2 1/1] VF Resource State Inconsistency Vulnerability in Linux bnxt_en Driver

Please look at the git history to find out what the normal subject
format is. Something like:

  eth: bnxt: fix VF resource inconsistency with old FW API

is probably a good choice.

> From: qianjiaru <qianjiaru77@gmail.com>
> 
> A state management vulnerability exists in the 
> `bnxt_hwrm_reserve_vf_rings()` function of the Linux kernel's
> bnxt_en network driver. The vulnerability causes incomplete 
> resource state updates in SR-IOV Virtual Function (VF) environments,
> potentially leading to system instability and resource allocation
>  failures in virtualized deployments.

Please *succinctly* explain what the bug is, assuming the person
reading the description can also read the code. Or should I say 
ask your LLM to do it, 'cause I really doubt you wrote this bloviated
slop.

> Signed-off-by: qianjiaru <qianjiaru77@gmail.com>

You must provide an appropriate Fixes tag for fixes in the Linux kernel.
-- 
pw-bot: cr

