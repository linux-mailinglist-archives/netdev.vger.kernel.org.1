Return-Path: <netdev+bounces-13121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C5673A58B
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2972819DE
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 16:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D481F959;
	Thu, 22 Jun 2023 16:08:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE993AA98
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 16:08:30 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2795199E
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 09:08:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6664ac3be47so1405992b3a.0
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687450109; x=1690042109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHrAtr63CDFrvYf0AIAGl5pyNC5ZfXwpcGvrXF7zcyI=;
        b=SL4BbeC8SiZr06bXNGLsW9Otclfx93ba9ROrRtCenWhyk91HS+UT5Q5QDldFFWQ2Pq
         tCvtovQ1zMc3ROXLgFfStAICxHu88Pd0MsX4mC8RYCAPTnvfAh592Nl/nHNDGYWJeJEm
         3JW8cJrOqk+hGvurcSZCgKpOC72/dQRM8a7y3o0nL8iMnmXX/lA2VYmuz6VtZIHYfdYR
         7jRsRV2C108Ah2yKtv9PW7lvBoGdbdUUGN8xouWv91AXTfzMl5B7reRr5N/nrzT7vnpJ
         SGyaSSlHHitIZFYstLxd1p9I336CCQ926fV9M4QEE4lrAJ8nog5U1QDkLgChy8nLc7Y6
         1fGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687450109; x=1690042109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHrAtr63CDFrvYf0AIAGl5pyNC5ZfXwpcGvrXF7zcyI=;
        b=GWPqEFxOzeMqVcSrPK9ObPqrL+n23/ll5RzIDZQRmVyoq3BZA9ldIcXyzbBE3RvEM0
         YFVg0cyHmx1ZzB+Me5Wd5Lc68H41J9jcEMqwcKSyVWWUZw8KE2TIJmrRZnO0hFU/3Ydr
         l+LrrwgI8WZiYCLdfIfP/KezB9VrFu/Fmyy/Dfhzg5Q7nWtiUhbq03xoIrqi+RSssne5
         5q2YiJKdEEUauUK5A9af2RxDHneAhFGvb5XJZ0SXeh8kahJ7hmciS4smLnNgLRFNRm4i
         LGySblJcyOkJzPwwed8RUL+/8h5/vVocLpaUA3m61c0P4wyX2C5Q/iO0aM27qlq1sD5n
         yTZQ==
X-Gm-Message-State: AC+VfDyKMvkh0cf6ZK0IIs3kIJ8Bm4t8z2t6qk+gs4mA0L52rKKgliqO
	EHDob1KIpLmVDCIH/YUDVMXmmc+TAXfiEQoh5kCj7v4H9AY=
X-Google-Smtp-Source: ACHHUZ6zR7WFYj5oFZciOo1azDwneNEf1CVfTyYTfTpVbKgAXNGD8iyZ6ISiqUOYPMwJBqCBUyGjAdMYuPgTBQck/9w=
X-Received: by 2002:a05:6a00:3985:b0:668:683e:a3f6 with SMTP id
 fi5-20020a056a00398500b00668683ea3f6mr15603802pfb.2.1687450109017; Thu, 22
 Jun 2023 09:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5AdPZfQQEfSgW-Cgw2GySerc0oxUu4OEcQoxwVeB+wQWg@mail.gmail.com>
 <2647dbfe-860d-4a45-94ed-d1d160d9a3be@lunn.ch>
In-Reply-To: <2647dbfe-860d-4a45-94ed-d1d160d9a3be@lunn.ch>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 Jun 2023 13:08:17 -0300
Message-ID: <CAOMZO5DvxFLxmzKzKBVdJkyeLgAJDDGu6aCT9dUY=coNFGXXuw@mail.gmail.com>
Subject: Re: imx8mn with mv88e6320 fails to retrieve IP address
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrew,

On Wed, Jun 21, 2023 at 6:43=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> So this is might be down to symmetric pause being negotiated.  You
> might be able to prove this by hacking mv88e6185_phylink_get_caps()
> and remove MAC_SYM_PAUSE. It should then no longer advertise pause,
> and so the resolved auto-neg should not have pause.

Thanks for your input.

Just upgraded to the latest 6.1.35 and the DHCP issue does not happen anymo=
re.

Thanks

