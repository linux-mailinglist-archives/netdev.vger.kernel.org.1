Return-Path: <netdev+bounces-24353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C2676FEA8
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 12:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027C02825A4
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DAB8C0B;
	Fri,  4 Aug 2023 10:43:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0638473
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 10:43:01 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED2546B2
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 03:43:00 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40a47e8e38dso196291cf.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 03:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691145779; x=1691750579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOJqrwX6eBicRAoTwudqPPw7DL3KcgjyNYI7qHOK9jg=;
        b=tlDzk8p3Qd9BVW31GLzRyv7ZUcMDB7K713VYP+7kXiputkHlQwiVDYUvytqQGIfBEr
         wbu6z7qPS0jGXDpZHsGjn1/qIr0Gf6TQ8o+iAVGfZjBtaRo4IWQYLaavW6VxGV+5NEw8
         IxWKqgrg+d1tqij+SWc8kCIJ0vrVzJMFyPt87YDo1FsVaP3rjl/qhtn0Y6mUKgUZECwh
         ur1HjcQqWFG+0rJUeOxaMEcaSa/Hz9J7WZaOoP+VomunEFcbhhuv08S8B6Gps3ZsiSf8
         FsHdkK+ccYJdcTueG2B9B0K1H3T/fp01FB/EeMAB24UK6fJXgWjhz/zQFXjCzb/8dUK+
         K7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691145779; x=1691750579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOJqrwX6eBicRAoTwudqPPw7DL3KcgjyNYI7qHOK9jg=;
        b=RTgUfmQPGf+yQed2uXEP0eO9WA4xgyW9FfdVat6pXgTTxGbP77HQxuwt0HsbTCtKor
         Pb+KBak3fy1gm2lTwsXSXaTgI11kFuLNgJKOIM+YyRwcS1mVmtAXCC1bHLbMhtTU1pzm
         HukvPNneDe8WBvD4nVcJvibfws4uyR1earnBN0wW+RBgogHkj08FPZxT5fU04hKyfAWS
         inX7OO+J3OyJZUhCyYlycx69+RBffC2jMCrGmkE0SJDrnq2zM5ZMAOSBfRX/Wrh7iRoR
         LSlDYTPVw/vM+BFV6W6Mv/Se3IXCZjvA8Ix5mo6ckjFjPp6NIMWXVJmqsGCF4sd67Z0C
         LlFw==
X-Gm-Message-State: AOJu0Yy0e81Px7fab4hqH56Nc3moewR5MRYed16Uft70PHEzlx8QqGBl
	x7nKBfj4WcSnXyeBgN63mavIi6Vb3NK4i2HmYNC6oL3KiYzKgjV+VBYmGQ==
X-Google-Smtp-Source: AGHT+IFrBg8TcAuKoTvcaWHA2QYZfg6pTqYF4x1vjZo0zej0AbfU2Xw2p0Mm2/elqdxoiA0GmcgX0loLYmVkvwMJ9XE=
X-Received: by 2002:ac8:5902:0:b0:403:b6ff:c0b with SMTP id
 2-20020ac85902000000b00403b6ff0c0bmr186859qty.6.1691145779225; Fri, 04 Aug
 2023 03:42:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202308041649468563730@zte.com.cn>
In-Reply-To: <202308041649468563730@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Aug 2023 12:42:48 +0200
Message-ID: <CANn89i+FTKRkgVodoQaCXH632rXx04AEe2_dJkqPiCEdtG0zQA@mail.gmail.com>
Subject: Re: [PATCH] udp_tunnel_nic: add net device refcount tracker
To: yang.yang29@zte.com.cn
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 4, 2023 at 10:50=E2=80=AFAM <yang.yang29@zte.com.cn> wrote:
>
> From: xu xin <xu.xin16@zte.com.cn>
>
> Add net device refcount tracker to udp_tunnel_nic.c.
>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Kuang Mingfu <kuang.mingfu@zte.com.cn>
> ---
>  net/ipv4/udp_tunnel_nic.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
> index 029219749785..ce8f5c82b0a1 100644
> --- a/net/ipv4/udp_tunnel_nic.c
> +++ b/net/ipv4/udp_tunnel_nic.c
> @@ -55,6 +55,9 @@ struct udp_tunnel_nic {
>   */
>  static struct workqueue_struct *udp_tunnel_nic_workqueue;
>
> +/* To track netdev_hold and netdev_put */
> +static netdevice_tracker udp_tunnel_nic_devtracker;

This looks wrong.

> +
>  static const char *udp_tunnel_nic_tunnel_type_name(unsigned int type)
>  {
>         switch (type) {
> @@ -825,7 +828,7 @@ static int udp_tunnel_nic_register(struct net_device =
*dev)
>         }
>
>         utn->dev =3D dev;
> -       dev_hold(dev);
> +       netdev_hold(dev, &udp_tunnel_nic_devtracker, GFP_KERNEL);

This is wrong. You need a separate netdevice_tracker per netdev_hold()

For instance, this would need to be in "(struct udp_tunnel_nic)->dev_tracke=
r"


>         dev->udp_tunnel_nic =3D utn;
>
>         if (!(info->flags & UDP_TUNNEL_NIC_INFO_OPEN_ONLY))
> @@ -879,7 +882,7 @@ udp_tunnel_nic_unregister(struct net_device *dev, str=
uct udp_tunnel_nic *utn)
>         udp_tunnel_nic_free(utn);
>  release_dev:
>         dev->udp_tunnel_nic =3D NULL;
> -       dev_put(dev);
> +       netdev_put(dev, &udp_tunnel_nic_devtracker);
>  }
>
>  static int
> --
> 2.15.2

