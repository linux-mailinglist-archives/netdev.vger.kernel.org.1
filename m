Return-Path: <netdev+bounces-73097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6E285AD7B
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 21:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D7B1C22604
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3664B535D5;
	Mon, 19 Feb 2024 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkGHp6FV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E20482FC
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375880; cv=none; b=Jl+zofkmXayuG7s+CzuafP/R20zgEw+jFi2gdwY5iY1usr8+gAzsRqYHKg6Iuu3N09Kgq/oYxd+mjSESgHkEyT8X89RSAJpSKDcN1JwxYc/ldwHUBDecrJMwt+XPv/gq4a7xNnj0XsRUf6TMxoD1Db3YkUtDIp54C+5CWk4ksgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375880; c=relaxed/simple;
	bh=cSB9RJTIuQgGEkE56EEwFF6SVQCVQBLfzkUZKVnuJaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDCJYlGD29hLlRNHiS13rLdtqVcxM+MTk9g39CaLfw56CroiD0U5uyX7cfIXlGjNxwmP0yrgNT7FcPc+8cicVxpcIWI0ws47Vpng0NrHYP9PK7308IzIg2oIQ13zrWchKR7vYnThtTOS93nmKY4SZusL5V0hMlvNyNXvrP2i11s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkGHp6FV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFC0C433F1;
	Mon, 19 Feb 2024 20:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708375879;
	bh=cSB9RJTIuQgGEkE56EEwFF6SVQCVQBLfzkUZKVnuJaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LkGHp6FVmABQfxec629lK/EzkY6hM7egA+RwEA5nPkLH2nYcEMkvIukfGzW17R7Ai
	 uqBMlDrE/YB+VOovRRoOQwn/X00lMDOH2OlAcPGLKPcRxnJw5ibJBpz1j8Njy8D9BL
	 N/k6OnhbGxS73tN0iXmoCldhc51TPbFEdnB/lY9Lgn4zBnqETiWwlCTQuqa7bOmh2I
	 QtUl8nsg2jX7eH3BPM752mm7KL8mfFik24lrevNDJFAflKt/aGKc79UkUVmWd0G4+F
	 v9B24vxd0JdcnQSK8PSBxe97cZh1oR3YAE3bgo0GWMSIE4EwFM3u8YJvEUccGzu6dW
	 ZLBDL+XzqPF2w==
Date: Mon, 19 Feb 2024 12:51:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com,
 swarupkotikalapudi@gmail.com, donald.hunter@gmail.com, sdf@google.com,
 lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 04/13] netlink: specs: allow sub-messages in
 genetlink-legacy
Message-ID: <20240219125118.27eaf888@kernel.org>
In-Reply-To: <20240219172525.71406-5-jiri@resnulli.us>
References: <20240219172525.71406-1-jiri@resnulli.us>
	<20240219172525.71406-5-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 18:25:20 +0100 Jiri Pirko wrote:
> Currently sub-messages are only supported in netlink-raw template.
> To be able to utilize them in devlink spec, allow them in
> genetlink-legacy as well.

Why missing in the commit message.

