Return-Path: <netdev+bounces-267244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOScMwtfs2lcVgAAu9opvQ
	(envelope-from <netdev+bounces-267244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:49:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BB127BF0E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85E51316D921
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 00:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F95305968;
	Fri, 13 Mar 2026 00:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL4whyQg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA9530AAD8
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 00:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362687; cv=pass; b=NyB93oTlzdVTvAu4br6XrkPLY5bDowFYx5XbZqu0+FUE2zCAyEP3T3EFuwFIm2m5R7PuG5gE8s+uXL3NupOOFxV7atUBxFrorb0U1jP7dw3a9/7uW4kbhTkV/8tAmxT3M4XO6oSnhOxuoYC5sH2oMdvv6XXyKpjOu+6du6lpBLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362687; c=relaxed/simple;
	bh=vEE4ep3471N407vnkg/dcy+srHoLtul6c5WBfTWv6RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJwiysUAkLAr8HdLvfd8/9L14x9ZOtBBoec0vpkZdzWkfMPGA/uKyBeiQ1A4GOyak8g8JLlrjxA2RZeNx45orVL41pSsJOeo5vmpbR5IyYDXWjmZ0UxJltxdiFJHrsSy6fW6gm4zgCq/BOFGZ+7WidYzRR6Dd7x99YfKxh68pPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EL4whyQg; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38a3c62d7d2so12307281fa.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 17:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773362682; cv=none;
        d=google.com; s=arc-20240605;
        b=devrf+q3TEab1clHEYl0RbF6L6LgirbOKAJXfHIKftta+N7+p9Zu1pOiMfVxwC6kmu
         5DFc3n6UTW/+WY/wbAvx61kObn+9aTTN+lmWvzx0VMJl9yXFcsQrSC9kTOXHXzlb0yPj
         4fRPvcLVYs1j/TrQxef5gBeoRALky1hGtcmmcFqXHEFTnFTufrou75PgMSLyyIyCgOow
         wYDoj2SdNsM3ufyk1nDKGeRUs9LUuSsUIyWq58ZUXXX2bqY2frK36QLVQXGfFF7S6yCe
         0233TT+Zf0XdpAmzhSrWtQeLQ+cbSVo+uNmp6DnqZNXRoODTsPWEurDBamkUGkEMYURp
         xBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vEE4ep3471N407vnkg/dcy+srHoLtul6c5WBfTWv6RE=;
        fh=ed4O/8ZCiyAId0BwWRvmKLZt4v5N6Z/mU/J7suH7CyA=;
        b=Zz9gUyAcmrbi3XaFbiGNXMTty4qnpXytkl5/z/GPOuEW/wYegvhsX5wWGeqx39BTHq
         62CUN1n6fBdGq1mSBjCZ8onzQiM3tkEmwvelOAKphD9+nx7FQsqajwVl38UnaxBoddhX
         obJMVVaGRn2KUWc55S4ogK0qZFyG3CGQ2CtuSWZt1KcnvdvJfh8Ci+AWCkesZwBlHdCh
         MO4nriYYYcVyh6x6nvZ2QOHXIFvewv463wfVFM2p2Qrx/Slg9o0p7i3MkST3dS8If5iv
         vZ/jApLq2yEDmRASPeFVR2GVhuPlr/jPErfv915oMvUFCXBgIxU8mgXGThANPRlEhuP9
         Iq0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773362682; x=1773967482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vEE4ep3471N407vnkg/dcy+srHoLtul6c5WBfTWv6RE=;
        b=EL4whyQgfIx79t8s+q3Z/G7NOlkIkec9mqzp+SHDkWZFDJ/KSTde25MORvdBTbCgjB
         IjUxtXAj9UuOBeJc4GAY5gGaAfIlm8DidGISJazKd0yIUOAAiBIw1QGNhZmItdessXED
         z86w3WJkr7/UKYnHIM10adyjnom1oaPj6UkUDzFa/9HCbJsbVDQCuKyplk2Wu7ZyZyAf
         qFKJEGn+uTBKhsRvPoNS7LMuTvDTA695qkpRViLGJOH6GOLQTzrk5eAs1xI3uUKOrp59
         UjG9VdVPBHatf5WpVZHKegwTFuA4VjBszPn2iRwQXuMim7hKGQeovM3H9YIuYjxntOiT
         hpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773362682; x=1773967482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEE4ep3471N407vnkg/dcy+srHoLtul6c5WBfTWv6RE=;
        b=FdKf21pBcRJmLdFiVPxS+LzThSuQIAQP1bi1gt9JRNi2utNhXUEmZZVykeu/U7Xkq5
         czDA7gSUPg6FmkPWtu8FOYhYkapD2AB7uKW4GFFWISg9I1o54PoOLYBB+L2Gz7REszuM
         zPf21QKJ24V0FHH69a9FOEqMptqkr2BJPsD2+7qQ7ZzmoOxxYepeFanay6G9wZpVih6P
         scxdKVDYLh5wCNIXy0ymNx93a0RrVulINHPXPEMMLjNXIJ+Gl+6Zu/UKifbrDtX1UoJU
         TVkZNgSXSzyUDD1FB4HRVev2CyOdSuIS+d5Zgw7lFsYeu5ehy/u9aV+fnOUNvxcS2i+a
         L4tA==
X-Forwarded-Encrypted: i=1; AJvYcCWPKbPLjwAyQvqOLTQF+Or7SfuLiMaiJ2dg/IIDEH9deCSjmm6AyIV3UkkZwFNu36IoitQa3w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlA/c/7xKGqa0sgSbAEeMf1naiSpOVxuutZTg28qF9qhZGd2Rk
	d0NsPV35dxfK3bPBfABJvtq0MM4acaZHuFWoBUpbJnhMkpJ+AqpOESzwq4WALop/0npmSeL3MEZ
	Jul5Cv8o52vOTXkJIJ4jL2AG0VxtRtXU=
X-Gm-Gg: ATEYQzzUnOih37Un4+bfn2ovUsrnZeAb72eobw4wjCZlegAdCbPA0+lYkkv28O+JiqK
	7i79llto+Xn0hDq2thfNLj1I0JUrhZrHzpTKI5oKK/kARYyVRvUch/Q4drdBkCZLWIlws1SPTiR
	vpJJEUIcLI81olZ69Qcwz37EfHd4Ra4JNE93K97MPznpCBrZnuqLOG+8tTb6R8IoH6QDBBrpQTJ
	iLriQRabknJPFVJoPMKbgSAejsOb9rLJAgIVdg2kHHJJgupKsy3esBM6hEqEw5mY52BGFAfjwHb
	CRboBP0oaQ==
X-Received: by 2002:a2e:b165:0:b0:38a:523a:7fdc with SMTP id
 38308e7fff4ca-38a89815630mr2973321fa.34.1773362681777; Thu, 12 Mar 2026
 17:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310151935.33197-1-muchamadcoirulanwar@gmail.com>
 <917edd8c-cda0-4d35-8300-47205a975a81@lunn.ch> <CAO26r3S_zF4CWt1Ms3rwWqR-Rm4FCu4YRCTKVYbtJdmJEnVwQg@mail.gmail.com>
 <64ea50d9-4c7f-4c91-a686-718f0700580d@lunn.ch>
In-Reply-To: <64ea50d9-4c7f-4c91-a686-718f0700580d@lunn.ch>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Fri, 13 Mar 2026 07:44:29 +0700
X-Gm-Features: AaiRm52aNzX4g59LYjJhJCLj610l2cWD5rtEGSfp77I63CPBYNzCO18hevaT9_E
Message-ID: <CAO26r3RjhPdU1-y909xuPRw0xp6PS5O2LRZcEr7-EMB=R-siGg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: phy: rust: add experimental Davicom PHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, ojeda@kernel.org, linux@armlinux.org.uk, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267244-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchamadcoirulanwar@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lunn.ch:email]
X-Rspamd-Queue-Id: 32BB127BF0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,

On Wed, Mar 11, 2026 at 20:36 Andrew Lunn <andrew@lunn.ch> wrote:
> That is not really how Linux works. The Maintainers don't go out
> searching for hardware which should be supported. Developers come to
> us with patches.
>
> One place you might look is Openwrt. They often have drivers for
> hardware which never make it upstream to Mainline. Take such a driver,
> buy the hardware, and port it to Rust. But please make sure it is
> really a new device, not just a variant of an existing family of
> devices which already has a driver.

Thank you for the excellent pointer regarding OpenWrt. I wasn't fully
aware of how many out-of-tree drivers are maintained there out of
necessity.

I will spend the next week researching the OpenWrt source tree for
unsupported PHY chips. My goal is to find a device that strictly meets
three criteria: it is a genuinely new chip (not a variant), the
hardware is physically purchasable, and the register datasheet is
publicly available without an NDA.

If hardware availability or closed documentation proves to be a hard
blocker after this timeboxed research, I will likely pivot to other
subsystems (such as IIO or hwmon) where hardware documentation is
generally more open, to continue my Rust driver contributions.

I will drop this Davicom RFC for now. Thank you again for your time,
review, and for pointing me in the right direction. It has been
incredibly helpful.

Best regards,

Muchamad Coirul Anwar

