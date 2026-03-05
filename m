Return-Path: <netdev+bounces-264111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEWZBj/WqGnpxgAAu9opvQ
	(envelope-from <netdev+bounces-264111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:02:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8BA209ABE
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD96F301463E
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 01:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69AD239E9B;
	Thu,  5 Mar 2026 01:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYTaO5+i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6840B203710
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 01:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772672572; cv=none; b=HHptH3DKAPygphtvh7vlq4Pl+ZEtINlX7g6lUwvmVRmHOXRv86HRIeiuzW+jANwIoNIrJTL46PmuzfX3MK769/BOSAcryfF3NFfS6WSwvqPiMYoGxgh2x6ARpjXAqgbBJXleFh58gksn9tReF3ufQwiWbuHPGx8jjXSYvQwxZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772672572; c=relaxed/simple;
	bh=01T1wpQkKyfgQWiIuWVBGWyiPJ4zwU2gIDr8R+TyrpI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BvRNWqxqdwd1RK93p+7DwkC+sMOwpA/Gd9fMsDv4DVE9ujmBU2MIXILrNgAuqsMA1UyF3YBFZh5hUVbv8FLq6aiGZxm68LMNbp/8RFsqW8zyEM5ee2hAb85JD1b9u59eyKYHIff51c6zS1f2u5TKoNWCrF9eLwcGriMxZG35780=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYTaO5+i; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7986a347d4bso73745597b3.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 17:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772672570; x=1773277370; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=01T1wpQkKyfgQWiIuWVBGWyiPJ4zwU2gIDr8R+TyrpI=;
        b=OYTaO5+iFUWg7yD0W51E5GirWq+yKdvOfk0DMLiIzwBjyppKm++Wmo9dsADQfOugkF
         pFfILtsfJkEI8gGfKovfpEFPTZn7ebzzSFerNzqfKwhTwUnbjbzmJ1z+slTV+D6FHrvp
         zGKfkKBihXFpv6jrks+DVMz5dWJVRgKu4WYdEte71uyVybEc2U0sWwLzPGP3jxKY48aM
         ctJq4WN6ABbmozQ3XQnyJzMvPD/0uBtRbmN52RyezWLF/9KAKbDZLCOWoImDgluZYo4d
         cJVXWCU4b0h32nLv5K1s5V770azGzQAkgvLyN2+lZ+eFKjRaRbpGQ0wf9OKdSwBf86z6
         YKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772672570; x=1773277370;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01T1wpQkKyfgQWiIuWVBGWyiPJ4zwU2gIDr8R+TyrpI=;
        b=OvE0+AypQ+/0Ke0/rxUFlBuIujYnizF4UsZESzVs6+cG205vPYb7JyOiLkIE0V8Uxj
         JuNQZ3SeZnBZcyx01Hl3QgDwwaUNRfkj0KaEXeEpa9fT1RbZpIvjULOi2ueLsq1bEQk5
         TVOh65beh+yP4AqWpQuWAj6eClz4Cluk1HojDqOuy9Hsf635jdadG9pIDd81sPY5Hhy4
         E6kJ2aDe4P73IbJR9xbmdzylqjJH0ppA6esgkoNRcm0oHSv71uGztbvJKpy3NV1goB8/
         e2l5oJfcden0Mldo4oflmfkRHzEzad08N2sLGsPCWWW6hN0ni4Aq+M6Gkt0poXIWBi3N
         eTvA==
X-Forwarded-Encrypted: i=1; AJvYcCXceTeW12/JD2wMaLHP7DkhjT/zL2e2tijxxIuam+QmW9n7m0/Fzw0lmCdE13+KZshBD/j4jrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzejRkQS50HFUzM+Exm6JfrPqVJiGe4wOtbrOxp8LEB+c+0x3ko
	hCKQzNMtfdKQLciH5q0TZeUdwK4n7Ut54dzmY4xbAuLNM7MRwEQ8SSu2
X-Gm-Gg: ATEYQzx+EMNG+3c4S87QOJ+JvkGdeoxsFQzNoncQkGOvcMfmSuth8hstXv4m7SzEC8G
	CtJCWsBVo2MfAqC4XNYz0yn3OpUTaKbSalZbe+xaVn1+pJtvvkeYj+2X9egHqmr90Bn7iDKv9Jv
	ItdtT9IrSTCBVGERLgsRgI54cD8XiGL1aiA+TAj5cGODXHNLZHp9k8qADYp54+J7Y1OlCMSbE27
	lJxKf6YMfyz0EsYwe5JGVQtudH46tIeLmZCpJ6yAHfwfcRSXKUBC/Cm21o5lIU7xIS4rqQu49MH
	Eirr/CY2ncc8kQJal0wDfrS51oiTatZyeaxXe8JDoQ7F5Ph72XbHhE+6Eednork0BdIGFYJsIlJ
	KyERAe+COis7QZw01tZgFQRQtcMr+j8PMqmjjbx/uDf2XneNZorn3D5i16NHA4s2xdfxxulfEr0
	j2unXe/jQPyGyjnGVF1roeFW0EuNMsP6sgcigBPFDtMlO1iQk=
X-Received: by 2002:a05:690c:38b:b0:796:4b03:7390 with SMTP id 00721157ae682-798c6c01c6emr34466007b3.27.1772672570468;
        Wed, 04 Mar 2026 17:02:50 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798d2089aa8sm1759957b3.23.2026.03.04.17.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:02:49 -0800 (PST)
Date: Wed, 4 Mar 2026 17:02:48 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sgarzare@redhat.com, netdev@vger.kernel.org,
	mkutsevol@meta.com, thevlad@meta.com, christinewang@meta.com
Subject: Stable backport request: vsock namespace support for 6.18.y
Message-ID: <aajWMBoSgXafmw8b@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: AE8BA209ABE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264111-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hey all,

Would the stable maintainers possibly consider backporting the following
commits to 6.18.y? They add network namespace support to AF_VSOCK, which
addresses a security concern from our users in production.

eafb64f40ca49c79f0769aab25d0fae5c9d3becb vsock: add netns to vsock core
a6ae12a599e0f16bc01a38bcfe8d0278a26b5ee0 virtio: set skb owner of virtio_transport_reset_no_sock() reply
a69686327e42912e87d1f4be23f54ce1eae4dbd2 vsock: add netns support to virtio transports
9dd391493a727464e9a03cfff9356c8e10b8da0b vsock: fix child netns mode initialization
6a997f38bdf822d4c5cc10b445ff1cb26872580a vsock: prevent child netns mode switch from local to global
a07c33c6f2fc693bf9c67514fcc15d9d417f390d vsock: document namespace mode sysctls

All commits are in v7.0-rc1 via net-next.

The intention of vsock is to be used more-or-less as a VM-to-host serial
with free port-based multiplexing. It may be used very early in system
startup, so it is often used as the communication medium between VM
agents and host controllers. The security concern is that any workload
on the host can bind to a vsock port and intercept connections intended
for a different VM's controller / control plane. For sensitive VMs, this
presents a risk. The above patch series mitigates that risk by teaching
VSOCK to respect namespaces, and so allowing the system to restrict
applications that may access the VM's vsock (by use of namespace
isolation).

The feature is opt-in via a per-netns sysctl (vsock.child_ns_mode),
defaulting to "global" which preserves existing behavior exactly.

I realize this may be a long-shot/big ask, as these patches definitely
fall outside of the 100-line diff limit and it is a very new security
feature for vsock.

Thanks,
Bobby

