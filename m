Return-Path: <netdev+bounces-33488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3891179E291
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 10:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651C21C20ED2
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 08:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3491DA49;
	Wed, 13 Sep 2023 08:50:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5BD3D6C
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 08:50:11 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6DB199F
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 01:50:10 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-64b3ae681d1so35944276d6.0
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 01:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694595009; x=1695199809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QR0C9IltByE4WTVNYvS06u17NgkMZ1JnrRatbagUiLM=;
        b=fDwubKgerw1FNVrQ6CoV92EK58pbRzT6FT57zm+aYDHQxVcsDfiQEqS4u4C0UymhyD
         A63mG+dcehHUo8sWviH+8Cn293QdE3dJrt8GokgLubzuUWe9i5M1FZ7+wIU8+X36HbAF
         3L1ZsT5H0ZERnUClieNbpcku1ym9zZLfJZiEvMJC4+ayBo5+kBErXgghku3Xy7DnkTl6
         qCBS6NmrjVxInbugVWv8RMGAv4vuIRj9QQUuSNXbOzU078Ky5ILkFvElehCG3yY16nlR
         1CrmAGfmlqFNbet184t3ll8QGfUamMaz4jsmY9DMcK79JnVW+Dmx3Bqvrp51W9Brl0Rr
         kw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694595009; x=1695199809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QR0C9IltByE4WTVNYvS06u17NgkMZ1JnrRatbagUiLM=;
        b=KSVVIB3Z+KR7Bzrmk9FufWhKYctogNYxKi79LhJPEjq1DrzSkx167PyFFQtuqsvzAd
         HbUzlXaqHpTEEOuReNPRckHcngzV5ISOMT90cC+pvqfqKRHqprq7Z/CdqB7tOAuOykDS
         KWQ2D1BM1Wog65mbwb2kwzntYkamMBPJpjs0psR5LSUa/+OCbKFbxuKAJUBQwAXcLq4z
         z2gwbmsA9wptjNg6ygjVkz3P8Jo5wvbcOXdMY4o2nTvmlUfSqo3G9/u04U99YgBFOzIs
         CEGlvePBF21jZ6fF0wZNKvCR8KsSyO9W+qlbvNxZle+E0/aTg7sTJGPw3Brjs6lAQYbG
         v6zQ==
X-Gm-Message-State: AOJu0YwXR/yn25irPOlFTXYfBM/YSqvQ6Y/LfGS9047sblk/ShZyZN0z
	5k2KArjIXj2PploR481x+BLmPo7OsfzaiW9gVyyiMA==
X-Google-Smtp-Source: AGHT+IHfefpOQ4AaU2QtUQKtJmgY+w+7pHmPAOv8antMQ+Ca7BJD0r2Uaa8XguLy2DJegatayAyZxrLhguUEel112rg=
X-Received: by 2002:a05:6214:4381:b0:64f:8c96:cf1 with SMTP id
 oh1-20020a056214438100b0064f8c960cf1mr1835471qvb.47.1694595009509; Wed, 13
 Sep 2023 01:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912134425.4083337-1-prohr@google.com> <ZQFu/SXXAhN10jNY@nanopsycho>
In-Reply-To: <ZQFu/SXXAhN10jNY@nanopsycho>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Wed, 13 Sep 2023 17:49:58 +0900
Message-ID: <CAKD1Yr1hzYpAU1jMN964c5U+e2-bGcPBqZsHA7_Lg-rH1iNsow@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: add sysctl to disable rfc4862 5.5.3e
 lifetime handling
To: Jiri Pirko <jiri@resnulli.us>
Cc: Patrick Rohr <prohr@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Jen Linkova <furry@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 5:12=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
> >+      - If enabled, RFC4862 section 5.5.3e is used to determine
> >+        the valid lifetime of the address.
> >+      - If disabled, the PIO valid lifetime will always be honored.
>
> Can't you reverse the logic and call it something like:
> ra_honor_pio_lifetime

Maybe accept_ra_pinfo_low_lifetime ? Consistent with the existing
accept_ra_pinfo which controls whether PIOs are accepted.

