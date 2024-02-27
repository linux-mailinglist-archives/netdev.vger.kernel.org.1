Return-Path: <netdev+bounces-75382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5F8869AA8
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F7D2B26E91
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79950145333;
	Tue, 27 Feb 2024 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Me5KlcWO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD8F14532C
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048509; cv=none; b=kOzz5ZeK7gUOODhaLnwrq6r6u1Odk/raLafYWWYDKCyvKQTNOa8LjbDY5344LmqmFsgi8bLfomKVDG/g/odi7bcMb2g5UaaLs1NUZSc/i4UZ1l/Nor+n59F5uNbhnm2WdGpXC6xmHaOIr54mr1Uyg9e8Aiyd0FjCLTo0DKcWo9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048509; c=relaxed/simple;
	bh=MzX+weepP7Sa00vtw3r/qUWzsr70CocH8oY3tiP+mUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+eIFXTtbszCnX0WkKLc9FGbHyJiTR4LDMOxCa/Ka+sGZWxQo1R23tGaWdjFMUORxJahY7+EAy1671AFzSL+0qhHYd9A+UE918OuGnUkqPfXwpMIG19tMU1t8ViqOOs7f69z37jXA0ZivwzfuaedjTiZAapM9+UiAfGqz9lhcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Me5KlcWO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uobtD88hd0NZ2CVpt7xCjfBCKKorIXY8l5PL+n1iJbE=; b=Me5KlcWOmqCpKkPi7P3TzWT5cj
	DJRtI+mFk6p4AWnY4iR+HHGXvc2lWl+EjmtPVw8lnK7uv2mfF4oHBhGDAa/eCRioHazZCFkDAwn8m
	PQ/cobzcSp86U44TxrGcytKw/KsNq5ltTMVhMTv/x9KFWdp/wGm9VcVH/opuNMbhhIus=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rezaa-008rhC-Qe; Tue, 27 Feb 2024 16:41:52 +0100
Date: Tue, 27 Feb 2024 16:41:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	horms@kernel.org, Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Add
 tx_scheduling_layers devlink param
Message-ID: <327ae9b5-6e7d-4f8b-90b3-ee6f8d164c0d@lunn.ch>
References: <ZdNLkJm2qr1kZCis@nanopsycho>
 <20240221153805.20fbaf47@kernel.org>
 <df7b6859-ff8f-4489-97b2-6fd0b95fff58@intel.com>
 <20240222150717.627209a9@kernel.org>
 <ZdhpHSWIbcTE-LQh@nanopsycho>
 <20240223062757.788e686d@kernel.org>
 <ZdrpqCF3GWrMpt-t@nanopsycho>
 <20240226183700.226f887d@kernel.org>
 <Zd3S6EXCiiwOCTs8@nanopsycho>
 <10fbc4c8-7901-470b-8d72-678f000b260b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10fbc4c8-7901-470b-8d72-678f000b260b@intel.com>

> What if it would not be unique, should they then proceed to add generic
> (other word would be "common") param, and make the other driver/s use
> it? Without deprecating the old method ofc.

If it is useful, somebody else will copy it and it will become
common. If nobody copies it, its probably not useful :-)

A lot of what we do in networking comes from standard. Its the
standards which gives us interoperability. Also, there is the saying,
form follows function. There are only so many ways you can implement
the same thing.

Is anybody truly building unique hardware, whos form somehow does not
follow function and is yet still standards compliant? More likely,
they are just the first, and others will copy or re-invent it sooner
or later.

So for me, unique is a pretty high bar to reach.

	Andrew
	

