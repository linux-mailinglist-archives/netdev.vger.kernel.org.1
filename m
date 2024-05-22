Return-Path: <netdev+bounces-97652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862F18CC955
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 01:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2478D1F21FB5
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 23:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760D080C04;
	Wed, 22 May 2024 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="QAGOE1q6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D301E4AF
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716418962; cv=none; b=piTNdbXSYIaIy4U08mTatvBUy3vpM/x83N9axepEHCnJp7Iw9A/HoWb0yzZ7ym3c6x+bMDYPk6xFdcxXyfi5boIEJlzYEtwC8hzQJfeuYjiVPEJsLeBW1AcGJHKbOUEphg52sdCOm0X/Wvk2yXpPoAcIlTBDxnGq1o1/KGId7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716418962; c=relaxed/simple;
	bh=1PLwRNGUwi1sVzI0YA6hsn7ehjvr7ZDNrwLUePNPges=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGnFSzwMffS1VibwPXhhjRXGf505t1qKbcmUk0cLU5/tZVt8oBKmgxH/SGfIhGnMawg816ABPFBopcmTKfm4dG7irgdN+ID3eJ6vrA02/XWMQQs6aA8rPyQ3qmrS4MKAeLYt8X43ldxBKovmX7kqdn6Be6o8jn7SQyFTxxG/cWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=QAGOE1q6; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description;
	bh=1PLwRNGUwi1sVzI0YA6hsn7ehjvr7ZDNrwLUePNPges=; b=QAGOE1q6XYKvkQKfsHV4XkXLMW
	VH1poTBRxFNEJPWCDtutuQQ8BV0KFcGGYSPY8awfi3q3OqvqbuNHn6bJcuQgQI+WyFPqqy1EOY6Yi
	MMpSGJqyFaGk3VWTy/bNN5fwTeRjRTFE87j6CaVIFKqWND7O+lL6PtNpA9V59S3vBYlYhsNPUgbFl
	NZ5R34C2ClycLKdldiOw9rp/Rn6SYTQBRsk270GPf+19lGBkkw0kCYF7x0qd3Mbg3yS94AYCpPhm/
	T8EEn6bqGiBZoj8hQIpSYg26P5wW3esnMEraCndweUGgFQySnZbuIrOuTYGxcAkakT7slAtAefJB0
	B//9WDtg==;
Received: from [192.168.9.10]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1s9uyk-000ezQ-1K;
	Wed, 22 May 2024 23:02:38 +0000
Message-ID: <e13fe956-a52f-4b51-a84e-8bcf860bb8cf@gedalya.net>
Date: Thu, 23 May 2024 07:02:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [resend] color: default to dark background
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Dragan Simic <dsimic@manjaro.org>, netdev@vger.kernel.org
References: <E1s9rpA-00000006Jy7-18Q5@ws2.gedalya.net>
 <20240522135721.7da9b30c@hermes.local>
 <67841f35-a2bb-49a5-becd-db2defe4e4fa@gedalya.net>
 <2866a9935b3fa3eafe51625b5bdfaa30@manjaro.org>
 <20240522143354.0214e054@hermes.local>
 <5b8dfe40-e72e-4310-85b5-aa607bad1638@gedalya.net>
 <20240522155234.6180d92d@hermes.local>
Content-Language: en-US
From: Gedalya <gedalya@gedalya.net>
In-Reply-To: <20240522155234.6180d92d@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/24 6:52 AM, Stephen Hemminger wrote:

> Overall, I am concerned that changing this will upset existing users.
> Not that it is impossible, just need more consensus and testing.

Makes sense.
It seems that possible negative impact would be when the following are all true:

1. Users actually using color. For debian and derivatives, up until now this
would have been people enabling color themselves.
Debian's recent enabling color by default was the impetus for this issue.

2. Using light background.

3. Not using COLORFGBG, or setting it incorrectly.



