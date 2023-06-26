Return-Path: <netdev+bounces-14123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1786473EF50
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 01:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E4C1C20A35
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 23:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA6E15AE7;
	Mon, 26 Jun 2023 23:30:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6D16402
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 23:30:02 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D87A198C
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 16:30:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b539d2f969so25940325ad.0
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 16:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687822201; x=1690414201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBfFQZUX3TFp/GqwGJFfJB4DrjscjdNgSaY0xn6MjAM=;
        b=6B+xzRZ4Vr6/d44ciru9AZg0TUC+dDojZ+J4hgY6gSezr7tUqy4vxRZfwHG7x+xUFq
         Ds3JKiZuneil7R5laOCCwtgqLitSPFKlw895SklwI1CnY4xlSPNINmzcruyy6MBYJNZR
         otj55X4qsL6vk5KAYqCZRgF4ugyb9K3WX512bE4Q+EGl1RXBjRARf4HtIKTv4OzmZOji
         dvjR1J96ASORVMMFFxTCJL+6ddzCL5opClDZ8MBdqHxsc21CD/YmrXILivuhBxSTEriD
         eLrumf4R02/zNnwgPk97gm4ngdqxbXYnML3GtUOLuW15rpNzdeUp4bn1K7mo1JvL82oT
         U//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687822201; x=1690414201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBfFQZUX3TFp/GqwGJFfJB4DrjscjdNgSaY0xn6MjAM=;
        b=NLr+JoumYBfpG6XWEXbxrXaVsGTFoHvFYxQuSCzhS7z5oo+7/V3/Bk2aBKe0Qmf6ne
         s5s9pX3M6nl4tH3rr9tcHfbRVqsQs+SyaTzZPGcMv98lvqu/CoMI4Eq0JWEh7FpCmxPK
         nT8fj9fN+RlcpFopemKH6Var9FWYp01uRG1u/LVA1bPqnlZb0Uthw95Lfp/nx3FxhCYU
         pb0GxY9qyKF7chkwuQPHTI5+XpsHj65z11TcJYboFGDogxxViznucZYhaI5YXgArWYDN
         tnz10kGtWyYEV++W7FHXKU8mZfncHNFkU9Z6ioCi8lMFz7cT936eMxYOKMF8SLeLs/gI
         Jcnw==
X-Gm-Message-State: AC+VfDw7BTUpfka3hjMs+CTauV+GCVDwyf9jWzcI/gaUX4Lkn/UrxSp3
	zr+qcunj5xvow8IG+GMneKNbCYD0pWxfrc4fa32WNw==
X-Google-Smtp-Source: ACHHUZ7kmR/5IyInq4cGj0nTDpcqrTcSrOkofcHLV+HyI1PKaxQ289bhH25bXNqhGOWXDADOI4KFESBvCraLaHPdPAw=
X-Received: by 2002:a17:902:ecca:b0:1b3:c62d:71b7 with SMTP id
 a10-20020a170902ecca00b001b3c62d71b7mr9340964plh.18.1687822200626; Mon, 26
 Jun 2023 16:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-7-sdf@google.com>
 <87edm1rc4m.fsf@intel.com> <CAKH8qBt1GHnY2jVac--xymN-ch8iCDftiBckzp9wvTJ7k-3zAg@mail.gmail.com>
 <874jmtrij4.fsf@intel.com>
In-Reply-To: <874jmtrij4.fsf@intel.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 26 Jun 2023 16:29:49 -0700
Message-ID: <CAKH8qBvnqOvCnp2C=hmPGwCcEz4UkuE9nod2N9sNmpPve9n_CQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 06/11] net: veth: Implement devtx timestamp kfuncs
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 3:00=E2=80=AFPM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Stanislav Fomichev <sdf@google.com> writes:
>
> > On Fri, Jun 23, 2023 at 4:29=E2=80=AFPM Vinicius Costa Gomes
> > <vinicius.gomes@intel.com> wrote:
> >>
> >> Stanislav Fomichev <sdf@google.com> writes:
> >>
> >> > Have a software-based example for kfuncs to showcase how it
> >> > can be used in the real devices and to have something to
> >> > test against in the selftests.
> >> >
> >> > Both path (skb & xdp) are covered. Only the skb path is really
> >> > tested though.
> >> >
> >> > Cc: netdev@vger.kernel.org
> >> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >>
> >> Not really related to this patch, but to how it would work with
> >> different drivers/hardware.
> >>
> >> In some of our hardware (the ones handled by igc/igb, for example), th=
e
> >> timestamp notification comes some time after the transmit completion
> >> event.
> >>
> >> From what I could gather, the idea would be for the driver to "hold" t=
he
> >> completion until the timestamp is ready and then signal the completion
> >> of the frame. Is that right?
> >
> > Yeah, that might be the option. Do you think it could work?
> >
>
> For the skb and XDP cases, yeah, just holding the completion for a while
> seems like it's going to work.
>
> XDP ZC looks more complicated to me, not sure if it's only a matter of
> adding something like:

[..]

> void xsk_tx_completed_one(struct xsk_buff_pool *pool, struct xdp_buff *xd=
p);
>
> Or if more changes would be needed. I am trying to think about the case
> that the user sent a single "timestamp" packet among a bunch of
> "non-timestamp" packets.

Since you're passing xdp_buff as an argument I'm assuming that is
suggesting out-of-order completions?
The completion queue is a single index, we can't do ooo stuff.
So you'd have to hold a bunch of packets until you receive the
timestamp completion; after this event, you can complete the whole
batch (1 packet waiting for the timestamp + a bunch that have been
transmitted afterwards but were still unacknowleged in the queue).

(lmk if I've misinterpreted)

