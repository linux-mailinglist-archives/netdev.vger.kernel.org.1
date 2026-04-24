Return-Path: <netdev+bounces-280983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD4RCf5Q62nkKwAAu9opvQ
	(envelope-from <netdev+bounces-280983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 13:16:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B1145D93B
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 13:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A4AF301A29F
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 11:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542213A7599;
	Fri, 24 Apr 2026 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="DN+MxgKy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962A83A759F
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777029305; cv=pass; b=I2ipteYdYTYNnZBJ3GenuMyp1hC+tN0iVc0zrjApSzrdOF4zYkYUbkmukYmeRohrZ+ivgScUlqLFKzwMZvnnMGNl/pCf6hfV4Wtd0zqNltKenk2hjzet8LcVJqY6Ye87lyeTc1qShGYv9qdXZO+V2vIpOssgyOrjGwXOZkZ+FFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777029305; c=relaxed/simple;
	bh=IOpArxetNoUYaWJeGtiU6U0Bc68joP/RY0jDbgkdyl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHgLlEcs1sVw+V5rxLx4DcGraLL/eqSJQyCFXBv890t1NUPC4q07oML5ZoiQgnjrqMPfuEISQrqLzJshEjfG+I91McCIDxqd/fpwIp7aiiQQdB+jtvmFfXV/UnKJvCHbfE4DcNp8UXGxn60QITAE1eElSWd2euII4o3bA7YaEVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=DN+MxgKy; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c1a170a50so9785024c88.0
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 04:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777029303; cv=none;
        d=google.com; s=arc-20240605;
        b=VLOH2hr1pYzzA5O9NI0fzwNusAm799g7SwOQcO+29MwhuitLGRskIGFKjnLcv13gfY
         dFh8gFEW5/tJtRL4XNvwAxIN3cJa5AY5LktP39Nn+++k9BqLpSTVfX2dBhdxbFFlUgaG
         h+a1rQ8Qmto9ojHA8YQeswddtk0MvbevBr+dNr7+tBGaT3C4r8Z4UfjO4YCgNJQdkVAw
         cc/Y89l3qcaJH5VDbRpYZDAJEMGESMPUL+qulfURRyosb2TnmSCA+qnG0t9YH0gZJ3iw
         I7yIVw+WeEb+P5TupYPMR/7EdEjcKIpi+MFEQTbClnRIwzBMBhCanvM1szFyS+gzukgK
         Fu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=46ztGlPgIzPKZ9MDPjOdy98igq+2AeqoG7MwjcZxBWs=;
        fh=Zmx/BB+DvZ77xx9PEvkN9qmvmEFQYnFclgU3iugtvBk=;
        b=j9i++D39+lU55OckjDLRqXk+58eEWSPsscX3qwvT/A058+d1J9/L5aGPADuL31YMGW
         5h2Q+11uaHnJJGmwcNUWDVGi01q7ld2XjX4QM02dSeUDwHLEecdFgEq6AS/grsuJzvsK
         Sz9lc9uzS8h5E4qXM6O0gJ6VftFM8CxX7/pfdZKmQTTEOVY3FYt/IJvL7FY7B9P8r7JM
         xWzJoh4c/lJ8L3KLm/+wkYASfcjoT8zLcnvwIiDFjfMWdbWcMUxeFQ0Y6IvAzdrwca9M
         zJcF+HGca1GlXCFAt3FGDaOubtM0qH/7fZLXaXzvsP2qEJqJ+xzwvEfgytmBOlAniJsD
         aCOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1777029303; x=1777634103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46ztGlPgIzPKZ9MDPjOdy98igq+2AeqoG7MwjcZxBWs=;
        b=DN+MxgKyGmg7ZgwAGDGCwNnxIsc8dB1ymeTzmSb77Q3BAz/mgszRx1U5nlNNbxVxtf
         itRttRedJFcvUcwxpTIGALj8wAMbqzeYISA1GefzbXQ/GK/nvF08+C93KzvfCy7TvzSm
         3pklA4brlcQPzUSMlvcHwrEWAOurkMFzy4IcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777029303; x=1777634103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46ztGlPgIzPKZ9MDPjOdy98igq+2AeqoG7MwjcZxBWs=;
        b=NX+U2UhqbZU9pJtIq38/8+q8j9C8jk1S3hhZ+BgmmclmbZ4VzeJR7gQwJedfIzfmcw
         1HSN9K7/+Lbs7dZyAweKr70PGAEheiITTDModDf/YCo8V393/OTfYIRPbqMSOEcZtdt4
         gyxOBzFOsaW5tSC/0yc29QOQCBAdODcY/VFzyWAJMoBK+Hl/MFaQ57sTD76rXajqGFkN
         AnRedtmxBFRnmo4In6Dgl91b0vQWzkZ8i2OUbGPM9757/O+qn5xWIMTVOZMh7AcmMnkl
         j30cneWhiOJ4HyWJCvpkD4PW8MmYQnY0RTzgy6wk9Vyl17fjVPWYPHh7PqncOrNnJZdi
         oHcw==
X-Forwarded-Encrypted: i=1; AFNElJ9P9KPuaQjgsmygpVfvTWIyofCN33DKjVrsjyar26mPqQdAjTx+f0K4ni3gbpwsD+ySR42oCkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzibFCodgvkpFT764dC1bskf59EUk5ESEKm3P4LQQ/paShvcDax
	kKwsza7Km+QJHneC72DzbC9GnRDqYE//Qc/Ln++fVPo/gib5Qf+1D6kWACtiK6XMaS4fZtRvlU/
	WxrpsQRW67mJSBNI6LyAGEBLuZGqil9wb413Vnh0CHQ==
X-Gm-Gg: AeBDieuLbu2IkECc0I+N1AZG2TTWDEgWhdJbxLeeWhSSeZnvWFFriL4W0jRLiSjqTRM
	aKE9BwG+lS5adEKFvjKhPzuKgxJpTEjU33v1MVtTd2b7P1uNU15SDyrsytXbsxvDrJdXAhuWJhZ
	L75JM4TBTdUifFTHWIvI6ZNyNv9oImnxb6orf1s1DtUmpzgtkOi2FaqHs4ApNZiWKkCv4Tmd3Oe
	i8qFwJvR7s+UipKfB1SuNfJiLkHfQ27WC/uhTQ9DT6dCWmEPnckyXdzIQM5Jy1ICAZjkXTZUd0e
	2JP8/iBoUtbfRFOd6IIQllcOwYsS
X-Received: by 2002:a05:7022:401:b0:127:380e:ff5a with SMTP id
 a92af1059eb24-12c73f92188mr17514204c88.17.1777029302601; Fri, 24 Apr 2026
 04:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423235422.1541768-1-kuba@kernel.org>
In-Reply-To: <20260423235422.1541768-1-kuba@kernel.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Fri, 24 Apr 2026 20:14:51 +0900
X-Gm-Features: AQROBzAEZi0DW38z30b08Vhil1YewCtR6flRU7HTnogSrPfxBR_x2W_hi0E35VQ
Message-ID: <CAFr9PXnNVL4mUEu19jMu2sPkOucGK7Q32iB-7FY8eUpKZY_XJA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking deletions for 7.1
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C6B1145D93B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[0x0f.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[0x0f.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[daniel@0x0f.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-280983-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[0x0f.com:+]

Hi Jakub,

On Fri, 24 Apr 2026 at 08:56, Jakub Kicinski <kuba@kernel.org> wrote:

> ----------------------------------------------------------------
> Andrew Lunn (12):
>       drivers: net: 3com: 3c509: Remove this driver
>       drivers: net: 3com: 3c515: Remove this driver
>       drivers: net: 3com: 3c574: Remove this driver
>       drivers: net: 3com: 3c589: Remove this driver
>       drivers: net: amd: lance: Remove this driver
>       drivers: net: amd: nmclan: Remove this driver
>       drivers: net: smsc: smc9194: Remove this driver
>       drivers: net: smsc: smc91c92: Remove this driver
>       drivers: net: fujitsu: fmvj18x: Remove this driver
>       drivers: net: 8390: AX88190: Remove this driver
>       drivers: net: 8390: ultra: Remove this driver
>       drivers: net: 8390: wd80x3: Remove this driver

For the drivers I really don't think enough time was given for people
to come out of the woodwork and say they are using one of them and if
they'd be willing to maintain it or not.
If this does get merged and someone wants to put one of them back will
it be as simple as sending a revert?

Thanks,

Daniel

