Return-Path: <netdev+bounces-138617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F35E9AE4A5
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDD41F23040
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D171D220A;
	Thu, 24 Oct 2024 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7PIyuzO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD96176AAD;
	Thu, 24 Oct 2024 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729772470; cv=none; b=V3o7FOSuVlcVHIZUjUJjtJ2kcFKq+moJ/cvnGzYt7WS9isq+s9nXB0ypQgDbRnfWG8QZ/N79OAODDB68NfMVXJITP2kG0S5BVEM4hhhpifHojl5G6gIY6kxns0wz8+l9byox2nQmmsaIbXuTkP54KzP0uOr+nLerDkwqlMwAkaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729772470; c=relaxed/simple;
	bh=UWyzY5P0S5jjYqVQZa3VmDuwo5IkVNJhZVEtPJoUV0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYJcJVR/H4PFcEvIh40awgbabjZGbO1AxxCkkwGdhlM5E27xgYE2mMsX8SIM5gYxpa57a/DcGR/8wR5CjYW39ZGyyOvaVWcmH4ovYLcPoUcn1u6uLW5ic2EzAPQXZhqiMQWorzUc5iY+HS2V+XXGp+gwQJBeIHQTzZfscviKBnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7PIyuzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4C6C4CEC7;
	Thu, 24 Oct 2024 12:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729772470;
	bh=UWyzY5P0S5jjYqVQZa3VmDuwo5IkVNJhZVEtPJoUV0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7PIyuzOY/XGqQmQQ9VgrS+D/Vg0CwwSHjI3TtuM2I+bjz+FA+i5jREhJavw5KTWF
	 fIPuIvFPHcxftFLD8QADuPXChvz3n1eDX+LDBdEoRYtiZ9JTwJtFLESzscLiN9JZ6X
	 LoBm7QKWNIGWsAJihghjJNImZSZHOeyF2vM+qcgfGznt46oXlPv///JdR2xo/SHkx1
	 B22QPX1XgFlnkN/RCIwGfNXEupZQFLvAMKFE8yVdVhfnSerCUprxdT47QO4dDqQYE7
	 5Iw3QzNPTjlpxZVsv1mcByIYmElkNSFbOlxAbKA7j0UCQeIBEVO/liAvXvgmFBa+tw
	 6pUuNHlsCyHDw==
Date: Thu, 24 Oct 2024 13:21:04 +0100
From: Simon Horman <horms@kernel.org>
To: Leo Stone <leocstone@gmail.com>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, anupnewmail@gmail.com
Subject: Re: [PATCH net] Documentation: ieee802154: fix grammar
Message-ID: <20241024122104.GK1202098@kernel.org>
References: <20241023041203.35313-1-leocstone@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023041203.35313-1-leocstone@gmail.com>

On Tue, Oct 22, 2024 at 09:12:01PM -0700, Leo Stone wrote:
> Fix grammar where it improves readability.
> 
> Signed-off-by: Leo Stone <leocstone@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


