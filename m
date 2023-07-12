Return-Path: <netdev+bounces-17013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 733FA74FD0F
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 04:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC1028161C
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6935635;
	Wed, 12 Jul 2023 02:29:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0633B362
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 02:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197E1C433C7;
	Wed, 12 Jul 2023 02:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689128984;
	bh=xG9e3he2guVchwzogX81WG2OjmLVudMKkd8lmisKZHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dFZazsH3rTpa33QyrA3jWxvDVplYudACM5N4yl8iF9PjIelC2bkMfQoY/RCtdpipD
	 OGTVEDnh/Wr218brznfs1lsGdv1HyzIR4aqiXix3GxRfwKk+BXLIB9aZG1Ty43xuoi
	 miD1c5U1/VufztrrDwSF3aXl5awMQbTjdsuNkad1ASZQJJBmwh8SrrxN+6hOPnTeMp
	 LNzhXRL2rzCfKGxyJ2NtEp9lwEEXKFjSK7/3Oiy49zdULf6zWk3P4nTKLvl26WAdrJ
	 dgaPsgacE5SVl8gN/AfhSLhLIUWIeFs0vPjTNF8nx25J+X8B/8QI620i5T00m6npDC
	 tkjpIKY3sVbAg==
Date: Tue, 11 Jul 2023 19:29:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yang Rong <yangrong@vivo.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, virtualization@lists.linux-foundation.org (open
 list:VIRTIO CORE AND NET DRIVERS), netdev@vger.kernel.org (open
 list:NETWORKING DRIVERS), linux-kernel@vger.kernel.org (open list),
 opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: Re: [PATCH] virtio_net: Use max() function for better coding
 conventions
Message-ID: <20230711192943.7a541984@kernel.org>
In-Reply-To: <20230710012508.2119-1-yangrong@vivo.com>
References: <20230710012508.2119-1-yangrong@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jul 2023 09:20:51 +0800 Yang Rong wrote:
> It is advisable to utilize the max() function in the virtio_net.c file, 
> as it conforms better to programming conventions.
> 
> Signed-off-by: Yang Rong <yangrong@vivo.com>

Unnecessary churn, please don't send max() conversions to networking.
-- 
pw-bot: reject

