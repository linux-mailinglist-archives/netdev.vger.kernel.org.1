Return-Path: <netdev+bounces-118775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31554952C39
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F481C2149F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82741C824F;
	Thu, 15 Aug 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="XeOQSKWr"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4244119DF94
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723714559; cv=pass; b=JgiKZRlLgLIsYd5IxAxwnSYZb1EABRTZe3shDhzKLOZbsyVR3x8/i2dffbOW/dSNcgJluolQdqi50SRFXelND19Rx+qMPAWFU8bnaRgMn4pn0TbSmjeSnsVX678p2QIpcFyqIUwdbe1o9sn/k0k35nZVgLoiOkBY9QZbxkUvMKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723714559; c=relaxed/simple;
	bh=kelK74cowp7BXiy1HRRrgecSG6vc5Vw5wQQx7hKLS6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KylXL50NE/14MI8pmStkoqNln31z8M/2/PHmqEg9uRYy+PZ7XYlMwPepdG6ION9xjT6ZCy/2SZ0o8NnYgTJ3WZsKUSftGH2jUpTaSFLc1uikhH91oGSgoHFyJiaRoYo0SvVWgObGXACNuXk5zBsxYnqPAAZpcL2ePCrBDbWDb18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=XeOQSKWr; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1723714551; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IhIelfjdSywMI+Escq+dinmw+/SrNnF+rLgcwlVwC2yd9Kit1tcENLn8JUWjO4sCfMjjMDFzk+2HTx1ReqS4ZvuM2BfWJLClnbXnUZQK8yXJ+XctNLosQekaTQKNEa4eww2WJLWbdpHec4HbFwedrU/RcY9Ij/4YIFRu3lZ6G1U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723714551; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eAjppfXM/L2DOUszHwBRMyMdUE9d7B9ws9GUpLjaqLM=; 
	b=HjaAa2lomYSLIozT6A905cemGEwFklncSi+5E1XYveeXV/lOc/ePMlJQlP/aaQTWkGW60dNXKqt8oZyG5otVh5hK1Z7pCWq5FwOcZcYo3yXjMqgdLiMoH4qyGLLHEQN8ogE8sAemzr5biZ3hqbM9j8sGMadD6cT63Pj8Fh62agE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723714551;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=eAjppfXM/L2DOUszHwBRMyMdUE9d7B9ws9GUpLjaqLM=;
	b=XeOQSKWr9j0sWf24usDZFpbw2dfpbHlhtS7tmQpI0YXbXYW1+zs7NbtYVzEZATYB
	T6b3fzhXlbKD9nvLchfpE6LRLEj0P/grOdFSHI25r4kWRFTpuxpy54BR6FTD6wX2nTA
	HL2wnyycnfhKcczo615gIlhysK2swqcrqNNq8BL3/KIPjmdePB9/RTHHHLk4b9VsWwc
	7h8ryGJ6sBQVBg4We6FKSf+fW5tgehB0YU/l3tXE8oIwHTUGfZSF5QQYMHxcro4n3F+
	GUexxJMcVQLD1QlF+SiaM5S7m+0rV5TvD0RmIA9XjmLBUKQ0tAzVB7J1JlSI9q9Y/rf
	h6QbY5a8Yg==
Received: by mx.zohomail.com with SMTPS id 1723714549404890.5555411899178;
	Thu, 15 Aug 2024 02:35:49 -0700 (PDT)
Message-ID: <38459609-c0a3-434a-aeba-31dd56eb96f8@machnikowski.net>
Date: Thu, 15 Aug 2024 11:35:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] ptp: Add esterror support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 jacob.e.keller@intel.com, vadfed@meta.com, darinzon@amazon.com
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <20240814174147.761e1ea7@kernel.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20240814174147.761e1ea7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 15/08/2024 02:41, Jakub Kicinski wrote:
> On Tue, 13 Aug 2024 12:55:59 +0000 Maciek Machnikowski wrote:
>> This patch series implements handling of timex esterror field
>> by ptp devices.
>>
>> Esterror field can be used to return or set the estimated error
>> of the clock. This is useful for devices containing a hardware
>> clock that is controlled and synchronized internally (such as
>> a time card) or when the synchronization is pushed to the embedded
>> CPU of a DPU.
>>
>> Current implementation of ADJ_ESTERROR can enable pushing
>> current offset of the clock calculated by a userspace app
>> to the device, which can act upon this information by enabling
>> or disabling time-related functions when certain boundaries
>> are not met (eg. packet launchtime)
> 
> Please do CC people who are working on the VM / PTP / vdso thing,
> and time people like tglx. And an implementation for a real device
> would be nice to establish attention.

Noted - will CC in future releases.

AWS planned the implementation in ENA driver - will work with David on
making it part of the patchset once we "upgrade" from an RFC - but
wanted to discuss the approach first.

