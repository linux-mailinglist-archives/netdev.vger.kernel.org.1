Return-Path: <netdev+bounces-26672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E508C778879
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF3A1C20986
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006A153AA;
	Fri, 11 Aug 2023 07:38:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BA7539B
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:38:55 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D13CE75
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:38:54 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-407db3e9669so131711cf.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739533; x=1692344333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x+skZz2w+2GZJJJ5GEJiqoHp+esKrCNS5oUsbGyl8E=;
        b=bAOHAs3vd3kij2t3yQNT7FcFVIbiKZNYE5xSvqNhe8mesOwxJd8B9fi0l1AhlDUURt
         KE4YfqQwajDEyScI0o715NRL83Ad9KhRReKl3vi4n1IyR84Rh72G0uwLMVp/08HaLzEr
         SCIvG9/Z7xNg+Q1uD4sYqQo8Iy0TAPE63mgOgoRIf8nI6j/j4HK8HHuniovRwrVd6zzY
         QY45jvMcCWHXO3nC9ndbWfdEZhxl4Jgo2mFc5BFTjgumN9b1BHUZCLb9IGNeB3BYW/1z
         QsZ4GMZZASMkHOAxs0ln+1c9/b8A9tas7DI3f/g9TK5J6/GBEx48rwYJfOXXdaFMHvtp
         l85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739533; x=1692344333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9x+skZz2w+2GZJJJ5GEJiqoHp+esKrCNS5oUsbGyl8E=;
        b=ai0+JxyysUK/YjLOYe/wELynbkLp0ezsVPqaUsVv0l7/FiKQbz2piEV/kGbak2StxV
         KNNq4jml3kAgMeXtmTeBWvMn7sjo8OMNusMRGsQP+75f6SSQrEeZvMOwfKquugXofmva
         FIsg5lckX6axEDce3ih/n3rVwdt8xGAXQd6qI9h6QILbnVZidbnEp/GVxeDetVJ7e409
         bwcCTHAfRjvwcSrmyIhNe95qSOW3omGRGf1K2xEXkklVDsRigKLjyaDZo04BlK45Puxg
         fE70YdF3PVp7JSDCIGM4P80VA8UDMKnLfucJNblbbRmSbaExjvhdkQE9L9gUtvOuvcRt
         A1zg==
X-Gm-Message-State: AOJu0YwQNc+dtxO+XHPSxGryMcbr4H9sreJzyTV4clr2JFfrOa1w/FNT
	YDic24UsKydpW/VzlgwphZr1+fW2mftaXt2bGBUpBQ==
X-Google-Smtp-Source: AGHT+IGeQgCC7vxP5sPXGpUl3Krf23ZVcWj6E3bFnn5+hm6OdjbWGuICVrqY/ebkeO/npkxX99mFD/ifxO+YuJVku6E=
X-Received: by 2002:ac8:5bc6:0:b0:3fd:ad1b:4e8a with SMTP id
 b6-20020ac85bc6000000b003fdad1b4e8amr156021qtb.22.1691739533220; Fri, 11 Aug
 2023 00:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230811025530.3510703-1-imagedong@tencent.com> <20230811025530.3510703-5-imagedong@tencent.com>
In-Reply-To: <20230811025530.3510703-5-imagedong@tencent.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Aug 2023 09:38:42 +0200
Message-ID: <CANn89iLYPk1VpcOACBki6CE82nPp9vD7akZSbBYD+-BVb_0zBQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] net: tcp: refactor the dbg message in tcp_retransmit_timer()
To: menglong8.dong@gmail.com
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, flyingpeng@tencent.com, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 5:01=E2=80=AFAM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> The debug message in tcp_retransmit_timer() is slightly wrong, because
> they could be printed even if we did not receive a new ACK packet from
> the remote peer.
>
> Change it to probing zero-window, as it is a expected case now. The
> description may be not correct.
>
> Adding the duration since the last ACK we received, and the duration of
> the retransmission, which are useful for debugging.
>
> And the message now like this:
>
> Probing zero-window on 127.0.0.1:9999/46946, seq=3D3737778959:3737791503,=
 recv 209ms ago, lasting 209ms
> Probing zero-window on 127.0.0.1:9999/46946, seq=3D3737778959:3737791503,=
 recv 404ms ago, lasting 408ms
> Probing zero-window on 127.0.0.1:9999/46946, seq=3D3737778959:3737791503,=
 recv 812ms ago, lasting 1224ms

Reviewed-by: Eric Dumazet <edumazet@google.com>

