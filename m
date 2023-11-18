Return-Path: <netdev+bounces-48953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06737F0248
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 20:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0BD280E8C
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 19:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B1E19BCC;
	Sat, 18 Nov 2023 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6MJRHvnK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C41B12B;
	Sat, 18 Nov 2023 11:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4YXEMkjy6qzjXjqNunS2BG4X7joch/6NstMnutQ4tTI=; b=6MJRHvnKI6gcE4KK+3VzO2OOr6
	noiOey5mh36Ol7hsJBmnY5tLbSGuZMK7N1X8EI95EXOrUL/Ss7crkyMm97zQUPYJ8sPdL60Jy6sRC
	VVp+7vh+3AdRNWX8HsP9pyszii3+I/d5z3GvaQBFQAcal7UdIAY9tKRJmiazVW9Xg30A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r4QhL-000Wbp-8F; Sat, 18 Nov 2023 20:09:43 +0100
Date: Sat, 18 Nov 2023 20:09:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, corbet@lwn.net, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: try to guide people on dealing with
 silence
Message-ID: <dd172cac-f530-4874-a4e7-fc8d7676d708@lunn.ch>
References: <20231118172412.202605-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118172412.202605-1-kuba@kernel.org>

> +On the other hand, due to the volume of development discussions on netdev
> +are very unlikely to be reignited after a week of silence.

My English parse falls over on 'are', and wants to backtrack and try
alternatives.

Maybe:

On the other hand, due to the volume of development discussions on
netdev, after a week of silence further discussions are very unlikely
to occur without prompting.

	Andrew

