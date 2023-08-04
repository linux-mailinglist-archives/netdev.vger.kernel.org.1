Return-Path: <netdev+bounces-24551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A3A770902
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 21:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFF91C2190C
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 19:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8055D1BF0B;
	Fri,  4 Aug 2023 19:26:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752321BEF7
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 19:26:58 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F46E7
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 12:26:57 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40c72caec5cso50341cf.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691177216; x=1691782016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ea5NvBV7OKnrCcP1bbWGFK6biV4K5ybbKkapW1FOcr4=;
        b=pk8VWj/fD+goY4szKOJWOcGgV8M79kFXXVN+adcFpGjC1rCxU6jbN3dVMtiOZ8sZjT
         wt6b2bTSKgV+vlgTr+F3xQKKWFG3/ugq/8bEoEXqijCYTktb3UYKtW4V8MqVMh0LqtEN
         advNboQYJ3/wsJv4Y9FIUyyeSiQWY9juIa7+Qe8YFKg1JNDUeF1wEi9R0WwihElP0fTs
         oQ7bZaK/sQsa3qrKDlwjSLUozvDakwWkNILCZckx4bTjRmCOcjGm+dx1rKZb7ly46c5M
         aLCGlw8B4iKXuQjejHHwTJ6fIIWJ4zdSGyH0S+2f0cK4yugwkU8RBDTaeg9qe0MTOHLS
         sgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691177216; x=1691782016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ea5NvBV7OKnrCcP1bbWGFK6biV4K5ybbKkapW1FOcr4=;
        b=ALBjQO+Ami5MQ2Rl8JkX70VR5qlgGShOMU7D7vDlsUQ7CcNG+HYOoaU4boV1ULKBub
         HDkAaDmeielV77eZNvZl+fNknzmPGuYTG613/XPUIhPXz0Qo/pCCRcLIMaKgxySEcVZ9
         TblwRQBiBFvZxOIl4QLiM8r3YedgYsWSGUYFrjnTD2W5XCCdLr4Wpj1u0TfQAPy4MaK0
         +lzyZDEBhw3kMaX5dc0ts4ojdRw0mZY7CnuRdU3nxw9CALfKvAXu+utrkGoEE7NGJYqg
         QqHBHh4A2ipwC45Egz7VzK0UhkUhm4lvUd1NM7PBb9crPrXSXKLzmQ4GncvQCthUv0Xz
         7omw==
X-Gm-Message-State: AOJu0YzweCkhdYS9MREpdTvKpJC5K+uCyNvcEZRyuoktlyhUEA59IKU1
	F4RidJBmyzTwRrfv65i9biywDK4UCHA2Z+vZleErpbOJ5mqQqKmJXLU=
X-Google-Smtp-Source: AGHT+IFcvJyUqd+aWkgQqR5TtAb0EX8PIqNhzjqJR5ruFEIfiTeJcrEy97+bA+ZIBIqodarkiOjPtuhJriWYVQBdTNQ=
X-Received: by 2002:ac8:5c16:0:b0:403:b3ab:393e with SMTP id
 i22-20020ac85c16000000b00403b3ab393emr63337qti.18.1691177216019; Fri, 04 Aug
 2023 12:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725085443.2102634-1-maze@google.com> <20230727135825.GF2963@breakpoint.cc>
In-Reply-To: <20230727135825.GF2963@breakpoint.cc>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Fri, 4 Aug 2023 21:26:43 +0200
Message-ID: <CANP3RGfL1k6g8XCi50iEMEYwOfsMmr-y-KB=0N=jGV8hzcoSeA@mail.gmail.com>
Subject: Re: [PATCH netfilter] netfilter: nfnetlink_log: always add a timestamp
To: Florian Westphal <fw@strlen.de>, coreteam@netfilter.org, kadlec@netfilter.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, 
	Netfilter Development Mailing List <netfilter-devel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 3:58=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Maciej =C5=BBenczykowski <maze@google.com> wrote:
> > Compared to all the other work we're already doing to deliver
> > an skb to userspace this is very cheap - at worse an extra
> > call to ktime_get_real() - and very useful.
>
> Reviewed-by: Florian Westphal <fw@strlen.de>

I'm not sure if there's anything else that needs to happen for this to
get merged.
Maybe it fell through the cracks...?  Maybe I didn't add the right CC's...

Thanks,
Maciej

