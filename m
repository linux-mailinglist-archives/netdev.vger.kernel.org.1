Return-Path: <netdev+bounces-171694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B404A4E2E5
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C569017F371
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E350C279343;
	Tue,  4 Mar 2025 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3hivcp3h"
X-Original-To: netdev@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631F6264FBD
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100878; cv=pass; b=kDCAJzo7OccoExuiCkefjB5Fu5s5pqpG9GLfLar4TWRptRGRYkuwJl8HzWZxCnpi9vdIGprL84B9d2MGx2Gu6aE0UVQRpS113eNHtLHjZQq1/h4qmN/+R2Dc+G2UVe+n29xagARbEQZACy177+65wOBrSAnsgTxzoMYAyL+fKNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100878; c=relaxed/simple;
	bh=CyfaPmwEF0Z7BMP96K76YmpgvffsaHwClknfwoPWEEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOrUrx5bTC0irGnnqTZYc3JlJjcuTAH8Jy/ob7CP2ZHy+D463gmE2nSMSb5Ngh5OGpPbUqLItmbGHv2bzEnfoGO8xCilIPEusvDne7lc4l76VbZOELyjbtTJlzAAfBfwAuk84KKi9DPVj7c7sDFZUmjrkSYEwU3jUyKOsoMg5e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3hivcp3h; arc=none smtp.client-ip=156.67.10.101; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 89F7440D285C
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 18:07:55 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=3hivcp3h
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fCF6cqlzFyVg
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 18:06:17 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id B8A7342737; Tue,  4 Mar 2025 18:06:10 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3hivcp3h
X-Envelope-From: <linux-kernel+bounces-541849-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3hivcp3h
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 516E041BCF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:49:30 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 2AA172DCE4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:49:30 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5384B1893554
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B8B21323E;
	Mon,  3 Mar 2025 13:49:06 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0912210F6A;
	Mon,  3 Mar 2025 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009743; cv=none; b=dn4zeYWOABY6+14LI3LTmvX5EdrNcxrivJqysiKe5RTWaoNKZqD7gW2Z2Y8Vp6JcEKR6kAYqrBKlhgGl3LIIMGgv6GI+RtJfSN2YUaq5mCpDISy75vf90RFV2ZmQd2j5yYywpVOg5z5BXs+d7KtWiIAxYWw1pWqbdxQLHIkv1ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009743; c=relaxed/simple;
	bh=CyfaPmwEF0Z7BMP96K76YmpgvffsaHwClknfwoPWEEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBdoJGWRKTsRaOIF6QOIVqQzB1bhFPJB6WQZxFwaYuitgp7TnWjZLek61nzEUiCaWi0B410O+cBeZ02iDlVs8T8judMhnQuKm2gkYbcEmMfmda6NAvJ/79mNMVUIBzv5O+cou+pHMbrQRK01KKsvQa8vT73BKEO/BXfwgu3izIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3hivcp3h; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fQIWx2nmMG91M2bKYSGCCMU7fUeJQJZ2n9bIALNGd4I=; b=3hivcp3hyikl1qgpt2K1DfODDd
	HqQjl6fQN9JIlWmtUUsTt8EBoZkGu/Ckdz39k91YUBofEcKYafu/WEtVyeSvj2kA9YpjKKMZmlPY/
	Hqaqwpg9seKtd1Qjxv8JShHhcQhnvlEdpCt1pb7a42/KCURdRkAC2x4dNWFhRmwIW82g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tp6A2-001oqB-J6; Mon, 03 Mar 2025 14:48:46 +0100
Date: Mon, 3 Mar 2025 14:48:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: joaomboni <joaoboni017@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000: =?iso-8859-1?Q?Adiciona?=
 =?iso-8859-1?Q?do_const_para_melhorar_a_seguran=E7a_do_c=F3digo?=
Message-ID: <de6bcb17-964e-475d-b535-ce153760d9dc@lunn.ch>
References: <20250303131155.74189-1-joaoboni017@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303131155.74189-1-joaoboni017@gmail.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fCF6cqlzFyVg
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741705586.76981@SrerqaGwvSkSey/VytXr1w
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 10:11:55AM -0300, joaomboni wrote:
> Signed-off-by: joaomboni <joaoboni017@gmail.com>

Sorry, but the Subject: line needs to be in English.

And the name in Signed-off-by: needs to be a real name.

The code change itself looks sensible.

    Andrew

---
pw-bot: cr


