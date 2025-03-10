Return-Path: <netdev+bounces-173503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B706DA593B9
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E3D18919F6
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F5322D789;
	Mon, 10 Mar 2025 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PMerF2i+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B356522D4E6;
	Mon, 10 Mar 2025 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608410; cv=none; b=IfI53JOlgrYmEwyotXsaaosEkLeqDoZ9dq4EQn8zQxdEBoYmRKdFy6PblPsXuH8ns4OJmYjdhxO6ILgdEjnb+1HaYXLG+Qql/vMU0gQ31aO7/hNU5E6Gvoe5fNtI5xrDr3bIuirWpdf0EwdVTi5VPBWQs6xMO1JBH7h367YoMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608410; c=relaxed/simple;
	bh=oTcn8IMMp7J1wt266fCA1Jle5k8bB37spAnXUecjtG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCkNURjUb9o8T8kId1/1NgMdy/ToS38PvkOVZ/R36Cjcdn3ymx6V0nXblyN3D6EB6Rk0j0K+2szZpYy6hP65LhHjqlFSSchnGdc9dPCeieK+L37xTq81dQRTdIWlpMJgiIaQDKVn1cBE+RuQ1khgtEfJM1UZ7z6knTzEXzWLeag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PMerF2i+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=a9Hd9pLgYLGyaK3mL9Xf/nhr5CbuLlp8ERW+lfTDT6s=; b=PM
	erF2i+giPdoPrSpDdLb8GXvSJp1A3FSGfAszlQbglscUlhQinUoCzf9bnny1gNEFEH4s+xqufBpBP
	9NNeYJbG5x/yp5jN1sA9VOFV06mmaJxhKF9rtzeWsG7elV4T5MVP8e3uUJFjSLK4tc4fMHny7jx2b
	HXNw+t0/t+LgE6o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1trbty-00400s-78; Mon, 10 Mar 2025 13:06:34 +0100
Date: Mon, 10 Mar 2025 13:06:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: hanyuan-z <hanyuan-z@qq.com>
Cc: davem <davem@davemloft.net>, kuba <kuba@kernel.org>,
	andrew+netdev <andrew+netdev@lunn.ch>,
	edumazet <edumazet@google.com>, pabeni <pabeni@redhat.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] net: enc28j60: support getting irq number from
 gpiophandle in the device tree
Message-ID: <41ba1d79-b7d7-4c58-b151-d4304a1c8ca7@lunn.ch>
References: <tencent_0A154BBE38E000228C01BE742CB73681FE09@qq.com>
 <2b09bea7-2a61-4697-a9c1-6a42cf8570c4@lunn.ch>
 <tencent_BE0060E3A7AF384BAF4DA37FD2121B8E1D07@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <tencent_BE0060E3A7AF384BAF4DA37FD2121B8E1D07@qq.com>

On Mon, Mar 10, 2025 at 10:20:01AM +0800, hanyuan-z wrote:
> Hi&nbsp;Andrew,&nbsp;<br/><br/>&gt;&nbsp;My&nbsp;understanding&nbsp;is&nb=
sp;that&nbsp;you&nbsp;should&nbsp;not&nbsp;need&nbsp;most&nbsp;of&nbsp;this=
=2E&nbsp;The&nbsp;IRQ<br/>&gt;&nbsp;core&nbsp;will&nbsp;handle&nbsp;convert=
ing&nbsp;a&nbsp;GPIO&nbsp;to&nbsp;an&nbsp;interrupt,&nbsp;if&nbsp;you&nbsp;=
just&nbsp;list<br/>&gt;&nbsp;is&nbsp;as&nbsp;an&nbsp;interrupt&nbsp;source&=
nbsp;in&nbsp;the&nbsp;normal&nbsp;way.<br/><br/>&gt;&nbsp;You&nbsp;say:<br/=
>&gt;<br/>&gt;&nbsp;&gt;&nbsp;Additionally,&nbsp;it&nbsp;is&nbsp;necessary&=
nbsp;for&nbsp;platforms&nbsp;that&nbsp;do&nbsp;not&nbsp;support&nbsp;pin<br=
/>&gt;&nbsp;&gt;&nbsp;configuration&nbsp;and&nbsp;properties&nbsp;via&nbsp;=
the&nbsp;device&nbsp;tree.<br/>&gt;<br/>&gt;&nbsp;Are&nbsp;you&nbsp;talking=
&nbsp;about&nbsp;ACPI?<br/><br/>Thanks&nbsp;for&nbsp;your&nbsp;review.&nbsp=
;Let&nbsp;me&nbsp;explain&nbsp;them.<br/><br/>I&nbsp;understand&nbsp;that&n=
bsp;specifying&nbsp;the&nbsp;interrupt&nbsp;as:<br/><br/>&nbsp;&nbsp;&nbsp;=
&nbsp;interrupts&nbsp;=3D&nbsp;&lt;&amp;gpio2&nbsp;23&nbsp;IRQ_TYPE_LEVEL_L=
OW&gt;;<br/><br/>would&nbsp;also&nbsp;work,&nbsp;and&nbsp;the&nbsp;IRQ&nbsp=
;subsystem&nbsp;will&nbsp;properly&nbsp;handle&nbsp;the<br/>conversion&nbsp=
;during&nbsp;the&nbsp;SPI&nbsp;probe.&nbsp;However,&nbsp;my&nbsp;problem&nb=
sp;is&nbsp;that&nbsp;the<br/>GPIO&nbsp;pin&nbsp;itself&nbsp;needs&nbsp;to&n=
bsp;be&nbsp;explicitly&nbsp;requested&nbsp;and&nbsp;configured&nbsp;a<br/>a=
n&nbsp;input&nbsp;before&nbsp;it&nbsp;can&nbsp;be&nbsp;used&nbsp;as&nbsp;an=
&nbsp;IRQ&nbsp;pin.<br/><br/>My&nbsp;embedded&nbsp;platform&nbsp;has&nbsp;l=
imited&nbsp;support,&nbsp;it&nbsp;only&nbsp;provides&nbsp;a<br/>hard-coded&=
nbsp;pin&nbsp;control&nbsp;driver&nbsp;and&nbsp;does&nbsp;not&nbsp;support&=
nbsp;configuring<br/>pinctrl&nbsp;properties&nbsp;in&nbsp;the&nbsp;device&n=
bsp;tree.&nbsp;So,&nbsp;there&nbsp;is&nbsp;no&nbsp;generic<br/>way&nbsp;to&=
nbsp;request&nbsp;the&nbsp;pin&nbsp;and&nbsp;set&nbsp;its&nbsp;direction&nb=
sp;via&nbsp;device&nbsp;tree&nbsp;bindings.<br/><br/>I&nbsp;noticed&nbsp;th=
at&nbsp;some&nbsp;existing&nbsp;NIC&nbsp;drivers&nbsp;solve&nbsp;this&nbsp;=
issue&nbsp;by&nbsp;specifying<br/>`irq-gpios`&nbsp;in&nbsp;the&nbsp;device&=
nbsp;tree,&nbsp;which&nbsp;ensures&nbsp;that&nbsp;the&nbsp;GPIO&nbsp;is&nbs=
p;properly<br/>initialized&nbsp;before&nbsp;being&nbsp;converted&nbsp;to&nb=
sp;an&nbsp;IRQ.<br/><br/>That&nbsp;was&nbsp;my&nbsp;motivation&nbsp;for&nbs=
p;these&nbsp;patches.<br/><br/>And&nbsp;my&nbsp;changes&nbsp;are&nbsp;not&n=
bsp;related&nbsp;to&nbsp;ACPI&nbsp;in&nbsp;any&nbsp;way=E2=80=94they&nbsp;a=
re&nbsp;mainly<br/>focused&nbsp;on&nbsp;device&nbsp;tree&nbsp;handling.<br/=
><br/>Thanks,&nbsp;&nbsp;<br/>Hanyuan&nbsp;Zhao&nbsp;&nbsp;<br/>

Please use plain text for emails.

	Andrew

