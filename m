Return-Path: <netdev+bounces-296738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tnXrEQE3J2qltQIAu9opvQ
	(envelope-from <netdev+bounces-296738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:41:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C4565AB69
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:41:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="jcTvx/1M";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296738-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296738-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EDEA303ADD4
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 21:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D263AFB13;
	Mon,  8 Jun 2026 21:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CE63AF660
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 21:40:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954824; cv=none; b=O9GqXTTgpmWzZMJR3SMvg8dZROR6UtzsnIGK4TIUI2RdZNWUSjOerGl2L28qPIEjwR6nOhRx4LEOwT/dS87uiJiRl2RQgNjwpJhT07xd2czPh2gHchrGa3LIuFJ5Ymwi6+yihvx8hMoSsWYA2/B4bX7vf5iZZbiwdD5q76Bk2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954824; c=relaxed/simple;
	bh=Lg9ZwlOcOfhAbvTch0Cv1dTb9CKT+F4yPbV9CbfRLb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ye4+oB4XqLOBtRFMtJxapgne6C1OR63+AaAouV2qV1CCeR/P1ipHC0u3Vuk4Nvpdd3qaLpYmGJvRC4YVJZ5hb4fHV8tpZol+egzn8O0XIxFhTyD7A6WHVHQcXM2QodeScsN0mGFxJ6XiqoniObn8diCQjTAA8rYfRhN/1RBrOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcTvx/1M; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so52863465e9.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 14:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780954822; x=1781559622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvsRWfpYyHjr9YubPvj8KeAz5AQDd/usJgEm/sviL6k=;
        b=jcTvx/1MgQk0j6Luz/zNpyiOs5Z1qaIuKgDStRzwnYO//0OKCPMvv0+vMZE4npeCAb
         +5zL8iFWve2esBYSF5pifZjrhjkIe4Pv7Tr1uBjYfI/tr+D0JsuP8HYpAWbL4+xZJF5l
         K6UiZHZ0VUpdDcZ+63KlhQ2gU9Gtt/v7LO7odRuCSYQVMy+ehohditiGMUXphaMERx1I
         s7GZvvYzgMeRowAhSf2TwCPuFzo3RH46gg2KNxhF1umF9OGL3LJzeUB2jPPY/mQOF5cL
         mIAeJDGbWG5xSCLBp+UBr1Fk0Tri9OTJ1leJMAkbeFkRfvFpnwq5QFzxxTmink8UwfNR
         oziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780954822; x=1781559622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jvsRWfpYyHjr9YubPvj8KeAz5AQDd/usJgEm/sviL6k=;
        b=H1geFcvGhT1PLoG9URTcjalvLCmFSaLuQrlxnHOy6lGNIGjv2p3u4qqy3XD3eSvIYV
         3mAekd9CfDTCU4AqLoCDuInvgIpLQzsfBs5mwdRt2ebe2bkyDRYsbQ68Ofv5dhaSZef7
         BfzDLGXYLBXAtyGZ0uqr9cfnItOtIirV5XIpzrNP5aoSZK33WmugDnBfKq2N5NdCir5M
         1ofCbcMGZAwMD+IWcL1DrgNtS2v04jUc0hxYtgq46qlg/BxzCwn9OUInUFl/63lMhg4A
         g2NVl6Jhlxu+AZscdLkUNferG/ijvUpektL1yA932EmlG55St3FynJs/+qJ6NrFebLgG
         z3UQ==
X-Forwarded-Encrypted: i=1; AFNElJ8akIPMKWCXj3tAWDmwfv4E6goYFEoz0HV8QtymKO0j5LCFxyJKY6EhvjbvztUcaUZc/DDNfcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrYMJimHjKkZ8vDMUU555KWtEJ2iYKiKQEO2I3yDP8SB18XJvk
	m4nF4dnSXm148YA5Aou2fPPIUVVCK8hElG9a7zWhUpv/+I4lwfYryiJF
X-Gm-Gg: Acq92OFvYlsSP7GrfsHVj/dkLefxPILpYk9c1u+21cdS9++QS0O7gDuQgWfU7swIf+n
	hYRyog6cUb9Dvtm/j/peH6SsoXYpyP4yb6CKEMWpuZ4N+6NBVq50YvN59QhWydNLgVXd9bn5bzM
	GXxlY2D1Uz4gf5WXtZzoEUkI0zZxO0b8lBatZAvYPO6EgqitKFmfiOrUJn6rp6U86AtpfXnvMu2
	qMngITrWnNFchuwImWH++9bIyIQ+51rCJGjDWSO69UZOnNMJJ/z/qMJfc3jfJpTW319E5EudD3v
	kiLxuqVnXSx+PZ5sC/SWRyYNH5M2lpzy6Fofzk6SSnXKCx/ruzaQAnnxHU8TyCDp07OUvBk+WPx
	He5fO7eFe9/n8ZR4IUNasj02P2G6SJdbhy6/6z7V6uUPus0cFSOYobBMbePmYLabxfWYh2xu5Rx
	JgFlmLuBK+TIhYP/Hy8ql8cfvk7KUm19afPt+29oPvzzo5Soq3s4Os22TwRtO3a1mdXVphcJc=
X-Received: by 2002:a05:600c:529b:b0:48f:e230:1d12 with SMTP id 5b1f17b1804b1-490c2625f9bmr257945945e9.31.1780954821893;
        Mon, 08 Jun 2026 14:40:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dce6sm48816172f8f.30.2026.06.08.14.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:40:21 -0700 (PDT)
Date: Mon, 8 Jun 2026 22:40:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jay
 Vosburgh <jv@jvosburgh.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] drivers/net/bonding: User strscpy() to copy
 device name
Message-ID: <20260608224020.6a9bcb53@pumpkin>
In-Reply-To: <20260608141822.780fb5c5@kernel.org>
References: <20260606202633.5018-13-david.laight.linux@gmail.com>
	<20260608132311.0fb69fed@kernel.org>
	<20260608220710.7499931d@pumpkin>
	<20260608141822.780fb5c5@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-296738-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:jv@jvosburgh.net,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97C4565AB69

On Mon, 8 Jun 2026 14:18:22 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 8 Jun 2026 22:07:10 +0100 David Laight wrote:
> > On Mon, 8 Jun 2026 13:23:11 -0700
> > Jakub Kicinski <kuba@kernel.org> wrote:
> >   
> > > On Sat,  6 Jun 2026 21:26:07 +0100 david.laight.linux@gmail.com wrote:    
> > > > From: David Laight <david.laight.linux@gmail.com>      
> > > 
> > > Could you be so very kind to read the automated message you received
> > > when you posted this?    
> > 
> > Looks like I managed to send two patches for files in the same directory
> > that contained equivalent fixes.
> > 
> > I think I should be able to merge the patch emails into one and send
> > as a single V2 patch that contains both changes.  
> 
> Not what I asked you.
> 
> You seem to be following the ML yet you excreted a bunch of incorrectly
> formatted and likely useless patches. Read the email. Start with one
> or two submissions at a time.

I got an email containing:

	It looks like you reposted this series less than 24 hours after
	the previous version. Please allow at least 24 hours between
	versions so that reviewers across all time zones have a chance
	to look at the previous version.

That happened because patches 0013 and 0014 (of 0089) ended up with the
same subject line when I generated one patch for each affected file.

Pretty much all the patches replace strcpy() with either strscpy()
or (when strlen() has already been done) memcpy().

-- David

