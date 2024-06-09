Return-Path: <netdev+bounces-102092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893A1901639
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 15:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083B9B20ADC
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 13:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA554436C;
	Sun,  9 Jun 2024 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Tv63ZLCh"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F376341C89;
	Sun,  9 Jun 2024 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717939414; cv=none; b=kGdkRL6uiEwBR2B55rXlniiLR2+NFeLJW3UM3/RBy7p2CWqruExLDzhRK6Z17feMdMvih/aclYAO5tmqyEekPHkdmkZj6clRkbuWkHfDiab7/KXVYJ9rCKoCk7U4bSSEBdMcdChdgf2ijL0srZvRD2fQobwnkjhJ8vZVCR9s7Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717939414; c=relaxed/simple;
	bh=tVK11C9kJ+Hk9fp+TR4FXWWOziEx80YrD6j+XXKzGY4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=n7vHUqg9/8DkgmmRmsCgiloKzzZlFW1dytYH3d7Qg22aChB8aOAlBNm1pPDAH23MgwOzEOkTC+HVDdtEdDgH8ow6fnlyvDm87eNKZwn36/y3O1V2A5zoMdKbhush5L4xj+Ei4ZrDyl2nxjJB+QV0S5CgXg/1lF9lNKpaCc+0OmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Tv63ZLCh; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717939375; x=1718544175; i=markus.elfring@web.de;
	bh=25tOwBxb8NrUCwMNgIyHSiPtABS50jsxg2aCEapBvJ0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Tv63ZLCh+AiQAEpCr2lPKO97YI1D6aZy7+1HJU5OeYjOR+kLXyhWop5dfdci7tuy
	 5OoIj0+RF0/1nuGcW6twYpd1MMpmsz48qafJmjAZ0ktyozJMGNdHTOqLYd1dx0Dm3
	 32b+weBTRZ+Bnme6+eJxP1dCjDI1OS5r4pa4lbyRhrUzqxmWSwfTND9OKz42cvCXD
	 TUakUnAshr943/vRER4Z57oPLDfOZGBa4v7PVbaxCUGTJCVDDRqQa+gbDVDhqp3So
	 5TuFsEFEF1N3IyXdHulzixuF0DNKuyWwqnlnfj6snjsc+G7J7RXlLuafdKAdBwxb0
	 9Mli1YHwFKpUuT15IQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N9LIc-1sSJ2o4BzY-00ys40; Sun, 09
 Jun 2024 15:22:55 +0200
Message-ID: <9903f5cb-f4e6-42f1-a8b1-b3b5da593dc7@web.de>
Date: Sun, 9 Jun 2024 15:22:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard chien <richard.chien@hpe.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Richard chien <m8809301@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
References: <20240609081526.5621-1-richard.chien@hpe.com>
Subject: Re: [PATCH] igb: Add support for firmware update
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240609081526.5621-1-richard.chien@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z17MGjTFufmAsVzFpzvj8lSI7qMzlUGSGK5xS9coywFkv1zog+w
 Wp6dw5fNs1QCmj4Uv/rpGe5PQxd64GZk8rjmzdz1PhUDzoytNLOmHuzu55Opvkv+RkFYg6y
 jY8uS3C9DRGOdtH0pnTauSUyS4LmRfCRKdRLb4jnwsxKYM9G86cqOgSqr8I9BntdkscaOKW
 zx/RfKIKeqnNYJtNzLzAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZxIL5KsKow0=;V6dCDFstKp0XHYVZ9/UBAwozoYr
 XECA/KOp+Ounl5M33wIPnBceHaFMeEL5wVzEkWC1LtlmBCmO2QE2eLycecuhIZzbWhnz2HNHV
 LRHyY76hU+/VmjoV1udf/f5C8TpktOm59wawaVWG0bgO3kTm2j9kmHi0cDCgyNqsjMqYm+6cB
 ptS/9tcTv7qLCDMxyonjFVyjaiPTEuQ4T1HYvOH5rjvBAJGGghs5LFM2y2aFsbHxs38IUVaWe
 MYJUsnmxPZT2BzisCu3drOteDWofKSc9NmAB7wZNZlIAPZBIo7dbgkTxA/bwqBdf5sITAMxpy
 Qxvc3fY3r+FZhFnVGdZt25LS6v6D9uKpZp+xaUrLM6SvnXoTNuKPVC90hvzkTNhqcHQ+Y0Iij
 hoz14aG9ckHx4Pq78NHW4vaDrHSh2ZaHK9RCG/GXfbcTSnQ2mOSwlkFPcoDCJcsyFtiqNQRs7
 SUOhLa3d/MCtS6DtpqYI7QsU28STwB0B7lTjawh8MPdSQ8vDnF3/V1VoIW9ra8fUZ2XGFyg10
 GPX24Km0AGrwdvSqxjnpZ+Y9lFKu3oxiYvdLf55gQ/IlnfPH+LL5n+5ELMgm8iw7SInKxj9lw
 bCQ5z48ZoSUweVVJMOPF38JgbEngj0RxSE79PTZ+5wULVhiOfXTX3YGIJ81eMTnHENBqmU9Ci
 auWzA3i9+HB8ZfjzI+5rSlu2olNdRaHKrDeNEaoNE+kJ7hQm2KaNp6sDoxPPgeX4nhjaVV9Aa
 cu4JQWXum7SBxpXnKiasJ2Qn8KivxlfviLn4o9CmJl/ihC9rn5deQRhpgs0NpJ8AQ/qCx9ery
 ntxfSLdxD+x5eQw15AHGjr71hJVJpd39Bmj/FtL60X+tg=

> This patch adds support for firmware update to the in-tree igb driver an=
d it is actually a port from the out-of-tree igb driver.
> In-band firmware update is one of the essential system maintenance tasks=
. To simplify this task, the Intel online firmware update
=E2=80=A6

Please improve such a change description also according to word wrapping
because of more desirable text line lengths.


=E2=80=A6
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -724,128 +724,282 @@ static void igb_get_regs(struct net_device *netd=
ev,
>  		regs_buff[739] =3D rd32(E1000_I210_RR2DCDELAY);
>  }
>
> -static int igb_get_eeprom_len(struct net_device *netdev)
> -{
> -	struct igb_adapter *adapter =3D netdev_priv(netdev);
> -	return adapter->hw.nvm.word_size * 2;
> +static u8 igb_nvmupd_get_module(u32 val)
> +{
> +        return (u8)(val & E1000_NVMUPD_MOD_PNT_MASK);
> +}
=E2=80=A6

Would you like to reconsider the indentation once more for your change app=
roach?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.10-rc2#n18

Regards,
Markus

