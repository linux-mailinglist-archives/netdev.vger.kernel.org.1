Return-Path: <netdev+bounces-206827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FECB0474E
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CB73BDA30
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55C426D4D4;
	Mon, 14 Jul 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5Nx8/RB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7F26C39D;
	Mon, 14 Jul 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516636; cv=none; b=oqcMUiPL27LFyHA5Hzwi5Rzzlr3Jm1+0vQZbNnFlp51kmwh5Tis1HcWb8mq1o7WeylVcStwoN2TLwCOzJuu4+krgwVj9npSloumqtw63H3U3HlN0LMCpr+LvL7M+tZ2rGmUKv6gIXojwGjIUOoVXqzVuR9BYkAUI6fDyCmNP2uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516636; c=relaxed/simple;
	bh=zjb61XviARN9/mirHwvNakHisZ82nPSFvJHMsXCOjqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC1sR+xXkbpALE4Wf9RR0omc0sGXqTpQtmLgg2P1hykv4O5hp2hZny526r8TXpIwj3vcp75NrRPwHFm68eq5q/mJVEk+beYQD6KzJhkSS8Xgg+PDK0lukp5wcZ4dbp1GAnMVyvm2eEpxDV6rsAYuv47gzvL+JqM0CMswT87RyK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5Nx8/RB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F2DC4CEF0;
	Mon, 14 Jul 2025 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752516636;
	bh=zjb61XviARN9/mirHwvNakHisZ82nPSFvJHMsXCOjqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5Nx8/RBdkyc+go2KxSBY6J1/50bKl5Yteg/5gigNWbKdJfhSMbRVCNJe/RvELz9h
	 xNLzmWOpit31pv7S7bCI+6qcW+J3G81T2KxA56ZOzfELwU0E6RUrB+peW6Apu7fm3t
	 zexc8XjxI5YWn0H2G0JzvyP0+2nNZZ54lHpwgR+5Z/+yCV8QpxyPHe0a8SMyq6jWjZ
	 waKPbkz88LVWA9H6tlSogCpAFMjHzDQg0drD9/mn300+0nN4LLQ9fWL/WrSHcj14ky
	 n7JIbwU35xOqk1aWucHAR36XCPZ3cY6bUV1AsUuz1jVh6J1EbBozvy5zsoJuqzwqZo
	 O/02zxNIL/W9w==
Date: Mon, 14 Jul 2025 19:10:32 +0100
From: Simon Horman <horms@kernel.org>
To: Wang Haoran <haoranwangsec@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: We found a bug in i40e_debugfs.c for the latest linux
Message-ID: <20250714181032.GS721198@horms.kernel.org>
References: <CANZ3JQRRiOdtfQJoP9QM=6LS1Jto8PGBGw6y7-TL=BcnzHQn1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANZ3JQRRiOdtfQJoP9QM=6LS1Jto8PGBGw6y7-TL=BcnzHQn1Q@mail.gmail.com>

On Thu, Jul 10, 2025 at 10:14:18AM +0800, Wang Haoran wrote:
> Hi, my name is Wang Haoran. We found a bug in the
> i40e_dbg_command_read function located in
> drivers/net/ethernet/intel/i40e/i40e_debugfs.c in the latest Linux
> kernel (version 6.15.5).
> The buffer "i40e_dbg_command_buf" has a size of 256. When formatted
> together with the network device name (name), a newline character, and
> a null terminator, the total formatted string length may exceed the
> buffer size of 256 bytes.
> Since "snprintf" returns the total number of bytes that would have
> been written (the length of  "%s: %s\n" ), this value may exceed the
> buffer length passed to copy_to_user(), this will ultimatly cause
> function "copy_to_user" report a buffer overflow error.
> Replacing snprintf with scnprintf ensures the return value never
> exceeds the specified buffer size, preventing such issues.

Thanks Wang Haoran.

I agree that using scnprintf() is a better choice here than snprintf().

But it is not clear to me that this is a bug.

I see that i40e_dbg_command_buf is initialised to be the
empty string. And I don't see it's contents being updated.

While ->name should be no longer than IFNAMSIZ - 1 (=15) bytes long,
excluding the trailing '\0'.

If so, the string formatted by the line below should always
comfortably fit within buf_size (256 bytes).

> 
> --- i40e_debugfs.c 2025-07-06 17:04:26.000000000 +0800
> +++ i40e_debugfs.c 2025-07-09 15:51:47.259130500 +0800
> @@ -70,7 +70,7 @@
>   return -ENOSPC;
> 
>   main_vsi = i40e_pf_get_main_vsi(pf);
> - len = snprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev->name,
> + len = scnprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev->name,
>         i40e_dbg_command_buf);
> 
>   bytes_not_copied = copy_to_user(buffer, buf, len);
> 
> Best regards,
> Wang Haoran
> 

