Return-Path: <netdev+bounces-286188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MKrNYo9/2kn3wAAu9opvQ
	(envelope-from <netdev+bounces-286188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:58:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E614FFF26
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA2CC301628C
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 13:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B48393DE8;
	Sat,  9 May 2026 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="bJgv3pZX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50C7361DD0
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778335103; cv=none; b=ujMf4X23KgqVrEJyL9L/r25lWNteZWLAQfTiBIHi7Xbm6CtKQOLzbpVx11/TIr2q3k3XFuhr7HtPRMS46l8fdXhIoWgMyQfE2vlbMJMYK7Ee/x1zzACDDg2E0PRe7tJyuJXg+QSDooHqfg52wJcCgYMoEs4Q8rxP+rvP049bhvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778335103; c=relaxed/simple;
	bh=M7Hg0+gE3eusbpps+buAnnwLX5X81d+g9BpOiYxCKiU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=noDlMHbRbz5dkEnPyHO9rO+x+cwXbW7aXtO3hJXD/kdy/5CXqN0ZeHjcIggwKqTGlTJmnrOlCttwRXiBuaPhsE+KkwyUlFhXChNUHFptea4p3qtU7K9KTfcxBQkHpDWf7SfZPVTq9+mgDxaKB7/ffS0zGKvKJ4z6GA4CXmuZaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=bJgv3pZX; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6841e6a5e51so1484026eaf.3
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778335099; x=1778939899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtcoItxJPGzLDup9Ghrw2YhEOUYqeKEI+y1BljciO94=;
        b=bJgv3pZXZB7lEb9b/zf1zhliHBonI7yU0JUmTLFVudUMhgNPkJhB4xl/SUQIeObP/u
         osR9y4nnILxk2ahMQXNrfZ5p4h2X+xXJYbKcj2rsZ/TONDpWfEkY0cls1phndT5sMLP2
         V2jPUEEZZ3rTqF2POyqFPrMhHV1o8ruZ0Dxg4DWsfwFw1Pv8woSi8xq96unnLOkic5+I
         0gjTdJ4ayfcqgoU3zg2aA26bcRC3xkAwHnBbutUElrEBM/C5uvwUyTX/QLGuXHTb8X91
         RWxw92sy8SMgLvGMZnS/csu59mzDcneJlXUSoLwrdU6BmCBycs1Es+QCwrjQu2/1vJQe
         588A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778335099; x=1778939899;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JtcoItxJPGzLDup9Ghrw2YhEOUYqeKEI+y1BljciO94=;
        b=OF2NoN/KDuocS/aZY7/N5CpOJ4lvnn611knOH7N+1aW+KXFhv7S5dEU1XlF+PjrbbT
         Wu92uHqBQGoLJFoIyVbZp0GjYtLhRtCu+OFR+R8CJ08d/gSMnJXvcSYasUwsUiTVao4R
         12QWFZTkr0ySuikRq2bELEuqDeGu2TDihuvpPfYz9QiLJLqJy+HsAXmDIAqPVkrvW/Aq
         eU0lWgpOqFeB/UNwuUP6W/GpaRFMIwhMMjyNXDPjJPJA2L9Z9LzNrd3vtoNGxuRevqOg
         DHx5Xl1UIPvJqT+2AetyqUDAM89Qohmnh+JLfxkGwbwygw2UWtXjbYJzzyk8DNBDjOWf
         AiAw==
X-Forwarded-Encrypted: i=1; AFNElJ8REHUgbWNuYribpmNaRUPHWGWw+gR0E20X01jKh/NoX33lLIhKnMP67Ay1U3nnNEoxm/7psRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynxmAkgjSPuOpsBEwJPhqYAulkQ8YJXfCTUOyH/13LzpU7D8i6
	rOSrYXp4Xm/LI/ELhe6bfcms3upmTOGrmtMugn1syVLStJRgzZs+80r7G7qWTy3b0GXBr9JuGuH
	PLYmo
X-Gm-Gg: Acq92OFcFAIiGs/aI+Jh6KsS/PESf3Eus7mzrK/slpRhKCu080zzGM0VU7wij8Np0DY
	CrogSrhzdfpjqoqmmsfV6CQ1W4X2YwNJ3wll280lq6OWYbrZnHysFivlgJXW/0af3MvX9PUSbJO
	wJqhkdwiGQAmladSiBhA7Fo7U33hVz6wfASeVUGkPNUnky6yTeOHjdI6k1i2gaDQ/rHGFBpXKdf
	sd6Y7zLYil9MN0T+/bsHM2ZLvPeYB7Mg++UqcKuxq4MJ3RehOPh+bPxWyxe+RWoHpueL5lZ8B+k
	Xbtmx312WB3p7a2l7Srdxc9Q+Q/xbrM3qZ96VzdKb5OftZeK4sKMk47RLtwxGn6jyyeBKMYFf2g
	PYtGSPEiAUWhsXql4DoNXyJwNtFqC8HO5n3N+ZO5sR0yHvz9QqdCZYfFreyPgf/MzxlSJjpKtFC
	97n1SmXPekAk1yOFa5YuguY7FwARanwQcJYPn/wgmeL04gPqlSqo/M/dY5XLxG0GYhXcU9kSkUY
	22kmxI7w7MHgoQ=
X-Received: by 2002:a4a:ee12:0:b0:694:8646:9933 with SMTP id 006d021491bc7-69998c9f9f4mr9127230eaf.9.1778335099502;
        Sat, 09 May 2026 06:58:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43556bbebe6sm4395297fac.0.2026.05.09.06.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 06:58:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
In-Reply-To: <20260506124541.1951772-1-christoph.boehmwalder@linbit.com>
References: <20260506124541.1951772-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH v3 0/2] drbd: switch from genl_magic to YNL
Message-Id: <177833509787.32015.11244289527797673484.b4-ty@b4>
Date: Sat, 09 May 2026 07:58:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 90E614FFF26
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286188-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linbit.com,vger.kernel.org,linbit.com,gmail.com,google.com,kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Wed, 06 May 2026 14:45:39 +0200, Christoph Böhmwalder wrote:
> DRBD's genetlink interface was defined using a custom multi-include
> macro system, genl_magic_{func,struct}.h. This system generated struct
> definitions, netlink policies, serialization functions and more
> from a single "magic" header.
> It never really caught on; DRBD is its only user, its internal macro
> jungle is next to impossible to understand, and even harder to debug.
> 
> [...]

Applied, thanks!

[1/2] drbd: move UAPI headers to include/uapi/linux/
      (no commit info)
[2/2] drbd: replace genl_magic with explicit netlink serialization
      (no commit info)

Best regards,
-- 
Jens Axboe




