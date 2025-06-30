Return-Path: <netdev+bounces-202584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465FFAEE4ED
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F233B8169
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A15F1E5B6D;
	Mon, 30 Jun 2025 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XivGe8eo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FB292B42
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751302040; cv=none; b=S6Z8bdseW4hmHsVRhqiMNshObsy4j4ARDyz16SzbVPye54G7o4FdQvdHH1nVIhxY4OrZndcsRXTwsi+7K0JYUAbPxUVMKPhzmokaUSpYTpd5hM5aHhTLzUFh+B4NNp+e/rf29MwfPpAlAAoEVnjj4B1XAnGS5zICts4/x3aj0lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751302040; c=relaxed/simple;
	bh=OnplvDWqY/fmBz/eDfO1jNE31E/h7mDBy3gWEf0BK+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCC8FMXxm1LwuRxJGIR50K++8C8LMWd1/5AzMcykHSLClZeXD/d2wAOOxb2u8X6uaCq2O4bGYDW8cotaWRno6BciTyw876/EaEyILWd1Nn55YXAZw//qMBL+QNb32qq64kadZLRZCrPTBBdaGlF9Qt87+ft9D1Sh4nt4A2Q7X9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XivGe8eo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dyBSNECdVsrlQzLPqP8reGQdOgZVM1g/L8tQe2ognW8=; b=XivGe8eoIZ16xErDPmjQUXybui
	OxFDm76Da1PIbz8vgU47KeaMr/R/XhRRuGEwv+OSHUIecNr4VRmU08zI+br4ajIGXSl2WuA7oecBw
	xe3zxecgMOuSWVRG/n8gmlvXtAar7MJ9F7DZr4la1/aaEhuqKbCyDthZF5iGbEbAfPK4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uWHes-00HNt3-BY; Mon, 30 Jun 2025 18:47:06 +0200
Date: Mon, 30 Jun 2025 18:47:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH net-next v2] amd-xgbe: add support for giant packet size
Message-ID: <679e9678-8c9a-49ea-87a8-a38650a82e19@lunn.ch>
References: <20250630152901.2644294-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630152901.2644294-1-Raju.Rangoju@amd.com>

On Mon, Jun 30, 2025 at 08:59:01PM +0530, Raju Rangoju wrote:
> AMD XGBE HW supports Giant packets up to 16K bytes. Add necessary
> changes to enable the giant packet support.

How does v2 differ from v1? You should include a change history.

You also need to wait 24 hours between posts.

    Andrew

