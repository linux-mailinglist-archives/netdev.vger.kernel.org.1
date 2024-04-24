Return-Path: <netdev+bounces-91038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 389D78B1187
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 19:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA080284A42
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8131D16D4F1;
	Wed, 24 Apr 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t+bKaUro"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E5D16D4CA
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981404; cv=none; b=mufaP+yUqiwFpZFOSbc1NZJ3kd/DwUNK+v0Px++jUzi1HkrLv4fMMq1c4x2v3QWu66msXAtLr14wa7zoweWPNBUyxpT60olm/q6wShTkbGu8C9sJKh8vt4IZ3tXTCX4iolgGWcq0eCjWvGspbsDK+GcGHtUton3QabSy3PplzTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981404; c=relaxed/simple;
	bh=RWkXdDAPfkJpiKcltcBrQt7q1vz7/sgfqjDtuw5QtOk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZjY1Ryxa9fvTxbuNPJ8KJ0gwRx6VCqDj7ujo3yfZq4j02rHhGCBD9lXBTPepBuh0765HrRL2+WH1PfN9scJbqijmyqoss7szv1QaXc09kzxqzCbebjIAMH3E9hbqOH2NtjMLiP7Go1XPiD9SPtiPcnDhDLPGFtRaqEdaaKBrT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t+bKaUro; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713981402; x=1745517402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RWkXdDAPfkJpiKcltcBrQt7q1vz7/sgfqjDtuw5QtOk=;
  b=t+bKaUro7gQWptMEb2IuLzr+iw880INb8BZzH31LBCHcbUFHV9aA61Kc
   AzOZQDmCyf06kn4D/i2KTqeBEhq97TB16lX11LWCopnqi6pTnM7nA7O5S
   2BpqcWm0V5EfSecHsvqaqzqJWMqkO6GBjAKyY6CVvMn86aFgKUxnQLJmm
   du0ghGqCu2npiZx0S6QoDrhVxxC49IlhhzPfFE8+JZi4704/g7gUf42nQ
   puvInH+C7ToouGstDGvlBdTRwIbDxfj3w+Bckhg6XvHMgY/4BatfjOlxC
   xG6i1H0vyp+EcWGz2oPGhHKgob6UtTKWKMT8m7UyYD86trst0VciIeZJJ
   w==;
X-CSE-ConnectionGUID: e6A9+ZpzQHq6hPQQ8aZCUg==
X-CSE-MsgGUID: xdQ6v4iyS6W8Onc4kFQAPA==
X-IronPort-AV: E=Sophos;i="6.07,226,1708412400"; 
   d="scan'208";a="24562898"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 10:56:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:56:01 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 10:55:59 -0700
Date: Wed, 24 Apr 2024 17:55:58 +0000
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
Subject: Re: [PATCH net-next v2 2/4] net: lan966x: Correct spelling in
 comments
Message-ID: <20240424175558.3b4ieuxw3yfrjptk@DEN-DL-M70577>
References: <20240424-lan743x-confirm-v2-0-f0480542e39f@kernel.org>
 <20240424-lan743x-confirm-v2-2-f0480542e39f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240424-lan743x-confirm-v2-2-f0480542e39f@kernel.org>

> Correct spelling in comments, as flagged by codespell.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>


