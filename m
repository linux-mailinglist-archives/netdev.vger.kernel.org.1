Return-Path: <netdev+bounces-26567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5E07782B0
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 23:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614FE1C20D3A
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 21:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E417B23BD9;
	Thu, 10 Aug 2023 21:29:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9420F92
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 21:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BDBC433C7;
	Thu, 10 Aug 2023 21:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691702990;
	bh=udij2PLbfirwon6in/VcXMGaiWAROe2LPcfk4aF2xiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kr4fT1MZ5n4GcU6trzHtMM5Y0K2DmSAq6NFe0l/WM2mtlZQTgFAYtRe7GiNfmHtki
	 GkMwXKRH29jk22YBx5KtKeMnebZaxeX6+GM35fEtCbSX0ToaJy2HXrRz7ZvWHo/ADf
	 HiFtf8j9CS3CqUNg2LzSSzalFMq/aG6x4NkCc+gVxJJKSKo7xBvgoXdBS2wzdyFfHV
	 ESvT848fAvMkyl3rMEKWJZYchVB/JBlBSmEAlUGPbHHsG163YyagOEVG9HW+FASyzU
	 P83eyNvkLm4TBsrlRGOO+G1y78XpBvTN4RLSA05q4FNQwqJMSMXKKkOJk1Ezxwpb8j
	 fqMNoWQC9exYQ==
Date: Thu, 10 Aug 2023 14:29:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, xieyongji@bytedance.com,
 jasowang@redhat.com, david.marchand@redhat.com, lulu@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Message-ID: <20230810142949.074c9430@kernel.org>
In-Reply-To: <20230810150347-mutt-send-email-mst@kernel.org>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
	<20230810150347-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 15:04:27 -0400 Michael S. Tsirkin wrote:
> Another question is that with this userspace can inject
> packets directly into net stack. Should we check CAP_NET_ADMIN
> or such?

Directly into the stack? I thought VDUSE is vDPA in user space,
meaning to get to the kernel the packet has to first go thru 
a virtio-net instance.

Or you mean directly into the network?

