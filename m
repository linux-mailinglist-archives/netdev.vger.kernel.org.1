Return-Path: <netdev+bounces-260704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKkQOPdVnmnyUgQAu9opvQ
	(envelope-from <netdev+bounces-260704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:52:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95690190190
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7B57309797D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688B628FFE7;
	Wed, 25 Feb 2026 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WAIDdKWu"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1114A28A3FA;
	Wed, 25 Feb 2026 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983951; cv=none; b=A9k3VwZPZtnAb0FRhzHJeT03gk9+eVKcTCUU43k+uNBA52+en9bJsPJhTmQ7yR+sZRH3dA9b6XHfwDqfNMyCYg7hIvw8XhQFxZ2tZv3pJFB/7zD9vdwLUxNZUcj3AtT6Ali6wQKiUMFVy/QSgvZJT1VeERelH+pVaOspJvJ4s10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983951; c=relaxed/simple;
	bh=U87I1AJLHguxn79pLOdJU1CrX0Y7Wl2GoTWom5CKtks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPPmhwn0oeurJykMWC2ybItzxceCNIkPex/3bUYe13yLhPwjI0VvgE/dVnZ+eyKL94Sx2+xy1Kvvdqb2iT7/SPWrwTZ1s8l1M7E6IN1OdgBPrTNtIwLmBxUAmHJ30jEHeF9qDfWoAujwT2mCyhHL4KD4yc1VpYulUkhFs1SgFpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WAIDdKWu; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771983946; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UibE2I8JbVmcSHsndJX9DCfJwX/LXdoM0FXt05GZLDs=;
	b=WAIDdKWuldeF6VOT5R0I0iJANHjKRbuWp9B3Cs7F2ZAoAIs8rXoSxWJDrPKLDbWMbjCTaAok9rh22YzeRwwvBBRg9zgJ+OJFgsNx+y8hjmDsuVdk2OCqyXc6N2BLEob/03/C+ev2I+WiEi+sWy3f7zGKskWc/3trHrz7rW3de2s=
Received: from 30.221.130.33(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WzkmwlC_1771983937 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Feb 2026 09:45:45 +0800
Message-ID: <3929f57c-afd2-461f-a840-7bfee6bfb5dd@linux.alibaba.com>
Date: Wed, 25 Feb 2026 09:45:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
To: Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Dust Li <dust.li@linux.alibaba.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David Woodhouse <dwmw2@infradead.org>, virtualization@lists.linux.dev,
 Nick Shi <nick.shi@broadcom.com>, Sven Schnelle <svens@linux.ibm.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-clk@vger.kernel.org,
 Taniya Das <taniya.das@oss.qualcomm.com>
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
 <51e8d8ce-f291-4e31-a938-2c1a0e8684c2@linux.alibaba.com>
 <bb28589e-714b-459d-a609-0153b97ac158@oss.qualcomm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <bb28589e-714b-459d-a609-0153b97ac158@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260704-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,linutronix.de,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guwen@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 95690190190
X-Rspamd-Action: no action



On 2026/2/19 17:29, Imran Shaik wrote:
> 
> Hi Wen,
> 
> Thanks for driving this discussion.
> 
> Is there a patch series posted that reflects the new proposal?
> 
> As Manivannan mentioned, some Qcom MHI devices have similar requirements. Once the reorganized changes are posted, we will also resend our patch series adopting the latest changes.
> 
> Thanks,
> Imran

Hi Imran,

Yes, I will send a patch series reflecting the new proposal in the next couple of days.

Thanks.

