Return-Path: <netdev+bounces-30193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BE078650C
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 04:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8003F1C20D89
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 02:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109D617D2;
	Thu, 24 Aug 2023 02:06:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E874F7F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 02:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DC8C433C9;
	Thu, 24 Aug 2023 02:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692842792;
	bh=+AJyAi+rxcFPyjXuoshx0npltT9mNEwFDvDQhmy4ZDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QCkM2UPURGdop99v48ybWg602Szbb978AmL9H5qfvEt1Tf2NT5T26WeZ+3vKnuLxT
	 Ub+hOaHUBMwY8uRtSTOVECp4yq/yfNKfvRmLCRntc4T6BrYiR+l/PSls80lGMFugjf
	 +Ehh1FhjGwSKhQ7cGY5NrWaxPfuEOF/6lGxuHfMzumipABD3RLgH39VPrZfn9V5S4Y
	 DDx7O/gP3yR7BfJ42MLlY8PYCPetLYXS1j9sLN9JeiwNAuTKqxjoJpvoUbdChrK9fC
	 wcdPnibsrMTzS4hK/Wyl+lGGNbfPmB8dgpwuIvN2JzAJjVyTlplGJRQDM6GxeayJ0+
	 LTITQO/ym3Dlw==
Date: Wed, 23 Aug 2023 19:06:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <edumazet@google.com>, <razor@blackwall.org>, <jiri@nvidia.com>,
 <mlxsw@nvidia.com>
Subject: Re: [PATCH net] rtnetlink: Reject negative ifindexes in RTM_NEWLINK
Message-ID: <20230823190631.4297d08c@kernel.org>
In-Reply-To: <20230823064348.2252280-1-idosch@nvidia.com>
References: <20230823064348.2252280-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Aug 2023 09:43:48 +0300 Ido Schimmel wrote:
> Negative ifindexes are illegal, but the kernel does not validate the
> ifindex in the ancillary header of RTM_NEWLINK messages, resulting in
> the kernel generating a warning [1] when such an ifindex is specified.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

