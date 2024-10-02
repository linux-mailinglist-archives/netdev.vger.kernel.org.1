Return-Path: <netdev+bounces-131339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631E198E273
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 20:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163E01F250FF
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB11212F1F;
	Wed,  2 Oct 2024 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jquWF5f6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD321D0F58;
	Wed,  2 Oct 2024 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893721; cv=none; b=iNj0+Gp1gLzDPmtzpTMjlZxN8SUoJytLMgyDcoBO224a/EzQLYl1TbsXtftFs09MC6wqd908UYiw1ycXPqxcP4l4HeeYutx3yyNBuTYoTpyyBpuH8XsW9nCeH16jtJpjpEK2iH1KqtYfCMwfYzekRsPRQCUPoivuFhM3iLy4+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893721; c=relaxed/simple;
	bh=TSwf31CgKxEFLmDSaDVU43tksPFTOFFpy1oRWDlDgtU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syBIlwLzdYOMriJQu2+A5Pm1EEd73p5PFPXpGp4aisnoP3ZBe3++PcCk2qPFnQc4N4pBw4ToUJytuYJF7t04z+9eB3ezaH+GsGhZF2WLlzA6v0o/caZ8SuMZlUC2+ggGSPgvdzEzLovd30BIiHnSYuAWMOeWhzLQxJ640ImSZ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jquWF5f6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727893719; x=1759429719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TSwf31CgKxEFLmDSaDVU43tksPFTOFFpy1oRWDlDgtU=;
  b=jquWF5f6LV5tVn6Uz08x9Vrj4VPRoicATMO7LGsNbxO4Kl3Rb6jhzcxc
   HNnb/3Djs/3arPLLu0o8qeIPQDH8CFwvlbRclxxER2U4ccU3uBQ5gvYNt
   iDmOmO1RXVxyr3OumP7h/poQhQAdlPkPBOrHY4WA+SFs5JMadWz9y8vMp
   sbw1JC9mdcR95bTSGWlRK+PAJc/av2+D/5Y0w/f2sDkvlVO1Pdd6SGW7E
   m7t5zvKyP4HqwEzqZxCXk+WBwr218bdiZo+LpYzgLcWF9O8atnlrI+36P
   0TMMSR7wz3fZRfKEidYwAylOpoOI//n6ORyI2Erx9IJQ3Ark+0uO+nLU/
   g==;
X-CSE-ConnectionGUID: /NlVU3+eSUme1CvNLhzwAA==
X-CSE-MsgGUID: SCCJ/lFTQpqMomBCtmPsjg==
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="263566091"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2024 11:28:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 2 Oct 2024 11:28:03 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 2 Oct 2024 11:28:00 -0700
Date: Wed, 2 Oct 2024 18:28:00 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	<horms@kernel.org>, <justinstitt@google.com>, <gal@nvidia.com>,
	<aakash.r.menon@gmail.com>, <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 06/15] net: sparx5: add constants to match data
Message-ID: <20241002182800.nzk7qqe7zovhuelf@DEN-DL-M70577>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
 <20241001-b4-sparx5-lan969x-switch-driver-v1-6-8c6896fdce66@microchip.com>
 <20241002054750.043ac565@kernel.org>
 <20241002133132.srux64dniwk4iusz@DEN-DL-M70577>
 <20241002073352.43a3afb5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241002073352.43a3afb5@kernel.org>

> > By "type the code out" - are you saying that we should not be using a macro
> > for accessing the const at all? and rather just:
> >
> >     struct sparx5_consts *consts = sparx5->data->consts;
> >     consts->some_var
> 
> This.
> 
> > or pass in the sparx5 pointer to the macro too, which was the concert that
> > Jacob raised.
> 
> The implicit arguments are part of the ugliness, and should also go
> away. But in this case the entire macro should go.

Ack.

Will get rid of the macro in v2.

/Daniel

