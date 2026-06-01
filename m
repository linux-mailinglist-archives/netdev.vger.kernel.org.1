Return-Path: <netdev+bounces-293528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC5bJ/b4HGplUgkAu9opvQ
	(envelope-from <netdev+bounces-293528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 05:13:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4FF61922A
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 05:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9363300BC41
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 03:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3357025B09A;
	Mon,  1 Jun 2026 03:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="Gr7Xked5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D4A258EC1
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283510; cv=pass; b=u/uTtr/6UxJ0oXB85aMtDRrJRl319me2JKhFcKGh68b/iRmG+qHZWdyFEhiHuDw1pX9tShX317SXxHyVagABhUB+9bIrP69cnVjVaeE/Eu9zF6i3i6v5oGGOk/901t+3RSMdgwi23qaBPUUj8RYvxe3j+tat0Z3yz9DrJELPx2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283510; c=relaxed/simple;
	bh=3MMmkUu/YfzDJCqhb57EOJIut04O28w1bNQaD8zFkqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q62GkQPFZ+DYu/znyqyyHT91YhKUaNyNtGwMKKnyxn4zd7Ue57bd4zl6Vs8AdZAAkqTHvP/eWlNEw2r3eAJ1/uF/HuUy5wbsMqxf+ykFhlqU/V5akxjhUJIi0sf8JGJCoYTYrfyaPSq1KaooJvx+v7pOUObq0bk6M1Pe4sG4slU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=Gr7Xked5; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa66893e9fso1043161e87.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 20:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780283507; cv=none;
        d=google.com; s=arc-20240605;
        b=DvuU0eRRKPlup7S9Wq8f5SZ9yFWxMHocYnhrcGjiCTvoRJY3mIG9xAgkH4kov6z0E+
         CnHOH0QoixyvDBGtKeNEt8NiAyqYVBbHEKnaQEVLbc5DPzuKIZGEDOEzcP+XNffIvb5S
         /svfc5rZMPjlv1IkaWYgJsBvTsPGz+RXCN9louV9ePd6IC5uzrZ7oIN3ylWzYDiS822s
         40FEHWYt2ZxUnMDfI04r1kIfZlDAYBJ9A4T8+uM4xa3H+aiVkZxt5YKza/O4h90VxEiM
         gXDa1ykiknRcQjiw3CjRtyGPHbXjE4yB7QBDr6sxJM5zyQuur+FDYXQwt0h7NqjTcQus
         DFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MuDntok0/7oP3h0HaSkrbvB8I/WbSdzhW7ajx8MOkQs=;
        fh=INlhi6zymBiZKprHtOnTUiNuB/KVANpg4htbG4jnKnw=;
        b=ROTyKFBnxpc9qQKoicQVysm1WQ9r+kVN+hy6KhLLLBAok2BOvdOwRfyUZeZB73kVEM
         2gn0msILtxpo4GjUzzfxCgmOGFFJHte6mwxjg+/I1eT4Pk82hNyDbp6nPHl01AM4C3sI
         0K6x8OH/y7g77itmrBtJN5uoYteivY09SqVfE99V82zSmB7awT7wpwSw4vrJfETUMOs+
         u8CjKKyjmK/LDzqjIKYb3UKpacLqsIGDS5Tk3eQOjfAbGkf1+EdsVLqW4MMuBqUUNR91
         CFuUcsvc03+oxU/dMvreUAnJtW+YZRTeofTpaMY5g+JrBUDdNxkyqBkhgtosAzQnxMXJ
         PeeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1780283507; x=1780888307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuDntok0/7oP3h0HaSkrbvB8I/WbSdzhW7ajx8MOkQs=;
        b=Gr7Xked5yR/ormdg6QmBhuz2EBqlCzpWBE2BhBmhSBdzCgihYFsbieosgEIPjRtYD+
         ivgvFTq4CSNpUsUQfk5YijQ2OhavjVJCtbNEmPdBcxfYB4r9MB7bJxV7MMwh+DZYFFpp
         v759H90t+ReadfkRDLe8WQfybeejBFfb0QVybNh/KNGzJkgBDjsHezX+0TqVCNpe8DQi
         w26QmkJ70iQcFPCcXPGdm4trE8B6SImrK/2uvsMQS/OrXUflXJDvOdwAnd+cAtQ8Z9Ki
         vhTgzaJqws6ofLXjpCx3uynsdQnCr9TQ6rF2xezjyq2kL7Y/GZXQQvO721TkWqmtat6s
         WEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780283507; x=1780888307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MuDntok0/7oP3h0HaSkrbvB8I/WbSdzhW7ajx8MOkQs=;
        b=VX8RlFRoxhodntPPEewLp8wjFxGafIr8L7nBY7caUhvE3e1cMDAR6quDTudO0nY8St
         kjmWpVFCwXelSR/h89aTkDk5vQx5WELCPgUiKq94j3ot7xKZD32pGvXBE23aboFMlShS
         aItjfRXqIlZE5XizgvT7H8TEwqrHCjp+BoJXCLIlRJIkbVkeSlay0usPF0PjShgR68of
         sFUdF3MoYliIo7OzOeQlZZthVIbZPo3LSA26tsoCUS4IlkNmV7je1C/Rc+i7SfU7ZVyX
         8dec3qfXlaoWzXWGoZknReXna6eqdQHNbto/3crGSULot/a+6qVUH5+LAeVOQuoaZyS8
         HkAA==
X-Forwarded-Encrypted: i=1; AFNElJ8qeo8dpDEsFta9d0cLo6xpqXNXKUzt9ZSvxgCjEsEu4Ymn4klztF7hcRT7PgBd7dDPSRfZulU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN1ZnXTx34mgmAcJtJQ/Xr5br+qe2koXhRUMiSJwSlrbPJW0yf
	vrHWdI+YUzCVfdikG5wYRdvfo4hJE1MU6ysUYlF85FkyuakELtwMjhFXx1HjWd1rzdK4gv5IXjg
	F/fWa8oIc4QUmh018FsIb3KeuFCPlJntHINDOi2qg
X-Gm-Gg: Acq92OGabdEtJgJdoJOTzBffsHavNGoUc1Iej7z9ALjv3lnUZz4yC+/5Vu/6bz3gvLb
	CmLSCFs8Iqv4MVFzcHkkprxgjwMh+6SI21JPltUKI5hSLwcLEmjpoIr8s1XYmoGpXCHUEolu+U5
	8lgjYFt3auPv9dCwpT8+Iq+EPR6ahvaZtviHYnQc8fL7mVww5HwLBHQrNFQyfRTjE9HdISDn/C/
	ZV1hlfLZ/hwtIn0CC7wJaF8FrmwcT1BDrvXvGp7xnspdMbBFgUK7r5mfL/3YnH3wuwnN7iO3lyl
	E5mR9BCNBJyVZJI=
X-Received: by 2002:a05:6512:158e:b0:5aa:690c:662f with SMTP id
 2adb3069b0e04-5aa690c66e9mr1347657e87.23.1780283506595; Sun, 31 May 2026
 20:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
In-Reply-To: <20260531010107.1953702-1-safinaskar@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 31 May 2026 20:11:34 -0700
X-Gm-Features: AVHnY4JXGlP1eBaFLieX9GEu2QC7fa8YTkX6sK3P-yG-Mx-u9DLHduWiKUrWdA8
Message-ID: <CALCETrW__=8mSusayfXG7UFCfue5BGbx+vqESj1d9wqOfX4s8w@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[amacapital.net];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293528-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amacapital-net.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amacapital-net.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 9D4FF61922A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 30, 2026 at 6:03=E2=80=AFPM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> See recent discussion here:
> https://lore.kernel.org/all/20260516182126.530498-1-pfalcato@suse.de/T/#u
>
> For all these reasons I propose to make vmsplice a simple wrapper for
> preadv2/pwritev2.
>

I have no comment on the code or the history.  But I'm 100% in favor
of the solution.  vmsplice is a crappy API, and would be incredibly
complex to get the implementation right,  and it should be removed.
But it has users, and the approach of just mapping them straight to
pread/pwrite makes perfect sense.

(If anyone wants to contemplate how bad the API is, contemplate gift
mode.  Or contemplate that, if you want correct results, you need to
avoid modifying the memory until the recipient is done reading or you
need to avoid reading the memory until the writer is done writing, and
vmsplice *does not tell you when it's done*.  And there isn't even a
caller specification of whether they want to read or write.  It's ...
crap.)

--Andy

