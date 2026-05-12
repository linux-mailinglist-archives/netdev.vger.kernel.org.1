Return-Path: <netdev+bounces-287109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBWXI9YPA2qX0AEAu9opvQ
	(envelope-from <netdev+bounces-287109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:32:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B52E51F607
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8520530157CB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED62390230;
	Tue, 12 May 2026 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGXEzfjI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A9B4D90AE
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585553; cv=pass; b=nzgpILqQir+4hJUvqRoBSfrrb2dbTiQvQIS/Miw3GK7NIGrhXQ6JyKptvV3/BnE9bRnnZiSlcRuNCxRX4MJ0fyHBJp427lUEMtPWGROosvdqUmtJV1Sxkiuj/oW/V0vc0aK0yu4x/IA/l5k0RCZ3m9WhvlUkK1tJ0qlIFSXTRdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585553; c=relaxed/simple;
	bh=5Ic8h0yoyT6T1nhHXx4EipIfx10zGGWoapXnusF0nDc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=X+qyiLzW1iCw0aM1DABlbA5Nej3iiZuuIt5qNJsUl067JvqYo4uGOSIkgBhIfLfH0tR7ODmRGJEHMakOFvm3LhN63+fMSi4EzeIILRXy8JT/uqxReUnQdPBywZz8pHo5eqM/mIZELdS1fLvnlvo72nALmzRkUe63iQnKZf+a+9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGXEzfjI; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ee990e8597so9259113eec.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 04:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778585550; cv=none;
        d=google.com; s=arc-20240605;
        b=KrBgPj9JmbNJ68iusTAI3eDFFhun4ZBPNU3y6Ey7DJc3Ez7k5EmVRamcD95GxbLo0x
         2n5Q97e4MHea32olveZs7+gKBlGJxCBgWw6bizcHAfMm4jrvIQLBL24lakFBLGE7NU9B
         CKGLi9RolKHTlYJiGET0MLDwst5HYbxIzSq7yAzUkIUwZvTc8dQIUXyOU+ZLLZrNYJCv
         FwZoCqR7dRgpxxA/Fkrqw+3OpA1gEqkvGcI/744ob9quWWF4I6vnSWswgHvzxk68lIKQ
         RUimIda/L5OV9bF2Su4GefeHWpKv+RFn/6P6WmPEj+qSyF0GmK3Ae1c4XC0ZCQSE0qok
         ndSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=5Ic8h0yoyT6T1nhHXx4EipIfx10zGGWoapXnusF0nDc=;
        fh=iFIhTbJKikyfWuU66vrInLjOOS9pO0TYoBfQfpJU0E8=;
        b=LMbN7ErQGq/JTWNsX0vyF9JhL8A2rY9V8OaucyYzrwigRn2NSkKxq+mMRoUDv1+mPa
         Rvc4VLRGwRgmdxfNVP4rhOIEaOQ8aMhrkgK9is/xmY8bgQa/CEU0DNvPMZllnOVyP/G5
         EkQC2Tauwiv5IeICfuxPyrEGASrPWwOZcq28V/jEFI55k2wDCeKNFv6KwXYZE98LOdX0
         JlNgC40fgyYC07O3Lmqt1osw7qfxQ53J8hh0lbT2X96aQA1OpX3x8k0d76h/oGRnQx43
         NbpkwzvVPiWQSdf4FWP+359azPec4nUZv7NxeVfdgn2Iq9YnblqCnFZEpy0RSKGEfzhD
         gFSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778585550; x=1779190350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ic8h0yoyT6T1nhHXx4EipIfx10zGGWoapXnusF0nDc=;
        b=MGXEzfjIgTp08vXIJO/VZdv8lsBzpm7eaPQV6ik/B1Hb+0JJ1d3O5XbU2bxxllLA93
         mGLXqGWPKbPLzQtPK7b+u/iH1Tg24RVyI2B0G9ELTfH029xyQ+a7e2gm7x6s+O7ruQm3
         Mrrepw7mc2bRGpJvYzv/33lFTI6po952U78CWXLVZOPVOjTg26u6vCo6FXVj6yeQLJer
         +ltXaLLnbI1C0KIGbBAYfW45yVwT5AGp4MCqmc33UsMxzGXylS1K2WTp0usrh5ZTEqZB
         lWRUzIMMtomG71V75LPVoQQrfHivNkpUAgDc092N57dACeqiwL0VA7G2I4WOcjIqXzrG
         SqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778585550; x=1779190350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ic8h0yoyT6T1nhHXx4EipIfx10zGGWoapXnusF0nDc=;
        b=YAEpwjuR+klgDXvHNEaJBiWilmba96VVgxDDRTgvdrLL5iasL1PO73K/bwrJfa/jY9
         TwKPZgaxheZ9PrGvxrA9a/PsdZoZHUsFHBGXQWWf1DsHGIGzIX/CFbz6kijhAzpb96eU
         O38wjyFy99Pf7Gb72yni5Nbox2QZjjCCS8ghZfRxnR95s+yV7AO+tvK9PAVQo+BoB+SA
         B4GeD1Q8vEhlQJvcQx7DiBnhhLEp8BVHQGT9GeSmDptcxA8sxG0MObkbPfTwHRSeYYhi
         JHXRRQbIvC9gLL2mRn+271jugJtRJch9ENB0rQMqjSLSETEeLYReFWxdMN7e1FuYr8z7
         4HyQ==
X-Gm-Message-State: AOJu0YyzvdJuiX9+HKdt7xi2dO5htn71N1Jqk2Sanu82yIJkKxYRfCqy
	ImmXO95Un0lG7RCC4uNr9C35MVyxSKkQBfGGZ0pzy/zTFcrE+P4PInI9LUPCAZGoz3oFaOkttsi
	Up+7vFqPm92h3PbI8AwacuixbtG7whaKFCWwjnAQ=
X-Gm-Gg: Acq92OFvVZkHXOgzWgJmo3scCbkbG4Yj1f1/NQ/jE3YF0zC0OlaPh1fNd9GQhQBHaw1
	Jg4fDl117c9HjmOLC1VD754pMHNrWHhQROLJZNVwp3zh4RSIUUFdm/8CHU/7LSP+lGHShOOyJcN
	wNqF0iXMytwNkWKX8ES4PLoyCjybmkOYtG59U5alzLm8BhwUeDhjB9vHiVYUi0Y5zHd7lvz5YmH
	IJ12qDgzGpQ5u6P2dCL/a00NVDPpXH63ARcnRRRr5fDWqMq6VDiHWubNREY+DlTe2deamCjVsFe
	l49s7WI=
X-Received: by 2002:a05:7300:6115:b0:2da:44ac:6d0d with SMTP id
 5a478bee46e88-2ffd71fe5bfmr1429730eec.20.1778585550104; Tue, 12 May 2026
 04:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tiju Jacob <jacobtiju@gmail.com>
Date: Tue, 12 May 2026 07:32:19 -0400
X-Gm-Features: AVHnY4LifR-95X9Lohl0xXWpsM0-q4iVFg2AaGbpr40v_o3HOF6DOFFun3Evmmw
Message-ID: <CADAg6uxK+xjPRgmSXeqfmbw1RgzOhUukkc-X72O61ywKhvx1_Q@mail.gmail.com>
Subject: =?UTF-8?Q?mv88e6xxx=3A_88E6320_external_PHY_on_MDC=5FPHY=2FMDIO=5FPHY_?=
	=?UTF-8?Q?=2D_=28GPIO_7=2F8=29_=E2=80=94_is_mdio=2Dgpio_the_right_approach=3F?=
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0B52E51F607
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287109-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacobtiju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi All,

We have an 88E6320 (marvell,mv88e6085) with an 88E1512 PHY on Port 5.

The PHY's MDIO is wired to the switch's MDC_PHY/MDIO_PHY pins (52/53
=3DGPIO 7/8), which are separate physical pins from MDC_CPU/MDIO_CPU
(54/55) used by the CPU. GPIO 7/8 read HIGH as inputs confirming the
PHY is alive.

We tested exhaustively at runtime: marvell,mv88e6xxx-mdio-external,
NORMALSMI set and cleared, PHY in internal mdio bus, and all 8 PCTL
modes on GPIO 7/8. In every case the PHY at address 5 was unreachable.

The mv88e6390_g2_scratch_gpio_set_smi() NO_CPU inversion appears
designed for chips where MDC_CPU and MDC_PHY are muxed on the same
pins.
On the 88E6320 they are physically separate, making the inversion
wrong =E2=80=94 but even manually correcting NORMALSMI did not help.

Is virtual,mdio-gpio (CONFIG_MDIO_GPIO) over GPIO 7/8 the correct
upstream solution here? Or is there a mechanism to activate the
hardware MDC_PHY/MDIO_PHY master on the 88E6320 that we have missed?

Thanks,
Tiju

