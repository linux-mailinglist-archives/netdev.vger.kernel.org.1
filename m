Return-Path: <netdev+bounces-296672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n47uCYkDJ2pupwIAu9opvQ
	(envelope-from <netdev+bounces-296672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:01:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C106597E2
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:01:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="bkr/iCD/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296672-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296672-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E046B33C27DB
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DD73D564B;
	Mon,  8 Jun 2026 17:13:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08C73D4132
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 17:13:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938785; cv=none; b=lFcRDbh6Ponj8aNGfdZfTL5RdceEjclGv648efkj+i7JGbeX1GLdkvW3p0EHCFQimtT3u033m6U06p1o5z5M45/1DpIhqJ0qdp1gE0SLnv/uc+sujPiPGfoLgqn7dEkhOvt68zmOTZj+IOlXHDRlI6oFURSDZql2ypu4vkW3aRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938785; c=relaxed/simple;
	bh=G2yTdmM+jxM6q4Rp8QMqnUV346H3bZaSNYYTm8fmrQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RN0zBX+eSM2Qvg/p2H/iMR2O+W1gUcGGn4zq2w6tq0vMTDiR6/9ZeokL7JlEBn56m1xc3k6mBI3irFyU9ADcYzDnPS1JL3fTZaAqFyLEQA21PqAA0yQp0W3GrTX0dE4BGU300Tq9/xaDXsdWh485q+IFzQjYN4JFIzEJYs5H/hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkr/iCD/; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490a76757e5so30082925e9.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780938783; x=1781543583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUpt/EToVTToJvd7YASG+3OoKZxNxbXoqptfVbb/HeE=;
        b=bkr/iCD/AbT5kMfEEc02CxM786jsvA1Nz2/jJdbfvfMrQ2dg+mLcw9Lx7YaIUlf70Z
         oHzpkCp/I00uyPDcsN7gGv8zR0egau+UlSNTBB5evHFxNwJKTCaWhUdkA783i+zVThN3
         boNLlLu3i95jNdk8y/cTguC30whCTSM2VlZBxKo9/9Wv5Iy20tUP0/Dd86Tq3ewyzBKC
         29BzOzJSHw9hRVytFIKluyZIXgOwu+LARdY/j6eATaTFMtm7Nc0S5rIgZYAEwOSvXrey
         FoJWK6th6hPMPHeRw1WjBpCEKZSVlTOD9jvumo2VeQzLyqc4WNmb7R+Mv006lyRItyDL
         xktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780938783; x=1781543583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AUpt/EToVTToJvd7YASG+3OoKZxNxbXoqptfVbb/HeE=;
        b=nBtZLcuPNsXCENydubdBixYImPLblj5qGmO4m5+CHyth0oPysdhjmTSYh5jFnNYOT+
         yTwwze04OuRvnSGY60N2vVdRuMKDnLEUITlL5Sz7gMzMIYohf3WbzoBkinlstUiS6CbM
         rH1pBy1G7pEZpF6hvlxrrK/vEOjicc5Sd8CpwDQ9nxtaZAVbNQaf20qGzRmLnI4xTd0i
         5JUTHe/VAs52FqiMOJokh02SafIWEoJdfDK+ORXBsqYEzWbiuFzFMypu7PfpUKqBh2sR
         4jr9HwY/g0lBo9rhywIp+NUwjkvUfnH1vYoXCpWRqvQ1noLIfjYGbj60/CIe37FjELoq
         xeWw==
X-Forwarded-Encrypted: i=1; AFNElJ9tYz68nNfcaQKPkwmppG/vxrduL5L+BWOldZEONhraUnVlFb/hTUsOEO/2fAsyS8IE9GzaQNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/4qORG0G6sNW3igxFPfR9MZ8cXSK/i1dGNeRdL7d9fLP7dYi
	7nkvfHM3Q4gFACRciXMwrDNJ5/zKh4yTX4pQWty0d0+bH6Cg/ZhT+pA2
X-Gm-Gg: Acq92OG5W8PmSGseTQ0W4Rw2AS75Xv0+279y+zzkWwAf4nVM/mw2JC/RtT79Ykbc2vM
	PutIX4nZceOPdegPajm0upRgtDHzlBfzppJI/8XSV39WGLPUHbVSJMCpgSH5vDJYfg5fE1LNLS9
	/wxErsRF2wO5PrcNRrIt2U3CZbmzSEw8QVM8Lv6wPvtYUgX0W1MHaocjWuievJ5QYiIUlMJouX2
	Yz7eQvjNbPcxrKsyU/0lc6lc+UsHGuBLdlQWPPqaPLLFAJTQcuz/PcdRxyD/lwgdJ0OWfe/GaMm
	5ZUIVeAfjToP2wa/CY8uuTUOpRV+JOFsei+uXdJg11jBMJRA5+4fy5U+LEZZNprtglrXPj613EX
	yx7+kkVdQ6rFYOVrSxM5jHgMzdkkVaSRgXXqKlnQePrYsboXAd400+yWuM2dOY9as5aOI4du5BN
	1uZxrX72CfmohQDe37wsMuk1Ox+DMtlWdVifkZCIoU
X-Received: by 2002:a05:600c:458a:b0:490:389:7644 with SMTP id 5b1f17b1804b1-490c25fbd78mr244360025e9.17.1780938782731;
        Mon, 08 Jun 2026 10:13:02 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f351ac0sm97432933f8f.27.2026.06.08.10.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 10:13:02 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: andrea.cervesato@suse.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	collin.funk1@gmail.com,
	david.laight.linux@gmail.com,
	david@kernel.org,
	dhowells@redhat.com,
	fuse-devel@lists.linux.dev,
	hch@infradead.org,
	jack@suse.cz,
	joannelkoong@gmail.com,
	kernel@infinite-source.de,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ltp@lists.linux.it,
	luto@amacapital.net,
	metze@samba.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	rostedt@goodmis.org,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	w@1wt.eu,
	willy@infradead.org
Subject: Re: [LTP] [PATCH 0/5] vmsplice: fix some problems in my previous vmsplice patchset
Date: Mon,  8 Jun 2026 20:12:31 +0300
Message-ID: <20260608171231.1480447-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6a26aa28.283787d8.1f1282.ba36@mx.google.com>
References: <6a26aa28.283787d8.1f1282.ba36@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296672-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,kernel.org,gmail.com,redhat.com,lists.linux.dev,infradead.org,suse.cz,infinite-source.de,vger.kernel.org,kvack.org,lists.linux.it,amacapital.net,samba.org,szeredi.hu,suse.de,goodmis.org,zeniv.linux.org.uk,1wt.eu];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrea.cervesato@suse.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:collin.funk1@gmail.com,m:david.laight.linux@gmail.com,m:david@kernel.org,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:joannelkoong@gmail.com,m:kernel@infinite-source.de,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ltp@lists.linux.it,m:luto@amacapital.net,m:metze@samba.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:rostedt@goodmis.org,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:viro@zeniv.linux.org.uk,m:w@1wt.eu,m:willy@infradead.org,m:collinfunk1@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76C106597E2

"Andrea Cervesato" <andrea.cervesato@suse.com>:
> Hi Askar,
> 
> the patch-set doesn't apply:

This is patchset for Linux kernel.
(It is expected it will fix some failing LTP tests, among other things.)

-- 
Askar Safin

