Return-Path: <netdev+bounces-258994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB3BDlk7lGntAgIAu9opvQ
	(envelope-from <netdev+bounces-258994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 10:56:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B63514A98A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 10:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD3EF3034E35
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F089B31AA82;
	Tue, 17 Feb 2026 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrIQ6pfK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F931A800
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771322157; cv=pass; b=LFAJTcVLLgyc9dDpfmbD1bYLtXbXgu/ISci0FPZwpHYZJs+rKA4mVexPThmn/lpKVktbIABdDzqqJ/MEKgK/VU6D0XqZVrP1+1hm2L/7/04GcG9aS6cpyAWWpVayPemuo9EpiDJSWXlqhwJiRvPjIRZY5cOoIa8F0f8LW9FL0uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771322157; c=relaxed/simple;
	bh=uQcxrS5XtLzaUDzx5mBZIEaJIdBq7YHFdQeDi+x5Y28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loT//iudDlRexqjQWTspYNuDy/jwFcUpfbpGiC1OZVG71PnEbEype47Nwq/DeQRLkXFbyRjHc3n9p3OIPjhQoHYdzQjrCMZkvVkain7DmoHRjwaTvtqA9jjhm1AltQ/GR5qF1Kg9UZ/K+B0A7vnGWu8OyGBskIXrtG2zKgQheU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrIQ6pfK; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-948ab1c79ebso1067955241.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 01:55:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771322155; cv=none;
        d=google.com; s=arc-20240605;
        b=h4gCnGvReNDEuHlZW7QZccNfRBpMcWVW2DfSE2HUWKJbzAQzhpD+JTsr3vuwFukyo7
         FaVY9GxwSYHk0lc1koxM7ZlhTLuS5gkqvLquS7pI0zVWx0DtXVmu9atKMl3nTZ8H6mDK
         hr+o5DBzDMx01nyl9zGzaxrQE1Vck2MN2H3JM5XeHB9JLuDemsXamfMdAWj8UdpAxTqd
         LF5Xu8BPa0Zs8aoT7p2D5yuOl1tu6DUQsQ9sFNtQuXVC4GeT960IEfZQhoY0/UUMDTmr
         BkYRYA2evXCxAQtCzvWMJkZnvVah3Pd5p0JsgFMdT3r19GnWt6QzJYQnsqiXG2QUWolL
         Jt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uQcxrS5XtLzaUDzx5mBZIEaJIdBq7YHFdQeDi+x5Y28=;
        fh=8h3FT6j6f0+y57n6bMmrvT75AmOPhvDFWlMtbXlAKnA=;
        b=DNI0jtlIjUA+XAayjOQlK/R3u+O14PyIulmHm2k73fIfav/cSeGICq+T0/9SnvZeIV
         jpUKqQGdGMZd2/qyI0GZ/sGz2TXrnw3x9n/L7n11weK/BMxNO3nPu/93+VVUWHnT5Dml
         O9V+ys/X8gj8XyL2QB15esjw1HrL9S2fvlwB+I59AyBFEPdY5ukcq/ejC0C91Xa4QmGX
         NkN8LJnvvve3dujYcEOfzmUfKL2oJdZ1SGG+/vVHBBeNQG90++hjsN3Ao/MU4o0alp8f
         HkQLkJi7+bsIilMgxMgQizoZ3EZbFsyvGtmR4el4Ip96/YK/m4F65rmJVX2hGl0qbwgQ
         TdZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771322155; x=1771926955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQcxrS5XtLzaUDzx5mBZIEaJIdBq7YHFdQeDi+x5Y28=;
        b=MrIQ6pfKM/YNhSYduwhPxzWa5RmJtXm959CSceSEV//q8COdGQ2p6/AwwWpJ1rtcp/
         QTCOQZAZZ2e9KAjV3NsAvhqxkshKRhlARd2J7UCh7D550iPSWSZgARWJcOFK9RRGNRuv
         XnQCWlHNYklgwHqKy1GkcxMWYg8Eufp6OOGgU/bHM5KkHXYB3K14RHkLieLQz+HnfCBA
         OtBhAqmpR0usvWGETI4f7liyW2mC3ANFz6NbpoBkwL7Vn7uy4iooVn2G2/hhepHL/XjV
         ePp7/L0urHDohTUgrDZNBd0t7JCdEyejfI+7Uh8lUuV3NqJjWiAn8nJaqju+/ARX0e7n
         UmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771322155; x=1771926955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uQcxrS5XtLzaUDzx5mBZIEaJIdBq7YHFdQeDi+x5Y28=;
        b=buArD4nZE4Wp3KBB910ctfXFgm3bsnhAqlaNvfxZKsbpmHTemZ8EPFZwwoB/Ije3Nf
         fQC8PTFLZun8NKPMUL0dx77hj0YfMWdMAfRtoCqyhjMJfCh3Cz2oBVfWGlScU7oCYn2o
         kvmrl8+dlgekZNqhMMDjiYuQrDqhe8SXX8ogvoVWq3Kma58Nw1NbUdP9M8+5Jxx00mK3
         feviqzd9lp50+oAiVCz/oMrz44NY2MrHexpAG+Kvmjscuo+6yxcEnR6DafFXNI2OimQu
         Gzw8vp4WauOchBRgf4MVCRR5DtrViSI73fXmxgLHA9JHXbzYxTGHhzYh13QrnVEYgw43
         vXNA==
X-Forwarded-Encrypted: i=1; AJvYcCXbAhInw2U22XHXj8DfrKWF2YDuyJLiq9h+3tyLNVbZtd9V7Hh12iKikRNHlatDhvFhCJhaEMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytag7jtiPDSflGVrOOBBnw8Jh3aLGohpqjc+WOo8WQaKl4v6E5
	5gOGm6oo28YGkDmFgyA2GwJjH6uAEe/o56CbjZ+sG/vsXNA1z+VPavP1zWrF+4AvfaoAD90v9lK
	K7VECZt8gg9aNzTcGaWV4FaWO3BHAL7M=
X-Gm-Gg: AZuq6aKwbd5y9hlbw8d4XU0g22zZiMLUuZ4RRjkLF99gPBucJUYjrsPRnjpPQcI3iKT
	3P3Ok5X7G6+43MmNa48sSJyIr/93SiNHIpyE3+tBwC3DWYQgO6RUOhsZq/s13o1mhyYrBFjIf5T
	AUPVMoQHIYCRyWmEyrjZYwUAkwCYeYC0xczgCtSXfYt7CjAFjEvTbc+qJ95uoga2m9FsK7yPcE4
	dkY/7QwWRBAi3SO4W1DQqXo+l2+tHPYCKehEKEeriao/QVCu6lwPUFXF/bxmxVp9QRpQ145nqlB
	T1mCCo42ykSJwAWC
X-Received: by 2002:a05:6102:3f08:b0:5f5:4121:9b0a with SMTP id
 ada2fe7eead31-5fe16f5d356mr4577718137.36.1771322155559; Tue, 17 Feb 2026
 01:55:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216174950.455244-1-seanwascoding@gmail.com>
 <20260216174950.455244-2-seanwascoding@gmail.com> <2e3bf4db-cea6-4f55-a82b-4e99bb3f44fe@lunn.ch>
In-Reply-To: <2e3bf4db-cea6-4f55-a82b-4e99bb3f44fe@lunn.ch>
From: Sean <seanwascoding@gmail.com>
Date: Tue, 17 Feb 2026 17:55:43 +0800
X-Gm-Features: AaiRm53vZLvkKhlBjILeLIYC1fodHSKYlOPAnjQL4nEJLrwpsrtIJFsCO7n8eJg
Message-ID: <CAAb=EJVmDS7vKHsw77SARnD9uff-9vBrg97jo3tbYJS-z1KAgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nfs: fix unused variable warnings
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	trond.myklebust@hammerspace.com, anna@kernel.org, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258994-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lunn.ch:email]
X-Rspamd-Queue-Id: 9B63514A98A
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 4:06=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
>
> There is no #ifdef'ery here. How is ptr not used? Is status always
> true, so the goto it always taken? But then rpcdata should also be
> unused?
>

If CONFIG_SUNRPC_DEBUG is not enabled, dprintk expands to
do {} while (0) during preprocessing. This means unsigned *ptr has
no remaining references in the function, as its only 'read' was inside
the macro.

Regarding rpcdata, the compiler's unused-variable check doesn't care if a
specific branch (like the goto out) might skip the variable's usage at runt=
ime.
As long as there is at least one valid code path where the variable is
referenced
which there is for rpcdata in the call to
rpc_clnt_probe_trunked_xprts() -> the warning is avoided.
For ptr, the macro expansion leaves it with zero references in any path.

Best regards,
Sean

