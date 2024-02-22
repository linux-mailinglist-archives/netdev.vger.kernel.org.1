Return-Path: <netdev+bounces-74183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F5986062E
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26EBC1F21E82
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEFB17BDC;
	Thu, 22 Feb 2024 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7zPGvmI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B64D17BC1
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643239; cv=none; b=gUKYG/zGSLbqaH9kvUn8NvWUAG9fF4MvdlMlXz0agFm6nqvL4f29BsskOEoErER9/3kE1wPMTZvEhq1HcDb0KJhcDVG8VGYSxFAMPfTZJs9RFKKg1tsltkc/kr/QPMT9qUVU02qKFnKsUJJnq7jLfWq6QUZTWxC7t/KsWRJHsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643239; c=relaxed/simple;
	bh=tLpCJuni9rb3m7ZM7NstXMA+xk57bKi7V6ML0f7H35A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9htsEkeVY2PY420ZywrD3FUsoxZtBKFbzcRvXvQvEagP9+K/Hd2VIXQffRPkpx/jwWxFaRbR4m5Pak0r7aAXaFsSuLk22FvdN8XRnW2AuXZ1H2gLmJ99k5kHJzBOPYfwEhuOWH1bp7+ENrowLnG6nvtNUob0wOLPNghcfVtfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7zPGvmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C60DC433F1;
	Thu, 22 Feb 2024 23:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708643238;
	bh=tLpCJuni9rb3m7ZM7NstXMA+xk57bKi7V6ML0f7H35A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C7zPGvmIoOM00Pa+BaUg6Gb8zXykl8lKxj3yDTdfqz0XhLG75S7bvoUyR9JWzuX2o
	 vZ04BUm9QphfO1ZI08Oh/CnYT3iGgvoLGoZBiT6CeZvVTX5f9he/Xn7hwNe46LhdIX
	 Gw9ciuOYUPWC/mnydsxniAbEa9CGsut5rSWdyRitPTYzaJRoyZiIhjmZKm4Wy6EYgk
	 +KaSghyQukozxRHekA4UZjn2xIv/ZBDVv2nvfzfCENswabQB6jeTELq1pelo5tna4j
	 7bSUmfiHhvNe3HFiFMOwEq801XLiU6mnKJHdTFS2MCqaGe1M37LR8NdSZlaDwZXQk1
	 jK9qRr4aTppfA==
Date: Thu, 22 Feb 2024 15:07:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <horms@kernel.org>, <przemyslaw.kitszel@intel.com>, Lukasz Czapnik
 <lukasz.czapnik@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Add
 tx_scheduling_layers devlink param
Message-ID: <20240222150717.627209a9@kernel.org>
In-Reply-To: <df7b6859-ff8f-4489-97b2-6fd0b95fff58@intel.com>
References: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
	<20240219100555.7220-5-mateusz.polchlopek@intel.com>
	<ZdNLkJm2qr1kZCis@nanopsycho>
	<20240221153805.20fbaf47@kernel.org>
	<df7b6859-ff8f-4489-97b2-6fd0b95fff58@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 14:25:21 +0100 Mateusz Polchlopek wrote:
> >> This is kind of proprietary param similar to number of which were shot
> >> down for mlx5 in past. Jakub?  
> > 
> > I remain somewhat confused about what this does.
> > Specifically IIUC the problem is that the radix of each node is
> > limited, so we need to start creating multi-layer hierarchies
> > if we want a higher radix. Or in the "5-layer mode" the radix
> > is automatically higher?  
> 
> Basically, switching from 9 to 5 layers topology allows us to have 512 
> leaves instead of 8 leaves which improves performance. I will add this 
> information to the commit message and Documentation too, when we get an 
> ACK for devlink parameter.

Sounds fine. Please update the doc to focus on the radix, rather than
the layers. Layers are not so important to the user. And maybe give an
example of things which won't be possible with 5-layer config.

Jiri, I'm not aware of any other devices with this sort of trade off.
We shouldn't add the param if either:
 - this can be changed dynamically as user instantiates rate limiters;
 - we know other devices have similar needs.
If neither of those is true, param seems fine to me..

