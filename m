Return-Path: <netdev+bounces-256106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDkUEWZqgWnHGAMAu9opvQ
	(envelope-from <netdev+bounces-256106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 04:24:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 77310D417C
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 04:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2B4030055D2
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 03:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2432F1FE4;
	Tue,  3 Feb 2026 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn9d+Gta"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DB62628D
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 03:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770089057; cv=none; b=U0rrOSV4LwCRwgvG7loeOkn4M+qNIChD4JV3uGRRbXhSySpzpFbLKqqq6G8TKmM8PoJtVxxZrwpazbBIo/TQjBVFzBz7f5+FsLRsf8QuEA/isSuY/fpNGOuqcWjTaqCQ9bIt4eVyppHtlAI6FL7nk+Atz8nGzi9GXMUjc8kaAh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770089057; c=relaxed/simple;
	bh=s2/NiPRF8pByV42uHHuUV6Cd8yTO4MG04MmcjvnU9cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qdzur3Ekd54Ga/Im0FzpOqjrWVZbWSWNpUdh1O8FRUfljGqbxRONQfaKJYs/Ts0cn6Igj/ckqKocpEfNCKrOhNrfJzqbnjYK4v5EpjXBTtHucfrHu8lEZT+5zezsr1bmeXsNkl89DFQ41UrEUAc7QoIkbEeVnMPXv44qxaLjQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qn9d+Gta; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a78e381fc1so24570955ad.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 19:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770089056; x=1770693856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iHSPOirFIFdpbKmf5I0OdBd45CTjYQzdFrAVFSsykfE=;
        b=Qn9d+Gta1W/CLBKd4m3e3jaiOg3oacEuN7tLI0WvuqzmfCrswsQKos7iDATbRlvYXl
         /mNXpU3vLGKu4dTgS2ZCrKS1Gkrnok2EnRYY5P3YCENu8rp7LY7nh0AOyYjO9bEN1Uyo
         20G6sgZ6QqGC9MR7zZA8sMgx/p7OSDFFM0wqLduHTMz6Xer1I0heSEFGcER3owVHnTpa
         4r9PNw5CpSiMomxT2BQtukf171aLpHgTjxZf+8ZLGIe2F/RpfqD1opMDtnC02oQuBPaO
         N6IckaXb/87E67QDxPghc6G8Bni3l63odc759Aj9YEBPbtKgMVJ4u03JjDQRRgoLZYAH
         koBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770089056; x=1770693856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHSPOirFIFdpbKmf5I0OdBd45CTjYQzdFrAVFSsykfE=;
        b=m3uvAOK4v6WNmIZHgLIAyl0juYqcmoUrBPg4p8LvoiJGBzoFtN5GL+HlHsL93NZJ18
         v98m2SrQpVm0s+TXARcjNtiH//prF7zsQ+OKNqIs374F2N72Th1m8CN6p643bICV5v9a
         t1kecJFwCER4iyUfbn0xUz0ngnh+W+BqdLQI5wVXD00b8BRhBAkm/wWBiPQ8ybWPQXN2
         Uj7q+sZR8zS7Uok1X06MYbRYgZvtH3awe05QinwlxeZtDqI8YR7O1ETvtCbDLCkpoh0f
         fybHymoele+E3vrXlMTJQpn9bvDTYJq8OEByVXtv4VPPdkTJLLh/fzb2Ze54UvUJaequ
         CfUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXrdTZa4rUnkSjmnlBlPzFG7HOGeDH3VjAJcb+JL6H+8V7l57a6GQCtL1iuiBpu3DGvfAdBMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRMShS4TCvETVo18aQbZyqWeK/+Y90H4Q9tU27kEdws8wiEl3J
	UI/9uviE4pN29M9qkTLejgWm0L4AVfbN/6ckcSRb0ISWJ/gz4tdO6ETv
X-Gm-Gg: AZuq6aL6i0uAlDtQyvN67Laouzf2g9JXbDXDfF+SXLgyrzVzmNnXKVxHDXiE+TuPYnW
	xTrnegDzCmLiWCPqKP2+dZeJeZA7rGGGLU93r4tXUt5LCc0/wFR8XX2CwDzuYqr4y0bV0D5DIT0
	cJFEG0TTiJiWJdE5QseYfgDvLTUG2OSqQVSvlix6LgMQEFOwgF9vCAm3D26qVBKNJ3+zTY3S03t
	XxBZCHdtHI0/U4b3s+iWbcdODwx0g+PAmcpehvft8SdmqM7Vt6ZYqdzY4b/tOBBmKex65dmTK2e
	PQE+yYdOXaCI3iTEw2X3o/nljjIRHtvkd+Xulj1w39Gjpd7uiFdG83wvW3h6f9KgsbQaawfgW8g
	rcAJk96MoiS2AXGcdO5+Z/E2lDA7RxBfEqLETz7fSTdbxnb2WC0q3jOfpJCGTG85BPQSL+KGcH/
	aTnWGFKg3ZjFJkvoc=
X-Received: by 2002:a17:902:e886:b0:2a9:2858:19ad with SMTP id d9443c01a7336-2a928581f05mr3998675ad.49.1770089055954;
        Mon, 02 Feb 2026 19:24:15 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9295c2ee6sm1283485ad.2.2026.02.02.19.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 19:24:15 -0800 (PST)
Date: Tue, 3 Feb 2026 03:24:09 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: only set speed/duplex to unknown, if
 getting speed failed
Message-ID: <aYFqWcyuuN8V71LX@fedora>
References: <20260130111904.144024-1-tbogendoerfer@suse.de>
 <aXylwyr2pV0rZAW3@fedora>
 <20260202151726.36abe1d0@samweis>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202151726.36abe1d0@samweis>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256106-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 77310D417C
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 03:17:26PM +0100, Thomas Bogendoerfer wrote:
> On Fri, 30 Jan 2026 12:36:19 +0000
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> > On Fri, Jan 30, 2026 at 12:19:04PM +0100, Thomas Bogendoerfer wrote:
> > > bond_update_speed_duplex() first set speed/duplex to unknown and
> > > then asks slave driver for current speed/duplex. Since getting
> > > speed/duplex might take longer there is a race, where this false state
> > > is visible by /proc/net/bonding. With commit 691b2bf14946 ("bonding:  
> > 
> > The patch looks good to me. But based on your description, I don't think
> > the fixes tag is correct.
> 
> the race is old, but it got visible by that commit. Before 
> bond_update_speed_duplex() was only called on enslaving and when bond
> is brought up. Now it could also be called during normal operation and
> that's what caught attention by customers.
> 
> I'm fine changing the fixes tag to whatever we agree to. So which should
> I take ?

Maybe
98f41f694f46 ("bonding:update speed/duplex for NETDEV_CHANGE") and
589665f5a600 ("bonding: comparing a u8 with -1 is always false")?

The 98f41f694f46 set speed/duplex to -1 by default, which could cause the race
to show SPEED_UNKNOWN. But (slave->duplex == -1) checking is always false, so
no possible to show DUPLEX_UNKNOWN. The 589665f5a600 fixed this issue, after
that speed/duplex both could be shown as UNKNOWN.

Thanks
Hangbin

