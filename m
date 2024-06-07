Return-Path: <netdev+bounces-101815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C399002CF
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F361C23C54
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE7D18FC84;
	Fri,  7 Jun 2024 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="apR+ZE8Y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ECD15A4A2;
	Fri,  7 Jun 2024 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717761490; cv=none; b=FR9Bmc/7C+pqcJgQf9eOAUiJ4HsycoiVc8ZH2Kt3rgPHk6z4PLcgd9e5iSomcJzwO4qmcOaTtra7IRWo2DgDQyH/6oZG+miyXtBu1qIKMqxgUNgsnVwB5kREyXUmcwDvcvug42/5n+BOvBDlX5SrONAgUvG+VhUFF3hLla5IhTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717761490; c=relaxed/simple;
	bh=4b2ugFfalk4/kWMxtoFcpD43wGccOMs6ThCReo3lAvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqvObxa1a54Rbs7qYcc0Cn0pIJoyInWj6u+gSYeMj5vUOeqzOzInR1vR6LVeGK2rYrD77AWAxShSG/c4lmHnw68kzVozSkqV4F7s4e7Ie2w/0AF9nfsLgX/GGW6KcazUb4HfnUBFbY2f0IFyVG9VXVihLPeEXKIoernLIJ+fdT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=apR+ZE8Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TR/Oh9dwCvTN/XzGdtqdy+Cjahkykd+vTLsu3IoL/UA=; b=apR+ZE8YqRaZUM+25wDrxTl6Fk
	xwylTeSR/y2FC+tp4CNZ3H8aGA4yE+kBgp64GqbxO76fK2iyntb/R7geULxJ3wwMK2gr+RpVhLhVy
	hS7luvwm7sJ3YX2d1/NljC9tIt+zKaNwDgAGIyV+J6Wn8/4NxWekch/SFWFJBmwsnmnM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sFYEJ-00H7Lt-7V; Fri, 07 Jun 2024 13:57:59 +0200
Date: Fri, 7 Jun 2024 13:57:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: Fix typo in NET_DSA_TAG_RTL4_A Kconfig
Message-ID: <a0630e6e-d979-4856-98c7-93721006da66@lunn.ch>
References: <20240607020843.1380735-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607020843.1380735-1-chris.packham@alliedtelesis.co.nz>

On Fri, Jun 07, 2024 at 02:08:43PM +1200, Chris Packham wrote:
61;7592;1c> Fix a minor typo in the help text for the NET_DSA_TAG_RTL4_A config
> option.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

