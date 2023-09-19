Return-Path: <netdev+bounces-34839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AE07A5691
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 02:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902481C20EAF
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 00:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF23370;
	Tue, 19 Sep 2023 00:30:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4A3163
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 00:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649CAC433CC
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 00:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695083434;
	bh=YVWFNEKkJBJ/RI4l1AkF9AaJnTyfPMWcuZ2Q46prDA0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F0gHfHGV2wjIMIqlWxCWjYAD+ChdcWcu925j0SYw8tCVVUrnW58ttLUdE9GIZdOh0
	 QdxgZbWeElqp7E5MX4r47S9gDBTXux7Eknu1biBZ30WHOMqTxSELsfuDBUXc2VK8e/
	 bVZphL3rwnC/OqqLOiuHDk9c5hPblgXrrqxZ5oFbZ+WfO0Gf0qcYP7h4nQl2EIu3uD
	 GSheQOmbsehCRuL6qqfHXCW47NJDoeV6IRy5CCi+eQgBBGMXqS3UM38zVcC7d0Mc+L
	 tXxsX8rcLmtoqrCwdnQ8L3oy/NiKXMRkZSf2KZo8qo3XI3duNwr/sl+Lep7a0tGjq2
	 K3hEfHI+pm/Hw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so690946366b.3
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 17:30:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YwDesj3C+iXC4TjeXttzDyWEoYnW9z/iv0D6G7OGTzSAN2cRc5H
	YNMPWZXMpkX6dEKaDThBNPYnj4zmPv0Fjeg5dYU=
X-Google-Smtp-Source: AGHT+IGJjd/nrQ2nvKae99TQARSxIkXWg2h9wqcyr+lCCOlOdxu5No88Tu0vYt1DOZ3/Z3W1jxKWzb3cvudiP1GFNhQ=
X-Received: by 2002:a17:907:a042:b0:99b:48a9:f56d with SMTP id
 gz2-20020a170907a04200b0099b48a9f56dmr8531585ejc.22.1695083432784; Mon, 18
 Sep 2023 17:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918204227.1316886-1-u.kleine-koenig@pengutronix.de> <20230918204227.1316886-41-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230918204227.1316886-41-u.kleine-koenig@pengutronix.de>
From: Timur Tabi <timur@kernel.org>
Date: Mon, 18 Sep 2023 19:29:55 -0500
X-Gmail-Original-Message-ID: <CAOZdJXV--vGNouOc=4jJzciJduwSKEJV2-TQAzQPg+AB7DJ6-Q@mail.gmail.com>
Message-ID: <CAOZdJXV--vGNouOc=4jJzciJduwSKEJV2-TQAzQPg+AB7DJ6-Q@mail.gmail.com>
Subject: Re: [PATCH net-next 40/54] net: ethernet: qualcomm: Convert to
 platform remove callback returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Timur Tabi <timur@kernel.org>, 
	netdev@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 3:43=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Timur Tabi <timur@kernel.org>

