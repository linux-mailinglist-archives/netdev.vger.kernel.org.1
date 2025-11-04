Return-Path: <netdev+bounces-235298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C20C2E94E
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 01:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BF93A3488
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 00:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FC2189BB6;
	Tue,  4 Nov 2025 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3AcNzVV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1E12E1E9;
	Tue,  4 Nov 2025 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215858; cv=none; b=I1GUPmW/tXBGTQoolhAYw7+46gWzsLceZM8p4Jwld6yYDQLHfZ750QHfJsvbz2pkWatOIfXVuAGpoEOSEBPVYAF5jSm8jUTj4nNROTB7mavUtvyOeiVfgIOvgfYuDDEUWKvQDaqbPHswjiLKIf1QybZT4AMtkLnoLr2DcZ3H3U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215858; c=relaxed/simple;
	bh=kLljg32RAqlWC1AxctjyBPAIxHDpYsbQCBgwIsrBd6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LuOEHlK+iibiyvFy/zIaNPEKuQOuPWAXYuay6F/J8eLZq/1W8/PjZLpSUmkCWrqQ4oueGFJOCk45i0CezYLIQPhI7ldz0A03hJJcsYhFb2a9Fxhs3j9irU66nCMAjKVHpWix6o+nR/NjYLZgHwDSt3Ha+e7BGzm3vMIBZQto5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3AcNzVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A30C4CEFD;
	Tue,  4 Nov 2025 00:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762215858;
	bh=kLljg32RAqlWC1AxctjyBPAIxHDpYsbQCBgwIsrBd6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X3AcNzVVdFuPefH0Nndnao9abMHQFWbkEekGsYnIrKa5nPwv3zbcha7+zeoVVRPdl
	 WGS2hAFIEEU8caqq26jfyVzREun9dtZ8BjZomVI8WcWm7TKupEur1gh6LhKlIhKJkU
	 WUEwOXKkFvOqUlIJarzxO0ElXsqvjjw/kX6qycQDKRioEexjMVb4b7SxYqq2d8OV6S
	 nrTMNunJswkzv29hIoXf/E91Ogu5FnEREVLBQnzeng09qPYf2UV427Y+BRDfl5aPor
	 FpQGGr/KabM/lL387PkCM+k409F/QTChTCr2hHshbEXBhzLfazxktUJWSbCrOqVSyd
	 H9C9RENLU8R0Q==
Date: Mon, 3 Nov 2025 16:24:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bo Liu <liubo03@inspur.com>
Cc: <ecree.xilinx@gmail.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sfc: Fix double word in comments
Message-ID: <20251103162416.788bca9f@kernel.org>
In-Reply-To: <20251029072131.17892-1-liubo03@inspur.com>
References: <20251029072131.17892-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 15:21:31 +0800 Bo Liu wrote:
> Remove the repeated word "the" in comments.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

If you're doing typo-style fixes please fix all of the problems in
the file.
-- 
pw-bot: cr

