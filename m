Return-Path: <netdev+bounces-23466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130EA76C0B2
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 01:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976A6281BBB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 23:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE6D6FB2;
	Tue,  1 Aug 2023 23:13:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB86121
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 23:13:11 +0000 (UTC)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043009B
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 16:13:10 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-44781abd5a8so1178433137.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 16:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690931589; x=1691536389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAGq/9RLNcnVJhUkKO8RYK7Q9CJ1xMxNc8HcCm0A7tI=;
        b=Ihdfjx8NnDjs26aKtDdeac7gYmonxzMEtgxcKMVcJEl4gzvp5vvV//81oaEwxicCan
         xPT7CC4Ue7wtA2H/bXR/BLsswafqpDRiHNT2E1YTkk74qmolWO3zU0R4PWCCBMroylCS
         9vqB6oE/R4CDu/sRhQtJvATotmL6wWV4lxmWeWN3b73+OUqoawsg/imZQTRlQvnyeK1F
         FjJHBSi2vxXH6qKlrDh9ZVL13C3FoPBg3l05Ljrcaaf19ROSH8419a0Gmq5B0n5BEFbR
         knwPp09mMFbsZjB09ozWQg9f4Jnif+n/yCN28yY5UOmQrS8mb87+EKoXpXPfD5IBojl1
         5mYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690931589; x=1691536389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAGq/9RLNcnVJhUkKO8RYK7Q9CJ1xMxNc8HcCm0A7tI=;
        b=Asnnzn7P36kTh1d2LWBZZO4WqUWC9JBma/2OSfZAlgAtYhSvhOl6WEWtRpmuCuIsV2
         5b8ce0UAnPVs2uvfQyfL8EI/DWLMk2/+RCYB5vNjRpA4pielOGtrVvI3f6XaRKfjXCf9
         3dUM5RONV1U4fvJ0vgur088ME55mzMsruVlLe8tRGyf+wEvHvIlPvsX/JXOq5I0yHgRb
         KIm4SaKKrHjT6wuhKGBa+Picm4/JN3NKB/RwbISKUPc1SToyg3Pad0/8D5RAH8+mD6AC
         qVN4VMq6DGJablkes39Dh8BuKwdfMHzabJOXbNODGpeHdsC7siKrb8338fzcCq4SxZCA
         9Ctw==
X-Gm-Message-State: ABy/qLbNNFW+GwfaPqcSWXPgKD3Jp7Kb5ne8IjqlZni4xxPZxwG7hcn0
	tK1D3NNHR4BUdetxvcbuAA32k3vDBh5nB2NREvzSzA==
X-Google-Smtp-Source: APBJJlH0b2618NvgP7f7wPCS6iKcbwhj1357/jp9RT5QWab8Bdwjvzhybht46exCb+UU/9GW42e7VnnNpSBBKDfnHT8=
X-Received: by 2002:a05:6102:4ba:b0:447:8821:acf6 with SMTP id
 r26-20020a05610204ba00b004478821acf6mr3616247vsa.22.1690931588948; Tue, 01
 Aug 2023 16:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801215405.2192259-1-rushilg@google.com> <20230801151258.4b71989f@kernel.org>
In-Reply-To: <20230801151258.4b71989f@kernel.org>
From: Rushil Gupta <rushilg@google.com>
Date: Tue, 1 Aug 2023 16:12:58 -0700
Message-ID: <CANzqiF5Hz4qMnjQX8WN5XTLgv4axwOYND9c4=_Vy+mU57CQ82Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] Add QPL mode for DQO descriptor format
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, willemb@google.com, 
	edumazet@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks for catching that. I'll update the patch after 24h.


On Tue, Aug 1, 2023 at 3:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  1 Aug 2023 21:54:02 +0000 Rushil Gupta wrote:
> > GVE supports QPL ("queue-page-list") mode where
> > all data is communicated through a set of pre-registered
> > pages. Adding this mode to DQO.
>
> In case patch 4/4 does not make it to the list I'd like to remind you
> of the mandatory 24h wait period between postings. Sadly it does not
> include patches not CCed to the list...

