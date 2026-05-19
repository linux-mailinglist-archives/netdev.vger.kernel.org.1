Return-Path: <netdev+bounces-289545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CQRJ9qdDGq8jwUAu9opvQ
	(envelope-from <netdev+bounces-289545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:28:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FBE58310F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7101B3054C3F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BCE31619D;
	Tue, 19 May 2026 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cx0ZSpC2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC78226CF6
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211551; cv=pass; b=DkX6KLs+6dN4nriFg6s1YEYDxcllG5Wxy6N74E7O1MuOgQYl7a95+3Fgv5gWjbBcBNBzUp2jya0oL8iAznsmt7flMwXzgaceMuRtMrsSS1Uuf6wAW1gkAnVi6vUzjOihziwxftMCFTnmROUVTr6NViL6eHEtgE0f+it58C1/zu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211551; c=relaxed/simple;
	bh=FnPktEvpCBFBJ+TVc/ni/S7t1B3GKoH7YXEfmoTGm+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvWwep2IbajhMtxfAD+f4/wk4zmqYEWESziY/ax2WmXH0Ypw2LeLexV4AJzejjEeroEYqxHjyb/ZRTdQCLI/tYtun1GD/LQ97zYnc3OZdgnhbJEV4wvR3ede3xx2wpX+FUiWM0/pWOvQLPAKVTbjR38+SswGtkeaLOrPBoPJUzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cx0ZSpC2; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba180a022dso1575ad.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779211548; cv=none;
        d=google.com; s=arc-20240605;
        b=eDUxdKunAGuixxpiFFq+i3OVTUNBwZG4FTFRlylYKy+RQraw87WivSi6ash13l95Xj
         /qPiY43hjlNWTwTkjBNt++NaXNvYTJ4CDAgfwyD6MprwfvyXXMJfWCWnv+Uy/MqYxQIS
         N8Yjyo5qdDljF882PglenHt23pJTXMIKVnoyikXCX0c45hkEgE/va84xzz5o9b48O3vI
         ZuZlv2JQyQqqkHYQ9xt4bMYpiOH1HsjYQ0bSsABz+HBS3K4cJU9YHqraX5M4rKhJJ+ER
         nket3QQEz0yi5S6Kd+Jg210vBGFDZeR68xhHbs77Q9bVa0vt8djx0HSjE5MfaCrW7M9y
         VGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CV+8xJFrBwz/qANfkgIkVL8z5wQmlbcD9O/MI26PWGE=;
        fh=ncnEulzx6fRE3+fxsmUEi1iQ1bVr/7y9O+5hZiF+Cro=;
        b=ldvwlX86nNBEp7r0kU0D3k94Opu1XY+R4mJxzOY90umSul92KS3fiCZtGoWSQv5duQ
         R1WNW74OZBCOZZTHhEPI4lWR+dWVDJLrJxVhvo83jtNOPi3Lr7FxTqa1SEalaH+QSP9p
         i6TLtOazQEUApGLlZjCqGLJa4oRxSjgWCXCX9nwpbhE/+92KNLgpgBdhA1tca5fidlid
         pQq05tEZ5Kcv4RxCxviuq70eQTzZcmtHWW47uy6DHT6lfLfBviL/D2lNKzkHH/k87gwd
         ElLnTQO8I/3XVSNwqhr55zE0OcOMgPDZl2rN8nNeo3IL9oLSj0JcRQYAtxXpJrE6BvIJ
         3McA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779211548; x=1779816348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV+8xJFrBwz/qANfkgIkVL8z5wQmlbcD9O/MI26PWGE=;
        b=Cx0ZSpC2r889Kyrl33xPYmyXUp82WXRM0IwdayS2pdpQCyJYWpu2IOQ5GmSqoO8dMr
         hD7hO3kJDWHsJuSGdRiwsl547edLT4sg3h0nF1h4cUGqNfmeo/dJB2vnJqYdr6WrJ9Wo
         j90qo4WH+WITgzNKDcvi6WjHKIZLecFpIlA5ERiqng0awonkWDyz59dUFVD/qQY7RRv6
         bGABbTtZghBbCm5nDOT7XtEGnbmvForw/JPS5O4mlZfQuaujjHGXwCqaCsXKirLmLEr2
         s8wSzNVCuhUVV8Ucev3zLxYhuX19Nig/i6TICN9jgw/CM0M3/w1p9S6dmTDPHIefZbIB
         W5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779211548; x=1779816348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CV+8xJFrBwz/qANfkgIkVL8z5wQmlbcD9O/MI26PWGE=;
        b=U3MoyP7hGbxtrmvyCUsYi7SuzuJ+/ZQ36V3TYjiDO8WIj9Fpe5DikcggkFk5gKaZd+
         52DGSsALelOF3KNBOO9xNmhEUOU/qccbj4sdVBWdbJGy1pC/o5OeFv/u7wrQejscuuKq
         rewq/ql/1kzwg00Xj5yzz+vrHlwEViCogzM5r9tr7FcmInU0ULvRiLkEXAuFO1SA8X+D
         gInlC0ZZ03ENo7KBIXQMK+0w51pGUB86xG0Vn7eJjlwWXU8aWta9iJDsJfqkqp7jTSsS
         +UFnBx5vvdzuB2fUcZFlkpJjg0feTzY7OdnCl6bX8Rpaq4N07DJHYvm7YNVlFc5z3VTs
         g7tg==
X-Forwarded-Encrypted: i=1; AFNElJ/13FWzMB16MzmiycSB/vstT4L24cdtGZtPHZRHDZ4CYyLVNAQNYQrcaWPOy466mBnLOxvMIxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWcsK73h84r3iwkgFOBQ6wsojxMkgnWRVT97A4vloZ/UzHeLiI
	FWQRL5X6u0yNsKrY+X8JFiXTtIsIutleP1D6By91rIQk2NGhzw57s6H3gebI+9XKU23VGNN2Imv
	I1/WiUT8GB4c2SbioLKkIKwShyTGyFs0T79GV05Kf
X-Gm-Gg: Acq92OEpnHApoq15Icv1U0k7C2DuQsqBZcC/N6HFk7ehU/FAhL8MI9v8kX3wtcV0cwa
	eUWKidlvWXlv+yDgu7bKLdZIWlIlv2+S2P/6RRopFAkdPaK8I4JJZPOVF+u4P1IStwEmyApvEwi
	ZofLuL/pw6Wt19bpC/wbtul+LanSrlxUEYwMUS+54MzOuaIS4D5U5m2Wc9dOvqzrLG7Ft05kVor
	dUqpT7nO2R0RBwHhHxj0efKiAfODDCNPQAOD5n+jmPiCzed/Lz8DkGczz+h0LoEzIAHQIFVb2+/
	elF5k0MjctPyy/PAjLSajdD/Ol7+FQLmNlE9As5wfi2hDolmuprEEoErV/Ej7a2pmCLuNlrrhis
	BReIMIFpYdmXECCuZcSJeT+uy1WI=
X-Received: by 2002:a17:902:cf42:b0:2ae:6755:a24f with SMTP id
 d9443c01a7336-2bdb0113ddcmr6591515ad.0.1779211547151; Tue, 19 May 2026
 10:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518030535.1057228-1-wei.fang@nxp.com>
In-Reply-To: <20260518030535.1057228-1-wei.fang@nxp.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 19 May 2026 10:25:34 -0700
X-Gm-Features: AVHnY4JXGWfpYwtEwaQ4vNriEAea_KorNY6U8rnaMQ1ybn6e0oAIdmmx__VA204
Message-ID: <CAEAWyHctmc26umq4W4NJUo+pJRw24V1-T98USjmY6-Ge09xkPg@mail.gmail.com>
Subject: Re: [PATCH v2 net 0/9] net: enetc: SR-IOV robustness and security fixes
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, imx@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	catalin.horghidan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289545-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 21FBE58310F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 8:03=E2=80=AFPM Wei Fang <wei.fang@nxp.com> wrote:
>
> This patch series addresses a number of robustness, security, and
> correctness issues in the ENETC driver's SR-IOV subsystem, focusing
> primarily on the VF-to-PF mailbox communication path.
>
> The series can be grouped into the following categories:
>
> 1. DoS and security fixes:
>    - Prevent an unbounded loop DoS in the VF-to-PF message handler,
>      which could be triggered by a malicious or misbehaving VF.
>    - Fix a TOCTOU (Time-of-Check-Time-of-Use) race and add proper
>      validation of VF MAC addresses to prevent spoofing or invalid
>      configuration from being applied.
>
> 2. Race condition fixes:
>    - Fix a race condition in VF MAC address configuration that could
>      lead to inconsistent state between the VF request and PF
>      application.
>    - Fix a race condition during SR-IOV teardown that could cause
>      VF->PF mailbox operations to time out, resulting in unnecessary
>      errors during shutdown.
>
> 3. Memory safety fixes:
>    - Fix a DMA write to freed memory in enetc_msg_free_mbx(), which
>      could cause silent memory corruption or system instability.
>
> 4. Error handling and initialization fixes:
>    - Fix missing error code propagation when pf->vf_state allocation
>      fails, ensuring callers receive a proper errno instead of
>      succeeding silently.
>    - Fix incorrect mailbox message status values returned to VFs,
>      which could cause VFs to misinterpret PF responses.
>    - Fix initialization order to prevent the use of uninitialized
>      resources during driver probe, which could cause undefined
>      behavior on certain configurations.
>
> 5. Diagnostics improvement:
>    - Add rate limiting to VF mailbox error messages to prevent log
>      flooding in the presence of a misbehaving VF.
>
> These fixes improve the overall stability and security of the ENETC
> SR-IOV implementation, particularly in multi-tenant environments where
> VFs may be assigned to untrusted guests.
>
> ---
> v2:
> 1. Copy the message content from DMA memory to local memory
> 2. Patch 3 and 5 in v1 are merged into patch 8 in v2
> 3. Add more fix patches, such as patch 1, 2, 6 and 7
> v1 link: https://lore.kernel.org/imx/20260513103021.2190593-1-wei.fang@nx=
p.com/
> ---
>
> Wei Fang (9):
>   net: enetc: fix incorrect mailbox message status returned to VFs
>   net: enetc: fix missing error code when pf->vf_state allocation fails
>   net: enetc: add ratelimiting to VF mailbox error messages
>   net: enetc: fix TOCTOU race and validate VF MAC address
>   net: enetc: fix race condition in VF MAC address configuration
>   net: enetc: fix DMA write to freed memory in enetc_msg_free_mbx()
>   net: enetc: fix VF-to-PF message handler unbounded loop DoS
>   net: enetc: fix initialization order to prevent use of uninitialized
>     resources
>   net: enetc: avoid VF->PF mailbox timeout during SR-IOV teardown

Resending to the correct thread.

This v2 series LGTM. If the commit message for patch 8 is updated,
feel free to add:

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

>
>  .../net/ethernet/freescale/enetc/enetc_hw.h   |  1 +
>  .../net/ethernet/freescale/enetc/enetc_msg.c  | 79 ++++++++++---------
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 75 +++++++++++++-----
>  .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 +
>  4 files changed, 98 insertions(+), 58 deletions(-)
>
> --
> 2.34.1
>
>

