Return-Path: <netdev+bounces-260160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBnRHjqinGnqJgQAu9opvQ
	(envelope-from <netdev+bounces-260160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:53:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C6B17BDE5
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25F24305B087
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6D336998E;
	Mon, 23 Feb 2026 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GQJGZFDA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F26D369961
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872822; cv=pass; b=oUtz8VZqkxAfSlfaoToOb0nyP8Me4BnVvIWhfCLv7tq/kfrNrEokJtecS7eSGwID8dV24yMvsWSbzIhTXtgyiIXP8Hwo6a4VD9OB135kBKvRMOl0ZONM3gh2fqSF0Zmp1aiHIs1Ibz4iNRg2N+obyAfS54Rgo2rzCPOlBa3Sfiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872822; c=relaxed/simple;
	bh=otMRDZCr0rZ3fivmEmpD4AtlC6OLYhOgJ7A4MkZtq9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRtQFs1vcbIUdteibWfj759GvVwR3O/K4HgGvBGPtFm532nEPeUAyGfQ/lkaxLHgsQv0BZYN/vYel7qTm5D7VZ+b9GvPL+L/5WPEvrPe1zLPC9b+tIMk+L/NR61FUpJRv2n0RMreGxV4HpSBn29mGyzLfU5HPQYZOMTgoGqzXy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GQJGZFDA; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1275910b930so3441325c88.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:53:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771872820; cv=none;
        d=google.com; s=arc-20240605;
        b=SbK0GIAIV2RvPufyrPB+Kk7boGXDRJgDd34jbf5+Qv/ZMPMn+Gxx6/UTbvfh4sPeII
         UhOU6d8jitLiDXBRpvNWmvAOUUdtuDW9lbFEp4RTyLuNeS6Pn8Upw/+pOLb6b36pdPr2
         zRbNnugiiKVDML9UlgG58qaLwv6y3CIBHDUq8NsPwGuCKwsknTBw5AmlCKOBQCZbBVoa
         5CWdjn2/v4RrlFi3A6cK/UQp2s5LyNSSR2v50AOF7cBJW9wOKbA0zCrqAKnoOopDRGkG
         gC8ZAGR5AJgIJu4WVWhn+w3S64lG9CJWTpcZEyfB4z574jZeMIjBhBKyhus/jgPj4j2F
         RcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QUqwR3+4SpgwjTwp/IZdpsL0ciyHWDjusfgTSeXmP4k=;
        fh=9RcnLwmzVh7g/OHnWH9tgecekdATVnlKQ3h8zx+5ljQ=;
        b=V+1ZWFOY/Uk9O+4iPsAuUA87oM6NOoJHJ6OZNJ3gM3H9CgSwZ37gwxfE/9tww+v51R
         hNLeSj40KMD8agihapRxAniph8KOshRkF8pEp3kW+QbmRa077gtEOVLdiUCzR2DHT0qO
         MlMZ2ZxjBrgrDc0DafcIT/vSljd2/rGLoUiJhFidOCjzKj3VQlK6I3ELCxLw6lMXwwcS
         nOh3yGRDpSFFeIai1O0ErvK0uaR6XW3/Dzt0HVHd60XZdQ876EkEviSlwiwM5BZunIoj
         V5Q1XZPayDD1GvvnuoKr4m6wvdpL/NH4MhYSaXkm467oXc2HXJ7VjW7UfCpqeVt506da
         SmUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771872820; x=1772477620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUqwR3+4SpgwjTwp/IZdpsL0ciyHWDjusfgTSeXmP4k=;
        b=GQJGZFDA3o5n9aimHDAxLn5N0peHeZlu81c+QpyGp0JqRLrSFBI1dZjLpvivzT0L7a
         xoUnpumf2+gXCQYsLTpMjiezza/Df0dTcGH/sB9xLGdYySDlSvw5RqtjLrW718gAi9PV
         sAekrhFtT8DKgOuMGWMWqRoWVyo9KpQrFGfKkDxs/XazH91yGZRhqC3Vu+OSYif/py7E
         i+xbdb0G827jVvV01F/r8aONZs5XCxc4oYqY0Pl54w59TClvFl+YwdhaBrBnEcJ5vHWO
         OW4c4oyuzflRsYO0gXBtjju4imABH8Se/CSLiqVwbeIjCJ1TLZkxKBnHNeoSUmH5C+nY
         Go6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771872820; x=1772477620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QUqwR3+4SpgwjTwp/IZdpsL0ciyHWDjusfgTSeXmP4k=;
        b=h4J+KJUQ+TQ6z+y/6ElJrqN8G51BY+xxIalacC7MaSAWZcD0xBm8nGuJdwspjoctDt
         059klYcuapH8TY4KxSfGxPlGVuK11VUlo35bGrpqoWHmCqXfexmILqLTE1e/yueRXv39
         E18qsWQ3hoiuEUmt5GQjxJR+ucHqZS7VYm5Digg2teS5XipPQ5DgYN1nZfg+KLR5rw2p
         ppRrrorkBx0wVazY6EQjtp6s0qzw5yZohTmtjAZOSWTBI5pW2HX9WZ/QCOORlmJ0hz4h
         1lx0aDmOhZ1TvMBgRdwUQYAYd9fL521Q3vRXmo2HszM0MEd9oRKXV7TRkrCqOqdBEq82
         z0AA==
X-Forwarded-Encrypted: i=1; AJvYcCUf1E0qXAsAJyxR/uZMa4W4ATytJJZ6nXcIXhT559kx4L/ndJg0jaBQWxc//tk41nuxu/q3lZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpAW7hi8SIBNKt/DxFaX2GKppnIqj0gClNjy5reCsFKfFPG6Gm
	W6kS+iyq1CUJXgRCzciZ7wYb879vRP1tDo3K6xW81S59brxLMNDA0n/f22OFa8JIQ0MKy2EAYRt
	pD+eosOylsNF7WPiENhoi53UfyfHtBQMERojPHGxf
X-Gm-Gg: AZuq6aLnLcG1hEH2o5fRA9rbG18CXgtgA67r2Emx86JNzCiZDW2gxft9yhaMBV+UjZF
	SgRbs/W4wo1BeNGe4QoNzsnQWm4xrosdYMraJaCAYISBc14ldBEqj2HB2aA5kDHtG/lJQgmTd+j
	EM653bvB0qoM/vg7Pe6ygsFrK05W4Fh3d+LjJJPdjuQNNSrBfEyXiMz/sgR597zYx73jUP0exBh
	PP+2ZMp794e3wQh/tkZtdAK7uzpJZMlsmC1A4qMcEXexm1q43VeJOAQlWCMpFkZp1srLQ0x5XKE
	bpGRTULhUqxnXZh2oTxm83hmhXvodLy46GJiicMVNEL/YMVM6THYMW1O2B8Ub+/1kh+G5OCGH12
	E2sS2gTY=
X-Received: by 2002:a05:7022:aa1:b0:11a:fb0a:ceca with SMTP id
 a92af1059eb24-1275fa9d3ebmr5860993c88.16.1771872819988; Mon, 23 Feb 2026
 10:53:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223100729.3761597-1-edumazet@google.com> <20260223100729.3761597-3-edumazet@google.com>
In-Reply-To: <20260223100729.3761597-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 23 Feb 2026 10:53:29 -0800
X-Gm-Features: AaiRm51jJd7Aad1nL2miSPliL9BrMdhQuIGISEdo4iKIP8MaNmmcCQlQGT5bD54
Message-ID: <CAAVpQUC2O1_u47s06w4JwYczPwTeNz4x84_T6FMjsuoERJ-Sfw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/3] tcp: move tcp_v6_send_check() to tcp_output.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-260160-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D3C6B17BDE5
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 2:07=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Move tcp_v6_send_check() so that __tcp_transmit_skb() can inline it.
>
> $ scripts/bloat-o-meter -t vmlinux.1 vmlinux.2
> add/remove: 0/0 grow/shrink: 1/0 up/down: 105/0 (105)
> Function                                     old     new   delta
> __tcp_transmit_skb                          3321    3426    +105
> Total: Before=3D25143091, After=3D25143196, chg +0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

