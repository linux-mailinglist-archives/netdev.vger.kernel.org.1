Return-Path: <netdev+bounces-187349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22C1AA67FF
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 02:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870401B605AC
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 00:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3DB1119A;
	Fri,  2 May 2025 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3neSmoe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298713234
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746146502; cv=none; b=kKCtQc/t02BUqnncCFEX7Z/bRqSGpnmXRLKx/hIGgKClpa3nzfqGABtIlFRs3lDKEaTHw7RcaGTKoJsK7tKfWTLn3H6eY+WvFCLuAvKNIBP9jTK6byzxYBbcEfjfddPwYQ4+Z/9u7S6+WcRxp6mn6jS/C9Kc9PNNS3LECviGkdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746146502; c=relaxed/simple;
	bh=Ognsc8thM1OpvG3RfPb+lorEGejnWGeUehw3OBBJOsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBYKrdD7kg8XnybOgfheJP0pE8eShe+Qyu+CcgQXsGsWEgj1tYBruBrsgPqn9MiP3HBqy5nszxiuCs3qQWG1W2OdgGAXTw8PnnVf57580hwvlyAGkd7rERt6CO2302Rol7fRs0RXc2DQOPEEjYhud+igrPDdPsSCkVAtjB8jqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3neSmoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F62BC4CEE3;
	Fri,  2 May 2025 00:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746146501;
	bh=Ognsc8thM1OpvG3RfPb+lorEGejnWGeUehw3OBBJOsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W3neSmoe0A6RvPhFrm5DDot+23ysIe+Qw4C0u0dQyvM+rrKJIbwHHXoB7JSUb5yys
	 1XfPHNnXXrs47n4JzmUxLu16/WENskkX+QYGQ9RG/bLscqtggZ167AG9ysxvJm3kud
	 5/ASYeq8C0CPSScIvN+X8+G6guKfaG2JoXdMFo5rkm/FF6t7qNrot4sFWcBd+lIcGJ
	 EJrSeMKlVCDFoN3qKFDyNBsZaimeErixERpM4AnkAgC0btOaPW6GKpwBd5wcBgIMN2
	 RgPQfi9b/9BZWIinCDwpQV9qLrRrgu5OSxOayMotTSt3Lw5FH/yEpjlD0NVd24B8Y3
	 uBzLrlWMHFHzQ==
Date: Thu, 1 May 2025 17:41:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net v4] net: airoha: Add missing filed to ppe_mbox_data
 struct
Message-ID: <20250501174140.6dc31b36@kernel.org>
In-Reply-To: <aBPdyn580lxUMJKz@lore-desk>
References: <20250429-airoha-en7581-fix-ppe_mbox_data-v4-1-d2a8b901dad0@kernel.org>
	<20250501071518.50c92e8c@kernel.org>
	<aBPdyn580lxUMJKz@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 May 2025 22:47:06 +0200 Lorenzo Bianconi wrote:
> On May 01, Jakub Kicinski wrote:
> > On Tue, 29 Apr 2025 16:17:41 +0200 Lorenzo Bianconi wrote:  
> > > Moreover, add __packed attribute to ppe_mbox_data struct definition and
> > > make the fw layout padding explicit in init_info struct.  
> > 
> > Why? everything looks naturally packed now :(  
> 
> What I mean here is the padding in the ppe_mbox_data struct used by the fw running
> on the NPU, not in the version used by the airoha_eth driver, got my point?
> Sorry, re-reading it, it was not so clear, I agree.

You mean adding the "u8 rsv[3];" ? that is fine.
I don't get why we also need to add the 3 __packed

