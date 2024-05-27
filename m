Return-Path: <netdev+bounces-98319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469D78D0BBC
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 21:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D6F285AC7
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 19:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1764A15DBD8;
	Mon, 27 May 2024 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W3Cwol+b"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFAF17E90E;
	Mon, 27 May 2024 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837148; cv=none; b=iEu/tvpguc8cAmbslI84ggXAzac27ZmAYAvDEzldwAFmjF6+qCEsM2AjSx53KiPKofCLfjy+xQUL+lPphEA1nqR7YS+HtOOveqV937Vdgw5N7YmJP27tjZVp3sXRZvtu2pEEMKBoLzKbogEVdw3ukB5WC0+gujxr1kU/bkq2ySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837148; c=relaxed/simple;
	bh=Vd1zlIzbVFbmIx1H/g6FC2ipCPgGj2vI2PgEIH8Xrgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxR5/k3/VOfJN0Hnw4mACtTR7NrxMVZawKs2hgphE1Tddq4Sk9IFZli5zsD7OwGNotlWOdSsxXArg5FPsI8fI4IgZa7w8n3HjSkSBkAb/+B3W4oiC9V4HybGABxF4R4qSVPaBuz402CcI4N6EjQulJvossu1frTkfWNTP5vVsKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W3Cwol+b; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oNic0jpMmfm4Lwcl/ErNXdEh+QlRK1GzAwqQp26j0N4=; b=W3Cwol+bgSKMlrsaz1YqOeqL19
	ayZc0ZoPuv2QrEOwl0M551obNcuCoueUfblZi3zN2X/6zH0gjv+1668KSHiiaLfq9vg3UWPxWN3Lz
	22sLyuqJ73mUezWznG9vNObdubA2XTxUvKcrCzkDKgc/I821hzeZytblmfjfjgcrt+Vs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sBflU-00G6Fw-Po; Mon, 27 May 2024 21:12:12 +0200
Date: Mon, 27 May 2024 21:12:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: Fix typo in Signed-off-by tag
Message-ID: <d0af9c38-d15d-4706-943a-b0b68d1eacea@lunn.ch>
References: <20240527103618.265801-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527103618.265801-2-thorsten.blum@toblux.com>

On Mon, May 27, 2024 at 12:36:19PM +0200, Thorsten Blum wrote:
> s/of/off/
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Good catch.

Please could you add a Fixes: tag. And a Cc: stable tag. The file you
are patching discusses all this :-)

Thanks

    Andrew

---
pw-bot: cr

