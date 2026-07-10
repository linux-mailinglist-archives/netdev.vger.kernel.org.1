Return-Path: <netdev+bounces-306661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5uwVKLdFUWqgBgMAu9opvQ
	(envelope-from <netdev+bounces-306661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:19:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0548573DA8D
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:19:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=e8qdxb7d;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306661-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306661-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C76063034306
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344DA38331E;
	Fri, 10 Jul 2026 19:18:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5967133121F
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:18:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711113; cv=none; b=FjJN87PyEhsI5mfxKp7wsy98f9PLFwiWrqBOl4CRoeE4E0TdiLbj/mj879PAIdTMnHW9RxpWR5uWZPNk/+LIknZvpei2epvIRLoSmMWjq8J5h6qsCqkhIwkzHJbwfQsAFHLykrPn77zXAfw7vEVEu2xZWPtdWGCCAKfsTjH0lCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711113; c=relaxed/simple;
	bh=Pkzq93VysouvMV4sOok85BWiz22/o2bRhcPNPa9P+iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfeJWldmv45ZQrySFKUsg/d8S6JRCmZC2hw+YkUc5/JERbYzxmTnftecq5OympRGDsxgERG2ZL2q0jHc6dCji/IMx6+DSvrfyeSUQC+3O0R2mLWFJacfOvQtouavhG9/BNihnZm+Ufg9GbIvzd1oihtRGtSbJEbdXkAQcd50ywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e8qdxb7d; arc=none smtp.client-ip=209.85.160.228
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-51c21495722so6241391cf.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 12:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711110; x=1784315910;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ivQlEJtZ0zxa8yf3dIj+FATasL8wavCjCs0e2VSoqvc=;
        b=i7c/8Y3CGZ7haWzfIb4xBmxk5QT6X+thfprCnJAMfvbOLF8bYaoWnHSors0gRPR5eF
         uYct/L81CF2sAlRWhvd5vCStKAtdk3RjS+wUZQpfrzGmJuNx5TEfjwlkb0ohLTRQCeKn
         jqmmWuAgglmmW2U0ae2YGCa68cCq4TZP8JtKPZ673l0q18TCJRu0KMn6Sinv+6kHzp51
         35CoAr1gqY3y6xFXJ5qbTqoPSFeXI3OTL7Oj9xNIDeJ8NcljjV1YrKa5ceTA7Mn7NzXC
         xMP08AOMDR0uVnshPw1v8hPS0BFdTmXFt5/49HfT6YWup7zebjLWtBLgzylYO+NSIZd6
         m3vw==
X-Forwarded-Encrypted: i=1; AHgh+RoZ/pDlJEsmeYLD+bi2IXMWKFiyXZ9HZiJoJ35oZYSHhjk2IyGCoVe3B4pWbk8kQxXuSqoHqrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyfTu7G50fyjAV95+AgrUdlkgD/efOrROsGG5AmNxiRp8ajuos
	Fy0lv/sg7UyK8XPl6uZO1pMs+eWCRu8K+5pvLwRHJuOhpdDG4WVPDcT+Nvns4Pk7tD+KyY3KVhB
	qEFsdXxfzqxiKMtzPG44JSpcna/cnZsQqGOW2ObU0ogRxHwZhoDkiQZ8p6z34NUXWlZt4rNkvb5
	NXNGAv7b7VshYKAZdI0LkbFJDiHnd4bUPpRnlfhZRlwOyW5ui8QnljgcKTu/QT1SP1yBSgdKOrE
	LP1dqKi3CmCVx4OdQ==
X-Gm-Gg: AfdE7cnGcKIyfFhDtkO8UZb2o4O+/3XNc+aB/C8NimR3zx08KGaHRsOGwuHyOH5lnqe
	sDif384b3BOV86DRqzU9qqT/PK9j9/5iJqZhegFY8VwzCsP1F+CrzmZ+dMWjY9vSRrXN38U0XMm
	61pLF9TNKwlHzHjXLPFbPmHQ+JbJ6/MhsijpiENuTaP7nuNTt/NDjn5H6ttRImIE+Wknv51h6V4
	GzQNdBj+ODpy7SoPwTIRSGzOwj19is6vlMnzIrsH5cL/JHM5RAttaqS++uRod1cbU/RDsR1p9Nb
	gwOu3oFio8Y8wWjoXrOElbxKgDBK2dZRUXGd761nRJ8wX4WdfVouzoALVrPnAtG45k13q+GTAob
	U0ZDnRZ8C/I9uk1zCYUyQ2euAoFPMu9QpwefY+vxo1ejnSk+nXlrMGexNC55//WLigbGnwntnbE
	+7bgt8k0nKua+1xAJoQ8P9ias4Tos0NKcR20JRQZr3S3jPiblhpA==
X-Received: by 2002:a05:622a:1911:b0:51c:504:2ef7 with SMTP id d75a77b69052e-51cbf305510mr2328681cf.67.1783711110055;
        Fri, 10 Jul 2026 12:18:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ffd8ab0958sm3456506d6.17.2026.07.10.12.18.29
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2026 12:18:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-384048e7e14so1631783a91.1
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783711109; x=1784315909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ivQlEJtZ0zxa8yf3dIj+FATasL8wavCjCs0e2VSoqvc=;
        b=e8qdxb7dumpMHLgGKMHeJYR5u6Ap4uMlT9MNmButbEK7YUz+ompB2Y6ZW43NcqZFdi
         WIbhKhAO+rjkJk5rrL8OaTqRW0YxOYRTbAPfCKbdWyc2vg1HXX4d9BPUUAGrJmz9uZCK
         TrIR+xMEInce6m4NkWY/V/43rWnAaabg83Cl4=
X-Forwarded-Encrypted: i=1; AHgh+RqRchamrdymRpsCstOrff/qTmVwyqtcx1FfHL0qkSKhDp8Z4JMBBukdOTiZ2H85/P/AlQZX9oM=@vger.kernel.org
X-Received: by 2002:a17:90b:3805:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-38dc77ee67cmr215924a91.21.1783711108645;
        Fri, 10 Jul 2026 12:18:28 -0700 (PDT)
X-Received: by 2002:a17:90b:3805:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-38dc77ee67cmr215891a91.21.1783711108045;
        Fri, 10 Jul 2026 12:18:28 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311838c9235sm39074609eec.21.2026.07.10.12.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 12:18:27 -0700 (PDT)
Message-ID: <caae46b1-50c6-495d-94fe-c95229d489ce@broadcom.com>
Date: Fri, 10 Jul 2026 21:18:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: drain bus_reset work on device removal
To: Eddie Phillips <eddiephillips@google.com>, Fan Wu <fanwu01@zju.edu.cn>
Cc: Arend van Spriel <aspriel@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
 Wright Feng <wright.feng@infineon.com>,
 Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260709101635.103005-1-fanwu01@zju.edu.cn>
 <20260710002451.500112-1-eddiephillips@google.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260710002451.500112-1-eddiephillips@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306661-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,broadcom.com,infineon.com,davemloft.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:eddiephillips@google.com,m:fanwu01@zju.edu.cn,m:aspriel@gmail.com,m:kvalo@kernel.org,m:franky.lin@broadcom.com,m:hante.meuleman@broadcom.com,m:chi-hsien.lin@infineon.com,m:wright.feng@infineon.com,m:chung-hsien.hsu@infineon.com,m:davem@davemloft.net,m:kuba@kernel.org,m:linux-wireless@vger.kernel.org,m:brcm80211-dev-list.pdl@broadcom.com,m:SHA-cyfmac-dev-list@infineon.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0548573DA8D

On 10/07/2026 02:23, Eddie Phillips wrote:
> On Thu,  9 Jul 2026 10:16:35 +0000 Fan Wu <fanwu01@zju.edu.cn> wrote:
> 
>> brcmf_fw_crashed() and the debugfs "reset" entry both schedule
>> drvr->bus_reset, whose callback recovers drvr through container_of()
>> and dereferences it.  The teardown paths free drvr (brcmf_free ->
>> wiphy_free) without draining the work, so a bus_reset callback pending
>> or running during removal can outlive drvr.
>>

[...]

>>
>> This issue was found by an in-house static analysis tool.
>>
>> Fixes: 4684997d9eea ("brcmfmac: reset PCIe bus on a firmware crash")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
>> Assisted-by: Codex:gpt-5.5
>> ---
>>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 13 ++++++++
>>   .../broadcom/brcm80211/brcmfmac/bus.h         |  6 ++++
>>   .../broadcom/brcm80211/brcmfmac/core.c        | 33 +++++++++++++++++--
>>   .../broadcom/brcm80211/brcmfmac/pcie.c        |  6 ++++
>>   .../broadcom/brcm80211/brcmfmac/sdio.c        |  6 ++++
>>   .../broadcom/brcm80211/brcmfmac/sdio.h        |  1 +
>>   .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
>>   7 files changed, 66 insertions(+), 2 deletions(-)

[...]

>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
>> index fed9cd5f2..b934feb9b 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
>> @@ -1164,6 +1164,35 @@ static int brcmf_revinfo_read(struct seq_file *s, void *data)
>>   	return 0;
>>   }
>>   
>> +/* Serialize bus_reset arming (debugfs reset write, brcmf_fw_crashed) against the
>> + * teardown drain: the remove path takes bus_reset_lock, sets ->removing and cancels
>> + * the work under it, so a racing armer either schedules before the cancel (and is
>> + * drained) or observes ->removing and desists.
>> + */
>> +static void brcmf_bus_schedule_reset(struct brcmf_bus *bus_if)
>> +{
>> +	mutex_lock(&bus_if->bus_reset_lock);
>> +	if (bus_if->drvr && bus_if->drvr->bus_reset.func && !bus_if->removing)
>> +		schedule_work(&bus_if->drvr->bus_reset);
>> +	mutex_unlock(&bus_if->bus_reset_lock);
>> +}
> 
> Is this safe in a softIRQ context?
> mutex_lock() sleeps until it can get the lock.

What softIRQ context? brcmf_fw_crashed() is called by PCIe (thread) and 
SDIO (worker).
>> +
>> +void brcmf_bus_cancel_reset_work(struct brcmf_bus *bus_if)
>> +{
>> +	mutex_lock(&bus_if->bus_reset_lock);
>> +	bus_if->removing = true;
>> +	if (bus_if->drvr)
>> +		cancel_work_sync(&bus_if->drvr->bus_reset);
>> +	mutex_unlock(&bus_if->bus_reset_lock);
>> +}
> 
> How about if brcmf_pcie_remove() calls brcmf_bus_cancel_reset_work(),
> takes the lock and calls cancel_work_sync(), sleeps. If debugfs
> path is already running, it can invoke the worker thread. Is there
> potential that both try to reset?

What is "both" here?
Regards,
Arend

