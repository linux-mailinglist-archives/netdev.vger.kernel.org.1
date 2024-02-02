Return-Path: <netdev+bounces-68302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D6D846753
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 06:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91161C24AC3
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 05:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83660F9FD;
	Fri,  2 Feb 2024 04:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxoOnVr8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6E6FBEC;
	Fri,  2 Feb 2024 04:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706849877; cv=none; b=jYP7WUWMbLK0MGYno8QVZlAXzdY6R/RegdXkyEYeZj4dZx+TcsqQvfi2DMDzVj6P0ccdNs4OXe4CIg9Cf1oevI9Rtq5ENrL8Q0QLx8rLOpea0u4A4hqi4skG460oVQAW14VyB9Q8SaSLDldQ1bSKrri6Idsqd+THg+IhyErjQEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706849877; c=relaxed/simple;
	bh=YK19vv0kLC+3vktuBU7Tn7nxWcO08QeCoGshwjMZ2l0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYFuPVI6IPCsB0DO7+CmwkOUPblwMCd+LjBcJitwiDeLnI3EW3x4q89rjPK6s6SfmTo68c9vphJisebJLfRGb57B6jGImrRajleVIGUD4zST5kAL0+hSCnFkum+6Qchwj+f8N/LCutST1sXFZ7K9S9LoM1AVCrbq+43GNJ1xPxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxoOnVr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00200C433F1;
	Fri,  2 Feb 2024 04:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706849876;
	bh=YK19vv0kLC+3vktuBU7Tn7nxWcO08QeCoGshwjMZ2l0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WxoOnVr8jRjR9kPv8ux72qd9XR9xQGbE/XR41BLJIJawku3A00uJ6LWRF5JHEYK2S
	 53KG8wFNXkBdrVwOYD9kn5pRdRWgfHlN3HiRAuvNZX5DlcnzuEPgiUOXQimQBq8SMX
	 gPkwCMfgVsGnTIj1pIbbkIcrqCZVX+yPmAQINhvBL3sKvfrSM+RCRG4R+lkhqKZ6ev
	 envzBfwcQOhVoiVa53Q9ykDLzixqYMQ3Cg4TSCiZ4vBapwd/QcSD4g/wTDCLXfQ2Sa
	 2/BAuWZR+rv7zHq7MyH0GJpfyLjdCq9nBrkICcY1U/89KVG4V8C82MjeDGnBuh8eeH
	 db6nui9xaL6KA==
Date: Thu, 1 Feb 2024 20:57:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev, Zhu Yanjun <yanjun.zhu@linux.dev>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 0/6] virtio-net: support device stats
Message-ID: <20240201205752.2ed0535f@kernel.org>
In-Reply-To: <20240131024559.63572-1-xuanzhuo@linux.alibaba.com>
References: <20240131024559.63572-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 10:45:53 +0800 Xuan Zhuo wrote:
> As the spec:
> 
> https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> 
> The virtio net supports to get device stats.

Does not apply to net-next, could you rebase?

