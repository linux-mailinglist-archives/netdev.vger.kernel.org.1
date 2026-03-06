Return-Path: <netdev+bounces-264726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEhhJyOrqmkYVQEAu9opvQ
	(envelope-from <netdev+bounces-264726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 11:23:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4886621EA10
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 11:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D5723016B89
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 10:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FDC3603DD;
	Fri,  6 Mar 2026 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ldo7WdIU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF113793C5
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792609; cv=pass; b=le5B3hak/6EfeJZ36wM3zd6PyXcljVah5HeNmnZwOfRJZwvu2lXgR59BW0DJLbzD9f83XDwMXCbvP5k0Ti+NS/bxQezQbsfSV+TxzMutwcpSLdimtTAE8j8fdWG70DrdJLnKLOxDAzuT3juIJyuyweYSWU0MG6AtDmQ4bKfepIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792609; c=relaxed/simple;
	bh=hkKmmWL316IwLhrjsGNWe6EywH4DnBMChiPnCieZffs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GI+18aZ5v8nUzKkwD66xjqExwvOXS55J7OkQ8g7LAXoYlZn/Dmw5VSUeXPNxXdsAzsA3ZZGRCzgGiLaxytsNKnK5+JlFP4YWwGP/v/GWJLmmYpE9Ibk2uDk+Y2sGu8TRp2+fe3sztpZI1iO69bHpS4WVt6qYX2RM4GdKLBN2Aks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ldo7WdIU; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a8fba3f769so39881165ad.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 02:23:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772792607; cv=none;
        d=google.com; s=arc-20240605;
        b=BH0su3Y2lw12OnDZtYX5TxxPZFjgbwnf7YSFRO0IVBWAsw60hpW2DQP+T4yy98KkTo
         RC4Kz9jsVzf1y9sxMEzBhkJWPD35DBQD3sRv/qJj5fWQto4jKBfv8/kSOUxSh7qnO4NW
         pyTIqS3CBs4WuG6/q9MYCb9edaoimGFNCyhQ/5Di5EIdVa4mdkhuQeE2JCSJbYy/jo9W
         Gxx13c3uiIEx3SZpyCpdsYt/rv6kvbA9A+e+mOSfEubH5wr8KWGPAN0JCxvHip44+Ngf
         Ss5t62ISKrSioZYOGiyvSC/WXIeXGZWhR9IhQGWEajUXa6EbIjUVvGVneRzxv/FxCeGX
         YEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3+6RN4E/K4Vq/uc6RPy3jrIOfOKL28+HyDVYpYRqe7U=;
        fh=CpznKZb3Y2GVzEgVdF0kQ9nv2y3eRybMGuc3PoWkz9U=;
        b=k+laz2kIqmGeOyXhUORc8XoPFRjFc2MLJvKdRCDuPZxoIp0dEOqdCbdZtAg4MKK+AQ
         bK+i6JGdebCBAiL5BMeD7pw/LnWR6SbvcECUFBDP/0fpHGP+5o6U7BOXYotiHorMYMfs
         Dk5IjM/XbdImV1vvA46iWj6fJqtg5Zhl58uaXCCx/78InVTUi0UL1g9c1qYTNDgHIg4S
         OX8K8Yvi+gH/rJyvF75B4nBkuCxOgeHFmutdH0Q/+rVIzNrbIH39XU7K69wcGnkfKnD1
         IleZbLipk2tlxd69usJbQVGIRAIsJHZD8Tjn86FU2ZF0WUKudat94DLiP9SCUPs3Tshy
         npnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772792607; x=1773397407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+6RN4E/K4Vq/uc6RPy3jrIOfOKL28+HyDVYpYRqe7U=;
        b=Ldo7WdIUczwEc0Va9XkdgtSedU9w7DuEanS38lZSt2eKKz81K0tuBEcZ+cFWu2Beep
         uAH/nDik2rM/wXI6NC39sId2qAa+nxI8rHSvNdQ3kJNRIUm4hq7nc9BsnKNWsVHhxLmX
         jaHrr0BsR6HuL/xBMELL0m5UonbR+rwn3Z1FkLfMrzWmhuAU3xG2Ejjzr8IuGc6gSf7I
         TrNchwNA3mX9hu8eoL81Zajnr43FY7OPY9JY0AmWRSzdSLkxlgOTM0jPOfa7LLvbccmE
         +zn9koFPkTrWF5//AzGFEeIarhIbIQftlPMrX7YgNpvOFOF1yR2kgepvV5CA1mQ4d3C1
         SQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772792607; x=1773397407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3+6RN4E/K4Vq/uc6RPy3jrIOfOKL28+HyDVYpYRqe7U=;
        b=odznTQlBW/MPG8N5iH04O70YUgr0BbVGd8cAs1uj9J/OhLjhqlppIq0SpPd94QSZSw
         QjTvQhO2wik+borsxbvDSDZ7tx+7om4D1o9YXlDOT4m4x3hwIVgMN/e19NsuLoeboYCD
         CJfneF5S4Nkf961PeiKJuWcrIKHoIeXYJM3q8vebLUM5l42HQEX5CUv30ns4fLyfHhCn
         //1SDC0STnYSnTTftOsGeiZDAl6n3LJq/nPdpDizFImgcKoiItoMnSRprTblwFA/dA25
         Hj5UnFLyG5l0UjvHhpbEgYQy3OYOphPXh6tfenMRYVST1APqhWcUeOY4w1hNpoXSWD0v
         IOWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAqD0tKNpCEDOe9Tzs4jaFWGfcospUhdQbE4oVSVcHIuMd/82Pdlm8xNqtfAtWAQCBGZjgu30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcVaFuKBqKI60SwnhHoQdqYf+cw0BdFWHePg5yCYrYdeHx3/rI
	jmhnAO3kzo4S64VwGxz9kq40Yp2zTdOUi92A4pnJ+JxYmvUMXSCN4D7XnxPpAm/JX8sIUbyo8xH
	aiLfc/P+g4DIN8yF7Y94I2sAVpwAZwYk=
X-Gm-Gg: ATEYQzwvt7CyFQgYR03XHfatm7OztnrA8vC0DtgFBgY+ksZsTe7oRwbt5DA9RQHyD7B
	x55VT1yR8+SNBnQZ5cdm8vt3Kc5j7bT+3aYRlC6AzMW5hWTY2I7npXJKQsv5K3dJqkwsGEAEduH
	ovnw9dxR44gcUwR2NGZs+OdigN+z67WoGVi/f5b/3JO0Z2X86Ebq7UdtTsLJPMdH04ggKjn7MZe
	PWMFV4LGw2GlFpaVO7vayQO9cK10/K1LRRKNJ4d46mwpUgAnPOlkIkf2qCQJUAODtKKwOaNSDPn
	fHQWpFS4lGRtfJOV0rJewOC4K0Z4dJm0BQ4NENfy3w==
X-Received: by 2002:a17:903:189:b0:2ae:61db:7982 with SMTP id
 d9443c01a7336-2ae823a28ecmr18541565ad.22.1772792607419; Fri, 06 Mar 2026
 02:23:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305125235.51286-1-noltari@gmail.com> <a628cf95-a0b5-447b-a514-96b2232d599b@lunn.ch>
In-Reply-To: <a628cf95-a0b5-447b-a514-96b2232d599b@lunn.ch>
From: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date: Fri, 6 Mar 2026 11:22:53 +0100
X-Gm-Features: AaiRm50NCjhhsFXyxFGHoDh9LgjJtmdGV7-PwzmDkdztju-6T8U-H6io1tvwx9Y
Message-ID: <CAKR-sGf+cNA5efKq0rxmNW7tVe1Sn_Lr3tTgqE05Jfu4obK-hQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: sfp: improve Huawei MA5671a fixup
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mnhagan88@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4886621EA10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.45 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264726-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noltari@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

El jue, 5 mar 2026 a las 16:04, Andrew Lunn (<andrew@lunn.ch>) escribi=C3=
=B3:
>
> > +static void sfp_fixup_huawei(struct sfp *sfp)
>
> Please avoid using a vendor name. It is unlikely just this vendor
> produces an SFP broken like this, other vendors will break their SFPs
> in the same way. And then we will want to reuse this helper.

I just followed the same logic used for sfp_fixup_nokia()
https://github.com/torvalds/linux/blob/5ee8dbf54602dc340d6235b1d6aa17c0f283=
f48c/drivers/net/phy/sfp.c#L375-L379

>
> So maybe sfp_fixup_ignore_tx_fault_and_loss()?

Sure, I can change that in v3.

>
>    Andrew

Best regards,
=C3=81lvaro.

