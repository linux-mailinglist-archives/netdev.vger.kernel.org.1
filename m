Return-Path: <netdev+bounces-73517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B7985CDC1
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2BA1C219D4
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB02D6FCC;
	Wed, 21 Feb 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um7b4nTF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71376FCA
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708481429; cv=none; b=Q8hEVCGEyMIp7jYOG19yiN7K8H69rKOnEdsxiDenTA7c15slma6V+J7vvpUcojnWEP92JraSN/K7njU8aiO+xNAVgh2wOuKF8Wgwm0Th/SrQM+j/nMJtUwSf7UUsJ/mdOUo36qaBAI+9n8hRw2EFAzQA+j4a4+6ROP5Ff+htZBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708481429; c=relaxed/simple;
	bh=DMiSXW7V15/Omkd1Fe2RvXvLa35tFTKd42DvtPpuO5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3ppbBG/EN5wRVfAGONrlWfFl+gnYis1M1gzQzJzLhtO0leHUamsWl5nbXZ7vHAGhF98Iegjg/yP9eX4QETw3hd0eku0UA8svyUemyjDE8ys0QY/COrXQWU2YPkR7q8R3miNZ7EgbSSh+j1A4Uu8yK7+OZ9fS92eF9k7DmkFDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um7b4nTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FA3C433A6;
	Wed, 21 Feb 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708481429;
	bh=DMiSXW7V15/Omkd1Fe2RvXvLa35tFTKd42DvtPpuO5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Um7b4nTF+8mxu4lPEo0oEELUiB2BWr2PFFczpnAvBwhc2aAqzoOY0gzC00+N3NiBT
	 YTFlkACdNVLhthkcULv7NcUQtORI8scPkSSxij1SmFVhf/RnOq36EUnKxr8P3hcmve
	 Ozx7OAVFik9HXj58HPiKhg05I7wrhfxdggsv2drjaOEvcIneGVu+QG8rqNOW2/3KJp
	 nLop34MJaALvc85YHn5APwmlyYr/QalH60vOOGFUasvEXNhURuHFn8LNlBWQS1VNkX
	 /OcxT4yp0QwTDLwWiVQmp9z3JZlfh0cV6oBjwfh4vyFkcp9EF5EM/rpokoj94yiGHd
	 wN/nxr2HlNe+w==
Date: Tue, 20 Feb 2024 18:10:27 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Message-ID: <ZdVbk0FLgieu7pfx@x130>
References: <20240215030814.451812-1-saeed@kernel.org>
 <20240215030814.451812-16-saeed@kernel.org>
 <20240215212353.3d6d17c4@kernel.org>
 <f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
 <20240220173309.4abef5af@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240220173309.4abef5af@kernel.org>

On 20 Feb 17:33, Jakub Kicinski wrote:
>On Mon, 19 Feb 2024 17:26:36 +0200 Tariq Toukan wrote:
>> > There are multiple devlink instances, right?
>>
>> Right.
>
>Just to be clear I'm asking you questions about things which need to
>be covered by the doc :)
>
>> > In that case we should call out that there may be more than one.
>> >
>>
>> We are combining the PFs in the netdev level.
>> I did not focus on the parts that we do not touch.
>
>> Anyway, the interesting info exposed in sysfs is now available through
>> the netdev genl.
>
>Right, that's true.
>

[...]

>Greg, we have a feature here where a single device of class net has
>multiple "bus parents". We used to have one attr under class net
>(device) which is a link to the bus parent. Now we either need to add
>more or not bother with the linking of the whole device. Is there any
>precedent / preference for solving this from the device model
>perspective?
>
>> Now, is this sysfs part integral to the feature? IMO, no. This in-driver
>> feature is large enough to be completed in stages and not as a one shot.
>
>It's not a question of size and/or implementing everything.
>What I want to make sure is that you surveyed the known user space
>implementations sufficiently to know what looks at those links,
>and perhaps ethtool -i.
>Perhaps the answer is indeed "nothing much will care" and given
>we can link IRQs correctly we put that as a conclusion in the doc.
>
>Saying "sysfs is coming soon" is not adding much information :(
>

linking multiple parent devices at the netdev subsystems doesn't add
anything, the netdev abstraction should stop at linking rx/tx channels to
physical irqs and NUMA nodes, complicating the sysfs will required a proper
infrastructure to model the multi-pf mode for all vendors to use uniformly,
but for what? currently there's no configuration mechanism for this feature
yet, and we don't need it at the moment, once configuration becomes necessary,
I would recommend adding one infrastructure to all vendors to register to
at the parent device level, which will handle the sysfs/devlink abstraction, 
and leave netdev abstraction as is (IRQ/NUMA) and maybe take this a step 
further and give the user control of attaching specific channels to specific
IRQs/NUMA nodes.




