Return-Path: <netdev+bounces-269478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCMUGLEPvGkirwIAu9opvQ
	(envelope-from <netdev+bounces-269478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:01:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A8B2CD54C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BF2930421E8
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F7A3DDDD4;
	Thu, 19 Mar 2026 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ewme2c6M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCAD3D3312
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932356; cv=pass; b=ij4MoyyiRkiOffsKM0+1NAz65w4uXM7g5MPFqfi4fdIqf1bJiXBUilCBS+mIU6EMaUCArO22dJ60BvB7RzkKmJ2dJ8J6Ymw8YMwXQG+DwEy9omybxw3YWug+vFcNB2KAAYgKsYYeglZ2Dc5I9iNiQKlMDL+71ZZkjPoENltXNLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932356; c=relaxed/simple;
	bh=6sDmh2K1ddd/qqvjeJ3o2QQSM/r3uurP4Rh1fp088y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnPTby3SH6TO/t+/p4OC2DZanhf4pXfLnknRSpgyPB+YAHSJv7p2cfCkTFs6dFb3+ik7b1ywvMxyogIbxnvFXG3Z4WTZSOmpW4xCKMtVcT7MnNAPALrf5kAeWWPIYN7bdwZ3HHJ6le5hrO5Q/261d9Mt3VSKrxMjVYaqpnbTA2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ewme2c6M; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94ace5d0e39so269715241.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 07:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773932353; cv=none;
        d=google.com; s=arc-20240605;
        b=G+fsv8sh5X2HpADOZDgSCVfQm7LdY1DoSFGh0gF6huXcaFFxU/TnkxbYd5LoHSCVU5
         d+47gIZN6SgoV6+ODArKjIhrLbdkPLgzywJpV/UEKGlvgVxqgNNX/yVWZbTefublS7VR
         WEwsI/P22cvLDeqo4SnEPB3mm1z+e2R8QQySAjZNrpRFTQ31GUpdkXHv9OkwXvj/wSqw
         BdqZxr+V34an6pAAp060r/TKHAyczdjT1BA00+0hpp9kNkKvZVseFcUhTYqm11nzhHua
         VqIc6pCqB0+yM1Sfya8cuO0ShgC4+1Dhzlf3zPY6QMF2w2nJv0kElm+rlo2tpvBE9k/8
         Ma2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yR0wDDbnJaolvQrkwxmZCDZETqBo+ePk57wSqwmdMQ4=;
        fh=BFAhBVyx9O1Vf0z5eo9LuG06Tbwc9uD2J5LeXg4PQVg=;
        b=fhwp+4wYqfSjJAY9HiXUZJAp24FSYUatBDV965Bqa5eQwvNqKygPhhlvRRz6+Fk5C8
         0E5ob49AC3zAZQC4z8tedXMOvJ0SzSqC/fi7Dxgh8mPkIqeMA8or4SY/rT/ZvpehwHip
         YrGv0u0QYJWx7CfZ7FTCweOsftRTqltLBR9TTmQ828aQPJuhlPWQ/DL6Wf/Q0Xicd45X
         M6bnGuZ36f4RXlzdeShIP4wrtGJO4oCicrnayBoCl8COWXaXuCYvTN8lnz/BztV9AOBX
         o4BSmLQG+wzJ8cRhxAcNZJcRQlDSIaWC2xk3c5Whhj4Ni8C5yW30NPvL3+EzjXLwSCml
         ezWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773932353; x=1774537153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR0wDDbnJaolvQrkwxmZCDZETqBo+ePk57wSqwmdMQ4=;
        b=Ewme2c6MB6ZIkT842pVens1EfuelsTlCksC2FxcK5Sad6YScL2F8UZ/9qavAWWC5lb
         XRIuYS1h4ba9ELYYB4VhPdkFGoimWVVMxCmvPmvv84huy7yA64SPx+fSt6OuI1dALUxJ
         V1XQ/mmvEvkr35VcLfEH+f2PYmy7Ow0OnEUxA4qM9ZyxA9ha54ZahtuMKdUbOIxfLEwn
         clKCoa42uRcXi8Em9WoDnlCNhzQwLI/9K67zhKiP5QFAVskT6kdNwn35LgDWtAE/d0pi
         d81sS6jiimjXPdxiXDbYcrpQiu+x2aTQ0lUmaa04m7RRfjcu85J6Or+ir5EgJ64hUPod
         H75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773932353; x=1774537153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yR0wDDbnJaolvQrkwxmZCDZETqBo+ePk57wSqwmdMQ4=;
        b=Mi8gPbyj4KkRtrkyn4zPOWuVKl2PApFOHtFfkxiZq3NCquPnkALOZHyf3YHnD0+O31
         X+rEvpxrT7kSD0xnmxrOQ+CUdN7Jaa/CcwAzGirfcnYoJ6upACjou4tD/zEv68aL0RxL
         /CRt9aeFeuVsUkd4BGRDmAQGzzNTKEOZRi67Qg+7ahHoTD7Abu8O/EwNPGD+DKgkNwWO
         +Gs0qyuwIYA+1MGsAXFYxnDssvvE0tbKG64zW43SSLdwjnQnpbV5J6ZHIUiGCTp6mn9V
         DJPN965M5vyz6IEwKIFg0qP9rOkuKs7mMjMtzG7ClVQj3XezocsGBY9F/1s+otiFCKvz
         HZtA==
X-Forwarded-Encrypted: i=1; AJvYcCVcJhZs7JIfJZ1yxoORMMn4QfqRGIuj72gS06iq/cLKjIYAUAIOe+uTKpV5QdGzxlcpHiDmQgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF+BkPoWi1glOouhXOMV8W8rCVij8PYGAHP3YZFRrVjRMmWNKY
	fi+XLbn7wiU/+0ySXyJI8A8BTY6HDtL00WySEGSBZVnP4Q93AxAD/SHEGte7m9wgm122sRCnIpv
	t/ODQIHQCNDdr2AMvLPp4WgFRc4h9i90=
X-Gm-Gg: ATEYQzwVCgR6QOAC+iSiZdSThMreMLh40k3ULz1lldMafkklCh3vc1l/5DZCHNCl/7B
	4S6sfeRDC0AuEZFVjSzC1xlx6UjYp/zDjtjKjJbYupuqziTlpBUxgtFWM+QP0uFQXRQfZFnHPV4
	s4fkimLbBR6M5/PWMSfszCf1ntqW6oQdB06s6fB5hOKqmCNRbUPJRrq8zdzqFEKpAtUCbgdhGKl
	dUoGFp6SYgOtezgczn2KbHoi/X0z3hiAYWFQ5EakIFtmkwS1F4av8Vd+1YQb3933T5Np0VFU153
	LQGgu4Q=
X-Received: by 2002:a05:6102:2089:b0:602:908d:3ba5 with SMTP id
 ada2fe7eead31-602908d75b3mr1604803137.36.1773932353056; Thu, 19 Mar 2026
 07:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319141846.78222-1-seanwascoding@gmail.com>
 <20260319141846.78222-4-seanwascoding@gmail.com> <abwLFk0L_kCZqIiK@ashevche-desk.local>
In-Reply-To: <abwLFk0L_kCZqIiK@ashevche-desk.local>
From: Sean Chang <seanwascoding@gmail.com>
Date: Thu, 19 Mar 2026 22:59:02 +0800
X-Gm-Features: AaiRm53HfEhbR7_2qsTpJtH-fp383GOiuoRUVlvrS4drdeqj357T51ILS8tg7q0
Message-ID: <CAAb=EJVCkn9_iO_YHMbLU1VR1OsKqTSg5Jo9jviaT3dEq0k5vQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] nfs: refactor nfs_errorf macros and remove unused ones
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, Anna Schumaker <anna@kernel.org>, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269478-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,vger.kernel.org,intel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.625];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86A8B2CD54C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:41=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Mar 19, 2026 at 10:18:46PM +0800, Sean Chang wrote:
> > refactor nfs_errorf() and nfs_ferrorf() to the standard do-while(0)
> > pattern for safer macro expansion and kernel style compliance.
> >
> > additionally, remove nfs_warnf() and nfs_fwarnf() as git grep
> > confirms they have no callers in the current tree.
>
> ...
>
> >  #define nfs_invalf(fc, fmt, ...) ((fc)->log.log ?            \
> >       invalf(fc, fmt, ## __VA_ARGS__) :                       \
>
> >       invalf(fc, fmt, ## __VA_ARGS__) :                       \
> >       ({ dfprintk(fac, fmt "\n", ## __VA_ARGS__);  -EINVAL; }))
>
> Why not all of them?
>

I initially only refactored nfs_errorf because it doesn't return a value.
For nfs_invalf, it will always return -EINVAL. Would you prefer me to
refactor it using the ({ ... }) statement expression pattern to keep the
return value, or is it better to leave it as is ?

#define nfs_invalf(fc, fmt, ...) ({            \
    if ((fc)->log.log)                \
        invalf(fc, fmt, ## __VA_ARGS__);    \
    else                        \
        dfprintk(fac, fmt "\n", ## __VA_ARGS__);\
    -EINVAL;                    \
})

