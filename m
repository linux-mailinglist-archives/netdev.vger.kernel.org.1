Return-Path: <netdev+bounces-31115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C45E78B89E
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 21:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535A51C2096D
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 19:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A0814018;
	Mon, 28 Aug 2023 19:45:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD64429AB
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 19:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D26C433C7;
	Mon, 28 Aug 2023 19:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693251902;
	bh=pIZ450UJMkVzx8UlKp54rw2QfZHBgu0tCxB/2xr8MYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WY26HVRiphuvRN+tnmGDhk3V2iWC7qtXKgEFawaeznWhiUDUo0mUZpaczBtYkPDdT
	 sVEl7Wdoz7OcPF2j+eL5sCFprBwPgDEpu3QYlkHSqJr4MOjx4akhOGF+wODANOFu19
	 7iU6NvSVVvjjMH4kGfkqX8axpT68iWKz2+x2pgC87bi189r5ItiryZAmBt3lD2BXfp
	 Xmu16Ll7b04NSS1O6VGtdA1hg4xbhuPLCWSV3Ku0O2SpUy6T8aYLZV542SNTcnYkL2
	 OoqeUxCTszHVOZ/XVnxK5kh7OVg+NWVIn7STTB7jlgtyv274ArDDt7SEteSOw76Ym7
	 ZR6c4npF4OsTw==
Date: Mon, 28 Aug 2023 12:45:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Bobby Eshleman
 <bobby.eshleman@bytedance.com>, <kvm@vger.kernel.org>,
 <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
 <oxffffaa@gmail.com>
Subject: Re: [PATCH net-next v7 0/4] vsock/virtio/vhost: MSG_ZEROCOPY
 preparations
Message-ID: <20230828124500.446929fe@kernel.org>
In-Reply-To: <20230827085436.941183-1-avkrasnov@salutedevices.com>
References: <20230827085436.941183-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Aug 2023 11:54:32 +0300 Arseniy Krasnov wrote:
> this patchset is first of three parts of another big patchset for
> MSG_ZEROCOPY flag support:
> https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberdevices.ru/

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


