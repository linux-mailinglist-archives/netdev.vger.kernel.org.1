Return-Path: <netdev+bounces-215441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A34AB2EAF3
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C745E4D3B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E491A9F84;
	Thu, 21 Aug 2025 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XM+h6maG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBE65FEE6
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755740752; cv=none; b=kDmMHpsrm+WEynyKkDBSkDBioQ58Svj4bDg6d8uhgsivBklkXyWHGS6j9Ou7NvvSkMlHJDUOPam20LBsGCcZqQSbVwSqKTgL5Un3zDgtz1ZKw+E/aEB3SWYRuSD9OgDl6OSZ89oyWS4+wVBN2ybkYPdF3+knGuOefqrGA9jhK6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755740752; c=relaxed/simple;
	bh=MUymcHLseFDdkEAot59LOXnmmJnYPvWrvxEpDPKujK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDrhkQG62T+HBMJ7jXThhvhnEQrttAjUOOnOn6pvY9Vqi2MGuF+HLEdDbannLE02vWg4GDKve5Dirnx42jO2i54lFu9bEbN1DQXu2xmFFiS8k5j0MAjLu9cGyRDohD3FLU082g8ywl0iHRE8Aeu0Z7gsX5z+PydFeeROg+l8U08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XM+h6maG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62116C4CEEB;
	Thu, 21 Aug 2025 01:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755740751;
	bh=MUymcHLseFDdkEAot59LOXnmmJnYPvWrvxEpDPKujK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XM+h6maG0KItWz10Fi7UUzCtmOKihVmRk+V5eHWACIFJG1GYwjcsLMc7RD84rDKx2
	 edp+IYEZjCnT9UtN3Ef8fotsR7Ysac70i/oh9HN3g4cyBdDXJSAdPWja3yJ2VLOS7y
	 0eO0Vc/h0nEYjE8Q7Msgf3j6cxXXFmvrguAY+V0TKElc3y3ge35P0njNwUfgBgQMJw
	 apB5MVUZ4pjc4J+QDBhzJReYHUDXSRby9KUhKML+upOELUPTyZv0siR1uwJA17w41r
	 4QRcyRw1bk7p/EK5dCStZL6TQgPSe7TA92frTsUuFElZCSxWkRXYXb56lQYhsoo0iR
	 6rHInjq8tiSpA==
Date: Wed, 20 Aug 2025 18:45:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 0/5][pull request] Intel Wired LAN Driver Updates
 2025-08-15 (ice, ixgbe, igc)
Message-ID: <20250820184550.48d126b8@kernel.org>
In-Reply-To: <20250819222000.3504873-1-anthony.l.nguyen@intel.com>
References: <20250819222000.3504873-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 15:19:54 -0700 Tony Nguyen wrote:
> For ice:
> Emil adds a check to ensure auxiliary device was created before
> tear down to prevent NULL a pointer dereference and adds an unroll error
> path on auxiliary device creation to stop a possible memory leak.

I'll apply the non-ice patches from the list, hope that's okay.

