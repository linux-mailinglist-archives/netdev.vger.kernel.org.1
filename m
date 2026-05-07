Return-Path: <netdev+bounces-285164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULXGEAw7/GmUMwAAu9opvQ
	(envelope-from <netdev+bounces-285164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:11:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D770B4E3E94
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49DD7300335E
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 07:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D62E346AFB;
	Thu,  7 May 2026 07:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfcsB7eC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQeAJ/aY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ADC2D9ED1
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778137863; cv=none; b=GeReOcIK+EhEyTlpERhBTfQWYZR5Px3vTsnKSKbgF+EDbf8Qvduc90bBLlx/tfynsFVA0MGd9MmbJ3uFVKA37UXlrfwcCRCeQ7MvxMixd78/ymYUrG7ztbXc+cfC/R0U5G09RnkByLI8l+reji9PuXHY14jFxFCAa8Ok0Y3WWlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778137863; c=relaxed/simple;
	bh=9qOk7HBarAeccmo8yscsdiZkNBa5WRpw2ab9oodYS7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mu8hXjjigXksbbD8F0O1pRYcXpVnmFSBFCTcEZ+a5xKXBbuHSfEzZGYf/q/4So6S3+fVoD/WsohqSOkE19NrhKWvDHxDkspVs2uBd9CfBxjmO6KlNIWUsN0qa1tAX0t4etBxnVt+WsqIfPoBosvOxoBSlNCg4LsGuvohZCjZYak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LfcsB7eC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQeAJ/aY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778137861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=byUQQ+BR5JeFDF1j3dicIBtcOLpqAvEqwVvjGMzrVf0=;
	b=LfcsB7eC8OeBsW5arTM7dR2/bdCBk7xBkArfyLber+wEAmFY6X5TIZOsvgOtMESogUTEGF
	oVkfqnHdfugIu386KniRNAW9lrG3txA6t4w2fRbLr+naeIMWUw5cvpjvrzftlE7dEyTabL
	tWDdW9ZiTMZR/Kqv2pWuFlLjtLGSpmI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-rVTWr1xMPGKvZjgW3tIzxA-1; Thu, 07 May 2026 03:11:00 -0400
X-MC-Unique: rVTWr1xMPGKvZjgW3tIzxA-1
X-Mimecast-MFC-AGG-ID: rVTWr1xMPGKvZjgW3tIzxA_1778137859
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4891f97aef0so2574465e9.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 00:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778137858; x=1778742658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=byUQQ+BR5JeFDF1j3dicIBtcOLpqAvEqwVvjGMzrVf0=;
        b=IQeAJ/aYrdXYSNtRYl/1gSqjoObGqEayQIMtudrMn1Wa2UEDm24YHLN7qlKNLmvGk9
         8L0J6CHBuo2RCH45UBSllxauhXba8UX7H72E9mXcZJtu3no7P9rJiRdHcXTnSCfsS7Nj
         tSq6puCL3Ypx0SJFTPpkUk3fZ1Q9HXM8DIQYLf/8DyKQijiyXxfqFPfkXySw40ITphR2
         uXf1hmi2od4Fy0fU8W8BdB8dnHRfT79oJvaeHzf9w35cSYy/ppwxzO+4eTB83Ig2Puia
         YgxvWYwlzm83FRKswBty2frh844+X2jUxRf9FxUvTMTFQBkDqUrIYBOUpYX8o/+a+0xJ
         Lqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778137858; x=1778742658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byUQQ+BR5JeFDF1j3dicIBtcOLpqAvEqwVvjGMzrVf0=;
        b=Ii5n71jqoUv0RIGZ56DTlptdFp/8dgTxboK5pquivnjw7Z2jhMq7w+1JeyplJyawzG
         Jpu6MMGHuoL2/bzekSD7h90cZVTGxW7AMbP2BiLNAJsDvVaUjgNzpOpLqR1c18JXuE3L
         Lef1f2jcPu8lsHpDHScfPqewI2ujebcLIj57p6zhwdX+H7yr8KxMy+UOhs7LhwcjOqR1
         9Pkw91i9Hcc6Cz1Z6/VR/RT4TYdrvFOMe27CbnCLumBKfUEn6DOph5pkJDinLGftdgJE
         vrAOZYgFicptPIppseRX4XfXIhPpWEarpw4/ECabTZ+5yZGJp/zE2yWAdAIc6LDpRnEf
         0Trg==
X-Forwarded-Encrypted: i=1; AFNElJ/gTjKYfNMGhQ3gFquIcNysKUuiG2CMICgZrzZ4ae+XzCaezny43/vtorwkw7qqyNb/yy502Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz52wYUNVldrrnZz52IT4pbn0Pm/e9/kuz+uWAIjumIgTVicy/j
	QJdBDwTifUf7iA7wgQ5TlAcpyLufbbS1Hu+Wrzyzn0WDByypvBYof8KMvsmQBKiKDaLOTthQGpV
	3+hLBzOBRpKGK/SQav4Q7sRXIttNH58kt2ucEvwfxNM7/vblkgIxOtmWfevTDfR/gxA==
X-Gm-Gg: AeBDieuuexl83eIQpcqhs//eWKLYEI1gELIl2+XMtI8rK1MVjAylkiTP6VkM/91QeKa
	oTZCtea1P4e4SltKU2ar0ZGq/L5OGU11hlVa9WizKSlF59nqc0sd6BLbkjpYtLv5n6Yq4s9e2oW
	A+r4sIxm+04cZZw4ZLpWpcn7YDRosvOzdQWIv7a7Xe2dvvtXgCPv4TITh0iOsSiF1nAYIHv6d7e
	gdr5SDKCPm8MBu4z0WEJJkzuvpqop5go+zBxRROEa+baxmvOQWhJvdSXCPNkhg+wF+Wh4Ri9Rlz
	KdqUqVtyecnlpLM48m3IUtgFLCQ/ksiSUvXrQ4yRgfJFi2a3z1IKnyPMLvY15cc/9KyAWSjI4EX
	S1nIePp1hZmS3jAmUMioir1yffIbrRcLImtaImL6Z7b3fmqpMb6Zd+8NSrI+R1CCm7w==
X-Received: by 2002:a05:600c:3f0b:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48e51f37fb8mr130030745e9.20.1778137858588;
        Thu, 07 May 2026 00:10:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0b:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48e51f37fb8mr130030035e9.20.1778137858130;
        Thu, 07 May 2026 00:10:58 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538aaa0fsm126515705e9.7.2026.05.07.00.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 00:10:57 -0700 (PDT)
Message-ID: <a17bcc0e-3a18-40d6-9054-8632c365f4bb@redhat.com>
Date: Thu, 7 May 2026 09:10:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 01/12] net: shaper: drop redundant xa_lock()
 bracketing
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260506000628.1501691-1-kuba@kernel.org>
 <20260506000628.1501691-2-kuba@kernel.org>
 <ae14591f-f93e-4947-b3d4-af4c441d8229@redhat.com>
 <20260506153348.1c278f4f@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260506153348.1c278f4f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D770B4E3E94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285164-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 12:33 AM, Jakub Kicinski wrote:
> On Wed, 6 May 2026 17:30:32 +0200 Paolo Abeni wrote:
>> On 5/6/26 2:06 AM, Jakub Kicinski wrote:
>>> The shaper insertion code is written in a way that suggests that
>>> perhaps it was expecting readers to be fenced off by xa_lock.  
>>
>> FTR, the code was shaped (pun intended :) that way to avoid acquiring
>> multiple times the xa_lock when not needed. Sort of evil early optimization.
> 
> Ah, that makes more sense, I guess. Do you prefer me to drop this patch?
> The XA lock is guaranteed not to be contended since we're under the
> netdev mutex..

Sorry, I should have been more clear: I'm fine with the patch, just
giving more context, as far as I remembered it.

/P


