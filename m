Return-Path: <netdev+bounces-205114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E22ACAFD6E1
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E5987B2397
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151CE2E54A4;
	Tue,  8 Jul 2025 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5VNrNWv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A5C2DAFA3
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001691; cv=none; b=rLxa06A3GTGOHo/nojpJhKZoBbdWkotoojX3ktj9d7Y0eSlEagUZBSoalt5cCU3h0P3VLCPAxzN6SIWjXhBDBAsnJd78pKxskfTWW+0Vi+46egP3/F8o/MLkFu0TwTf7j+2YngzqOkckbBPEQ2eTbeGDlM5MpVKlGfpdFlNO4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001691; c=relaxed/simple;
	bh=ZOCIEVL93EVZfhZxH5tb+LDXcugwRvY47JFGzny20vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUK6IfFWGaXtEP9zWz59wjeZlBM1SjlsWe9oCREbby5CsW/PHYomVnshuhiU9L2GSKPw6b/m5jvOxeaADjGWUVCTkTcVEfnZMICXBHaGJuBSCpSr1nQiiNiVLZB0WiNUIFftHBuumyAE1LhvRbg4j3qQS1xdyF40gycYp862hk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5VNrNWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F1BC4CEED;
	Tue,  8 Jul 2025 19:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752001690;
	bh=ZOCIEVL93EVZfhZxH5tb+LDXcugwRvY47JFGzny20vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u5VNrNWv/0891zpJW22rXhAnMLrISH8u2NalTtwjQM+Ey1DX3hXtN74LyBg3MuPMf
	 IQg2VbrcuILkU9SZMsZIMwdmtzO2swxoXuI38J1AiQea7TJQbLYW3mJiSP40AD7UJl
	 tSLNPQ/9k/Lxc3kaIWqSVecVFjCcz9c+n2BwlrNeF0SZivUwbbdRXZQFAe2zqmpDFQ
	 kNbwVeRyJpLxvxuhD0O/nwJ2N/hhmzDNqDBqtYdOGHzJVUfAEEtrRuOIel+lLYUZdz
	 XyH2amuNfKW+TqF+Of7h4/bynnoN/ogvEXdsavN0WxbPIDnuSmWVCpGZU0mh/T71hJ
	 m14XCHYMsjmlg==
Date: Tue, 8 Jul 2025 20:08:06 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 3/5] igb: drop unnecessary constant casts to
 u16
Message-ID: <20250708190806.GY452973@horms.kernel.org>
References: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
 <b6d736c0-ea5a-4b94-a633-dc54c6283895@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6d736c0-ea5a-4b94-a633-dc54c6283895@jacekk.info>

On Tue, Jul 08, 2025 at 10:17:49AM +0200, Jacek Kowalski wrote:
> Remove unnecessary casts of constant values to u16.
> Let the C type system do it's job.
> 
> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> Suggested-by: Simon Horman <horms@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


