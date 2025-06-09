Return-Path: <netdev+bounces-195837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B19AD26DB
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE79166D49
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63BF21E097;
	Mon,  9 Jun 2025 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGThvJb1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27BE21C19C
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497822; cv=none; b=R1nRDIFPAfJ8iHBQHl6zx7LNzVPHdkrDdFDM+ftdKhemYYIF1VSOy+4MP5dqpPGyUCB5ezFLPBBKVioWCBNYYbz5AOvbfhaBVE2U+exRLiuFntlXImxlDtDWTc1TrvlVUlEmHYkHltC6OApNcIeyuLk54Lc+A/7IeE7A1DV/tkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497822; c=relaxed/simple;
	bh=F+o6zCLV0Gbxnw9MU21nFijiIOLb5WJvKG19GXId5zM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QO3d8UBD2yFXbHH2bB3alH/W3afPBNDoA+pYX59z/p5QsiGy9V4tFkIaubfmH2NjuF65mE5yEJR+VLDOo/2AOmM/TSt+HDO+pGnGaXMY+loh5f8A4Rvh3z68if8NZS5fPjJ5nuN20XkNZKq6/o85NI6zZ7sEXfR31kjOzFIxLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGThvJb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB95C4CEEB;
	Mon,  9 Jun 2025 19:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749497822;
	bh=F+o6zCLV0Gbxnw9MU21nFijiIOLb5WJvKG19GXId5zM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PGThvJb1GLr1uPT1xEUnjItHVbDm98Sxwdf5SxSWg/uYjrPYCkfjIcxpmq5VFDj6u
	 WCwcBiu5TlbCri9Ek/OugzPl7AtL4Q3X73p+vVA1oPWiEpP9RcQQ3uLyilNu5MS+J3
	 IYjVRBG/oryBdqZptnKiO6MYax25uWbiW/ilgd1PZtOGk7lS2lkQmV7lKtdYZTsyr/
	 H2OIvKTwqCONnFAsquNI12VHWKa1ymTwdlfJ5kMEgzFI7t8XokLaCNyS12ZjqE+C5o
	 mP0ZWg8O1GlXQTTFUwKvd8sbejg8+bQH3kMfsFHEmU7UehjHMkIjcMXrSUfCtv8E0G
	 zi9lIvyL5S6fw==
Date: Mon, 9 Jun 2025 12:37:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Li Jun <lijun01@kylinos.cn>
Cc: davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 michal.swiatkowski@linux.intel.com, horms@kernel.org
Subject: Re: [PATCH net-next] net: ppp: remove error variable
Message-ID: <20250609123701.436aaf43@kernel.org>
In-Reply-To: <20250609005143.23946-1-lijun01@kylinos.cn>
References: <20250609005143.23946-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Jun 2025 08:51:43 +0800 Li Jun wrote:
> the error variable did not function as a variable.
> so remove it.

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl`` warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
-- 
pw-bot: reject

