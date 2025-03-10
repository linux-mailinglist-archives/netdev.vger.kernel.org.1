Return-Path: <netdev+bounces-173426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AE1A58C1E
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 07:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C21161FDB
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 06:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB18B1C3029;
	Mon, 10 Mar 2025 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWKG9w/g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C11A724C
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741588594; cv=none; b=COSxbu6iq4biYYEHa43nMJ6YKjHVmU/iV2TBdHgvpbP1HiAbBTqYc4S10j6JKFCZMFxU6l1QpF/3di+AoD74i/XuxV82m7RCZvNvHmdVwuCgOkK6sHmaQGSoUzy8FgI8T7azG2h/aRwEBGnumkrvYUXkpRXn3C9q3cLYBoD4TX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741588594; c=relaxed/simple;
	bh=N7IbZw43usuf2J6c0ZPz8uQwIYyf7oRFPAD7gCYAX8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUKGdNehIfJhsxow/4WmzSUXfUjXfvpQrKi9JhTQtCfqW9Q0b0FM/SLF5PHP6z44Hwsi0PCyRuqgRZUEzAdhLLCqRuVXyLaw1EDEpnwRA0jRawCp4qWulmMDxwmV/60TtVJKUW9W0BoOHR1s3CDmQTmlCtYJgo3w8QRI8VboA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWKG9w/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE09C4CEE5;
	Mon, 10 Mar 2025 06:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741588594;
	bh=N7IbZw43usuf2J6c0ZPz8uQwIYyf7oRFPAD7gCYAX8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWKG9w/g1+ac6sEr580xq2ibwUXQ9mXGfdivinh/YybcNW4mcS/fIeYdsjZnDUWwF
	 WEKUv7POHSGD7XKItpfJLgvm8/DmFyK+R5lgQiytAKHZPDXtHrXyxUVeBnDA42ws3Y
	 8IMyYmmtUQM/tnxYwrzMxpUhji7iPU+OBJbcrjVHdN1MsCbqOEZY3q5V/dnY32WAQb
	 BynKDJHPzX0Vt6I7lepHkOhPtF6DvL626OPii029VNF0tGdIKuB+2tf8HUclcAlSOz
	 trDJTsfHWx7ff4hhG4CkXSy9H9X4Xj0qpeD52ArLELJArbMJEk75lmLyn9zyohiUhS
	 sN72IpG7uQrag==
Date: Mon, 10 Mar 2025 07:36:26 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Rui Salvaterra <rsalvaterra@gmail.com>
Subject: Re: [PATCH net-next] r8169: increase max jumbo packet size on
 RTL8125/RTL8126
Message-ID: <20250310063626.GG4159220@kernel.org>
References: <396762ad-cc65-4e60-b01e-8847db89e98b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <396762ad-cc65-4e60-b01e-8847db89e98b@gmail.com>

On Fri, Mar 07, 2025 at 08:29:47AM +0100, Heiner Kallweit wrote:
> Realtek confirmed that all RTL8125/RTL8126 chip versions support up to
> 16K jumbo packets. Reflect this in the driver.
> 
> Tested by Rui on RTL8125B with 12K jumbo packets.
> 
> Suggested-by: Rui Salvaterra <rsalvaterra@gmail.com>
> Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


