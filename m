Return-Path: <netdev+bounces-60111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329BA81D69E
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 22:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20802824DE
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 21:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C671640F;
	Sat, 23 Dec 2023 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="SHnVoroo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EA015EBD
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7810c332a2cso220187585a.1
        for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 13:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703366675; x=1703971475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qenx+PVljo+d+w+KglCZPwIKp63V9DTGdmNKI9oulWQ=;
        b=SHnVoroowa+4467oNc+K3DjS+tQbOfhF/v4lXU+MLnaBXH21I8lBPjgUuiOqr7YK9/
         2k2kNAaVHlNxb2oGkLy6Rb1KCZXDfMRkt7tRT/0BIxttHiz33knBvfQVz34D/iUlh7vu
         hWGln91rsSiGjpyoVblmJOUVhzJ/rKeHxzgP4gIp3QkLaGZggECAmTba3HU600mCxEp1
         qs8Bi4bGzdArvPluUOguuW5k7/Xyj4A+cBIOtRsWZnAStWEyNl90dfnXyke/qezdxhVu
         fbxzq8Z+NHn2spvw7Dd38/zMfRqxxHXV/OWCavLzNrQe9byYZd+8OTwxGv9bOFrwUWMs
         6hkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703366675; x=1703971475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qenx+PVljo+d+w+KglCZPwIKp63V9DTGdmNKI9oulWQ=;
        b=DpsIWHdZqLkFxG+GBaM6S1SGEfRtWAkXpxmY/z3iWw6NUVN4J5gpXNG0hdRSByx+Z0
         WEBiHIERWUtSqctj+AFi+9R0jeUEANZyGLX72SJqRtBzvVq1G4Oy+LZgfgSO9ZVfrPzb
         sYhozRd2sj3OkbObjtRYcmNmzkoo705/vfvaMr2d7qESeWnW+BUOnnS2QNQ5IJANvV55
         GWdEg5q/lWYgTP8xv8sa+KSFXTJlzwc3O+e/xSkjQL+lpiLEv6cipvJYnfaRFsaseYsU
         YSn5HFtMwj7N1/IBaBABgJpyw0BrVIyoYfpSN/9KYAtb2gOsVsRFzKsyVLTtqM8QUskq
         hujA==
X-Gm-Message-State: AOJu0Yx1jcrOnwZswGHfPNZMOkL26GAYnebBPZxJ10aGkXksCG2i9Jl0
	qsmeuQe29fw9BB9bYjQpOvO02EYgFVd68djglYQbI94hJ/adiOOLcqVwzD37Mg==
X-Google-Smtp-Source: AGHT+IEl29DTeUpkDfSCStgPAPgNUbLYYhvnX3W1dvPK3DDip8gsUO2kTnrkeRhU3IMme+F7YXU0WPbAQbe6hCTOmKE=
X-Received: by 2002:a05:620a:3712:b0:780:fb4a:404 with SMTP id
 de18-20020a05620a371200b00780fb4a0404mr4957344qkb.125.1703366675560; Sat, 23
 Dec 2023 13:24:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222173758.13097-1-stephen@networkplumber.org> <20231223123103.GA14803@breakpoint.cc>
In-Reply-To: <20231223123103.GA14803@breakpoint.cc>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 23 Dec 2023 16:24:24 -0500
Message-ID: <CAM0EoMnTmFfhePeHUoCQOt+qUuBcrKGeEgMsP3bs4FJ5g0aRsA@mail.gmail.com>
Subject: Re: [RFC iproute2-next] remove support for iptables action
To: Florian Westphal <fw@strlen.de>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 7:31=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Stephen Hemminger <stephen@networkplumber.org> wrote:
> >  tc/em_ipset.c                        | 260 --------------
>
> Not sure if this is unused, also not related to the iptables/xt action.

Not related, these two files:
tc/em_ipset.c                        | 260 --------------
 tc/em_ipt.c                          | 207 -----------

Also any changes in configure and Makefile affecting those two.

cheers,
jamal

