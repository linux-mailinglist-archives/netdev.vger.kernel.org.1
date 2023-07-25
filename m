Return-Path: <netdev+bounces-20982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C522C7620CC
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE422819BA
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22B325932;
	Tue, 25 Jul 2023 18:00:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E9B23BF5
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:00:50 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8141FF2
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 11:00:46 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6726d5d92afso74895b3a.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690308046; x=1690912846;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8pvWP56yrG+yvqkjLNoNVOKhLl/iC48M8XtK4jAeFOE=;
        b=p0AT2uHqpMkK1JFQxWrllEfbOcJuN9kYWP5FXpFykSytW5qjEn2EewZCPz2/ZOBo5X
         VXa1jcLEblGdYQHB9zkqO0ydHwIhrhApWmYWgnCoX4jRV27eMB9Lw7KU6GyUkiLF5Vox
         NhqVidL7ZZuxEg+/Q4mLi628DUduDF05C0aQM2R9OPO2+sMVo7qzbVnSAV0T8p9zZLax
         +7qkap4/X+y10IeVV3ev8p0QiGjwo5PzYhsgNLFmoX1YOND3TrBjo5JxIUb+AevnyliG
         rvH+nuvcsCwowA51tyz05Izw66UvKaLX6bU/uevBxODlsdR05cuG21oXcIyZK/r8xDeV
         faog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690308046; x=1690912846;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8pvWP56yrG+yvqkjLNoNVOKhLl/iC48M8XtK4jAeFOE=;
        b=ZFtSSFoZkImdbrzaaoWO0SpjTPZZqpazpEfOmmSje2pjEAHnhI0aswmRH6KLKUONfQ
         DJJ4NjFrkBXL79CKndZSD5Osz1UEJIJLGMpOWWJAJVspym3d5Exmay12Th5RM+hKIrbf
         h0fU+KcgwUB3hDq7TiDKurIXmHj8Q+5y9xgulnukyz2eLuhvxdoASsm0io8FcK6ScOFk
         DHcq/FEkP8ZIV1ZD5DX9veMjMwuX0oC3nQbDyrCROQZXbCrhnWY3Sp/I0xcNM/3xeLPt
         gXWrc3Jjf/Fri6KKt4iNJxJU8sp3KblLkp17NJy25A/CVeEib7alCE0+TdT0Cn0Mwbn2
         j8Tw==
X-Gm-Message-State: ABy/qLYeUmG+nzIhncmw+pq65Xn7lD2eyQOcHsMUcrrd4RNoIfNfCmXs
	+XhnnyK6BgEzPTGpIKN3L58=
X-Google-Smtp-Source: APBJJlHH9Bl7U5IT2hD9W7uQfokQ6dOKoRbZjLiP8TmSCUS0REjzYIYqzlHEQub6oSEYfEnA6e9pkQ==
X-Received: by 2002:a17:90b:1b07:b0:268:2862:7414 with SMTP id nu7-20020a17090b1b0700b0026828627414mr37755pjb.0.1690308046126;
        Tue, 25 Jul 2023 11:00:46 -0700 (PDT)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id lc14-20020a17090b158e00b002612150d958sm10069629pjb.16.2023.07.25.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 11:00:45 -0700 (PDT)
Message-ID: <8a5c57dd26f70399a3db012884c2ccb090b00dba.camel@gmail.com>
Subject: Re: [PATCH net v2 1/1] benet: fix return value check in
 be_lancer_xmit_workarounds()
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>, kuniyu@amazon.com
Cc: ajit.khaparde@broadcom.com, netdev@vger.kernel.org, 
	somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com
Date: Tue, 25 Jul 2023 11:00:44 -0700
In-Reply-To: <20230725032726.15002-1-ruc_gongyuanjun@163.com>
References: <20230717193259.98375-1-kuniyu@amazon.com>
	 <20230725032726.15002-1-ruc_gongyuanjun@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 11:27 +0800, Yuanjun Gong wrote:
> in be_lancer_xmit_workarounds(), it should go to label 'tx_drop'
> if an unexpected value is returned by pskb_trim().
>=20
> Fixes: 93040ae5cc8d ("be2net: Fix to trim skb for padded vlan packets to =
workaround an ASIC Bug")
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  drivers/net/ethernet/emulex/benet/be_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/et=
hernet/emulex/benet/be_main.c
> index 18c2fc880d09..0616b5fe241c 100644
> --- a/drivers/net/ethernet/emulex/benet/be_main.c
> +++ b/drivers/net/ethernet/emulex/benet/be_main.c
> @@ -1138,7 +1138,8 @@ static struct sk_buff *be_lancer_xmit_workarounds(s=
truct be_adapter *adapter,
>  	    (lancer_chip(adapter) || BE3_chip(adapter) ||
>  	     skb_vlan_tag_present(skb)) && is_ipv4_pkt(skb)) {
>  		ip =3D (struct iphdr *)ip_hdr(skb);
> -		pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len));
> +		if (unlikely(pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len))))
> +			goto tx_drop;
>  	}
> =20
>  	/* If vlan tag is already inlined in the packet, skip HW VLAN

I'm not sure dropping the packet is the right solution here. Based on
the description of the issue that this is a workaround for it might
make more sense to simply put out a WARN based on the failure since it
means that the tot_len field in the IP header will be modified
incorrectly and a bad IPv4 checksum will be inserted.

