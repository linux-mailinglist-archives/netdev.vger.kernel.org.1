Return-Path: <netdev+bounces-271321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JUFLjcJw2lKnwQAu9opvQ
	(envelope-from <netdev+bounces-271321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:59:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7744931D0F6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B90FC303E811
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46713AE18A;
	Tue, 24 Mar 2026 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pquzHbpz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3843B27C5
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389556; cv=pass; b=NeQPZlEX6fApaXmVzAzpykeJbWh+T05n5aECN8ASWqOzYG6JDCoZ4x2ZcZS84jRA3WK27vPOLyBQfnlQaFwuF3Oz4XmbQ074mPTPPNTstg/VexBK4o7cmXaG+tBZmvVMJb0J366qy/zqJJ9duTkoVRzy6WmSqdHgoTHS6mc4nrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389556; c=relaxed/simple;
	bh=/aCyCirncyUxv+akVBuL9DN5+58XZ7nWec6H0yHLlM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BN4L0BBtQkCsO2htkad7FQci57WIVJ6BhfoklBJhumJlfkgNXWHJDGqs8izMY4ChvDLY+tdBgaZVqp0PbUwIt+r4VOrQWK4FG84VmPHagy0dTXJVMeNxL10ktR7c9LvRUqlORb5j6u+R7dBks1pWy0GUiff2lLA9YWBr2KQkC/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pquzHbpz; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-669d7666d77so3964171a12.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774389553; cv=none;
        d=google.com; s=arc-20240605;
        b=J/SHwEcXBo/R3B+Ya9IFFswSipIX5mt88QwzDnSIjcpZa34W5fM0sBpPKtp8d/Llan
         KFxbthF0+MdApjOO9NawVjUXXA6uHOA0FmYCUx8hxLl1daMnzHjmO98yfoP543VHmoK9
         lBt+AAy7okQmkzk7tZeJXwN65ctuDL3jqIBW/swHyun2uhiRh2/YIvxFBnSV1gEVgLcl
         5tVtT4+HbxgApD35tIy+RS3avq1gy0UU6UQ6zuiS9RcBjAbo02SMlXPKH5gZm6AvkYGP
         YG3TLGGUGxsqQo05Jt8beAB4R2V1qR3iKHGgnwRYJUaXwOUz35woA0dCa7U4jPW0E/vO
         JCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ubHPdDAZo85fGM9vwGiDKHGAuOn66wdGOcMIAcVNJIk=;
        fh=dOpKiVAR+Cu88DehpfC43lT1lUIuwlpEp3fw0p3YtdE=;
        b=bZIZQlUDK0WNRQ/xLX/vLTXR4v0pODiZ8OF7ww/0IaHf6p7vX+u55FLOUImbfQoZOf
         9XYl6+H++wScQjpVtlEy1IvZxgu4PtQ4dnQar4khljWtR2F+JDdRcK4mSLhNO3kLBswi
         u4S+dfo45wGoPWrZOsPJhjOQO6KEklL2SGHizMdji3THt+mcOW1Q3LENX2ensmV7OuNU
         1sM/mOjAbQouKHYxaxki1Fq8jXFsY3TZ2A+xHkF43n4NiRlLhXRPnCLSDIWjn/Nn/u2W
         23alxZlF8KWb1MBhRcRe6vLPPJ/+42SP/BnMjk13fEBVC8KYVUI5o3RiuqHOH9NoanBG
         8/8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774389553; x=1774994353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ubHPdDAZo85fGM9vwGiDKHGAuOn66wdGOcMIAcVNJIk=;
        b=pquzHbpz7BfpcYXOryqOrW8SXkrX83n03DP9rT3RDayke+5nmvkAvJfsvQVR6ZL/NF
         ruZXuagwmQsHRNkd16VQmnPKuc+LKfvs+WEFxIfnTHsHCHuuG/NoJ4BzcNbaGSLixbQ7
         buFfgH4yl5Vg9/l77Jj9MQDS7mZk1aqBNwodJOrY9v+K/5BPGINkcS2CVA5FSmIITqFm
         S0J20TT4H7JNTxEorVuKdxGlJ76YODABZ/uOPQWOFfRPlj6iYBjyPx/esVSLdToUsOsa
         nZPLYRjYx+lWXAiZDzKL6YbPenx4lD9ZKaDuY95u80vTzQwQtz96d9YxyQgHdTWedtu/
         o72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774389553; x=1774994353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubHPdDAZo85fGM9vwGiDKHGAuOn66wdGOcMIAcVNJIk=;
        b=sCFkUFQfoNgsEcidMjyezPHf6Rm5IhwDO5UCWNKBcV5B1RR43GN/SDEwqdQyEarn5B
         sGLaw6CxKHAC07pYIa1JjGbtNH0GMVNn67GbwzTRLezWKJcNPZJlzmzZrDVlFBtfzjx4
         Zy3mMlDgD9UQANL5Un/C6g/w4nKsMwK2jp8F4MUM+jIedGG+7W+rpv1JfVl0piw9P5F7
         IEWuNbpGvH2A39Ur0Cxx/dCHhhUO3Z8+Re4vY6fytD9/eyfBs5bvjykhcKKq/o/v5sku
         ZFViOU/yb/BYudL2SRtt2Bq/73LImG6QS6/kQceMttk0VrAtLKF3m2HUINDcfkhgyJSb
         NNHA==
X-Forwarded-Encrypted: i=1; AJvYcCXEpvk0vdBrQw9aJrhG4dPbaBoolj8EK0nbPHbanv07scn6h12yibk1QH5X8y9hh5uL/svBBEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+7aZ3eptM06WeNEQgwytBSQ3ZvaoIiKGRMwoVnO1w0h6hc/Bb
	OS66MKl9G/Rlaww8OM2ZYUcIY+g4g2i4hJtBj8ktjibKp5+yfd6GTRW5vD88eondm6aw7xIP8b+
	yR3KOc8OUK4139gpN9RzRBBezyBNrUt8=
X-Gm-Gg: ATEYQzy+psUvYFQmXlczqDae54SkL+qTtOHrGp5wpXmTYM7ouC6418VQX360gnS+fpU
	ZtVXdGF3kZSrwuUA5eQckDg2FYuILY+jYpeHFUOG2DTEwmkasVF4N3UCv7i090uFIZ6xXSWaV5q
	rdS6Nu6lcm8GF98mmy5kVs/oAx7r9wpmLDHpe23+jtOeW5FdsIYw5DRybPRXCBAdfXcfhfgA/Tx
	T4oUvBJNtbjML8gltvxTEEfvpnp5fYaaf5weOKDROVySRkwYhocQto6LeCq24ShCSC08l9Ae8us
	qSE=
X-Received: by 2002:a05:6402:5059:b0:667:9545:18b4 with SMTP id
 4fb4d7f45d1cf-66a82651f3fmr598622a12.12.1774389553195; Tue, 24 Mar 2026
 14:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>
 <acKypS845fm_GB0o@shell.armlinux.org.uk> <CAMsLQxFnhPT5TLmwQS14rrgD8xmgs6ymH8Q3ee1KcSqm1XEstw@mail.gmail.com>
 <5ff11a7f-6f92-4488-8138-9f8d6210ae30@lunn.ch> <acLtrOrZe0G89MBy@shell.armlinux.org.uk>
In-Reply-To: <acLtrOrZe0G89MBy@shell.armlinux.org.uk>
From: Daniel Wagner <wagner.daniel.t@gmail.com>
Date: Tue, 24 Mar 2026 21:59:02 +0000
X-Gm-Features: AQROBzBD1QsoByVXv4gEoiK0pvdol49FAacKUp2l6XdRdtS_50byPk1Ajv92aqI
Message-ID: <CAMsLQxFp4hFxTbjBswM3GqX+VsT9G2Y0uP_fDhQkbzJdhbLD2A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: bcm84881: add BCM84891/BCM84892 support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271321-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,broadcom.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wagnerdanielt@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7744931D0F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Can you confirm whether bit 0 changes depending whether the PHY has
> link. I don't know whether that's media link or host-side link, so
> I suggest checking both.

Bit 12 does seem to track copper link state in my test:
  [0s] 0x3107  bit12=1   carrier=1   plugged
  [4s] 0x2107  bit12=0   carrier=0   unplugged
  [19s] 0x3107  bit12=1   carrier=0   replugged, PHY sees it
  [20s] 0x3107  bit12=1   carrier=1   phylib poll catches up

Bit 0 stayed at 1 through all of that, and through ifdown/ifup too.
I'm not sure what it is, but it doesn't appear to track either link
under the conditions I can test.

Bits[4:1] stayed at 3 through all of it: copper transitions, different
copper speeds (1G, 2.5G), ifdown/ifup, on both BCM84891 and BCM84892.
No USXGMII codes.

> That looks like 0x4011 isn't documented on this PHY.

Indeed, it jumps from 0x4010 to 0x401A

> There's also a bunch of MDIO commands that can be used to enquire the
> status of USXGMII enable/AN enable, and what mode is used for 2.5G
> and 5G.

U-Boot on my device uses SET_USXGMII during PHY init. I didn't plumb
the mailbox into the driver since phydev->interface from DT already
tells us the mode.

Daniel

