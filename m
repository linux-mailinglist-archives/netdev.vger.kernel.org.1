Return-Path: <netdev+bounces-26988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D81779C3C
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 03:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31631C20AD8
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 01:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ABBEA5;
	Sat, 12 Aug 2023 01:23:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A9EA2
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 01:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C396C433C8;
	Sat, 12 Aug 2023 01:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691803425;
	bh=DM74YiLYu12hQBbaqX4Ualct3b0OVDgxMya+Mgl3mAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ud1byx3zmVj7R2FG62xAoFVzv+9m1vJisEFRPfo0DridSYiPtycD1u9j+dkv7n5xg
	 fh9OvN6Cj8OiVV/kcYozX3uQTwlE317RLfd8oGy8BoCTiSpi3rK75aOwAJtjg+An4a
	 AB9Oz4LGA6Rf6w8SmuHDG1kl8WAlQ8mctH4T6l9l4XYwXuYPf02SVaYY75vRav8Pm7
	 LaBkInZAWL+3KDJudfOFOq/U9KlV+h8Ft9kLwg4gSBqKgsb5wWMr22mNzu6HbBY16j
	 VF7BOQEGQ6HMb81s0sCHTtyH4eM3o1WAVbKL0HnpMI4lxhqctf6+q5Xjm1CLH28zj4
	 btO9sIE3v5aeQ==
Date: Fri, 11 Aug 2023 18:23:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net V2] virtio-net: set queues after driver_ok
Message-ID: <20230811182344.763f10da@kernel.org>
In-Reply-To: <20230810031256.813284-1-jasowang@redhat.com>
References: <20230810031256.813284-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Aug 2023 23:12:56 -0400 Jason Wang wrote:
> Commit 25266128fe16 ("virtio-net: fix race between set queues and
> probe") tries to fix the race between set queues and probe by calling
> _virtnet_set_queues() before DRIVER_OK is set. This violates virtio
> spec. Fixing this by setting queues after virtio_device_ready().
> 
> Note that rtnl needs to be held for userspace requests to change the
> number of queues. So we are serialized in this way.

FTR this appears to have been applied yesterday by DaveM. Thanks!

