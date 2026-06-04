Return-Path: <netdev+bounces-295368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qRUPNiK4IWq/MQEAu9opvQ
	(envelope-from <netdev+bounces-295368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:38:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FEF64258F
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:38:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jhkiLgO0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295368-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295368-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A37A2300A4F4
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 17:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ADB4BCAC9;
	Thu,  4 Jun 2026 17:38:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B147ECFA
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 17:38:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594714; cv=none; b=UsUZzqmdftbhb3aEmT7xNxYWUokxe/orYYauscX1xIfTE1aqg1VGgPit9ufzHzkQlhX+gFvlX8dqNs+A/k6pqvIiX7AhnzAXPOqt0MrFhVwV6j0WcoptR4QFMW4QTuVh/M6AUUGsQQc9oDDhc4LEe0kQKsWZWAznHvz+snZTXCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594714; c=relaxed/simple;
	bh=v2KH0A+T/5unV0mAelk5zB+47zjGgz9MT7jM30vb1s0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWU9M70b7mEQBDT4xPiK/iHzHOdvscj+B9mYzLimHbWff5jxj1t7DMr6JrQTiTfoOFB1cAw2p65feNSdwn2etpCoW66rlqGC+HI4ibFmC3vQXJ5u9rE/gdz+xH+RH2Ua/2hiXoZNsYHmbbNVRfwuic5K6O/7JNy1xK5gdmfkg4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhkiLgO0; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b12270b3so6531835e9.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780594711; x=1781199511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDxRgk4KLva6cv7jp07s/JuZGm0Suw+6/YbYX6FRPfQ=;
        b=jhkiLgO02xJY3jbGkLqf6yEze1IG/Ox2jCJZ1yITJxLGtM9U5+0C/k10tCut54S7kg
         CsAVN3snOFl9+cvyUyIBHJ8hDzhqYT3BOWKrygE95ThTXkwdNctJq9RjXSbVzN30eJ8o
         dHEB170KdTBrrqCpS1ehtBEXFNsGBvlFKB9RF6iU07j1Rwv/wvmygCq2COzvErF/p5Br
         mx6Sqt3WLy3dfZ7T61M+uMici202aefJ8L8GLQtOJHoTBem3cAWNWIvlDRwmKtlFP+2A
         0U5Zfi75t3LFjnLBh0BeDqWKOygVVWoQo8UGHWy6rg7/oXkTm2E+QN5eJqrjJ0Ep58Nl
         39WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780594711; x=1781199511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aDxRgk4KLva6cv7jp07s/JuZGm0Suw+6/YbYX6FRPfQ=;
        b=OtSxamoMkParWAshpSAfGdo4w5h4X5GXYUUasD8js6dJqs41bGbd2nQeQ4b8pgnCPM
         GW8RsnKifIqn+fjA3QD/KoQJWtTcnCO8NdCp0ZrMbRMfm4fJ4BodozDG/JZ79oLKa14w
         oVBmcO08L8VulHhMEd1Tshz5B0jxh6p0lebYXabf48wd6ixT2JuWMSDrplNhXViQ3vUy
         6FxK+VecPma9FTKvZT3MQQSFHFkayqAjL+c0JzZcpeYW3ML9OrB4N7I+YThRD2sSSB7G
         FYq+ZVgZyDwozhx05OUygH/scNJ1JGdOh1awMN696TQtOJ9gr7kp8ydodRILOek8TIAx
         8Reg==
X-Forwarded-Encrypted: i=1; AFNElJ+e/R2byAh9NmoV1jdlMcjUiCz+WvEqokqq012uSSEsyfytk6FOzSbqKgSINIGS+2PzViD16eA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywes28hlQ31b14/JkNnhr1iH4yasXBmBFkpv30WZYRqZg1ShYKh
	W51l0EOOIBzE5AqfsZehc2Q3wy+In991DSM3t8mz3XsYRbIdrkW+TdXd
X-Gm-Gg: Acq92OFWA+UqwIQBRIx/zr5Qa/PFHehbvMfiJl12Fk9CoZz0A7ekaDq1XKA4jRACtNE
	Kp06lnTuEYyPIMPy0MqFx20RGe4T3TvBOfnxbVAg8xdfS2Ljjlg/WIiIrw7uxKsYM38oZ9hoZVD
	b4YzxRYVRm79NQl6Kd+L0MThXMOtbhiit68El/5+tqXT2UWgaKZeQndLlBR4Vc4rjIpzVtwBccq
	IlJ9tIQLNV+dQoo9csRh9Ffc0eRcR+sOCcXXmKAHDaBDZ0tVhEY3HdOfixDzeY9cJHNmXo8vNkV
	z7IG87Qr4ywuvAmpkl4NPlLy1OytofHlfEkCRjmPFADR4VQyxYCUXlvVD//BwcXQ3jYx2V+pOHZ
	CeFEcZZzgppdS5FPdTU88hHMS1YkaSIJJMWpdCWNXLKPkSrM5Nu4ekTnkqaqrZODxgapYgk41YQ
	er6mLRLy6SC2uTxgONuX3qab/C0hHGzQIydHWaYB0abdxEsu88K2ySE0hCGp402K9lPDbi5Cc=
X-Received: by 2002:a05:600c:1c13:b0:490:b642:ce29 with SMTP id 5b1f17b1804b1-490b642cea1mr153777325e9.8.1780594710934;
        Thu, 04 Jun 2026 10:38:30 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm105657875e9.9.2026.06.04.10.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:38:30 -0700 (PDT)
Date: Thu, 4 Jun 2026 18:38:29 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Askar Safin <safinaskar@gmail.com>, metze@samba.org,
 akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
 david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu,
 netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de,
 viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260604183829.63c35fd9@pumpkin>
In-Reply-To: <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
	<20260603211736.755139-1-safinaskar@gmail.com>
	<20260604100609.6b37f500@pumpkin>
	<CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295368-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,samba.org,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pumpkin:mid,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56FEF64258F

On Thu, 4 Jun 2026 07:17:10 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 4 Jun 2026 at 02:06, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > Something needs to ensure that the high 32bits of the fd get masked off
> > on 64bit systems.  
> 
> That something already exists: CLASS(fd, f)(fd);
> 
> It ignores the top bits, because 'fdget()' takes an 'unsigned int'.
> 
> We have been a bit random in how we declare the system calls in
> general, and we mix 'unsigned int' and 'int' and 'unsigned long'
> pretty much randomly when it comes to file descriptor arguments to
> system calls.
> 
> fs/read_write.c in particular uses all three cases with no real logic to it all:
> 
>   SYSCALL_DEFINE3(lseek, unsigned int, fd, ..
>   SYSCALL_DEFINE3(readv, unsigned long, fd, ..
>   SYSCALL_DEFINE4(sendfile, int, out_fd, ..
> 
> but then anything that uses fdget() (through one of the helper classes
> or not) will simply not care.
> 
> Does it make sense? Is it pretty? Nope. Does it matter? Also nope.

I know it has mattered elsewhere, and is easy to get wrong because
'mostly it works'.

At least u32/u64 is reasonably sane - the called function has to ignore
the high bits (at least on x86).

Bool is another matter entirely, (IIRC from a couple of weeks ago)
gcc will assume that the low 8 bits of the parameter register are
either 0 or 1 and clang assumes that the low 32 bits are 0 or 1.
You can't even check with 'if ((u32)bool_param > 1) error()' because
the compiler 'knows' it can't be false.
It all dumps you down one of the UB 'rabbit holes'.

-- David

> 
>                   Linus


