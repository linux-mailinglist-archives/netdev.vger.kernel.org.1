Return-Path: <netdev+bounces-18049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AC6754660
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 04:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B66F282327
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 02:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFA47EC;
	Sat, 15 Jul 2023 02:46:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C39B39D
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 02:46:42 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036BF35B3
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 19:46:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-66c729f5618so2527522b3a.1
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 19:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689389199; x=1691981199;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6vZE/UUght9xIV7fPffGlP9HlXq9aIo6BQfZSH7He4=;
        b=lrk4xh3PBqWbzwMaSSulSdVgFlSzQrl3q0duGv3Uq1VrehoRDou/1nyMY4PnpVpxtD
         xzzGgySYQTiy0yqxKLZvF4u3bbzrYLpLcajYkFsfXZm8uhZSriydVS79Lhpsq9rO6Ist
         T91UIT4jE01x5hMloc/kRF0phREM4qix2d6ce13frVYtLpebZWCb4XxWPTk+Q2zPSrIN
         z0dZDzcA+2mbIrS7vQKnY7tZ379ff38ttzUD0Yob3qaFC81ccKMHsiO+1wDRI4RlIZMB
         hQ/cuIIweKiY5b6NWvup9Noq2jpVGtqWRd+y88fd00aopHEXTeO0cVhmq6t0EMRS49JQ
         fILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689389199; x=1691981199;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6vZE/UUght9xIV7fPffGlP9HlXq9aIo6BQfZSH7He4=;
        b=P6pzhhc2qoBC6jS7FaUk9L9OB8XUowg8Kya4XSlMDCacUgCknlaXyB6Q2Zst1oI1Y/
         0fvqRd1vOqxFLJd0I+9YVyTVp5YJZy/GEIdHsvrHZrwBP6gMC/1iFc4C9pv3RQyq79ia
         +MaDUsj4jO8Eii3rThY6+YYTqxT/IJGtBwAkFGI0ZiU29Ylj/PdgGe2s7mwmTtqq+1TG
         oKqTndbrSedY7u2uJ3ENXpV79J/R83BU2QA4lozCuFdtpDrHm1WaU2C4x0g7MiT5WKUt
         b0CLb0ryn6R80j4P41UX8K+yFFEIPtlbgl/XGfQFY/up/YfOKHAjW7Kyz6HqUZ+VgHA4
         rj3w==
X-Gm-Message-State: ABy/qLZWitO6g7DqwUVTEGprPQS/6X6HmrkxQgMt60TxwSCz9ca0rHT8
	hZamTeY1jAUqNC09uxxqO/9m+9OeFbE=
X-Google-Smtp-Source: APBJJlErQOmUM4kgmmKkVyNl1lgNpLxUwMbnq7H4nrXofSFOf3xg2/M+F+MzGu6eSUr9XRw2HLIutA==
X-Received: by 2002:a05:6a20:3948:b0:12e:8e34:f38e with SMTP id r8-20020a056a20394800b0012e8e34f38emr8027507pzg.48.1689389199072;
        Fri, 14 Jul 2023 19:46:39 -0700 (PDT)
Received: from smtpclient.apple ([2600:381:7001:e003:9559:2e9c:7f30:1736])
        by smtp.gmail.com with ESMTPSA id 10-20020aa7914a000000b0064fa2fdfa9esm7801696pfi.81.2023.07.14.19.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 19:46:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: SIMON BABY <simonkbaby@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Query on acpi support for dsa driver
Date: Fri, 14 Jul 2023 19:46:27 -0700
Message-Id: <F756A296-DD08-4FCB-9585-8D65A3D8857B@gmail.com>
References: <21809053-8295-427b-9aff-24b7f0612735@lunn.ch>
Cc: netdev@vger.kernel.org
In-Reply-To: <21809053-8295-427b-9aff-24b7f0612735@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: iPhone Mail (20F75)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks Andrew . So if I add a platform driver, will it get triggered  by ACP=
I table or Device Tree or by some other mechanism?  My goal is to see all th=
e switch ports in Linux kernel . The switch is connected via I2C bus .
 =20
Regards
Simon

Sent from my iPhone

> On Jul 14, 2023, at 7:33 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> =EF=BB=BFOn Fri, Jul 14, 2023 at 05:47:42PM -0700, SIMON BABY wrote:
>> Thank you Andrew for your inputs .=20
>> Do I need ACPI tables ( similar to DT ) and changes in the device driver c=
ode for invoking the correct probe function ?
>=20
> You don't need ACPI tables changes, but you are going to need to hack
> on the DSA driver and create a specific platform driver for your
> target.
>=20
>       Andrew

