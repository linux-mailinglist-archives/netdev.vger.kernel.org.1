Return-Path: <netdev+bounces-162545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07624A2733B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3521618827BA
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4EB212D72;
	Tue,  4 Feb 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2zFzisSX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494DB20CCE6;
	Tue,  4 Feb 2025 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675521; cv=none; b=ZBbBIFOkdy5T9s5YKaoyevPfdw0djlk4zw3BQDtrs2jqyI0AFdB8VWiTXU39T31+1xjweAHeuyKOP9pLzgTtBlQ8od7CxHdacj1CBMiDz4Lwu37DK3Tq64UwYiedq5QPvhxcrIG+NmxMrrl6SjCyCtHnb+1YzBEAfz+4zCFlQDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675521; c=relaxed/simple;
	bh=KXErA1Z10wN53fMN9l+gTf0NXOxQj75p+H91zUNyAQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyijoCF691MP54ZkW9mEW2/yZGTMfiA7d/yTiHUdiKhZT7lrPY6o26uK1n2TFpCfR+6ZL8KzavLbc4AnOQzycaaR8iU0UjK9+v9H2uGVlbaLbxYb9O0hmfI5fJsQ3njTJ/bCzqmYid26+o4/RvsiK5jIbrYIry/SaNwMyR4CQEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2zFzisSX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tONImgsZBFCRForerTmlmeGunNv/sZwoa1eaSkXh+mc=; b=2zFzisSXwqfHPQ34Ne/nudwNgE
	JOLehRzweCGO74P23+ZVKqb6XFDggVlCazJOp/Ws0ndQcNzq7Vn0knOFZ2UGS2AZWLXP3+22YNJmv
	qZwv9Ue+8bEzaykYR+oFBznvfhm1bxKH+YwVrqGGNveSUHv+2QYPb7T3uYcxOBVsIALI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tfIvL-00ArLk-CM; Tue, 04 Feb 2025 14:25:07 +0100
Date: Tue, 4 Feb 2025 14:25:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
	netdev@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: Document guidance on inline functions
Message-ID: <de8d372b-0f2e-4c42-9d6b-8aecbb4645ef@lunn.ch>
References: <20250203-inline-funk-v1-1-2f48418e5874@kernel.org>
 <874j1bt6mv.fsf@trenco.lwn.net>
 <20250203205039.15964b2f@foz.lan>
 <20250204115410.GW234677@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204115410.GW234677@kernel.org>

> Thanks, perhaps something like this would help:
> 
>   Using inline in .h files is fine and is encouraged in place of macros
>   [reference section 12].

The other major use of them in headers is for stub functions when an
API implementation has a Kconfig option. The question is, do we really
want to start creating such a list, and have people wanting to add to
it?

	Andrew

