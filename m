Return-Path: <netdev+bounces-283824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJdZMfSU+Gn0wgIAu9opvQ
	(envelope-from <netdev+bounces-283824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:45:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1BB4BD215
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1119C3021D00
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 12:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2282C3D522F;
	Mon,  4 May 2026 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvLtTlsJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE3A3D0917
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898605; cv=none; b=Ay5nxKnkeeWAgRJpsKvfCLI/bMoFO2909JtzZ8fA8PZDPclNGkP0RzjH0HVRgO+fbD48jn11r9spC0nTENpGuiKXkTTatC9oH2OjKUbOnz/yGw/Bncr36rdwRWSdQg7qI/ucbucpUpovy803MtngjDy/aiZbiGWie0kIRJW63aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898605; c=relaxed/simple;
	bh=jWGoglP6jmcwlrHvt1gQ9/+zWIwt0vegzHr25BbK6cc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TS78XL6/qlxkjzp7ffmmRWonZHI0Tu4rkFuHeN/yiT8eXMdZVo8hx70rm84fpcuOfBorPhRoxWV5PyQmmuY9N27SeEYZzB8DvMDFQx2/IjppkaqrENt1OJCGXGNUrz32fv4DZm4PPtFEh4cFcAXy5LtmG/WTqNRWGgOJauUiajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvLtTlsJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b150559bso27321085e9.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 05:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777898600; x=1778503400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ufm/8wyV7h2cWwxL5F4jbAArsiyVqXQndXIOjfMIX4=;
        b=XvLtTlsJ9uh3K33svRXL/rWcr2sD5q3Xga6b5UTIeCDK0LNib8hVKkfBTGtUmww0/M
         WoKK8s8TQdmUbdOxi8ywztkLLraGkG1nG+bUb5ZASV5SwteD8gFcQs8+2K6vDMXpOOok
         klki9QE/d2fWuF8JQcIHyyMjxdRdS4KTQB9gSrYmpvSc6o90dKvqDW584M/CjZxa+8xB
         LG2mgEB7bUGvJ3XUx2+cCKLgauyRDQyHHsq9HHlU+/63Klhep0rDOgo7cMrsuzP9ZAw9
         lHYItr+KtzOk/AQeaU6GxYZA4zLPGwN/BXSgogNGA51dQBxgN/F0YEykHtwtR7ygbykd
         hjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777898600; x=1778503400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ufm/8wyV7h2cWwxL5F4jbAArsiyVqXQndXIOjfMIX4=;
        b=VVW9Vhziom2i+umCUSJXGf/fWabAfzg2CGbN83h3uUaFe/UMnzOpJ0oUwwGFmElq3M
         3NG4kkbLurXLTuS45lKxcn3/R9Ii6VJiEYGfcqmk/1KMgjEEbjMG0T5OwfQek1IYUDw8
         H3bsKILasnDYBdm3jnxH9jZ0yL5C5wmIRcLPlbsOejKB+cUZoPWFPxUy9zS+yGJNccZa
         9JPCzVIv+wOxEAxfa3Go9JoH4c9Ze0NxCoBIFJhMtSjc7SfTc3JpJ0+MihxjK1/vaj5N
         DEV25TM5Qz4mZmJxjrRQZJc4ZdMORGZk9bC1gcBIzoEgumM+yzPWZ6XgGD29iuO5/9i5
         AwsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ZU4XuukmzaYv0PpSNxyA3Op3G80+FL2Ik8c/XZyVRZHWdz0ysq3G89OftiJ831oHff8C/THk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/IQHe4zA1aEgq6IkOt49BBBS/+kRD23SKUIaNZ0V2i0TPlkZ
	oo4vyJO3SGq0sGNhBeJ9ktzx49XY/7/pALwRFfHeaRHrQZaWhj6axLb+
X-Gm-Gg: AeBDievfuj3cgOMPgacqLB798gnajIRvc4A19m2B/t8wP8vid14JIOUrVng0keo+EB8
	lR1MM/2/IfWaNb3Ql0II99zxgqoekEQ+HfPeOMMbJkFFbgw+OaKs5vvPqEyja6rCCWmowx3rj0f
	cUwshOIEFHbfLP3EjhTYY5DDB2NK1vplYsotKoQXpLe52HFp++QphonK+qqX8ogcuCDpSlS505Q
	f1vhGH1MjkarwlGdg4iOzI65XyOXdTlvB1IN2hZpIGYw167EkD+HvOGBeX3Bi0ViYNBqKAEI4W0
	8bkQoLlbik0gCa7Lv0nBonh6k1ZX43w96fmJeK7l1cov7Ogj6cBgieskUOriMuv+hzNtG1wQCFO
	/jHrQ5kSe5PPLnpZ8cve+dxH7sVfEPhqUhzJzQSD+PsrwBtYJheDVMr8rhP7tFBmhGqjGhNMGFc
	L3zxYMsLpzzejoOVpdc8rWI3xxcv0HHxXpTAD2xQa+S8Slzwqqz7LK/CjqSSzQPeq7o1J8UsrnO
	0I=
X-Received: by 2002:a05:600c:a411:b0:48a:7b55:12a6 with SMTP id 5b1f17b1804b1-48a980fc3e7mr112517875e9.0.1777898600087;
        Mon, 04 May 2026 05:43:20 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fef2a67sm111207925e9.5.2026.05.04.05.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:43:19 -0700 (PDT)
Date: Mon, 4 May 2026 13:43:18 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Yury Norov" <ynorov@nvidia.com>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Ruan Jinjie" <ruanjinjie@huawei.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Linux-Arch
 <linux-arch@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
 bpf@vger.kernel.org, "Nathan Chancellor" <nathan@kernel.org>
Subject: Re: [PATCH 1/6] lib: include crc32.h conditionally on CONFIG_CRC32
Message-ID: <20260504134318.6eae8193@pumpkin>
In-Reply-To: <ec4ed7f5-b1c8-49e4-b83d-e29c5414b9de@app.fastmail.com>
References: <20260430211351.658193-1-ynorov@nvidia.com>
	<20260430211351.658193-2-ynorov@nvidia.com>
	<ec4ed7f5-b1c8-49e4-b83d-e29c5414b9de@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3F1BB4BD215
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283824-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,rasmusvillemoes.dk,lunn.ch,davemloft.net,google.com,redhat.com,linux-foundation.org,iogearbox.net,fomichev.me,huawei.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arndb.de:email]

On Mon, 04 May 2026 10:03:10 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Thu, Apr 30, 2026, at 23:13, Yury Norov wrote:
> > Currently, bitreverse API is either declared based on
> > CONFIG_HAVE_ARCH_BITREVERSE, wired to arch implementation, or if the
> > arch has no bitreverse, based on generic implementation.
> >
> > So, regardless of CONFIG_BITREVERSE=n, the corresponding API is always
> > declared. If that happens, the functions become declared but not
> > implemented, which is an error.  
> 
> I'm not following that description. Why is it an error to declare
> a funtion that is not implemented? Isn't that how optional interfaces
> tend to work in general?
> 
> > The only header requiring the crc32 and bitreverse prototypes is
> > include/linux/etherdevice.h. Thus, protect inclusion of corresponding
> > headers in the etherdevice with CONFIG_CRC32, together with the only
> > function depending on it.  
> ...
> >  #include <linux/if_ether.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/random.h>
> > +#ifdef CONFIG_CRC32
> >  #include <linux/crc32.h>
> > +#endif
> >  #include <linux/unaligned.h>
> >  #include <asm/bitsperlong.h>  
> 
> Don't add #ifdef blocks around headers. If the header cannot
> be included without side-effects, change the linux/crc32.h
> file instead of its users.
> 
> It looks like the problem is the check for CONFIG_GENERIC_BITREVERSE
> in include/asm-generic/bitops/__bitrev.h, which ends up
> hinding the generic___bitrev32() helper without need.
> 
> Simply removing the #ifdef there should avoid the build failure.
> 
> > +#ifdef CONFIG_CRC32
> >  /**
> >   * eth_hw_addr_crc - Calculate CRC from netdev_hw_addr
> >   * @ha: pointer to hardware address
> > @@ -291,6 +294,7 @@ static inline u32 eth_hw_addr_crc(struct netdev_hw_addr *ha)
> >  {
> >  	return ether_crc(ETH_ALEN, ha->addr);
> >  }
> > +#endif  
> 
> I see there are only user users of this function, neither of
> them are performance critical. So the other options would
> be to either open-code this function in the two callers
> and remove it entirely, or move it into net/ethernet/eth.c.

Or change to a #define so that only the users need to have the
required headers included.

But open-coding in the callers saves anyone trying to read the code
having to look at another file to see what is going on.

-- David

> 
>       Arnd
> 


