Return-Path: <netdev+bounces-46835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3327E69E9
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 12:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2657A1C20940
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 11:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC0F1C286;
	Thu,  9 Nov 2023 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeVtJ24B"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D511B29B
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 11:49:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC141719
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 03:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699530586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRWgktC5dBfBH0y4IlPCeWKy9YBplXDcHKZ7n5koZ7o=;
	b=OeVtJ24B4HYZMNRIlvDH8dGLJddDJv0Ylw7PduLfT4p+7CpDaNUrKKYeYN0wtOV4z4VC7A
	1E9aMu0wggtMgK+wNOAWY2N9njCpRxYpAIu+zHN6lNFpVHXwzK9BFB1jWZKoAySvdSEyqS
	x3E4X5JPn2cnlVN0L8Jukr5dRsq+Opw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-dTwAgvH-O1SGAaW21x9n_g-1; Thu, 09 Nov 2023 06:49:45 -0500
X-MC-Unique: dTwAgvH-O1SGAaW21x9n_g-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-778b5c628f4so14748185a.0
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 03:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699530585; x=1700135385;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rRWgktC5dBfBH0y4IlPCeWKy9YBplXDcHKZ7n5koZ7o=;
        b=DJr2/q8MjsY72MsP8R1pbDGHYeoJamebx9/VYZl+lUPErgHEmeGxr3qJ5F4jf9mTV+
         uQUaDPI1/2uTPTadZIW6zFEo23/V3FgbSJ2FCZ/THzxZCGqHyUw6wFynQtHwHf4GL440
         rOyxcoXDdoiVx+S4CeLF02zbk31XPywrZguqUwcpQ7KxxPYHna5Tzkjf6oFkAuUWniJ5
         c7MBMCLl6x+SL1USPXnwL7IzG7/j8cvHuKbnIlSm8RkY0vYabBloWJGspv0iR+fJHihm
         4oQeZ7CfwisKTpdnl8XSLQrerWPotNgotk9hWBSFmhB0XYna2r8263YdOOAeSbk0h5el
         J5zg==
X-Gm-Message-State: AOJu0YwoPoOuYpLV0b/ZcaRV0XVuI4h2Yn/hhfS9dTR//VDBlFBlR5ou
	1PLGiO82816P4skqlcujW3eIelCstw7nWEoaPL70etVXPNFMqzw9qPZHr2ok8SJF78N3YuJe3NH
	JZ9yr/8vimAHI1W6f
X-Received: by 2002:a05:622a:5186:b0:41e:4be2:d3eb with SMTP id ex6-20020a05622a518600b0041e4be2d3ebmr5519122qtb.1.1699530584773;
        Thu, 09 Nov 2023 03:49:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGUS4SbJ9ssl4USsnfkA9xKEduU/vOY24B+xDTRXOVdGNcq+w7LhBc+XgFeookbhcTcoTQKA==
X-Received: by 2002:a05:622a:5186:b0:41e:4be2:d3eb with SMTP id ex6-20020a05622a518600b0041e4be2d3ebmr5519110qtb.1.1699530584454;
        Thu, 09 Nov 2023 03:49:44 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id kf20-20020a05622a2a9400b0041b83654af9sm1859307qtb.30.2023.11.09.03.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:49:44 -0800 (PST)
Message-ID: <5783a6f8819a741f0f299602ff615e6a03368246.camel@redhat.com>
Subject: Re: [PATCH net v2 1/2] r8169: add handling DASH when DASH is
 disabled
From: Paolo Abeni <pabeni@redhat.com>
To: ChunHao Lin <hau@realtek.com>, hkallweit1@gmail.com
Cc: nic_swsd@realtek.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 09 Nov 2023 12:49:41 +0100
In-Reply-To: <20231108184849.2925-2-hau@realtek.com>
References: <20231108184849.2925-1-hau@realtek.com>
	 <20231108184849.2925-2-hau@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-09 at 02:48 +0800, ChunHao Lin wrote:
> For devices that support DASH, even DASH is disabled, there may still
> exist a default firmware that will influence device behavior.
> So driver needs to handle DASH for devices that support DASH, no
> matter the DASH status is.
>=20
> This patch also prepare for "fix DASH deviceis network lost issue".
>=20
> Signed-off-by: ChunHao Lin <hau@realtek.com>

You should include the fixes tag you already added in v1 and your Sob
should come as the last tag

The same applies to the next patch=20

> Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

It's not clear where/when Heiner provided the above tag for this patch.
I hope that was off-list.

> Cc: stable@vger.kernel.org
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 35 ++++++++++++++++-------
>  1 file changed, 25 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethe=
rnet/realtek/r8169_main.c
> index 0c76c162b8a9..108dc75050ba 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -624,6 +624,7 @@ struct rtl8169_private {
> =20
>  	unsigned supports_gmii:1;
>  	unsigned aspm_manageable:1;
> +	unsigned dash_enabled:1;
>  	dma_addr_t counters_phys_addr;
>  	struct rtl8169_counters *counters;
>  	struct rtl8169_tc_offsets tc_offset;
> @@ -1253,14 +1254,26 @@ static bool r8168ep_check_dash(struct rtl8169_pri=
vate *tp)
>  	return r8168ep_ocp_read(tp, 0x128) & BIT(0);
>  }
> =20
> -static enum rtl_dash_type rtl_check_dash(struct rtl8169_private *tp)
> +static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
> +{
> +	switch (tp->dash_type) {
> +	case RTL_DASH_DP:
> +		return r8168dp_check_dash(tp);
> +	case RTL_DASH_EP:
> +		return r8168ep_check_dash(tp);
> +	default:
> +		return false;
> +	}
> +}
> +
> +static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>  {
>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_28:
>  	case RTL_GIGA_MAC_VER_31:
> -		return r8168dp_check_dash(tp) ? RTL_DASH_DP : RTL_DASH_NONE;
> +		return RTL_DASH_DP;
>  	case RTL_GIGA_MAC_VER_51 ... RTL_GIGA_MAC_VER_53:
> -		return r8168ep_check_dash(tp) ? RTL_DASH_EP : RTL_DASH_NONE;
> +		return RTL_DASH_EP;
>  	default:
>  		return RTL_DASH_NONE;
>  	}
> @@ -1453,7 +1466,7 @@ static void __rtl8169_set_wol(struct rtl8169_privat=
e *tp, u32 wolopts)
> =20
>  	device_set_wakeup_enable(tp_to_dev(tp), wolopts);
> =20
> -	if (tp->dash_type =3D=3D RTL_DASH_NONE) {
> +	if (!tp->dash_enabled) {
>  		rtl_set_d3_pll_down(tp, !wolopts);
>  		tp->dev->wol_enabled =3D wolopts ? 1 : 0;
>  	}
> @@ -2512,7 +2525,7 @@ static void rtl_wol_enable_rx(struct rtl8169_privat=
e *tp)
> =20
>  static void rtl_prepare_power_down(struct rtl8169_private *tp)
>  {
> -	if (tp->dash_type !=3D RTL_DASH_NONE)
> +	if (tp->dash_enabled)
>  		return;
> =20
>  	if (tp->mac_version =3D=3D RTL_GIGA_MAC_VER_32 ||
> @@ -4869,7 +4882,7 @@ static int rtl8169_runtime_idle(struct device *devi=
ce)
>  {
>  	struct rtl8169_private *tp =3D dev_get_drvdata(device);
> =20
> -	if (tp->dash_type !=3D RTL_DASH_NONE)
> +	if (tp->dash_enabled)
>  		return -EBUSY;
> =20
>  	if (!netif_running(tp->dev) || !netif_carrier_ok(tp->dev))
> @@ -4896,7 +4909,7 @@ static void rtl_shutdown(struct pci_dev *pdev)
>  	rtl_rar_set(tp, tp->dev->perm_addr);
> =20
>  	if (system_state =3D=3D SYSTEM_POWER_OFF &&
> -	    tp->dash_type =3D=3D RTL_DASH_NONE) {
> +		!tp->dash_enabled) {

Since you have to repost, please maintain the correct indentation
above:

	if (system_state =3D=3D SYSTEM_POWER_OFF &&
	    !tp->dash_enabled) {

        ^^^^
spaces here.


Cheers,

Paolo


