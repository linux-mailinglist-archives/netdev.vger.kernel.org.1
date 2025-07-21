Return-Path: <netdev+bounces-208711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF91EB0CD82
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55DE5464C5
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 23:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A6622CBE9;
	Mon, 21 Jul 2025 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U23L1I6s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13289221F09
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139099; cv=none; b=E7NgfsTfWiu1P7imhSSOjYWStrauTSUX8r9sVpYe8MC4hO0PumULJyxOaTGAOirtPFTIKoenV7WwlcKwOA1+p/SHophUlQTany5EaQYL3+XDlr/nDKyO/NyMN326mMFbJw12jDI0hZcVD75CVggXDJVf2ew56KIWSEOyamAULAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139099; c=relaxed/simple;
	bh=Lh7KL3p4HW5GpQMuX3H+u1SzC2+vFjphx+qAYUwPGEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrpV7kGDL2fD1cGsd5yiZNdTK28UmaJMBvY+SF+zxVRVn31LdqTAszPnGWmgeCrCtm24r3EJSOO+5VCXldgqRgICyBfB36s2VHtWR//hacSVSWIxIUt/916XJscT4QSCcKlRzii3oXzYb8Y/jAnf4vKk6H70Wk83yMX8F1QmpgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U23L1I6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2453BC4CEED;
	Mon, 21 Jul 2025 23:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753139098;
	bh=Lh7KL3p4HW5GpQMuX3H+u1SzC2+vFjphx+qAYUwPGEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U23L1I6sQjUb5p0bp1rAWk2ACWxCHsAqeQCOhnvqKMQnQutd4S73bDzdoNMj5mXd2
	 zDDixZBUdX5LfVsc4p80e9z6yzw/5JzjQnp5msRVV0ivLTDNO9bBMFJa2jHaLO888X
	 gYbRKNj4vowKmPx3j9bbNK5vmNBwh5hnq7D539Pptp/nY/AAaQ6QnTc92lEeo2fy7V
	 2LYq+F6dSz/b4ZhE+SzLqqDHPJ5iBz/5gx0oWW9XctIZSbOhE68wbUgcJU1YzcpWAO
	 wHjBr85eZD1haM8KH0HH7JjX9bpAqiNYePRG3hgOKM0Zgg0faZwvsvD0ADOW51ywus
	 yNHrdu7kbm0Fg==
Date: Mon, 21 Jul 2025 16:04:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next v2] netdevsim: add couple of fw_update_flash_*
 debugfs knobs
Message-ID: <20250721160457.407df671@kernel.org>
In-Reply-To: <20250720212734.25605-1-jiri@resnulli.us>
References: <20250720212734.25605-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Jul 2025 23:27:34 +0200 Jiri Pirko wrote:
> Netdevsim emulates firmware update and it takes 5 seconds to complete.
> For some usecases, this is too long and unnecessary. Allow user to
> configure the time by exposing debugfs knobs to set flash size, chunk
> size and chunk time.

FWIW I also find the long delays annoying when running the test
manually. But do we need knobs for all the constants? Maybe cut
down the size to something more reasonable and expose just one
knob to control the length of the msleep()?
-- 
pw-bot: cr

