Return-Path: <netdev+bounces-274459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLXXCwBFzmlQmQYAu9opvQ
	(envelope-from <netdev+bounces-274459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:29:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7100387BCA
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1A073028B28
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 10:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B463AA50D;
	Thu,  2 Apr 2026 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hkrfya3A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7p58Ar1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50FF3921DF
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125754; cv=none; b=Gp6i9m2mNC/+0fvoFeoW74z8dPtYRTFP6ix2kbS+CIc2IUytBXDC6fCqkz5u0rCh56SAEwVKezP3X7lZ/x1XexbF1mgZ8sionjIoKVEy4cRGA8ilsiciz/H64Ss7M2lejYuU/lp+tOtnKULhBECPZ3pzUz6nugRvkC768G0nvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125754; c=relaxed/simple;
	bh=IW1lOPDfzNo6iyC+RTfQZKz7s0OSLg8gYMFYo/QQozk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+g1sttA4Uix7K5pAFjYb/60BifZF4I9+DBP4WM7CzrlaPveTB9EUD+rhjg2IrNTlTGumfpn5bCuY1QxhoyKAmiSCL8lcB1ZhIsuxirtACZqdnUS0shT+MSeCdr3g7UuXg+dzGO8EZ/naaVvjOleKRlW6LfcNP44HyVlPJNBzfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hkrfya3A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7p58Ar1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775125751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1QNFZcjlbQfqCAZ+2Rv3blmsKd4Db0pLwQogOddra4=;
	b=Hkrfya3AsuV4FIAhrIdE1gh/476Ix3GB1xnpLmKXdZgi8A96CJyejyMsXJnSFhGSdhSXeN
	8R2aUs3oYx8IgT8EH3BLjHQ3fVuKVbeC8RCxWPTVNisc15UKfnqErLnMaLqfI4zti+3NQP
	9hMc15tV8IvvKWBdnKt+cni9OnHvthc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-N2NHAFVqN9eeHTJwtey--g-1; Thu, 02 Apr 2026 06:29:10 -0400
X-MC-Unique: N2NHAFVqN9eeHTJwtey--g-1
X-Mimecast-MFC-AGG-ID: N2NHAFVqN9eeHTJwtey--g_1775125749
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d00dd913cso967874f8f.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 03:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775125749; x=1775730549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1QNFZcjlbQfqCAZ+2Rv3blmsKd4Db0pLwQogOddra4=;
        b=A7p58Ar1DL/9I3ktXWNzHczcrXqYTd9XdCFVZlNNYm+xkot//ajZxllbCYpyOGvJy5
         g+aOBRcBa5N+PbUNE+y7GrPkvMmdB5IfFKuCq3T8ZdZbcnuLXsUBIhhEtpCNPPw1CbJX
         Uzx6mavsMi+d+bWH/QfOzHOoaa8sxbcDrGzUCu0vI3A51xhLHdCfz9bYGR881mn6qk7x
         gcLq/OjhWA03FpSrHq+PG5D7fLvjeTkB78V713/2W4QCPeMITT2B8NUWQxuYHK5eCqLp
         05ISewfbCwAablWhFf3xSpzJ6kU6pX4wJP4MvnV/ajiV+TYDUC20BfXGuSkNr/29Ht8j
         HA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775125749; x=1775730549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1QNFZcjlbQfqCAZ+2Rv3blmsKd4Db0pLwQogOddra4=;
        b=oYZxFB0w+9qloxael0/BNJ6r2eCNBWiJgL5IroCRDSwWYLmvV5bWcMs3NsPWIAcUvI
         +NhR5hWqwHfx+Lyph7FdsXJ/IXPjwqyC5403nxcyRUNi3lJ7P6aheajt0skDhmJocamh
         z2p/rPyLwDTxKOtacEzoUKwZImv/rU6dTtZiNptW7TeyqzC3kdNChsQ+qo2KfcqrJ7zJ
         LF0XhIwtnvz/kYgzZKx+VVKa+GSh/H9hDg/Po7InAD16ixD1UZXt7yI8Wj52xPk3gUSI
         oGcf74YplhOq5dpMMMBfIhJbunvc0kTH4qVrnKxtAw8BW1aT7cc7HK934zpeQzLGsdHC
         dxzA==
X-Forwarded-Encrypted: i=1; AJvYcCXl5pXZOvjTp9WW7vZwsshopRLGLjLE7Xr2KTkmi59eMolAuTX6r6fRSmLloR4IA1yOPCvqRj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjKV77D4jik/P+WQuZ1fNHPj3I5cSFH7ql4gnWUGMva5ieSQG
	DG/qhNkYFzRABwiyEULIHQLBY199kLCgJx7XE9V0clPOxt2FMjbNa8+2YXpJw1hXyfhhN0Xf4+t
	ZEIIVpiuAbxTffuQZpc40uU4FExZoab+V8bgEdhp4pGBdeKfrvBeUeZ/yrg==
X-Gm-Gg: AeBDieugAsWGnaxsaRdWvDZZat6z5xibHI9Y4IyEziupnMIyRFOdKqIcKrFlSXqA18V
	lYz3KKwh7Po95aM1GrWZNyOgdFX8esDxNvKWfZ4HHykbJzWjV+LF84JfdK2pMCpsg7gGRSp0VY9
	RnKLAWEGuh/ZJtwjYdGylLgCxRK2uiQOcS0UmENlk8PxCC3LbrVnACIYdvpLUUnQ9Fbnhq9ad5a
	y1WvZYVEqElppGTq9MHajEX3GnlRtkA+QnlvPR4sUdL+xcZm9rCl6CWxSWKc47JpbKabBJW7g0D
	yd5NJj+UEnjWxuB//MifzSt00IaMDcOANcg/DIPOeUW1qScUy0rkFHHlu6uoi3AN61koOKcxJng
	u4dgVQ9ll+8roossF6Q1a2dObsiYzL1dt3lxKXj1fZGZkSmatcmrufPakgg==
X-Received: by 2002:a05:6000:2c06:b0:43c:f5c6:49bf with SMTP id ffacd0b85a97d-43d1504985cmr12930728f8f.5.1775125749348;
        Thu, 02 Apr 2026 03:29:09 -0700 (PDT)
X-Received: by 2002:a05:6000:2c06:b0:43c:f5c6:49bf with SMTP id ffacd0b85a97d-43d1504985cmr12930682f8f.5.1775125748892;
        Thu, 02 Apr 2026 03:29:08 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f843dsm6658714f8f.37.2026.04.02.03.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 03:29:08 -0700 (PDT)
Message-ID: <9f169800-12f2-4f98-ab99-e4433b2b49a9@redhat.com>
Date: Thu, 2 Apr 2026 12:29:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] igc: Call netif_queue_set_napi() with rtnl
 locked
To: Bjorn Helgaas <helgaas@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 andriy.shevchenko@intel.com, ilpo.jarvinen@linux.intel.com,
 dima.ruinskiy@intel.com, mbloch@nvidia.com, leon@kernel.org,
 linux-pci@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 lukas@wunner.de, bhelgaas@google.com, richardcochran@gmail.com,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Avigail Dahan <avigailx.dahan@intel.com>
References: <20260331173728.GA146742@bhelgaas>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260331173728.GA146742@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,lunn.ch,vger.kernel.org,linux.intel.com,intel.com,nvidia.com,wunner.de,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-274459-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C7100387BCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 7:37 PM, Bjorn Helgaas wrote:
> On Mon, Mar 30, 2026 at 04:02:30PM -0700, Tony Nguyen wrote:
>> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>> When runtime resuming igc we get:
>>
>>   [  516.161666] RTNL: assertion failed at ./include/net/netdev_lock.h (72)
>>
>> Happens because commit 310ae9eb2617 ("net: designate queue -> napi
>> linking as "ops protected"") added check for this. For this reason drop
>> the special case for runtime PM from __igc_resume(). This makes it take
>> rtnl lock unconditionally.
> 
> Taking the rtnl lock unconditionally certainly makes the code nicer,
> but the commit log only mentions the "avoid the warning" benefit, not
> the actual reason this is safe to do.

Sashiko says it's not safe:

---
Can this regression cause a self-deadlock when a runtime resume is
triggered from paths that already hold the rtnl lock?
If the network interface is logically up but the link is disconnected,
igc_runtime_idle() allows the device to enter runtime suspend. When a
user queries the device using ethtool, the networking core acquires
rtnl_lock() and then calls pm_runtime_get_sync() to ensure the hardware
is awake.
This synchronously executes the driver's runtime resume callback, which
calls __igc_resume(). Because netif_running(netdev) is true, the
modified __igc_resume() unconditionally attempts to acquire rtnl_lock().
Since the executing thread already holds this non-recursive mutex, it
appears the system would self-deadlock, hanging the network stack.
---

/P


