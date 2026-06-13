Return-Path: <netdev+bounces-298887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SUF6LNzALGpNWAQAu9opvQ
	(envelope-from <netdev+bounces-298887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 04:30:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D26567D893
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 04:30:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="abNE/kxG";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298887-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298887-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE3C8313EB92
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA1D2C21D8;
	Sat, 13 Jun 2026 02:30:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C6F2147E6
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 02:30:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781317850; cv=none; b=bH20rAaYEKOwCiL7kO3hQVsa2vrfHpCe5y9nHtBLzEeEnq9UBa7IWhbL5S1wHTOjgMoyhyd0rV5sFGsf6v+I3rnQyfgwLoasnEP45iL2EDwW54sTq7hyNsMlpzrWuh0DR61uuU9RkNVQocroGStqVAQdYxCzEwV/XVz0YrVMg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781317850; c=relaxed/simple;
	bh=HgbZyHvGeCzljg7Sr9TXApppcDGF9vIDEw/qZU2nt/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rm9KmJnINupsuQGOQ91ovSJlruv+0CMsiqR9Bd79nlWq2Qsq/iND8Sp/JK2YHx3qwyKVXA6h8geMXFhB86Cq6h7p0CHQsGIs7FHhokNp84KdtRIimJICzKr3yVAC8W7VY60HnOGnwBg/7TKVs4ptKWP3iTVZ6/T556gfUMZ1IM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abNE/kxG; arc=none smtp.client-ip=209.85.210.193
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-84234c83142so782428b3a.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 19:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781317848; x=1781922648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=64T+SialQZ6697/fNGFMpzn29D2cLqJP0AzHPR78vug=;
        b=abNE/kxG4jFrmvT+x4EyYoOkMxu8RF+7qYCjxIQq7kzrGVNJvTvpllxX1RwqMl27bn
         FVEH7O8alCnS1mvbdhIf7aZhwwOn7YsG8F3BKVfWx7n4spcb7CDptJqKDazt0+O+OThw
         3m9qyotXWUT/wQed6jf4fVU+fzpKnc1ZdUQQ5Ap1eTyKXb1ifQL8aN95bzpcCEgEtPxU
         WBcYLHemZTFB4PJj0JjOoFN4f9PeCSm27u3KlRgOKXgKQ3QTVC67RD4VLkN6EQLT7fI9
         +pwAooyaPI7kOsBx6S8DAWTks/4B7dT46X1S4r5kV4k2LBZbcOJphNuA8thRwkVNYdtD
         kzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781317848; x=1781922648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64T+SialQZ6697/fNGFMpzn29D2cLqJP0AzHPR78vug=;
        b=ILO0fWKyr08viPsg/KwmO7o1jcu1b9/mmN1c54KoNgBOrRicgGCat+NpyFQbxuE7ev
         WW/d+rnCw1jWk1oUiOTNoMF/F8WAerVLd0gGMVXi09IVW9W/Dv1qXr6yWER6LeioDsZl
         KBc5Ekb0Z37mma4WNsyVwE5vqN6oAnKxpAfdMjyBxa0KXLQGXQ6oGEykTwUpCgLTOP9O
         iZ2VxlpXgnMQu/fs7mcTatpS2WdQG95soeSKXMzxLwqHgTIvw0lZPM1Z+HXx3mNCE77m
         Dpzy52m8s3wonZEdLg87gM3N0OHtLREUtM8vKoXo+rY5JPy5v5EuSD04r+qzz8YrYJ99
         RnXg==
X-Forwarded-Encrypted: i=1; AFNElJ86Cd38H2W3OSHAYXOXoNXNEPKEJkdpECF4H3Mue3rDWfMXcQLH+K2QEKO1FbQuUpXcZwtkGgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9HLg3pR3d2ZqInXt1q30Pchu0wO4RLrxyKlzyIXbPkH8rylZT
	kk+MT0pEQhwJ6jy6vaE3CSEknlakoNG6LO0B9ZmdY0Qzqm3/t3sFAFVP
X-Gm-Gg: Acq92OE6g4GSfA7SOQgN946LkurILxgLzz2xFM1wTaG7z7OkbhZ3h3A4VxIijBkEB22
	dTwQNOJda1HfADgHlBsMPLTTPYBL5z/Yn/eKss1h04i5vgrpgOicnKvk8ymwhpZWWoehuarQs8F
	NBVRhssj4CUshQkf08KarIU8fcntmuEtGxzZmfT4LXvpIabWThEpNISeMtMDOVHG4p47WE6plxS
	R5ABENOsTpq1QZgYOWQ8ybJbfX1lqGk+pxO8obQ2VaepOav/2i4GgdSF23W6gCdL0N7DJLa6EOQ
	23nwJkJqHSg49e3zh7ovpyORPWGcncBy6zfj3X3zIzxqUOjMdn73zuQZZYoMru8OI9NUd7dAtB8
	BlCvOiLmyB0JqNmi3HEk+tgFK64YAaM5nQjXVpnq0HU4/mSmQwO4T+PrqL1KgNsnciTTKWcBpYj
	ksC2rKK1VotnMXuJvA
X-Received: by 2002:a05:6a00:288f:b0:837:a211:4ee2 with SMTP id d2e1a72fcca58-844e1a83861mr2129907b3a.38.1781317848278;
        Fri, 12 Jun 2026 19:30:48 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b04808dsm3630627b3a.52.2026.06.12.19.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 19:30:47 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:29:05 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next/net 1/5] ethtool: Introduce
 ETHTOOL_MSG_TSINFO_SET for virtual interfaces.
Message-ID: <aiy_eV7RP2nPlxmJ@devvm7509.cco0.facebook.com>
References: <20260613010039.1362312-1-kuniyu@google.com>
 <20260613010039.1362312-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613010039.1362312-2-kuniyu@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298887-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:memxor@gmail.com,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:kuni1840@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D26567D893

On 06/13, Kuniyuki Iwashima wrote:
> Before enabling SO_TIMESTAMPING, applications typically try to
> enable hardware timestamping on network interfaces via SIOCSHWTSTAMP
> (or ETHTOOL_MSG_TSCONFIG_SET).
> 
> The timestamping capability on an interface can be checked via
> ETHTOOL_MSG_TSINFO_GET:
> 
>   # ethtool -T eth0
>   Time stamping parameters for eth0:
>   Capabilities:
>   	hardware-transmit
>   	software-transmit
>   	hardware-receive
>   	software-receive
>   	software-system-clock
>   	hardware-raw-clock
>   PTP Hardware Clock: none
>   Hardware Transmit Timestamp Modes:
>   	off
>   	on
>   Hardware Receive Filter Modes:
>   	none
>   	all
> 
> These operations rely on the driver implementing two callbacks,
> dev->netdev_ops->ndo_hwtstamp_{get,set}().
> 
> However, among all virtual network interfaces, only bond and
> macvlan currently implement them.
> 
> As a result, most virtual interfaces cannot advertise the
> capabilities of their underlying devices:
> 
>   # ip link add ipvl0 link eth0 type ipvlan mode l2 bridge
>   # ethtool -T ipvl0
>   Time stamping parameters for ipvl0:
>   Capabilities:
>   	software-receive
>   	software-system-clock
>   PTP Hardware Clock: none
>   Hardware Transmit Timestamp Modes: none
>   Hardware Receive Filter Modes: none
> 
> While these callbacks could be implemented in each virtual
> interface, this approach is limited to those directly linked
> to a physical device.
> 
> Not all virtual interfaces are tied to real hardware; for
> instance, packets from UDP tunnel devices eventually pass
> through physical devices and can be hardware-timestamped there.
> 
> Let's allow configuring the hardware timestamping capability on
> virtual interfaces via ETHTOOL_MSG_TSINFO_SET.

I don't have a lot of state on this, but when adding xdp hw timestamping
I remember fighting a lot with those apis. Now we are adding another
one, but (seemingly?) for sw devices. Can you explain a bit more about
why can't existing SIOCGHWTSTAMP (or ETHTOOL_MSG_TSCONFIG_SET) fallback
to your new dev->tsinfo.enabled codepaths for the devices that
don't implement the ops?

