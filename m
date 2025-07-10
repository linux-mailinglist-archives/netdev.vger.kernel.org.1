Return-Path: <netdev+bounces-205663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36D5AFF939
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 08:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99649565222
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 06:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AA8235079;
	Thu, 10 Jul 2025 06:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTNuYHTm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6519622068D
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 06:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127450; cv=none; b=cUmou/U1QPucX+6roGcVXsvCsMt56P+kbPe2YNlxykiRyE8sKQdqLefXmnD9dE7EcX6lONyl9wpfp0wVV27XOj96WFtGEaPTWnQWn1Ln6UvfGtUXR6WUCXwPhjoVDK84+JbEKZKzak80GI/X0PKaGatdrK4jY8bsSnjKu3rzMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127450; c=relaxed/simple;
	bh=B+sJSqD8NmZGbYk1pEEsdF8fEb/eO8C56DGLEoxouDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUDej72d7S1VmbDCXZgfNRQ5xVljog3jGl8RsU91e3CfPFd7QZ+ZruUXuaVUUBYy0s1MaJxCIOpr0ukByCMSPPldFkP0MzStLoIRiUEvI5LTpLmWpJvQAx+e5XvqTeEcRjwtG8MpGalfBwPIWFiHdyA9MgAulIOwFFuMdqqfPrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTNuYHTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A24C4CEE3;
	Thu, 10 Jul 2025 06:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752127449;
	bh=B+sJSqD8NmZGbYk1pEEsdF8fEb/eO8C56DGLEoxouDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QTNuYHTmPUJJJCAT338pfpgXIUa1sBZGchxxgk3+JKVicggAa57NsABTr/Q09In+t
	 C3oNq9jKkJaVSyXqiiYrP/aZgOR+9H4dCu+BxWBaaQHRmcG+NcsKF0eNZHXdFNcrbV
	 vFDg3y7iS2YpSdc/ReiyRWlSUfplnLK5yyGC1RXaVInGmc1fP7tT0+9mjcONH2U7F+
	 T5orlE5AkGBgKu5JxPdpNJcKFx9Dra8zKZ8kYuo9isAlZ3ouSVkivfj+tefMl0E1UQ
	 0j4Ir6NN6HFt6LYoopSZk8ywbU00JpiYqHjQ+jeauJrzE3EzOVxXNzekogVv4o0iMI
	 dec53cfRFAgFA==
Date: Wed, 9 Jul 2025 23:04:07 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next V6 09/13] devlink: Add 'keep_link_up' generic
 devlink device param
Message-ID: <aG9X13Hrg1_1eBQq@x130>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-10-saeed@kernel.org>
 <20250709195801.60b3f4f2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250709195801.60b3f4f2@kernel.org>

On 09 Jul 19:58, Jakub Kicinski wrote:
>On Tue,  8 Jul 2025 20:04:51 -0700 Saeed Mahameed wrote:
>> Devices that support this in permanent mode will be requested to keep the
>> port link up even when driver is not loaded, netdev carrier state won't
>> affect the physical port link state.
>>
>> This is useful for when the link is needed to access onboard management
>> such as BMC, even if the host driver isn't loaded.
>
>Dunno. This deserves a fuller API, and it's squarely and netdev thing.
>Let's not add it to devlink.

I don't see anything missing in the definition of this parameter
'keep_link_up' it is pretty much self-explanatory, for legacy reasons the
netdev controls the underlying physical link state. But this is not
true anymore for complex setups (multi-host, DPU, etc..).
This is not different as BMC is sort of multi-host, and physical link
control here is delegated to the firmware.

Also do we really want netdev to expose API for permanent nic tunables ?
I thought this is why we invented devlink to offload raw NIC underlying
tunables.

Thanks,
Saeed.


