Return-Path: <netdev+bounces-44839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CB27DA15A
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54BD01C210EC
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 19:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025123DFE2;
	Fri, 27 Oct 2023 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qb8MCI/S"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961F36AEA
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 19:32:38 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EE91AC
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:32:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9c41e95efcbso343241966b.3
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698435155; x=1699039955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWT6rg+UcGuVHCGktF1X9nMLt5S5rmKf4Xsx5qvsANI=;
        b=Qb8MCI/SE2t09YH08xsRPe7xvIDqvL4YihTNMkSt2rdMW/Dpmkj7WvvfbWvactJv1w
         mra5/BgWYRmmcK4QXvh8DDvCBQ1YtH+UHMMvnXaIq2T1sNqsnHZXsLru1aFepAOPfxna
         DTNH668VklYK5WsqmObTVftG6fYPibXxN06+C157bBpeQtKiePh5ITJsTg8S/Y9lOc2K
         SLcjr3gY2S2eO3BdkSuc9qU5yANyRJ4bf3VQmokP6P2nq059gFycvmOU+bx9alwG6hnZ
         q0lBMgpJLY8wfPjIhtmRnVmw1miRlhuy3CKN+TKb8U/k9LFvBhPNY4idEgAf4b147jSy
         KmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698435155; x=1699039955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWT6rg+UcGuVHCGktF1X9nMLt5S5rmKf4Xsx5qvsANI=;
        b=o7aeQg2IK5I0jnCGtXPOt/AZJqnYh2R3xsxUwoXA37lPkrCd9+sf8QC3TxkwiAtjhC
         8daEZ+12yKoymO1PgX00CjUI+js54GHYyVhOS2z9w0dI4TlM9AJ81rJgw3FRslE+VcJ0
         WVavzNfn+aaO+smdITJpTPsPzFtTyMzITWfxBSspKyvfxkIWVVncwS9Nccq/+aAhron3
         Li8j7QMd5CP2fhsAuuE1N3bQ6GrYNv8QPBSXnY0HvtMyDjai2R2m00Rb4AFYFqjvYWF5
         nWuBBa9z0LnoWB7GusUJP5PlzQ0cLK1X3szCe41K50TpqYhIxgaX8Dp968hrQjbbb3Jk
         UuwA==
X-Gm-Message-State: AOJu0Yx/9m7AnuVeoRAerT1dh8nuB3A6jRk5AZUjLQZLXoCZytAEoKzH
	ew9cY1EBBkaU4MUkESjB2zwkmdMm0WdebV0cn1EbYA==
X-Google-Smtp-Source: AGHT+IHAODo9hINKXNlQvGgAqxNPpRnNjd4AA89Jgp1KLx343fQyHwwoszpkk3UnOGcXvbD6V54sQTKCIm/OR/KX2/4=
X-Received: by 2002:a17:907:a0a:b0:9bf:b129:5984 with SMTP id
 bb10-20020a1709070a0a00b009bfb1295984mr2459494ejc.77.1698435154557; Fri, 27
 Oct 2023 12:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com> <eda2f651-93f7-46c5-be7e-e8295903cc1e@lunn.ch>
In-Reply-To: <eda2f651-93f7-46c5-be7e-e8295903cc1e@lunn.ch>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 27 Oct 2023 12:32:22 -0700
Message-ID: <CAFhGd8rSw7RRXTh0XE6EekPKeka34k5RT93gzqvP8s=PntCdsA@mail.gmail.com>
Subject: Re: [PATCH next v2 0/3] ethtool: Add ethtool_puts()
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, 
	Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Dimitris Michailidis <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Louis Peens <louis.peens@corigine.com>, 
	Shannon Nelson <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ronak Doshi <doshir@vmware.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Daniel Golle <daniel@makrotopia.org>, Landen Chao <Landen.Chao@mediatek.com>, 
	DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>, 
	intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com, 
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 5:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Changes in v2:
> > - wrap lines better in replacement (thanks Joe, Kees)
> > - add --fix to checkpatch (thanks Joe)
> > - clean up checkpatch formatting (thanks Joe, et al.)
> > - rebase against next
>
> Please could you explain the rebase against next? As Vladimir pointed
> out, all the patches are to drivers/net, so anything in flight should
> be in net-next, merged by the netdev Maintainers.

OK, should v3 be against net-next? I opted for next as a catch-all.

>
>     Andrew

Thanks
Justin

