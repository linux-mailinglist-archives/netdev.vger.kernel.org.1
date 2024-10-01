Return-Path: <netdev+bounces-131085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E0A98C85D
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD61D1F24BD3
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E0E1C0DC5;
	Tue,  1 Oct 2024 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T7eePNeG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE29E19AD8D;
	Tue,  1 Oct 2024 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727822915; cv=none; b=Q5LWW19lBARbM35PaPY1/Lkk8fqo4XkupL+GF51BsO2pQweHvKD8F+x9kAjP2pw+5MoF4e1htEvBoVC9ddatya/lhkfpzor9RatN0QFsC4f/Zz6Rq6gVK8WDtNl/5nALkEHTwpEPClOYBXY311f/wCzxftI5CBXFrR8hzb54YwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727822915; c=relaxed/simple;
	bh=5WMMLMfT0YLDtkievFpHc2L1F5htDhP4vC7Q1tc5DcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oElzPmWSmdQ0qT5/eIFkZEZbMfVFnVoitHPM6GFGKDHA7VCRjQu9hdozoEULY4wuJ6Uh3l37HtqvEmp7qW9g7AQOLiiK29TlCheF7nhGGXczIwx/3chYyksObmiscXxCiEBmgFUbS2mSquthgz446XqiA08HKak1a9yZFtdbLJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T7eePNeG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5agLEBT+ZNgqFzbiOlLbpNK5s1NJgU2nPVUQyWEHT1g=; b=T7eePNeGWfVCTSLRu40gugNR7e
	6YMmWTaHuKoW9Y1MKWggmOB+Ftv9OpLSU7b6wjESp34bJDz7BQnzlEcjhT0C/JPFIHTiWiKpm6Ti1
	R8Eg3NagYdbKkBLvDgFCgOjal/51eA/Elp1iJAzdV+BUAN4cmnLFyEckTzvtnCJpLV34=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svlfL-008mcr-Q0; Wed, 02 Oct 2024 00:48:23 +0200
Date: Wed, 2 Oct 2024 00:48:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	olek2@wp.pl, shannon.nelson@amd.com
Subject: Re: [PATCHv2 net-next 03/10] net: lantiq_etop: use devm for
 register_netdev
Message-ID: <3776b850-ac0b-4ffc-ac36-2aad2209535c@lunn.ch>
References: <20241001184607.193461-1-rosenp@gmail.com>
 <20241001184607.193461-4-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001184607.193461-4-rosenp@gmail.com>

On Tue, Oct 01, 2024 at 11:46:00AM -0700, Rosen Penev wrote:
> This is the last to be created and so must be the first to be freed.
> Simpler to avoid by using devm.

Actually, devm does not enforce that. All it enforces is that
resources controlled via devm are released in reverse order. Things
not using devm will be release first by explicit code.

The only reason devm is safe is that the core ensures the interface is
closed. So the order probably does not matter.

    Andrew

---
pw-bot: cr

