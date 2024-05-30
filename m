Return-Path: <netdev+bounces-99214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E80A68D4237
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995F31F223F3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 00:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E0D18D;
	Thu, 30 May 2024 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6CG6jw4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FAD7F;
	Thu, 30 May 2024 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717027855; cv=none; b=rAAF3elWRg6aW8qcMP80m7j+Hqvh8IZG4x3N+zCKwALBfDAHNGV7qltVOUR2ajhtOLTNv7QMwtlhHSvfrjxGWt+DwTcnqQXoa20OZhsPSNXNVWNTm8gShkjWF4n3/Opxf5CNGLidlC+D9kP3fmWBb4Xsx8sltD4Jzw1KML+P2+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717027855; c=relaxed/simple;
	bh=n5cHmceXcDfDX/c/RyY/vgiIjInJNHRy6l4phJMpOLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gm0PXqc8OeC5Dl/qgQqVwh5o68sFwux+T6fo2th4RPThz03PXL+Tu837uFSoNkHn23PXhloss0QrF8P2Y79Jh8q5BzkvotfEebKYMyJHlJsAXA8CEIWJHfmi7JxmSmU5uXZBeoYqvKns/3LacKo233M4EhWAqrF92BrZPf9blEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6CG6jw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92946C113CC;
	Thu, 30 May 2024 00:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717027855;
	bh=n5cHmceXcDfDX/c/RyY/vgiIjInJNHRy6l4phJMpOLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z6CG6jw4X82EENcgvPVxutM4JCLbW/gdxI9KsAkYLozWNIvF8IyP7jL+hOaea6OOm
	 EWkXG3T8hWew/WwAoRPp57iSYJMXb9eBY8phWVcGhUInLeoEwzkpetU4ppsZJQ9wvq
	 21wo8SS0AkKrtU69djkPxAMX2hkBTm6sFs2nFl8lPICk8D3F3awj/yknpwkBW+Fi+u
	 aHqCb9hYnivK30diZDPOr9fbI2o/xEXLzS/oh4FQKaKpoYDNXjm0bSf4NSZ9R/D4O6
	 53zGneU04Sz6XWUDAnWubGGNxl8QEIKT+PQNsuDUr7CRFRu3DUoDu2EO5uc83rNdHa
	 2iXFvWuABdJcQ==
Date: Wed, 29 May 2024 17:10:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net 1/2] virtio_net: rename ret to err
Message-ID: <20240529171053.132ae776@kernel.org>
In-Reply-To: <20240528075226.94255-2-hengqi@linux.alibaba.com>
References: <20240528075226.94255-1-hengqi@linux.alibaba.com>
	<20240528075226.94255-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 15:52:25 +0800 Heng Qi wrote:
> The integer variable 'ret', denoting the return code, is mismatched with
> the boolean return type of virtnet_send_command_reply(); hence, it is
> renamed to 'err'.
> 
> The usage of 'ret' is deferred to the next patch.

That seems a bit much. Can you call the variable in patch 2 "ok"
instead?
-- 
pw-bot: cr

