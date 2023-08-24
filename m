Return-Path: <netdev+bounces-30187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C997864E7
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 03:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78AD91C20B64
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 01:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE7C17D0;
	Thu, 24 Aug 2023 01:46:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B59F15DA
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 01:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE29C4166B;
	Thu, 24 Aug 2023 01:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692841565;
	bh=QcxBPDj3EFvkzsVgWGRcZsaxw4CEy1HbhIOucoZS2DU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZdsbvsRE9H5Au13iYTDqjDHjU3D1UlP4Z7bZf3G3qq/aN2ZYvNmdz1YY+bl07S4wf
	 2/7KVsrLpG+eFEnJaXsAJsqEeqnn3X5smrbv50k/IEXuegTHIvg+SKIWnBP+y9PXLO
	 sSp2mhui1rL8GhoE/hMSj/A/oa9yzZAuiP9QTyfoE0P5S/iyyBlXo7Y2eC9B0ayfHC
	 8dYZj/iEvknYYkGGWMJCeHjNdJwJX0E3ppE1l7F0Dyg4VZ0EsoxdLl44IqaE8U8iW0
	 9Air/KVqcPf/uWoZfOkbLXI9FTZ1ItQSO2pKGKSRRsnqTKaRjl/bEOggwjwmiKygEr
	 BspCqy2Opgf9g==
Date: Wed, 23 Aug 2023 18:46:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Stanislav Fomichev
 <sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v4 07/12] tools/net/ynl: Add support for
 netlink-raw families
Message-ID: <20230823184603.7fda3b66@kernel.org>
In-Reply-To: <20230823114202.5862-8-donald.hunter@gmail.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
	<20230823114202.5862-8-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Aug 2023 12:41:56 +0100 Donald Hunter wrote:
> +    def get_mcast_id(self, mcast_name, mcast_groups):
> +        if mcast_name not in mcast_groups:
> +            raise Exception(f'Multicast group "{mcast_name}" not present in the spec')
> +        return mcast_groups[mcast_name].value
> +

if you repost - missing extra empty line here

> +class GenlProtocol(NetlinkProtocol):
> +    def __init__(self, family_name):

