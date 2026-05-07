Return-Path: <netdev+bounces-285165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKC8E2A9/GnfNQAAu9opvQ
	(envelope-from <netdev+bounces-285165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:21:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A904A4E3FB4
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E585300C928
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 07:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C770533ADAD;
	Thu,  7 May 2026 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJLniGyH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTzZ60z1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1B52C0261
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778138461; cv=none; b=UoKwvpFlfZ4dTJARX7M83zUizOkqdCRyxLXNPQUUGRZ7Rb/tKAO4919G8chEcYqivDssWntNYTjVcSVb+LHVjP8VG6wQyNf+FXnzsvHkDoSWyI92TP6+cuiByRXm8LOZkKZGGEz8pS36bUiEJ+fLtmpLd8VdQ7W9MVdJ3CuyRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778138461; c=relaxed/simple;
	bh=rUQoQZDzHnFIn5GHfRInxQalRbst+XXfqMKwdXuq1ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8sP41fDgV+80Qewu/FBbxMoGp4JDobf3iyIjg2HEgAi/UAMRza4+NZApKQhhxpWoOWNRYMC4MSfUkmy7Nm6D4qPbSforqG9jSiCik5XGG0TBNfgzi/1m6FiyuV029NvJLHL0ZKzXVJ0o7faoWqse3CFa+5ZnpzqbnPikcL0VOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJLniGyH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTzZ60z1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778138458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJCtbpDZBR/57aHfFYrXL9twLmQ3xZkrJJexPdNGgdM=;
	b=bJLniGyHmngrrBsHtDZr6sLHyMh7x3PXKpco1Ex9jUVzQuFwxquwCNcEPtMA9igDxocsKj
	pJx20DbD50sZZPunzIdGT+BJ9wFrjAEpYVXbjge13EOWXQjPjDvT1K2nN72Qp6jbDrPuIo
	F8nsORl4SPFBGTw2jJk9xusxq+gS7i4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-vXSCmOgXMpWu7FsU6QRyMg-1; Thu, 07 May 2026 03:20:57 -0400
X-MC-Unique: vXSCmOgXMpWu7FsU6QRyMg-1
X-Mimecast-MFC-AGG-ID: vXSCmOgXMpWu7FsU6QRyMg_1778138456
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48e5df7e6ecso2724985e9.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 00:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778138456; x=1778743256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJCtbpDZBR/57aHfFYrXL9twLmQ3xZkrJJexPdNGgdM=;
        b=UTzZ60z1sqYXa1/kaCd6LwlT7aNASqN7cEXAA0Ii1lcYv6twPgGojb+Fq/Xl565LDJ
         E3q8UoVBbehqL30v6ogJOmunVe4jIa6XtJcGq2ZryJaU+sx64evn3PbA6zu+BjnEndax
         My4vxEQqemzc1kiPBaW62QsrX8i59q14Twr0b++SKeSz7eUXpyiPuvD1Rvqhjm2OQ21m
         bD3RJ6Uq+OeJfxji2S7h8C5DGNPAWYFHVmOzmFBY2Ay2syaCc8mIirzZqxeyi03kiYTs
         vIfjA+05XkVHrQb9wJM8qn4oL6nzdVf6IIRxR7kreo4PI8LgEDiAGuxh3ipXlQFZHLgT
         Xbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778138456; x=1778743256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJCtbpDZBR/57aHfFYrXL9twLmQ3xZkrJJexPdNGgdM=;
        b=hAr0EZzZlGVE/xUtiZqFRNiu5m6ubJRbF1w/0c2L8aZN3A6ocUS7GqgitXtb07Z68T
         ok1RJIW2a+PGCB1qJ+z34eCe4BPHBQTSiDODjjViZjMi3htHpGUgQngoO0X1BWFaXlyX
         SsXNW0NSkqAmd+b0J4CyQUlGSZvgAfWM5mEO4Xzhj+8npvqpKatgIuI5Gl+4lwvyPcxE
         7aty4IH8Zz4tUDtvobmzsxnNOLOJHytZvxokTbvbvPxsJyyWDNqQ/WOdJQztjzsuv1IM
         dhgyu/hIZhZP1Ofj1PINYkMjPaV6cIj2EWOP4aJkRxtyMmGw4vkaHUwjkXdr9ZETdCgd
         NYJg==
X-Forwarded-Encrypted: i=1; AFNElJ9jsglD03mgLrzNaCF/+KbXyyUHyweHXR5LVI0fSnANmDTKru6OUF6r5Bu2moRx5Io2GtfEnFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJzqVsgJrFVb69QHxPbFM/0tb4+H0BPvMtfnWQh5orgdkedFUZ
	w6QQfzJsK2bIOtEccFqJpYS3+KFwxqjDr9rEgA+qTA7tKX7ipxHUayOuDIBm1bF8l6RA6+LTmGk
	ctBaxqMt8C9H8WEXLA2HjcBKaowEcHad9KgKeoiWdUOrMpfitzJO0vNd7RQ==
X-Gm-Gg: AeBDieuTADv1mRBlT48owVGtPtyAVt1+u/aQJSMv9ZnBPj8lA6qi41Y+vofd54bkGTs
	xMkvDtnmNX1N8dCt1SjSpfgEsMKfnxP5jAhFj0avQnZLNvNSkaQJ+ZnO7aZfFEKTmKDBy5O6Cn3
	hH5hzm5+tCVbjpQURmm8UNeBTG7/gsuqQVbsP4HmhEmCKm8/7k9fpWpQCvwe3EfkKuOsJVwH8+w
	RrRqrAmlW0ayEq36YjrDmyAHgON5dYcR1FwcNnMH0gJYFXtY2l9jmn2E/XR+oOCP66se83U7kPt
	ergr+bOs3s11UEYRKuRvUtSYZ6YayyYH8PQslLEWajhJo9GLk2d1jVA9As8J84CSlEhIG1ylWIV
	Y/uF5eDa9mY/o56GaNdU63a+hxyUGjQVDhfehtsRyTq3uThDM1vsJgpBIRyFjhM/bTg==
X-Received: by 2002:a05:600c:a305:b0:48d:361:4df6 with SMTP id 5b1f17b1804b1-48e51e19680mr76570835e9.9.1778138456118;
        Thu, 07 May 2026 00:20:56 -0700 (PDT)
X-Received: by 2002:a05:600c:a305:b0:48d:361:4df6 with SMTP id 5b1f17b1804b1-48e51e19680mr76570405e9.9.1778138455654;
        Thu, 07 May 2026 00:20:55 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538bc9bdsm123490205e9.11.2026.05.07.00.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 00:20:55 -0700 (PDT)
Message-ID: <1cd8256c-286a-4a73-b0a0-89233cb3c2d0@redhat.com>
Date: Thu, 7 May 2026 09:20:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/4] net: eth: fbnic: Fix addr validation in
 pcs write
To: Jakub Kicinski <kuba@kernel.org>, mike.marciniszyn@gmail.com
Cc: Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Jacob Keller <jacob.e.keller@intel.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Simon Horman <horms@kernel.org>,
 Lee Trager <lee@trager.us>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260504135815.44226-1-mike.marciniszyn@gmail.com>
 <20260504135815.44226-2-mike.marciniszyn@gmail.com>
 <20260506185819.1c68a71b@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260506185819.1c68a71b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A904A4E3FB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285165-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,meta.com,lunn.ch,davemloft.net,google.com,gmail.com,armlinux.org.uk,intel.com,kernel.org,trager.us,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 3:58 AM, Jakub Kicinski wrote:
> On Mon,  4 May 2026 09:58:12 -0400 mike.marciniszyn@gmail.com wrote:
>> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
>>
>> The DW IP has two distinct PCS address ranges cooresponding
>> to the C45 PCS registers.
>>
>> The shim translates the PCS addr/regno into specific CSR writes
>> into one of those two zero-relative.
>>
>> This patch fixes a one off in the test that could allow an invalid
>> CSR write if an addr == 2 was called.
>>
>> This patch contains a fix for addr validation in fbnic_mdio_write_pcs()
>> to only return actual CSR reads for addr 0 and 1.
>>
>> There are as of yet, no real impact for the bug as no PCS writes are
>> not yet present.
> 
> Hi Paolo! Was there a reason / do you recall why this was not applied?
> (I dropped it from patchwork now. If the omission was accidental it has
> to be reposted)

Darn, limited capacity here plus re-submission glitch: v3 had a slightly
different cover title (due to typo) WRT v2 so PW did not mark v2 as
superseded. I process patches via PW in sequence, when I reached v2 I
considered the sashiko comment not blocking and I apply it. I was unable
to reach v3 until now.

TL;DR: @Mike: please re-submit 1/4 and double check there are not other
differences between v2 and v3 - otherwise more patches needed. Also
please ensure you keep the series title consistent among revision, or at
least manually remove old revisions from PW upon resubmission.

Thanks,

Paolo


