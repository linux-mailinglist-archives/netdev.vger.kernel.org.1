Return-Path: <netdev+bounces-217872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C8DB3A3CF
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3300F3A79EC
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9319B2594B9;
	Thu, 28 Aug 2025 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA8UJjOf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954C5CDF1;
	Thu, 28 Aug 2025 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394002; cv=none; b=n4rGDHlLKgaJNKrrNrAHIa5LcJeEdUamBcp7sAFuxHh3qVCu7kTscsZ4ylZknGJZq1GgjecB3CkniFTbtkxuAVC75CMlM0UJiQdN9PpqAJDnzW48B364craJLxklBsInimBdgEvKz10g/W27wcd0j/Q9t5BGJeG8vwjz1N9ItAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394002; c=relaxed/simple;
	bh=MtuVAmIB/KU4zxP/Yeo/82S8owHGyY86M82VbjOxrWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjWr8q12/0j88hJvnCFAZEYdIuAlOc2V7ETgBleoVAyOYZYihJUFgVEm8EzoYQZcXhB9QvUP/gjGL89b4ba4x49NoAwVVYe7gvihkb6+XQ5QEOpgPTAukUmFK5Ag6BQ05esk4lmIT2kHAx+Y81AeGOQERTbqyTA/COW6blhZu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA8UJjOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F728C4CEEB;
	Thu, 28 Aug 2025 15:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756394002;
	bh=MtuVAmIB/KU4zxP/Yeo/82S8owHGyY86M82VbjOxrWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hA8UJjOfhqe2LNNFsHRdyny5z8Wbt1lopSL+82oAlGBSDIVLHWlgg/OOCD0SocLVt
	 iBD9lArnlgzzyxNcBVr4q2eWlpjBPvaVtKiumX2pPvPEw/h7H2VNcfYUqvlZ/IH5qz
	 oSUszvo3dFtny84ZxpZn2AXAAejaho8SIGFSoXpXgfjE2gUqDtAS+qWlA+EuwEXP+p
	 qXm9cptcqzfq+wuV5QpgrGmdeBdozBZMQcKkYHJfukJNEzF/Nb7hVLhWdvvlsEBzXg
	 cdnBQGcDjtNeliTk2LjUuJpJQBIkV/v9Dme1YaYSystKbKmmDKQdoGMuxI9dZD928V
	 qY+G6RYIiQs/A==
Date: Thu, 28 Aug 2025 16:13:17 +0100
From: Simon Horman <horms@kernel.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Jeroen de Borst <jeroendb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Joshua Washington <joshwash@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	"open list:GOOGLE ETHERNET DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] gve: remove redundant ternary operators
Message-ID: <20250828151317.GN10519@horms.kernel.org>
References: <20250827121043.492620-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827121043.492620-1-liaoyuanhong@vivo.com>

On Wed, Aug 27, 2025 at 08:10:41PM +0800, Liao Yuanhong wrote:
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

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
pw-bot: cr


