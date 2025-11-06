Return-Path: <netdev+bounces-236521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD3DC3D965
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 23:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 243344E602D
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 22:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9015332B9BA;
	Thu,  6 Nov 2025 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hpbpc26P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26B328B55
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467889; cv=none; b=kMdJIt3IgZBjLKm0OK23I630RcE1IjPs4U0NI/EUIByPLeBvDIue/3LiUBJNL1N/vKdydY6EgbZovmOV8Hcif+eojZuBRKvqTZENQUJpjSkerC8bGZ0fNa0jdAYou7Q3+DN3FzYL25fU2fW2xTxJBW4/m15x9dDJGFyGPZWrlFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467889; c=relaxed/simple;
	bh=xPYIT0+k0Xzcx0BF+rvzeK1loHfZYHharXNs0HguncY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIUER2pAuNQWDXjbZNo5iAcHK+9Bk177jlwrg9uVkJru85omGtQZSs5m1ir5k1plQy5W7fT1GEGE0rERKEIe+6jCJ6jxRr8iB8oNRCTL6eFwDiXNmOVCL+OdxYJPPX6IkfsLSRYbQdBsbkVD4NMx/cJuDDitC4u0sCHc/9cK07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hpbpc26P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7122DC116C6;
	Thu,  6 Nov 2025 22:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762467889;
	bh=xPYIT0+k0Xzcx0BF+rvzeK1loHfZYHharXNs0HguncY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hpbpc26PIvqMFE5XYOFLAyNMAefbU0w03YkT36x4TC6ko9esMePVVavFQSxhy/l//
	 7JjOwtQcSfM8D0Z92ITwdMmzVv817yyUbibkY0wOGssK2uQDJMYprQw7JCPVMiTzLJ
	 hwG4CWqGjh1jD5ZZAcHJw+WbKmFPGRJBgUL7Sm1aWZv9bjys0obXrW/GvcOi25HM5Q
	 H4j/E4MfV/LVEp7dLWktvl8kMqXjtCT9xZQeWMCGLPS0D2Pbg6qPwDB89/tTvOm1Hq
	 2rRF1ndI8WqOAYzPkPfMnl5iP2vlX4+C/qoJ0V6Ww65HVMwBupD0vh7FWzRCd8YpZt
	 3/LNYQoliHJWA==
Date: Thu, 6 Nov 2025 14:24:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, donald.hunter@gmail.com, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, sdf@fomichev.me, joe@dama.to, jstancek@redhat.com
Subject: Re: [PATCH net-next 2/5] tools: ynltool: create skeleton for the C
 command
Message-ID: <20251106142447.75250c87@kernel.org>
In-Reply-To: <aQzOs-0tFbGJOwgL@mini-arch>
References: <20251104232348.1954349-1-kuba@kernel.org>
	<20251104232348.1954349-3-kuba@kernel.org>
	<aQzOs-0tFbGJOwgL@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 08:37:07 -0800 Stanislav Fomichev wrote:
> > +static int do_version(int argc __attribute__((unused)),
> > +		      char **argv __attribute__((unused)))
> > +{
> > +	if (json_output) {
> > +		jsonw_start_object(json_wtr);
> > +		jsonw_name(json_wtr, "version");
> > +		jsonw_printf(json_wtr, "\"0.1.0\"");  
> 
> Any reason not to start with something like commit 4bfe3bd3cc35
> ("tools/bpftool: use version from the kernel source tree") here?
> Otherwise I doubt 0.1.0 will be changed ever.

Ah, thanks a lot for the pointer! I grepped bpftool for kernelversion
but somehow it eluded me..
-- 
pw-bot: cr

