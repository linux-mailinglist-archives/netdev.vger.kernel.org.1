Return-Path: <netdev+bounces-89832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B968ABCE0
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 21:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8632F1C20959
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 19:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540BC3D0BE;
	Sat, 20 Apr 2024 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tx44odxf"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F2205E00
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713641082; cv=none; b=X6x0OJMbNfpeViNrC9L7OxqrQNnuAT/dyhL/itNY2nGSOQnA5pxmAhdT829msW+mVSsodIyvxbLS0Ilp7qt8ihpSDH3E+CgsQnlu+wB2XxcxWUktTWj8crmR6BfLG3Q6LJVa1PB6Dtjki7A+BsW1d6RYazIEA+YFfVyg0GS3F2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713641082; c=relaxed/simple;
	bh=mmEM6g90ZQwifgnvIJtuJGdjdOEiFIjvno6Bpfl/Ids=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbCGZlUZRMbd8YEd+WW2vHFJh2D3aIQcynAClyktC3vCa0dz5THaWXyaXyjc9p3/L8q0js7bYTZ5B2+vCt0oTVYAAqaNos+7IdKXGuFTK62vj9oqAc8zmQt+ftLjfA9w/kz9uxJMIs+kRVtZ1MGbqhGQqVV2ximGdpPH4Gf8Clk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tx44odxf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713641080; x=1745177080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mmEM6g90ZQwifgnvIJtuJGdjdOEiFIjvno6Bpfl/Ids=;
  b=tx44odxfvXkzl2por+fBI2M8Mp4zDGrTPe7STkUBbuYA/6qriU0xHWAp
   8gEyvPXT5tv3/44ThuYWfNoSm1RYezBODt7yzI64otP049EPFgIxKHoRv
   95FuXtbnubajF35X23lKw6kArLMWlWry42ziyfxnBTyV8pqS0cumayvOJ
   tA525FQnWbg+0iW7HXZiRjQlX63faxiyYrb+bs0z39AaBN34siQqc9aX7
   Aw3/ALfMSf1fSQoXuXWJdwR9Z4l2mC/sVHq9C6t/tp79481f6kn7jN/44
   0F9I8XYAnt8YtC2ye2UTj5CwHaO4BvQsrd7+BUSwPqYF5+n+1fX11M9qg
   w==;
X-CSE-ConnectionGUID: HVdoQRMkQz+QrdEhZgSCjw==
X-CSE-MsgGUID: aPypDRXLTUGqWhBAYNZ/JQ==
X-IronPort-AV: E=Sophos;i="6.07,217,1708412400"; 
   d="scan'208";a="21911029"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2024 12:24:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 20 Apr 2024 12:24:27 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Sat, 20 Apr 2024 12:24:25 -0700
Date: Sat, 20 Apr 2024 19:24:24 +0000
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
Subject: Re: [PATCH net-next 4/4] net: sparx5: Correct spelling in comments
Message-ID: <20240420192424.42z2aztt73grdvsj@DEN-DL-M70577>
References: <20240419-lan743x-confirm-v1-0-2a087617a3e5@kernel.org>
 <20240419-lan743x-confirm-v1-4-2a087617a3e5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240419-lan743x-confirm-v1-4-2a087617a3e5@kernel.org>

Hi Simon,

> -/* Convert validation error code into tc extact error message */
> +/* Convert validation error code into tc exact error message */

This seems wrong. I bet it refers to the 'netlink_ext_ack' struct. So
the fix should be 'extack' instead.

>  void vcap_set_tc_exterr(struct flow_cls_offload *fco, struct vcap_rule *vrule)
>  {
>         switch (vrule->exterr) {
> diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> index 56874f2adbba..d6c3e90745a7 100644
> --- a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> +++ b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> @@ -238,7 +238,7 @@ const struct vcap_set *vcap_keyfieldset(struct vcap_control *vctrl,
>  /* Copy to host byte order */
>  void vcap_netbytes_copy(u8 *dst, u8 *src, int count);
> 
> -/* Convert validation error code into tc extact error message */
> +/* Convert validation error code into tc exact error message */

Same here.

>  void vcap_set_tc_exterr(struct flow_cls_offload *fco, struct vcap_rule *vrule);

The other fixes seems correct.

/Daniel

