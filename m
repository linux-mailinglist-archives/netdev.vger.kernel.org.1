Return-Path: <netdev+bounces-26523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CF2777FF6
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D81E1C2031F
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EC121D2C;
	Thu, 10 Aug 2023 18:09:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F64214EE
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:09:44 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA6EE48
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:09:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52307552b03so1527755a12.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691690979; x=1692295779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1LYHLAFsJ2nEzWLE4J0Xt0KOPPJPB+YpToOfsh4q+4=;
        b=fD+ndgsLZNk+5CUHd7Ev1qfqGT33xAjNauhLxKBa+TW8RM3ooQPg4BKoY1sildXwqA
         gMirgc4ob0jOL/3jOidGvnX+wh1I8YF102jiVbv/NW+IL75t1hnEXY/Kssu/crGTd2lf
         /Snc7NxhxYsxFRfiB15ERKn4VQtOAHnWcrIdAsksnwhdXneSVMxlbYol2fzvZvQsmPe0
         Bb7+lLIrFOYWl1b0tOLmVGKpZva48uo/2sy3fWZHNWaMGjU7u04U0f/3CHfSOsKOYGAZ
         DeDp7tdK3iS/UtT5/1RH60sjcSMtCvUVH5l5zwsqboC8vQBTm/Dmh82I4xBhMFHqWDeA
         QgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691690979; x=1692295779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1LYHLAFsJ2nEzWLE4J0Xt0KOPPJPB+YpToOfsh4q+4=;
        b=Onl87aNHcFfbyoJe5Wg2wI379UcI35dakkETb1vkn+cKpTO7uR8qxAZz+U+tWo+Efb
         o0ylKrsUoQIwLFfqcf0zYoXxDKLlPxmmyT1send5TLEsvmcYgDM8V7BU+ojZePfDNJFK
         a9w78xeqIAWTKJbS2bhhBjhnnDEV6Oz0rHiRXLr6UkOP0RIVuMxtik+n5aXQwUQ6dGfI
         t0Sdv9Cne+68wrJLoA/mq1fj/XMQ7iSwBp0ohHuK/+n1CWpy8E3gDgscGEKh7HQLPHcK
         V94AdUMWx9NZfb9C7iZAWuOmQpeQvRpsUpdJcG1gkgjv45VoLB3fSpaZe9m94DghsDaG
         y68A==
X-Gm-Message-State: AOJu0YyJ2cZfkeoRNa7LabmlUirBnSx5U77RJYypY7rxvmx4CdA6IFjM
	vt/Kb+HVMsK2jzX4tEzFNxHCyh8HHHRKqsavQK0=
X-Google-Smtp-Source: AGHT+IGhy6gBByrhVqWQze40PKhn/qqoHp8KQXm2HFwG7/h/94Zn0mCejuFIPVgZdh/TaSQ9s21zB/fHJXRf/lWjuzs=
X-Received: by 2002:a05:6402:1298:b0:522:2019:2020 with SMTP id
 w24-20020a056402129800b0052220192020mr2447490edv.17.1691690978816; Thu, 10
 Aug 2023 11:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk>
From: Sergei Antonov <saproj@gmail.com>
Date: Thu, 10 Aug 2023 21:09:27 +0300
Message-ID: <CABikg9zXYx0szwCSGss2+8AaSWr-iDDtiy-+StJUcZxDEht3wQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6060: add phylink_get_caps implementation
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 9 Aug 2023 at 17:46, Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> Add a phylink_get_caps implementation for Marvell 88e6060 DSA switch.
> This is a fast ethernet switch, with internal PHYs for ports 0 through
> 4. Port 4 also supports MII, REVMII, REVRMII and SNI. Port 5 supports
> MII, REVMII, REVRMII and SNI without an internal PHY.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Sergei,
>
> Would it be possible for you to check that this patch works with your
> setup please?

I have tested it.
First I reverted this commit:
9945c1fb03a3c9f7e0dcf9aa17041a70e551387a net: dsa: fix older DSA
drivers using phylink
So I could see the issue reproduce.
Then I applied this patch and - yes, this patch resolves the issue.

I haven't studied the code carefully, but because of testing:
Tested-by: Sergei Antonov <saproj@gmail.com>

Thanks!

