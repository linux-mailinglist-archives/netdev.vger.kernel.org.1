Return-Path: <netdev+bounces-48144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 643877ECA19
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF46280E06
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1413DB9B;
	Wed, 15 Nov 2023 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcR27uIg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510883DB99
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 17:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC74C433C7;
	Wed, 15 Nov 2023 17:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700070990;
	bh=seHXsU+nC1ZI4hISDFAU4lqI5nICNlP3RwnhFpogd+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jcR27uIgLKUK330DPYPiyQ0eWauPjEUx9x8R5nO3xTTjJalEFtrdPIXhkcHN645hs
	 1PxN/V0jRlrYNj8VGtcd2mj6vx40Mthwe/6Mj6CX0mw7mGPF04KVZhm5bhiFIN55sV
	 LkwWOeWYkFi/vKpoYei0sAxNbCXO5kynFQoWPlHY5gX4H7wiHZlSaVn7ImLtAWLXjN
	 9XD6VeH8UY4ahJV0mNVRgGF7kFh4ya+8jP1Gx7FQT964HiBXZMZXZyvyZNsxjE5Q9Z
	 nGHsrSWkuqsRcrrLQlyJMjTMkhBfbATRBURLIXhGqx2dWbojOKuJLe/CHFieUiP2hw
	 FbdsZnRXT9CAg==
Date: Wed, 15 Nov 2023 17:56:26 +0000
From: Simon Horman <horms@kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next] indirect_call_wrapper: Fix typo in
 INDIRECT_CALL_$NR kerneldoc
Message-ID: <20231115175626.GW74656@kernel.org>
References: <20231114104202.4680-1-tklauser@distanz.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114104202.4680-1-tklauser@distanz.ch>

+ Jakub, Dave and Eric

On Tue, Nov 14, 2023 at 11:42:02AM +0100, Tobias Klauser wrote:
> Fix a small typo in the kerneldoc comment of the INDIRECT_CALL_$NR
> macro.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Thanks Tobias,

I agree this is correct.

Reviewed-by: Simon Horman <horms@kernel.org>


To the netdev maintainers: get_maintainer.pl doesn't seem to
know much about include/linux/indirect_call_wrapper.h.
Should that be fixed?

