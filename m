Return-Path: <netdev+bounces-212062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63F8B1DA4F
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 16:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFAE07AC38C
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 14:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDB425E44D;
	Thu,  7 Aug 2025 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPOUqGrz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D42367B3;
	Thu,  7 Aug 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577964; cv=none; b=M3++QuZyLZ42d2n/7+qSDFzrfHkS6bZJmgcASALCUatkn+mKjxCQgKD0Eh5xcJwZGLL5Lw4AlLoa45+RZnCbWq3x1KUYkz+GomUEY2xqP7B3G/9ZbXdn2UQNB4lzKc94R/Ptw2RH2YoTS5L3HeorXwqi7N5KsOSiQ0IjdEF4mUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577964; c=relaxed/simple;
	bh=v9UBJJ7rw8xXktUNTfxDHSa6umxXPmKyqhV0mzMycic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3PGuT1WCpIoDABu5kHrlqiqvuFcNSw7kyl9QkYWg00TjDWoObPy85zLbhTPvw0XrqvOG2osBGnVPIgioHwotJ+TPelmqAuRN7F4Crc6HRNjSb9SU6G7WbL00f+MG7qD10KBogZ/MZ5hcdhI4VNE3OodNMwbAYOhP+qPJF8c3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPOUqGrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336B9C4CEEB;
	Thu,  7 Aug 2025 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754577963;
	bh=v9UBJJ7rw8xXktUNTfxDHSa6umxXPmKyqhV0mzMycic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OPOUqGrzsYJarf7g1JDrMPWbSRs9d8zUvXo+aAsqeXwZbug+Jfh2n/zxRq3MNdWeH
	 ccS3GaiZeeMeOHt5cHtHjt0sXnNIkDKMZjekYj5U9WdG1db1mKOPIbRVXOE6nxNRVX
	 yv8k+LSLdwpCTtvkwBGnVHcXIXDoSs1JBRsMS4wyAAmBBiCc/kBm/RCktW07BuNUgh
	 omYsbGBt6Woh4YdIAU7VrADUyBpAqBpRkbYWJjddRWyxAz95coP9nMKjjYKocc8icw
	 3NE74/cb1QP0ipB7/Q/s7EgGukns2kfu+7oxAlG96q4EepSoHdUreYClq+zaxWQWzr
	 xTFJooMtXVIhA==
Date: Thu, 7 Aug 2025 07:46:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for v6.17-rc1
Message-ID: <20250807074602.6082bd34@kernel.org>
In-Reply-To: <20250807144345.806381-1-kuba@kernel.org>
References: <20250807144345.806381-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Aug 2025 07:43:45 -0700 Jakub Kicinski wrote:
> Previous releases - regressions:
> 
>  - netlink: avoid infinite retry looping in netlink_unicast()
> 
> Previous releases - always broken:
> 
>  - packet: fix a race in packet_set_ring() and packet_notifier()
> 
>  - ipv6: reject malicious packets in ipv6_gso_segment()
> 
>  - sched: mqprio: fix stack out-of-bounds write in tc entry parsing
> 
>  - net: drop UFO packets (injected via virtio) in udp_rcv_segment()
> 
>  - eth: mlx5: correctly set gso_segs when LRO is used, avoid false
>    positive checksum validation errors
> 
>  - netpoll: prevent hanging NAPI when netcons gets enabled
> 
>  - phy: mscc: fix parsing of unicast frames for PTP timestamping
> 
>  - number of device tree / OF reference leak fixes

Eric just sent a trivial follow up to one of the fixes here.
Let me respin real quick..

