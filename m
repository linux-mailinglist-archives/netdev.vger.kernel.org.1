Return-Path: <netdev+bounces-189931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA293AB489F
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 03:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FC58674EC
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 00:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF9C145B27;
	Tue, 13 May 2025 00:59:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378405695;
	Tue, 13 May 2025 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747097996; cv=none; b=OkXXgo6mV+vWpKUVsZJX9vuJb1R7ByLaLsiJM9B4s3v3PG/Q2+drXtUYJHNmLk+TDBMYOH29dWUzHGqKiW1BLm0+Xpx7W/A4ZYV6r4Xp2kXopEAXNUPI4HWCp7QkBhABxWx8sO/Rjm1ke2XaZ8LlAUtV9xNKlgctRZ7d4aTZz74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747097996; c=relaxed/simple;
	bh=QijcsHL4yO/98JvNzuDTU3gbuRArHYMYfje6GRx7III=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulTUljT+96nnugNl1Dwf+k2XV2JokQ1R5aZnbxMuc0zfkaku6s2myEMNwjJusdLBAE6kHm/jdFYbRYIa6qh/oDJ+3a8FIN+qZM8uSFbAHABdy6zdvKk4b+ALqVXJceFqyh/sTvxX6KdqpaHFdwYCOLsVkdxYQA++o75nZoaaE8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=[192.168.1.225])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1uEdzj-0007Pf-BI; Tue, 13 May 2025 00:59:43 +0000
Message-ID: <98876971-e4e0-44f1-8faf-f791bd7a4e4e@trager.us>
Date: Mon, 12 May 2025 17:59:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/5] eth: fbnic: Accept minimum anti-rollback
 version from firmware
To: Jacob Keller <jacob.e.keller@intel.com>,
 Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski <kuba@kernel.org>,
 kernel-team@meta.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Mohsin Bashir <mohsin.bashr@gmail.com>,
 Sanman Pradhan <sanman.p211993@gmail.com>, Su Hui <suhui@nfschina.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250510002851.3247880-1-lee@trager.us>
 <20250510002851.3247880-3-lee@trager.us>
 <a406ecb3-a94d-47a7-bff8-becc6302a775@intel.com>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <a406ecb3-a94d-47a7-bff8-becc6302a775@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/25 11:47 AM, Jacob Keller wrote:

>
> On 5/9/2025 5:21 PM, Lee Trager wrote:
>> fbnic supports applying firmware which may not be rolled back. This is
>> implemented in firmware however it is useful for the driver to know the
>> minimum supported firmware version. This will enable the driver validate
>> new firmware before it is sent to the NIC. If it is too old the driver can
>> provide a clear message that the version is too old.
>>
> This reminds me of the original efforts i had with minimum firmware
> versions for the ice E810 hardware.
>
> I guess for fbnic, you entirely handle this within firmware so there's
> no reason to provide an interface to control this, and you have a lot
> more control over verifying that the anti-rollback behavior is correct.
>
> The definition for the minimum version is baked into the firmware image?
> So once a version with this anti-rollback is applied it then prevents
> you from rolling back to lower version, and can do a verification to
> enforce this. Unlike the similar "opt-in" behavior in ice which requires
> a user to first apply a firmware and then set the parameter, opening up
> a bunch of attestation issues due to not being a single atomic operation.

Correct this is handled entirely in firmware. We use the normal firmware 
update process when incrementing anti-rollback. During the updating 
process firmware first validates that the new version number is >= to 
the anti rollback version set in the SOTP. If not the update is 
rejected. The drivers role is purely informational, it checks anti roll 
back and provides devlink with a human readable error when necessary.

When incrementing anti rollback the NIC first boots the new firmware. 
Once it has validated it can boot the new firmware it increments the 
anti roll back version in the SOTP automatically. This makes anti roll 
back automatic and provides a way for us to abort the process if needed.


