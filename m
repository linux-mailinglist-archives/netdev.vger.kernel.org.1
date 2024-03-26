Return-Path: <netdev+bounces-82146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A129788C6D6
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B801C3989B
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9851313C82B;
	Tue, 26 Mar 2024 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0Y8aRds9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE80BFC0E;
	Tue, 26 Mar 2024 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466843; cv=none; b=D4J6T3tdk/aNCzjjPxTeAf3A4UhoMbWSnMfBY6qbBKopSPTfenPb+vipwvWmZ0CCS23I36PotazN5Ao1jvrb2cAIl2u7EOabW8OT7MKE236Q2yRmSGggQQ4nLMRbG6jFLQQP3wgM0286EMmxzlKmGptuk04gMv/Mc9TnWTNz99o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466843; c=relaxed/simple;
	bh=5ZdD6EBQDhSWELf/1IQNK1gqAf36MIWICbfgY5mKye0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPNDKZ/OxDWyQnmYEe7ADIdxKn0pzdTCxHntaafsknNjpTu7f+6J8s0PmrxYbYVnZbzm8c1hIE4NrzV5rZ8mKCBrTAOzalWtnR7cdBWY+Pe6G3d0t+sY1O5iYNbvmpJMeI0xWPSImaZCsCcJxcBiSEqWjO5rn0Zk1aZMt4D6O/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0Y8aRds9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Lnm0V+V77Hgs5hICixRMn3liIWAung7AV9I1XLBrOP0=; b=0Y
	8aRds9y6PWhr3O6sLboGYsDlUSlEQnxYG53C8D5twelTMkziAG26H3CBYhmPT3SidYgUHW+CTkWXO
	QRPSDgC6JMPQSDIxXWeGi2lLIuyewUseP84juJNvL7tl2EyE1dWBr8SlTNmIBncGPMfgAteQrIogw
	KRNsSzNOpQmZi/o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rp8hs-00BIMG-0h; Tue, 26 Mar 2024 16:27:20 +0100
Date: Tue, 26 Mar 2024 16:27:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org,
	netdev-driver-reviewers@vger.kernel.org
Subject: Re: [TEST] VirtioFS instead of 9p
Message-ID: <e54258e7-429a-4805-b263-e2bf9fc7d4c4@lunn.ch>
References: <20240325064234.12c436c2@kernel.org>
 <34e4f87d-a0c8-4ac3-afd8-a34bbab016ce@kernel.org>
 <20240325184237.0d5a3a7d@kernel.org>
 <60c891b6-03c9-413c-b41a-14949390d106@kernel.org>
 <4c575cc7-22b8-42e0-a973-e06ccb82124b@lunn.ch>
 <20240326072005.1a7fa533@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240326072005.1a7fa533@kernel.org>

> Somewhat related, our current build_rust test doesn't work because
> I used rustup, and it works by adding stuff (paths mostly?) to bashrc.
> Which does not get evaluated when we launch the script from a systemd
> unit :( I couldn't find a "please run this as an interactive shell"
> switch in bash, should we source ~/.bashrc in build_rust.sh for now?

The man page says:

       When bash is started non-interactively, to run a shell script, for  ex‐
       ample,  it  looks for the variable BASH_ENV in the environment, expands
       its value if it appears there, and uses the expanded value as the  name
       of  a  file to read and execute.  Bash behaves as if the following com‐
       mand were executed:
              if [ -n "$BASH_ENV" ]; then . "$BASH_ENV"; fi
       but the value of the PATH variable is not used to search for the  file‐
       name.

So something like:

[Service]
Environment="BASH_ENV=~/.bashrc"

assuming the service is running as the same user as rustup was run as,
and it is invoking bash, not sh, to run the script.

	Andrew

