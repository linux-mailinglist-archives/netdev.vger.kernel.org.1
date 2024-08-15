Return-Path: <netdev+bounces-118778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EC6952C48
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7D4284208
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6017DA69;
	Thu, 15 Aug 2024 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="VBJgshnP"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42061714D7
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723714853; cv=pass; b=ZhrOpOR+x6/HQX8FmpKyIiy9KriTpHzzLBHBO7N52w/OowZRcff2qPk2eDphxt0O+yVKiQtoygEx9xSjY9qdvq3rTqepgrAGAC2qNKIsGoe4wV78x81ALi5nLmvovBpVGngJi9bHR/LMwf3ewu+8KTtEb/fJR8BFI56iOkJfz4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723714853; c=relaxed/simple;
	bh=lTHI5lq9xwfORcoP715iCs9bBNyPe6Rxqxs3jWy8xNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9clnGW+k+5uXROolwQj+EN+nCe4RumA1mvEaTjlSpjukBgomPyGBZfwZ+ZmPQsgYnCh1hnlns/GgeVL9zI2gbaDpNdGzKgn+lbKPzGuqMNmYmxr38jc7LBB6eDC3+oG09aTQIMS6NJGEM0P88GFJnOgJwjqgxLkk8qCwZc4a84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=VBJgshnP; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1723714833; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i/CQ+SbBVEgcQFcpjgtfjylQKJ5W3nFG19bcq1yThEnBMAQ3LDBE7tuBtQRn3mCEN+/pLBOqS9TycXb0JYkM6H9sarvW2k8LV7Ch3sireVPi1IEjJyZRUWzKq0DZZvB77F7I9pcb4kJmSRtset9y/MFoXEJ990uKSKkLXAu4vZA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723714833; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IoGXtB+kXxKO/f7XbLU6aNrZqu38AU5Ibp1hCw5ugFE=; 
	b=jByNTfOFFDOPBXgJeS35Ss0SRmRD3TFy07iZegGhZQqho5C1nlIU3ZEJ6Wvuc7AER0XW1KUnLjaU/q/qOeMrZSPHLepNPX32B6DYTT4T+bYk8FGmw8oY5OT7H6fXvaCDqpd1Ab5p3NNtZwmvCBfeoRlr03r9WO+OVdjwMZK81PY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723714833;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IoGXtB+kXxKO/f7XbLU6aNrZqu38AU5Ibp1hCw5ugFE=;
	b=VBJgshnPakAd0hdgPyB4AQPwdtUMDUb2rUxB6XylDFv7qZ9twvUyUagCx1RmIRXU
	DphnO0HHrtVKlemgWY3fO56H5F/hrP5HUBzuL5c5f2eqd4RUrQiIOsjcohAYfGDj5uD
	cPLK9WSKgVSp1ta8JB6zxvcYTEigxQPY8K2o9COQmJxjpoUVKkcOy8MvJZQZ2BFsGKw
	yDfrcjLtr4ysLMF3uFHcyH89FlLPUdLqr8A/3Iypm9mmNp8c2kOfPAH4Spp8nGwXnGa
	B9f/t/CHZteINFgoA9NrcC0LxUUa6am4qQEN/ejkaPSxDkoBS8UMkKOuSG2q44H4cbP
	2n4xfUMWgA==
Received: by mx.zohomail.com with SMTPS id 1723714830790607.5481291648456;
	Thu, 15 Aug 2024 02:40:30 -0700 (PDT)
Message-ID: <1ed179d2-cedc-40d3-95ea-70c80ef25d91@machnikowski.net>
Date: Thu, 15 Aug 2024 11:40:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] ptp: Add esterror support
To: Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 jacob.e.keller@intel.com, darinzon@amazon.com, kuba@kernel.org
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
 <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>
 <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>
 <166cb090-8dab-46a9-90a0-ff51553ef483@machnikowski.net>
 <Zr17vLsheLjXKm3Y@hoboy.vegasvil.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <Zr17vLsheLjXKm3Y@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 15/08/2024 05:53, Richard Cochran wrote:
> On Wed, Aug 14, 2024 at 05:08:24PM +0200, Maciek Machnikowski wrote:
> 
>> The esterror should return the error calculated by the device. There is
>> no standard defining this, but the simplest implementation can put the
>> offset calculated by the ptp daemon, or the offset to the nearest PPS in
>> cases where PPS is used as a source of time
> 
> So user space produces the number, and other user space consumes it?
> 
> Sounds like it should say in user space, shared over some IPC, like
> PTP management messages for example.

The user spaces may run on completely isolated platforms in isolated
network with no direct path to communicate that.
I'm well aware of different solutions on the same platform (libpmc, AWS
Nitro or Clock Manager) , but this patchset tries to address different
use case
> 
>> the ADJ_ESTERROR to push the error estimate to the device. The device
>> will then be able to
>> a. provide that information to hardware clocks on different functions
> 
> Not really, because there no in-kernel API for one device to query
> another.  At least you didn't provide one.  Looks like you mean that
> some user space program sets the value, and another program reads it
> to share it with other devices?
> 
>> b. prevent time-dependent functionalities from acting when a clock
>> shifts beyond a predefined limit.
> 
> This can be controlled by the user space stack.  For example, "if
> estimated error exceeds threshold, disable PPS output".
> 
> Thanks,
> Richard
It's doable if everything runs on the same OS, but there are cases where
time sync is part of management and we will want to disable features on
different PFs/VFs as a result of bad time synchronizations. Such
features include launchtime or time-based congestion control which are
part of infrastructure.

