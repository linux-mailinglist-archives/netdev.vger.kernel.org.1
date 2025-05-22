Return-Path: <netdev+bounces-192545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E95AC0528
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61609E1454
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 07:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A87F22156E;
	Thu, 22 May 2025 07:02:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2635893
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897323; cv=none; b=cSICwrBRrBmYO54M7DwrUETCmPAjGFvRR/aHLtfGAvKjB0t3Ca7CtMOoTcGTtWyF7MTYLDb7e8GCTMVASG/TNQ6TwbRIMFdGsqMX3JrkLXuAKn060B3Bv7vIK09dXQ6BKKILyi9TEs6o5Y4T1G3JTa0CnVwLPiFj4LJHAmKWfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897323; c=relaxed/simple;
	bh=ODpziRA27kMEvZ/6+f9NLT1mt4S6kzbLWNHhiItvYWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnQVuvBl+BKXAJ8RYIoCzCkiRLxBQZ8U+f2abLVYVRCOdbFu8UeBGl294LCnUrVntci9rl5SqXz2oEDwMdHNdO7sDGVh5THs70cO5SBjzbv3N8wYpOWjg75ZnX97evYORlzxQeq5uoLZBGlxDk/+y4ABOTDboqbIEBoelGWQXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af503.dynamic.kabel-deutschland.de [95.90.245.3])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B5E3461E64855;
	Thu, 22 May 2025 09:01:35 +0200 (CEST)
Message-ID: <4b67b9cd-47d1-4fbc-8de0-86d364f36dce@molgen.mpg.de>
Date: Thu, 22 May 2025 09:01:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: add E835 device IDs
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Konrad Knitter <konrad.knitter@intel.com>
References: <20250514104632.331559-1-dawid.osuchowski@linux.intel.com>
 <8c8999a7-d586-4bc6-9912-b088d9c3049f@molgen.mpg.de>
 <46e45673-66fa-4942-a733-fdcbc95b5ee1@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <46e45673-66fa-4942-a733-fdcbc95b5ee1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Dawid,


Am 19.05.25 um 13:11 schrieb Dawid Osuchowski:
> On 2025-05-16 10:57 PM, Paul Menzel wrote:
>> Am 14.05.25 um 12:46 schrieb Dawid Osuchowski:
>>> E835 is an enhanced version of the E830.
>>> It continues to use the same set of commands, registers and interfaces
>>> as other devices in the 800 Series.
>>>
>>> Following device IDs are added:
>>> - 0x1248: Intel(R) Ethernet Controller E835-CC for backplane
>>> - 0x1249: Intel(R) Ethernet Controller E835-CC for QSFP
>>> - 0x124A: Intel(R) Ethernet Controller E835-CC for SFP
>>> - 0x1261: Intel(R) Ethernet Controller E835-C for backplane
>>> - 0x1262: Intel(R) Ethernet Controller E835-C for QSFP
>>> - 0x1263: Intel(R) Ethernet Controller E835-C for SFP
>>> - 0x1265: Intel(R) Ethernet Controller E835-L for backplane
>>> - 0x1266: Intel(R) Ethernet Controller E835-L for QSFP
>>> - 0x1267: Intel(R) Ethernet Controller E835-L for SFP
>>
>> Should you resend, it’d be great, if you added the datasheet name, 
>> where these id’s are present.
> 
> Sorry it isn't publicly available yet.

Too bad, but the name of the datasheet would still be useful in the 
commit message, so people could point to it, or, should it ever be made 
public, can find it.


Kind regards,

Paul

