Return-Path: <netdev+bounces-22274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BE3766D4F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 14:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21E928277B
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D43107BF;
	Fri, 28 Jul 2023 12:35:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B764C8C9
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 12:35:13 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052B9187
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 05:35:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686ed1d2594so1984446b3a.2
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 05:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690547711; x=1691152511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eGcqxjwyY3pQ4csT4f4ZYFzUgFaDBasoFzgth4FA/MQ=;
        b=Ayqc4/V4xCizMpmDFZrNnLTheMd/dzztR+ZfbaALYbnKWyd1UUFRzSS2w31dkd3zb2
         gwRpSajc5oIiKbKk1/ap8bGKCB+oyif9jhi+zD1qdtAftb62WVTjkXSo1MdbtB+zRBT5
         Fu3zGPAXEF0P38GF6Y0X0r79yC3+xQJhWbulItJtQnlJATpr8wSpbF+Aztf1AapQs27/
         aG0xnZXIfvCmAhH2OBAawztFT/tQ8Cign6cGhMFqWstCob14Gi+Y6t4sVsUcZGMae5u2
         DVbrfb6LJoQRgXx9hSxlGF6CvjbOS64rUlf/BRwdmlT+1WEL2akThtv20+bH/lF9/1zb
         EoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690547711; x=1691152511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGcqxjwyY3pQ4csT4f4ZYFzUgFaDBasoFzgth4FA/MQ=;
        b=ZXuXjj0DKHxLZjVLUt1xZvyFcLDqY+8MuQf7JonhpWR/SxRHru91nPwXXxNqrFm+lH
         cVrTSuqeSOEuOd/oeq1b5doGN/NKYkEaaiKxd3c75zW4K9fSGhZVikIFqCR1vaTldLvh
         6FFqhKdlkc/7gmSHyavnFonQ/SdH66BGGtHKrkF9WN6YLzkgwCbmKf2+z8GFs5LSTckC
         XFSpk3zzH1Su0PzYDPPZJTaEG2DaHnFDH+ASLr7ho6YWNffBUVBNPaOGtOZLu3ACV+z0
         GZVvxQ3+H71jmFqO5rmjylHLN5LBO/Z6VvVgpfq9LGy1IEjtRzcNyklBFL5UX8mxhA6T
         I16g==
X-Gm-Message-State: ABy/qLbnCPbYfoewl3SKcgeHV+Lbz3nzUOMkgrV1tWwJJSH51F1dGtDz
	VDwo6PtqEXwt9h2P+7BRbEOovmKbw29YF3rxIc4WZQ==
X-Google-Smtp-Source: APBJJlG+md8nV+Q9MCGNmsY6Cl5UKO3sLRcVzXdaRiluSPg7b4tpcWZWbV3MxDY9ynKpupQ65y3JYRyqDlXWn8w5NLU=
X-Received: by 2002:a17:902:830b:b0:1bb:90d7:5e01 with SMTP id
 bd11-20020a170902830b00b001bb90d75e01mr1329459plb.63.1690547711217; Fri, 28
 Jul 2023 05:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org>
 <CAMj1kXH_4OEY58Nb9yGHTDvjfouJHKNVhReo0mMdD_aGWW_WGQ@mail.gmail.com>
 <6766e852-dfb9-4057-b578-33e7d6b9e08e@lunn.ch> <46853c47-b698-4d96-ba32-5b2802f2220a@sirena.org.uk>
In-Reply-To: <46853c47-b698-4d96-ba32-5b2802f2220a@sirena.org.uk>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 28 Jul 2023 21:35:00 +0900
Message-ID: <CADQ0-X_pXKvUxLW23vEyH=9aZ6iLA2jOKz8QX6aqwQmxFcPY8Q@mail.gmail.com>
Subject: Re: [PATCH] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ard Biesheuvel <ardb@kernel.org>, 
	Jassi Brar <jaswinder.singh@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 28 Jul 2023 at 20:43, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jul 28, 2023 at 10:41:40AM +0200, Andrew Lunn wrote:
> > > Wouldn't this break SynQuacers booting with firmware that lacks a
> > > network driver? (I.e., u-boot?)
>
> > > I am not sure why, but quite some effort has gone into porting u-boot
> > > to this SoC as well.
>
> > Agreed, Rather than PHY_INTERFACE_MODE_NA, please use the correct
> > value.
>
> Does anyone know off hand what the correct value is?  I only have access
> to one of these in a remote test lab which makes everything more
> painful.

"rgmii-id" is correct, configured by board level.
The latest EDK2 firmware was already modified to use the correct value
for DT(Thank you, Ard).
http://snapshots.linaro.org/components/kernel/leg-96boards-developerbox-edk2/100/

Thanks,
Masahisa Kojima

