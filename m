Return-Path: <netdev+bounces-127821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CC2976B64
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657051C211CB
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 14:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B06A19F43E;
	Thu, 12 Sep 2024 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=martyn.welch@collabora.com header.b="QOF7cVFj"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A4B18028;
	Thu, 12 Sep 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149720; cv=pass; b=iIkmhIVQmY99iIWV6I/tCIwE9RxbzarNCqL26D9f34e5alVfDMd1oPp8BjbE6i03NtkY4893DZ2V9pDfZo8k3uqW69vBACFjeOmO0Iple69PAbTnO91Qnkt3nypROwTkNH7Vqw2RK6TwyPlX4kbxn1mrICrRUS7oNdCT0JbDKYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149720; c=relaxed/simple;
	bh=m/b8a6XcpU/9RZFZ6BBZaSmYoQcf1kt9xtYnhWYic38=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KyX/DcX6Vc1zq1+JfhpWXkDAVA31fwlj/dVssSa/qVFNeZbSDKoAPsBFkvEKUYPxMTa9kf3i5vOrlxaFYhSMSinXP2xCgvAjmcbQ8SyUuJkxK+nhNP25bOn0zCpki8+fLb4/Igl6g6D7UA6VijX9u1bPRvjo4k1chfMJHVg6L1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=martyn.welch@collabora.com header.b=QOF7cVFj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726149692; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GPkQAKUreZ98kCkd9OA7fiv30jga2Yh4NQv/NBnAP2XzPd/hlmiKJVF1m/BlgBgrG7TREjywumFLQTzR2aKDS7QFULG0l20tmv09oqZLczJPAUthOr3eN9RwUMQFY9wYuN08uCjNvGMGdiTUAsTUXPhLK3KYsiiGEEqnKgmiBzc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726149692; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JZZjMBg6GaRjNsN8LHncP31eURRBGVQBoOHkla3Xoh4=; 
	b=FORqQ0wSd5t4RSCmdw6xLoHhxSSO6P/je11L0cWeHRKOrZdy6hXG/2feTcTJNG66bE+oYUYxh8KG/Y0Uch6rucxZzMMK5nkp1mAy08JMbakl526FmO9XT+VwaScadT/OoEmctDr7xtGcUgYoOnroUpVYCnqxAbCKwjkKI10iiNs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=martyn.welch@collabora.com;
	dmarc=pass header.from=<martyn.welch@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726149692;
	s=zohomail; d=collabora.com; i=martyn.welch@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=JZZjMBg6GaRjNsN8LHncP31eURRBGVQBoOHkla3Xoh4=;
	b=QOF7cVFjfLhGg0vJ7JiDjBWbmC41C0Uj6K9BVGYVFkUSvt3oZTIGPrL/MLxlQEwm
	vqNtccFGrszSKXGeGLFIvUwmExuYFBE/v7zmINEAyoDguPhl2O0IV1ixdOmAyeiQgF9
	9L7G5SRT1GDhIta6xroXVQvQ9+IlNYpGOd2KO1+g=
Received: by mx.zohomail.com with SMTPS id 1726149688923383.6595471383481;
	Thu, 12 Sep 2024 07:01:28 -0700 (PDT)
Message-ID: <0aa17b0eaf91334e9d3f989f04f264efae5f0b40.camel@collabora.com>
Subject: Re: [PATCH net-next v3] net: enetc: Replace ifdef with IS_ENABLED
From: Martyn Welch <martyn.welch@collabora.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean	
 <vladimir.oltean@nxp.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 kernel@collabora.com, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Sep 2024 15:01:25 +0100
In-Reply-To: <20240906182035.57c478bf@kernel.org>
References: <20240904105143.2444106-1-martyn.welch@collabora.com>
	 <20240906182035.57c478bf@kernel.org>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Fri, 2024-09-06 at 18:20 -0700, Jakub Kicinski wrote:
> On Wed,=C2=A0 4 Sep 2024 11:51:41 +0100 Martyn Welch wrote:
> > -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> > -static void enetc_get_rx_tstamp(struct net_device *ndev,
> > -				union enetc_rx_bd *rxbd,
> > -				struct sk_buff *skb)
> > +static void __maybe_unused enetc_get_rx_tstamp(struct net_device
> > *ndev,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union enetc_rx_bd
> > *rxbd,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff
> > *skb)
>=20
> Are you sure you need the __maybe_used's ?
> Nice thing about the IS_ENABLED() is that the code is still visible
> to
> the compiler, even if dead code elimination removes it the compiler
> shouldn't really warn about unused code.

Hi Jakub,

I thought that was required, but upon re-reading the Linux kernel
coding style documentation on the subject, I see that I miss-
understood. I will check and see.

Martyn

