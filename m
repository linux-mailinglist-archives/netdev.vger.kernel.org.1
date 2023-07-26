Return-Path: <netdev+bounces-21584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFF7763F36
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37308281EE6
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 19:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389004CE84;
	Wed, 26 Jul 2023 19:06:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEA17E1
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 19:06:18 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E46E62
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:06:16 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so208932e87.2
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690398375; x=1691003175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ISopsp3GPjCEYylIemfLA0z3JmRG0JusuOWHSGEOLw=;
        b=Wyo2LaoVHtAiw2PazwAFDmQcirOzA6gP9C+wgO1nx2DyTeSWDe2UJT4YLSqbezPdXi
         FYtDoimOGsFJYfth3e4yqD0aQQCIlAZEvYrZJstJwIyZhZBqWxo2I2fHbgXhkZpRUsLY
         h0Ca7UDrIZ9c7yA/XeOF95zhnwrbRRHcS7fMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690398375; x=1691003175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ISopsp3GPjCEYylIemfLA0z3JmRG0JusuOWHSGEOLw=;
        b=MaNtil9ZMhCcnHV61Sno7evatzhpgAdy4D8DA30blT6whJZ3ONc+VbuI8W81UObG7E
         PJKM6BvQtugPAnNAP16d6NVvdaHf8CAM/r++pUCLQGblrFbchwhu5wjUuFKIWJuk0gfh
         Bx+nhgNU15Ry2P6Kt5K7B16pBhoNNAaUTUG7G12fNI0pdX1F6c5IAOPRxrEEegSy/p+3
         RQbg9LOXlDf4brm7dsagxmXCoY0TCu/vhl2xP1RS12yvrOO6vVujxhJmAQqmshKN8msa
         WlBrrtL9mpkJgCMYOqxEs4lrkc4pMGStt9n9BXwEXKw77Ua3Hfln6hMnc5kUWhAupRSA
         PXtw==
X-Gm-Message-State: ABy/qLbwfPG5z/1rDsN3viDRDJrCX8n8hXETDuXjde9iKawJUS1h6cCb
	EB2P8b91ZWPqik6jof5xkSHBjy61ocoAfAgJ7CqYfHQ8
X-Google-Smtp-Source: APBJJlEcWIPvCv4sc+pWWkMX6i0omfy9UlYJ66/I6q33UF0NuZTszgqjQtFxco1wKMHDZGsSavA3DA==
X-Received: by 2002:a19:674a:0:b0:4fe:676:8c0b with SMTP id e10-20020a19674a000000b004fe06768c0bmr59222lfj.11.1690398374801;
        Wed, 26 Jul 2023 12:06:14 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v27-20020a056512049b00b004fdc8e52ddasm3444951lfq.129.2023.07.26.12.06.14
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 12:06:14 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso245100e87.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:06:14 -0700 (PDT)
X-Received: by 2002:a19:c519:0:b0:4fb:c0b5:63d4 with SMTP id
 w25-20020a19c519000000b004fbc0b563d4mr42636lfe.43.1690398373839; Wed, 26 Jul
 2023 12:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230726151515.1650519-1-kuba@kernel.org> <11ec5b3819ff17c7013348b766eab571eee5ca96.camel@perches.com>
 <20230726092312.799503d6@kernel.org> <CAHk-=wjEj2fGiaQXrYUZu65EPdgbGEAEMzch8LTtiUp6UveRCw@mail.gmail.com>
 <20230726112031.61bd0c62@kernel.org> <CAHk-=wi9MyyWmP_HAddLrmGfdANkut6_2f9hzv9HcyTBvg3+kA@mail.gmail.com>
 <20230726114817.1bd52d48@kernel.org> <CAHk-=wiuR7_A=PbN8jhmqGPJQHypUHR+W4-UuSVhOVWvYXs1Tg@mail.gmail.com>
In-Reply-To: <CAHk-=wiuR7_A=PbN8jhmqGPJQHypUHR+W4-UuSVhOVWvYXs1Tg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Jul 2023 12:05:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4pbrNZGqfV9u1urZr3Xjci=UV-MP+KneB6a5yo7-VOQ@mail.gmail.com>
Message-ID: <CAHk-=wh4pbrNZGqfV9u1urZr3Xjci=UV-MP+KneB6a5yo7-VOQ@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from using
 file paths
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Perches <joe@perches.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	geert@linux-m68k.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org, 
	workflows@vger.kernel.org, mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 26 Jul 2023 at 11:59, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> You're already using 'patchwork'. Why don't you instead go "Oh, *that*
> tool isn't doing the right thing?"

Christ. Looking around, patchwork *ALREADY DOES THIS*.

Except it looks like it might be set up to just complain
("netdev/cc_maintainers"). Which seems to be why you're complaining.

IOW, you're complaining about *another* tool, because your own tool
use is set up to complain instead of being helpful.

I'm now even more convinced that that warning is completely bogus.

No way in hell am *I* going to bend over backwards and add some stupid
new rule to my workflow because *you* use a tool that is a whining
little complaint-machine instead of just *fixing* the problem.

Guys, tools are supposed to *help*, not just whine about
technicalities and make it harder for everybody else.

So just fix your tool. Don't complain about *my* use of another tool.

                 Linus

