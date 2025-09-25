Return-Path: <netdev+bounces-226131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA5CB9CD31
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 02:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110541BC3636
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 00:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64C0CA5E;
	Thu, 25 Sep 2025 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vra7C+AP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81123C8EB
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758759163; cv=none; b=f7uoVORfBs3bOO0yDAO8trpA1/mVShs9HBxr1GyuPS913lWY66quyGgIlCJDasIy83+MzV+fqRT7KPX99/pjBN/LNFH5oUaOSM9xTFKltVCjIr2Lx3O4CwN57427omyTQDcSHcKeJ4dr8TzX+qtesgVm0LDO4/5AgsuVIYXNgHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758759163; c=relaxed/simple;
	bh=D9Rk3JTOL0/BVJNQgzwg78OPmHxdRlEkOdEaZk2w/jU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0P1WqjkHY+4XbTPoNt4VVz1wvJAnWT8kSUPs+JzZ3UxkWXndPQ13aX6XNSpXR6gosBqPeIlm2tQsrkScZkW0PdwehFsvuFh/CxYseGa86ILjUWStOsM6xfoATCApoSXEZZvptzW5g83JwRxEOGUAgqRY6K01H/6v3HEpKr0HY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vra7C+AP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC62C4CEE7;
	Thu, 25 Sep 2025 00:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758759163;
	bh=D9Rk3JTOL0/BVJNQgzwg78OPmHxdRlEkOdEaZk2w/jU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vra7C+AP+mbPIbIAgEvXic3wk2+ArwxDscbjTHnVA6iC0J8WraFpbElzDigVt7rpi
	 m334mq1wPtwc8NQqRNKDkOUAgTLZz8B54Q/euQQOtWnieCUx/7SvaZTnu1GTv9QEwl
	 PGe1WUfjubyEQw57H6Rwdx8/ip1n7gEJXOyoZbVgh82a50VCyv52ILxaedU9ZYCpXG
	 vLGuXARINvsoUS/6l9a5BaLVvt3Hsollom5k8d+SpYqckO7ogsvmhpzQ8gj5ZTF+Kp
	 51xGyeI9dfEQnxUwJn2CM+Yx/KFR1b94l+iWk5YryScJpUig0r8FfdtmNjA7EdSST2
	 NnJ+FaJehgAkw==
Date: Wed, 24 Sep 2025 17:12:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>, Breno Leitao
 <leitao@debian.org>, Petr Machata <petrm@nvidia.com>, Yuyang Huang
 <yuyanghuang@google.com>, Xiao Liang <shaw.leon@gmail.com>, Carolina Jubran
 <cjubran@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/9] netdevsim: a basic test PSP implementation
Message-ID: <20250924171241.189938a6@kernel.org>
In-Reply-To: <20250924194959.2845473-2-daniel.zahka@gmail.com>
References: <20250924194959.2845473-1-daniel.zahka@gmail.com>
	<20250924194959.2845473-2-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Sep 2025 12:49:47 -0700 Daniel Zahka wrote:
> +	if (psp_ext)
> +		__skb_ext_set(skb, SKB_EXT_PSP, psp_ext);

Oops, the extension is not defined if the CONFIG is not set:

drivers/net/netdevsim/netdev.c: In function =E2=80=98nsim_forward_skb=E2=80=
=99:
drivers/net/netdevsim/netdev.c:116:36: error: =E2=80=98SKB_EXT_PSP=E2=80=99=
 undeclared (first use in this function); did you mean =E2=80=98SKB_EXT_NUM=
=E2=80=99?
  116 |                 __skb_ext_set(skb, SKB_EXT_PSP, psp_ext);
      |                                    ^~~~~~~~~~~
      |                                    SKB_EXT_NUM
--=20
pw-bot: cr

