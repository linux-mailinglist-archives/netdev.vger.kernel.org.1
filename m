Return-Path: <netdev+bounces-123385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FAD964AC0
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D067B25D54
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F10A1B3B36;
	Thu, 29 Aug 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0xF2DQX8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7273F1B3B32;
	Thu, 29 Aug 2024 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947014; cv=none; b=nOza5ddcK7j5bNklsqBgNgGiGOLqHt/49PgkOsXa/vrPqHnJuu7zcgxbMCNe2gc1M+CqWIl8AoIfkEZ4tShqsIOGOSb/qcFML8+F3wYNW5x0h//eKIy/VMEWshYVxXIcLVbxOjsm0SWZyJ/skJj6ptKV2OBcJvkovI2YOTFC4RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947014; c=relaxed/simple;
	bh=Ume9Bh2NTNVZFGvuWz73/Ndr6W8uo6HiHMwcZWhf3Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjuWPG8XkiwhzugAQnjlbQle8ZobZD+cdacRUKXbL936k8SAI4X4x+8/06lL3ZtaR1OvYtYwLxMf143CfgL027QE2dABDLyzcchNu2Fa5MSg28zMj+/2sk6U2sRyaIMcMj8OkjZ/Jl6VymU09eJreegAtYNIpvChC9CK5BitAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0xF2DQX8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9eq2P6P7l3fzGWJtMUCNLa2Lna7hOEj9E8VNwNQbzaM=; b=0xF2DQX8cLUUUC4v21lA2FH5f6
	UM47lNsnA4ePuwbZGji6B6uRttEZS7lSMisgPNN1dZtgZ3mY8ujkmOqfUluVmleDGgbf9R2mA47uU
	Sj7KQ0Oa4VvTrrk8UQabe78VjZb0lW5jy3NO+hxH5cqfrW1HhkNkEU/XHMlx6hoUUFT4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjhVq-0063IA-M8; Thu, 29 Aug 2024 17:56:42 +0200
Date: Thu, 29 Aug 2024 17:56:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: document guidance on cleanup.h
Message-ID: <aafc72ad-1672-43bf-a332-d4f40fa7dab3@lunn.ch>
References: <20240829152025.3203577-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829152025.3203577-1-kuba@kernel.org>

On Thu, Aug 29, 2024 at 08:20:25AM -0700, Jakub Kicinski wrote:
> Document what was discussed multiple times on list and various
> virtual / in-person conversations. guard() being okay in functions
> <= 20 LoC is my own invention. If the function is trivial it should
> be fine, but feel free to disagree :)
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

When discussing guard() etc, i have said we would reconsider this in a
couple of years looking at the experience of other subsystems. Maybe
something about this could be added to the commit message?

Otherwise:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

