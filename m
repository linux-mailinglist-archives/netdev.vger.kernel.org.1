Return-Path: <netdev+bounces-36585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F94D7B0AF9
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 19:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6CB292819BC
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 17:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27DE34CF3;
	Wed, 27 Sep 2023 17:21:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9410D2F4D
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 17:21:09 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D881EB
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 10:21:06 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so27917730a12.0
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 10:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1695835264; x=1696440064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yq/3PHzaqjD8i+n5bG1U7HeS1jTpmJAlcQZIv2pI2FA=;
        b=ZEQmvqSqTwDZccMiqkSMUCoSRlhgkZM+XLXlxHXCp9+VUNm5md0eJ63bECqmlrDSP/
         4cJOfEHnC14wG/bMQQI7x84yZhZOvzKz8Yg6XlDBEXGZm7Xvt5v2IrDDl+cE5n0d3GOp
         soH+OkAghktJgDVLUvV2nErUxvgvazXH3C7q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695835264; x=1696440064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yq/3PHzaqjD8i+n5bG1U7HeS1jTpmJAlcQZIv2pI2FA=;
        b=VzEGwwasD6WdE9i8yCRxa35f+qo8QGJ9Uif/T3oY2oo0X+AlqaLqPztwZRlg6sYDDG
         Zqf9sUq1FnjrGoa9e8jrdJV2pT8yRJdHeEIkRt8zIFqBGEf13h9XKkm7BZNG78HgdHGk
         OresZKwFXpKZEP9BzcNBFSEETcuGoGeqm7K6KOyjtWeiH+LBhKd9x1amyGZSbHPHEk9j
         /bB+i1QvwAxVv4eodwScNmkJ6sTXaQUI40iBBK+Cbte2KXVtCsegRFTDyG2Rll/oKNB6
         J3sRTqY+iAMkL5kS+6V20F7QsEp0M5uTfnZc8YvjqmKVDSmqx6GSlLnhTIqX4JQN2Z5o
         DM2w==
X-Gm-Message-State: AOJu0Ywd0UvsHGoRl7Yk3j9dbF1it05B4Hxa6Ipu6o9En111J93jUFJz
	sEhDhbPxw0K2DmOLhlDc6OYSINvxs8ENLgP7kWWw9q98eUZ7OnQ8
X-Google-Smtp-Source: AGHT+IFOhuMG/IU0ewf1FfQJTFtD7Im3bh024hBUHfH0oQpj7d7WrfNzneCPLEbA+WeA28eI6ZaFEObbSg5z9KUk+/E=
X-Received: by 2002:a05:6402:520d:b0:527:1855:be59 with SMTP id
 s13-20020a056402520d00b005271855be59mr9440635edd.3.1695835264126; Wed, 27 Sep
 2023 10:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927035734.42816-1-michael.chan@broadcom.com>
 <20230927035734.42816-2-michael.chan@broadcom.com> <3ff0cdd5-0b4d-4868-8b0b-21e08416561e@lunn.ch>
In-Reply-To: <3ff0cdd5-0b4d-4868-8b0b-21e08416561e@lunn.ch>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 27 Sep 2023 10:20:53 -0700
Message-ID: <CACKFLikQ=q2TfEYrJhEemDqmK5HBFJxTJORrKTriL2SMCgLYxA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/9] bnxt_en: Update firmware interface to 1.10.2.171
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 5:34=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Sep 26, 2023 at 08:57:26PM -0700, Michael Chan wrote:
> > The main changes are the additional thermal thresholds in
> > hwrm_temp_monitor_query_output and the new async event to
> > report thermal errors.
>
> A quick question. Is this backwards compatible with older firmware?

Yes, a newer interface is always compatible with older firmware using
older interfaces except very old pre-production interface versions
below 1.0.0.

>
> > -#define HWRM_VERSION_RSVD 118
> > -#define HWRM_VERSION_STR "1.10.2.118"
> > +#define HWRM_VERSION_RSVD 171
> > +#define HWRM_VERSION_STR "1.10.2.171"
>
> These don't appear to be used anywhere?
>

In bnxt_hwrm_ver_get(), we exchange the major, minor, and update
interface versions (1.10.2 in this case) with the firmware (but not
the reserved version).  All changes are compatible but a major or
minor version update may introduce bigger changes.

