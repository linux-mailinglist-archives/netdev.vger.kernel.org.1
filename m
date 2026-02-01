Return-Path: <netdev+bounces-255581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qE2iKy0Hf2nZiQIAu9opvQ
	(envelope-from <netdev+bounces-255581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 08:56:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1455DC529A
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 08:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B17283007C9E
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194872FC02F;
	Sun,  1 Feb 2026 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJfGhbWT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A562F39D7
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769932585; cv=pass; b=olxeRGHkzSyXlFwSuzFBXVapfjMx5dM0g9LT7jt3UYfwm4tqiWjkDqqg8xB9sI91eJ38VH9WuRNyJxb3zaFd1NW6xdDwEJdPvfwmB3s3kAWM9P0S3cedlO+BGSKKWcJdqB+u98mBlsxMtplf6Y76Cqk1CsX+QKno7fzQfi8PsH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769932585; c=relaxed/simple;
	bh=145TvTNNWdctPMBK2Z/2IfyWpi71vtE0JJpY3YZjVWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBweC2mFzfdQmAwZZXFoGdDm0Sl0vwoJojKvn9Uc1NUcEAqfN6obWo4trpY+t/Ag69x7ZCfM1golnEIQeRxVjPsJr06aDJKPQ2yHNSRnMocqcWOAzaIXEAGGvJpwDK9gejuxYSy0iOeU4vONvJbhs+aUQvlWJVRuzxfo3qsp4dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DJfGhbWT; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c655e0ee70so382723285a.3
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 23:56:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769932578; cv=none;
        d=google.com; s=arc-20240605;
        b=M7qNEoAZtKGrOk+NwyJy1vyyq+bv7aXtPD0PpJXMgcOtdnpIyU5MykxMyrCNoi4LnJ
         5psWJSXcsYxaxNHArt2d1ydkcHxsZ7UmS/g+UrdnNAMpnXR8g+ZAkGfubQ1OzDe+6oYj
         sh7EmHhko9/3vd6DomcqzPNBnm5rhGB0xyCLxeGuUg8wCIT2RI6VPh53VVHAmDMrb/t1
         5PzbDpyKBYkboQaFQty7scl0MJdPx0vnZNfzqEMPA0ToqV67UOncW/FDEUDroltAnqRG
         bbWcSjL0GrkivNV1EQYPsGfphze2ze7fgWlmvFEGVEXIRn6/V3ZUV9t40G0rH0nC+/IZ
         f5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=145TvTNNWdctPMBK2Z/2IfyWpi71vtE0JJpY3YZjVWk=;
        fh=INbq1eGE3EuPEbyKl2E/p8kzK2lSmqdJ6qMGg/q2W+0=;
        b=ff9vRx0DVHiResnq+ciDrx8A4AJ5wHRa31Q/K37SsZqaL7D1MU4sucgFqlv9PZwmbP
         pWRkM5Yg8FcceTfhcxot3DkP2Bik0hssDhqCVE/9fHiZ+h8557tgsE/xTVA2OW+ZS+8/
         LszivpKYjDKoWuPyexQF+QBosq7+OJ86nE8iZDxGtaGuZEaEnpVncce6CvtfI5iYPpOi
         VluOYSUG9VaJ8w4z02Qj3uKcd1zFE+fSU1JfXUDwn0mWVNd+Q7nS+PEPIBga/T1qw+dg
         D8FhDT4YG7tUi3QMbOvFV7sXfYeXhpnEscZLvh6quhN5UXgPscl80M5ogtHdw1mc8gkS
         XDaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769932578; x=1770537378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=145TvTNNWdctPMBK2Z/2IfyWpi71vtE0JJpY3YZjVWk=;
        b=DJfGhbWT29ZbaqslL56qglK6hRxdQk6q3vk/WR36Aus5GYKQmMMzvJFW208aJVZ4/e
         4eb4Ky8miEy0LAxmJ2ULxfTQxHU3s6mjEr8wUFcGcPJ7yzt2pS5+Tq/e6Y51zc5Dkm9a
         PDg7UfTHl3/KJSjdXyWGktIilvv2CBMXHgwPD3GDijrUPVoBWcVQGL+r0P1bW1wMaKcJ
         UI7mAbqMolJYMSMFJ9ooSCMQ+s+6t8fG5fluao5jkLTojljbqx8VvbNyuesXlNcuM65E
         aYibmSOXmyjT1kB7JS6ijyP0fSZux2fQ0bi1c8nBkN+YJnuNruV5hepWk0VwHeQUjPY9
         guRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769932578; x=1770537378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=145TvTNNWdctPMBK2Z/2IfyWpi71vtE0JJpY3YZjVWk=;
        b=juFjXTknBAx+AXY6NDOi28DIfS19pNMmoET9umrIcxbBiTpd1m/VXQpHsD13OyaLw0
         fkDx80443zBLurln496CTeYzOLn7HteZA0uYeI6tFAH18k7n51Y5p4qkRJEkCb85hjxm
         PU2B07ffoMJIjxSAd8EyIpEIg9e8h92Z6CEf0LzkcLC2/2Na+OpvE2h/Jbq3fxbdIIJG
         5ycv58XsmxIYSpy9uda0G4THOsSa7ThMhxo+kytzoAlHeMmuj/152cFxSfdPDaV3gflF
         8QkW2aAx8LeqzyX7kIk06zpLfZXGCNkZAz/brdnwK5LfRq9dfR4hKZR0rmbVXDuMHhtE
         iT1w==
X-Forwarded-Encrypted: i=1; AJvYcCUJFcb/acF7jpfrhhxWrDi4RO0v2MtZc8JsyFwCNt85A7MZ7I+vz6jm2cNa75p8YexdDyyTwyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqgMCRgtju+OON/P9YnfNf74i+qBTH5YryZ4PwtCoN47dcq+wV
	UdEpNuRo46l9GIHtfsGQrrIDzv+OmSSg5pQzXiWC6mowr18dweT2kK+Ji+ktof5y7k0aq8udc8r
	mkb0b96rMDYEcIrmsZeRSGjY5OUcf8mpygBJW4sEB
X-Gm-Gg: AZuq6aJ6pg5wABjUAuAYscC5juZ0NMHnHnhRF1nxYPGka4FDOmMjd9Smpal0mCvmTtc
	a114Nqm5VrJpoocnfyozX9MxevxR+4IboFS1V+eJCvnwMQU1VJ8jswtFt7n+P6IqXC5uItDAoPZ
	lMRD5cpCk3q6PlvYRDt3tjgmECzqT2Jtq2jR958hhwd5ZfxN6cDaA3UWA8z/2COZCVDCdWfUdMp
	wXVdQr1UTy+tVlnL8xQCQD12cMeog3kZdTkmwKLbmu2dqbAcayQHTJsca8KTBwvS0dtCSE=
X-Received: by 2002:a05:620a:8519:b0:8c9:fbd3:32fc with SMTP id
 af79cd13be357-8c9fbd33714mr472241185a.36.1769932577748; Sat, 31 Jan 2026
 23:56:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131225454.1225151-1-kuba@kernel.org> <20260131225454.1225151-2-kuba@kernel.org>
In-Reply-To: <20260131225454.1225151-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 1 Feb 2026 08:56:06 +0100
X-Gm-Features: AZwV_QgckUNMZ5ONthg4M_66-WCqbx9U0vSK0bPEoEoI2XX9rhi2CV1ul_ZCp_8
Message-ID: <CANn89i+uqBk4QLoOn+70da4t8c7AWG5Yk0WOuxH7f7hf0kkVXA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] docs: networking: mention that RSS table
 should be 4x the queue count
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255581-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1455DC529A
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 11:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Spell out the recommendation that the RSS table should be
> 4x the queue count to avoid traffic imbalance. Include minor
> rephrasing and removal of the explicit 128 entry example
> since a 128 entry table is inadequate on modern machines.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks Jakub.

Reviewed-by: Eric Dumazet <edumazet@google.com>

