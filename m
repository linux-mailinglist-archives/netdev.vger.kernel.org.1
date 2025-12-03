Return-Path: <netdev+bounces-243389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6B1C9EB4E
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 11:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C6D14E06FA
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 10:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724CF2E8E09;
	Wed,  3 Dec 2025 10:31:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AE42DE713;
	Wed,  3 Dec 2025 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764757873; cv=none; b=EF3ZFVgp5iu9abjCIpA9SXlO765sB/J0EtheoymxKx9veqMV4C+ov2xiN0aGYXhYxuaXiizXufPh+pIc1Sxz18ALUTBnEVbSvDaE5yviZx/4M/Lc5j0qBrEFIrBRv8K1iZobHGYjmxzQCj2mMBiL5R7fGHWkISFhhHiKAYbtQWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764757873; c=relaxed/simple;
	bh=adiUeHbx7VhdWlQ0C0Jch11UxeOeUglougUJe9snoKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuW+FeF81jcmF/WwqTb2QE1PTyJqftyms/XUq6fPZZv6TRkxs1azxjPz170orLYPYYv0guMtkRUF0pCwYGdvBbYV+ptelyCh8DMo5aBlrmt9L9MzLL+eWfTlq2k9lRK4iKmxXui6Wb4jWH0NOs4PF8kLARWy4xSqvM1T1B00GUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CA5F339;
	Wed,  3 Dec 2025 02:31:04 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 817E73F73B;
	Wed,  3 Dec 2025 02:31:10 -0800 (PST)
Date: Wed, 3 Dec 2025 10:31:07 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Sudeep Holla <sudeep.holla@arm.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
Message-ID: <20251203-romantic-tricky-llama-76c4cb@sudeepholla>
References: <20250926153311.2202648-1-sudeep.holla@arm.com>
 <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>
 <CABb+yY2Uap0ePDmsy7x14mBJO9BnTcCKZ7EXFPdwigt5SO1LwQ@mail.gmail.com>
 <0f48a2b3-50c4-4f67-a8f6-853ad545bb00@amperemail.onmicrosoft.com>
 <CABb+yY1w-e3+s6WT2b7Ro9x9mUbtMajQOL0-Q+EHvAYAttmyaA@mail.gmail.com>
 <3c3d61f2-a754-4a44-a04d-54167b313aec@amperemail.onmicrosoft.com>
 <CABb+yY2-CQj=S6FYaOq=78EuQCnpKFUqFSJV+NHdLBjS-txnAw@mail.gmail.com>
 <ebf95db6-432e-4912-958b-d90f92c635f5@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebf95db6-432e-4912-958b-d90f92c635f5@amperemail.onmicrosoft.com>

On Tue, Dec 02, 2025 at 02:19:41PM -0500, Adam Young wrote:
> Can we get this and the corresponding follow on changes by Sudeep merged?
> 

You have responded on a old thread which might cause confusion.
For your reference, the right thread is [1] and I just pinged Jassi
asking the same few days back. Thanks for following it up.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com/

