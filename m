Return-Path: <netdev+bounces-178622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE46DA77E34
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF14016AE01
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 14:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2D205506;
	Tue,  1 Apr 2025 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNZIG5cC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A8D2054FD
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519047; cv=none; b=fhXpwbw+nfWOViPxydKQmglz3J5kt1vXSNiWdcieZHGVLyjyEpqNJ/tySX2PAZjXlY/bRVbFw3PAZ130AMAGMgsNjJo4svdCbdEE0aLkL304Zn2MqVtLIbUp93HY9yTa7vv4mENeESUup8TCreG1W5mC7+xC99qyoXYULR4y4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519047; c=relaxed/simple;
	bh=CWajsIlqDf/1Umo15Bw5UjonTEiogZdpTNQccNpgwdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcv8aiNXLRnCsIkZt8mKS5D/HKUmH4hIPRZrh+pexkdj4Drb9eh/XxJAIbiNcHr6kK9gNQ6lD/fIgQ29cNY++PcLeIyFXqs4y7z21m5lulrr7eSWyQ7U0R6dxDJk0Mg3g5fgtfQf9KRKd+I1nBtjjZ19jRzGBIZzpQXWD0Yd9FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNZIG5cC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60E6C4CEE4;
	Tue,  1 Apr 2025 14:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743519047;
	bh=CWajsIlqDf/1Umo15Bw5UjonTEiogZdpTNQccNpgwdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YNZIG5cCrIy/b+mV0Tocqf8hYyEVQ4wYpz4OBG3rYP8uplmHrQZxMCGYm2eTjgBmP
	 clHT/W3TMrsJZMvd7LI6JBB67geh/M7cUDdw+Qkx4GqCH7GK8t0qdEljfaRDSt5NOA
	 96b92SzB3vCppiTgWnjk8xvyk+D/nZjKs+6LQV3fxjBonBrwsfypCPEX1iH2zgrFY/
	 y3KIl38SH9Gk/XXAEOnuk4bH2zeMQL2PRYEZ/LFn4j08WIryRiB2M7A8w1QzLyfL0Y
	 kud7NcnhuQt/WQsRr6uQ+rz3UXJxOFUwcgMwi1pdo7FZZmgwmmHdOvzhBsA8azhGMO
	 UNs74sF6wNsAw==
Date: Tue, 1 Apr 2025 07:50:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, "jiri@resnulli.us" <jiri@resnulli.us>, Leon Romanovsky
 <leonro@nvidia.com>, "edumazet@google.com" <edumazet@google.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: net-shapers plan
Message-ID: <20250401075045.1fa012f5@kernel.org>
In-Reply-To: <a3e8c008-384f-413e-bfa0-6e4568770213@nvidia.com>
References: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
	<20250328051350.5055efe9@kernel.org>
	<a3e8c008-384f-413e-bfa0-6e4568770213@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 11:35:56 +0300 Carolina Jubran wrote:
> > As mentioned in Zagreb the part of HW reclassifying traffic does not
> > make sense to me. Is this a real user scenario you have or more of
> > an attempt to "maximize flexibility"?  
> 
> I don't believe there's a specific real-world scenario. It's really 
> about maximizing flexibility. Essentially, if a user sets things up in a 
> less-than-optimal way, the hardware can ensure that traffic is 
> classified and managed properly.

I see. If you could turn it off and leave it out, at least until clear
user appears that'd be great. Reclassifying packets on Tx slightly goes
against the netdev recommendation to limit any packet parsing and
interpretation on Tx.

