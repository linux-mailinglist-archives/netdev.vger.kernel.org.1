Return-Path: <netdev+bounces-20265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1429475ED02
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE8E281471
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 08:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B377186D;
	Mon, 24 Jul 2023 08:01:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D452184F
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:01:59 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C07FE
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 01:01:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-993d1f899d7so716244466b.2
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1690185715; x=1690790515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvpQjdy2BZtG4KxZUJm0NSczIjObM2PdRZCjOhCuHqE=;
        b=L8ohUoQwhRgvUZKLkgt2VAsrzphG3+p7mgJ/gQ+hDxT+HVl0t3pJLoFEdQrx/EQwy8
         xN1jUdg4iR/MYSLHSdB0o3Yg4cMoEfFfJyuO4WEkhPBIWYOyMlTGIrl4OG209ohSxtQD
         DQ/4D3OMZFqg3Mf/skvNwVLRIbKNFakNb+F8IzAU2JEIS0I+8iyUqV3ouJTt/iLoqnbv
         TkD15YOuPNF7Z6yAakkJUlScTQgfZQXvscA83nD8qR63JT1c/g6Q1+T4UwOETkE86fMg
         1NAHj9FRSpcvm/jIUFC37I2Hwi1EHaTDTYdpKW4AXtemRlwTju6DmY0fzVkMBXE4QIIT
         SiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690185715; x=1690790515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvpQjdy2BZtG4KxZUJm0NSczIjObM2PdRZCjOhCuHqE=;
        b=MlXxcTg2bfaQMDtCWLQ3yBReXDiYvhuOl/+eNilYHL9cYtFurNYhlbGHdLuK1bBSAb
         QZbTT5A3iSd60dqO15ob4mHofJ5G68bSlM8IHMTvetZtHBjWBXGHVkCIm5c4ZXCFOYF6
         LdkeIULCT3gNgI/Gjz+PUWlmBdwJ1QutyBZzIqxY5Szq5Pe0Y0DZ77cES86BO9DN8S19
         lrKDgXxVxLcPpwNTrQC03aFcM5x4a+bguYZC/vBMbUYjmwE/A1G5AT/odPK3Ti/NRBGo
         GqNqtSWc1EKw4JeEJt6Cpy9R1PnIcLyRMpUl6ccq6ZJhUfl8kCOYpOIbUCOQ4OdNU8Ob
         IkxQ==
X-Gm-Message-State: ABy/qLbY0tCELkTc+L0IP6EKcSbAlhWmnj65ECodaft0ommIM9zDopO5
	waVgsy1rZ9xvfTWsnRu6+oU2Jqd8WIRELS3TJ1mOFg==
X-Google-Smtp-Source: APBJJlHC5rMQrIx5ImZ99gmyXHNXpIqWWNKYgsVWHrLadDUIN+FGDrHLMI+w2SLqw3PTowpbtiuavEOWH40HooYc2NA=
X-Received: by 2002:a17:907:7846:b0:994:8e9:67fe with SMTP id
 lb6-20020a170907784600b0099408e967femr8119394ejc.35.1690185715296; Mon, 24
 Jul 2023 01:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720-so-reuseport-v6-2-7021b683cdae@isovalent.com> <20230720211646.34782-1-kuniyu@amazon.com>
In-Reply-To: <20230720211646.34782-1-kuniyu@amazon.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 24 Jul 2023 10:01:44 +0200
Message-ID: <CAN+4W8h=dSqF-TV1pRueP1mGSpUpkkZGgMScL_=GR7PphTZRkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/8] bpf: reject unhashed sockets in bpf_sk_assign
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, haoluo@google.com, hemanthmalla@gmail.com, joe@cilium.io, 
	joe@wand.net.nz, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com, shuah@kernel.org, 
	song@kernel.org, willemdebruijn.kernel@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 11:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:

> > Fix the problem by rejecting unhashed sockets in bpf_sk_assign().
> > This matches the behaviour of __inet_lookup_skb which is ultimately
> > the goal of bpf_sk_assign().
> >
> > Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
>
> Should this be 0c48eefae712 then ?

I think it makes sense to target it at the original helper add, since
we really should've done the unhashed check back then. Relying on
unhashed not being available is too subtle.

