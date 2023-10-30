Return-Path: <netdev+bounces-45191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330637DB592
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 10:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1141F2167B
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 09:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68668D2F2;
	Mon, 30 Oct 2023 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Al4YIthu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED043654
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 09:00:15 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ED4B4
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 02:00:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53f647c84d4so12003a12.0
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 02:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698656408; x=1699261208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7K4ygboP/GY4APGAOCgABrUsbdlE386siBpiiPBK5b4=;
        b=Al4YIthuHsCebp5zB5/FcVynOQD56NadVL/vZ3hETTpbsM3FYRBRRgszm+2lQC7vdo
         SjcCkwmyLToaFuuhiQm4S5bnxTiNMu06/D7HTGbXH+iiRegqO8TZfuRgxJZ+i9mQPJhn
         f20t03bcmLOBf6tVxjJwDeEpn0VAnVhoJvBWMCwtDXTtmaadqCSgPyntK8a5OW7ElBX1
         gB34YsZAxsC6VuFCVam8f3xWbCoWF2TZlzNoP3JdxgWzSnOLzLbDtsQp8V2FUZMf3/4c
         q4gIb3E8zRdCCXnKNOrDWG1CiZcgRwyIvfZR74XT0RNzvVka5+lS6uclVf3BYC5ksbKE
         An7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698656408; x=1699261208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7K4ygboP/GY4APGAOCgABrUsbdlE386siBpiiPBK5b4=;
        b=X7o9XNIF5xwdcvc15lFArt2FzYX9x6EQdcC2SX/cyTcJ32FA0Sj1/ETakQnG9vbrGQ
         Omo9g0b4G89FzIipg4JhXY99u+xOxEIyviBwKPClj1GqHRqLRm6SynHZF4NvzvVAD2k1
         nZgfO8IJOt4yOtJxGDFhRZxKlBSNiE1hpC+4mI0eZhoGh2WgfrH9CxRIH/FROMO0rDy9
         1gw1TnoIyNHHRG/UyM6QVGZe3PFlRCoj8ztpsIvr1e/NP8s/4kUTj/FAb5QgZnRNpFfG
         2DInITHbk4lAvVnYXXmVAQinLYCUXnBP9AscLenaBd2Wwi+HWz6iXYsji8ddrL1mzh4M
         nd0g==
X-Gm-Message-State: AOJu0YzQwL/j94QIklWiLLG6qHs1dXd3raUT7Ii8tNFHBq9UHQfeLpTL
	EiDEBm+ZKlOeEsTOlG2Bogj6NcxAg+d82C+OK2ZW/A==
X-Google-Smtp-Source: AGHT+IErb4XhfJbrSp9lfHzfI//VJKL1ekE/nZgdVzyVZOXhZC/i3UxpGK9LB5ic6pJn/hf9toCdfYFiUNa2/8U8F2o=
X-Received: by 2002:a05:6402:5409:b0:543:1909:1a3a with SMTP id
 ev9-20020a056402540900b0054319091a3amr48233edb.4.1698656408315; Mon, 30 Oct
 2023 02:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231028144136.3462-1-bragathemanick0908@gmail.com>
In-Reply-To: <20231028144136.3462-1-bragathemanick0908@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 30 Oct 2023 09:59:54 +0100
Message-ID: <CANn89iJyLWy6WEa_1p+jKpGBfq=h=TX=_7p_-_i4j6mHcMXbgA@mail.gmail.com>
Subject: Re: [PATCH net] dccp: check for ccid in ccid_hc_tx_send_packet
To: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dccp@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 4:41=E2=80=AFPM Bragatheswaran Manickavel
<bragathemanick0908@gmail.com> wrote:
>
> ccid_hc_tx_send_packet might be called with a NULL ccid pointer
> leading to a NULL pointer dereference
>
> Below mentioned commit has similarly changes
> commit 276bdb82dedb ("dccp: check ccid before dereferencing")
>
> Reported-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc71bc336c5061153b502
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>  net/dccp/ccid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/dccp/ccid.h b/net/dccp/ccid.h
> index 105f3734dadb..1015dc2b9392 100644
> --- a/net/dccp/ccid.h
> +++ b/net/dccp/ccid.h
> @@ -163,7 +163,7 @@ static inline int ccid_packet_dequeue_eval(const int =
return_code)
>  static inline int ccid_hc_tx_send_packet(struct ccid *ccid, struct sock =
*sk,
>                                          struct sk_buff *skb)
>  {
> -       if (ccid->ccid_ops->ccid_hc_tx_send_packet !=3D NULL)
> +       if (ccid !=3D NULL && ccid->ccid_ops->ccid_hc_tx_send_packet !=3D=
 NULL)
>                 return ccid->ccid_ops->ccid_hc_tx_send_packet(sk, skb);
>         return CCID_PACKET_SEND_AT_ONCE;
>  }
> --
> 2.34.1
>

If you are willing to fix dccp, I would make sure that some of
lockless accesses to dccps_hc_tx_ccid
are also double checked and fixed.

do_dccp_getsockopt() and dccp_get_info()

