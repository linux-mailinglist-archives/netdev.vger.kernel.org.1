Return-Path: <netdev+bounces-131221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3D498D59A
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82C91F2206B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D121D04B8;
	Wed,  2 Oct 2024 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="b6HU06mU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB41D016B;
	Wed,  2 Oct 2024 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875904; cv=none; b=fsauLuMzDTU2rL2b68lil2ByObfBflaH7glZ4to+Z8P4PBIvn0iyUPCOKMBqft+xBOqBlI14lpX3ydjtN8T4hrM/A3GL71/Yg05IqXLmVpwrP9o4bwAo0qaqP9hKfvOByLRuuvHC9M0nQm1vT+5aHbZ9olKl/j7JxkklTGFM8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875904; c=relaxed/simple;
	bh=FiEuteuv0EhGG4lLAnaYCiolQxpFrJnZpAUbT4a0v+c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INx3iR81MiE+bmDyoSrTEF+msPwCvdivWP1V/5+9qx5NsJxJVXgGSlKhezUF0UhQ147pL3cqyqa5KDo72z6+TWOGt0IJFX+zlybNjSaNiYwTNN5b8jFYcUMzVo04dmYCOOHC+wmS730uR1+RgY4VVRHkbINfWfqjEHDGbMW01yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=b6HU06mU; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727875903; x=1759411903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FiEuteuv0EhGG4lLAnaYCiolQxpFrJnZpAUbT4a0v+c=;
  b=b6HU06mUGrXaBvec14/8K4nP2M9wqcY4Gg6Lwh7ftLb8N/JgbPNy7Nrv
   f3WYgzNHW4kUrMtBryFkkt2I7SqZe/g8xfjOprbS4IBT9m6g7iEHNiLC/
   jmXLsZ1ls0mTvgvGZUzlUm44vFEF71X+gAXQVlx9Uf3wbQ0gsgtXqjgiH
   cjb+eyzla/DPxF4l7c+snFlukrx0GYGVKvvkUmcJ7olQVkwz/3uSQ9ZLV
   UC+Rk9FCEEkLA8+sjo9C8759NtdIM1Y5TguVq5z76/jG16vRaW0bmpgI8
   VhIbxgue9y0f6DibaBoPYwFUxk8NQZt1s+A1VRKADJ2MV5Wz/tqQKwdXv
   w==;
X-CSE-ConnectionGUID: FJi4kDpaRGqzAXLvQdIhpQ==
X-CSE-MsgGUID: zOrvV2qYSde0awADUi9ZeQ==
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="263551893"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2024 06:31:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 2 Oct 2024 06:31:36 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 2 Oct 2024 06:31:33 -0700
Date: Wed, 2 Oct 2024 13:31:32 +0000
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
Message-ID: <20241002133132.srux64dniwk4iusz@DEN-DL-M70577>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
 <20241001-b4-sparx5-lan969x-switch-driver-v1-6-8c6896fdce66@microchip.com>
 <20241002054750.043ac565@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241002054750.043ac565@kernel.org>

> > +#define SPX5_CONST(const) sparx5->data->consts->const
> 
> This is way too ugly too live.
> Please type the code out, there's no prize for having low LoC count.
>

Hi Jakub,

By "type the code out" - are you saying that we should not be using a macro
for accessing the const at all? and rather just:

    struct sparx5_consts *consts = sparx5->data->consts;
    consts->some_var

or pass in the sparx5 pointer to the macro too, which was the concert that
Jacob raised.

Thanks.

/Daniel

