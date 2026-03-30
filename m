Return-Path: <netdev+bounces-273240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCi+DfWQyml++AUAu9opvQ
	(envelope-from <netdev+bounces-273240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:04:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA935D698
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6ACF5304B822
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D13332E143;
	Mon, 30 Mar 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Ge/1ALbS"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE41A3290C2;
	Mon, 30 Mar 2026 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882644; cv=none; b=UB1a+ApQSdqMDZXV4lMJfi2oeFjqPiMBk5RQb7FJq51XR1ri1/Ewtpzx99Bo7KrcailKXZ7ODXEobvWLg/mgLsQr2zSKnf6TIBl0cf4TG3JrTTpVoER+EQbQ2ZWKdoajUxAIUnVaXEqy0f1q4WQHEbdwNg95a4mE1cihOb1dHD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882644; c=relaxed/simple;
	bh=Ln1/n/ClxXU/JaYjINzFmRR8rjkriRavhZdPSGJqgH4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PpOpirh+GFd7oEWcJvZQxg8UfCWodXp12wyI/2lv893JlIy0UpC/gAhvQK7q9R6Zn7tfMty1/++WlJG5/IWt0ku1/4x83LYEryvJBndA7LW9XRLH1WnpuHU8NAttJMtwVei5/ihXeMp+DQa+XyEzuNBN0BPHX7+CGH3QmJvW63c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Ge/1ALbS; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE167A5842;
	Mon, 30 Mar 2026 16:57:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774882628; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Feu4vvS9PJP6yuJ+D33WUtWoaluTZV0mEqkqacnZuRg=;
	b=Ge/1ALbS/US6h7H7OrRnAD0zRdTSYTunQSyao56fLQ2oIBKVkWKZOt7lYDeZ8cDi3QXAj6
	huQCLk4EIFjLKfeQnS4Il/o4+rs5jsIMs1YchLoNd1vkqDg3rlnL/jPBZGCQdBKwuZCYUY
	ZiWiZ4Q2Xo4BAkv5rf0KP+vxrdIk9aB+FuVhNnTOcD8EQAWXkQi1r07jRWY8dXHfoCjiww
	Fav6rlIDcqnPjqzJ9BhwK0mzisqkAsP08GnWwd6q3HS5AjWxNItVsOmfUuun1j96AtvgBL
	03DlQQDetfzyvyUocYCVyHL/QOQwYvxSOTR8ARPDJEPFQuX4HY5ckq+RaZK2rA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 30 Mar 2026 16:57:05 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: microchip: add downshift tunable support
 for LAN88xx
In-Reply-To: <ea58ad33-ac25-4907-8fa5-167479070b97@lunn.ch>
References: <20260329224202.500229-1-nb@tipi-net.de>
 <20260329224202.500229-2-nb@tipi-net.de>
 <ea58ad33-ac25-4907-8fa5-167479070b97@lunn.ch>
Message-ID: <8e80433fe878322b8c31fc30fe89e85a@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sto.lore.kernel.org:server fail,tipi-net.de:server fail];
	TAGGED_FROM(0.00)[bounces-273240-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,raspberrypi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FAA935D698
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 30.3.2026 15:01, Andrew Lunn wrote:
>> +	switch (val & LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_MASK) {
>> +	case LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_2:
>> +		*data = 2;
>> +		break;
>> +	case LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_3:
>> +		*data = 3;
>> +		break;
>> +	case LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_4:
>> +		*data = 4;
>> +		break;
>> +	case LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_5:
>> +		*data = 5;
>> +		break;
>> +	}
> 
>> +#define  LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_2	(0 << 2)
>> +#define  LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_3	(1 << 2)
>> +#define  LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_4	(2 << 2)
>> +#define  LAN78XX_PHY_CTRL3_DOWNSHIFT_CTRL_5	(3 << 2)
> 
> It looks like you can replace the switch statement with a FIELD_GET() + 
> 2.
> 

Thanks for the review, Andrew! I will incorporate both changes and send 
a v2.

Nicolai

>     Andrew
> 
> ---
> pw-bot: cr

