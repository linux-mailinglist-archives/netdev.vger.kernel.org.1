Return-Path: <netdev+bounces-259412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA1VF3LNlmn4nwIAu9opvQ
	(envelope-from <netdev+bounces-259412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 09:44:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B614E15D188
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 09:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED65C3008C16
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 08:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0B633507D;
	Thu, 19 Feb 2026 08:44:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1851233342E;
	Thu, 19 Feb 2026 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771490670; cv=none; b=h+4aJ9wMrR5hm2xChJ8xdqH3ZgPB+rGhqWC6Mc9NGciQTmVMWT0qUFSWSFRtf2GAbixI3Gx5w108wMSVZBn4/JqbTl4l5aIo6ifYWA5fpB3b8rto88pAZpbm8fSZlx8TTfVPmtqapZJDQ5ZaPWdn4qYwaIwwKhlNu1EW+EToVxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771490670; c=relaxed/simple;
	bh=q86tA4VbUkx+OqyW+v68k1AhOLR3wLhIMOukRa1X0/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNJ7kp7EwCrDrRRSE7G8vUk90azP0Uvp+DLcXTIGVD2oD4H07jx/j0Kxh1PpOjAc8CfLtraFOPM4fV5E7SrVEmjZeJfxB0evmeAaQ8DqHi3Sqq7NerJFI4e8hJKtvtlzZqDhEJbQC4cEs4LfbkwnGohsTsHGU3DpccxlkNXmfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af0dc.dynamic.kabel-deutschland.de [95.90.240.220])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id F1F814C2C37D57;
	Thu, 19 Feb 2026 09:43:50 +0100 (CET)
Message-ID: <6cf745e5-55fb-4163-8c37-8ed1ef477fff@molgen.mpg.de>
Date: Thu, 19 Feb 2026 09:43:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bnxt_en: BCM57414: 0000:c4:00.0 (unnamed net_device)
 (uninitialized): Device requests max timeout of 100 seconds, may trigger hung
 task watchdog
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <ff733f84-9688-48af-bb11-12362d6b9758@molgen.mpg.de>
 <CACKFLin5vLXDBhheP7Tm7br0-Zew1zpdfyZw3Lu1EiHx9Fw8uQ@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CACKFLin5vLXDBhheP7Tm7br0-Zew1zpdfyZw3Lu1EiHx9Fw8uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259412-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.962];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,molgen.mpg.de:mid]
X-Rspamd-Queue-Id: B614E15D188
X-Rspamd-Action: no action

Dear Michael,


Thank you for your reply.

Am 12.02.26 um 20:10 schrieb Michael Chan:
> On Thu, Feb 12, 2026 at 10:30 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> 
>> There seem to be two problems:
>>
>> 1.  It’s logged before the name is known.
> 
> Yes, this information is received from the first FW response when
> probing the device.  So the netdev name is not known yet and the PCI
> device number is used instead.

Hmm, it’s still ugly. ;-) Why not log it later, or don’t use that 
logging macro and use something else, that does not expect the netdev name?

>> 2.  The timeout of 100 s seems higher than the one you expect, which is
>> 60 s [1].
> 
> I believe the latest FW should use 60 seconds, but there are older FW
> in the field that use 100 seconds.

We just bought the Dell server, and the Broadcom BCM57414 has the 
firmware version below:

     $ ethtool -i net02
     […]
     firmware-version: 233.0.195.0/pkg 23.31.18.10
     […]

It’d be great, if you told me the current firmware version from 
Broadcom, so that I can point Dell to it and ask to release an update?

(By the way, why not log this version too, so it shows up in `dmesg`?)

>>       > But 60 seconds is the timeout on most production FW and cannot be
>>       > reduced further.
>>
>> It looks like you addressed some of this in commit 0fcad44a86bd
>> (bnxt_en: Change FW message timeout warning) and commit 8ff617513996
>> (bnxt_en: hide CONFIG_DETECT_HUNG_TASK specific code), merged in Linux
>> v6.16-rc1. Both were not backported to the 6.12 LTS series. Also, it
>> looks like they do not address the first issue.
>>
>> As we do have `CONFIG_DETECT_HUNG_TASK` unset, we would not see the
>> warning with the patches.
>>
>>       $ grep HUNG_TASK /boot/config-6.12.49.mx64.487
>>       # CONFIG_DETECT_HUNG_TASK is not set
>>
>> I’d recommend to have both commits backported. Will you do this, or
>> should I contact the stable folks?
> 
> If AUTOSEL has not selected these patches for stable, I can request to
> have these backported.  I agree that the warning is annoying.  I will
> do it later today.

Thank you for sending in the request. I found it in the archives, and 
it’s queued for 6.12.74 [2].


Kind regards,

Paul


[1]: 
https://lore.kernel.org/all/CACKFLik3qQ46i3_wRpm0OnaNnMcMc-hVNrFt_0U9yzzjNrm4VA@mail.gmail.com/t/#u
[2]: 
https://lore.kernel.org/all/20260217200005.998240758@linuxfoundation.org/

