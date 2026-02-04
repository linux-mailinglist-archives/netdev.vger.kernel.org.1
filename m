Return-Path: <netdev+bounces-256502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AtdIfadgmlgWwMAu9opvQ
	(envelope-from <netdev+bounces-256502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 02:16:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7F2E0601
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 02:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 906EC305EC0F
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 01:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A0823EAB0;
	Wed,  4 Feb 2026 01:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3JTZD0F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A883923A98E
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 01:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167587; cv=none; b=EJnDkd7UI3WaAii2XzgiWkV+4sA9+REU7/qmh2iOoQYcdTLAwsXEiZqpoV/sQm1HqjkjDzUu0oYKq3Pek73fBgGPfji+hDh+O4m+Xm24wp8dqOExmAfpR6RQQvAfaVl/HSdWpaYmDyiF2NVQMNla+NUDOgLxZ+L7EGSauKnfEmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167587; c=relaxed/simple;
	bh=L216ITtMRNoIXMS3FPhIXyzM8tpPNsKUiknEhOPYEQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjcuSGzl24aAte9MzkkN9OPnKxa7Hp0bBCep7AnxVjKkcc9Pe/8Ms87yPywbL6Tx/iwTMY9iWFcmSlV7Vm/ntdgncOHxUY99TpZeOvoV8N51dm9s5FzxTJo7KHE82J2hQ1C+X3FkGMgmwkhZWBdAhd+0/kc6FUEhqBnIogXYH0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3JTZD0F; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0d67f1877so41592995ad.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 17:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770167586; x=1770772386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2FLPsebHG+vAwAXgBhxcvyQhF1/f0xjdQWPxcZ9aWgI=;
        b=f3JTZD0FbraNyrhg7Ajh/Nzox1H0sw23Y4cLQMLZEWwWsc6027WuntPd0FkEgntsiD
         j+YBp7ATV9SBP+dE2MqKf0n+6agMgQPmKNOMqhQlDrB62jJPdqz6XSpyaBMRksze97Mi
         e5wrdkTvTvT4NMqujtC6rRftZ1ncKY93+oATf4ItjR4IEl035In3NtgYlrHXe+F9Avth
         S1Dmaoyec/VPUVtNtz/vQhOSDxNtqUMEn4b0FY5t/+ZxS08hJEE1ijF5wsAWBryHbQ0z
         dp9uCZJ/f2a7IntTLTgmqq8y6o/ugJtuAuNW0Ex3fgvoHlFlAGXhd4hHyikpc7PScww8
         hQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770167586; x=1770772386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FLPsebHG+vAwAXgBhxcvyQhF1/f0xjdQWPxcZ9aWgI=;
        b=bWiTQ0UYj43Pd1LZgZSj1QveWFrACo9Gd9kASjptJFeMr/ygjVKWEN7Gtnpn5ADsNs
         QhV863BIrIkjuWXYeAd2pI9STshz7aLPa4srfeTsjQJ6vUc3kutPn+ublWLieoIGOKbt
         0lT6X5JoIeayzo3QoUBzcCBVW8xvcFg/j/IFBuYKXpLO4x5OuuC4F72x/UFLljc+BirK
         85GMpuAb6ZCT9/Fy2StaeZriidJEc7VQVEaaiDPNRV3x+iVxeuaL1dViDPV4koEqSREZ
         L3vl/FOw1PyJFhLrMSLaLJD7Ln8ogfeCSq49h/4vXWLh6junTcOlRPU5q93YUr7NmEMO
         PXuw==
X-Forwarded-Encrypted: i=1; AJvYcCXnX/anXM92lLJAPMZ7c0ivFn/VyqUAlDk4Xl8J3kb7UwDegxpaFnIAem4fwLE54pwezE5T02U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhbEh5JTvNMQXTQjtuLvm8CjThjmxQMUlzTRe2bSiG0OLHqIF
	KbDydWGgj1xu9d41geUKJhMPIUlEbrzY5Jz6iFn+NW8KNaryKkYjRAFH
X-Gm-Gg: AZuq6aLxzfG4UR3w3VihZ2XRBuZ2yGmfhbIDfYrrZjUiP2OcfW8bGPSlmzvny1xlWvy
	4fIP53756H34JOOeJTxRjmhSCbDyCX5FbRf/Pi/b4jEKhXqpcqtDtwgc4Fy/iEFwujHhDSMSh1i
	wFk01FuTcJB4NsHESx3nQGwof1Am1fmCKxZIFEmrFfBKg5TXiphErhqWjQmWW/2PixUArA2CB43
	03SnFteGYjU54K/W5eyx/gnKcpzQV94X9dsn5c9Oz2Om4G9dibBO368O4TgU1yipwYgnORHlmZ7
	a+n16KquDF8ZtUZXr76GW9M8sxOEQosOYg1m5n/BZAtt5MtNHNaA4Lrdg5Sisg1PcKvLkxSzkXJ
	LJwiS/Rf5a5iOmfld+ezuSlSPF3wvgHLmDblddJb1LSPi8nSLt1wDa4QB2HZ3/Mo+KoHrkRdmxO
	rx08w8whv/vW6fX6o=
X-Received: by 2002:a17:903:2a90:b0:2a9:3229:bea1 with SMTP id d9443c01a7336-2a933cf3fdbmr12875375ad.13.1770167585962;
        Tue, 03 Feb 2026 17:13:05 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9338512f4sm6798325ad.9.2026.02.03.17.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 17:13:05 -0800 (PST)
Date: Wed, 4 Feb 2026 01:12:59 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Weiping Pan <wpan@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] bonding: only set speed/duplex to unknown, if
 getting speed failed
Message-ID: <aYKdG2evl8npuxB1@fedora>
References: <20260203141153.51581-1-tbogendoerfer@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203141153.51581-1-tbogendoerfer@suse.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256502-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E7F2E0601
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 03:11:52PM +0100, Thomas Bogendoerfer wrote:
> bond_update_speed_duplex() first set speed/duplex to unknown and
> then asks slave driver for current speed/duplex. Since getting
> speed/duplex might take longer there is a race, where this false state
> is visible by /proc/net/bonding. With commit 691b2bf14946 ("bonding:
>  update port speed when getting bond speed") this race gets more visible,
> if user space is calling ethtool on a regular base.
> 
> Fix this by only setting speed/duplex to unknown, if link speed is
> really unknown/unusable.
> 
> Fixes: 98f41f694f46 ("bonding:update speed/duplex for NETDEV_CHANGE")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

