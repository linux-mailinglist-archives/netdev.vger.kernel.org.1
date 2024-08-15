Return-Path: <netdev+bounces-119015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF30953D23
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 00:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9F41F23965
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 22:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3D014D2B8;
	Thu, 15 Aug 2024 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="Y1r+nkAs"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF4014A089
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723759630; cv=pass; b=gcvcI1G75ak7YMg++MFlYrNmrbsJ32ZhOV52FDLqk1h7APUAbeJ/cRFDoO7yU0z1LmH7i+ppSR5Rmm7EdptFqiLwn57/Dqcf6v/5gxN3KUxIeZBGU5ZhYkSsqO9cXpXca0pP2U5IjHv+UNTTAGfl0vixt1Pa0ZX5nKyMDQApGWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723759630; c=relaxed/simple;
	bh=7tN9QaDcEe6swWfiv//Qee41PZEZvXM4Gb6lljFceF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZvJrnYIRxwxfmdl9mSy3ZiZrS7VvtgX4bUDVPSF4XAaSyY7IbSYoBfXXQ/otKUUhrPxkhYgh/6SXOaa5hrbVaivshbKgCoTZlhU/lRdbqjh4UDJ2c/SpSh8QWBykskjAUySTqvfCcvgD9XLnK+9sJ3jSNK6Jtu5PZb20x8BFfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=Y1r+nkAs; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1723759617; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SVcV0Y+X2y/9nycMEdca7TjDiqzT9uoBFggDzaG5XJKLkyAQI674EhMboezrg41+VS8y06MyYiD5OXiLVoF8p8w+Ks5/W9+n6erO2zxo9CPPLRYr+Zr0vso5+3H2GUrw4tlVRtjmwxCa6tqfT/U/gFLa3C53CrgBFeOzIBOFzAk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723759617; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=94enMT6IgcWD7o283z6nZs0lSa0qSTbUCX8c6kC/usU=; 
	b=Zl3AgJtO2YvF8efsSSTEvV9WRSoHfDTaQHz2JKWHSgCYnjOzcEwA0t9sGDGk0KEHvMEFTAHDG19jlzImxWN+TD+iI+6Jjr2EgPMyxWHDav3g5Q2E3L7Q1srvS+jeDtiPhBCq4nhXOVHGe3phQki7DK4+DCGOx66T+VVKhzt9940=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723759617;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=94enMT6IgcWD7o283z6nZs0lSa0qSTbUCX8c6kC/usU=;
	b=Y1r+nkAspCqpCauTibfiggIsPRprkHw1iMrMXq1hgPR8fzb/DREMRgFn6ETgYPt+
	VdBYjmsRxgPYDuZ0Vj4939Vxb6KSonS1x4x8TykymsvNz4XoWkejEWOOcazLX8nofjv
	B8yooojmr/mpWoZmL9mWBhKDpRF2PyXikyZJ98MVy0x1RND5N9RElzDXcZMxu5FfvEt
	YZj+isbC6/Pr7OjrV7xl4duRGqipMrJ6fntS49R7RQyG+qQ2GMo9aa8ndWOdP9/7dmP
	cRSBq48F+Va+CWcwohtRVuiblNvLL/N3QnTO4UNASUx5IGwUvfgcAbsoRUE4LK5B2py
	BVgVMMXOZA==
Received: by mx.zohomail.com with SMTPS id 1723759615292107.85678322031367;
	Thu, 15 Aug 2024 15:06:55 -0700 (PDT)
Message-ID: <ed2519db-b3f8-4ab8-9c89-720633100490@machnikowski.net>
Date: Fri, 16 Aug 2024 00:06:51 +0200
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
 <1ed179d2-cedc-40d3-95ea-70c80ef25d91@machnikowski.net>
 <21ce3aec-7fd0-4901-bdb0-d782637510d1@lunn.ch>
 <e148e28d-e0d2-4465-962d-7b09a7477910@machnikowski.net>
 <Zr5uV8uLYRQo5qfX@hoboy.vegasvil.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <Zr5uV8uLYRQo5qfX@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 15/08/2024 23:08, Richard Cochran wrote:
> On Thu, Aug 15, 2024 at 05:00:24PM +0200, Maciek Machnikowski wrote:
> 
>> Think about a Time Card
>> (https://opencomputeproject.github.io/Time-Appliance-Project/docs/time-card/introduction).
> 
> No, I won't think about that!
> 
> You need to present the technical details in the form of patches.
> 
> Hand-wavey hints don't cut it.
> 
> Thanks,
> Richard

This implementation addresses 3 use cases:

1. Autonomous devices that synchronize themselves to some external
sources (GNSS, NTP, dedicated time sync networks) and have the ability
to return the estimated error from the HW or FW loop to users

2. Multi function devices that may have a single isolated function
synchronizing the device clock (by means of PTP, or PPS or any other)
and letting other functions access the uncertainty information

3. Create a common interface to read the uncertainty from a device
(currently you can use PMC for PTP, but there is no way of receiving
that information from ts2phc)

#1 and #2 requires an interface to the driver to retrieve the error from
a device
#2 requires an interface to adjust the esterror and push it to the device
#3 can be terminated locally in the ptp class driver using the same
principle as the presented ptp_mock implementation, or something more
sophisticated

Also this is an RFC to help align work on this functionality across
different devices ] and validate if that's the right direction. If it is
- there will be a patch series with real drivers returning uncertainty
information using that interface. If it's not - I'd like to understand
what should I improve in the interface.

HTH
Maciek

