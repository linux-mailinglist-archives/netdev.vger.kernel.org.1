Return-Path: <netdev+bounces-177557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C7EA708A3
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 19:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F43B16620D
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B171F3D3E;
	Tue, 25 Mar 2025 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MqLBUqIj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0190D21171B
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925614; cv=none; b=NGc+76BwH4JQ3dRJELFJhnCPqxStwrpeKqpBYAYpIaGJPPvLs37dqQUzE2I1BF/sFf0MzpmFB1Lwk4a/94qgK2Fi9wwcFaIOUanVCyxfVU5cUcrFF4jgxnf6l9MdFZH+7pk+qohPlCVqfQb7F378AORi/UN+qX8zrS3asbevjhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925614; c=relaxed/simple;
	bh=ZT2LoyxWkCsv8LF9Ix5OM+ff5Fws1xxHkJm8YDZnkuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TohuUnvEqsQOiUJO6JOjn5FP+py3TqQ7tEh+ixdImIRtjfSrTfjn9lVDH/GUV631x+B0BT/IAiioUrCkVxFYhm7c5+R4kegzhimi76O/rF6TK4pTQ/WztMGGsMc5IxK83bLK0TII6rRTA9WCAAs72XmucKdC3aUzxB9PjZhLhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MqLBUqIj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=iYQTlOtqXEeN6mxdsXG7mCbn8weBuqNp3UtKSbRRq0U=; b=Mq
	LBUqIjTzQOJs+dIoo9jQu7GL9AnV8U8ddTmrgUYXwWdH6FVcAv9hZWWViuMWqAepapv/duy4fRh+k
	vYCQRWrNozCEnaer0JVEzRO7w1uNrSsboaQfN/i592HAZabI3YOA3mPzjCNLgi1EJaRSAt3JWy4sy
	4dCLWLltNZNQLOY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tx8ZO-0075VO-6p; Tue, 25 Mar 2025 19:00:10 +0100
Date: Tue, 25 Mar 2025 19:00:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Eliyah Havemann <eliyah@insidepacket.com>, netdev@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: ethtool read EEPROM
Message-ID: <7e3eb464-054d-404e-91aa-eb50d5640099@lunn.ch>
References: <505D824D-406F-453D-AE69-7B8499A8FF0C@insidepacket.com>
 <b5dflgmqztzjmt42rw3x5ccrdth7qkc2kicr6jtofkkrmyo2cy@utly225o6zn3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5dflgmqztzjmt42rw3x5ccrdth7qkc2kicr6jtofkkrmyo2cy@utly225o6zn3>

On Tue, Mar 25, 2025 at 06:03:42PM +0100, Michal Kubecek wrote:
> On Tue, Mar 25, 2025 at 05:16:52PM +0200, Eliyah Havemann wrote:
> > Hi Michael,
> > 
> > You seem to be the current maintainer and top contributor to the
> > ethtool project. First of all: Thank you for your contribution to OSS!
> > 
> > I ran into an issue with a whitebox switch with 100G and 400G QSFP
> > slots, that I was hoping ethtool could solve and I want to ask you for
> > assistance. It’s pretty simple: I need to read EEPROM binary data from
> > these QSFP transceivers, but they are not associated with any linux
> > interface. This is because vpp is controlling them directly. The
> > ethtool has a function to output the EEPROM of an interface, but I
> > can’t feed it the file back to it to read it. The file it outputs has
> > the exact same format of the file the whitebox switch provides. I
> > created a small python script to read the file and it gives reasonable
> > output, but I don’t have a way to test this against a big collection
> > of SFPs and I know that this work was already done in ethtool.
> > 
> > My questions:
> > 1. Do you know of a tool that can read these files that ethtool
> > outputs? Maybe it exists, and I just didn’t find it…

Russell King has a collection of SFP dumps from various devices. You
could ask him for his collection. He might also have an extended
version of ethtool which can read from a file.

	Andrew

