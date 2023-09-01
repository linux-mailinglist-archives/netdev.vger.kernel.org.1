Return-Path: <netdev+bounces-31731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D35A78FD33
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 14:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C14A1C20C67
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 12:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A599BA53;
	Fri,  1 Sep 2023 12:28:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6DBAD41
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 12:28:54 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FF510CC
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 05:28:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so8162a12.0
        for <netdev@vger.kernel.org>; Fri, 01 Sep 2023 05:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693571331; x=1694176131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1I6dpx5TUvkoEh56JEMyzHdi0osjSjPWIDUEWZsPuU=;
        b=rvM0gAhDWAou9kQB1YjnLXb3i4me0qEkmyY8yuGiX7UUxl76FEMAYU12pr2KRAeG28
         sw5v/dP8gZenp7RCpmI8EY6G2zY8mCBRl+x14yUsC+TOSULDeMfJ/Xev3Cj0ZsRjzr6X
         76lTCBV7eilggzpMTpGVO1lK2aeImo10oaRA4JgE/bVVD/ZGpJiAQuPDGuLB2ldBQSne
         bQEgbHlilc30OOSPKSkmqn73L1/HOnMm6HnJPEOYbisyOU1LZGI1kLgS3RgC5IIG4qbL
         q9QxVTR2kS3uBtJdW0n34B45PBd7RvIZCGBSz6DfLeQgW1IfNW+9Lva42LVTC+3vbrOE
         ml7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693571331; x=1694176131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1I6dpx5TUvkoEh56JEMyzHdi0osjSjPWIDUEWZsPuU=;
        b=Fr1Un/t72RLSL/5rGuvntapSj42QB9z+rBgK0jxPDHw/amIrmU8tB8t28IhYNyLgAe
         lKroac6oawEW2L84UckAi7WhIM85GbwM2Yc4ji2fhkKrW34uxzZrq2Yncdh5ULrlSoLd
         TLUcOiczOkKU5y4sjVoTiBdus9g0ouKGp34K9WZcTMjmNv++LSLXHR7qXBTftcd4ZpnT
         PArPgrko4jCQ/xQ1q6kSqGNWwfEy+s+kKLrseWeFZYgFpQStrAs2UDoUNdec5GM3r7k8
         MWeLrvaYQDNru+SaH3N0ZuX+SGQ2p/Xfb+oLgw321BQN2HIOj5oiDyr48r560TBPx95s
         5oow==
X-Gm-Message-State: AOJu0Ywq0H1RijdK3A4vfmD6mJSb4JJMmYcPQh1AYS4tcIH7n44UyBpz
	7yyRfjqxThKKW3rKBsChgwBkidYL2vTcpd1f1bUGdw==
X-Google-Smtp-Source: AGHT+IFIBLQiVlMj8bo8BxSFikphD3uKWvzg1eE7vOLenZ7xS6hW5kH9XwxQdd6iZmktD/GoAJt1cIajikiHK/TkjDY=
X-Received: by 2002:a50:9f84:0:b0:51a:1ffd:10e with SMTP id
 c4-20020a509f84000000b0051a1ffd010emr96127edf.3.1693571330962; Fri, 01 Sep
 2023 05:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230606140041.3244713-1-ptf@google.com> <CAJs+hrHAz17Kvr=9e2FR+R=qZK1TyhpMyHKzSKO9k8fidHhTsA@mail.gmail.com>
 <7aa7af7f-7d27-02bf-bfa8-3551d5551d61@gmail.com> <20230606142907.456eec7e@kernel.org>
In-Reply-To: <20230606142907.456eec7e@kernel.org>
From: Patrick Thompson <ptf@google.com>
Date: Fri, 1 Sep 2023 08:28:39 -0400
Message-ID: <CAJs+hrEO6nqRHPj4kUWRm3UsBiSOU128a4pLEp8p4pokP7MmEg@mail.gmail.com>
Subject: Re: [PATCH] r8169: Disable multicast filter for RTL_GIGA_MAC_VER_46
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, nic_swsd@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

I was wondering if this should be extended to all RTL_GIGA_MAC_VERs
greater than 35 as well.

Realtek responded to me but I was slow to get them packet captures
that they needed. I am hoping to restart things and get back to this
over the finish line if it's a valid patch.

I will add the appropriate tags and annotations once I hear back.

On Tue, Jun 6, 2023 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 6 Jun 2023 17:11:27 +0200 Heiner Kallweit wrote:
> > Thanks for the report and the patch. I just asked a contact in Realtek
> > whether more chip versions may be affected. Then the patch should be
> > extended accordingly. Let's wait few days for a response.
> >
> > I think we should make this a fix. Add the following as Fixes tag
> > and annotate the patch as "net" (see netdev FAQ).
> >
> > 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
>
> Perhaps it's best if you repost with the Fixes tag included once
> Realtek responded.

