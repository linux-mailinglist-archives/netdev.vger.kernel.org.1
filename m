Return-Path: <netdev+bounces-134933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BF899B97E
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 15:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FADA1F21713
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 13:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6147E1E871;
	Sun, 13 Oct 2024 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="Awux4AiT"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAE71EEE9;
	Sun, 13 Oct 2024 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728824649; cv=none; b=ABgM20Xw9jgdwQ24TE3BBw5xJ31eMK4bzMfeTnpsxo3THkEsofyo3xFM0FsY4IQ93T4FNohbCD/iWsGNobK2rGcRuiWCSmo6v2Q2/q5BsDCD7FMqrZNrsSfQ4FlSdloa/4Sb7Ry1ojTPLWxaEzwZauGaX7aP5dZ3ZrqUs1x8X0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728824649; c=relaxed/simple;
	bh=rDnuUa1HAwng3cbVtXHRzJs9QAMxLEm5dhuzU+UhQqA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UThDhmt4ENlO+Lt84byJnEYSzi6k1aWKiGg81s26BTay03ebfM+jspuRTGtbRALv3Rkit4O2vEHSIw+0rP3IG5SxH1NAvMmgep8+Ry/Z/eviyHXAcIDQNYkR1X4qC7FLqvArHBE1DPlTR8Gd1c26EvzvOp4eCs7Ix2orqhJlzqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=Awux4AiT; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728824618; x=1729429418; i=hfdevel@gmx.net;
	bh=AMxDGO15Or5yoSXKAsGKE5Aa2LASf14ueWnfYn0zK9c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Awux4AiTha10GxxR3eVQ8h0rJSoHfgWsp8Tskq151C40s+WmTwtoyK9dbaKUjWqr
	 pC2TqMFC0Q+MqUbeTB8M8ZZEbjIpE2U0zCPH9bD4gfrc2c8yhAD5GHTrjI6IjfzFe
	 u03M7zUuqOfCQb8dXEZqNQ67xc9hX5EZmm9MRZbG4QHDuAXZx+6GTcvBqzyWUZ7ni
	 6r24WiAeTGyZ87cGnovVmygjpmExyppPAq0MZTcrcmBQshLhZdilalMMPNpAY7zKn
	 F3GNlnCWwOWEQe8M2u6MC8CT2gpoPPJ1UwK3xOGJxHmZUraFDNNyddUAtTY4TTo1L
	 POJokLambUAfyA2cjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDXz-1tpBrg387J-00zRxO; Sun, 13
 Oct 2024 15:03:37 +0200
Message-ID: <2ba308ae-4aba-46ff-8187-ba9a69a26e4c@gmx.net>
Date: Sun, 13 Oct 2024 15:03:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: daniel@makrotopia.org
Cc: andrew@lunn.ch, ansuelsmth@gmail.com, bartosz.golaszewski@linaro.org,
 davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org, pabeni@redhat.com, quic_abchauha@quicinc.com,
 robimarko@gmail.com
References: <3c469f3b62fe458f19dc28e005968d73392f9fa3.1728682260.git.daniel@makrotopia.org>
Subject: Re: [PATCH net-next] net: phy: aquantia: fix return value check in
 aqr107_config_mdi()
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <3c469f3b62fe458f19dc28e005968d73392f9fa3.1728682260.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ON3Bgijp4Vimy6c0UekcvWcB9g+sYG11jLAfWl7hVnk7AUzvFVo
 4aVuYOuLx3Lsgdqgdk0RecKGrpa39krdgzv4oP0dDxXtgMwadghWkiP3CJ6q6Nc1kXz412W
 o0opw1l0Lr/7tTrRoBSjnZGbgTPAz46majjaRp0ZmHex9glWe5GmOxmEjIETl8fIGbsgCik
 yt5mPZkhckVBzCkYOkviQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wrgOdMHkwmg=;VxGi8cofJ8g9p6ncEcWEF0ohtlG
 1G1LxfuDsmvihOO1FFAqiqDX/uYblcw3rGC15Cas0cOUdrkFSxMKbrubXOizOb9n5dv8gpHUA
 AJLGVhEUf7p+my4Y0ungg8RL1wk7Hux5uBBdYsbizxtN1KQGhpI1p6zbUix7l+aaEAKA6H7TC
 RvRfuTY4IKFPSdaa29dvm3Tsm4vjhbx9mJIH6nvy1nTEPXIxBa3odZ7r0G0usrEoW6thb+4k0
 onYndIrR3xNZ3BYr8EpRlrfRPeR8BjwZa6kTadE9ToJaC9WWmq6uvXzbfDPXcBRMqd2UAm5IV
 ZLtBTJXG7gzCaBNSW37UIC8pygKniQxLtgr0ee5SyNV5JqNs9ammpol08C7z12ovJVRHl2RTJ
 u+h2tMzBGRmQhyowUFBs2rULk1NuwVb5WRIFGC/miPnB3eVXFXtuauLQ7VfSH+5kYjH79SgJN
 asy6y4I1O0tBiRkgexDSt4PszzPzEMHx8K7Xpu2M1EheWo91FuBX8gz5a/j/QsG+1RyoA3Hi0
 qvjHPi1bZt6dqeb28U2bOCm/8rgWoUV2zafxpRvUsghqYfDar4N6zylF/+pThnSvFYkWLHuhI
 0XdgBDnOanF8PZIysgvzwom04Y6HEw0g1jkFqskBTVahPbK9Fni3X2nJahlGXKjTRUDxXogix
 PGLn1vK75siDhjSbFKdpAoUETnwkvntoKLY77iiX64xW4MLB+cXM9AARs2WH0TIEIjSrls1H3
 gdTSKCpYfVpOdI+Ofcihpaxplgm0WSK6DHi3ColihTQ93v6YAWwWBdDsdJhTL/wANk9RMkgsW
 DlsFx4Si6h9O3WjjAC4rXKpw==

On Fri, 11 Oct 2024 22:33:52 +0100, Daniel Golle wrote:
> of_property_read_u32() returns -EINVAL in case the property cannot be
> found rather than -ENOENT. Fix the check to not abort probing in case
> of the property being missing.
there is another failure case, which is not properly covered:
if the system is non-device-tree, the function of_property_read_u32 return=
s -ENOSYS.
While you are correcting the return value, you may also correct this case.
>
> Fixes: a2e1ba275eae ("net: phy: aquantia: allow forcing order of MDI pai=
rs")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/all/114b4c03-5d16-42ed-945d-cf78eabea12b=
@nvidia.com/
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   drivers/net/phy/aquantia/aquantia_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/=
aquantia/aquantia_main.c
> index 4fe757cd7dc7..49fd21d1b3c9 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -513,7 +513,7 @@ static int aqr107_config_mdi(struct phy_device *phyd=
ev)
>   	ret =3D of_property_read_u32(np, "marvell,mdi-cfg-order", &mdi_conf);
>
>   	/* Do nothing in case property "marvell,mdi-cfg-order" is not present=
 */
> -	if (ret =3D=3D -ENOENT)
> +	if (ret =3D=3D -EINVAL)
the non-device-tree case could be simply covered by this:
	if (ret =3D=3D -EINVAL || ret =3D=3D -ENOSYS)
>   		return 0;
>
>   	if (ret)


