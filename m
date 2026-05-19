Return-Path: <netdev+bounces-289389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOHrIog5DGp8aQUAu9opvQ
	(envelope-from <netdev+bounces-289389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:20:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA6657C177
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 088573022BA2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C053A8FF7;
	Tue, 19 May 2026 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFnRaszv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479B83921DC
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186044; cv=pass; b=jZ4gpLrzHyGcxU63gPiJnn7EgWNQ16y/Mg5JHEaz6znd7bhIjAUJmXn1AKYUOwmbwKHduscNdzDl2JWj2HECijN6P7ypJ8iZ3HzVPe6ZnxBc0hrWVeA3MjvuccP7YowIAuj4M1UQVvb3sPz/i7LPAieDXSq4QzcYMfArwcGfDt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186044; c=relaxed/simple;
	bh=2vR31sdUHtymFe9CNUukVCJVp0E0BMo77ex2FZYtwlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiXxWfy6FUgLllsOlq8Mo6o6ddZ8zRq4xcDsPxGDtqQEgTc1BC9KDAwwdokK/xE9VzaazdBxMxmObPEviVXsXtxzBtsko3IF7YekXOzGCCBTyt0JiuYYUwGj4BYICynGTBqPrdJ76dKSOAHb5jTiDnZmljBeiE50++AyJ90kWJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sFnRaszv; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e568ab0bc5so3847717a34.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 03:20:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779186042; cv=none;
        d=google.com; s=arc-20240605;
        b=CbHX5IrzILaWtt2Zbk5JLZhfMV1+rklENjNDwKS9OchR0jO/xun4BrAAYR50fyuxC6
         mG7BjrwSyQ2Nfm+tKAYi80r+DgkFpwzigjObnAQS8zHn63sZvvhp3GaDaBwcQC84itxS
         YpgyWL/Df0vL3SBFPv0ZqQba5eYEoSfi6V8c9rKrDpNVk5R7AbyXiMApN1HEZ3aQaIDv
         KWglesnoSfkfU8sNxQR2kWsU82z//jBroFxsGy0J+maccxxN0pfhH5Ppsw8+Aq3EpGkn
         zOcMBepVTwuCItKeI5PPaACSHM16hXabkS9HRXundmF7kd2++0cZyId1P7/D3b49GKcU
         albA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H3FMjfHhduEKZP2kMBahieqdNkXbkgxKCQHA9LNkNyo=;
        fh=YrhIqPENUAvtQH9kVgK6iYyEkmZYX76g66i5mw/6efs=;
        b=kb5os+4VkLRtgAbhDmZMM7mKRh7PTXkBwFZHSxLpsq2HYSvGwaGzntpZlTRvUrhBtv
         SOjRRoyctvhpGu7kWhNQWeAnP0BrE6kQV0z3r713cRmtjJYxW4RpDQHx0K0UQMq0QLVO
         kthYeTTq1yK2tu4pfws42c9JAg0WBiy9KTmm9/O7FsiWSVBwkrx5zSbOLoHDkvTYrC7H
         7L89+ZfepZKPwLjiAnD+id8TSMmtEo/WZ9NMX5LU+IeNe4PDLrzjDbMxRhRm770HxTNj
         1ksnXQRBb2FIRhJMK0qREUA++9dQlEWj5PxNBtL7OvS9Fh3ab3ByDwLjssK1neyqeRlY
         Dk6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779186042; x=1779790842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3FMjfHhduEKZP2kMBahieqdNkXbkgxKCQHA9LNkNyo=;
        b=sFnRaszvU6XfnI7zBmg0+qqg2QfmkJryrzrdfZp/D4xiimQI/Jjb2sGtZDxlj2MLLs
         DuvImyR/a6M7i2rvyQrGIZ3OqJ3UxohldcaP4lWVKJQLU9Ah4yvciakv7pi36QiV0DpS
         TbK/XKlHo6H11IFL2DNY7+foOA8YDDvAs1GoF9pTvbbh5N+gu8YFUdCVPMn9JWg+ohMs
         hVIGTRfKVbfEaNh4sL0wl4G+tVUZzDAiUHRBPlog6V6GfL7o/H0E/swszpFPsm1ocVxI
         1hmyE8cWVSu7aETDhxfVPsm3riJqEo8Y1p1X6319aM4sabQICVShM40PJ7VYP3HHfemc
         TODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779186042; x=1779790842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H3FMjfHhduEKZP2kMBahieqdNkXbkgxKCQHA9LNkNyo=;
        b=EnT7AQRNyR+NkoSGzimWPonrohD/B348QLU7m1+pdEoMV9PkaF7X721TdU97lr8FLk
         nvKo/QHN+TaGOaWNfAX6iXFqxLIdNa1RMbT4PCQy5dTlnvkXXi3X5quzEN5cz+vR5Trp
         WsgbP8VlfunOu6I18p2JenvVPvM4DhlQFqzBNsnuTA5g+dgU4s9UiBqHafQlvgnXvKNJ
         YX0EMt6AjECXohwL2YQjsdOCKxM7wpbP0j1CLqCUp/7sSjzxHS7UjkGWQgUtuLZpZyXM
         KaWmjaLAf9dMshhPuiFuFb9zfm1V3xdDWBi0qUti6cKnjNe9Q2cyAYtYs7SHYecCPFve
         xWnw==
X-Gm-Message-State: AOJu0YxCUfYR9NqrNQaLpPgNT5sC6O1T9YYRLelvpmGmXI/C9XYsCdTY
	u+RuRYZ0/O9T9/QLXBk54WvSNpT//6aBsxvPrJfV0L/WfovoDxion0D80BjkZ+zBYshPDhd/9jo
	YGOU4M9r13d8etbM9KA1anIW2YP4ZNgs=
X-Gm-Gg: Acq92OHCRiuMeBTg/sfG8wWuDXaLJZpnNvm1j9SqzLra1sLmSoQWRKMNPfDT6Ce70z2
	/rsUXWVJIlx+pQtVND4kTIaC4vOAoF40Tabm2JNu8GNDNKJO9t3G0NNmwUTgoNGm+HkS9YcPh38
	eXu69K0vxmk4T3NK9BWe+KZ6Ad8kZYVliqEJ2xNyf2un3wlrTteYhmdvyagA0RrSNL90yPh9M9U
	hkMXFMnHdKzfbBeqIFrAi3DKUXOUv3bCRt3yIfBne90UUzHDUob9rKc8VQu7UNr+pWWyF50FaKA
	TqO2Z+gHy+paoyIT
X-Received: by 2002:a05:6830:3146:b0:7dc:d725:fdb with SMTP id
 46e09a7af769-7e4a3e5e7fbmr11698778a34.8.1779186042241; Tue, 19 May 2026
 03:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518164029.439928-1-houminxi@gmail.com> <20260518164029.439928-3-houminxi@gmail.com>
 <m2y0hfu41y.fsf@gmail.com> <CAJ0BgHc7c9h_pOmGQjjKLZ2-dz_dvo8XxwjbUrPOWSOz+11g_Q@mail.gmail.com>
In-Reply-To: <CAJ0BgHc7c9h_pOmGQjjKLZ2-dz_dvo8XxwjbUrPOWSOz+11g_Q@mail.gmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 19 May 2026 11:20:31 +0100
X-Gm-Features: AVHnY4KRop5o7_bCYiIKZO82xuIJRrDt6HXoJ3bKbz2JBy6VofP1Ky3t_J0IWh4
Message-ID: <CAD4GDZyP6GSfUfc0iyDPShHcVJRJmVNc-4HyZJGgk+FsFuuq3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tools: ynl: add unicast notification receive support
To: =?UTF-8?B?5L6v5pWP54aZ?= <houminxi@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, aconole@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289389-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5EA6657C177
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 at 10:51, =E4=BE=AF=E6=95=8F=E7=86=99 <houminxi@gmail.c=
om> wrote:
>
> Hello Donald
>
> Should I re-spain a new version to fix the yaml check issue?
>
>  =3D=3D=3D=3D=3D=3D Checking the tree with the patch =3D=3D=3D=3D=3D=3D
> New warnings added
> --- /tmp/tmp.2uYmXlzyoK 2026-05-18 12:59:32.034644770 -0400
> +++ /tmp/tmp.UAwK6To8IX 2026-05-18 12:59:32.187643683 -0400
> @@ -0,0 +1,3 @@
> +ovs_packet.yaml
> +  3:1       warning  missing document start "---"  (document-start)

Good catch, yes please.

