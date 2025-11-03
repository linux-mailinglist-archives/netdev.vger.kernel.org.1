Return-Path: <netdev+bounces-235190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E3CC2D463
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 17:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA43E189BC49
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C513164B7;
	Mon,  3 Nov 2025 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1PdcpMP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC0A3164A6
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188796; cv=none; b=qWIaPmlLMjHGBD3fYPuwywFLlzfAgdH5nrzFxVqGcQxcBXNBIYsqwj2VkafNSm0p0vVxHcHRrSV4i0K2IK1rvGpOYkY4NMrIdWfv6QdwCRHWD9fvPNOGy5uvlsrVPVzr4J+nAPCBtpUe9AoujyJOfCpkeRcEyGuhz0Hw+oCbBF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188796; c=relaxed/simple;
	bh=g4/PzezksU6EuTgtLO1bKiTXlw4axPqEhICJMzXtlhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhN1G2VgsCC8KfMj14iIicyHxvgYY4ItiX5WNNet0/AIdjIJ1QEFJz8o9BdMc4MnaGhgCkrJNz6uvBwUeiGcCue0UjQ0pqmd1shQ5l1tOel1Vgu2+lDqBE5KVAgV2Ll73w4gjlL7OzErfoi8E4s6DJLHFqjxUiLrDR7GIP+u6Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1PdcpMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1835AC4CEE7;
	Mon,  3 Nov 2025 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188796;
	bh=g4/PzezksU6EuTgtLO1bKiTXlw4axPqEhICJMzXtlhc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W1PdcpMPHIPYWz1r7W5xXQMX3XPHEvh7jtzKUiRBi/V3LPVWH4WDuRhDiNIvhhz1q
	 oZzfUJktTzzXl9WAEeU0ds6tv919TjKqyzlgS1oEvNTj4bRGQE2vCemDtSupOzpE7b
	 BSlicurZGqfIRfo6vD2He/qftOigR8gM21srRpWSwUqpzTBB4mCvnmXXti7eg0OoFo
	 a68hMih/j1fliEo0RfWgJkGuyV+FmSlt8PpzZNVaDP4c/DrwurFlqwDG5lSwx7MAGx
	 j0BqNuk404focdpUvanPmt7Lkw/O2eTJUz7ajpBSBOEKPICQmmOnXUwgpFT6ZuCGjp
	 pEnQQsHNAyCHw==
Message-ID: <5f71a913-7a11-4256-91bd-33c546041cd1@kernel.org>
Date: Mon, 3 Nov 2025 09:53:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] devlink: Add support for 64bit parameters
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Petr Oros <poros@redhat.com>, Jiri Pirko <jiri@resnulli.us>
References: <20251030194200.1006201-1-ivecera@redhat.com>
 <c0f06b60-f890-4f0e-b736-3bfe8c54114f@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <c0f06b60-f890-4f0e-b736-3bfe8c54114f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/25 1:56 AM, Ivan Vecera wrote:
> On 10/30/25 8:42 PM, Ivan Vecera wrote:
>> Kernel commit c0ef144695910 ("devlink: Add support for u64 parameters")
>> added support for 64bit devlink parameters, add the support for them
>> also into devlink utility userspace counterpart.
>>
>> Cc: Jiri Pirko <jiri@resnulli.us>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
> 
> Tested on Microchip EDS2 development board...
> 
> Prior patch:
> 
> root@eds2:~# devlink dev param set i2c/1-0070 name clock_id value 1234
> cmode driverinit
> Value type not supported
> root@eds2:~#
> 
> After patch:
> 
> root@eds2:~# devlink dev param set i2c/1-0070 name clock_id value 1234
> cmode driverinit
> root@eds2:~#
> 
> Ivan
> 

Added the testing to the commit message and applied to iproute2-next

