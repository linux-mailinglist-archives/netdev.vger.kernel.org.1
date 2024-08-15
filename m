Return-Path: <netdev+bounces-118779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29A8952C49
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD3928400F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC56719D8BA;
	Thu, 15 Aug 2024 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="XBlxBaYY"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2441714D7
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723714883; cv=pass; b=kvbcyA9+GdX5Myj6V74VT10qh4k/YDqYHeixOYEGs4DnhNdq4XuVV41qZvdLzzTK4XQdpUZvh1QN+krMTAqAFpCGrPuHNQ8O1rqQGSSZ1FG0nk+dgzEyltIwWCHycHOjM4EEyWwr83qetTHZJquXOOQEE075f0LGPwIS1yX8IjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723714883; c=relaxed/simple;
	bh=mg5SFzY/s/tNTj69kCybAxxSjjyMEpBgQ6iqN9WKcnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiVKNvmvNMJTZx+/ml39Am9jBw4IikomAgOdC9UHIFxk6sq8jLU8j5nNQHU400mbzSPqsA7zNnuA/0rOq2FDB6Os0w+xdMShmolFwLloB26ePy6FuXpmZsaEA0X7OEb/W/RO5eCnoemSapRIQqpEVyXIXrh0oQxLmFMLR8bgHDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=XBlxBaYY; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1723714868; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G+a1b4nlaJAzUpCK7j0MEHfZDhMh5mzCj+Qeky4QY0nm2eLrn2+vH75FknZZt26JnSLKaM5VkaQ/Vw7qgc1ORB8qpr10or+/7Zam4PfiWLWHG/H6vU6GbQroHmKS4I71IdkSggRK1c8d1jDTZUW8I5UID8kTUJeU+apL0t/Ri/g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723714868; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kNTL3CSFqQa/BhU/52ZlxEors/CFFPiovqa5eu0s1vY=; 
	b=H76b1vq/+Q3mGFcy8A5a5fBrRYJBy2SsHiiA9gaQ9iQhhF7GSS+V7EFg2rX5hezUR73Go/1kgBbQ/5vK+vqS7KmXaoWjZzhj9ndAWlDIWjM1Yg+cPDYk7riMeBd33W3GXWkx2c2Fs9Oxs4QnqgrdCe9hUGE8ikI4zA6DsTSg8RU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723714868;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=kNTL3CSFqQa/BhU/52ZlxEors/CFFPiovqa5eu0s1vY=;
	b=XBlxBaYYlDXWdd4nL+vWEmfw0gUf+mVhbknhYW58F2D+Z5ichtze0BPM694pxN1x
	JFF5mCPCVpbgqgPutEC1w7dJNEnECNZ/Wj/PV10PPs/hoj5lZ4FJ4VMO1pIZS/M0Hm1
	PANlmztLBiV+8x7QeSvpvVcr+xkp4GiDPM1DJgrVRPIknWmiX9ZqLF+RRV3JkqxHyhO
	paJpCjEbwBtukdWCK0DA+/NUjCQKF5jZxumTyRKTLt8YQRfhykfjVKWXatD40HKJFoz
	Xh05QP5wLFy/WxjzhICNSvoSurOxrwz9MMSJ2CrHs3LdwwaEX1YThv0k68r5+79fZ0Z
	ahlJN3meMA==
Received: by mx.zohomail.com with SMTPS id 1723714866802410.0035902741008;
	Thu, 15 Aug 2024 02:41:06 -0700 (PDT)
Message-ID: <3ee121a9-6326-4cd0-8440-38f13255c3b4@machnikowski.net>
Date: Thu, 15 Aug 2024 11:41:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] ptp: Add esterror support
To: Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Miroslav Lichvar <mlichvar@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 jacob.e.keller@intel.com, darinzon@amazon.com, kuba@kernel.org
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
 <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>
 <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>
 <Zr13BpeT1on0k7TN@hoboy.vegasvil.org> <Zr2BDLnmIHCrceze@hoboy.vegasvil.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <Zr2BDLnmIHCrceze@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 15/08/2024 06:16, Richard Cochran wrote:
> On Wed, Aug 14, 2024 at 08:33:26PM -0700, Richard Cochran wrote:
>> On Wed, Aug 14, 2024 at 03:08:07PM +0200, Andrew Lunn wrote:
>>
>>> So the driver itself does not know its own error? It has to be told
>>> it, so it can report it back to user space. Then why bother, just put
>>> it directly into the ptp4l configuration file?
>>
>> This way my first reaction as well.
> 
> Actually, looking at the NTP code, we have:
> 
> void process_adjtimex_modes(const struct __kernel_timex *txc,)
> {
> 	...
> 	if (txc->modes & ADJ_ESTERROR)
> 		time_esterror = txc->esterror;
> 	...
> }
> 
> So I guess PHCs should also support setting this from user space?
> 
> adding CC: Miroslav
> 
> At least it would be consistent.
> 
> 
> Thanks,
> Richard

Yes! It's exactly what inspired this patchset :)

