Return-Path: <netdev+bounces-242486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1B0C90A3F
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E0E44E0598
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6CE22423A;
	Fri, 28 Nov 2025 02:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfCf+h2v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056D981724
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 02:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764297535; cv=none; b=TfUkqD2fut8fNet8bVPMA2epKIn7nTl+kvH8Fb1hogU7B19s9t5DDUJnUHt7bheJW2Qz3UmupF3sxWgryqOfbAluPA2nCn/h3wXHpvU5+bRC+DZs6GOtpCL2nodCD9oYyNglShjmAmKycx68TVlYsFZmVzu4tlBaCis4/jtldM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764297535; c=relaxed/simple;
	bh=TUByFtko/0pKd0Q/aXFmbTz12NWMoXgOTpkvb00Z5B8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umneCbWxZ37O284EfHJ88eKkyyrPjCjYDSJYuCVk2f9cwvjn6ekeGrbijdE/3KMnSdAzWZLPVm2PwdYmarMoVdq1kBkq+JHE+CL3jai+pyqs8bQDJU68KAznp7Qz7o+VAADKcGg294zY1+1hGHjrkqFFBkXYYxbwcmdBV30/wK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfCf+h2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E73C4CEF8;
	Fri, 28 Nov 2025 02:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764297534;
	bh=TUByFtko/0pKd0Q/aXFmbTz12NWMoXgOTpkvb00Z5B8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UfCf+h2vJhuyqm5TyOLUov10RZ9Ot3j+RmNEnl+ZlK1HXYt6tMv92Y8XOz6016wnA
	 /L9xq1998aGpCTO7WyVEg06NoQnNQ7i1TzLXTeQ3e//+JmtcCwHSS9Uzuw8brewQ8l
	 XC1Bfg1P8D4Ih05Cl+8D81p+7nfov8f2idOo9x0wyf/Ml8ZzOz0AlMAOXvzkvmLM58
	 sTZs2qRMFPJdrGoZv8oeBvf9+nMmmTeeh86Qwz8EUVviUfObulE4vjdW8+Qp3rnGQP
	 fwGw6qKJz75rHOHTZZ2CI7qRQDjmBSvIigip9o2y0PTihlt8QaBwHmeYSMcUxIS0T/
	 kMHsqccfR8gjw==
Date: Thu, 27 Nov 2025 18:38:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 00/11][pull request] Intel Wired LAN Driver
 Updates 2025-11-25 (ice, idpf, iavf, ixgbe, ixgbevf, e1000e)
Message-ID: <20251127183853.2158cfae@kernel.org>
In-Reply-To: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 14:36:19 -0800 Tony Nguyen wrote:
> Arkadiusz adds support for unmanaged DPLL for ice E830 devices; device
> settings are fixed but can be queried by DPLL.
> 
> Grzegorz commonizes firmware loading process across all ice devices.
> 
> Birger Koblitz adds support for 10G-BX to ixgbe.

Ah, looks like I accidentally left it Under Review in patchwork.
Let me pick out the changes to drivers unrelated to the reviews then..

