Return-Path: <netdev+bounces-259203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bd36KtVBlWkYNwIAu9opvQ
	(envelope-from <netdev+bounces-259203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 05:36:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B5F15301F
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 05:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B95803023322
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 04:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEE2244665;
	Wed, 18 Feb 2026 04:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrAGnO2W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA042116F6
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 04:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389393; cv=none; b=XMYg6c4XJjGg3olHv9vY04VoPTqG4YlV1WXfQIPQu5JDWmwzq4CqT2HmRnQPNiHzoXkTKVRGelx+PaWOJTqF88x3geONMMYrSrA/ikng+5rK+f69QcVuo6uA9iaE+X26Jm8YSWM1rNWkDh0CknooFa4fX5i2usFqx/F+6LosVlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389393; c=relaxed/simple;
	bh=WkQfnMIqqhTpvF7GAl+CV39UW9+kMPDJ2HfPsIMKTbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJmtDilPNLt8jJ2/A0jWrOdQSZWsgUJ04KIVmO9DnPNvCIwgEngztdsBfoEX1ycDbi927fmV4yfQ2DLlkjaohICBueQgY7Qgsz9bRIugLyrZxo9AzEXuYTV/vdkcYGz6RuN6Mhumik7H37C9rJ6LkI77ib+n4Gz6DZRTF/+LvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrAGnO2W; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad3f12a496so2004825ad.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 20:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771389391; x=1771994191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UIK+4uh2cdlhbXr1YAGYhpAT4mpbb+rH5PwB6hritaY=;
        b=KrAGnO2W8yXgoovDGomFQVrNZbu/zGNzUzm/Cet6zYXwE03qpM6XNKskoro6gztUPi
         fcrt2+maYSyixIDaB1RRLxWJJJV0vZxj27SCS/Fu0tsL8v/ExpGyyRSVt5Q/HNL1oTqQ
         iBCUx3Q4LyNTFtDIh40e73G25alzP/znW1XmUoDkGNcBKkJLGZnOD/PsW2F5RNMbArj1
         rujVn2aYA/gWFjsUlpaggBGZPEXOlTDzaYG8WNu0wJizsA09TbaDLlD1/5QbSKZiMIZ6
         zaVEwH4NreXKJVUPl0KOBvLWCK9uoj9odtwAoqVFhJi0HCA92zzG6hgXe0FTSkaHei2P
         q5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771389391; x=1771994191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIK+4uh2cdlhbXr1YAGYhpAT4mpbb+rH5PwB6hritaY=;
        b=uKRzCfI0tqNLGLys3U8gyc06S+FpNSg0B4J/RpIVtAhDcl7ZGJNHd/qkprKhFkc+/S
         6dLO3xgZ+00AQP36i8zQud0NelqxzxHQYIs3siXrJofRaRMs1SYwVfInDkdt2qEEuiG3
         8tbROdi4yqcyRaWsEc7zJ7UlNYN8zsvbtvVwV72omWcwugHAUbEgRgkCCRvpGpWpcDr5
         R9F6ZBWVj1VI0tRcapQz4iO09K0GFF6xw2j+wz4wtlZsWD1XuupKYF2Lv1h6rz5hsocG
         n48J/IEcR2RGD9rHM6FqHsytWIXZRHSzr475iyRCsXFIqvtPa04vc1IQCP58z9vmgpHL
         ZQwg==
X-Gm-Message-State: AOJu0YwE6I3iZ4aMD55/+U+aP0matAtsdgU6G4OliQejj0pu+4c5HHJw
	p0ARf/NBuQuf84cnsj161Wz5+gNBM7TMyex8w/FI12/AFlPHRWbvDFka
X-Gm-Gg: AZuq6aJzQDGfVI2sKsBttfBQZEYHQjPsVcDY3Vm/wdr6qWeU1G1ZLQhmKSz2fk0Hd23
	dEg1pQPpzMn9r3UFJ1MdkakuAyYSz6lQ68vixEPDxZMPIyUH4E/jQIQrHKTG8jbsctXVZGPHj+c
	lt1JVTWZ8QmY09nNrvQ/BGMwm3MFKe1xNLZNtZHCye+yzYAZyu42l3BRGp59TS2VqtIXZdK1EDq
	miJX/1wgiU2k882R1NIsNh8E/vN15+ItRvro1ebsIdjujvta29oszfhsdMYOnUYGq4PDK4J9/K1
	sQBePAowIcTJPFuTyxLbMglQwQAjFd4QdRGkwQpxuOW3UNGdaRF3m4lfkPL9Pm5VzIj/m3oPy1H
	Ueqdt3kJQRP/RDBw+Q916WXKc9RqwGkqGE3jzNKRLukIuyXgKVVhMRd5mw/t8zSczlmaVNPAf0z
	5z8x4JT2EgnqIjUFjBjw54CfYLFHU=
X-Received: by 2002:a17:903:22c7:b0:2aa:f989:dc6b with SMTP id d9443c01a7336-2ad50b30a50mr8102005ad.4.1771389391479;
        Tue, 17 Feb 2026 20:36:31 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5c20sm125058215ad.46.2026.02.17.20.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 20:36:31 -0800 (PST)
Date: Wed, 18 Feb 2026 04:36:24 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Liang Li <liali@redhat.com>,
	Nikolay Aleksandrov <nikolay@nvidia.com>
Subject: Re: [PATCHv2 net] bonding: alb: fix UAF in rlb_arp_recv during bond
 up/down
Message-ID: <aZVByEOAYdR3WF4q@fedora>
References: <20260214091541.89659-1-liuhangbin@gmail.com>
 <20260217164355.7139ab53@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217164355.7139ab53@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259203-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18B5F15301F
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 04:43:55PM -0800, Jakub Kicinski wrote:
> On Sat, 14 Feb 2026 09:15:41 +0000 Hangbin Liu wrote:
> > Fixes: e53665c6eaa6 ("bonding: delete migrated IP addresses from the rlb hash table")
> 
> Ah, also AI says the issue existed already in 
> 3aba891dde38 ("bonding: move processing of recv handlers into
> handle_frame()")
> not the exact trapping instruction but the hash table was used from
> recv_probe so at least a UAF would happen.

Not sure if I understand correctly. Do you mean we still able to access
rlb_arp_recv() after setting recv_probe to NULL?

OK, that also count as UAF, even though not crash would happen.

Thanks
Hangbin

