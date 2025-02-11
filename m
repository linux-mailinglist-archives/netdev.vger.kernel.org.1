Return-Path: <netdev+bounces-165233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1300CA31272
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF833A54CF
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 17:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C84261397;
	Tue, 11 Feb 2025 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AwKYb47a"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71B26214F
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293685; cv=none; b=BgmeLokByIdnzjZ7ynClfGBjQuUyCmPEyyhRydune7EfGfeF5fXdMyI8kiNkwS+U/djGO9zofv3LG/2kPeuiZpdGKapw32Rfj5u3I+/V8jWdI17Hr/LEjSmjmVx7lvy66s3SXhkGz/D6qKPr8yEQDi563c4BM2SmbBV53VIeQ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293685; c=relaxed/simple;
	bh=MGBeZIj/iHkRnEY3BWsaO/5b9dhRffx5PK6XwOtyEKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWUycVRFn2Ou8EfCAw00UQ/hM3FWe0JZEpKUYGkXCiA57ZkoTzp4fgKKkRP38KLWKe2JACoim3XEdx940C1Ih0oJPcSXoj586mdoce/6eZpRn8fW2SJnf0LkpHE0DEnxsunBjmRStNw1RCq8pzk673EdDBlK5aLvy67pU6IUIfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AwKYb47a; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7d5a9943-63ec-491e-b439-ba2187ea972c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739293677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhwbj30VEUi9E/ndR0mfufR7NqA8DBACvY+1FulmKlY=;
	b=AwKYb47ab/oFG8OuhSlEy4c9W+b6AG26CV2seV4MLya0nWUJ2Mc7tIrD8aJXiWHg4CTB4m
	/1GocdeCogannlv6AMmZzNsKsGfcjvVCR2SyNbO8uGO9dGEPBnH2OaUTE3u8woi/mhQijt
	76SOfyhDZtR2ODQvq2aOfhIzqRkIf+g=
Date: Tue, 11 Feb 2025 17:07:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 0/3] Permission checks for dynamic POSIX
 clocks
To: Wojtek Wasko <wwasko@nvidia.com>, netdev@vger.kernel.org
Cc: richardcochran@gmail.com, kuba@kernel.org, horms@kernel.org
References: <20250211150913.772545-1-wwasko@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250211150913.772545-1-wwasko@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/02/2025 15:09, Wojtek Wasko wrote:
> Dynamic clocks - such as PTP clocks - extend beyond the standard POSIX
> clock API by using ioctl calls. While file permissions are enforced for
> standard POSIX operations, they are not implemented for ioctl calls,
> since the POSIX layer cannot differentiate between calls which modify
> the clock's state (like enabling PPS output generation) and those that
> don't (such as retrieving the clock's PPS capabilities).
> 
> On the other hand, drivers implementing the dynamic clocks lack the
> necessary information context to enforce permission checks themselves.
> 
> Add a struct file pointer to the POSIX clock context and use it to
> implement the appropriate permission checks on PTP chardevs. Add a
> readonly option to testptp.
> 
> Changes in v2:
> - Store file pointer in POSIX clock context rather than fmode in the PTP
>    clock's private data, as suggested by Richard.
> - Move testptp.c changes into separate patch.
> 
> Wojtek Wasko (3):
>    posix clocks: Store file pointer in clock context
>    ptp: Add file permission checks on PHCs
>    testptp: Add option to open PHC in readonly mode
> 
>   drivers/ptp/ptp_chardev.c             | 16 ++++++++++++
>   include/linux/posix-clock.h           |  6 ++++-
>   kernel/time/posix-clock.c             |  1 +
>   tools/testing/selftests/ptp/testptp.c | 37 +++++++++++++++++----------
>   4 files changed, 45 insertions(+), 15 deletions(-)
> 

For the series:
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

