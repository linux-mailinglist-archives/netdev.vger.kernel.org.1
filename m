Return-Path: <netdev+bounces-294957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ufxiKuyuIGqa6gAAu9opvQ
	(envelope-from <netdev+bounces-294957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:47:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 091BD63BA5C
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:47:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Wjj7uirC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294957-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294957-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 366383010BB7
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72E44963D1;
	Wed,  3 Jun 2026 22:43:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9748C8A7
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:43:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526603; cv=none; b=AZ+Sg4zBNKHbcueeY5/QIy6qPLs+GbwxbyHYKm0mgZNHKM7nOogw5tqfXBSqarxcns3iE4I1xeTLKfV2y/VOkSWkMIza1jeEwcNpOFGjxMi5TaUztzyEqWICgkXcWNJ6Hzhdk6TdIvwkqljtFx8N/iPinwHbQNh6e4/3eCeMFE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526603; c=relaxed/simple;
	bh=bpSKopOh+lqC+IlYALKlFknmtsR6CYYa845dkB+uwqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RF2e5DhK0o9ziYBssAAtupUmpcYU2ri4irxmnpb0I8Q7/oFFZ2U/9kJaK/t1ZSGYYlcztDKdDbZh9M+OlpwPK+OVvrwCU5tEU2sXuTtLHFGXme8jEygIWLMBskfarIejRw1weSWt6hmHHVl2tcX+PG/LsYw3D+vVtx9e8ZwN4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wjj7uirC; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490afc47455so272395e9.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 15:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780526601; x=1781131401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTE44OxcHCqYjYX+doIy+3NqUmI4SQrZkrHVFocDs+M=;
        b=Wjj7uirCmuM3oEx9Vkzc5+uo+3QV5z2Tw+aUW7f5mIXlMdcg8ub1+BrDboEcF4IBgh
         UuzgCxmX0Udg7LvXiOlztwQBl0xCSU1hkEjxgt5PsrLs0S/RJhoQYriKRSqchOzbXnmM
         HBFFdzuC30b6XcHVBX7JF5MqTCLyaFZr/VdloqdIHj6exver28+uqVOtUTDN7Jt58u+5
         gGNwkNbUgN0FgT0RYFVQCtFD6lJ5vlMSmvWr7x598wn+lRmwSPTtNLj0aAkYcK8eqGKL
         +ihWY7zZ0xgV72sw/XrRzJNJR2siE6s7ng79IokAeNf1f2U67BKiyuHRAV8SrCLTD68Y
         w+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780526601; x=1781131401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTE44OxcHCqYjYX+doIy+3NqUmI4SQrZkrHVFocDs+M=;
        b=ByyEULvKLs76QxUJUdTJqexNhkFSXk/7KWTg3ZMw7mm3+IuF/nqmBHo8W+5P7hsQPJ
         5NqJmlWdSPToKtL1ArJ41n8KR/rUydrFjTyFv8tJVJCvMa8ph0MizAK7Lw+fbvRcKmSk
         0//yz5bhEEjn1wufFOhSohhzB59ri3jmqcEROOjtoB1+k+WLAXgpTo9HETUahf5Qhq3f
         96FnH1aG0R5CXQEf/botbpGtRLgqIgrndckoLn5hWoja3vg06tgYBr0KE16n1ObvQ5Sc
         xodqKIt1BJOk7CWhy1sP1bnrhwTuh57tUko1LObVq1oTJh/khzmJFM44OQ3jUORcP3fg
         /mdA==
X-Forwarded-Encrypted: i=1; AFNElJ/nWPPD8vZz6eaORYuL0InONAFUVqjXXHYebzUKHBqAmCpO3sw5ko71O4Ec8UC5orRt3j+m+B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOOY8M3cijgL5D+q6EK1eE0H5FTDwVtJqFNxOBJsaryzuc7rAM
	s04lLMpZr11QuCOvlKoANf0fRZrVyiHE27+/7XxM75gVW+Dj0zUJUHOw
X-Gm-Gg: Acq92OHuaacx2QnaXgG1A66fCDLD7SQUFxrT0p7d6oF1FpSqIR5ExlkyqLaE9iZ44zg
	NfejUbr/vKMap+yoMBVSMiiOOGKsMN1CDJfaSEDhlzJVT9ZaY47AYOvOEWTRT3TeqmIQdBJl3AC
	1LwI+1iUTUBEtAPeGRMKXQA16+zKfWyNzEbR7IQj3KdLEfMgBTsWA9LfxlH8RXZy9nMywWNNzVq
	Qx6Tij3CZMSNl6qJKQxo52YiDc2CqPSOeaEwwZntm8Jzx7gj1K8urFKgfo1pbPRDJB2mB9xbnwl
	tpnFyc0vxLsJfPDTwwDJElhF6gtCRUR6MlRJrA5fIeYLcIzK7CZbowxBME2uinnMDr7fk2IYoMW
	sLri87IPploIK2RBXwDDwQIMD6rDlXgKb9ZI4McM4tkQdwGKdi2yX9u8TA8EgcQPUCju1iwUnJK
	B1WNY6lA2+QGhdiCYLYyuNe82M9ozKfw==
X-Received: by 2002:a05:600c:a09:b0:490:688b:f9f8 with SMTP id 5b1f17b1804b1-490b5fe6672mr83368675e9.27.1780526600498;
        Wed, 03 Jun 2026 15:43:20 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490bc391aaasm29855955e9.1.2026.06.03.15.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 15:43:19 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: luto@amacapital.net
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Thu,  4 Jun 2026 01:43:11 +0300
Message-ID: <20260603224311.834796-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
References: <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294957-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,gmail.com,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:luto@amacapital.net,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amacapital.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 091BD63BA5C

Andy Lutomirski <luto@amacapital.net>:
> Maybe we should keep an API that does an optimized copy, from one fd
> to another, that can send from a file to the network with at most ONE
> cpu-side copy.  Not aiming for zero like sendfile / splice.  Aiming
> for one.

Yes, this is what my hypothetical future patch will do.

One copy from pagecache to pipe, and then network uses that buffer
directly.

> But splice_to_socket involves
> MSG_SPLACE_PAGES, which I think is a part of the mess that you
> dislike.  And the path where one does copy_splice_read and then
> splice_to_socket has to be a bit complex because of tee and (I think)
> because splice_to_socket cannot assume that the incoming data is just
> ordinary unshared buffers.

My future patch will provide new guarantee: pipe buffers are always
stable, i. e. they will not be externally-modified.

So hopefully network code will be adjusted to use this guarantee.

But pipe buffers will not be "ordinary unshared buffers".

They still may be shared with other things because of tee(2).
(But they are still stable! They will not be randomly modified!)

But network code can do "pipe_buf_try_steal" and thus ensure that
these buffers are not shared with anything else.

So, network code can be modified to use "pipe_buf_try_steal", and you
will get "ordinary unshared buffers" exactly as you want. This will
give you in total exactly one copy.

Also: as well as I understand, previously, pipe_buf_try_steal was
kind of lie. It may return true for buffers created via vmsplice with
GIFT. (I did not check this, but I think so.) I. e. pipe_buf_try_steal will
return "true" in this case, but pages are still shared! But, thanks to my
vmsplice patchset (which is already applied), this is no longer true!
So now pipe_buf_try_steal is absolutely safe to use!

Finally, we can degrade tee(2) to copy, and hopefully this will
allow us to always be sure that pipe buffers are not shared with anything.
This is possible future direction.

-- 
Askar Safin

