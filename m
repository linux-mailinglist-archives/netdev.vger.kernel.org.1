Return-Path: <netdev+bounces-153050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C0E9F6AA8
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E081895B04
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A071F37C6;
	Wed, 18 Dec 2024 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0yG3vEya"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD41F76D3
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734537615; cv=none; b=Tt+K7VPRMYaq0x+9nydwBKBxukODAS55kIBkpWxFuZrl7VG2EKSqKhCKNI4cpuHqSJbG+aUGOOKlolNQltQZju35DzheGU1Dein+jaLIaN8k97QFwmf6GXO6NXbkRF1P0VydTpI/gW6wi8l0oeeE0GYdjO6eoU1EmBbxhyp0E3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734537615; c=relaxed/simple;
	bh=MCcrqcpBTFC0rcjHmIGwDn5PmC5mTZheP9JMLgjzzF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C++F5nvPZE4IO5/2J+EGbOKh7w//KNYrSGedxO6EQ64fFcXwb4dgejcRawVzU1xARDVlwCwVRUZZlohusPVYT8P840ZMGPXPZeJo1d7x2BpBxYpSF+lj2fHS+vBP9YDWyeuvwit8eceGEVr8o8SJnNzhn+ZtAvnvbQDAdgTmykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0yG3vEya; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oCZNtCYXJDUf1aTHl92qpuXPC6+vyRtLpviDsxaIKME=; b=0yG3vEya8ToXYeIe3ysQu3cqMw
	Pze/oBq0DTK7yXPWTwtP6nyKLWLnjeMTRY1iGRPxPozB1yVtmpMYo1wI2RqqKq5X5WdQImmPH53gh
	JZQrKSDJo3qxzFnYe9MqsGK3uB0dQ9N4vjvfjzDwJv56tKqow84CpXfbCqiMX19kOOpE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNwT3-001KAq-EG; Wed, 18 Dec 2024 17:00:09 +0100
Date: Wed, 18 Dec 2024 17:00:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: tianx <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, weihg@yunsilicon.com
Subject: Re: [PATCH 08/16] net-next/yunsilicon: Add ethernet interface
Message-ID: <9d2eaec9-4dd6-4faf-ad29-e8f3b7e275c6@lunn.ch>
References: <20241209071101.3392590-9-tianx@yunsilicon.com>
 <f4292a69-6956-4028-b5a2-c1b54893718f@lunn.ch>
 <7cb1bf46-2a6f-4fde-a6da-3d01bec4293b@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cb1bf46-2a6f-4fde-a6da-3d01bec4293b@yunsilicon.com>

On Wed, Dec 18, 2024 at 11:35:39PM +0800, tianx wrote:
> We need to do some cleanup work when the machine shutdown.

That is very unusual. When you do add that code, please add a good
comment why it is needed. Anything unusual should be commented,
because you are going to get questions about it.

	Andrew

