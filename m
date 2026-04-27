Return-Path: <netdev+bounces-281445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ENHMR2r72kCDwEAu9opvQ
	(envelope-from <netdev+bounces-281445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:29:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F04478984
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BB32305C5AD
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED76F3E92B9;
	Mon, 27 Apr 2026 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="OMa4dji2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF6C35AC17
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777314310; cv=none; b=C/2ddxGe91WDSCHj9KntMuTq0qu58d9Qq4sb/SBuR81kUjz6JiPegJwxz32fK9Qw5fNYYeq8qhuxyb2Bcy1hFamnv5EESCXcE6+svxwcffrdJVOG8OBU9f9pQ46N93WR8QEAplLUbt7mY6PRmcONDqKkLeC06IgH3hlc/73EkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777314310; c=relaxed/simple;
	bh=x8daYy/xe2IGqkndE63c9mrqTq6cO/rv1/64decL3Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUbUTJKJESsAftYLcV+lJHPjRQiTTMt+tTBx3VJ9eZeUFJLLPnKmldgplYqXLX8T6zx/BFl9NblubQwdxPQmRPCEPzxHo60D532hUIwZLInrR7zNhz/BCo5f6Hl/q184kwea6CWBiwfylBNMjP2sThYWZJOV6bmkud4K26MhYkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=OMa4dji2; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b6b0500e06so16129265eec.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777314309; x=1777919109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r62aUJ0jnce9kgdNQ/Nlm4it1uU6lIZXN3jr7p6GKXA=;
        b=OMa4dji2yoscdggFxpN6U1TI4K52pVo09e7PLvdqfYoHchFET8ZQ/r3sYI0HV7ec5+
         +Y4eaiWG7C64TVvv0EHXv/f9nRtmHOLhPbK1f63eXYELE0fPHOsjfGoZA/OSRQHMUbwz
         t8aGKIIO85IOH66a9b4RUbG/LZE90dqCPGBqQTStTOVdQzQRuOGIpqbo7+tIOKTAWg6g
         2C+TKUXsxqnMULOwBugiaB6/dSonbClcx2EGhBESeTDkZVrIs4EIHFhw0CyB/j4xVCpm
         MtxQ9vGTsS3x+EbJZ+sb0Qk6ApN/Zx0Y2+L5gBoKX2hTNBCwjS81oBswoIRJkC9og8xo
         OxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777314309; x=1777919109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r62aUJ0jnce9kgdNQ/Nlm4it1uU6lIZXN3jr7p6GKXA=;
        b=FDqgwLvMG89znyTw3Cv8F+vudbEPM6BrUkG0v6UFhnDFDxCTGnelaGz9Xf6jCxXWVu
         xOE9jZNWi6Fg/aCkNjovnjVBC+ECeFTQrZhXKTIWprUp0h/tKdH66rePLAc1yALY9h4K
         f/Lwyuxxf9KIAMNr0MoOoyIj3wNlTQ/StWeCbQEqM9pFdbaKsSaFjc+FkskifuHnCyuw
         c4IdLa/SGj9vpEHQYqKx+dOrHMNW39NiQ7WEh9oFu2zBmr6MRIjsj5g6Yb2zVGV82K9t
         oNvz7sfUhaP1c7EMScN5Zna96xq5ugEcQcgJpwbMuGngS6tJ35KWgafOeVi6vTvFlua+
         XXUw==
X-Forwarded-Encrypted: i=1; AFNElJ9MiUZd9nAT4cu9EPGvb7Xvt2WlOtziVpnWktxMKjTfc6Zz8uMRZFT1VFFomunZk8LyMTbZI8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK6sw2s7879mPCTLDJkWJJ1BcbVnLi+iyHu3wlUy1XafYf0uju
	qti9Q03BDR2ybqwu5YH8r8eG2ubqbfmtLBeZi4DjDinAsHTAi5/siEzeaT1WiSyjr3c=
X-Gm-Gg: AeBDiet38Bx1Lz81mxMyIBdPGXXRzSpbjB745WKng+b7EEe6+AtypZ9p+zgGToJfkkU
	15LGZOe26aUczVHRGldG178003O/YHvu5ZEkc1YlhOgAqPu3M30Enr0DQlLhywZ5kSj3XALom7s
	ysWr3FCC1+zX2xRwX5yGtWBPtNZDfTakyM2SdGnlJJHzDZFoLme9h4n5+NEK7MLXGgUwUClRdb1
	JXUwr6TKAeScSrpQBLzJGgZf9DMdQg1jX5rFcGLr7odSOJf+5+mYspnkG8nvXogyZhxzqkD0UsV
	JGBACc+Zw/L/b8hL/4ftySKUzwd1Ij0H+3LMgv0KDf4Cm45yjegmXLqNlyDqsQMTuVhR2DzonM8
	W49TRt1n+E3/cmeTjQ6KRCca/bYXdNuUeqVfBVCxYksFt/TFuzFJ1NMQysy4S6tNxDzHpFcon5j
	mLRUMFDWp/PvoEf49ziQHnnbd7ldaemOGXx/BIgAK+gjAjfQ==
X-Received: by 2002:a05:7300:fd15:b0:2d0:239a:23cb with SMTP id 5a478bee46e88-2ed09b7d31bmr51555eec.16.1777314308449;
        Mon, 27 Apr 2026 11:25:08 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8aed43sm43833183eec.26.2026.04.27.11.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 11:25:08 -0700 (PDT)
Date: Mon, 27 Apr 2026 11:25:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chiara Meiohas <cmeiohas@nvidia.com>
Cc: <leon@kernel.org>, <dsahern@gmail.com>, <michaelgur@nvidia.com>,
 <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
 Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH v2 iproute2-next 1/4] rdma: Update headers
Message-ID: <20260427112505.684c21f3@phoenix.local>
In-Reply-To: <20260330173118.766885-2-cmeiohas@nvidia.com>
References: <20260330173118.766885-1-cmeiohas@nvidia.com>
	<20260330173118.766885-2-cmeiohas@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 26F04478984
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,nvidia.com,vger.kernel.org];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281445-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim,phoenix.local:mid]

On Mon, 30 Mar 2026 20:31:15 +0300
Chiara Meiohas <cmeiohas@nvidia.com> wrote:

> From: Michael Guralnik <michaelgur@nvidia.com>
>=20
> Update rdma_netlink.h file up to kernel commit dbd0472fd7a5
> ("RDMA/nldev: Expose kernel-internal FRMR pools in netlink")
>=20
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Chiara Meiohas <cmeiohas@nvidia.com>

The upstream macro names changed, the iproute2 build is broken after
current headers sync.

In file included from res.c:7:
res.h: In function =E2=80=98_res_frmr_pools=E2=80=99:
res.h:203:26: error: =E2=80=98RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET=E2=80=99 un=
declared (first use in this function); did you mean =E2=80=98RDMA_NLDEV_CMD=
_FRMR_POOLS_GET=E2=80=99?
  203 | RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET,
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
res.h:56:44: note: in definition of macro =E2=80=98RES_FUNC=E2=80=99
   56 |                 _command =3D res_get_command(command, rd);         =
                      \
      |                                            ^~~~~~~
res.h:203:26: note: each undeclared identifier is reported only once for ea=
ch function it appears in
  203 | RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET,
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
res.h:56:44: note: in definition of macro =E2=80=98RES_FUNC=E2=80=99
   56 |                 _command =3D res_get_command(command, rd);         =
                      \
      |                                            ^~~~~~~

