Return-Path: <netdev+bounces-263924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIRrLRpdqGmZtgAAu9opvQ
	(envelope-from <netdev+bounces-263924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:26:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBF4204345
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7A913006178
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 16:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED4F365A0F;
	Wed,  4 Mar 2026 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3MioEWH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC234DB79
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772641552; cv=none; b=d/3eQ+2nz9b8PcwD1y7dpAiMlQydc6ayIgwudVv8UqRUj+aJZG44jzor1GKBbyBMqS5hmxdjxOEaltEPcxF605s0Q0eMd5Yy3FsUOJqTYSxLDG989gJECVr5q7SryeYDUTOu50FBTCKd9turv/vfsNltdy6KPcwKXtkUNJxjWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772641552; c=relaxed/simple;
	bh=CgXj9Qujm5Mk8E7ObsRSKFPcojwrTPtAnj4q/sYm/Rw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WmO0B1hoNfcE8xa0/G7PyREIHZCEqPlu0aBJ8S2xu3T8CWGz6/W0ZgKf3PXMZMQqLhYQ/m1Cg1/Ke+40/1OvqH6F6MddZlMn7lCYKCwcpz9PLEH+mdzd6jCG8909G8k5rI85uO05zzK5aUe7pZgmyalrwrQSh0Ak/UT1hbGJ4Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3MioEWH; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-798578e2918so65682157b3.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 08:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772641550; x=1773246350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDMrZMXgcltiopzyN+7A+ZMtPGsdEkDU2ngRM+C0IHs=;
        b=f3MioEWHhVzf20h/LaZIm6q7wSvdw5fH0JP8uLv2gv9JFsbRGnxPFbSKAVRQEDPsAc
         e9fXKUfaEBbQUoiUE4hKewuZrRigngOx/IqdsYtKi1mQX0D8lpE0284ETGue5c+hDtJ2
         E5Gtx+84lhFztPq6QOvrcQ2eu43lgqcUEOY9DEPBqlwmcO7VJeP/4vvWVVfgbgT8SSs0
         mNSIVyeShdObMb/fAlm/bej/6RUNtZkuuaQVawzBfBit894nCO3OAkm2m2093QZy0jDf
         QefZ9TsJkW/y0nPnCQrNcP0AgkDnwc1tRzyC/on4XJgxyHVop/YIxcO+lxhJJSGiQYxa
         JosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772641550; x=1773246350;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gDMrZMXgcltiopzyN+7A+ZMtPGsdEkDU2ngRM+C0IHs=;
        b=rtAoJkcm4HRSq0OtHZFZfIqbd9cIpE/97JipJdfr+NXCvI9xIk6oGS1G+np03LdGDY
         em24qFKsLRSHGs59CCtSggPXz/AjMJVKz1tLOHQ6wzSvli7ihaknNCQIpXQt/EFmYRVq
         HgrcVnV9h/rVzX0EmvzGdZcddwR6d42MWoC626rkDwQjU6HFwf5v+eWn18Sz6b0I/Bh0
         Z5/C9ZBQ2U/4sfD2uCoZSVew2MKVk2/g5HExrvl1siv7L9Kmcg7cHd6qxL8fBDNwHFf+
         xO+bkVz2ebdqb65Nol1Y2p3DEvLnjlVxJ/wkHosS0hIseheI3quzLV73hI2mjFZKWOd/
         2qFg==
X-Forwarded-Encrypted: i=1; AJvYcCXHyhLs4xV4/gMhL2dljmV4Bw+4/ffHCKOW21o702cnv82B72bvmpQq8jNdSQ2KDCOSuJk9bPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNsOf8Kf8LCr3fFsYxC6BQm/94zfG8Pgz3fYW5x8Cc0tyhrbM
	0GpAnk76Z5qb7c0bHc38DdGgmvfSQzYL3lgRKsw1h+KxvU0qhbVGLmJf
X-Gm-Gg: ATEYQzz/8wQqo17nViimN+Bb+pFiOsicQOYCdLeledjXbvo/NbXObc0aoLrI5ikDmEA
	F5fxaCGdot+AHms9Qof8fKEFA+VGiXq1ll4+5qqqhwNviH0LrKelB3XJ1GLGWtQgqrHlByiufYu
	+3hpEPu/gWkZeyeBa0dmtvKnTZe1SAbjdZLCXc7jX6IjHhSwx8sqbosjMUGgjKOFriDga/07//X
	EjlERsLNe16xdoZ0BY7t6W7WkyiuCE/gUvq/lGrssHdlxxrFfo+L8TCfeyuR1VfP4raJvWd/G7e
	LZ4Blyc6o0BOefi358jjKYnG/e5un/walrPvVb/aTZ2aUH72+llSdhQ85OmDxwmzTmDQJdC0mq4
	hsCf2oJifRZtTYVHP9/Scl6B4gUk3B5Y66mdi237kO2uCxVudRH1KAj8EzhAgUic4uIPYyzzIBK
	YZ/FqZSUDhaM1ZPd27/6iqoW6K6klv6vC8+9CCiY6T9lsPiam5l2pkI+5+fX4lN8ToDVTsLhc=
X-Received: by 2002:a05:690c:45c1:b0:798:980f:6706 with SMTP id 00721157ae682-798c6c01630mr20906417b3.22.1772641549748;
        Wed, 04 Mar 2026 08:25:49 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79876c40439sm78064377b3.37.2026.03.04.08.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:25:49 -0800 (PST)
Date: Wed, 04 Mar 2026 11:25:48 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wei Wang <weibunny@fb.com>, 
 netdev@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Wei <dw@davidwei.uk>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weibunny@fb.com>
Message-ID: <willemdebruijn.kernel.2c99d96277de8@gmail.com>
In-Reply-To: <20260304000050.3366381-6-weibunny@fb.com>
References: <20260304000050.3366381-1-weibunny@fb.com>
 <20260304000050.3366381-6-weibunny@fb.com>
Subject: Re: [PATCH v2 net-next 5/9] psp: add unprivileged version of
 psp_device_get_locked
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5BBF4204345
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263924-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.990];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Wei Wang wrote:
> Add a place holder function called psp_device_get_locked_unpriv() which
> will be used for commands that are unprivileged and are used for
> exisiting commands like dev-dump, dev-get, rx-assoc, tx-assoc.
> Commands including dev-add/delete/change-ntf, key-rotate would keep
> using the privileged version.
> 
> Following commit will be implementing the unprivileged version check.

Can you define what unprivileged means concretely in this context.

From the follow-on patch, it seems to only affect
psp_dev_check_access, where it additionally allows some operations
from other netns if that netns has an associated device.

Can you give a concise reason for which operations to allow from
another netns and which to deny. Also as forward looking heuristic for
when new operations may be added.

Btw minor typo in first sentence of next commit: associcate.

