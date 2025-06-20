Return-Path: <netdev+bounces-199831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A8BAE1FDF
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 18:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D1E1C20E9C
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880432E8E07;
	Fri, 20 Jun 2025 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BvVaoDdE"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431402E8DF7
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435779; cv=none; b=bhSM+Jwpb49jnR9TBwE+MHRc5pvPRGsQutJV8wnUsC+w1+SlFaTMNLUbZ9BIeGFSsUX4lJdeAFsYR6naEZSZrXALbTmSylRooZDSpudby6ACy8DQ19nfg2+tmmbv4KhLkV+PClvRFS78KYATCxTuTKZ/r4vH/wfj89lanXyZCCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435779; c=relaxed/simple;
	bh=Dm7oxg4J2fPGtqOVFc7aMZBu0v7rYqXCaHfgUZqu64A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukxYw3au8SufQOPA8qZAE7N8rW1c1T987KxfK9MV4BznbE/GfMD5/jYvT9xOFrXhYejFvNmn8zjftNaEOHgOgYFkV4KGGqzXUQQCZY5MqM0haVt/oskJipk4xYZOLvKkoqDaipic9WKZJSQEmUL5DqEwZD411gPUCha41JkP43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BvVaoDdE; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <91a9e80a-1a45-470b-90cf-12faae67debd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750435775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJDQ5jsltpJAHqGixOU5/Ni4jPTDl32ucuObQ0mSDyM=;
	b=BvVaoDdE4HfZlrhFrGHfLidXQq982iceIFHYawUFS82oIZutrM74DFbTSJO1YVWfqduR9M
	mUeggRzAA2wPS595IFKDZm9MSrf6DKadVBei1/GDHu/JsDk0RSNnArFH1dYIURgjvzYjT2
	BdUHQuD6f3YB0eV9pTofQbziWxGdBDM=
Date: Fri, 20 Jun 2025 12:09:29 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 1/4] auxiliary: Allow empty id
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
 Saravana Kannan <saravanak@google.com>, Leon Romanovsky <leon@kernel.org>,
 Dave Ertman <david.m.ertman@intel.com>, linux-kernel@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>, linux-arm-kernel@lists.infradead.org,
 Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250619200537.260017-1-sean.anderson@linux.dev>
 <20250619200537.260017-2-sean.anderson@linux.dev>
 <2025062004-essay-pecan-d5be@gregkh>
 <8b9662ab-580c-44ea-96ee-b3fe3d4672ff@linux.dev>
 <2025062006-detergent-spruce-5ae2@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <2025062006-detergent-spruce-5ae2@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/20/25 12:02, Greg Kroah-Hartman wrote:
> On Fri, Jun 20, 2025 at 11:37:40AM -0400, Sean Anderson wrote:
>> On 6/20/25 01:13, Greg Kroah-Hartman wrote:
>> > On Thu, Jun 19, 2025 at 04:05:34PM -0400, Sean Anderson wrote:
>> >> Support creating auxiliary devices with the id included as part of the
>> >> name. This allows for non-decimal ids, which may be more appropriate for
>> >> auxiliary devices created as children of memory-mapped devices. For
>> >> example, a name like "xilinx_emac.mac.802c0000" could be achieved by
>> >> setting .name to "mac.802c0000" and .id to AUXILIARY_DEVID_NONE.
>> > 
>> > I don't see the justification for this, sorry.  An id is just an id, it
>> > doesn't matter what is is and nothing should be relying on it to be the
>> > same across reboots or anywhere else.  The only requirement is that it
>> > be unique at this point in time in the system.
>> 
>> It identifies the device in log messages. Without this you have to read
>> sysfs to determine what device is (for example) producing an error.
> 
> That's fine, read sysfs :)

I should not have to read sysfs to decode boot output. If there is an
error during boot I should be able to determine the offending device.
This very important when the boot process fails before init is started,
and very convenient otherwise. 

>> This
>> may be inconvenient to do if the error prevents the system from booting.
>> This series converts a platform device with a legible ID like
>> "802c0000.ethernet" to an auxiliary device, and I believe descriptive
>> device names produce a better developer experience.
> 
> You can still have 802c0000.ethernet be the prefix of the name, that's
> fine.

This is not possible due to how the auxiliary bus works. If device's
name is in the form "foo.id", then the driver must have an
auxiliary_device_id in its id_table with .name = "foo". So the address
*must* come after the last period in the name.

--Sean

>> This is also shorter and simpler than auto-generated IDs.
> 
> Please stick with auto-generated ids, they will work properly here.
> 
> thanks,
> 
> greg k-h

