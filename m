Return-Path: <netdev+bounces-171249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD3A4C25A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 14:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4295E171186
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8228211A05;
	Mon,  3 Mar 2025 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3hivcp3h"
X-Original-To: netdev@vger.kernel.org
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
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303131155.74189-1-joaoboni017@gmail.com>

On Mon, Mar 03, 2025 at 10:11:55AM -0300, joaomboni wrote:
> Signed-off-by: joaomboni <joaoboni017@gmail.com>

Sorry, but the Subject: line needs to be in English.

And the name in Signed-off-by: needs to be a real name.

The code change itself looks sensible.

    Andrew

---
pw-bot: cr

