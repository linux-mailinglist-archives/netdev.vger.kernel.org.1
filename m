Return-Path: <netdev+bounces-152156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E629F2E86
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 11:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630EC188611A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D001FF7CA;
	Mon, 16 Dec 2024 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzEvfcOF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5AA41
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346312; cv=none; b=TYOwDxK5WXskddczGbNNXGsZGzTt3BYD5y07FxSLjYbpxB5g6e20PiZ/GIMUVMy3pkIpTBy/pQcgbly2pT2J8SiiIGEyCARfFqWBP53kWh5YvUzj6gV2nuel6Ry+fuycIqVpgaaLzUd5OhGPM/fjgMHQC3WX7Bw2L19bdOFfh5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346312; c=relaxed/simple;
	bh=RwAE7aESmXwUwvCzpVnJQ+Fr6xaDGeZGjm6GrCme/Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQMqHdhPtbqr3ExbdiJ6TAIA7vbtVxNk1jVc8wX2Es6hotBQVDDfaX1dwSHa8UdngEOF2vBlB53MAm6U88K4i20VRxZ/uLjWwEZUYD6k3MGVTB0Wt2BR3W7/Gpg8IHcrgR54wUGKm/H6k1Rb53qWtlrpITOZN6peDJ+/MX7zHMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzEvfcOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89756C4CED0;
	Mon, 16 Dec 2024 10:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734346312;
	bh=RwAE7aESmXwUwvCzpVnJQ+Fr6xaDGeZGjm6GrCme/Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzEvfcOFyw04B7pbVInLul0blCkr9eUN9jYKAuDDCvmY1U2DecxnmTs78j2YzCjkC
	 OETkW/AdSNk4JH/B+Qxs/uSgTnWri9qkuuEEHJCntBDnUEagYmVB7dIM0KRvvegpAX
	 RYU3TiNQ8PpBPbJnk8gbKgeQHQZcDTaiXS2UTUUYgAXGSn8f0BpMt3e/wOfVsgiM4c
	 sdX39N4WvuA068M4H2016JyUYHVVsLXYlJg0VjPgo7qKhFi1ZyMhFsq7810fFUwAro
	 0S3L/WFcXdlVJ6fYav9354Y7PgXWPdtuxlOvUx++bDEtxhSmgQYqOv05w9GGh5nAYS
	 +XR6N1VUU/47Q==
Date: Mon, 16 Dec 2024 10:51:48 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Chun-Hao Lin <hau@realtek.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] r8169: adjust version numbering for RTL8126
Message-ID: <20241216105148.GB780307@kernel.org>
References: <15c4a9fd-a653-4b09-825d-751964832a7a@gmail.com>
 <6a354364-20e9-48ad-a198-468264288757@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a354364-20e9-48ad-a198-468264288757@gmail.com>

On Fri, Dec 13, 2024 at 08:01:41PM +0100, Heiner Kallweit wrote:
> Adjust version numbering for RTL8126, so that it doesn't overlap with
> new RTL8125 versions.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


