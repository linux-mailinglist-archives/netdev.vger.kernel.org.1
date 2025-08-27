Return-Path: <netdev+bounces-217388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EB4B38819
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA4517337D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8C32D7DE9;
	Wed, 27 Aug 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0tWvaoN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A43D2C3770
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313775; cv=none; b=qJqrQgRlDm0WXXrsV1hguI8YzEXLqtucPs/X24nPHzrMhM5yS2tMxvbWUNFDCzjbmAH6NM5FwAtBSlWbH/RoRXJyZyKZzmckF5TeY7QX8VA9/7SvpxHSFk6LJpw5Ij3zoVJPgiW/mj26zMesTHC7texNrhebGkCcGUo6oVyD0W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313775; c=relaxed/simple;
	bh=gtGcpHkQB86dDni51dt1f/vRMVPx7gIJZCEngGoGbd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1R1r3Rc38zu+AxHYiNrWQdxBggHI/GMXeBumRAkTste0BnH8mzR7OzRbmbHyGSB2RcBMcOqT6K7sZ/x0ia82JVq9MrpSoopOJTZm4j7woVh/XzvWBvq9lUpAW3aM+C4NeLjgA6k92MDAitGjSesJ23zU1o1QnmnvXTAY821XYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0tWvaoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71593C4CEEB;
	Wed, 27 Aug 2025 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756313775;
	bh=gtGcpHkQB86dDni51dt1f/vRMVPx7gIJZCEngGoGbd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0tWvaoN00iXeFgjRX57aSVGTg1MOFc+E1dKIWRMVgyZrEB3OLSEbteSUZ8NZvwL7
	 DaUhu45sAAxpNO4Y4OfXWtfaa0czJN8Bl7Hyu3rg6CVCG5DqD/6nqZelxyldWtbTxi
	 LJWCZ4jrMCYY920X+V3yQslXdbhF8wLK5Jnejm/DHAYrWRH60N0/BFzDfy15Rc2Etl
	 DyF5QFqWNdnxQ5oJo0J0R1+izh7i8ugh96l9MrvVXzHpkauwZx/jUb1vtyei/G+q4L
	 EwH3WY7r2NJbz5ZVHbDvmo5Lh2IuV/gu+lK/66n0nRm8JYVaVrrKuofcfRLfdj8KaX
	 9FdI0Ud9eIG+Q==
Date: Wed, 27 Aug 2025 17:56:12 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 11/13] macsec: validate
 IFLA_MACSEC_VALIDATION with NLA_POLICY_MAX
Message-ID: <20250827165612.GM10519@horms.kernel.org>
References: <cover.1756202772.git.sd@queasysnail.net>
 <629efe0b2150b30abc6472074018cbd521b46578.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629efe0b2150b30abc6472074018cbd521b46578.1756202772.git.sd@queasysnail.net>

On Tue, Aug 26, 2025 at 03:16:29PM +0200, Sabrina Dubroca wrote:
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


