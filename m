Return-Path: <netdev+bounces-91039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101B28B118B
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 19:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88181F254CF
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EAF16D4EF;
	Wed, 24 Apr 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="06b+6cLu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D713C672
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981506; cv=none; b=jsiG/F2M71LxjNXWZiHkgnwN+EHGs5pX/ZEh7NNn2bM/zWfk/Pa4Bv8sX/OwJey6t8EhB4E9i7VUVEXrrB1HaUuyD3+Kn72UglFlfmXKj2sJE3OuYfQHuVHlRQMhz19gHTSeMXeyPkgzBew41tCjVVaM5t8n3wBCWyqjv1W7YaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981506; c=relaxed/simple;
	bh=RWkXdDAPfkJpiKcltcBrQt7q1vz7/sgfqjDtuw5QtOk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8mfxqYczp/L+C059X2OeP6FRgqNyZ+e7sa57VtwWHexe8DFtAiho1uIh/8NP4lmpSgrcLT1ybxPyvp9Mp3DC+K2cICF/jYzyLzJslBwEiJUKxQ059qRLrcAwzNZPd5VkaJB+XbKWEAMPI1Tz5tDiZta0atFBgQWZ97pJSlwM8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=06b+6cLu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713981504; x=1745517504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RWkXdDAPfkJpiKcltcBrQt7q1vz7/sgfqjDtuw5QtOk=;
  b=06b+6cLu+NanqHr1qp3EzmWqm/xMO5ETlFdSb8CwBfNiWYYAPUt1Rkce
   z6rJpvr2xgwxuO3+8ArfT1hR9T7pUPdB0H1DoO4JYLH7lz1huBm8mRY01
   flOmmjaMt+Avgmg/sZ80AzLBj5t5COZn+K/BF0YdUD2g7Y+pbfQovxnyL
   3+4Lv5+2BpiAp5q8csvkLXiyiNSXIALSB8cdWR9Kp4crdBcFJ3YzatfqL
   TAwriXwstCCKrFeF6Tjje6YIEVOQeXeIGHqsXyj5lGYEyPdfaP0QREPgS
   F3p2gdaM6lHcY7coP3mp1Yt9HEWQpBxcBgn/0T7nYsT2qnJ2YMUb2wQrC
   g==;
X-CSE-ConnectionGUID: uBieWstiSWigek204D9GSg==
X-CSE-MsgGUID: mChtQ/qLQB+RA+UggCcafQ==
X-IronPort-AV: E=Sophos;i="6.07,226,1708412400"; 
   d="scan'208";a="24563112"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 10:58:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:57:54 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 10:57:51 -0700
Date: Wed, 24 Apr 2024 17:57:51 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Simon Horman <horms@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Bryan Whitehead <bryan.whitehead@microchip.com>,
	"Richard Cochran" <richardcochran@gmail.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2 3/4] net: encx24j600: Correct spelling in
 comments
Message-ID: <20240424175751.xed3irvvik6bm5yx@DEN-DL-M70577>
References: <20240424-lan743x-confirm-v2-0-f0480542e39f@kernel.org>
 <20240424-lan743x-confirm-v2-3-f0480542e39f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240424-lan743x-confirm-v2-3-f0480542e39f@kernel.org>

> Correct spelling in comments, as flagged by codespell.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

