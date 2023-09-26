Return-Path: <netdev+bounces-36224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2534E7AE62E
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 08:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id E1DAEB209AF
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 06:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E674C7D;
	Tue, 26 Sep 2023 06:44:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E91C16
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 06:44:35 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB90AF
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 23:44:33 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d84f18e908aso8751794276.1
        for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 23:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695710673; x=1696315473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61aVUGOGTN3aSD7gJdb94H+TJu9K7lHrgxrABi+aRKY=;
        b=jSMHuDHHhLMYzR8SM9T18DzBuzzc6pVCCsGzjMPHXAc2pSyVD11hPmwBKSDqhcc6f7
         ChEqoDpo29wgWlXBCa5hlGxaraqdzfL5pxNV5K2q96x/qUAiJMZgZZSibU+ZplD8UF2i
         cW1bTuBHW9DmBmkxINtZupECyTarCQW/Kijwep28ftyoZHNhYMrmlYWCRJpgNuaUFuq+
         vF1Btnumqr6woN8SpqfWnRu2M55s/XHP4ea1k17RdbL4eDMy0yc6vFVmxpyAqG5CAOdh
         tT27EKxQNr3n3gJcfq7J6eO/u0jlLoJVrKeEEWcKLDLxXcWH29nZrEN44L9DLNq6aMI9
         RqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695710673; x=1696315473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61aVUGOGTN3aSD7gJdb94H+TJu9K7lHrgxrABi+aRKY=;
        b=feoZPtbjWQjAqsGtzEzy8v8+gF5J16xLlN6/PNWFZBTC43DVJBF13M6aW7VQ7u3o2K
         MEZ6MnTFmQiWNnBWZKVI1JmGzYmZ2ieGScgE5p2r7eMFhefp3iYvl8RoKONDqm/xghd9
         IkzEWv4gLO1TrpLekTUhf2M6WAvWg8LVWbpVTQetNqeGZTIO6CVVBMHCvShut31KiQZi
         xAKtcXfRloP/M8YfDxcFPZ4RMtV3BGIxfJPWjtOlhwcsrFZcoR08PIVDqkZEBIoblsVm
         japidPZDprt6pXXiDOYyuylTT6zrtRMtCUT7VzGs+fjjRHolrTmHcPMZjoS3ZXwUp18O
         Dlqg==
X-Gm-Message-State: AOJu0YzrDHI/0WadLmnzMpPyujAFuItLEEeCb4U4KXL7GUi8JwRzYY3n
	dtSQP9BtAf200amf1D0bfMXLy9RU/PbWwvQuqwO85g==
X-Google-Smtp-Source: AGHT+IHmEW12xGgm7jK8pxl2ZTKmJ9657HyjP9fQXfOhlnIMMIxY2wvD4MjZlOGq41oZ/TS2D5hsrSwHlLjnaSnKPsE=
X-Received: by 2002:a25:b283:0:b0:d78:1502:9330 with SMTP id
 k3-20020a25b283000000b00d7815029330mr7481834ybj.7.1695710673001; Mon, 25 Sep
 2023 23:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925-ixp4xx-eth-mtu-v2-1-393caab75cb0@linaro.org> <b109470b-99d1-441d-0648-7b8e4a8c86fd@intel.com>
In-Reply-To: <b109470b-99d1-441d-0648-7b8e4a8c86fd@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 26 Sep 2023 08:44:20 +0200
Message-ID: <CACRpkdbcMCXg8H8SsuhPSvvtdqD1reNxpCiFv5eD=gPYKUyr9A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: ixp4xx_eth: Support changing the MTU
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Krzysztof Halasa <khalasa@piap.pl>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 12:29=E2=80=AFAM Jacob Keller <jacob.e.keller@intel=
.com> wrote:

> > +/* MRU is said to be 14320 in a code dump, the SW manual says that
> > + * MRU/MTU is 16320 and includes VLAN and ethernet headers.
> > + * See "IXP400 Software Programmer's Guide" section 10.3.2, page 161.
> > + *
> > + * FIXME: we have chosen the safe default (14320) but if you can test
> > + * jumboframes, experiment with 16320 and see what happens!
> > + */
>
> Ok, so you're choosing a conservative upper limit that is known to work
> while leaving the higher 16320 value for later if/when someone cares?

Mostly if someone can test it. But maybe I can have authoritative
information from Intel that the statement in the Software Programmers
Guide is correct? ;)

> > +static int ixp4xx_do_change_mtu(struct net_device *dev, int new_mtu)
> > +{
> > +     struct port *port =3D netdev_priv(dev);
> > +     struct npe *npe =3D port->npe;
> > +     struct msg msg;
> > +     /* adjust for ethernet headers */
> > +     int framesize =3D new_mtu + VLAN_ETH_HLEN;
> > +     /* max rx/tx 64 byte chunks */
> > +     int chunks =3D DIV_ROUND_UP(framesize, 64);
> > +
>
> netdev coding style wants all of the declarations in "reverse christmas
> tree" ordering. Assign to the local variables after the block if
> necessary. Something like:
>
>         struct port *port =3D netdev_priv(dev);
>         struct npe *npe =3D port->npe;
>         int framesize, chunks;
>         struct msg msg;
>
>         /* adjust for ethernet headers */
>         framesize =3D new_mtu + VLAN_ETH_HLEN;
>         /* max rx/tx 64 byte chunks */
>         chunks =3D DIV_ROUND_UP(framesize, 64);

Right, I fix!

> > +     memset(&msg, 0, sizeof(msg));
>
> You could also use "struct msg msg =3D {}" instead of memset here.

OK

> > +     msg.cmd =3D NPE_SETMAXFRAMELENGTHS;
> > +     msg.eth_id =3D port->id;
> > +
> > +     /* Firmware wants to know buffer size in 64 byte chunks */
> > +     msg.byte2 =3D chunks << 8;
> > +     msg.byte3 =3D chunks << 8;
>
> I am not sure I follow the "<< 8" here.

I actually only have this vendor code, but clearly <<8 is not
"multiply by 256" in this case, rather that the number of 64 byte
chunks is in the second byte.

The software manual just describes a "OS abstraction layer"
used by both VXworks and Linux, and since that wasn't acceptable
in the Linux driver, someone has ripped out the code to
talk directly to the NPE firmware, and that is what we are seeing.
If you have the source code to the abstraction layer
"ixEthAcc" or the source code to the NPE microcode, I think the
answer is in there... (I have neither, maybe you can check internally,
hehe. Dan Williams used to work with this hardware!)

> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks!

> > base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> > change-id: 20230923-ixp4xx-eth-mtu-c041d7efe932
>
> Curious what this change-id thing represents I've never seen it before..
> I know base-commit is used by git. Would be interested in an explanation
> if you happen to know! :D

It's metadata generated by b4 which is the tool we use for kernel mailing
list handling:
https://people.kernel.org/monsieuricon/sending-a-kernel-patch-with-b4-part-=
1

I think this change ID cross-references mails I send with my
git branch, so it's easy to collect review tags etc.

Yours,
Linus Walleij

