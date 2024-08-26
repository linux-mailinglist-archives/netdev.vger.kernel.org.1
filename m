Return-Path: <netdev+bounces-122046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB1E95FA9B
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1151C2202E
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01741199EAB;
	Mon, 26 Aug 2024 20:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2a1nGfK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD5D194AEF;
	Mon, 26 Aug 2024 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704047; cv=none; b=H15u1EANI7Ht4i4JyKFRc2uVn9TssTv4TTOaUtzUMBluxtjkbsLjop/wfSXGWKc/3Msj4I/4+KbutwD4VaaLl1Kucjene+23+DwoCLJHEcwFkPWM8r4nxEVJAXbIKsEWgkYGe4u9BJgiakCtaeuu/UEeyjFJGN9sd7pzFLRbOlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704047; c=relaxed/simple;
	bh=MoqD/ULYzH64mjaZLoArehxYZyBV1+b/qEHFGE/6NaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6B/18NpzoM0GM8LuQ4y8KpUY6qxolNz2sTjCD+ucjhKg2sEt/rKACUMFehZcu/TOYsyG9P/DnEBr7STjE/1Il5YuGZNiasYuOK33Ia1AVMTu+KOoVvTPMyy6U4ciqK5szZv7HPqss/BingES6Z4kOmKaWyB5IJFqPrUc3q/vFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2a1nGfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188C3C4DE1D;
	Mon, 26 Aug 2024 20:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724704047;
	bh=MoqD/ULYzH64mjaZLoArehxYZyBV1+b/qEHFGE/6NaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k2a1nGfKF2klfKcTas97l1M+biwXg+6QC/R40bj9wCpHG+WMlXupg488iA6Wc3W5m
	 X1FRL/jDT/SJmRszc7co0WSo+6yf0RoPq675pbMO28F5QDsRTxRDqgE7sLLvn9Eqec
	 Qn7wwUVRkb23NlQb96ONkN8pJDGdjhuGBvh2yL7HJGO/RVz+hy/6Biq6TYu5dpC1ZI
	 sDpjUCq+8TH+j4CkbbQdHX0pRVaw0elcad7wwDZ3WuQHN9du7oKZq35HuuLtEGfmWR
	 T45CtOo9OogHSRsWllKQa+Okx01CWIPwTDnUNFZ8Ymsrzke+/WiLe1cN3CBUOaagmI
	 Gke51eOqqYnKg==
Date: Mon, 26 Aug 2024 13:27:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yuesong Li <liyuesong@vivo.com>
Cc: mark.einon@gmail.com, davem@davemloft.net, dumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH net-next v2] et131x: Remove NULL check of list_entry()
Message-ID: <20240826132726.25570e37@kernel.org>
In-Reply-To: <20240823012737.2995688-1-liyuesong@vivo.com>
References: <20240823012737.2995688-1-liyuesong@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 09:27:37 +0800 Yuesong Li wrote:
> list_entry() will never return a NULL pointer, thus remove the
> check.

Unclear to me whether the intent of this code is to check for empty
list or this is defensive programming. Let's leave it be.
-- 
pw-bot: reject

