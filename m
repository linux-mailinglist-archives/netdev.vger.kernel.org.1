Return-Path: <netdev+bounces-163673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F64A2B4F7
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB1E16735F
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5669F1A9B3D;
	Thu,  6 Feb 2025 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qvkRxQor"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D215B99E
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738880619; cv=none; b=XcM9qDKTVRq8f7XpU7L4DQpidg7vdCf5s0NwlobkIyDUoOLwfwbt28Cd64OAfdnRJgu0OXvKSsiGg4LgpC5oGVZ5dbGajeDuAnMtiWRV/uDDe9PDg5Z8/vyyXlXb0O4JDB2JwoQnhGUn1tAhDJgGn3emyO8Sb15y7oHiwrLqtnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738880619; c=relaxed/simple;
	bh=T/1KdcQxA8MYsab19f1ReuZRf5+pbnfyFcB0YuJ8T3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWcuQce2iQwN1Bw6HBwbPloeOofGy4d+vugQhj/5nCvLvsZNOKOaJHwbVYSfAMbaFE/0A9v9FwJJbyiqJQX7uWx/EMRh1feZV+uw9J1sIBINyUGmGhPxZkUJJvXSFXwKGLOdbMRtwZMdDfRkjD2l/wco5FlWZBgmquUdizGzRG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qvkRxQor; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8a4335c5-8761-421f-9133-1805df606a90@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738880613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2vaqhGeAWhH1hYyX8B4oDzEXpvXhzKX+eKvTeDAePQ=;
	b=qvkRxQorJF98R+kzNw+W958LdvMLbl2YjXN0eJjz72DBNb411X8gnyjjHNOc/8euschnYg
	kuYXScue2Tk7U2axVi6A6SFH0KYWJbaYxbcI2ypBmZ2jamNSS3u3RGZrImNeA0tz8xTUG8
	efuCadJP8owm/WJFulEJcaBFsmwUvKs=
Date: Thu, 6 Feb 2025 22:23:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] ptp: Add file permission checks on PHC
To: Wojtek Wasko <wwasko@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>
References: <DM4PR12MB8558CE01707ED1DD3305A9FCBEF62@DM4PR12MB8558.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <DM4PR12MB8558CE01707ED1DD3305A9FCBEF62@DM4PR12MB8558.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 06/02/2025 11:03, Wojtek Wasko wrote:
> Many devices implement highly accurate clocks, which the kernel manages
> as PTP Hardware Clocks (PHCs). Userspace applications rely on these
> clocks to timestamp events, trace workload execution, correlate
> timescales across devices, and keep various clocks in sync.
> 
> The kernel’s current implementation of PTP clocks does not enforce file
> permissions checks for most device operations except for POSIX clock
> operations, where file mode is verified in the POSIX layer before forwarding
> the call to the PTP subsystem. Consequently, it is common practice to not give
> unprivileged userspace applications any access to PTP clocks whatsoever by
> giving the PTP chardevs 600 permissions. An example of users running into this
> limitation is documented in [1].
> 
> This patch adds permission checks for functions that modify the state of
> a PTP device. POSIX clock operations (settime, adjtime) continue to be
> checked in the POSIX layer. One limitation remains: querying the
> adjusted frequency of a PTP device (using adjtime() with an empty modes
> field) is not supported for chardevs opened without WRITE permissions,
> as the POSIX layer mandates WRITE access for any adjtime operation.
> 
> [1] https://lists.nwtime.org/sympa/arc/linuxptp-users/2024-01/msg00036.html
> 
> Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
> ---
>   drivers/ptp/ptp_chardev.c             | 52 ++++++++++++++++++++-------
>   drivers/ptp/ptp_private.h             |  5 +++
>   tools/testing/selftests/ptp/testptp.c | 37 +++++++++++--------
>   3 files changed, 67 insertions(+), 27 deletions(-)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

