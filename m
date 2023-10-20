Return-Path: <netdev+bounces-43091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4B87D163C
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121A62825E9
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 19:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E5A22310;
	Fri, 20 Oct 2023 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEGVLLW+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425111EA80
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 19:16:20 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE27D4C;
	Fri, 20 Oct 2023 12:16:18 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41cc776ccb4so6950761cf.1;
        Fri, 20 Oct 2023 12:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697829377; x=1698434177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB4JpDFuK+ujXLwBTCE+YoWklyn3fLbVJadxwKIhk7Y=;
        b=nEGVLLW+CfKA/tJlrU789FYhvx465O/pp7XGxtziUw8beymBgYVuMjcsQZ2sGkUvol
         gV2OkOU3B/5gV8VWQR2dYo2DOUU3YQfcD0Sb0Qg3MtjC/FNwsrhRp7zQ3bUIQDShwQzU
         MnrdRF3nPiFbAf1xKs5Iecm0AQBFqdgaUkXGYwFnwapPX0tEQOkkQr1mpEwnKwnPPuSP
         poA4Gv1gC7On6DBGF/9ZdzfSY+Tn1k3V7fKnQ7lyAMUtygdiNLfDiGf3b94Y8GJUUkO5
         cI4L9brwSFBqnvNVwF7WZ4sBL1dbnWr8UWkquxRqvF8/m0xoXpZG3Y9VhUlly5N2S58J
         Ofxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697829377; x=1698434177;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eB4JpDFuK+ujXLwBTCE+YoWklyn3fLbVJadxwKIhk7Y=;
        b=PuameZ5x1kt3W7eox2Pbfg4da9taLDyasTY+VL/jWJLzgugHT/eK9ZdXWign/rv7y2
         SZ5dpFpylCsk51ZMGNhCuZ/iqrdJGiRZbv4dncyBsvRG/g+SKNVHCa1CW29eQafhQoPN
         aAE+lnEgdaPeKn6odiVHMerz+UWeEl2cA6PjO/qElYNAqbAJsoNK8W7pwBB/kUuU+Z+L
         4ePFwhmHWfpwUYs6rbjYLc5P1j8cYVxRCKojClvbltUtWByfJ9XpXdiuHfMEs3Qx9Iht
         iwkTNtoc+xhslZjFjydrlEGL0wKw6pZwT9XlJVY8/LDZkEYVv9G4tInuHNL2YpdcFJyV
         wtow==
X-Gm-Message-State: AOJu0Yw8a/nj5h20n7KbHDVRpp/cpudxCUVfBbaqu1sUEZuAwog5Q+p0
	+dJl2k0CmeSagM5r5eITvq0=
X-Google-Smtp-Source: AGHT+IHHzyePaUKFo+9CHS+CD06onpPNSrlNKGyXd92vmgJm755sbyXQZAR0NeqIfBf9QCjL6jrHaA==
X-Received: by 2002:ac8:7d96:0:b0:417:9c40:c5fb with SMTP id c22-20020ac87d96000000b004179c40c5fbmr2996248qtd.44.1697829377488;
        Fri, 20 Oct 2023 12:16:17 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id x9-20020ac85f09000000b004181a8a3e2dsm817441qta.41.2023.10.20.12.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 12:16:17 -0700 (PDT)
Date: Fri, 20 Oct 2023 15:16:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yan Zhai <yan@cloudflare.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Aya Levin <ayal@nvidia.com>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 linux-kernel@vger.kernel.org, 
 kernel-team@cloudflare.com, 
 Florian Westphal <fw@strlen.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexander H Duyck <alexander.duyck@gmail.com>
Message-ID: <6532d200c080d_28a354294e8@willemb.c.googlers.com.notmuch>
In-Reply-To: <496ccff707e16e98163d2a3fbcfbc1f824fd8ec3.1697779681.git.yan@cloudflare.com>
References: <cover.1697779681.git.yan@cloudflare.com>
 <496ccff707e16e98163d2a3fbcfbc1f824fd8ec3.1697779681.git.yan@cloudflare.com>
Subject: Re: [PATCH v3 net-next 2/3] ipv6: refactor ip6_finish_output for GSO
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yan Zhai wrote:
> Separate GSO and non-GSO packets handling to make the logic cleaner. For
> GSO packets, frag_max_size check can be omitted because it is only
> useful for packets defragmented by netfilter hooks. Both local output
> and GRO logic won't produce GSO packets when defragment is needed. This
> also mirrors what IPv4 side code is doing.
> 
> Suggested-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for splitting up the series. This change alone is subtle enough
that it benefits from standing alone. I thought it was intended to be
a NOOP, but you indeed call out the frag_max_size special case.

