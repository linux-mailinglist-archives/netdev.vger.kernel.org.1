Return-Path: <netdev+bounces-115904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014339484E4
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE2D1F22828
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 21:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FD516190C;
	Mon,  5 Aug 2024 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XAYjKKKl"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B0149C6E
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893608; cv=none; b=QWRe7hNHDkXsnYSLhDr+Jn/arY3jUlUz0QnI0/bFw751q/pIqMBBQjAwikingVMq4FD6PHcj8CPTuEIi1cBdjbpzLx/bgOxW5vZME9FkY71iQxvNeuw8leD5PrhcSvM8l5W7jCHU9HDBoLreQyiMKcxqrBcBO+0c87RJdxWJd7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893608; c=relaxed/simple;
	bh=5qkxxnr7uDgGItwplXolKWtbBedts6NrTURjWN4etVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPZliB0WoKjZtraouLV0aXBWaJGTn9DC5BiMGwzdDaFWx2pllM/pJbS6ODe4j19lZGoeS9nLFI/5vYoIqfN9J0iUb5NbBI9aUba+8dJ4/Fc/73EnNvlQWHHSj6REJkR33ORQpxqaOuK4uzDmIxAuJ1E9pMBQTOxYCUiQf2bx3xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XAYjKKKl; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f5f04c4b-7064-400e-b8bd-004c0d21c74e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722893601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3kC2GrplLdNecPLcTp1SFEewNS0mVM4TkTf6aY8L+o=;
	b=XAYjKKKlBmXqKgg0w+lEyWmuJUWKQ8fsm2TWcjwLCpvjJUJI2mKDcdv3/U0eSpeaAlaiRJ
	+YUn0hPIQulLxAukPWg14BRwhl4NjAQHtj1tScigGxdNogAAJ5sbynLI5vCzGU00vdQ+9P
	ULMo7vmdoEBg57jnh3fpqcs+zup++bs=
Date: Mon, 5 Aug 2024 22:33:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ptp: ocp: adjust sysfs entries to expose tty
 information
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jiri Slaby
 <jirislaby@kernel.org>, netdev@vger.kernel.org
References: <20240802154634.2563920-1-vadfed@meta.com>
 <2024080343-overture-stew-aee9@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <2024080343-overture-stew-aee9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03.08.2024 08:12, Greg Kroah-Hartman wrote:
> On Fri, Aug 02, 2024 at 08:46:34AM -0700, Vadim Fedorenko wrote:
>> Starting v6.8 the serial port subsystem changed the hierarchy of devices
>> and symlinks are not working anymore. Previous discussion made it clear
>> that the idea of symlinks for tty devices was wrong by design. Implement
>> additional attributes to expose the information. Fixes tag points to the
>> commit which introduced the change.
> 
> No Documentation/ABI/ updates?
> 

Ah... totally forgot about it. Will make it in v2,
Thanks!

