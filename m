Return-Path: <netdev+bounces-221820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C818B5203D
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 20:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB6B5639C0
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456D627605C;
	Wed, 10 Sep 2025 18:26:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C28A26FA77;
	Wed, 10 Sep 2025 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528813; cv=none; b=sRZN+xXnm/DD4jRzm6GVSaajm31Xc9AZ28nfg7kqWMUmSr8HnDMVbqmXQ26NEMqjyoMoyzLt2od26q5cDJYUOYuHitDtSJWlb0gFL/aiOoW0Rmxy9DjeRj4oV0CHNaDQ0S1Xe3MnVIS2L+h+dN296j6I9Hy1XCnb9FX1oXpu+Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528813; c=relaxed/simple;
	bh=0Ge/+WkbgCMPVI7iSrjIo+poccgp1KWRGwl578L0+Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXpJVzs6TExxkiAQOdEVsGSywI1dsmoVoTXEC/D1R7E63tDIiMahDn+8JetIncpUJF9V3cZw1GABfxojWVCE0KhTeXOK9+72Q1ThuK/cpIXSwBccOLm3Y0oDAQwz51Tnibrs4/G2Rzo3LR8Pp7rW4jnYgbsmOk9amxWS++VR4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0787fa12e2so187624766b.2;
        Wed, 10 Sep 2025 11:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757528809; x=1758133609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSBAzl6wD76Cva3WaSt7fUWLozpvyd1a3tCiUh/Kyy0=;
        b=HTq4aDToj+53uYb2bLFcaEX2AG6Eod+UXVdVV+iCaSlokLoj9TnNu9ocDaUBnhMiMG
         x7JHkqUOuB/MqsKhR6CyacxZ4dqYiy43bG1VpZnTjqV1RIDe4mpb9QwTFnh0hzfEs5Zd
         BxDxfKgcUI1xRjJZl7tzw7tAfF22mimb3ApOi6Gxe24Jk60qdqRmmDVgNPM96wxnYMn+
         8ZJ7qwoPKBGpyZQEzuBAZnyVDivVEIn5EFz3A7AacjgsPOgb3wceW0A+XVhOKwoAmhwW
         fA1j0qVy4U09SC8x3fmepkHVeJwtxr/bNy3PWk5enfG9OL7M/oIcKQ7NiCk6TQq4TI1j
         Owhw==
X-Forwarded-Encrypted: i=1; AJvYcCVjruEQCVOvLQHK1LJf9SizBXqWtzNOg0xez6r/CkSm0lnCitFhUUYjSH6hp5eooHg2nGBZwsKAKT4d3ZE=@vger.kernel.org, AJvYcCXKMDxhyMzK1YWSBFhRp+VowkqdTqFKLJowG7HSKx1hJbyzTzTSPw/5Nch4cCDac/SMFpfvSQ68@vger.kernel.org
X-Gm-Message-State: AOJu0YyG7kGPdYcG5icMrIMpndm4E3LGOnjmIRqmrVP9H9RVQZs1kmij
	Rdp9/Q9W/EPlpYWDRG3dAep9hb4+TcbL+kEX5Z2HicUteMwFkA5d8MaZ
X-Gm-Gg: ASbGnct3hyTu5Yr9gocAqo2DqO5Z8e55yIOmu/Yes4MVM/HVs4vMI9flkltqK0xaJwA
	JmULCMJY3CHjDqfJt4FrGuCQWdYEr8GQdPM5N5Zbmbnsz+r1Cmm7h+KXipREvWJEHyqyS279Z9e
	FFCbNdHFyF+JZ8VCrO2lfEx7GbYz/h+BGDo0/pCBUOnHhywqK7kJZ6FnMQCIMcnBYYdkal+jVMI
	T5Rd8ru5yYCtNsQQ/9epolYmUWKF4o0rhcHa/Tq4SaNaSsuTxCb1y3vKEd2y4ujs6j2HBADvioe
	+Uf8kHizBoAHwvbXWz5kp57gCoW5xqP72h76db9Ez8JU+oVMHh/s2Kof1mPOn2WekLIpi/vYSj0
	GZ5aMtIE10wpn
X-Google-Smtp-Source: AGHT+IHaelywRYzfmS3mcSI3Y9aqq1KnoB/1WFY1xOOEPVUlPhva7fHs7yFHqmDm9leJZZJaLXIHow==
X-Received: by 2002:a17:906:fd8a:b0:afe:85d5:a318 with SMTP id a640c23a62f3a-b04b1666d66mr1568401066b.36.1757528808541;
        Wed, 10 Sep 2025 11:26:48 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62e9f161470sm40970a12.35.2025.09.10.11.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 11:26:48 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:26:45 -0700
From: Breno Leitao <leitao@debian.org>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Mike Galbraith <efault@gmx.de>, Simon Horman <horms@kernel.org>, kuba@kernel.org, 
	calvin@wbinvd.org, Pavel Begunkov <asml.silence@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	netdev@vger.kernel.org, boqun.feng@gmail.com, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <oc46gdpmmlly5o44obvmoatfqo5bhpgv7pabpvb6sjuqioymcg@gjsma3ghoz35>
References: <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
 <84a539f4kf.fsf@jogness.linutronix.de>
 <trqtt6vhf6gp7euwljvbbmvf76m4nrgcoi3wu3hb5higzsfyaa@udmgv5lwahn4>
 <847by65wfj.fsf@jogness.linutronix.de>
 <aMGVa5kGLQBvTRB9@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMGVa5kGLQBvTRB9@pathway.suse.cz>

On Wed, Sep 10, 2025 at 05:12:43PM +0200, Petr Mladek wrote:
> On Wed 2025-09-10 14:28:40, John Ogness wrote:

> > @pmladek: We could introduce a new console flag (NBCON_ATOMIC_UNSAFE) so
> > that the callback is only used by nbcon_atomic_flush_unsafe().
> 
> This might be an acceptable compromise. It would try to emit messages
> only at the very end of panic() as the last desperate attempt.
> 
> Just to be sure, what do you mean with unsafe?
> 
>     + taking IRQ unsafe locks?

Taking IRQ unsafe locks is the major issue we have in netconsole today.
Basically the drivers can implement IRQ unsafe locks in their
.ndo_start_xmit() callback, and in some cases those are IRQ unsafe,
which doesn't match with .write_atomic(), which expect all the inner
locks to be IRQ safe.

