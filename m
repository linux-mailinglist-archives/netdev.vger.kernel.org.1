Return-Path: <netdev+bounces-291292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH1KFOEtFGpYKgcAu9opvQ
	(envelope-from <netdev+bounces-291292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:09:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E32735C9AEE
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58C1830058F6
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3D837E2EE;
	Mon, 25 May 2026 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAj5P0AN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8330837D136
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707356; cv=none; b=SS/g8dduJOL4VonZUPF4hFtrr3wXBygVhmzI3iwul2XKXSk98hsxrb+mWdMroC9ECndrkvl5R7xYOe9DOm+IO3AcH0Gtrrj+g9fhZrlOMUz2RoKXr+cXZiN+3iEyG+pODsCuu4njvG5SOrHE6MBqV+r0s3qXEBKowSVGm5/TQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707356; c=relaxed/simple;
	bh=g4o1dpIg6Wql0HWF21Ncd1Zu05FLlgYRwwP4h4IKfdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbULazY/cqCWVnwDlFVSPokBNovCNod7TSWtOMOWsY/I4jjn3IYwdj8nzSCaaQ5Zj6Qa/Ao+DpEXYFf4Gdvfkl7ghjh3vBqKwp/vl/QfX/6QWdzxUnBZN/JukhB6c3VMWbT5yblgCq5lWg2GVNqfS/FCm1u6PVc/nXKkstP950o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAj5P0AN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479DF1F0155E
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 11:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779707351;
	bh=Ti8F6+ipYsvuGrD4TuxYp5AKRgNH5B7oF+X/muBpZZ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PAj5P0ANFYqOyNCn/pCy94Jz70WdiPUDbOsUbaW4Tu3qfJRwT+v/ui0DsQaeU5/nZ
	 nVVVXLEh/b/nttcnz6IsPeR7PdLXP4pkbWEV5EKykUxlZFQAYUipgr0FzbAq9IYKs0
	 19rLyQZ+OJrzwH9bICfx0PM5hD1PvxI6j20+WPwEwy7+ZeG4PFR2u8ovmyWTOIIeVj
	 CXeTKcG8etsXXWeNA+YdZiYjHwMcOWzl0Cnw3QrevxLDmLAeGRmKepqkboJvoMz5em
	 K2Mg2/Qmk+LSC4qIlwLokdcJbIrGN3/VFo2XI+Cvjj/ldZNHfr/jir55z7xVRnWldJ
	 5aYdqrVfl3jig==
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-6324ee4040cso3229532137.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 04:09:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9InWA9OdjkMgU8POCxm5AmXmmOhbMovyWG10+2jI+nEUWsJ6kExy6YzNWS8Oj+orw8WiCeS6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdSGTQzy7I3lce1mwUJtxwjxHS8tGN2E8O15MwxKgwKGoeeYro
	N+XEGsS1/lEmA9Doe9TFEXNUCvp8XmY3HwbTW3sA2iJ+wf5/chxSqt5yHuBMnBDyvsvqU1mmiBt
	CE4WSAbGZVHImmhd+xjoP5lZB3l/L7tE=
X-Received: by 2002:a05:6102:5ccb:b0:634:5339:33bf with SMTP id
 ada2fe7eead31-67c7d977844mr6305680137.18.1779707350376; Mon, 25 May 2026
 04:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522113225.241337-1-bjorn@kernel.org> <20260522070515.044d7d97@kernel.org>
In-Reply-To: <20260522070515.044d7d97@kernel.org>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Mon, 25 May 2026 13:08:59 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNjE8e1Lj1yDEPYXk_KPspjN166rDbHon+zwiJb1rPqSrA@mail.gmail.com>
X-Gm-Features: AVHnY4JLYHa3GAzQN4bj9M_WDpfipku0Hpu51IZUTpE6XJB_0rmfNrcwqqfjO5Q
Message-ID: <CAJ+HfNjE8e1Lj1yDEPYXk_KPspjN166rDbHon+zwiJb1rPqSrA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] fbnic: Support larger io_uring zcrx buffers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
	Mohsin Bashir <mohsin.bashr@gmail.com>, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[fb.com,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,intel.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-291292-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E32735C9AEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hey!

On Fri, 22 May 2026 at 16:05, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 22 May 2026 13:32:19 +0200 Bj=C3=B6rn T=C3=B6pel wrote:
> >  drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  29 +--
> >  .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |   5 +-
> >  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 168 ++++++++++++++----
> >  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   6 +
> >  .../selftests/drivers/net/hw/iou-zcrx.c       |  28 ++-
> >  5 files changed, 176 insertions(+), 60 deletions(-)
>
> Hm. What's merging the frags? the hw will serve them back to us in 4kB
> chunks. Frankly the iou zc hurts me less that the fact that we run
> out of nr_frags in GRO :(

Thanks for taking a look, Jakub!

The driver relies on the generic XDP frag coalescing
(xdp_buff_add_frag()). So, adjacent 4K completions are extended into
the same frag. IOW, GRO should see coalesced skb frab, rather than one
graf per HW BDQ frag

I'll address all the other comments in the next rev!


Bj=C3=B6rn

