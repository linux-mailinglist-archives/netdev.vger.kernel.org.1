Return-Path: <netdev+bounces-196737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C91C4AD61F3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48431899707
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BB2228CA9;
	Wed, 11 Jun 2025 21:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3unw4LjE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277D71E376C
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678879; cv=none; b=ZvqSUaI1eXWInKkSRHwA/4hYvxQE8QI+xxtyrZniGTNqn0LqaLZ9PrCQCIItCVNYmzEOJSyKDiVhY0jBA2ofE+P6DDK3QiomuPMWf44ErM6ndTGHOyiVJ0g6Ovwi9vmlRBEhwHQl9h6vZLqNCg9Bv0idXBBPH01EkZYWsPtYi80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678879; c=relaxed/simple;
	bh=GuZNk/LX1sDfa1H74bNw12LfYSjZRlGfoDps5wDLPbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zf34j8n9dZFOkyqUzfDcy2FKhqwrA5RfxfQphu1sCas6P3/UkYISZ/WV/p8y/i8Na8USWY1S9fKyom91bA7H9kG5xUKuGaC0uqOhaOtrwg2TK4J5UK96+mmO2HKruRPqLnFkC+5kF+mU459kcL2tW/ZB1cUvqk61w8IS5f8RA/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3unw4LjE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w+DrNpiWZPwCmdhyUp5QZplOdv0f5LqQFW+E20Kyel8=; b=3unw4LjEVY+UpMkmw78njzBMOF
	UCJExB4mX+L5B5GU/o7bq65FQN+Nnudv3nRUHK/IEXYZRlm7KFstNTyLO0JYXmrFI+UUwYn6z6BSA
	R0g2r7MFm6hM4GtVsF21XAkLOl399JtK2Cm6rc+NCYWe1ouqA2N63/R5jjSJ4S0HkfYk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPTOv-00FSU1-Gg; Wed, 11 Jun 2025 23:54:29 +0200
Date: Wed, 11 Jun 2025 23:54:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
	sanman.p211993@gmail.com, jacob.e.keller@intel.com, lee@trager.us,
	suhui@nfschina.com
Subject: Re: [PATCH net-next 1/2] eth: Update rmon hist range
Message-ID: <e2196bf7-5e97-4235-bf99-f6d546e6f621@lunn.ch>
References: <20250610171109.1481229-1-mohsin.bashr@gmail.com>
 <20250610171109.1481229-2-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610171109.1481229-2-mohsin.bashr@gmail.com>

On Tue, Jun 10, 2025 at 10:11:08AM -0700, Mohsin Bashir wrote:
> The fbnic driver reports up-to 11 ranges resulting in the drop of the
> last range. This patch increment the value of ETHTOOL_RMON_HIST_MAX to
> address this limitation.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

 

