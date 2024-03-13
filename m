Return-Path: <netdev+bounces-79671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D1487A84A
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 14:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BDB1F21D7F
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 13:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192A04085A;
	Wed, 13 Mar 2024 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/xac1zT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D63224FA;
	Wed, 13 Mar 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336430; cv=none; b=Acg7Gr7vXt3FpklBRsMlk0luZIy0lqTdL+CNjGZsIlbvdkxC4L76csXq807bF0SaEwTMKz2+UoCP40o6ODtVQpZ0jtGzfIFp7y+3Cey6HUHQWNfNAY5AndNNYuDHUUfkKp5m6eGLI7reFmqjwdpTyV+QUuLwADkGiM9ptT/5Ibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336430; c=relaxed/simple;
	bh=B0fnba4gidZQvyTEXxciojWjcwOMuZEEiz9uPq80vZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jg+eqdRwm1sT/StpsarVy3zFP1LwAQP8GQs4+ont7iZyLpqAr68Ux11Uz6RvoE+ojqLHEBWj6gIyo3t2Fmabwrf40l7TrpxzabQcV++Z4tM6j79IkKKVxPLYe65OUhNw4GudG2vpDYyJZycEJ2+jWrBg4Z0WL4NSH0bCL/Imr/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/xac1zT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400B2C433F1;
	Wed, 13 Mar 2024 13:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710336429;
	bh=B0fnba4gidZQvyTEXxciojWjcwOMuZEEiz9uPq80vZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u/xac1zTA5lEiNKP/cD0WonmASiVASqgXcq69tM9Hxta4vbONFhv4pLhEurK3rDSI
	 n7qrCMhv2Ig/jIP7A7nfTL70aDgBrgyD9CyDuZmEO54cVqcaGZOFOlmz7W0EsSz70u
	 3uU5aUDAxTDB8oPt9vQYTsrunFO8Q3OMzaxf8fP3bJVmwMm2240ZRwhWoAMjRlb68I
	 x9UwPnJ/Mk+hj3lKdmptOsuSavGPVff4Tr9k3n9p2SJClPtYSLaTg7V9WcY49z/QNH
	 8YhISL8fLr8EpaaYnjM2ayvMsDHKyn2WVERuLjO07/ts3wCN+d2dH4trvB/5ZE9AtT
	 xNcsnqZ5ov4hA==
Date: Wed, 13 Mar 2024 06:27:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev development stats for 6.9
Message-ID: <20240313062708.3bc51347@kernel.org>
In-Reply-To: <CAL+tcoBzHNt86-4OC7Jck1WBG+YuadWDhQrkyEPBaxQxcET6YQ@mail.gmail.com>
References: <20240312124346.5aa3b14a@kernel.org>
	<CAL+tcoBzHNt86-4OC7Jck1WBG+YuadWDhQrkyEPBaxQxcET6YQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 10:13:43 +0800 Jason Xing wrote:
> > RedHat remains unbeatable with the combined powers of Simon and Paolo,
> > as well as high participation of the less active authors.
> > Alibaba maintains its strongly net-negative review score.
> > Tencent (Jason Xing) joins them (Tencent doesn't use their email
> > domain so it's likely under-counted). Yang Xiwen makes the negative  
> 
> Interesting numbers.
> 
> Well, actually, I always send patches by using the company address and
> review patches by using my personal address, which probably makes my
> scores negative :S
> 
> Next time I'll try to use the same address. Hope I will not appear on
> the top of the negative scores list.

I can add an alias to map multiple addresses to the same person locally.
Feel free to send me the addresses (on- or off-list).

Some goes for everyone else, please feel free to send me your mappings
and company affiliations. I don't have access to the Greg KH/LWN gitdm
db and Linux Foundation remains unwilling to help.

