Return-Path: <netdev+bounces-16555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D20074DD19
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E8E281126
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698DA14292;
	Mon, 10 Jul 2023 18:10:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E75F14290
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 18:10:03 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A886F128
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 11:10:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso7575971e87.0
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 11:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689012600; x=1691604600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0y0QnBCtE+6dspZdtNusgaiPuJYJ/+guSWc4VqPxJn4=;
        b=pXnP/rj3FxkOpm1npOLwh33cGMkWAHTc71iJBggi6fKWsSKCT9Zqd2d91D0lOutpRj
         E9navVx4voIWi13wcegLu7MGNBPH/kA8pEMl3CnyxcyTXxgl1nvK81tKaExoEcjZc/3U
         SnjEF4hF4yle0O8vSGZc6TAVGUmOSYOJpLLUpPUGRVa6rZ9icEU6htSCYbMoG+jUA5dN
         7ZPGzOEuDss7U/id72gh/vmcWE1IvqVByxifODsqMNvNHaFIdCCidLAGjv5oWkYzfeSW
         ZWoYdPSithmgnN3SmDFrLaRJLj2E+FZasSKnaMbqITO5lQ+vPEbxjCcnPih4zT9ts4WV
         UWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012600; x=1691604600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0y0QnBCtE+6dspZdtNusgaiPuJYJ/+guSWc4VqPxJn4=;
        b=XQTTkc3SenVZHOoYgUVUPm6pz3ejGHSg9klW8wJX7fgxFMVvtta2wksk3goA7P5OBS
         pMTdNhrGikjn1wG3LADJJ7xCUs4pDQMOOApFFH3NoI/3eIe7GKAILGp4kMBBx8Lru0O3
         Zne6Gl3s8nk8FWvRLb+fjJZHm+ogPYClf66z9dGTjGIthTsOMFsMtc9Rx7BdSEPlaS6n
         kkRfYUw8HRS/ikY4k6PTqtt3QKWVceILnn3C9+/qZu8tbwo8jjm1rJSrVLxUCIejhR3W
         OG0IwITwZisFA97mZcfbwNkO6HR0NtP5qb9uRazrGxa+0BceG7jxIXrdgqkqpyAqvDFj
         ovaQ==
X-Gm-Message-State: ABy/qLYntDGQ3g1faXs/N/tt8EpH7S8606AhGvxBJ1QMXKWUEpEsgGm3
	Skvh9xsAb6peKnRzITLC3sSoTMU1uCSMbORcMH8=
X-Google-Smtp-Source: APBJJlF1AZwoIAemAKurcDmG/ty3g8O7NrutT+9xIYRYHEDytWWx7RrTj19+Ec9puY5sDsESSr2Q04WEcBVKk1s3OYk=
X-Received: by 2002:a19:5f5a:0:b0:4f8:e4e9:499e with SMTP id
 a26-20020a195f5a000000b004f8e4e9499emr10285174lfj.12.1689012599663; Mon, 10
 Jul 2023 11:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com>
 <20230710123556.gufuowtkre652fdp@skbuf> <CABikg9zfGVEJsWf7eq=K5oKQozt86LLn-rzMaVmycekXkQEa8Q@mail.gmail.com>
 <20230710153827.jhdbl5xh3stslz3u@skbuf>
In-Reply-To: <20230710153827.jhdbl5xh3stslz3u@skbuf>
From: Sergei Antonov <saproj@gmail.com>
Date: Mon, 10 Jul 2023 21:09:48 +0300
Message-ID: <CABikg9xc5PryyT+b=3JsJoHppe+tfOs+BWrq+kETQK99A-DG=g@mail.gmail.com>
Subject: Re: Regression: supported_interfaces filling enforcement
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 10 Jul 2023 at 18:38, Vladimir Oltean <olteanv@gmail.com> wrote:

> That being said, given the kind of bugs I've seen uncovered in this
> driver recently, I'd say it would be ridiculous to play pretend - you're
> probably one of its only users. You can probably be a bit aggressive,
> remove support for incomplete device trees, see if anyone complains, and
> they do, revert the removal.

Can mv88e6060 functionality be transferred to mv88e6xxx?

