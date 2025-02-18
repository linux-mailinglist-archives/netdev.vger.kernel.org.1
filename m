Return-Path: <netdev+bounces-167354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D2CA39DFC
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C68B7A1AEE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1245B2690C0;
	Tue, 18 Feb 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y46YiI93"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6827B1E526;
	Tue, 18 Feb 2025 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886834; cv=none; b=JwYefGAr+Gs/vMaoGycpEB3hi7BkBIh8jeQmIvzozLJ6ai0nTwQ96SsXunLrcjzuNwIHzGZBXaspLK9SspBjNu4lANeaKo007NoGDJj5UJKyHFvNSQ29CKHjDPQMN4RHqlTq6M8YDQVIToNRTWTyhdgN4/2zWr+3pnhute8tcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886834; c=relaxed/simple;
	bh=5z8LWbagXI192t7ErCCaDDR4VEao7+VdxE2ykFoYsQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5ok1TuZwEnucTQr9qRsrGLAXg+cwd2j28D6OScW8NEN9rOPqGXSJc7WSqaABuyhJmRqaLpBEQ6ygFdf0nzTyubfpKMfbx+96KDAdETP8AfW/hxtfgyLPNN9XXcmPLW3cN8IgOyHNZlIADlBDQfwSZM+tRa3G1zwMW6KMDEkOA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y46YiI93; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Sbc2+CEAosb7qsh0nhv9B7+VQ83pKeQ+1D580JpcUF4=; b=y4
	6YiI936r1QW9tdqY34NmtuOs5tHWTRG/GYEGFIHtgiTcKNCS75VgvrCnRhSbqzP7QmvBeKdwd53+r
	GiG6ENcbXAt5Y4Ln9R0DnKJzAzo5jPwdPIfvRFW2hQZjd6QHnvZ0Oqi3hQ0VW/pDR/gr2+AusAb/3
	2HHay/7VO4Dbvc8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkO2d-00FJUV-O5; Tue, 18 Feb 2025 14:53:39 +0100
Date: Tue, 18 Feb 2025 14:53:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [PATCH net-next v2] net: Remove redundant variable declaration
 in __dev_change_flags()
Message-ID: <4c2fccf4-8754-429c-9d51-903889714b3d@lunn.ch>
References: <20250217-old_flags-v2-1-4cda3b43a35f@debian.org>
 <715a9dd2-4309-436d-bdfc-716932ccb95c@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <715a9dd2-4309-436d-bdfc-716932ccb95c@6wind.com>

On Tue, Feb 18, 2025 at 09:35:55AM +0100, Nicolas Dichtel wrote:
> Le 17/02/2025 à 16:48, Breno Leitao a écrit :
> > The old_flags variable is declared twice in __dev_change_flags(),
> > causing a shadow variable warning. This patch fixes the issue by
> > removing the redundant declaration, reusing the existing old_flags
> > variable instead.
> > 
> > 	net/core/dev.c:9225:16: warning: declaration shadows a local variable [-Wshadow]
> > 	9225 |                 unsigned int old_flags = dev->flags;
> > 	|                              ^
> > 	net/core/dev.c:9185:15: note: previous declaration is here
> > 	9185 |         unsigned int old_flags = dev->flags;
> > 	|                      ^
> > 	1 warning generated.
> > 
> > Remove the redundant inner declaration and reuse the existing old_flags
> > variable since its value is not needed outside the if block, and it is
> > safe to reuse the variable. This eliminates the warning while
> > maintaining the same functionality.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

