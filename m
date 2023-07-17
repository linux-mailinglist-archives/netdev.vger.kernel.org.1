Return-Path: <netdev+bounces-18331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AAF756724
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E0A1C20A51
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD5E253D2;
	Mon, 17 Jul 2023 15:05:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E0C253C9
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 15:05:07 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FC510FF
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 08:05:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-67ef5af0ce8so4749712b3a.2
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 08:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1689606305; x=1692198305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=894ZS7OKNo/BvncioHyYOLDbabMO0cdmHrhN0nPH9Ro=;
        b=pChUQApOFgdw32Xhy+8OR4hOapPdDEs2X6cpNx0OQKCbimEFdW8rdXBS2dbJsYtBBJ
         TiaAN1JNyrJ2XOmiPYWpX13TwXvOaCW1rVAQt2S3ggelkqLpfyo8dpntMJA6XyL2KnR8
         YwJ7Wj0ijbcpj89OQck1r5V+LiqS8DNUled3OsSBSRmBIecqONJCkXOHjmesOI6Id4Wj
         /8iOe5VJwBR0BqFJ2ZEi+0gHb3xKGDuqdiBPy8xJTowdmdUWfNfGReXkRgygTYNv1Cyu
         hQUvn/GS9NhUhgl59tHLJPyYB6DAwEpn92uJNVOQS4UceRrsQft7ZOje4aGuTMbfj0lI
         UR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689606305; x=1692198305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=894ZS7OKNo/BvncioHyYOLDbabMO0cdmHrhN0nPH9Ro=;
        b=kcAShRZcbx1V36sYbiGcoU6Fmr/CFUu7ek1SI87PnUBs1Hpy8DNhsMgdlBb6mEWVM/
         xvOlrISz+QpkHS0ed9MUNTikG0ABElvm8JlMOitye5zgdSlnX5wiSf/J571VDnEe3SDt
         aXTqSsq4fresAhURYVt4Aqr16ZZgIWJq/4W08X8iOatGP20idT4E1ePG9FfgxUHnouXJ
         GdaCTUDJ0kudOzJOH/IkbZOerODV5PioU16zMp9v1QRNW9GYHqO0KH9zhvGS2cAHqqRq
         G3GietFOfRvNqd/VnVi3sdqUCApZvAqPbR2/g0KZXhRgzcFDLNNGHHkZwMsuf2gs1v+S
         n0GQ==
X-Gm-Message-State: ABy/qLaz7buoSdsp9+2ih9bYszBaseADaPLgpjuiWEPQooqvWVVn5q3t
	3jgo/l9xojRCpaFgHOh4qVfb1w==
X-Google-Smtp-Source: APBJJlEEvAZWxh+vlJ5QKTEpDyU54AW6UEHfwD/PKRoLGI3iuvjtZUt93l2uLkvGJ0kbe9uYmmWw4g==
X-Received: by 2002:a05:6a20:144d:b0:132:bf3e:d643 with SMTP id a13-20020a056a20144d00b00132bf3ed643mr16005395pzi.5.1689606304727;
        Mon, 17 Jul 2023 08:05:04 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id q26-20020a63981a000000b005439aaf0301sm12786216pgd.64.2023.07.17.08.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:05:04 -0700 (PDT)
Date: Mon, 17 Jul 2023 08:05:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: hanyu001@208suo.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH] 3c574_cs: Prefer unsigned int to bare use of unsigned
Message-ID: <20230717080502.21b6b1f5@hermes.local>
In-Reply-To: <7f6fba66a5cad4486c04efe56ded5ae9@208suo.com>
References: <tencent_C283203D2CCA281A87720665D83277B4CE0A@qq.com>
	<7f6fba66a5cad4486c04efe56ded5ae9@208suo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 17 Jul 2023 11:11:11 +0800
hanyu001@208suo.com wrote:

> This patch fixes the checkpatch.pl error
> 
> ./drivers/net/ethernet/3com/3c574_cs.c:770: WARNING: Prefer 'unsigned 
> int' to bare use of 'unsigned'
> 
> Signed-off-by: maqimei <2433033762@qq.com>

Patches that just derived from checkpatch fixes are not accepted in netdev.
Didn't you already hear that from the maintainers.
Repeating with more patches will just get you blacklisted.

