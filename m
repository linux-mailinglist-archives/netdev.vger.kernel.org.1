Return-Path: <netdev+bounces-18155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A80537559CA
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 04:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6305F280FF8
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 02:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25961365;
	Mon, 17 Jul 2023 02:57:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70831846
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 02:57:21 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4751BF
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 19:57:20 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b933bbd3eeso23507481fa.1
        for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 19:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689562638; x=1692154638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qw8+GHVSbi9gLX1cn6tcsvnRawby8bgkKMYKtc1Otzs=;
        b=DYCTFUR7oCkYqyUAtv7I+k5dgtKp8coaF8yfKCv3sgLopBisQF5GmuC1vXUl0RXLTk
         5NlqmYOgW3hkirsAV6mfby/Z5IzxNW/MnvubIbf+2NQt8yjkqKL7gmafk7I8EskZkZP3
         vZQEztauQhWJkCJ8q6jQNL6iU5wnflbVsf2XvKh5vSUh1FpiZipO0a+ZTVHbr6/0RTi9
         +1fQOtcgYcFI5pE+fgMctt6cB2r159beCJfTyzYqaezD71l1G8Hl2k7BOI7VXcdReUUD
         niiYyYhP9ulnVS4GxKG0Q+nMHa/j6KdtG0O9UAUhBMqwWwZsPJ+yJPRj6tMhpEvZlRbi
         lsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689562638; x=1692154638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qw8+GHVSbi9gLX1cn6tcsvnRawby8bgkKMYKtc1Otzs=;
        b=Icwx0/u8tTWcnbtYPBf1aILoE12yMjU7G5+FBJhdJzv1eAstaoBqPVxMmhsDzBIsI0
         N/tppGb0rmzIfmlAoXCzpPe7s//DZaDZzbBxCnZZuAqHOeSpwDqX7BZ+4zlRWmP9vWHY
         zsvtpdTiZWmaH/piqLZ8AJFWu0zJETrZuZOaFwaGWTZje+Shj0orhaS3SRdlCuQEeURu
         a1M0OyZzVAHAWXLHw0B467mE/RXHGvmOL4c1ZOwhF9se8DLLmXB6077ASmpDJh6B/KX5
         HC0dECS3wxEW2H9vYjVj4qc2BvyS9m31QxvOxVCIgBKO1GR5+nga4PLWKudpjc9V7k9p
         6gjg==
X-Gm-Message-State: ABy/qLZIuynmfjTeEpbiGBoXiyqwfjEe0YghG9KJh8xUFSJc0MhSfAsO
	tmkrIHmjjNLQ2QGbVozGhejnyoi+aUCzlA+BM1E=
X-Google-Smtp-Source: APBJJlEpgyErG5ziV138PL+k/YxbGs9oWFuOpX3yEEDsEp9C9cLg4pRYBvMpJrWe2NUvOB22bGg3IG0Xmz8jcObH7vE=
X-Received: by 2002:a2e:9059:0:b0:2b6:9ed0:46f4 with SMTP id
 n25-20020a2e9059000000b002b69ed046f4mr10393631ljg.23.1689562638285; Sun, 16
 Jul 2023 19:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689215889.git.chenfeiyang@loongson.cn> <2e10d9d1-e963-41fe-b55b-8c19c9c88bd5@lunn.ch>
 <CACWXhKkUJCFV8DKeAOGPQCfkn8mBhZvBJBMM8SYVgVKY8JEyRw@mail.gmail.com>
 <ZLEJq1G5+7I+FsPo@shell.armlinux.org.uk> <bf0299ea-93d2-43e0-be9f-2d8786678b9a@lunn.ch>
In-Reply-To: <bf0299ea-93d2-43e0-be9f-2d8786678b9a@lunn.ch>
From: Feiyang Chen <chris.chenfeiyang@gmail.com>
Date: Mon, 17 Jul 2023 10:57:06 +0800
Message-ID: <CACWXhKng+LRPY4rjgrATtt9K4hx1bBt8CEMSyg0b5cpzFA0kyw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] net: phy/stmmac: Add Loongson platform support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, chenhuacai@loongson.cn, 
	dongbiao@loongson.cn, loongson-kernel@lists.loongnix.cn, 
	netdev@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi, Russell, Andrew,

Thank you for your insights on RFC patches. I'll remove the
RFC in the next version of the patch series.

Thanks,
Feiyang

