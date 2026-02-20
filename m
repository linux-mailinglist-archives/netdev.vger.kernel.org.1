Return-Path: <netdev+bounces-259712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKz9IkhfmGnzHAMAu9opvQ
	(envelope-from <netdev+bounces-259712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:19:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08322167C01
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA4C7304F49A
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 13:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6742D343D9E;
	Fri, 20 Feb 2026 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="A/selhji"
X-Original-To: netdev@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690151CD1E4
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593426; cv=none; b=H87GJuHkcnBB1ldk8AxK8rukiLf+WeYkZN0/18FiwEYH/ugSi0MsGktXNxkXogApQXRzSF0a3UXcQYW8AS2qUPyOgyU5E6hupcSq4JWe7xl5q9aPlPGEHPV11OGmsBNzH8a0LaGk943IyhCopIL+Ux2IqIAhedSOjJJr6o63XZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593426; c=relaxed/simple;
	bh=q9gM4WcCB+3YQq34MqtXMaVgKKPtqg0dElkkwl6GeiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XrCEqhAmKI6z/s2YFPIKvE9CkLrifkl/e95NFsjkthPqB8meEeLcKyC40O2VG5A5dS7DC7r3LhJGg6hdePBKu7TwVUOzDyvwgJkWvQpV52vwWP5b6dOlmK97cp2jJnYxVHaV5OVq3GI+5HsD0dZoOnaxJ6zn3yfe058HBhLZvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=A/selhji; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 15949240028
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 14:16:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1771593417; bh=lKGbTAK+8Ycx+lfEIrFGLvCjSvLBMGu3yMZUrY+M6Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=A/selhji/JpxAz0OneLMCzvLoQ6zDi2bnVm7IHwAVtrmog/dgxyjx/Ah5w3Y4tdrc
	 2e920XCyMmhF9pDDMijWDMEetYg7wMcL25DFubNYBN9ewebJ/JN0PhoU2HGK32xwYY
	 lW68aNg/XPbI39moeCAXnrf4zJhUjpfaTce49BhnFMyaVc0VWX8oneJBAKR8LYHez+
	 OzunoYof3Fok0cars8b7KeqyIbim+baBFcuW7DH2hqq6fLib1ITvNVZLVnHefjGFlO
	 fdc+YAxd340bsky9YVWC3EwBik6fgE1eTH9Wkop8xCfpD/MtDjkd35Zb1Tw6UaBkBU
	 QR6PuEtx4YKeQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fHW480krLz6txm;
	Fri, 20 Feb 2026 14:16:56 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: nxp-nci: allow GPIOs to sleep
In-Reply-To: <20260220115906.102470-1-ian.ray@gehealthcare.com>
References: <20260220115906.102470-1-ian.ray@gehealthcare.com>
Date: Fri, 20 Feb 2026 13:16:56 +0000
Message-ID: <875x7rblmg.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=2017];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259712-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[posteo.net:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[charmitro@posteo.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gehealthcare.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,posteo.net:mid,posteo.net:dkim]
X-Rspamd-Queue-Id: 08322167C01
X-Rspamd-Action: no action

Ian Ray <ian.ray@gehealthcare.com> writes:

> Allow the firmware and enable GPIOs to sleep.
>
> This fixes a `WARN_ON' and allows the driver to operate GPIOs which are
> connected to I2C GPIO expanders.
>
> -- >8 --
> kernel: WARNING: CPU: 3 PID: 2636 at drivers/gpio/gpiolib.c:3880 gpiod_set_value+0x88/0x98
> -- >8 --
>
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
> ---
>  drivers/nfc/nxp-nci/i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
> index 6a5ce8ff91f0..b3d34433bd14 100644
> --- a/drivers/nfc/nxp-nci/i2c.c
> +++ b/drivers/nfc/nxp-nci/i2c.c
> @@ -47,8 +47,8 @@ static int nxp_nci_i2c_set_mode(void *phy_id,
>  {
>  	struct nxp_nci_i2c_phy *phy = (struct nxp_nci_i2c_phy *) phy_id;
>  
> -	gpiod_set_value(phy->gpiod_fw, (mode == NXP_NCI_MODE_FW) ? 1 : 0);
> -	gpiod_set_value(phy->gpiod_en, (mode != NXP_NCI_MODE_COLD) ? 1 : 0);
> +	gpiod_set_value_cansleep(phy->gpiod_fw, (mode == NXP_NCI_MODE_FW) ? 1 : 0);
> +	gpiod_set_value_cansleep(phy->gpiod_en, (mode != NXP_NCI_MODE_COLD) ? 1 : 0);

Do we need a Fixes tag here?

AFAICT this was introduced in

  6be88670fc59 ("NFC: nxp-nci_i2c: Add I2C support to NXP NCI driver")

which used gpio_set_value() instead of gpio_set_value_cansleep() from
the beginning (that is before transitioning to gpiod_* calls in
43201767b44c ("NFC: nxp-nci: Convert to use GPIO descriptor").

This piece of code is present on active stable trees. So you also need
to Cc stable?
  
Cheers,
C. Mitrodimas

>  	usleep_range(10000, 15000);
>  
>  	if (mode == NXP_NCI_MODE_COLD)

