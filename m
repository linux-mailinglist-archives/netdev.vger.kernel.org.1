Return-Path: <netdev+bounces-62682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B8C828869
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 15:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE201F24CD0
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 14:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C25339ACB;
	Tue,  9 Jan 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcP9Zxmu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ABC39FED
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so10477a12.1
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 06:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704811425; x=1705416225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hTSp/621JuWdOzYoBlVmVqh7hDK5oBkPf++B3jV4j8=;
        b=HcP9Zxmu9/16084eHJ+NmuGWlYUcc3QFeS8uSSZikkoUXQ2UL34hLVUWuyh8LCzKqo
         cjOWd9oOovsMQdqebHbAnSNlQ4dwOvx579RlYjeYArqv8zP1jgbFYBC/GxZ4UryfpigA
         iKnRxmjHY1Sv0SMZpzdwk+E/sxXNheVudyV4VghUE6HoJ1gf2p7pruFQVUPiOPcqzH+m
         Hc3Ca43z67IPYoB/WQCIYSOrKh5zR17Ajyx+qZKltH/zKdWuAhpZTt4YUWmlSw0fkjJj
         wqBbs67uGIg65/6wc0iL7qeaU/vz+2uWc6RQkQVu7fSPF0CMqzsSUEMA/Br6QS/wjKQg
         KgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704811425; x=1705416225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hTSp/621JuWdOzYoBlVmVqh7hDK5oBkPf++B3jV4j8=;
        b=cz2MxjM5lgP23LTEEq1/IQ8HjCftrZRJ4wJnrt1+ETb2lqSgKy+qaI5V4Y2cHpMoRM
         QJMqb3X5vJTT3wFpbJat0tHPesmfuVRm1gQjcwuZleaxlhlMkDJnyjSEvkHQ2Z/NzmZp
         nRBExE1OOVyM5c5FsI6tScKZqsfjqjACu5qNcLgcrva8RgIS2n3PveqKL0/H1nC9RrpK
         NR6X4+BdMzgjzlYVVKwcbbf1qS+/uVvZ8IYcvT7eQlg1QCWGBYvSP/lmdNxR9jBBCg0A
         Iuiy6gbPvUOjiBACO4IJzXIZH3Ivav9cdnbFDaLj1t/w+yRE6JBM6o5EdWCHnzwCS5Ui
         +8RA==
X-Gm-Message-State: AOJu0YwDMgvDXEECg9iSq4CtJUXPGzZMjtjPcAdJzaiyAQZDtCGL/xFP
	bHu+vkNAuGweqcon03bSZ6rUlscV7ekmqf33ojNf/7miX9lW
X-Google-Smtp-Source: AGHT+IGCzpJkHmbkISlJEaLGwgFS/54jBbdaQxFTLs2DxUORYa3GyuTiAnd2AjxmVJ16Ps8zGgj4wzF+PsKfXzpopCc=
X-Received: by 2002:a50:9548:0:b0:554:1b1c:72c4 with SMTP id
 v8-20020a509548000000b005541b1c72c4mr101455eda.1.1704811424481; Tue, 09 Jan
 2024 06:43:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com> <20231223025554.2316836-6-aleksander.lobakin@intel.com>
In-Reply-To: <20231223025554.2316836-6-aleksander.lobakin@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jan 2024 15:43:30 +0100
Message-ID: <CANn89iLbRnakLSuuoAF7eeN8KGqc7wy0bEgCmHCP1mU6LB912A@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 05/34] idpf: convert header split mode to
 libie + napi_build_skb()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Michal Kubiak <michal.kubiak@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 3:58=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> Currently, idpf uses the following model for the header buffers:
>
> * buffers are allocated via dma_alloc_coherent();
> * when receiving, napi_alloc_skb() is called and then the header is
>   copied to the newly allocated linear part.
>
> This is far from optimal as DMA coherent zone is slow on many systems
> and memcpy() neutralizes the idea and benefits of the header split.
> Instead, use libie to create page_pools for the header buffers, allocate
> them dynamically and then build an skb via napi_build_skb() around them
> with no memory copy. With one exception...
> When you enable header split, you except you'll always have a separate
> header buffer, so that you could reserve headroom and tailroom only
> there and then use full buffers for the data. For example, this is how
> TCP zerocopy works -- you have to have the payload aligned to PAGE_SIZE.
> The current hardware running idpf does *not* guarantee that you'll
> always have headers placed separately. For example, on my setup, even
> ICMP packets are written as one piece to the data buffers. You can't
> build a valid skb around a data buffer in this case.
> To not complicate things and not lose TCP zerocopy etc., when such thing
> happens, use the empty header buffer and pull either full frame (if it's
> short) or the Ethernet header there and build an skb around it. GRO
> layer will pull more from the data buffer later. This W/A will hopefully
> be removed one day.

We definitely want performance numbers here, for systems that truly matter.

We spent a lot of time trying to make idpf slightly better than it
was, we do not want regressions.

Thank you.

