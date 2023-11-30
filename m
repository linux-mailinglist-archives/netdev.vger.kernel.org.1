Return-Path: <netdev+bounces-52416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 083477FEAFB
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CA0DB211CA
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 08:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB832D606;
	Thu, 30 Nov 2023 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpvqXzIy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCCE10E2
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 00:39:26 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so6881a12.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 00:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701333565; x=1701938365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNav2MEUYxomWdlekB/cfRgdHTUz7LNcPyW/u3GPNtg=;
        b=gpvqXzIyB1//t+XmrMDXcpsyn60kbfisGn+XbPN6CogTzpkZzN637dBwHbV670ea5z
         fKTIhhfluMtU65igkxDGCz75oROPD2vDNlBFBpg0zhGTm478kegDf2ST5I8WJGP3d1E1
         l4oBUJsEPYxHw/Ea4hXV6ujVfARd6+M9WXsVKLMP6AX73YVs8SAjvgFdY34ZR+0qPC68
         SAAlGt66ZU0uU+WfvzJ8GujvYx+uA5OWCo/U6euxthg3ouLYUTZnfynlDXBrQfCDYExM
         bLjPMjGZCdZSJKIsgrOFJmNsMa+fY10rOnBbUZofacSQY6VOICTHd2AO7o84WoXmzNvG
         IdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701333565; x=1701938365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNav2MEUYxomWdlekB/cfRgdHTUz7LNcPyW/u3GPNtg=;
        b=DXVEN3LqBo2PWvEOVntoKUyzySkH9psUF9Vmd6W61fLIaZOd4p53/cxLpErJKWdBqy
         rNB7cehzQ2E8ttmO9VLLkb8I6S+Ul8+3V1eN+b0IxDhBlv/3Lcl/Lz/zNPX7G+XlGnKO
         9H2BEY5a43j3KEqC8gSLIl52Yr2+oEvlpRZBWEXcJ9Uaj/AIGc8u/ZIFkiVBjccc1Hq5
         6h3ON4WQTJe5Y1/G/dRiSACIard5eES1x/NgosqA65UJWdxE0FeggCyB8lAp+quC+0Wn
         inrS+2vDnZTz7SAZ5ypJBoba/69q4d0Xnd3dCq6AvcOs+Ugda/tthIjUyfxRecMHZW11
         yw/A==
X-Gm-Message-State: AOJu0Yx8JE9JNI1EOkrwlbJzEe1PGvUhhXvl/mhINmryF7iiKxGBhy7s
	cI2VAS/MD5tVk7yz+w7KPBw4TtssS6MR9XyzdC86Ow==
X-Google-Smtp-Source: AGHT+IHEVYYBrVItFxZDzJOCGTJxPEFfT5vPA2+6IQgNSKQGV+De4+z0ginIjihoHCxMdzYrw4mpMpmrfvPjyUzv2b8=
X-Received: by 2002:a05:6402:1cae:b0:54b:81ba:93b2 with SMTP id
 cz14-20020a0564021cae00b0054b81ba93b2mr114502edb.2.1701333564532; Thu, 30 Nov
 2023 00:39:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129022924.96156-1-kuniyu@amazon.com> <20231130003349.60533-1-kuniyu@amazon.com>
 <20231129201905.1959478b@kernel.org>
In-Reply-To: <20231129201905.1959478b@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 09:39:13 +0100
Message-ID: <CANn89iJU=dm0hHqd6iSYXCMapcnCEUC=sKiTDdX1DvAkY+rHsQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 0/8] tcp: Clean up and refactor cookie_v[46]_check().
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net, horms@kernel.org, 
	kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 5:19=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 29 Nov 2023 16:33:49 -0800 Kuniyuki Iwashima wrote:
> > I just realised that Reviewed-by tag for patch 2 of v2 series contained
> > a wrong email address, and I happend to copy-and-paste it for patch 1-7=
...
> >
> > > Reviewed-by: Eric Dumazet <edumazert@google.com>
> > https://lore.kernel.org/netdev/CANn89iLy5cuVU6Pbb4hU7otefEn1ufRswJUo5JZ=
-LC8aGVUCSg@mail.gmail.com/
> >
> > Sorry for bothering, but it would be appreciated if it's fixed while
> > merging.
>
> Fixed, thanks for catching!

Indeed, thanks Jakub and Kuniyuki :)

