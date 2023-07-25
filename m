Return-Path: <netdev+bounces-20924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8886B761EAB
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C311C20F51
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1301F926;
	Tue, 25 Jul 2023 16:37:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09211F17F
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:37:30 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8F41737
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:37:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2680eee423aso1075218a91.2
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1690303048; x=1690907848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxV8UE2eWk1ycwtiduTKw0mPoDkEOgJdUW/6WyyR2n4=;
        b=pbaEJs9JRSuOofn/kgGZHeCbSDeDo8uLApQF9OQ7y/aW2GWzvu7VyWf7/KZUi1xImy
         Ud9TyECHDEecWDUhkRdunjHeSPMv9JbMHpKjryH5w7S7dN4oJUDi9dMqISkLyY8WwQ+B
         /+dGXUfECITUl6IYB4UBqIg6DB8dUps+wjVqN0Iv7ZkFeky4VU9YRzgiwNm2Dl0LX/Tt
         DTQ19nNXxPX8u6f4MUbyyNoj9H1nkfHWHBZ58F5KEv7KgsAuBDKlxMF0fO5E9jk/oA/E
         l6CS0/ztxqcfbADR8NFSCH/T02YNDQY3JU8SWClU1QdRCLy/rrbb+Q2s/u+v5I+NAqTZ
         Fz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690303048; x=1690907848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxV8UE2eWk1ycwtiduTKw0mPoDkEOgJdUW/6WyyR2n4=;
        b=RfeEV5UmV/pFGZKleexdnLEDy/ci/X0VnrD99E4EURexIQPjJa3C1Q6fIJpjq/KgSb
         9r4/EVU5HIphO/RlCBSje5QqWMW1HuUI3sgrimFRIiGYP2/XEoOif327grOn0XYaH9kg
         WO85JtxC2oEnOgw9I9uG1PSFe+VRGuDRdLeFoBBvrmPgzeR7Y0XN0y9RewszLb91tdx0
         lH+WTRyyItCopyJU6K1JaadfabBis/ngY3he35v/A8D4Gw4FHhtQ3lHKN7FSuvLc5SjW
         oDeUtxT1lux2K0EngO69u3B8AhuFjBKqfxI+7gfM7YU5nC0zWg1/e2oQ1sqGU9uNivG1
         4rxA==
X-Gm-Message-State: ABy/qLZDKpq0nlIZrWeK6Yere1escutkbfq/NnBwB2Ov6XNEFn21QMZq
	KL2IbgkV1W+spZqxKRjoCRXtGzsRT8VzhyN0jPK8UQ==
X-Google-Smtp-Source: APBJJlHnZLqgw0QUx1cj8ftYxG/ylXHVKNz3AYGrCn05rLepXNvW9exBCI45FDIEOQan9EdZWthY6Q==
X-Received: by 2002:a17:90a:8c0d:b0:268:4dcb:b09e with SMTP id a13-20020a17090a8c0d00b002684dcbb09emr121060pjo.46.1690303047789;
        Tue, 25 Jul 2023 09:37:27 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a190500b0025bfda134ccsm8951426pjg.16.2023.07.25.09.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:37:27 -0700 (PDT)
Date: Tue, 25 Jul 2023 09:37:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nicolas Escande <nico.escande@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [iproute2] bridge: link: allow filtering on bridge name
Message-ID: <20230725093725.6d52cc03@hermes.local>
In-Reply-To: <20230725092242.3752387-1-nico.escande@gmail.com>
References: <20230725092242.3752387-1-nico.escande@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 25 Jul 2023 11:22:42 +0200
Nicolas Escande <nico.escande@gmail.com> wrote:

> When using 'brige link show' we can either dump all links enslaved to any bridge
> (called without arg ) or display a single link (called with dev arg).
> However there is no way to dummp all links of a single bridge.
> 
> To do so, this adds new optional 'master XXX' arg to 'bridge link show' command.
> usage: bridge link show master br0
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>

Looks good to me, but we really need to address removing the term master
from bridge utility.

