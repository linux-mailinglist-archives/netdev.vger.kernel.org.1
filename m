Return-Path: <netdev+bounces-19124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965BA759CDD
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51475281985
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5856A15493;
	Wed, 19 Jul 2023 17:55:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4071FB38
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 17:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34B8C433CB;
	Wed, 19 Jul 2023 17:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689789308;
	bh=VAHpwDmbVb7vAmsueO0gxYld9Kz+/rC90JncY/i+0Z8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pUtLQqEmUh6jrfGRA9xHjt27XPhzYdfbSDgpz8mdy3PCA3IPTuWwydcfqHkfDveHB
	 qAxdNREGLUGdYWYdl7QKIoXLvV+zmEC9IwW1N0D4EUuLtSVTxwjCQpQtnoRwLo2Jhg
	 nlPgMrMD+gnyCrWkquB+7hI/1Qcd6WKQkOGGtf36q4LlIyJ1UrjNiuJz1+rJ3LkY3i
	 KGn9QzJWPYUnyOmE9+F0opil4iPTVx52VXVI79bHt3C5adIA+0xaujCQb+agz0evf8
	 aXDsWWsn6O+hPrxqh0lm4XuEZa7/oBrPTxiaPMtRmlRyejxHZzhG5ltF7XXAFg/k/w
	 aXKlCAekLo8PQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b701e1c80fso106457761fa.2;
        Wed, 19 Jul 2023 10:55:08 -0700 (PDT)
X-Gm-Message-State: ABy/qLZNIV0LKMXvNar4J8WjtznIksPbpowl47En8ulxPUx7jqybpEHE
	39jztkQTSuKTq6284rYPCm1bbD8YvXU+IRF2sA==
X-Google-Smtp-Source: APBJJlGL/kk3oHY6k1yfq7SsCPop3Wy3YQQE6Qzgt85P636iSCY98TK7gwsRHy3ktZQQSAMhuBPDa2ZKFWJ9nqnLjNM=
X-Received: by 2002:a2e:97c8:0:b0:2b6:a3b0:f4d3 with SMTP id
 m8-20020a2e97c8000000b002b6a3b0f4d3mr440245ljj.26.1689789306681; Wed, 19 Jul
 2023 10:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230718155814.1674087-1-kuba@kernel.org>
In-Reply-To: <20230718155814.1674087-1-kuba@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 19 Jul 2023 11:54:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKBbP_dXZCbyKtgXVDMV-0Qp8YLQAXANg+_XSiMxou9vw@mail.gmail.com>
Message-ID: <CAL_JsqKBbP_dXZCbyKtgXVDMV-0Qp8YLQAXANg+_XSiMxou9vw@mail.gmail.com>
Subject: Re: [PATCH docs v2] docs: maintainer: document expectations of small
 time maintainers
To: Jakub Kicinski <kuba@kernel.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux@leemhuis.info, broonie@kernel.org, 
	krzk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 10:00=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.

I think the split is great. It would be even better if this
distinction could be made in MAINTAINERS and then the tools could use
that. For example, on treewide changes on Cc subsystem maintainers and
skip driver maintainers. The problem right now is Cc'ing everyone
quickly hits maillist moderation for too many recipients.

Rob

