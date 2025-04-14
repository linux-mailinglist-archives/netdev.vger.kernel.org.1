Return-Path: <netdev+bounces-182148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB4FA8804E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CBF18957BC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0633727C873;
	Mon, 14 Apr 2025 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kHWyuBla"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C281E505;
	Mon, 14 Apr 2025 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744633468; cv=none; b=X0UmXj2LnAQZR7yjeiZlkq3FIKCU/fQ7ovyR42HTW1hOl/zPnPpjd4GUUSbenZx9Ld6uW19oqo7m1eVDfgfclGNuracTxM17scIymBv7N5ZDAixZn6r7ZKB7ivlsi86p1BbPp5UoTxlrorgvorlFPPanf/pwqbM/3rWeeqSvMpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744633468; c=relaxed/simple;
	bh=j2y7Sd85khWXnLC1ZR5qY0qfU5SvTx1/61VbGsYOK5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hxxvn8DZsl2elAFVDt6JGNOvqR0UOzrl2hXogbDNL2YiXjBdK6bPdNxjMXN9vSaEeQ7t5zCSsQvga74u5IyBSWOF1GP6qLrAPnhkCDn4ceo9A1bnFYGIarBmCfuKzJII/JSV6wwXr2RHS9o6TohO5IJfUW5DBTXX2L7HWOQQXfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kHWyuBla; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rphO6DU1W0U+JZUnu44tb3QuUigIMOv2WypHCAsG23M=; b=kHWyuBlaLGhRYJpKgSt812x1Kj
	x/PiUfgxSwTW5sNSBq2U30e0SVWBRdPzpuMOhOs+R5rwgTuVSJaBUp8mVssqV3gz3eLpmRLt33dXw
	mH06suLUorRAjyVlrRF94kcwtMicDfk0OWGFsFflgHsCInZxIfB+nSo+DI+R/raWgQs0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4IrN-009BNB-3c; Mon, 14 Apr 2025 14:24:21 +0200
Date: Mon, 14 Apr 2025 14:24:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, pkshih@realtek.com, larry.chiu@realtek.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net] rtase: Fix kernel test robot issue
Message-ID: <3d5a5a7d-a8fb-4a6a-9f3d-3ea27f9d06e7@lunn.ch>
References: <20250414093645.21181-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414093645.21181-1-justinlai0215@realtek.com>

On Mon, Apr 14, 2025 at 05:36:45PM +0800, Justin Lai wrote:
> 1. Fix the compile error reported by the kernel test robot by modifying
> the condition used to detect overflow in rtase_calc_time_mitigation.
> 2. Fix the compile warning reported by the kernel test robot by
> increasing the size of ivec->name.
> 3. Fix a type error in min_t.

Looks like three patches should be used, not one. You can then include
the details of what the test robot reported making it easier to
understand each fix.


    Andrew

---
pw-bot: cr

