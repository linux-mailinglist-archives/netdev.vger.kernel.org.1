Return-Path: <netdev+bounces-40353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F6E7C6E19
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 14:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3181C1C20D2B
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 12:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51521262B7;
	Thu, 12 Oct 2023 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHspUfoP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18142511B
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 12:27:58 +0000 (UTC)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDF0B7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 05:27:57 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-4524dc540c7so392907137.0
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697113676; x=1697718476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDu/2uqHkjW1Wxvgu3hcxeuiPTyT+MCxEgrv0YW9CCI=;
        b=hHspUfoPNT8ZyuaKLZDODy9AaaAtUWqj8locBXBFbo78j4v+iFp5A9pG031p/u8bFE
         FJcc60ztn1WUhRKsZ1AESe5DfoIHKMM+lWfkn1mu86Hj20GyoQ4b4LUM+0e6iKRK94sM
         wOqRgwto9yyeo1xo9HPRNOdUnKrHULEPlaf7pIyBYff59Lbo7fIqGWJJcQzh5LQtOJbn
         1wNwoRQN3JNCko6FwzyBiGM/ODkTu/ew2TYGgx6LdkzA1JeqyaykqCZi+l88+/WIluq/
         0Ppkc8Jwc/bYfEDJzZQ/TTfH5x6aJt2NAd6Tu2+nHBkFQ3dAXAZc19Y666ojHYxXex1y
         7G3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697113676; x=1697718476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDu/2uqHkjW1Wxvgu3hcxeuiPTyT+MCxEgrv0YW9CCI=;
        b=kSIHZKgtBHUgQJyYr/tfdXAtInUJUSqtp+YNU08DZfPbIo6KNKj1htAzKfK6hJgcQy
         z/QsouR0MmUOghBNoHV7Q+R9n1+4EXK4cXZgwg4K0Cmmsno0N+3x0TXoSoAnoZrw+Lbn
         +xcjuCiTS8gPOnNEJw4tb27BBptk5i2tyrTqnzL3WjVvm+nJF0NOgCGqcVF7qGA5uOTe
         oRfnVzauS7xvoh1YoY5DEERYHjS2A8O4L3+/Pb+PEfKCkZmHdL30wKV2A9w2m/qeM/YT
         QK4Gyouw08MaF41clo6Tmj2xSjuVKARiNqeyG1Xk7qo9uasqOsPeXL8NRTA6/OF+VEoJ
         MClQ==
X-Gm-Message-State: AOJu0YwbcQf1gU09VETxr8H3QdEhqEmJHKl+MoeyBixJUAqBQudOU7wH
	Wi//gaB8uhyBWmcPObp7o0TFiCRsDd1Y8D8JFOQzd+LH
X-Google-Smtp-Source: AGHT+IH9W3xZl2714OjnDh+mCTkkwfXk8BZo2pekQr2XGcNGq+YlV7aQrkiIFsNjg/9Gvembgw3X1CL7VuS04W2AXRU=
X-Received: by 2002:a67:f599:0:b0:452:c581:5a07 with SMTP id
 i25-20020a67f599000000b00452c5815a07mr22561817vso.11.1697113676417; Thu, 12
 Oct 2023 05:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012120240.10447-1-fw@strlen.de>
In-Reply-To: <20231012120240.10447-1-fw@strlen.de>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 12 Oct 2023 08:27:19 -0400
Message-ID: <CAF=yD-Lu1dodkaE_nLiMSdbeLikZMm3y5-K=7D2_S1M2W5yO_g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: gso_test: release each segment individually
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 8:03=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> consume_skb() doesn't walk the segment list, so segments other than
> the first are leaked.
>
> Move this skb_consume call into the loop.
>
> Cc: Willem de Bruijn <willemb@google.com>
> Fixes: b3098d32ed6e ("net: add skb_segment kunit test")
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Willem de Bruijn <willemb@google.com>

