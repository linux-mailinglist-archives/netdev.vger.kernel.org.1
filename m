Return-Path: <netdev+bounces-102082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 398BD9015F3
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 13:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE831F2157E
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 11:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784172E63B;
	Sun,  9 Jun 2024 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jaLH3p0j"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D242233A;
	Sun,  9 Jun 2024 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717932263; cv=none; b=tlqAbQ1nKnutSvziP0VmrkGVG/yy3tXY03DZPhPb+OCkUdVeWT5aMS3Z2RuE68gSqtBmMnx+HAkkiOymy+VivhJHZLAmCJAKSF0S5cHSbzzzKVEkdxErmnsSZldVD8eG1YnIuW1khuMwKp8j+Tt9a8wnkjtZh+/e+zP+lJvxiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717932263; c=relaxed/simple;
	bh=q/iXIOMyLJl5xphpYTwH3w/lEzJ3M4l/7/fmNTRAZeE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=fWLRpn0oGWopYduWf1gNDP1nnJn2cWd9gDYHLJo8PnU6PCG0vCMYoB3Prw+V6IPwoUP+vWB5UQxLEFPvR3EYi7KEAYQLAzBOdMQ1SWwESWgdoz9yIKKua8Kj5/hqeTSnvLvomQafHcMF79eM+lR08dRCbX1QJliUKa/gFaT/QkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jaLH3p0j; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717932221; x=1718537021; i=markus.elfring@web.de;
	bh=HJ4zCaTWgNUn48MUERLAvrZ6HAXG3veuSDqVhXI7XfA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jaLH3p0jdorjs00Q+bnR9LcaaipNoRxj1XpVz0Ewhr5wHalsQbXvJhw3THTYALoI
	 Hgmod/cz128I5G3gUsPWd6ELT676AL2OtJMAy2fc9aO+qyqP8VvqsO+cFgxWuoOSS
	 T69QSplwPmdjP1Jyqme5LT5VXEyWZUyzTTFc9UKZe1UMvVeVvgp1t1c7FdKcKz4ZZ
	 6uiajyILhQw/urG1RNhhrcf4qbeE0zaJoeJu0/v4BS8XESKbZdDusPOF/dOfMNH1i
	 S7xCjp2pZ63ZsNJCTrsiZ7lFuTfVf2SB+kNmdIghjs+VHpRgN7Jtg9jfIChsdR1aV
	 ZU5zcmcQcetvhcM4wg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melf5-1snxRB3Nsj-00q09r; Sun, 09
 Jun 2024 13:23:40 +0200
Message-ID: <4aa34452-4e13-4dc2-a67f-5bd821fd0498@web.de>
Date: Sun, 9 Jun 2024 13:23:26 +0200
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
References: <20240609085735.6253-1-richard.chien@hpe.com>
Subject: Re: [PATCH] ixgbe: Add support for firmware update
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240609085735.6253-1-richard.chien@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2VFpPJBph9XiC5vhNiOmte11nZIZgjfOHt+kTXyb73NicWJP8kq
 TmMkwWvE8pGeQ8GU5ABYb0vEeNgUL8EwlpiO+3pSgkgRaPGHYtxpunzeHJK6+vcr46mX0Cx
 mnigvjhS9psZBvdkn4b28pmP2/U4S6ffcKwoCNK3vddo5oppRjskgueF1C8//ToVkWk8y/I
 bVo6IL6MhZSBu9erevrxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i1+OJLuE/48=;+swK+qIrek4neQqBpd9S0NH0hSm
 T+OzBThB+w3qj8yo8EPxADKPfzRb9aDf+hV9w8ynvILLQqwZ37IcSYQZk0Ck7Mr0j+xJ3Ye0V
 EGMIyeVJb90ouvgMZzHOgWwCHuqcS82mX6n/IvHW4v2TV/r//rw9hWULc+cjcyV9AXgAQ/7xi
 HDvAxWpTh6HIPQiK3Ow2LAsbsffL2JbOgtfk06dZ8N2d4pnC55l/CDhgTcapdsKnPbtS2c6+I
 dAofcBrEKuLAMp0STDXQtSLwDFwJWQlTxRcJ+4A33787VbhRpVMevar01vV1FWfMY1TW0SEjg
 cajpVzZZbTJY8PjnOnvNUjQI8AO4OxNlDMC0f7QdScdikkOR5ltEwiEAzAq3sITMPxWfQED/E
 dWm4E2iEHC0mvh7vHuyHe0I9qVjp/0wbgFfH5gmbJlkZw9ppN8sQr0xZAY4xQQl98rXlvu6ko
 aWrxWzNBFeCCm8hUhi8kEY4116ZIlvgH5V4cszl91ZK2FybOgmvhp1vpWxj5M7/VFOUjfYTAd
 1cAE5vo7jRLFsCGcZ4F2Xg5wNpVe04JB8QX/u+VvnKo+p9tIGglnq5+6G47QTNENmqb8qiK8T
 T7z2OWPefxeiojr8V6QBSiAkPudzeWPvWHF8RKgnT5JcjR2V6n65Rrh3DM6W+GxHF69vqGzcD
 SkjE6NP9wGU0EObBJTNef6ZcFdM6FmkXLpG6BUEGyX2yp8typdbhBlwaAoXnzqk42YPRTL8+Y
 KpLc1jpFk0nsboil81B8aPv0UQEptHjVU7vWhjXXxDS7yDaJoLMZ77wf7gobs5X4jvlDjSQxt
 aknYOJ4U+bGnzWJ+eGGHV1uAr1r8gvX+mKopjIG2NFVyw=

> This patch adds support for firmware update to the in-tree ixgbe driver =
and it is actually a port
> from the out-of-tree ixgbe driver. In-band firmware update is one of the=
 essential system maintenance
=E2=80=A6

Please improve such a change description also according to word wrapping
because of more desirable text line lengths.


=E2=80=A6
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -993,114 +993,292 @@ static void ixgbe_get_regs(struct net_device *ne=
tdev,
=E2=80=A6
> +static int ixgbe_set_eeprom(struct net_device *netdev,
> +                            struct ethtool_eeprom *eeprom, u8 *bytes)
=E2=80=A6
>  err:
> -	kfree(eeprom_buff);
> -	return ret_val;
> +        kfree(eeprom_buff);
> +        return ret_val;
>  }

Please keep these statements unmodified.

Would you like to reconsider the indentation once more for your change app=
roach?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.10-rc2#n18

Regards,
Markus

